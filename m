Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D2EC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 16:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720F960C40
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 16:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbhDMQCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhDMQCk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 12:02:40 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D2DC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 09:02:20 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso7941777ott.8
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k47xil1fRjZVCvNZReqXjoW46eLjFs70Dc3Z79Mltjo=;
        b=ctCTDDrNvitmV85K7ZlC8mqBk9cqhIqeb8ITxcT48dt/iuy4p0wFgtecfpzbzc4Lqp
         P0fNSWLIiEHEUk+MInjALZmplDK2OANC9MV/K//Esid2RPr8o0yYQIKMSVjq9mkgy6vm
         RdF/GN27NPlXGhGhEuurnptxPay+OVup7iPyHVER2iOd5l/NQZeM1E6mIkr0gbQhcdsR
         sUPzl6iF2TRB4HUrlRstc8pZVFKOhseeTldQ+GITteZZSPuCFIfVyQDZyK25EBr+nPa/
         UBJFf96MOHOrPD700SUCtmlQ2iSbcD4k5jOtP+oJb0E9atMYt+3eNgU3qeMvKFgRpE6v
         CxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k47xil1fRjZVCvNZReqXjoW46eLjFs70Dc3Z79Mltjo=;
        b=Qt5Z3YRH+Li5I/g2TKYWtsNyfq+Nv/2yrNfgbQuqGFo6CSqZHyH64pY1yfdzsYKHLc
         CKs8upsmkvuzJn27x5/zWtzgqTtjB6X4LZwSpz/WMWU/G1YiRK9rw+Tu5fF/1wdRLNH2
         dM4jnENPr7yuBg2cJSvJBro50Ma3lv2wtavOdFyXGAmL4E7eonign3ryuFsQCXJf9uWE
         a4qLiEWgcIlsYD1Kfd/7kk1SQQWGOz11DU8YzQwBYo5DDi37DNdzMYBbIk4Xb/TP9LYj
         Yt4FjmyN89CB3q29Tetbs7RsecCgLAjCx3Q75vuHE67nKYI4cCGEFMeL0gHr5tm+f8fX
         w70w==
X-Gm-Message-State: AOAM530k6E5LrDwsde74cHWUe3W6iVMwwFuK5naowiOOr2cadN96mBXe
        C8vmd19f/PsWP/s1L3CRutM5Eq6mpa78XHawlIXwlBdK
X-Google-Smtp-Source: ABdhPJwWneK92NUzYiWqGPwRG1k7/ZLPqv1hZlSYGYFu+EtJQKQpd8JVKwtXs1H82Gqxa6NC2ThKy6qJj5xs/EqScJs=
X-Received: by 2002:a9d:2de8:: with SMTP id g95mr15752056otb.162.1618329736099;
 Tue, 13 Apr 2021 09:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com> <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Apr 2021 09:02:04 -0700
Message-ID: <CABPp-BGCpwguTJk3N-4Okrdpsio9Q7Hj1HSPPUZX1EZSiXkepQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/26] Sparse Index: API protections
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 2:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here is the second patch series submission coming out of the sparse-index
> RFC [1].
>
> [1]
> https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/
>
> This is based on ds/sparse-index.
>
> The point of this series is to insert protections for the consumers of the
> in-memory index to avoid unintended behavior change when using a sparse
> index versus a full one.
>
> We mark certain regions of code as needing a full index, so we call
> ensure_full_index() to expand a sparse index to a full one, if necessary.
> These protections are inserted file-by-file in every loop over all cache
> entries. Well, "most" loops, because some are going to be handled in the
> very next series so I leave them out.
>
> Many callers use index_name_pos() to find a path by name. In these cases, we
> can check if that position resolves to a sparse directory instance. In those
> cases, we just expand to a full index and run the search again.
>
> The last few patches deal with the name-hash hashtable for doing O(1)
> lookups.
>
> These protections don't do much right now, since the previous series created
> the_repository->settings.command_requires_full_index to guard all index
> reads and writes to ensure the in-memory copy is full for commands that have
> not been tested with the sparse index yet.
>
> However, after this series is complete, we now have a straight-forward plan
> for making commands "sparse aware" one-by-one:
>
>  1. Disable settings.command_requires_full_index to allow an in-memory
>     sparse-index.
>  2. Run versions of that command under a debugger, breaking on
>     ensure_full_index().
>  3. Examine the call stack to determine the context of that expansion, then
>     implement the proper behavior in those locations.
>  4. Add tests to ensure we are checking this logic in the presence of sparse
>     directory entries.
>
> I will admit that mostly it is the writing of the test cases that takes the
> most time in the conversions I've done so far.
>
>
> Updates in v3
> =============
>
>  * I updated based on Elijah's feedback.
>  * One new patch splits out a change that Elijah (rightfully) pointed out
>    did not belong with the patch it was originally in.
>
> I gave it time to see if any other comments came in, but it looks like
> review stabilized. I probably waited a bit longer than I should have.

This round looks good to me.

Reviewed-by: Elijah Newren <newren@gmail.com>
