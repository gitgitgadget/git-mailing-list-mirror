Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4FDF1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHOXbV (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:31:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42250 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeHOXbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:31:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so969323pff.9
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXA5NIZiDoHBfLzruoS1lfY8qJvxcew1qRduIaskXlY=;
        b=SrW8zPhDprO/zYyOkETs7OFM855alFCNqmoUNFiv2ZzaDpQFqdO6t1IWBqo2Z73EUY
         tTGhtY0jNVysYjmXNzJ5yWb92KC25tw2sXByr5UaMg178mUzztCWcJNbSdSmif2Z71BL
         GQZ0j/ejALOeYS9u06k+fEbMaz274yaLhEDNmb16VYlLkgzFtxys4gO9EKKh89JGW05W
         zP4Mea8XOQ/LBZqYnX/3HcwfwVs8n8jdDq7VZmi1z5NIGbyB21TeNJU6MfgJpmV8ekBe
         T1wNfNHhyVNBEeahyaq7i1YEK+oO327CJ/p0vsJbmRKD7N+b4dOSqCK8z8b6uIjiCHea
         ccfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXA5NIZiDoHBfLzruoS1lfY8qJvxcew1qRduIaskXlY=;
        b=okfFvxeg4gMvZeVk+5jyXOL5WBHczvCA9r+xZhCI/XkRIjz00ixW+e1N78t7ErMHfD
         aqrFGlQWELr0y6gO5kFwJbO/IcSjBzjii3J8cy7aqZOre0XhMKg0LWQs142esZXFMLS9
         iyaGneNCDGNNhYQ6lxBqM/T4l/wffiIlQUzQAxWNYdAWgtG9bOkYhJEhLGpnhJekvoDB
         rfb9HU+KmitlRaKaIIUhngstJNkN1wSBCXneABg3q2VBIV3+095wrBxNZ1THSxeqkXu3
         ZGtY+Zd4IhQRR5uR3afX0Hba1bgxfD+S0q3AKLrpVDT7Gi+3NVFmi4qWW0bzbDGjTJOu
         m6ag==
X-Gm-Message-State: AOUpUlHGmHGwOWAYx86GuW1OxYC/isqoJ7Z0jr27q7f84m6+GPWWXAJc
        F7O9tMuXpUIdVSz5rxpscWVOhi8o
X-Google-Smtp-Source: AA+uWPxLT3Ls3PpE1sI2SlRygFT3PazvYJqEKqdvB/hBUHpbeMyC5yr+5U1EArB3uQUKccmDjbJ+LA==
X-Received: by 2002:a63:1844:: with SMTP id 4-v6mr26904178pgy.313.1534365457187;
        Wed, 15 Aug 2018 13:37:37 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p5-v6sm27358204pfn.57.2018.08.15.13.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:37:36 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:37:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv4 2/6] alloc: make allocate_alloc_state and
 clear_alloc_state more consistent
Message-ID: <20180815203735.GB181377@aiede.svl.corp.google.com>
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
 <20180815175410.5726-1-newren@gmail.com>
 <20180815175410.5726-3-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815175410.5726-3-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> Since both functions are using the same data type, they should either both
> refer to it as void *, or both use the real type (struct alloc_state *).
> Opt for the latter.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Not worth rerolling for this, but these usually go in the opposite
order to reflect the chronology:

  Signed-off-by: Elijah Newren <newren@gmail.com>
  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The patch still looks good to me. :)
