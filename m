Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C040C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009DA22253
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpaj4BVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405964AbgJTKKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405574AbgJTKKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 06:10:01 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25049C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 03:10:01 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so1543158oie.12
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePcLfsKZGL6b/FhNF8Rz0P6+eWGYOjLNtn2XMvzWr88=;
        b=Mpaj4BVjeH7h3iM9RXJs9iQuFVpjko1ODWnfURW/KiUniN33herD7dnsmEzl+5phiQ
         jlJhj41H+JQUuZUs4wXHsX0RHnW1dpmFphSCkQr75A4TEF3WkcKRWn7wGYqOYT5RZmow
         Oub2BnEQ/JDOXksk7of+sifSsFUPJrwPifFE0xHWa/630WyN3Uj9LWM0hPvU/pp6U6+l
         EYjRCNwccKofN6RDaF2QYi1bV+HsqA/WCzc0wLc94tOQR1/k27OxG5bVZYhuHc4OO756
         eQmO49NaAVtm7lSGtgpgToLrs3HPtOZeWeFdRVcbbZAKZP7B6C/xQxggVyz/gr63IsZ3
         hohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePcLfsKZGL6b/FhNF8Rz0P6+eWGYOjLNtn2XMvzWr88=;
        b=MFz3YY7wwbM4a7nrqaQyNdlGN6wnpDq12UnXfL+sGe3veDQgHHPO8nxxyRNueNAaIs
         gDcAoSrG6jxnF+AUwLcumD5c2kNbqq8dDWtzfJyidIDXLnEFSBGFbvnbPI+nS/OB3mS5
         WdEAv5rDw9M86RRK+aOtZdD6nYJePo49akGp4AiuUUks5c8ha7GsMKnb8SlTaQjLfBKe
         +yP9NW4D+pyXHOK2D9ZLIm+euvABHBUOnFjssjjj2B7mWzKmCjPH2D2KncXjqphkcmoS
         zHLVA8hfsUnJ+gBSvMMSantadW4WUTX/UXaYCKVnmPxJYcpjVayBjAORjqQ3b3y8J71j
         RcEQ==
X-Gm-Message-State: AOAM530le0D8mWt3hooV7hNKN6GmBe/w0emUdUPmDD/Y4IUZf783yaoT
        pVQJqTE1BXW6zOX4ZucimUR6HgD/1W0l1kuR5fLVowcyxIU5pQ==
X-Google-Smtp-Source: ABdhPJxWpdqOlEE3hYpRkL4tzgc+B/OgI3cgP6KRp8b8C+QWuN9ZOp6d3EoeoaiE2e7wYd3W/OCTB4VaNF+Aaqt1lgo=
X-Received: by 2002:aca:ec0d:: with SMTP id k13mr1284823oih.93.1603188600471;
 Tue, 20 Oct 2020 03:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <pull.756.v3.git.1603147657.gitgitgadget@gmail.com> <28c1e488bf644786af071e66b73450baa47ccc44.1603147657.git.gitgitgadget@gmail.com>
 <20201020023857.GC54484@nand.local>
In-Reply-To: <20201020023857.GC54484@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Tue, 20 Oct 2020 11:09:49 +0100
Message-ID: <CAN8Z4-WqMSynUNZpyevq09cMqE0dcxY5RwXbs-i8zjqzvRjo3Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] perf lint: check test-lint-shell-syntax in perf tests
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20, 2020 at 3:39 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> I'm not necessarily opposed, but having this in t/perf/Makefile would
> allow me to just run 'make' in 't/perf' and still have the scripts
> linted there without having to involve a 'make' in 't'.
>
> For what it's worth, I suspect that this is because 't/Makefile' already
> has a 'test-lint-shell-syntax' target, and 't/perf/Makefile' does not. I
> think it would be OK to add it there, too, and move this change into
> t/perf.

Looked at doing this and noticed that there are several targets in test-lint
in t/Makefile. This would involve duplicating them into t/perf/Makefile which
seems like it would be poor form, especially given their complexity.
Perhaps t/perf/Makefile could have a target which calls t/Makefile's test-lint
target instead. Will play around with it.

>
> Makes sense. I wouldn't be opposed to breaking this out into an earlier
> change (e.g., "it's about to become not OK to use seq in t/perf, so
> prepare for that by replacing any invocations with test_seq()"), but I
> think it's probably not worth it, since this patch is small as it is.
>

Yeah - I see the point, but I agree that since the patch is small,
it's ok this way.
If the patch grows significantly, I can make it into two patches

--Nipunn
