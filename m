Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A7C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhLNEJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhLNEJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9622C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso15417881wml.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YCYSmezm/0Jn4EY9BK4Jr6G0fnr+Q4QyHilCYRQVha8=;
        b=Yeos18Ol+7qbU4+VO92jbJlJBCg72jcqZpJwcRUqXcEN8D1MEm/R3VhvFla2uN4pEj
         Nfyr5qq7xexjpwVPqNVhVoo4sIjiHvIqelfqZEfyCjoxpanIRJTY/kEZYA/7ux0znBCk
         3wfG+JoB+vppFSxeRHEuGHbJMKnJYWfxyJGhLE97198y9ED98x+DykRVyHE5gpT/DWJ3
         C7wfGTIKD/qGAFovbKXr486OYn5sQVUFql/WRmfMYwjaCUvgSCXtk/FOUgMuns1WU1Xd
         lQZTwGf33eH3Wo+Wh4HOWeJTV3NSvWmtcYCXPvym5AmTwrTbf7cVz/xn3hHR56seaf7O
         cQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YCYSmezm/0Jn4EY9BK4Jr6G0fnr+Q4QyHilCYRQVha8=;
        b=G7GPIV/khsDDFE7RzHJhgBrWpN/9qWVCVM+B+KMEUnEDa0kw1rEagFUps0SEj8xW6J
         OZHQwqXrRnPngRCrcW/2Dx3DNLSSbALBt/FpJqdu3iBsMYJV8ehCYQGqjai0gAZP+YuM
         w9rc/c/YKTtbQ1EOgEAfcVU7I3IYXSifw54eXKXSjjiIbb2JU0w0+HSiO9XP5o2Rc+df
         npyoK6U0MUQkzUPy/WkAHDWeSMPptFTRTlldxOlPInnTSsjGi/zVL3Hio9ZwY5HPLenw
         Hxy5g29t/Zfyz/XUxSIaHp/KbvOL9zQhguAjd5n4Xxi/kPV5qfEsOfHNDV6AIwrnhUR1
         Gfaw==
X-Gm-Message-State: AOAM532B3RTbe6GoHy6k+Y/Ofm9MuydYfnbMxKOJ9uyhT+p32phgX90a
        xg7xB/PZbDDjJoiSvzLH7LZzc88pKbk=
X-Google-Smtp-Source: ABdhPJwYVOnwtrzWiB/d2p6CwR2rFV+t1t0ggZBLJNVhRIAPi40bQIbLQQOK7y6hNy9fsimlP2rzYA==
X-Received: by 2002:a05:600c:3844:: with SMTP id s4mr21790063wmr.165.1639454953088;
        Mon, 13 Dec 2021 20:09:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm14780316wrf.69.2021.12.13.20.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:12 -0800 (PST)
Message-Id: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:02 +0000
Subject: [PATCH v4 00/10] sparse-checkout: make set subsume init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described at [1], the split of init and set subcommands in
sparse-checkout causes multiple issues:

 * Poor performance (deleting all tracked files, then later restoring many
   and maybe even most of them)
 * Poor UI (multiple progress bars in wrappers that hide both commands under
   1 user-facing command)
 * Loss of ignored files under directories the user wanted to keep

This series fixes this bug by providing a single command to switch to a
sparse-checkout: set. It does so by making set able to do the combined work
of init and set. It keeps init as-is to give folks time to adapt, but marks
it as deprecated. It also makes reapply able to toggle cone/non-cone mode
and sparse-index/non-sparse-index mode.

Changes since v3:

 * Do not make git sparse-checkout disable throw an error when not in a
   sparse-checkout -- and document why we don't exit early either.

Changes since v2:

 * Small documentation wording improvement
 * Added Reviewed-by's from Stolee and Victoria

Changes since v1:

 * Inserted new patches 3 & 4 as additional preparatory cleanups
 * Took the new mode-toggling work code in sparse_checkout_set from the
   previous series and moved it into a new function, as a preparatory patch,
   and made it usable by init/set/reapply
 * Also updated reapply to allow mode-toggling
 * Updated the documentation as per above
 * Various other small items from review comments

