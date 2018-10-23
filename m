Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3861F453
	for <e@80x24.org>; Tue, 23 Oct 2018 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJXCvQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 22:51:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46335 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbeJXCvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 22:51:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so2562312edq.13
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AswHiEvHz3skfYqsHzVNfARVpTPoHEH3Xx8uPDX4Q9o=;
        b=MpEZFjzzrzGonn5gJ8dzrTFEBzReq10Isd10IGNsydAyFsCVANgLuxXbJR2QAeQD3i
         B9qGVjyV+lcrMmVvSIIa/Tvu0IDmy2CsiBPr8+QVpp+ZNdMQJMR83ziW5eB0PGES2s2g
         8mwzCBWKWOX0O91FNoEl4U4/mN63eX86JrmmDBA5FREg1GqFQc3qioCk4ZgnPm6R1vpl
         PaFfuCzw/5oVzl5aBwYdSUwCsqglcBaBPk0gSD0T6N2uZYZOJJ+91S6Ho5l2OxIE8Uou
         LsTTV1uxfIRFaTxW//1d8PMfOKor0RpI9L1YNqOMu++1KwynGcl6N2pw0l2ZQSkAEDv0
         2Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AswHiEvHz3skfYqsHzVNfARVpTPoHEH3Xx8uPDX4Q9o=;
        b=IhX1wfuLS0B8tmVeAvbMvwj01t8zRGkeDsbaju6yfm4BjBAUCOBqqtsCfsAeKQbMJd
         SaWAepxPV0QFvInDJIGiQbkkMq4o6Im7frYHDyR1g7cBOGd0oEHZKnrCZPVRU33UP0KX
         B7MQrSRbM1x/lXOBGh2AJoe1zchKwOUSDwP696UkXOf5jvNiWnsFKeevd4BU+IkMiFwS
         vyeB4ra83eJdglzNvcZstECkgDzjgaX8ff6aCZKzsyeyUGV4Cxl2C3I3q6LE04ckugrA
         i4TalKvTOFIh/BKGkgO6/w/GIeWC2eEgj/4MuD0wZNteTKmvc3DA7phKdrAfqpGiF0vp
         xhMw==
X-Gm-Message-State: ABuFfoi2MGq0Z/c63Oh7yqQHjsyCVt4NSfNo3i3zYuzdwjjQRhaj+zVr
        gWIJBHk1JSvc8pWf/XyHu22evQLpNRbXujgAvr71kA==
X-Google-Smtp-Source: ACcGV62bBjhRlP2wUmkR6lSsKrZK1H6Qy6EUkwPgT2OF3XMQ/jTm4B0H/7lNsqYn7KT+hZHQEjdPw/WfXcEsYkOrCSo=
X-Received: by 2002:a50:b607:: with SMTP id b7-v6mr16052584ede.215.1540319202917;
 Tue, 23 Oct 2018 11:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181016181327.107186-8-sbeller@google.com> <20181017225811.66554-1-jonathantanmy@google.com>
In-Reply-To: <20181017225811.66554-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Oct 2018 11:26:32 -0700
Message-ID: <CAGZ79kbunyc02802+4sjGwthBnj_=eS=+z5B_WQSRdbUAHw1tQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] submodule: fetch in submodules git directory instead
 of in worktree
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 3:58 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > This patch started as a refactoring to make 'get_next_submodule' more
> > readable, but upon doing so, I realized that "git fetch" of the submodule
> > actually doesn't need to be run in the submodules worktree. So let's run
> > it in its git dir instead.
>
> The commit message needs to be updated, I think - this patch does
> significantly more than fetching in the gitdir.

From my point of view, it is not significant, but refactoring.
I'll think how to write a better commit message.

> > This patch leaks the cp->dir in get_next_submodule, as any further
> > callback in run_processes_parallel doesn't have access to the child
> > process any more.
>
> The cp->dir is already leaked - probably better to write "cp->dir in
> get_next_submodule() is still leaked, but this will be fixed in a
> subsequent patch".

... which fails to mention the reason why (as it is hard to do given
the current design) but is more concise.

> > +static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
> > +{
> > +     prepare_submodule_repo_env_no_git_dir(out);
> > +     argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
>
> Why does GIT_DIR need to be set? Is it to avoid subcommands recursively
> checking the parent directories in case the CWD is a malformed Git
> repository? If yes, maybe it's worth adding a comment.

It is copying the structure from prepare_submodule_repo_env,
specifically 10f5c52656 (submodule: avoid auto-discovery in
prepare_submodule_repo_env(), 2016-09-01), which sounds
appealing (and brings real benefits for the working directory),
but I have not thought about this protection for the git dir.

Maybe another approach is to not set the cwd for the child process
and instead point GIT_DIR_ENVIRONMENT only to the right
directory.

Then the use of GIT_DIR_ENVIRONMENT is obvious and
is not just for protection of corner cases.

However I think this protection is really valuable for the
.git dir as well as the submodule may be broken and we do not
want to end up in an infinite loop (as the discovery would find
the superproject which then tries to recurse, again, into the
submodule with the broken git dir)

When adding the comment here, we'd also want to have
the comment in prepare_submodule_repo_env, which
could be its own preparation commit.

> > +static struct repository *get_submodule_repo_for(struct repository *r,
> > +                                              const struct submodule *sub)
> > +{
> > +     struct repository *ret = xmalloc(sizeof(*ret));
> > +
> > +     if (repo_submodule_init(ret, r, sub)) {
> > +             /*
> > +              * No entry in .gitmodules? Technically not a submodule,
> > +              * but historically we supported repositories that happen to be
> > +              * in-place where a gitlink is. Keep supporting them.
> > +              */
> > +             struct strbuf gitdir = STRBUF_INIT;
> > +             strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
> > +             if (repo_init(ret, gitdir.buf, NULL)) {
> > +                     strbuf_release(&gitdir);
> > +                     return NULL;
> > +             }
> > +             strbuf_release(&gitdir);
> > +     }
> > +
> > +     return ret;
> > +}
>
> This is the significant thing that this patch does more - an unskipped
> submodule is now something that either passes the checks in
> repo_submodule_init() or the checks in repo_init(), which seems to be
> stricter than the current check that ".git" points to a directory or is
> one. This means that we skip certain broken repositories, and this
> necessitates a change in the test.

I see. However there is no change in function, the check in repo_init
(or repo_submodule_init) is less strict than the check in the child process.
So if there are broken submodule repositories, the difference of this
patch is the layer at which it is caught, i.e. we would not spawn a child
that fails, but skip the submodule.

Thinking of that, maybe we need to announce that in get_next_submodule

>
> I think we should be more particular about what we're allowed to skip -
> in particular, maybe if we're planning to skip this submodule, its
> corresponding directory in the worktree (if one exists) needs to be
> empty.

If the working tree directory is empty for that submodule, it means
it is likely not initialized. But why would we use that as a signal to
skip the submodule?



> > -                     cp->dir = strbuf_detach(&submodule_path, NULL);
> > -                     prepare_submodule_repo_env(&cp->env_array);
> > +                     prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> > +                     cp->dir = xstrdup(repo->gitdir);
>
> Here is where the functionality change (fetch in ".git") described in
> the commit message occurs.

True.

Thanks for the review, I'll try to split up this commit a bit more and
explain each part on its own.
