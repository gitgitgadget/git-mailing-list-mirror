Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FAD1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeDEWPE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:15:04 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:44845 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeDEWPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:15:03 -0400
Received: by mail-pl0-f50.google.com with SMTP id b6-v6so19279134pla.11
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/OBZKee59HQev+gXE+w6338NZYeBmepBXywXzYCC5k=;
        b=BpqU79wvIqSAjbvX88ufpyWTvxrs5+NeugQeAGpOHFQvB59Dc5MWNgoeV+L4a1GK1X
         nS0G8EgbuMVuJ9vLRm/7IN7hblMjJxMEJK/g164zgAPsKYRaHPxwpEdUNqMtsgzBXtKw
         V/xiCplaWm8pnOmbqeQno7WguyHyxKQBxueKt4l2hJUgljrfbQLokVsTUOewSVC8AVhw
         ZsGZtYUalgq98NI7Rk/NRdzs8v9v9P3jyymaLFtxmPyG3PqccsKUwEeZg0eyWp9cALjm
         auH4WiqUzyNd76Xfteq66VC0q8A4XuQqcQ/1B1EHvjKgbsd3j69dWCJ81ckYpRoOOf6H
         rHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/OBZKee59HQev+gXE+w6338NZYeBmepBXywXzYCC5k=;
        b=FWaKdMxZf4QxrE9yf8TQCsqh4PMslN0Gcoea58OQ6ghda6It4WRPhwoDw1I41nQfWh
         E26yzDV3Hht4hMiPPNXD/JpgiVnobnjgPHRiz1WU2yblgiou7vvaCmdhrGgkdmoR5fcX
         miIXknemXD17AedBs6X3+gd82RWrsffkF7pLq+E3lwr3S8/jkW3yLT1tDql6UGyNhllZ
         d7Hx9q+zlZ1GFR696TJNm8m3uB3zjOGDZOfnRAVQr77YTdkM2G82CbD5HcNG7qF3oCnL
         GV9WHQBPCRP0Dfe7yTFuVdB8fQCnOzV4SFfgeZYUTvy9KWVRsv2JgpAxv99G4htwIUAI
         e/4w==
X-Gm-Message-State: AElRT7FIrWk3RW2Pn/JULOU7spkDC+jFSjVvktEhXTNDl7BKVimVkxSR
        NCpYFQq8BwduCR4RZILuLCo7bg==
X-Google-Smtp-Source: AIpwx4+GAZj83n8lV8pcORHze0OqajgzpXRtVlEsnPav59tx1uASEF4zvfrQfoWBjXJlu1aRhR5hPA==
X-Received: by 2002:a17:902:8304:: with SMTP id bd4-v6mr24663212plb.70.1522966502559;
        Thu, 05 Apr 2018 15:15:02 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id a65sm18678368pfg.170.2018.04.05.15.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 15:15:01 -0700 (PDT)
Date:   Thu, 5 Apr 2018 15:15:00 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>, gitster@pobox.org
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180405221500.GA87758@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522893363.git.me@ttaylorr.com>
 <20180405020238.GD8879@syl.local>
 <20180405221201.GA29929@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405221201.GA29929@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:12:02PM -0400, Jeff King wrote:
> On Wed, Apr 04, 2018 at 07:02:38PM -0700, Taylor Blau wrote:
>
> > +test_expect_success '--no-type unsets type specifiers' '
> > +	echo "10" > expect &&
> > +	git config --type=bool --no-type core.number >actual &&
> > +	test_cmp expect actual
> > +'
>
> Actually, one minor nit (not worth a re-roll, but Junio may want to mark
> it up): drop the space in "> expect".

Ack; I thought I picked this one up. I am happy to re-roll it, but maybe
it makes to amend while queueing.

Thanks,
Taylor
