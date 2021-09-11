Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4991C433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCBE611BF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhIKA0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 20:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIKA0f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 20:26:35 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D4C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 17:25:23 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ib9-20020a0562141c8900b003671c3a1243so40759613qvb.21
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 17:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=SExv4TXwns70QTxKmN5VJidHfPeYBHCon2aUXKXMpXI=;
        b=U5ZhAUpwEbKvTSaeyS2z11duN3S2xAMS7y9Q2U5J5KC1dK/FiNhijJC2eCaH7YIsGO
         4V2X8/4urYy0ewU8nL3L0MwoDHyiR4svcCTufjG4wnuP9waqTm+je/MHTXMlrW2rykN5
         KhdS6ZQ80o1DqmZBy5OqEokK+IQvV3fCLUB2+xuJSDrDnhy93dZ/T3LYD9e3yfikhWtU
         ZkFhtiuATvtHWY55sG5vR4tyJbsMyARGVNC7iP3DXuMNy+8nFxjJZ7WxDoCGsSB7a6d0
         HxNC4yqeR+zgg3S3cADBeN9dc9TKy3v+FqYVp+WzuduIgPLAt52t/VCDDUHwTcJBjnAW
         lHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=SExv4TXwns70QTxKmN5VJidHfPeYBHCon2aUXKXMpXI=;
        b=n1bB9TS3p6bl8ivgj5oZTITaNG5Dq5WrnqI/KdrfsBLqUbESy0yj73S0McfOcsx2Sd
         e5iw0+WuvSxasGntxJF+A/rmswHt+ghtKnorw+u7f9H0ENQfwrfz1x9Cs1qzW6wWWegt
         mDSkzqzvjnyN2gfwLvW0jztM1OB2lB/SVDDH53iLI6pYshto7BCBeanHMHnCRwozT0bZ
         xqM/cZgCqLgnwnesnLAQi25dp1Y4xYFKboXdBoH3xu7XiWdCCCgA6H1LJ9VZV/iszfMq
         VZfxJtLjZPBvTf1ePQPjtGfaaHsZFYQljUaBMIoiiA7AMxS3g4vUF5niHjVE/CsgVY4q
         kQoA==
X-Gm-Message-State: AOAM533OjU3Eq3jw1lRca+WM51bG/z3k3qiyQVRgpmPhTEPFuzbwLG6H
        Qq0D9bogVuhWU+8A0dS1bmXIyeTWU5DMB6OAbFlWMUNr2WVGwa8K6IqIrJwUJHu/rxh7iMVZhuI
        F1qSv6d/niLroUwE40iq++XLz0xWAdueltYKRa2ZjSSMHbkpMpEPU1Hj3A8IOuus=
X-Google-Smtp-Source: ABdhPJzU/LBMqxZWPe0YI/PxC931jOTbvwtcfsAFJ9szqqZ1gvdIvViUbuC8oa3pRKadeHP9h8FFc8E+xwjb1g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:76ee:3e65:a242:bc2f])
 (user=steadmon job=sendgmr) by 2002:a0c:e88e:: with SMTP id
 b14mr298216qvo.59.1631319922631; Fri, 10 Sep 2021 17:25:22 -0700 (PDT)
Date:   Fri, 10 Sep 2021 17:25:20 -0700
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <0346f447548cfd11307173aaa3284d86a2ef689c.1631319742.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2] branch: add "inherit" option for branch.autoSetupMerge
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be helpful when creating a new branch to use the existing
tracking configuration from the branch point. However, there is
currently not a method to automatically do so.

Teach branch.autoSetupMerge a new "inherit" option. When this is set,
creating a new branch will cause the tracking configuration to default
to the configuration of the branch point, if set.

For example, if branch.autoSetupMerge=inherit, branch "main" tracks
"origin/main", and we run `git checkout -b feature main`, then branch
"feature" will track "origin/main". Thus, `git status` will show us how
far ahead/behind we are from origin, and `git pull` will pull from
origin.

This is particularly useful when creating branches across many
submodules, such as with `git submodule foreach ...` (or if running with
a patch such as [1], which we use at $job), as it avoids having to
manually set tracking info for each submodule.

[1]: https://lore.kernel.org/git/20180927221603.148025-1-sbeller@google.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
After a bit of testing, I've verified that this still works as intended
even without the extra patch [1] linked above. I've added documentation
and tests.

