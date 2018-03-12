Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA52E1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeCLWIL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:08:11 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:41815 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:08:10 -0400
Received: by mail-pf0-f174.google.com with SMTP id f80so4970919pfa.8
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NzvhScQjaaclztsUlkb2fzj4mRvwS01+2STerH2YNfY=;
        b=hn+WrEAeCXlywm659OvyrxBxXRKrAbf2iTiIBklJ8qr2Y3f5JzSNfsRT06Gf5qbiWF
         ZgDyN574fSQL9OD9qzjPxq7s0BtUMLOpkg7rsEH8Bi5YaN0FAvuLqsdFuWg++JkOmJ0Z
         uKiAuCdB+wV3Nj3aWm/VP0bNbWbShk5TEHi2jn4llVhdFRLAQwHmvRGd34Ij1LQwa2kT
         RyPZ6dY+X43jDQhK09yi9TKITDHioyifTwySuUm7csCIF0YdZo2rkkwGDwS1wd6+n0Dm
         ekQ9H7KbP1iJcUS44gE+bi2h3StNDzMKB25Zupbn7Q+ukCeRzqNGCknCfZ4i1FBxCCFZ
         kyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NzvhScQjaaclztsUlkb2fzj4mRvwS01+2STerH2YNfY=;
        b=l7mjXdAw74Spye7NO0mmN6ja83HQomYfY2NL26Zcb378UKsMj0wcA+VT5OZrplkaGQ
         HB70CF0c92L7zqIMyW+o/U7IweyKki1mwyr+DIN/lOJW5ipVMOBq9DAAkjwSw5Y2wj23
         VjcT34meMz7PlNoF+c6FXT68jWd7nIZYB12zWlSAdRQonsfXpReyPS4aK3TTzKGX6IfJ
         8UzKW5dpsX2VreRH3H0NKUArl+jIBNleeqhvl/x99t7bA0p/jwmlDqfD+FtyN/Rcgsmo
         ncvronenRwNVmOysMq3C0ZmyPO4ipj+BRXt6W/y1qIaCz71B65QdTnLV6ndYBscQsfGl
         25Bw==
X-Gm-Message-State: AElRT7GHkVuBtWlMs2VXozUsnOTRF1C8Edqlzamni3nsvV05oli8J78I
        v9VvFLZLcUEY1MS+gynGzLS2Xw==
X-Google-Smtp-Source: AG47ELs7513Vl90BLM08BbOm77dZE4s82SLQGnkBi2b/7akjqEimLLBBaxbHworJsIXCfW2ebfqFHw==
X-Received: by 10.98.102.82 with SMTP id a79mr9461877pfc.138.1520892490075;
        Mon, 12 Mar 2018 15:08:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n76sm18763768pfi.93.2018.03.12.15.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:08:09 -0700 (PDT)
Date:   Mon, 12 Mar 2018 15:08:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 12/35] serve: introduce git-serve
Message-ID: <20180312220808.GB61720@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-13-bmwill@google.com>
 <xmqqinafe6ih.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinafe6ih.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >  Documentation/technical/protocol-v2.txt | 171 ++++++++++++++++
> 
> Unlike other things in Documentation/technical/, this is not listed
> on TECH_DOCS list in Documentation/Makefile.  Shouldn't it be?

Yes it should, I'll fix that.

-- 
Brandon Williams
