Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10606C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C459D64EC0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhBIRu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhBIRpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:45:20 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED72C061756
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:44:39 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id r21so9738158otk.13
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIYiSrksjUiuVo9F2bxcyii6l5QtD7ZpatYhxoJKIbo=;
        b=h4luNpbofLJ/T0pWERyV64LGwsJ1ADMj3sBu6CJ7DV0pvjgWXAAzHiJht9I/PNFrSQ
         TUI0X/HxyZcr76MJDHb1I4npJXPOiQnrMG8Zvy49B6tIbNm94sgzszy/iZAhtoC8reKv
         kzoeTLDtblgM4pVke/NjdVvgNB59jkspabPhVlSHpbxWo7iU0JpBbLXvrDW0xsu0MMMl
         npRSvTtTnpzULiJxxB0HMUVrEZCGaWLzRiho1gMaxnAunGldIe54eWHrAVUN4foG5fqN
         oDiOLSz0seWltQ8NNloaGTvhN7KEiJzKHTSXb2BgB/BaW7cJ+v0NsUDtuYmENullzRvm
         xobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIYiSrksjUiuVo9F2bxcyii6l5QtD7ZpatYhxoJKIbo=;
        b=B3YemC0euDd7hV+2wW4bbkHMYbFUOlAdUTv/A6fgE/4TVcdgTx5EsihSCMZNZL8atc
         YMR8LDL/VSCFNlBxZuiiPNxaH+CSpx7U3MmRCvUGxePnHE9hSUbWMVx7WBY3ooyEiD/n
         TFqM3snCMeDI4DhV4UwpOR9HuqXVKdczVmrhhpxntW5PyYVEyH6lSUeHnpx76geCuk1R
         6rkvMdoC1jQ53d9VeJdnNfhE4ra7hUXD8OpdVucZVmsb7mCP8oTt6NT/MbCdEnN0g0oI
         naROM+Pawo32p1oDx3QRMWVcBa1BfwPnaPoAY+ahX7EjFZqDW32yqs7GbV6nNkfMYy7W
         30Zg==
X-Gm-Message-State: AOAM532+lMAri8DzxAzgIev0bd0sVvpimqK5Vx6kxDv69TYx0XWqGsVF
        DUMykBUA7w0L4L4osogr2oy8GTCaRLiQkHVokowKPEbjSYU=
X-Google-Smtp-Source: ABdhPJwcOaWlvDJLrRfbmx4QEdnA32JxFXk9RlgRd7rTDpZx8G35FoaFbVvqKDsIAnMhvEiBUIlCqn1hcHr2XRbPVlw=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr16843733oto.345.1612892679203;
 Tue, 09 Feb 2021 09:44:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com> <a0e75d8cd6bd32fb1ab2a209bc2079c30995b257.1612870326.git.gitgitgadget@gmail.com>
 <6aa32f94-9c8c-ad26-09ab-4c2028ef1d67@gmail.com> <xmqqo8gt2mxh.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8gt2mxh.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 09:44:28 -0800
Message-ID: <CABPp-BGM8N_PaS_M148DoteO3dHNq+gvmNbigHuHsgkVjocCww@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] gitdiffcore doc: mention new preliminary step for
 rename detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 9:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> >> +Note that when rename detection is on but both copy and break
> >> +detection are off, rename detection adds a preliminary step that first
> >> +checks files with the same basename.  If files with the same basename
> >
> > I find myself wanting a definition of 'basename' here, but perhaps I'm
> > just being pedantic. A quick search clarifies this as a standard term [1]
> > of which I was just ignorant.
> >
> > [1] https://man7.org/linux/man-pages/man3/basename.3.html
> >
> >> +are sufficiently similar, it will mark them as renames and exclude
> >> +them from the later quadratic step (the one that pairwise compares all
> >> +unmatched files to find the "best" matches, determined by the highest
> >> +content similarity).
>
> While I do not think `basename` is unacceptably bad, we should aim
> to do better.  For "direc/tory/hello.txt", both "hello.txt" or
> "hello" are what would come up to people's mind with the technical
> term "basename" (i.e. basename as opposed to dirname, vs basename as
> opposed to filename with .extension).
>
> Avoiding this ambiguity and using a word understandable by those not
> versed well with UNIX/POSIX lingo may be done at the same time,
> hopefully.
>
> For example, can we frame the description around this key sentence:
>
>     The heuristics is based on an observation that a file is often
>     moved across directories while keeping its filename the same.
>
> The term "filename" alone can be ambiguous (i.e. both "hello.txt"
> and "direc/tory/hello.txt" are valid interpretations in the earlier
> example), but in the context of a sentence that talks about "moved
> across directories", the former would become the only valid one.  We
> can even say just "name" and there is no ambiguity in the above "key
> sentence".
>
> Then keeping that in mind, we can rewrite the above you quoted like
> so without going technical and without risking ambiguity, like this:
>
>     ... a preliminary step that checks if files are moved across
>     directories while keeping their filenames the same.  If there is
>     a file added to a directory whose contents is sufficiently
>     similar to a file with the same name that got deleted from a
>     different directory, ...

Nice, I like it!