Range-diff against v1:
1:  9628d14588 ! 1:  0346f44754 branch: add "inherit" option for branch.autoSetupMerge
    @@ Commit message
         creating a new branch will cause the tracking configuration to default
         to the configuration of the branch point, if set.
     
    -    NEEDS WORK:
    -    * this breaks `git checkout -b new-branch --recurse-submodules`
    -    * add documentation
    -    * add tests
    -    * check corner cases, including whether this plays well with related
    -      cmd-line options (switch, checkout, branch)
    +    For example, if branch.autoSetupMerge=inherit, branch "main" tracks
    +    "origin/main", and we run `git checkout -b feature main`, then branch
    +    "feature" will track "origin/main". Thus, `git status` will show us how
    +    far ahead/behind we are from origin, and `git pull` will pull from
    +    origin.
    +
    +    This is particularly useful when creating branches across many
    +    submodules, such as with `git submodule foreach ...` (or if running with
    +    a patch such as [1], which we use at $job), as it avoids having to
    +    manually set tracking info for each submodule.
    +
    +    [1]: https://lore.kernel.org/git/20180927221603.148025-1-sbeller@google.com/
     
     
    + ## Documentation/config/branch.txt ##
    +@@ Documentation/config/branch.txt: branch.autoSetupMerge::
    + 	automatic setup is done; `true` -- automatic setup is done when the
    + 	starting point is a remote-tracking branch; `always` --
    + 	automatic setup is done when the starting point is either a
    +-	local branch or remote-tracking
    ++	local branch or remote-tracking branch; `inherit` -- if the starting point
    ++	has a tracking configuration, it is copied to the new
    + 	branch. This option defaults to true.
    + 
    + branch.autoSetupRebase::
    +
    + ## Documentation/git-branch.txt ##
    +@@ Documentation/git-branch.txt: This behavior is the default when the start point is a remote-tracking branch.
    + Set the branch.autoSetupMerge configuration variable to `false` if you
    + want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
    + were given. Set it to `always` if you want this behavior when the
    +-start-point is either a local or remote-tracking branch.
    ++start-point is either a local or remote-tracking branch. Set it to
    ++`inherit` if you want to copy the tracking configuration from the
    ++start point.
    + 
    + --no-track::
    + 	Do not set up "upstream" configuration, even if the
    +
      ## branch.c ##
     @@ branch.c: int install_branch_config(int flag, const char *local, const char *origin, const
      	return -1;
    @@ config.c: static int git_default_branch_config(const char *var, const char *valu
      		}
      		git_branch_track = git_config_bool(var, value);
      		return 0;
    +
    + ## t/t2017-checkout-orphan.sh ##
    +@@ t/t2017-checkout-orphan.sh: test_expect_success '--orphan ignores branch.autosetupmerge' '
    + 	git checkout --orphan gamma &&
    + 	test -z "$(git config branch.gamma.merge)" &&
    + 	test refs/heads/gamma = "$(git symbolic-ref HEAD)" &&
    ++	test_must_fail git rev-parse --verify HEAD^ &&
    ++	git checkout main &&
    ++	git config branch.autosetupmerge inherit &&
    ++	git checkout --orphan eta &&
    ++	test -z "$(git config branch.eta.merge)" &&
    ++	test -z "$(git config branch.eta.remote)" &&
    ++	test refs/heads/eta = "$(git symbolic-ref HEAD)" &&
    + 	test_must_fail git rev-parse --verify HEAD^
    + '
    + 
    +
    + ## t/t2027-checkout-track.sh ##
    +@@ t/t2027-checkout-track.sh: test_expect_success 'checkout --track -b rejects an extra path argument' '
    + 	test_i18ngrep "cannot be used with updating paths" err
    + '
    + 
    ++test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
    ++	# Set up tracking config on main
    ++	git config branch.main.remote origin &&
    ++	git config branch.main.merge refs/heads/main &&
    ++	test_config branch.autoSetupMerge inherit &&
    ++	# With branch.autoSetupMerge=inherit, we copy the tracking config
    ++	git checkout -b b1 main &&
    ++	test_cmp_config origin branch.b1.remote &&
    ++	test_cmp_config refs/heads/main branch.b1.merge &&
    ++	# But --track overrides this
    ++	git checkout --track -b b2 main &&
    ++	test_cmp_config . branch.b2.remote &&
    ++	test_cmp_config refs/heads/main branch.b2.merge
    ++'
    ++
    + test_done
    +
    + ## t/t2060-switch.sh ##
    +@@ t/t2060-switch.sh: test_expect_success 'not switching when something is in progress' '
    + 	test_must_fail git switch -d @^
    + '
    + 
    ++test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
    ++	# default config does not copy tracking info
    ++	git switch -c foo-no-inherit foo &&
    ++	test -z "$(git config branch.foo-no-inherit.remote)" &&
    ++	test -z "$(git config branch.foo-no-inherit.merge)" &&
    ++	# with autoSetupMerge=inherit, we copy tracking info from foo
    ++	test_config branch.autoSetupMerge inherit &&
    ++	git switch -c foo2 foo &&
    ++	test_cmp_config origin branch.foo2.remote &&
    ++	test_cmp_config refs/heads/foo branch.foo2.merge &&
    ++	# no tracking info to inherit from main
    ++	git switch -c main2 main &&
    ++	test -z "$(git config branch.main2.remote)" &&
    ++	test -z "$(git config branch.main2.merge)"
    ++'
    ++
    + test_done
    +
    + ## t/t3200-branch.sh ##
    +@@ t/t3200-branch.sh: test_expect_success 'invalid sort parameter in configuration' '
    + 	)
    + '
    + 
    ++test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
    ++	test_unconfig branch.autoSetupMerge &&
    ++	# default config does not copy tracking info
    ++	git branch foo-no-inherit my1 &&
    ++	test -z "$(git config branch.foo-no-inherit.remote)" &&
    ++	test -z "$(git config branch.foo-no-inherit.merge)" &&
    ++	# with autoSetupMerge=inherit, we copy tracking info from my1
    ++	test_config branch.autoSetupMerge inherit &&
    ++	git branch foo2 my1 &&
    ++	test_cmp_config local branch.foo2.remote &&
    ++	test_cmp_config refs/heads/main branch.foo2.merge &&
    ++	# no tracking info to inherit from main
    ++	git branch main2 main &&
    ++	test -z "$(git config branch.main2.remote)" &&
    ++	test -z "$(git config branch.main2.merge)"
    ++'
    ++
    + test_done
    +
    + ## t/t7201-co.sh ##
    +@@ t/t7201-co.sh: test_expect_success 'custom merge driver with checkout -m' '
    + 	test_cmp expect arm
    + '
    + 
    ++test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
    ++	git reset --hard main &&
    ++	# default config does not copy tracking info
    ++	git checkout -b foo-no-inherit koala/bear &&
    ++	test -z "$(git config branch.foo-no-inherit.remote)" &&
    ++	test -z "$(git config branch.foo-no-inherit.merge)" &&
    ++	# with autoSetupMerge=inherit, we copy tracking info from koala/bear
    ++	test_config branch.autoSetupMerge inherit &&
    ++	git checkout -b foo koala/bear &&
    ++	test_cmp_config origin branch.foo.remote &&
    ++	test_cmp_config refs/heads/koala/bear branch.foo.merge &&
    ++	# no tracking info to inherit from main
    ++	git checkout -b main2 main &&
    ++	test -z "$(git config branch.main2.remote)" &&
    ++	test -z "$(git config branch.main2.merge)"
    ++'
    ++
    + test_done

 Documentation/config/branch.txt |  3 ++-
 Documentation/git-branch.txt    |  4 +++-
 branch.c                        | 36 ++++++++++++++++++++++++++++++++-
 branch.h                        |  3 ++-
 config.c                        |  3 +++
 t/t2017-checkout-orphan.sh      |  7 +++++++
 t/t2027-checkout-track.sh       | 15 ++++++++++++++
 t/t2060-switch.sh               | 16 +++++++++++++++
 t/t3200-branch.sh               | 17 ++++++++++++++++
 t/t7201-co.sh                   | 17 ++++++++++++++++
 10 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..55f7522e12 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -7,7 +7,8 @@ branch.autoSetupMerge::
 	automatic setup is done; `true` -- automatic setup is done when the
 	starting point is a remote-tracking branch; `always` --
 	automatic setup is done when the starting point is either a
