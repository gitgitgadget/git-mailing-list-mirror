Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3453C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27F561410
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFOK0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhFOK0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 06:26:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470BBC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:24:09 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r16so17255164oiw.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pgeebM6pG83TaxfP1ycqnhzAIy39Ziq79ETq3Eqp/Bk=;
        b=A9q01+fcV43MzmisR2CSn5fRX0kcEk5zw4JksurE/mXebk1ZRcPgI/nUz/Gi3n1Naa
         VT98z9uzDbBEDFTUrE2UyrByqEvS1Kww3v5lGu4DQ90b+eL8eSN74va8qiqYDD1O/f3B
         XNHaABg+9b34CZ3d+2+Onib8jqsaqGkiNeCgCgEBZbXjOIY74q32QaO3YpWqRGnh1Uq7
         g3DFm4wRS3n/v3BvNXiDCVA3a3FI2jeA7rN7hdcvlaJXCl9dgsn/UU8pW4vOYNEUq8X/
         Hp1hIw4ZcdVUNZLJytEzC2gzXZDdFS6Obh1D4IzfwAKnsSmTFFQYX9Tx1bCRzDxxsVVG
         m01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pgeebM6pG83TaxfP1ycqnhzAIy39Ziq79ETq3Eqp/Bk=;
        b=easte6jlK06JSA5XsCgT3Gg3XWB2jevdNvqiUU94m4jgicH8M8hjQOIBzT3SDG73S4
         vSpnyjWGNV/dhqeTJEGYMeKa8AIMZl7k7KwgChk6/G0MHK/spQV2KmjMoNemo47Af37X
         LYXHAQStCHtsVQNFUChRwU78eDg7ARpn5cVLxLHXSW8F5v7kiMKF2PbRTtCaUERoaqip
         aidz8IFTWM81jly7r6anmgtghjryBHhXK8dH7bZh8FuiqGsNhi150rqU9lYRy9UKQBKV
         Tlt2iykRCPyLbtoBPs0WUfoQmmmrNeJaAf3TyeRNM3OS3OkJ+wbTgUcVT1UjI5WlWfxk
         cS9w==
X-Gm-Message-State: AOAM531twExr5G4ZuXanXdQwDW6us3nV17ebtcibgW0pMm+HCMiYtcnL
        ZGJSgYTk6Knr2H4wGesUsRI=
X-Google-Smtp-Source: ABdhPJzJzoI9vQFbCqmz96AQTxRlh/SdVGFYOOrYbuL7E8Z4yPDgm1Y0ZsiczsbIrl/wC9sOs4yamQ==
X-Received: by 2002:aca:4bd7:: with SMTP id y206mr14025404oia.40.1623752648616;
        Tue, 15 Jun 2021 03:24:08 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 16sm3606855oie.33.2021.06.15.03.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:24:08 -0700 (PDT)
Date:   Tue, 15 Jun 2021 05:24:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <60c87fc6a87ba_e6332084f@natae.notmuch>
In-Reply-To: <YMhx2BFlwUxZ2aFJ@coredump.intra.peff.net>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
 <60c647c1d9b5c_41f452089@natae.notmuch>
 <YMbexfeUG78yBix4@coredump.intra.peff.net>
 <60c82a622ae66_e5292087f@natae.notmuch>
 <YMhx2BFlwUxZ2aFJ@coredump.intra.peff.net>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jun 14, 2021 at 11:19:46PM -0500, Felipe Contreras wrote:
> 
> > > My point is that if you are going to repost a patch that has known
> > > problems,
> > 
> > It was not known that it had problems.
> > 
> > That fact that person X said patch Y had a problem doesn't necessarily
> > mean that patch Y has a problem.
> > 
> >   1. The problem in the past might not apply in the present
> >   2. The problem X person had might be specific to his/her setup
> >   3. The problem might be due a combination of patches, not the patch
> >      itself
> > 
> > Plus many others.
> > 
> > A logical person sees evidence for what it is, and the only thing that
> > person X saying patch Y had a problem means, is that person X said patch
> > Y had a problem.
> 
> Wow.
> 
> For one thing, you could still relay the _report_ of a problem along
> with the patch, which would be valuable information for reviewers.

Yes I could have, and knowing what I know now I wouldn't even have even
posted the patch (not without a proposed fix). Woulda, coulda, shoulda.

But that's not the point. The point is that I did not repost a patch with
known problems *today*. Nor did I know what kind of problems, or
how pervasive the issue was.

Presumably you had to try at least 2,500 merges to find *one* issue.

I ran all the tests for diff3 with zdiff3 and they passed without
problems.


Merging this patch would have:

 1. Not broken any tests
 2. Not changed any behavior for any user
 3. Not have caused any problem for the vast majority (> 99%) of
    people trying out zdiff3

So there was no carelessness here.

Moreover, I provied the patch at 9:30, at 10:42 you commented about the
segfault, and 16:24 I had the fix. On a Sunday.

If this is not caring, I don't know what is.

-- 
Felipe Contreras
