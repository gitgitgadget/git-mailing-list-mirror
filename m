Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF01C433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbiAEUCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbiAEUC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0594C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q8so402312wra.12
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+DGmbD80B+1rXzyVHSgJ611O1XhX5pYfaprIXFfmwLo=;
        b=Ivj2rtuEPHe+D7q8Nqw9Q4wR6zLFr+D+wNybkgM7OAJdu+jn7vsuTWq8il71d++lkd
         lOZrEF1YFu4GFxnVAltY/IzdUeEAVmEwkVwzvqPpOk0aI21v2fj6aCp8yooKxsY6ydFF
         mCa/M5zFLPhfzwsmCiZXWdFNeyI/WFKG/qopuZOzQ7kO0bRp/V2rfZPvqjvIULMPKCPa
         hNpwj8J4U5UIv88e0qgYqZun6M5u7poThe8cEKWLfAoDEwONGq/vp9Bu88L9hteNnwrU
         qaJybqJRiIujCJNEMKaiQXWCWYk85AUgIkWNIWDHNFw34sZY8HslTG/crwuC2t3C5nNR
         bYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+DGmbD80B+1rXzyVHSgJ611O1XhX5pYfaprIXFfmwLo=;
        b=4mEHB5Az3tdLXWrmw0wzUnwPr3brqkyvEV3p3B/gJc419qSPz09mwA36mTTbhG5d4m
         BEk6ZKFBh4rEseN92O9VMzMwzdp3wUFSykNIKmWv0LiUbNt7aJlSdS5SVBKW6vURT2be
         C0Ub2lsjljWDQ5m2uWPC3Wl0ph9/9zMxSqgzuxgF4f55vhlH4CZuJZ+pVrHj5KQeqMJA
         XwCUhdKQuWOPC/7a6DQitJDdnDg+kLhLglDQMbSoVRsi5lJBn4FF85RR/dprI1clCzvu
         uSDr2BOFH1CJjMXBYwOPjIfqFSI/CY1bT8Cxi9wp1KiA47PG8sum8e5L/qplAzuQRojm
         cSgg==
X-Gm-Message-State: AOAM532Gb9YBRjvELNPs5ScStlAtprTWvp2cTyeBrtCC2P2ESIWwY/G4
        Gxh5goj6cHS3d1P5+EhkeVVpJT5TP0Y=
X-Google-Smtp-Source: ABdhPJx2FtpvKHFDWMoMmLDMF2aPJ0ag/voEJp9VxY1Hmw/Vq+6WYZn4Uy4krza281MXIeZro+Q5wQ==
X-Received: by 2002:a5d:6289:: with SMTP id k9mr46956864wru.501.1641412946159;
        Wed, 05 Jan 2022 12:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm3781397wmf.9.2022.01.05.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:25 -0800 (PST)
Message-Id: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:13 +0000
Subject: [PATCH v5 00/11] Factorization of messages with similar meaning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a meager attempt at rationalizing a small fraction of the
internationalized messages. Sorry in advance for the dull task of reviewing
these insipide patches.

Doing so has some positive effects:

 * non-translatable constant strings are kept out of the way for translators
 * messages with identical meaning are built identically
 * the total number of messages to translate is decreased.

Changes since V1:

 * took into account the comments, except for ref-filter.c where the
   proposed refactoring is not obvious.
 * added even more strings to the "cannot be used together" crowd.

Changes since V2:

 * fixed change of behaviour in tag.c
 * reverted sam changes as per Johannes Sixt comments

Changes since V3:

 * apply Oxford comma where needed
 * switch all options to " '%s' " style where i18n is applied.

Changes since V4:

 * Apply changes by René on tag.c
 * cosmetic changes

Jean-Noël Avila (11):
  i18n: refactor "foo and bar are mutually exclusive"
  i18n: refactor "%s, %s and %s are mutually exclusive"
  i18n: turn "options are incompatible" into "cannot be used together"
  i18n: standardize "cannot open" and "cannot read"
  i18n: tag.c factorize i18n strings
  i18n: factorize "--foo requires --bar" and the like
  i18n: factorize "no directory given for --foo"
  i18n: refactor "unrecognized %(foo) argument" strings
  i18n: factorize "--foo outside a repository"
  i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
  i18n: turn even more messages into "cannot be used together" ones

 apply.c                                   |  8 +++----
 archive.c                                 |  8 +++----
 builtin/add.c                             | 14 ++++++------
 builtin/am.c                              |  6 ++---
 builtin/branch.c                          |  2 +-
 builtin/cat-file.c                        |  2 +-
 builtin/checkout.c                        | 18 +++++++--------
 builtin/clone.c                           |  6 ++---
 builtin/commit.c                          | 17 +++++++-------
 builtin/describe.c                        |  6 ++---
 builtin/diff-tree.c                       |  2 +-
 builtin/difftool.c                        |  4 ++--
 builtin/fast-export.c                     |  4 ++--
 builtin/fetch.c                           |  8 +++----
 builtin/index-pack.c                      |  4 ++--
 builtin/init-db.c                         |  2 +-
 builtin/log.c                             |  8 +++----
 builtin/ls-files.c                        |  2 +-
 builtin/merge.c                           |  4 ++--
 builtin/pack-objects.c                    |  2 +-
 builtin/push.c                            |  8 +++----
 builtin/rebase.c                          | 10 ++++-----
 builtin/repack.c                          |  4 ++--
 builtin/reset.c                           | 10 ++++-----
 builtin/rev-list.c                        |  4 ++--
 builtin/rm.c                              |  4 ++--
 builtin/show-branch.c                     |  4 ++--
 builtin/stash.c                           |  8 +++----
 builtin/submodule--helper.c               |  4 ++--
 builtin/tag.c                             | 27 ++++++++++++++---------
 builtin/worktree.c                        |  6 ++---
 diff.c                                    | 12 ++++++----
 fetch-pack.c                              |  2 +-
 git.c                                     |  6 ++---
 http-fetch.c                              |  4 ++--
 range-diff.c                              |  2 +-
 ref-filter.c                              | 22 +++++++++---------
 revision.c                                | 22 +++++++++---------
 t/t0001-init.sh                           |  2 +-
 t/t2025-checkout-no-overlay.sh            |  2 +-
 t/t2026-checkout-pathspec-file.sh         |  8 +++----
 t/t2072-restore-pathspec-file.sh          |  6 ++---
 t/t3431-rebase-fork-point.sh              |  2 +-
 t/t3601-rm-pathspec-file.sh               |  4 ++--
 t/t3704-add-pathspec-file.sh              | 10 ++++-----
 t/t3909-stash-pathspec-file.sh            |  6 ++---
 t/t4209-log-pickaxe.sh                    | 10 ++++-----
 t/t5606-clone-options.sh                  |  4 ++--
 t/t7107-reset-pathspec-file.sh            |  6 ++---
 t/t7500-commit-template-squash-signoff.sh | 11 ++++-----
 t/t7526-commit-pathspec-file.sh           | 10 ++++-----
 51 files changed, 189 insertions(+), 178 deletions(-)


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1088%2Fjnavila%2Fi18n-refactor-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1088/jnavila/i18n-refactor-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1088

