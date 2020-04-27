Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97DFC54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10A62064C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLfXvNYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgD0PqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0PqU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 11:46:20 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCEC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 08:46:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j26so26944046ots.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DxSi0a/XDWO3IJBuJfhqjQ/ZniqUa6Cz6sACQWEbyo=;
        b=iLfXvNYayCJOG+kNMT6HaTHo9HEVIHw2sCrVBGwBXbq6P59HQVs7vZkjMk4fJ1Cf+1
         O68GUNqfYwYQn4kAHN+/NLm+Pw1POT38y3ZrsoFqrY66xHPbbBsB4LLObzKNjWgl8IBU
         9e4hkAY7Zuiqb+itnu1GKucDQCB19INGmYo7L6V78H2OYIEtEJQYFaljlhfp6oOcj7kK
         7d7jYCV9eR6fHxyPpbsgOWrGNZds8ANy/IIUx4glbeSDIsudXNu7TIFTqLsp/gkdPaKV
         2JZIxqvIG2hR+aPpUZ9/rc0bH/wuqmTmqReYkEmrTwdbzBNV70uiPlutFYuGcX8qgeeE
         1yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DxSi0a/XDWO3IJBuJfhqjQ/ZniqUa6Cz6sACQWEbyo=;
        b=dUJ6UikYD54LHHKpb0D28CiHonH9s8JjYCjAQsCV+sTN/v2YFPYeWJD2W5aMxvC/JW
         WZHS4LP+GdmqIlepqoqDGgKmwV9Lp81boqkz1YtoXOFLAV9Im/A48VPTCHgfkb1dXvWw
         xqWrcgKhYpBRDb8z89p6YAdUSGaQJNR0yAhb810hD0Xh1kJShrZnPmWyaKjLDgozJPaE
         AZ+uDPdg7gwQr8zZ9/70gOMpNPIuzX+vt0cqF6nSxjUMnHLv2AvkRZZGGJsjra9EBDXI
         OQBTjI/0nkmJFEx6jafYQ+ZYXpuaRoHIyTEd/NoUfIuccol7PT3NI4Fe1PvHglgy0qD2
         9BZA==
X-Gm-Message-State: AGi0PuZkJ0YWLnj/OGSg3VupYEPQiTwTunAMMfM7mw2Ercuzje7naHJj
        CElGK6n09U9dc9tY/ED/rTJhL0EUCq0lhHdc3IaJr+a9
X-Google-Smtp-Source: APiQypLy8TbrOB1VBGNamluC9srBj9yXZC5xE4gwEH9kJdcZbbO/6mQY8TAWFAw9b7ZXHmEyKO92yKJuKlJlM36cPrM=
X-Received: by 2002:aca:5513:: with SMTP id j19mr15769727oib.31.1588002379192;
 Mon, 27 Apr 2020 08:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <3910b39cf7c7419eb5b87c7aeb871e11@atos.net>
In-Reply-To: <3910b39cf7c7419eb5b87c7aeb871e11@atos.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Apr 2020 08:46:06 -0700
Message-ID: <CABPp-BEBQD1Rzaur7M5Uc8OyEidA08RkkjfXmCPm5qx6aUgE_A@mail.gmail.com>
Subject: Re: git-rebase v2.26.2 - "--root --empty drop" doesn't work and
 "--root --fork-point $somegibberish" gets SIGSEGV
To:     "Berg, Alexander" <alexander.berg@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Weiss, Karsten" <karsten.weiss@atos.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Mon, Apr 27, 2020 at 5:30 AM Berg, Alexander <alexander.berg@atos.net> wrote:
>
> Dear *,
>
> AFAIS there are (at least) two bugs in git-rebase at the moment.
> Those findings below occured on a simple branch, without an upstream.
>
> If you wish to rebase history and drop all empty commits, e.g.
>     git rebase --root --empty drop
> those empty commits are still in place after the operation comletes.
> With git v2.14.xx this operation ("--drop-empty") drops those empty
> commits as expected.
> Is there a new option to be used here or something?
> Or is it just broken?

