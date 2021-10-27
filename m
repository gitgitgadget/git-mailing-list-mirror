Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C120BC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAA6601FC
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhJ0T2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbhJ0T2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:28:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94EC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:26:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so2752192plc.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X/gUOUN6Aw9BhRw3hBfkiHiw1xX6hLWY84FtGtCfDE8=;
        b=SI4W0MTcULIXGXQtR0CWLdHmeIV68ozQ83+xGHKjmKXnSJjcxVW/mYGS59cPH9NDv7
         Y0p4paWPPpMG4Bmn8LJhzj8PfCUxBFuyos+qKUj/mhZbaRVi5OI5RIotaORVbb/4RUCy
         9dKbr2ufsba1/IgtXESj4SXTyaCegyLCcmC4SUODU3MjSE8QHUD4+4f9tYHlXSCejf3T
         O+dDuQA4fby946Om8QJX1VmpU1IiLizhCNZjR40Wu9XQQU9T3lDTuktlvYndsdPDeMDs
         y8B/oxZ6AwhLI2jzcuyRLBQqbmrOXvUKKBWPBiCt2n4egNRLHIliksrxOos1Es6oayh8
         iMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X/gUOUN6Aw9BhRw3hBfkiHiw1xX6hLWY84FtGtCfDE8=;
        b=4eI9492nBuGratU6FjUMJraAJ7tM9/6/L8swUik/90bGXpvdt2Iyuu/tNcMluct/gI
         lUj3LAqDqWfHr1W1ONw18GfXvRSJQgeirBw2XdMnYXZqK2un3Sldwpv7vVS3cEA7nXQ9
         ySpaEdf9kKc0cd0FRSZvV98Sb4WwCZ45rAzt8wwSsVL20g+lk9BZTUBO1PxTl+lpLkop
         CKQ4K1RfD55jWrpFyIkfDVZ/srW8KHeGEaT6Voz6bnzxNmpjOTKa7irKx7KcyqLDcQq2
         3ch1LNBbR4UsHhMbB07GIq+HjDNryIuP4CK474ZHRi76dDcJc3kzl7kYnBb95A7qWp9E
         j1qg==
X-Gm-Message-State: AOAM532f77TX/jwPRQiZ910XD0jgo8Dr8G+2BW0yslGR7u8n0py8sqLP
        HWyu7HQMxKz8uqFpM/0ui3GVNA==
X-Google-Smtp-Source: ABdhPJyC9iNOxstn2y2aLyommjsXcgJocjV3aFi4n/WEfcfUJVbQrFRJULnnCe0aeqkYr0BCRsLWyw==
X-Received: by 2002:a17:902:ea09:b0:13f:ac2:c5ae with SMTP id s9-20020a170902ea0900b0013f0ac2c5aemr29997786plg.3.1635362780378;
        Wed, 27 Oct 2021 12:26:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4c2:db58:dbe6:e3c8])
        by smtp.gmail.com with ESMTPSA id c25sm671161pfn.159.2021.10.27.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:26:19 -0700 (PDT)
Date:   Wed, 27 Oct 2021 12:26:15 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #05; Mon, 18)
Message-ID: <YXmn1yZgDHHz6TWa@google.com>
References: <xmqq1r4hv7bv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1r4hv7bv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pretty late sending this, so I'll try to include newer versions since
this mail came out last week, too.

On Mon, Oct 18, 2021 at 11:48:04PM -0700, Junio C Hamano wrote:
> [New Topics]
> 
> * gc/remote-with-fewer-static-global-variables (2021-10-13) 3 commits
>  - remote: add struct repository parameter to external functions
>  - remote: use remote_state parameter internally
>  - remote: move static variables into per-repository struct
> 
>  Code clean-up to eventually allow information on remotes defined
>  for an arbitrary repository to be read.
> 
>  Will merge to 'next'?

Sounds like there was a segfault reported on v3 (sent 2021-10-19, so
between this mail going out and now). Glen says he is working on reroll.