Range-diff vs v4:

  1:  05af90f5814 =  1:  05af90f5814 i18n: refactor "foo and bar are mutually exclusive"
  2:  e307ea9b998 !  2:  f6a5332d310 i18n: refactor "%s, %s and %s are mutually exclusive"
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
       	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
      -		die(_("-b, -B, and --detach are mutually exclusive"));
     -+		die(_("options '%s', '%s', and '%s' cannot be used together"),"-b", "-B", "--detach");
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-B", "--detach");
       	if (lock_reason && !keep_locked)
       		die(_("--reason requires --lock"));
       	if (lock_reason)
  3:  d5bfa26e992 !  3:  80390ce08ed i18n: turn "options are incompatible" into "cannot be used together"
     @@ apply.c: int check_apply_state(struct apply_state *state, int force_apply)
       
       	if (state->apply_with_reject && state->threeway)
      -		return error(_("--reject and --3way cannot be used together."));
     -+		return error(_("options '%s' and '%s' cannot be used together"), "--reject",  "--3way");
     ++		return error(_("options '%s' and '%s' cannot be used together"), "--reject", "--3way");
       	if (state->threeway) {
       		if (is_not_gitdir)
       			return error(_("--3way outside a repository"));
  4:  51c53f01dd8 =  4:  49e41dc136f i18n: standardize "cannot open" and "cannot read"
  5:  a9d8a50d666 !  5:  ad58bc8d8a9 i18n: tag.c factorize i18n strings
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
      -		die(_("--no-contains option is only allowed in list mode"));
      -	if (filter.points_at.nr)
      -		die(_("--points-at option is only allowed in list mode"));
     +-	if (filter.reachable_from || filter.unreachable_from)
     +-		die(_("--merged and --no-merged options are only allowed in list mode"));
      +		only_in_list = "-n";
      +	else if (filter.with_commit)
      +		only_in_list = "--contains";
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
      +		only_in_list = "--no-contains";
      +	else if (filter.points_at.nr)
      +		only_in_list = "--points-at";
     ++	else if (filter.reachable_from)
     ++		only_in_list = "--merged";
     ++	else if  (filter.unreachable_from)
     ++		only_in_list = "--no-merged";
      +	if (only_in_list)
      +		die(_("the '%s' option is only allowed in list mode"), only_in_list);
     - 	if (filter.reachable_from || filter.unreachable_from)
     --		die(_("--merged and --no-merged options are only allowed in list mode"));
     -+		die(_("'--merged' and '--no-merged' options are only allowed in list mode"));
       	if (cmdmode == 'd') {
       		ret = delete_tags(argv);
       		goto cleanup;
  6:  969946274aa !  6:  fd27beb3f2b i18n: factorize "--foo requires --bar" and the like
     @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
     - 		die(_("options '%s', '%s', and '%s' cannot be used together"),"-b", "-B", "--detach");
     + 		die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-B", "--detach");
       	if (lock_reason && !keep_locked)
      -		die(_("--reason requires --lock"));
      +		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
  7:  052dc06beeb =  7:  08f5471aeaa i18n: factorize "no directory given for --foo"
  8:  59e1e8aa1b4 =  8:  437aadbc2c9 i18n: refactor "unrecognized %(foo) argument" strings
  9:  39e375c68ab !  9:  7d97ee5dd18 i18n: factorize "--foo outside a repository"
     @@ Commit message
      
       ## apply.c ##
      @@ apply.c: int check_apply_state(struct apply_state *state, int force_apply)
     - 		return error(_("options '%s' and '%s' cannot be used together"), "--reject",  "--3way");
     + 		return error(_("options '%s' and '%s' cannot be used together"), "--reject", "--3way");
       	if (state->threeway) {
       		if (is_not_gitdir)
      -			return error(_("--3way outside a repository"));
 10:  c6161bc3f1a = 10:  226c105559c i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
 11:  4fab0db3cc4 = 11:  8bcc814ba00 i18n: turn even more messages into "cannot be used together" ones

-- 
gitgitgadget