-	local branch or remote-tracking
+	local branch or remote-tracking branch; `inherit` -- if the starting point
+	has a tracking configuration, it is copied to the new
 	branch. This option defaults to true.
 
 branch.autoSetupRebase::
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..81e901b8e8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -218,7 +218,9 @@ This behavior is the default when the start point is a remote-tracking branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
 want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
 were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote-tracking branch.
+start-point is either a local or remote-tracking branch. Set it to
+`inherit` if you want to copy the tracking configuration from the
+start point.
 
 --no-track::
 	Do not set up "upstream" configuration, even if the
diff --git a/branch.c b/branch.c
index 7a88a4861e..17d4cc5128 100644
--- a/branch.c
+++ b/branch.c
@@ -126,6 +126,38 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	return -1;
 }
 
+static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
+{
+	struct strbuf key = STRBUF_INIT;
+	char *remote;
+	const char *bare_ref;
+
+	bare_ref = orig_ref;
+	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
+
+	strbuf_addf(&key, "branch.%s.remote", bare_ref);
+	if (git_config_get_string(key.buf, &remote)) {
+		warning("branch.autoSetupMerge=inherit, but could not find %s",
+			key.buf);
+		strbuf_release(&key);
+		return 1;
+	}
+	tracking->remote = remote;
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.merge", bare_ref);
+	if (git_config_get_string(key.buf, &tracking->src)) {
+		warning("branch.autoSetupMerge=inherit, but could not find %s",
+			key.buf);
+		strbuf_release(&key);
+		return 1;
+	}
+
+	tracking->matches = 1;
+	strbuf_release(&key);
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -139,7 +171,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking))
+	if (track == BRANCH_TRACK_INHERIT && inherit_tracking(&tracking, orig_ref))
+		return;
+	else if (for_each_remote(find_tracked_branch, &tracking))
 		return;
 
 	if (!tracking.matches)
