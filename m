Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52651F453
	for <e@80x24.org>; Tue, 23 Oct 2018 22:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeJXHVJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 03:21:09 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:53752 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeJXHVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 03:21:09 -0400
Received: by mail-ot1-f73.google.com with SMTP id k15so2026325otd.20
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Lz81XapisrDUzkjz2pDsGLVqrrNx6gm2YyBNF/kL0/U=;
        b=VynCGZU9J8gmVA1d572LTZ60PDnjsWIhJ05CGeiKIg1NSo+lxtA40CBy2nx9A+1kR+
         DJYHA9u0r7+1R8b/dixPPyhG6uRS5vy96TIRRuvAvkQlu14PE4VBG6GZMP3yugYLvgqL
         ct/y8ooHJ8QcQv13mL2KyMhlRXatddA1dFOYYDs+9VESJnxk+Xkrl+aPESpcYlIRECi8
         FIwbQDHIAyC9e/0Rsyt1nYRcZyDzUa1ywXCRHdWf2QMWXn/DN4w+/dHHSXzEAtFhSifE
         SgzVPkwF2mlSOYHKPq6cmK97QqYVL8n3DZkZ7ZgDVtVH2YpxQS5xqR3TYhQ7LUmyEHke
         4L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Lz81XapisrDUzkjz2pDsGLVqrrNx6gm2YyBNF/kL0/U=;
        b=TZLz4gdaw0Wai6ulj51Ak04l2uer5+q8+u4LMqAKyqfrenbM949XSrzPzy9QHFaglg
         A8vEoeO8ri6eNNijgHFfGVvFAtTbeHqrHm7bbocYmWMcyzjQdWmctAEznCTUQe1I0yfH
         BmRfU3wPpkDIKVSGs/HtgjarT0iHNJgNIwxNeDUb3LSw7gj5G33s4JD0oJKC61/q4maT
         2QC1nsAwB2dIXxfL+8re6YziXQ1zDWyfT2T0Hw8XL5TmscR/G+IWKkiBiGjoslN3L9Ts
         TpjS+nX3RXCLv4GvNWUOHjnINLRlMziByveIvDq6BIyqjAOtvCe9keS/9YYwUNWR1tub
         1QaA==
X-Gm-Message-State: AGRZ1gLvxplIPu0C5ZNhfHejU6BDYosEn6q7so8TboOvEbSyHNfNbc0K
        BSmIhFQBFxTU+8kpUs5gNcHdGVjnONgp9SG7KzKP
X-Google-Smtp-Source: AJdET5ccc19V2F10T84AutFTEfKwo6bUEwMJSyHSUQwzt9U5xkzCi9i2C4McYKWYqonAHU8qmWJrfR6Q4KI8rj+xOP3m
X-Received: by 2002:a9d:2351:: with SMTP id k17mr205714otd.34.1540335340299;
 Tue, 23 Oct 2018 15:55:40 -0700 (PDT)
Date:   Tue, 23 Oct 2018 15:55:36 -0700
In-Reply-To: <CAGZ79kbunyc02802+4sjGwthBnj_=eS=+z5B_WQSRdbUAHw1tQ@mail.gmail.com>
Message-Id: <20181023225536.61508-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGZ79kbunyc02802+4sjGwthBnj_=eS=+z5B_WQSRdbUAHw1tQ@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 7/9] submodule: fetch in submodules git directory instead
 of in worktree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Why does GIT_DIR need to be set? Is it to avoid subcommands recursively
> > checking the parent directories in case the CWD is a malformed Git
> > repository? If yes, maybe it's worth adding a comment.
> 
> It is copying the structure from prepare_submodule_repo_env,
> specifically 10f5c52656 (submodule: avoid auto-discovery in
> prepare_submodule_repo_env(), 2016-09-01), which sounds
> appealing (and brings real benefits for the working directory),
> but I have not thought about this protection for the git dir.
> 
> Maybe another approach is to not set the cwd for the child process
> and instead point GIT_DIR_ENVIRONMENT only to the right
> directory.
> 
> Then the use of GIT_DIR_ENVIRONMENT is obvious and
> is not just for protection of corner cases.
> 
> However I think this protection is really valuable for the
> .git dir as well as the submodule may be broken and we do not
> want to end up in an infinite loop (as the discovery would find
> the superproject which then tries to recurse, again, into the
> submodule with the broken git dir)
> 
> When adding the comment here, we'd also want to have
> the comment in prepare_submodule_repo_env, which
> could be its own preparation commit.

I agree with the protection. As for the preparation commit, I don't
think it's always the code author's responsibility to tidy up the
surrounding code, but since you're adding an identical comment here,
it's probably worth it to add the comment there too.

> > This is the significant thing that this patch does more - an unskipped
> > submodule is now something that either passes the checks in
> > repo_submodule_init() or the checks in repo_init(), which seems to be
> > stricter than the current check that ".git" points to a directory or is
> > one. This means that we skip certain broken repositories, and this
> > necessitates a change in the test.
> 
> I see. However there is no change in function, the check in repo_init
> (or repo_submodule_init) is less strict than the check in the child process.
> So if there are broken submodule repositories, the difference of this
> patch is the layer at which it is caught, i.e. we would not spawn a child
> that fails, but skip the submodule.
> 
> Thinking of that, maybe we need to announce that in get_next_submodule

The consequence of getting caught changes, though. Currently,
spf->result is set to 1 whenever a child process fails. But in this
patch, some of these repositories would be entirely skipped, meaning
that no child process is run, and spf->result is never modified.

> > I think we should be more particular about what we're allowed to skip -
> > in particular, maybe if we're planning to skip this submodule, its
> > corresponding directory in the worktree (if one exists) needs to be
> > empty.
> 
> If the working tree directory is empty for that submodule, it means
> it is likely not initialized. But why would we use that as a signal to
> skip the submodule?

What I meant was: if empty, skip it completely. Otherwise, do the
repo_submodule_init() and repo_init() thing, and if they both fail, set
spf->result to 1, preserving existing behavior.
