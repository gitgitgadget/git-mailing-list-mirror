Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFBEC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D756108B
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhHTVX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhHTVX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 17:23:56 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7BC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:23:18 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso16986547oth.12
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BN+zWLKejjz8Up6Rdo6rz0CS/DofJRchntX7K29Xnxs=;
        b=XwWCT+AFlLJbAD711mlS4MvKWy/CHquZUIYHnZgWWJHJ5tr8EAAxWwg3aWnxMLPUfR
         cxH9SK/D/j2KvjE8aJfp9B37m1FNatod4i1UFKLV8FQGoHiWJzB8oDkJ1WoD7fMPEBRZ
         eLa/AxjZ6r/HExCT4bs5UjPBErtkkYD//nFlBkdp0xB9ZlyxSATfMXYmEf13fTT0rDJG
         /TVHW8ypadpzFfb6SUFkoGREI0UNP+KtjmHG10Cn28EY1K+SqceFKg7XMVU5SExi6L0c
         c0hOdXCxAqKlrn0rfPzGHKrJNqGpw2whe5nGNTw9y7Sa+Wyqv0xvhW/pZSTF/B8FqXWB
         Yx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BN+zWLKejjz8Up6Rdo6rz0CS/DofJRchntX7K29Xnxs=;
        b=T1x4W423m/Kx81Ed5s/Md1PRkxcOdyiEOP1uGekLBqeuLH9U4r/oGOa+jLtDg67iQ6
         AmbpxL7Js7qDGGP2yjA7VFGgpFHWja97u9TPoh9s5igTOitvTI96N8ySfNPbCGaVQOjE
         xV6bcKDTAeL9OXukIgZr3dE7GdQM93daOmKIAoZg89OIssVw0AjxUPBGJKwapZw73z/T
         Q4sPNEl5Rq3vGKTE65bIIraJckeYuAYtvcWhVADqrz/+Thg1Ho+eCR0hlCFVcyVY29fc
         p1ODzc0DaKjTC6yetBbwGQ9bCibbMJj/rLSSYUo9rqLa+98Z1ZHUQY8gmiXEJ2vVNtZ1
         i5RA==
X-Gm-Message-State: AOAM530yf+Qg6zw53IjXC7AdsP52LD2PP136xvmvmtAzmfOByeR2UFr2
        zM7VvJUtuNFdcIaKVQ9DtD5l3vNTkNQkWtycaH4=
X-Google-Smtp-Source: ABdhPJzQnN+U3JnAf2DPStK+4qDP3HzF4m4NTmeHm3IeYow4TJU0dr8sedtdEWJMhjKOLu0qTIrlAKX0xyas2U5LkE4=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr18291489otk.316.1629494597422;
 Fri, 20 Aug 2021 14:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
 <xmqqzgte62ud.fsf@gitster.g> <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
In-Reply-To: <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 14:23:04 -0700
Message-ID: <CABPp-BEtOWUGCcn3B0On80=tMZ_Re9ScHnBiwPPPFY=x2TwG5Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 11:42 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> >     It seems to me that it would let us live in the future in a more
> >     comprehensive way if we tweaked merge_recursive() and/or
> >     merge_recursive_generic() so that all internal callers, not just
> >     builtin/merge.c, would redirect to the ort machinery when say
> >     GIT_TEST_REPLACE_RECURSIVE_WITH_ORT environment exists, and
> >     doing it that way we do not need to sprinkle "-srecursive" and
> >     "-sort" everywhere in our tests at randomly chosen places to
> >     give test coverage to both strategies.

GIT_TEST_MERGE_ALGORITHM already does this; the testsuite already had
`-s recursive` sprinkled everywhere (due to contrast with `-s
resolve`), but since I wanted to use all existing recursive tests as
ort tests, then rather than tweaking all the test files and copying
tests and whatnot, we decided to just have GIT_TEST_MERGE_ALGORITHM
reinterpret "recursive" to whatever GIT_TEST_MERGE_ALGORITHM says.

> I could also change this patch to stop using ORT _all the time_ and
> instead let the GIT_TEST_MERGE_ALGORITHM decide which is tested.
>
> That is, except for the final tests that check that the index is not
> expanded. Those tests must specify the ORT strategy explicitly.
>
> I think I started playing with the GIT_TEST_MERGE_ALGORITHM because
> it appears to override the command-line option, but I will need to
> double-check that.

Yes, GIT_TEST_MERGE_ALGORITHM=ort reinterprets "recursive" to mean "ort".
