Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F360C4332D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB57C206A4
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbhAZWB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391576AbhAZSbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:31:41 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D990CC061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:30:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s18so7665059ljg.7
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b/sTJwuyRFDbPY+HDSnK4QgCaeChE3y8zA0CJmzoQ6Y=;
        b=TlG6PQb1vkK7Ti3SKOyveQC4R9dweSm0WmGzBbXm2ZwkpomsDYS3kNaI3Nn9DSBEh4
         BOE8I770fzO7RN6jFNqpzQK2EKLxhBdfv1cYsitIwtwWpcURkhmAH8LUXdUKixkzVNDb
         9qJp9bdT1vR3dtWi7MjXHCE2N5BQUcg5g4VMyjCZuCWG/WW8JqHjSwwTx2XZriNJItd8
         /3F1f+LB+OUGXZYqTBOhZf2JQPb15WaMezKNmHfv5yDLauz2RlAM/RILf3+Q5rDqVqUH
         UYC1rrSngT4oZ/MTVbYTexVouRdF3aDMdJ75Af3SxTT5JgPXMog39ITEH7uEUfAI+s/m
         OgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b/sTJwuyRFDbPY+HDSnK4QgCaeChE3y8zA0CJmzoQ6Y=;
        b=i4au7wV8tNMBfuzenCl3r+x8RhFdbQ7aP1fgRoKax3YaOfvnEiqr+b5hveHcJOkqis
         hcA2KIiabxlbh+7dqrrzBytNHkgrF2SfBD+ppFwfphOEgGNo6bisxzzQ6K3aOdUu4M77
         IshZDECO1FuwsyrDo2y2kvwmxRq5pT8sfujZxSkLGnfunfjjMGIJ6Htm5GEsl9ToEalG
         bbHfDcyX4PtTYOD/IXViGegDm3DnLg0zWlnttg06DMJ/Kqr3iEhMv3K2kGL9cmLVsZmC
         JqHtaM3UkLOGHK5dFmyz3AnH536xq4AozyXQ7jSSUVOXhr+xoSH4PDFtylofbxwy5vKl
         BvJw==
X-Gm-Message-State: AOAM53144G4H7Weojg2Y0P7m8dGNQT8wNu1DcMMEykhE/FXCJH6K7UjH
        KxJjdTKF5LwFHrUL4GSjU+4Pqj5/5+DKfiQVbHJN/XE7FhXTWA==
X-Google-Smtp-Source: ABdhPJxoydNeQrIvMgSw06CoxtMHtRw9zYtx2kofZFsgGaGJxdLOWJO0fSXvlG+/P81W7Cwr/XjVqTikG503PHiVHZo=
X-Received: by 2002:a2e:7f04:: with SMTP id a4mr351496ljd.3.1611685856955;
 Tue, 26 Jan 2021 10:30:56 -0800 (PST)
MIME-Version: 1.0
References: <CALmLNPQAKzzzAUPhejvcF7SEvq4zGDDqkm6HaVi9pAfB0JjoLQ@mail.gmail.com>
In-Reply-To: <CALmLNPQAKzzzAUPhejvcF7SEvq4zGDDqkm6HaVi9pAfB0JjoLQ@mail.gmail.com>
From:   Dan Lew <dlew@atlassian.com>
Date:   Tue, 26 Jan 2021 12:30:46 -0600
Message-ID: <CALmLNPTUSJvxKwDVJViZ7qETP5nGBUftdeHjEX9U7coT0Ve8yQ@mail.gmail.com>
Subject: Re: Bug report: gitk is no longer working on my OSX machine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have managed to figure out how to fix the issue - I removed my
~/.config/git/gitk. Upon recreation, everything worked fine.

I ran a diff between the old and the new file and discovered the issue
was this line in the gitk configuration:

```
set geometry(state) zoomed
```

If you change "zoomed" to "normal" then gitk works again.

I don't know enough about git-gui internals to help more than this,
but it looks like the "zoomed" state is broken somehow.

-Dan

On Mon, Jan 25, 2021 at 1:57 PM Dan Lew <dlew@atlassian.com> wrote:
>
> Hello,
> Would love some help, having trouble getting gitk up and running again...
>
> Here's the details from `git bugreport`:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> 1. Open any git repository directory in a terminal.
> 2. Run `gitk`
>
> What did you expect to happen? (Expected behavior)
>
> gitk opens
>
> What happened instead? (Actual behavior)
>
> gitk crashes with the following error message on the command line:
>
> objc[33662]: autorelease pool page 0x7fb1070a3000 corrupted
>   magic     0x00000000 0x00000000 0x00000000 0x00000000
>   should be 0xa1a1a1a1 0x4f545541 0x454c4552 0x21455341
>   pthread   0x10b020dc0
>   should be 0x10b020dc0
>
> An error window also pops up saying that "wish quit unexpectedly."
>
> What's different between what you expected and what actually happened?
>
> It shouldn't crash.
>
> Anything else you want to add:
>
> I'm using git/git-gui as installed by brew on OSX>
>
> If I run `gitk` where outside of a git repository, then it opens fine
> (and shows the "Cannot find a git repository here" error.
>
> gitk has run fine on this computer for years; I don't know what
> suddenly changed to make it stop working.
>
> [System Info]
> git version 2.30.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Nov 10 00:10:30
> PST 2020; root:xnu-6153.141.10~1/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.0 (clang-1200.0.32.28)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