v3:
https://lore.kernel.org/git/20211019224339.61881-1-chooglen@google.com/

> * ab/config-based-hooks-2 (2021-10-15) 14 commits
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - merge: convert post-merge to use hook.h
>  - hooks: convert 'post-checkout' hook to hook library
>  - am: convert applypatch to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook: add 'run' subcommand
>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
> 
>  More "config-based hooks".
> 
>  Breaks t2400.

I see Ævar posted a reroll
(https://lore.kernel.org/git/cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com/).
I reviewed the prior version, but my review is not very useful since I
wrote many of these patches in the first place. So others who can
provide review would be doing me (and Ævar!) a favor (and I'd be happy
to trade review-for-review if needed ;) )

> * js/branch-track-inherit (2021-10-18) 1 commit
>  - branch: add flags and config to inherit tracking
> 
>  "git -c branch.autosetupmerge=inherit branch new old" makes "new"
>  to have the same upstream as the "old" branch, instead of marking
>  "old" itself as its upstream.
> 
>  Under discussion.
>  cf. <87a6j6tbsv.fsf@gmgdl.gmail.com>

I think Josh is waiting for discussion to settle before a reroll.

> --------------------------------------------------
> [Stalled]
> 
> * ar/submodule-update (2021-10-13) 9 commits
>  . submodule--helper: rename helper functions
>  . submodule--helper: remove unused helpers
>  . submodule: move core cmd_update() logic to C
>  . submodule--helper: run update using child process struct
>  . submodule--helper: allow setting superprefix for init_submodule()
>  . submodule--helper: refactor get_submodule_displaypath()
>  . submodule--helper: rename helpers for update-clone
>  . submodule--helper: get remote names from any repository
>  . submodule--helper: split up ensure_core_worktree()
> 
>  Rewrite of "git submodule update" in C.
> 
>  Kicked out of 'seen' to make room for es/superproject-aware-submodules
>  which is among the topics this topic stomps on.

The latest version of es/superproject-aware-submodules is starved for
review. I'd appreciate eyes on it (and can swap review for review if
folks need.)

> --------------------------------------------------
> [Cooking]
> 
> * es/superproject-aware-submodules (2021-10-14) 4 commits
>  - submodule: record superproject gitdir during 'update'
>  - submodule: record superproject gitdir during absorbgitdirs
>  - introduce submodule.superprojectGitDir record
>  - t7400-submodule-basic: modernize inspect() helper
> 
>  A configuration variable in a submodule points at the location of
>  the superproject it is bound to (RFC).
> 
>  Will merge to 'next'?

Sounds like Jonathan Tan asked for an additional test and a small fixup.
I can either send a squash patch or a reroll - your preference.

> * jt/no-abuse-alternate-odb-for-submodules (2021-10-08) 9 commits
>   (merged to 'next' on 2021-10-14 at ae49a2ceda)
>  + submodule: trace adding submodule ODB as alternate
>  + submodule: pass repo to check_has_commit()
>  + object-file: only register submodule ODB if needed
>  + merge-{ort,recursive}: remove add_submodule_odb()
>  + refs: peeling non-the_repository iterators is BUG
>  + refs: teach arbitrary repo support to iterators
>  + refs: plumb repo into ref stores
>  + Merge branch 'jk/ref-paranoia' into jt/no-abuse-alternate-odb-for-submodules
>  + Merge branch 'jt/add-submodule-odb-clean-up' into jt/no-abuse-alternate-odb-for-submodules
> 
>  Follow through the work to use the repo interface to access
>  submodule objects in-process, instead of abusing the alternate
>  object database interface.
> 
>  Will merge to 'master'.

Thanks, glad to see it go in.

Additionally:

https://lore.kernel.org/git/cover.1634077795.git.jonathantanmy@google.com/

  Jonathan is planning on sending a v2 soon - "hopefully this week."

Thanks all.

 - Emily