diff --git a/branch.h b/branch.h
index df0be61506..6484bda8a2 100644
--- a/branch.h
+++ b/branch.h
@@ -10,7 +10,8 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE
+	BRANCH_TRACK_OVERRIDE,
+	BRANCH_TRACK_INHERIT
 };
 
 extern enum branch_track git_branch_track;
diff --git a/config.c b/config.c
index cb4a8058bf..4bd5a18faf 100644
--- a/config.c
+++ b/config.c
@@ -1580,6 +1580,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		if (value && !strcasecmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
+		} else if (value && !strcasecmp(value, "inherit")) {
+			git_branch_track = BRANCH_TRACK_INHERIT;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 88d6992a5e..31fb64c5be 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -64,6 +64,13 @@ test_expect_success '--orphan ignores branch.autosetupmerge' '
 	git checkout --orphan gamma &&
 	test -z "$(git config branch.gamma.merge)" &&
 	test refs/heads/gamma = "$(git symbolic-ref HEAD)" &&
+	test_must_fail git rev-parse --verify HEAD^ &&
+	git checkout main &&
+	git config branch.autosetupmerge inherit &&
+	git checkout --orphan eta &&
+	test -z "$(git config branch.eta.merge)" &&
+	test -z "$(git config branch.eta.remote)" &&
+	test refs/heads/eta = "$(git symbolic-ref HEAD)" &&
 	test_must_fail git rev-parse --verify HEAD^
 '
 
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index 4453741b96..4805965872 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -24,4 +24,19 @@ test_expect_success 'checkout --track -b rejects an extra path argument' '
 	test_i18ngrep "cannot be used with updating paths" err
 '
 
+test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
+	# Set up tracking config on main
+	git config branch.main.remote origin &&
+	git config branch.main.merge refs/heads/main &&
+	test_config branch.autoSetupMerge inherit &&
+	# With branch.autoSetupMerge=inherit, we copy the tracking config
+	git checkout -b b1 main &&
+	test_cmp_config origin branch.b1.remote &&
+	test_cmp_config refs/heads/main branch.b1.merge &&
+	# But --track overrides this
+	git checkout --track -b b2 main &&
+	test_cmp_config . branch.b2.remote &&
+	test_cmp_config refs/heads/main branch.b2.merge
+'
+
 test_done
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 9bc6a3aa5c..f9972e2841 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -107,4 +107,20 @@ test_expect_success 'not switching when something is in progress' '
 	test_must_fail git switch -d @^
 '
 
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	# default config does not copy tracking info
+	git switch -c foo-no-inherit foo &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with autoSetupMerge=inherit, we copy tracking info from foo
+	test_config branch.autoSetupMerge inherit &&
+	git switch -c foo2 foo &&
+	test_cmp_config origin branch.foo2.remote &&
+	test_cmp_config refs/heads/foo branch.foo2.merge &&
+	# no tracking info to inherit from main
+	git switch -c main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..8005a5ccc6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1409,4 +1409,21 @@ test_expect_success 'invalid sort parameter in configuration' '
 	)
 '
 
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	test_unconfig branch.autoSetupMerge &&
+	# default config does not copy tracking info
+	git branch foo-no-inherit my1 &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with autoSetupMerge=inherit, we copy tracking info from my1
+	test_config branch.autoSetupMerge inherit &&
+	git branch foo2 my1 &&
+	test_cmp_config local branch.foo2.remote &&
+	test_cmp_config refs/heads/main branch.foo2.merge &&
+	# no tracking info to inherit from main
+	git branch main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7f6e23a4bb..ae9f8d02c2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -657,4 +657,21 @@ test_expect_success 'custom merge driver with checkout -m' '
 	test_cmp expect arm
 '
 
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	git reset --hard main &&
+	# default config does not copy tracking info
+	git checkout -b foo-no-inherit koala/bear &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with autoSetupMerge=inherit, we copy tracking info from koala/bear
+	test_config branch.autoSetupMerge inherit &&
+	git checkout -b foo koala/bear &&
+	test_cmp_config origin branch.foo.remote &&
+	test_cmp_config refs/heads/koala/bear branch.foo.merge &&
+	# no tracking info to inherit from main
+	git checkout -b main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
 test_done
-- 
2.33.0.309.g3052b89438-goog

