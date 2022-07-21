Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80222C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiGUTOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiGUTOC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:02 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88638D5CF
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c3so2075970qko.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1dQVujzoXDPol+IzhN58yzFlQwUd2ZQ2sQRce9R5z0=;
        b=T/Tgym+3pPF4aCGROKJUam7rLvk0G5fO1X4iGVyb1rOMvTOCvvl1s27ICC7Z3FqXAI
         hVdBP/zm5DfsHwBKb9sfX0qi7rKL9ZT+TqCgJPPyqnxg5jDlyEVFSdZkqmushbSYK+6z
         xq2F1UPM7YwaqNpYKelygqalfetfqmDgiTx70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1dQVujzoXDPol+IzhN58yzFlQwUd2ZQ2sQRce9R5z0=;
        b=4DHhzjP+IdqT/tmHhheipJLK/NwLLLuyQA+GF3FRLuBmxMbPiVFvs/Q7iiuaNSoDW0
         eG0e5JVy3s+eCVoYQ4WxfJMXM/hmspsbvmYr45xOXsxk7gimELA4vcNrnfcVvRQ8JO5K
         HoRM+tGmjoQv6PYjuiYoDiARqc1oo+slKExZ/sgvpFPUdsgS5l32KkFlNH8JZU57lAxS
         FG3nJoJL0IDYoO5lHcm6S80s9B+l0J+AiFMvDIHNCm9kpuOxa+dnvh+hl5TRM7pfRZg2
         l53J7JDktDunIeerYHrmhcgUNNN8qMJO/zPKYGMnljUlWpqV13vZR2C4RZ8bUz/zfOvS
         ZOxQ==
X-Gm-Message-State: AJIora+LWcqBNmckGOgd2u+i1AAkG+CK03Dhf5JLYM2N/Pt1p3n9xKNF
        j9t1T3CPacwfsDnSrYL+WkXUNw==
X-Google-Smtp-Source: AGRyM1sgikBxbSEI11xVYBrHf60UDIRAai5EUqfoGOaSZCmi1+rmxCHomRwUC7K6gs5X5KJKMiccjw==
X-Received: by 2002:a05:620a:400b:b0:6b6:2010:3015 with SMTP id h11-20020a05620a400b00b006b620103015mr2781195qko.491.1658430831766;
        Thu, 21 Jul 2022 12:13:51 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id v9-20020a05622a130900b0031efc91644fsm1839364qtk.33.2022.07.21.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:51 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:13:49 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: On-branch topic description support?
Message-ID: <20220721191349.kf3zx4tpwrjhzudt@nitro.local>
References: <xmqqilnr1hff.fsf@gitster.g>
 <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
 <xmqqwnc6idxr.fsf@gitster.g>
 <220721.86a692tkva.gmgdl@evledraar.gmail.com>
 <xmqqy1wmgx8t.fsf@gitster.g>
 <20220721182645.45xrwf2buohibcaw@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220721182645.45xrwf2buohibcaw@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 02:26:45PM -0400, Konstantin Ryabitsev wrote:
> I'll play with tip merge commits and see how well my "survives rebases" tests
> go.

Hmm... well, it works great as long as you remember to always use
--rebase-merges. The moment you forget to pass -r to "git rebase", your cover
letter commit disappears, and I'm not sure this is going to work for what I am
trying to do (which is to make the process of submitting patch series
simpler). I know it's possible to configure git so that "git pull --rebase"
preserves merges, but there doesn't appear to be a way to force "git rebase
-i" to do the same without the -r flag. Also, "rebase -ir" looks really
different when there is a tip merge commit, which will probably also be
confusing to newbies just starting out with rebase workflows.

So, I'm not sure that at this time this is objectively "better" than keeping
the cover letter in an empty commit at the start of the series. :-/

-K