A quick overview:

 * Patches 1-4: small preparatory refactorings
 * Patch 5: patch adding new function for toggling {cone,sparse-checkout}
   modes
 * Patch 6: the crux of the series; make set able to handle both init and
   set options
 * Patch 7: make reapply also able to do mode toggling
 * Patches 8-9: documentation modifications (Patch 4 is worth reviewing; it
   marks init as deprecated -- are others okay with that?)
 * Patch 10: trivial modification of git clone --sparse to use git
   sparse-checkout set rather than git sparse-checkout init.

[1]
https://lore.kernel.org/git/CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com/

Elijah Newren (10):
  sparse-checkout: pass use_stdin as a parameter instead of as a global
  sparse-checkout: break apart functions for sparse_checkout_(set|add)
  sparse-checkout: add sanity-checks on initial sparsity state
  sparse-checkout: disallow --no-stdin as an argument to set
  sparse-checkout: split out code for tweaking settings config
  sparse-checkout: enable `set` to initialize sparse-checkout mode
  sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
  git-sparse-checkout.txt: update to document init/set/reapply changes
  Documentation: clarify/correct a few sparsity related statements
  clone: avoid using deprecated `sparse-checkout init`

 Documentation/git-clone.txt           |   8 +-
 Documentation/git-sparse-checkout.txt | 100 +++++++------
 builtin/clone.c                       |   2 +-
 builtin/sparse-checkout.c             | 204 ++++++++++++++++++++------
 t/t1091-sparse-checkout-builtin.sh    |  10 +-
 5 files changed, 227 insertions(+), 97 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1151%2Fnewren%2Fsparse-checkout-no-init-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1151/newren/sparse-checkout-no-init-v4
Pull-Request: https://github.com/git/git/pull/1151

Range-diff vs v3:

  1:  814aed2d125 =  1:  814aed2d125 sparse-checkout: pass use_stdin as a parameter instead of as a global
  2:  04cd57592e9 =  2:  04cd57592e9 sparse-checkout: break apart functions for sparse_checkout_(set|add)
  3:  f3af5edb25d !  3:  a8fdda35b91 sparse-checkout: add sanity-checks on initial sparsity state
     @@ Metadata
       ## Commit message ##
          sparse-checkout: add sanity-checks on initial sparsity state
      
     -    Most sparse-checkout subcommands (list, add, reapply, disable)
     -    only make sense when already in a sparse state.  Add a quick check
     -    that will error out early if this is not the case.
     +    Most sparse-checkout subcommands (list, add, reapply) only make sense
     +    when already in a sparse state.  Add a quick check that will error out
     +    early if this is not the case.
     +
     +    Also document with a comment why we do not exit early in `disable` even
     +    when core.sparseCheckout starts as false.
      
          Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Reviewed-by: Victoria Dye <vdye@github.com>
     @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
       	struct pattern_list pl;
       	struct strbuf match_all = STRBUF_INIT;
       
     -+	if (!core_apply_sparse_checkout)
     -+		die(_("no active sparse-checkout to disable"));
     ++	/*
     ++	 * We do not exit early if !core_apply_sparse_checkout; due to the
     ++	 * ability for users to manually muck things up between
     ++	 *   direct editing of .git/info/sparse-checkout
     ++	 *   running read-tree -m u HEAD or update-index --skip-worktree
     ++	 *   direct toggling of config options
     ++	 * users might end up with an index with SKIP_WORKTREE bit set on
     ++	 * some files and not know how to undo it.  So, here we just
     ++	 * forcibly return to a dense checkout regardless of initial state.
     ++	 */
      +
       	argc = parse_options(argc, argv, NULL,
       			     builtin_sparse_checkout_disable_options,
  4:  82a13cc0197 =  4:  5882332b97f sparse-checkout: disallow --no-stdin as an argument to set
  5:  7a812e0222c =  5:  3e9e28c8dd2 sparse-checkout: split out code for tweaking settings config
  6:  7167a4b3118 =  6:  595ba138603 sparse-checkout: enable `set` to initialize sparse-checkout mode
  7:  3687637915f =  7:  09b13280c26 sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
  8:  7483d1363e5 =  8:  9d96da855ea git-sparse-checkout.txt: update to document init/set/reapply changes
  9:  11a45920602 =  9:  f669829a98b Documentation: clarify/correct a few sparsity related statements
 10:  395d9b194d3 = 10:  ae671aa615a clone: avoid using deprecated `sparse-checkout init`

-- 
gitgitgadget
