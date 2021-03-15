Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4CFC433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF6B64E76
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhCOIDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCOIDE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 04:03:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D5C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 01:03:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z1so16180789edb.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PysSp5PojLvc3NWUi0ofvUC22KUYHMRKBJKWTXJAvgk=;
        b=QbjiuYdISwjZJ3I+IAf5unYyiC2I5olJPaEx2yi/OCre07lw2evK6j2Vc4KdeQpp5I
         kmd95/AKsyMmR9cLPQe0f2JjPA7/wkT2YGIq3uiENpRnjDczKlgqxddRsaf9Qj38c6G7
         bM4yhhsTcnf30IlrD2SESYJ9SsOKTSEHhmCR+//vu8DlfLEupsbsqrrQBFSMwpwwL9vR
         2ABpD3kNTdMp5HEkhnMZ79CQR13OEQo8rJc5BM3DV0wMWOOHnRK2S45dTkwIyJBBiWay
         Z1u7c4rHTktJYlRTPSeNtmDkAspqeKjaMGjZXPLjfQjLpxFWtVmMNRELn9sjl+gWl28P
         bOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PysSp5PojLvc3NWUi0ofvUC22KUYHMRKBJKWTXJAvgk=;
        b=Lb+OrzHw2flqsvQpABtp6bEgw+tew8htDQvil5QUrg076zA6t/12mmOUG1wcQBPN4R
         REx3fUQBX8mbSvhWCvTVzdcwcrqTZnMvJbaU5PLtytco0KSL0Cez4OizxzjlM6OzCsbl
         AAQoLsLPzVCN36e7MGZY4gyJXzoCxNMYEJxxhJvL6STqEFKaG8gwQpo15CG/k2fuzedG
         m3FCAJCE0XPYRjLQvJT1cudpinWLQc7kyBbQbRATPjvRbPsjYyMx4f9vz+kGs4ztke/4
         +uwPIszLF0DaJ8n/00qtC2DyTIyCd7OMS3uOi9eZLGm47YhR/zwg+4h4XC4maTNvqQBW
         VSfQ==
X-Gm-Message-State: AOAM5315k1M26rPSyoHiKkNKUbumI0FGFqjVStfZqSEmA7+FOhaoXq/E
        NEMK5dCVBJrY1/UGxNOC0u11RAvqYOWOC9G/oiQ=
X-Google-Smtp-Source: ABdhPJyJPz9ZsWAb37QWUsNCEIfp0DhVLbh/Yj+NGJgLS99/CP5H04GsUffwfsA9Wn8zTzNNRz7mfMp6Mihitk8l8mA=
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr28473523edx.273.1615795382378;
 Mon, 15 Mar 2021 01:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com> <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Mar 2021 09:02:51 +0100
Message-ID: <CAP8UFD1W+oPwXzjq8SFVRTusJiw-3jvMTmBjLzK6PH6=GN+QwA@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] commit: add --trailer option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 7:35 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Historically, Git has supported the 'Signed-off-by' commit trailer
> using the '--signoff' and the '-s' option from the command line.
> But users may need to provide other trailer information from the
> command line such as "Helped-by", "Reported-by", "Mentored-by",
>
> Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
> other trailers to `interpret-trailers` and insert them into commit
> messages.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] commit: add --trailer option
>
>     Now maintainers or developers can also use commit
>     --trailer="Signed-off-by:commiter<email>" from the command line to
>     provide trailers to commit messages. This solution may be more
>     generalized than v1.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/901
>
> Range-diff vs v5:
>
>  1:  ca91accb2852 ! 1:  c99ce75da792 [GSOC] commit: add --trailer option
>      @@ builtin/commit.c: static int config_commit_verbose = -1; /* unspecified */
>        static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
>        static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>        static char *sign_commit, *pathspec_from_file;
>      -+struct child_process run_trailer = CHILD_PROCESS_INIT;
>       +struct strvec trailer_args = STRVEC_INIT;

I suggested added "static" in front of the above line, like this:

static struct strvec trailer_args = STRVEC_INIT;

You can check with `git grep '^static struct strvec' '*.c'` and `git
grep '^struct strvec' '*.c'` that we use "static" when declaring a
'struct strvec' globally.

[...]

>       + if (trailer_args.nr) {
>      ++         static struct child_process run_trailer = CHILD_PROCESS_INIT;

I didn't suggest using "static" here.

>      ++
>       +         strvec_pushl(&run_trailer.args, "interpret-trailers",

Thanks for working on this!
