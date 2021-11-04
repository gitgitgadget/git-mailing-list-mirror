Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2F3C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 21:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCAA6112E
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhKDVYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhKDVYd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 17:24:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515DC061205
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 14:21:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u17so9401581plg.9
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8yiPwdxrWnuhY2v+z7yuD2v01oBRdpv9+II4nlTbajo=;
        b=RxwJnWqO4F25akpGh5MggrEIi2UGJL8vWh+/GFvk7jBvvAxkWvZZqRH5gbRThcub+V
         HwtvA+SXj91Jd5YYDAfIldqTesSykKs78UcIv8mYjRby9elVc4CAB2fvDLTpakeKoHLZ
         5mFG2/nA3B/HsO6PhUngRIpQK1wWxS9fK7AaJHKQOTAG1LLqgaG342+tuDdORBgBQGOX
         DJT6LoC85r8eIylWG9q8oiXeVMZaXfVWmg2WJxHzTqqTqIbWLSydYdLcQc922pVi7mWF
         o1fWMeew9dSJdhlotnkJYHpAkGkHVvRF+PeTlLmmF2859xJ75ZTfCydFr/puZeV5QPIb
         RQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yiPwdxrWnuhY2v+z7yuD2v01oBRdpv9+II4nlTbajo=;
        b=ZfH5yhUuu81ltizj9CWMjLPv2qxb77iSoymZLWWNGi8/cFVsOzfELIIvcU+8E1c8H7
         ACGTtNh5Wb+/vrU7Xz8UE9GAesgMIFEvGeoDKIYePS5gEDXSAp9SJ9Bgc+gn9jpt0LtN
         4GJL9xtXKXG423pnGkpLMVaUDNKv6wKV3dmuPbUu+U/RnDPZCKmicqWmAUliFnJpAXjs
         gsCoSdl9gXz3YaZc+5GbezsfBU79bJZtmImiAL5uNYJ9cBLKx6EBloWC2LZxhgy+ewnF
         HzlxK88hRH4sMa38u3EdxdehoJOuFVRovNEL3HTre+BoL73rV+uAF49fp3vnmFHgFlDM
         628A==
X-Gm-Message-State: AOAM532rVebbQGKYnbd3G7qIbu3ByL293nFGv72rmIPpLFkhH/2NWSRQ
        FfQ+YGOtLN684MoY/SMNl/KJ6Q==
X-Google-Smtp-Source: ABdhPJyTJdsvsM8qbRnJAeVttoWo+InP3WSxF6hnhucPx8eFAlSo4pdGWfSRKuJXOuE1maKOQOT+tw==
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr24907736pjq.104.1636060913488;
        Thu, 04 Nov 2021 14:21:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
        by smtp.gmail.com with ESMTPSA id mg17sm4784057pjb.17.2021.11.04.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 14:21:52 -0700 (PDT)
Date:   Thu, 4 Nov 2021 14:21:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: submodules ux overhaul update (was: What's cooking in git.git (Nov
 2021, #02; Wed, 3))
Message-ID: <YYRO7IndgVEn0yqg@google.com>
References: <xmqq8ry44vve.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8ry44vve.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 05:17:41PM -0700, Junio C Hamano wrote:
> --------------------------------------------------
> [Cooking]
> 
> * gc/remote-with-fewer-static-global-variables (2021-10-28) 6 commits
>  - remote: add struct repository parameter to external functions
>  - remote: die if branch is not found in repository
>  - remote: remove the_repository->remote_state from static methods
>  - remote: use remote_state parameter internally
>  - remote: move static variables into per-repository struct
>  - t5516: add test case for pushing remote refspecs
> 
>  Code clean-up to eventually allow information on remotes defined
>  for an arbitrary repository to be read.
> 
>  Will merge to 'next'?

Glen says he thinks this is ready to go in, yeah.

> 
> 
> * ab/config-based-hooks-2 (2021-11-01) 18 commits
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - hooks: convert worktree 'post-checkout' hook to hook library
>  - hooks: convert non-worktree 'post-checkout' hook to hook library
>  - merge: convert post-merge to use hook.h
>  - am: convert applypatch-msg to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - hook API: add a run_hooks_l() wrapper
>  - am: convert {pre,post}-applypatch to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook API: add a run_hooks() wrapper
>  - hook: add 'run' subcommand
>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
> 
>  More "config-based hooks".

Like I said in last submodule "newsletter", I don't think I can give
much better review on these ones than I have already.

> * js/branch-track-inherit (2021-10-18) 1 commit
>  - branch: add flags and config to inherit tracking
> 
>  "git -c branch.autosetupmerge=inherit branch new old" makes "new"
>  to have the same upstream as the "old" branch, instead of marking
>  "old" itself as its upstream.
> 
>  Under discussion.
>  cf. <87a6j6tbsv.fsf@gmgdl.gmail.com>

Not sure when we can expect a reroll. Josh is OOO this week; thinking
possibly next week?

> * es/superproject-aware-submodules (2021-10-14) 4 commits
>  - submodule: record superproject gitdir during 'update'
>  - submodule: record superproject gitdir during absorbgitdirs
>  - introduce submodule.superprojectGitDir record
>  - t7400-submodule-basic: modernize inspect() helper
> 
>  A configuration variable in a submodule points at the location of
>  the superproject it is bound to (RFC).
> 
>  Under discussion.
>  cf. <911ab2c1-8a11-d9d0-4b28-fc801112f6da@gmail.com>

Saw review from Stolee as well as Jonathan Tan; based on Stolee's
comments, I think it needs a reroll. I'll try and get one out today or
tomorrow.

---

Additionally, there's a WIP reroll of Jonathan Tan's conditional include
based on remote URL:
https://lore.kernel.org/git/cover.1635527389.git.jonathantanmy%40google.com

I owe a review there; other reviews welcome too.

---

Coming soon: look for an RFC from Glen on branch creation with
--recurse-submodules.

Thanks, all.

 - Emily