From the documentation:

--empty={drop,keep,ask}::
        How to handle commits that are not empty to start and are not
        clean cherry-picks of any upstream commit, but which become
        empty after rebasing (because they contain a subset of already
        upstream changes).

With 2.26.2, to drop commits that _start_ empty, you'd use an
interactive rebase and remove the 'pick' lines associated with those
commits.  In 2.27, we'll mark such commits with an "# empty" trailer,
and will also provide the --no-keep-empty flag to just automatically
drop them.  (See
https://lore.kernel.org/git/3a5bedc68d696f19ab8eb40d1af8abd42172219f.1586573068.git.gitgitgadget@gmail.com/,
or check out the 'next' branch of git.git if you'd like to try it
sooner.)

> As I've experimented with some new options for the above command,
> it seems that user input checking isn't done properly for "--fork-point".
> I've tried
>     git rebase --root --empty drop --fork-point --rebase-merges
> (yes, --fork-point usage is wrong here) and got
>     Segmentation fault (core dumped)
>
> A colleague of mine looked into this:
>     $ gdb /bin/git
>     (gdb) set args rebase --root --empty drop --fork-point --rebase-merges
>     (gdb) run
>     Starting program: /bin/git rebase --root --empty drop --fork-point --rebase-merges
>     [Thread debugging using libthread_db enabled]
>     Using host libthread_db library "/lib64/libthread_db.so.1".
>
>     Program received signal SIGSEGV, Segmentation fault.
>     is_per_worktree_ref (refname=0x0) at refs.c:725
>     725                     starts_with(refname, "refs/bisect/") ||
>     Missing separate debuginfos, use: debuginfo-install glibc-2.17-292.el7.x86_64 pcre-8.32-17.el7.x86_64 zlib-1.2.7-18.el7.x86_64
>     (gdb) bt
>     #0  is_per_worktree_ref (refname=0x0) at refs.c:725
>     #1  ref_type (refname=refname@entry=0x0) at refs.c:760
>     #2  0x00000000005739c9 in files_reflog_path (refs=0x90ce30, sb=0x7fffffffc5e0, refname=0x0) at refs/files-backend.c:176
>     #3  0x000000000057402a in files_for_each_reflog_ent (ref_store=<optimized out>, refname=0x0, fn=0x4d4d20 <collect_one_reflog_ent>, cb_data=0x7fffffffc640)
>         at refs/files-backend.c:2060
>     #4  0x00000000004d4f4b in get_fork_point (refname=0x0, commit=0x91cff0) at commit.c:933
>     #5  0x0000000000475e69 in cmd_rebase (argc=0, argv=0x7fffffffdd20, prefix=<optimized out>) at builtin/rebase.c:2082
>     #6  0x0000000000406cd0 in run_builtin (argv=0x7fffffffdd20, argc=6, p=0x8b3f40 <commands+2016>) at git.c:444
>     #7  handle_builtin (argc=6, argv=argv@entry=0x7fffffffdd20) at git.c:674
>     #8  0x0000000000407bee in run_argv (argv=0x7fffffffda80, argcp=0x7fffffffda8c) at git.c:741
>     #9  cmd_main (argc=6, argc@entry=7, argv=0x7fffffffdd20, argv@entry=0x7fffffffdd18) at git.c:872
>     #10 0x0000000000406910 in main (argc=7, argv=0x7fffffffdd18) at common-main.c:52
>     (gdb) list
>     720
>     721     static int is_per_worktree_ref(const char *refname)
>     722     {
>     723             return !strcmp(refname, "HEAD") ||
>     724                     starts_with(refname, "refs/worktree/") ||
>     725                     starts_with(refname, "refs/bisect/") ||
>     726                     starts_with(refname, "refs/rewritten/");
>     727     }
>     728
>     729     static int is_pseudoref_syntax(const char *refname)
>     (gdb)
>
>
> With kind regards,
>     Alex

Thanks for the report; when the tests finish at
https://github.com/git/git/pull/771, I'll submit the patch to the
list.

Elijah
