Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7997120951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdCQXEr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:04:47 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33486 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdCQXEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:04:46 -0400
Received: by mail-pg0-f49.google.com with SMTP id n190so49864008pga.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hvl3V0PF5ox5aDECuazq9YKQbUtP/5Zx780Pqd0OR38=;
        b=NxMB4gAxdmrC7aqmL5TQCwfLLg4+JZ+czH+Vwu+qJi7v7RQiVEzPfW123OqUxMfsAJ
         KAb/jxhaWsNS4o8L0gc+9iV+4RWb6hkSleLwzXfN+Vqo/BfcMmlITIJPtbaXEUq/mkpq
         lMqrgTkBEHameKVwJqBruaosyuO+jIU/eYm0jAjZSMNV4ZoZTo7iyTWwoeeidEVR1+kk
         q+8jBLx+5RCHiHOyAKAoDCy0Utw6dcOR2so7uzAZj4QWm8m4HLm7U2F0z/jihT3DXQjo
         eDCVEMK0J5GdwSHRhrqtFENQDZhSm7Aur42AO1GYoEZ3pYk1Tqp2cSFfDxW2RxrOcT0+
         BXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hvl3V0PF5ox5aDECuazq9YKQbUtP/5Zx780Pqd0OR38=;
        b=sbj9Ignt4xfh4exVvOJQEbhLVnUTyiahpeLsd+qab/mT6en5d6zu/DdB3IL+bBNkr/
         psVnp/yyZ8NutRS7ntoSp4JhuqA6alXy0+pEyUjgy71U/P/b5s1umOjtVobR5+E2d6Dv
         spCkhdYQviZlUYQE2NZP1os0vVsVsgwlXGC3WuS52WPxgac2f2lhesonIIZ5HvtVrejI
         bUGKe/IZKja5bGPIR/yzWLEaw3gDsX2xYuDlnoY2BEqXHHuHPFyN2vwEqsmjkwzQim5D
         exPHTG7CjibExEz5tPSUeVAd2zolJhoysSsw3AQzBySrBD4FO9V4S2PFWme94LSmdViT
         KMCA==
X-Gm-Message-State: AFeK/H3JuLPGuOqDpEI8P1Cnr98oIa/NVKpUm2+yE/67c5lJ/mcmfygkKmShCu4rctMT6+cf
X-Received: by 10.98.133.6 with SMTP id u6mr19420366pfd.48.1489791801580;
        Fri, 17 Mar 2017 16:03:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id 185sm18729949pfg.13.2017.03.17.16.03.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 16:03:20 -0700 (PDT)
Date:   Fri, 17 Mar 2017 16:03:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fix build with no thread support
Message-ID: <20170317230319.GF63813@google.com>
References: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
 <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
 <20170317184701.GB110341@google.com>
 <20170317223741.qwfh2zw37y3jbeev@sigill.intra.peff.net>
 <20170317224232.GE63813@google.com>
 <20170317225847.g5776lntj7d5ni3v@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317225847.g5776lntj7d5ni3v@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Jeff King wrote:
> On Fri, Mar 17, 2017 at 03:42:32PM -0700, Brandon Williams wrote:
> 
> > > > I didn't take a close look at it but this would seem to indicate that we
> > > > don't worry to much about systems without pthreads support.  Just food
> > > > for thought.
> > > 
> > > Hmm. We used to. What version did you test? Everything passes for me at
> > > 0281e487f^ (after that it fails to build). So AFAICT v2.12.0 is the
> > > first release which does not work with NO_PTHREADS.
> > > 
> > > -Peff
> > 
> > The version I ran tests on was what the master branch was pointing to a
> > day or so ago:
> > 
> > v2.12.0-264-gd6db3f216
> 
> Ah, OK. I couldn't get such a recent version to build with NO_PTHREADS,
> but I assume you mean after applying your two patches.
> 

Oh yes, sorry I should have mentioned that was with my patches applied.
My bad! :D

> v2.11.0 is fine, but v2.12.0 with your patches shows the problem.
> Bisecting (and applying the patches when necessary) points to my
> 46df6906f (execv_dashed_external: wait for child on signal death,
> 2017-01-06).
> 
> -Peff

-- 
Brandon Williams
