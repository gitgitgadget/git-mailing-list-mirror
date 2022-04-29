Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1273C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 09:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357157AbiD2KAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357135AbiD2KAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 06:00:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0661A45059
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e24so10050689wrc.9
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aEQZs1LrNlUjnojn61Xpx+bfSR6yPe5q/LVV/LYDMi4=;
        b=TY2jgDpT3DAzDyjozKjYCQ+ahY1RKfp4A4m1qexxINLn0Mue/t6kj+L6HhZbyF/Ukt
         UyqGIr4i0yfKxm8vDG1N+IwdKvYzS0I8HNVmGDnOVeySs16X2cUoAwuLhhlidqa+gVgb
         uV1G3PLra/4yAXz7RAwzSg2j1rTDOfAJ16GT+ti4v/t1/QtP6XKX67rlqRzqoWrnd/45
         BpDiIA3kr328dlMdphR3g/xuPnAFmJKxTzfWtGFr9iAQxLzIsD87MLWAOmYlm8gC53DV
         B6A1Y6eIugoI5hA6Jn/S1Llgdq0wWuWndi6TYrAH0b33edXm499LooUCcDu7A0J/PibI
         wQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aEQZs1LrNlUjnojn61Xpx+bfSR6yPe5q/LVV/LYDMi4=;
        b=MlxTEmPBETtD7pTnnVwAc9SZ3mpOGxNiOA3hFtgiYFDG9kzLzeLtOEcCHmt65IkP+q
         D8FrvtxFr5ZOGAeNH9sQIV5oF3WrqQrND/PUQxlKwbKusSPCdG/nYWRtOLLZ1grilvxQ
         Rnylud8S4YiEBFvu2Dy9GqKQ0rmJpufQ7kTaAcCLcs39s6CDaKY5CWV0Afhg9F/eJxie
         XXohz2Mm/sOsYztnMvwPv+QTM8zku4+GeQ7VJTle+6QE1sriX/2oEFk/DLma7tUnV8Lh
         E059fTnJSddqDJPM3CGzvZiaXXy/kjOIR3BofMrdMlxIVWfdyrK7XRHEhynZTWTbut4H
         2Aig==
X-Gm-Message-State: AOAM532jGYs/si+XdHxIKeKRbvQAcd8JRqqztzoruL1zxWNpXpW9kEZZ
        iCcWjNBSJ1TOOJW9qNpSgq2cakY1Emk=
X-Google-Smtp-Source: ABdhPJx384QIeiT0r8l51ojNHh/AUf5vfw8ssWhtTYtvDPVLHq+x0u8OImUZT4JZYZ/g1DIAJsxZRQ==
X-Received: by 2002:a5d:64eb:0:b0:20a:ecf8:ac9f with SMTP id g11-20020a5d64eb000000b0020aecf8ac9fmr10654673wri.342.1651226209725;
        Fri, 29 Apr 2022 02:56:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12-20020a056000178c00b0020aaf8d351bsm1930708wrg.103.2022.04.29.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:56:49 -0700 (PDT)
Message-Id: <5b08edcdeefdaf2bd7bbc111bec82281b2f2b313.1651226207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
References: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
        <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Apr 2022 09:56:44 +0000
Subject: [PATCH v5 1/3] branch: new autosetupmerge option 'simple' for
 matching branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

With the default push.default option, "simple", beginners are
protected from accidentally pushing to the "wrong" branch in
centralized workflows: if the remote tracking branch they would push
to does not have the same name as the local branch, and they try to do
a "default push", they get an error and explanation with options.

There is a particular centralized workflow where this often happens:
a user branches to a new local topic branch from an existing
remote branch, eg with "checkout -b feature1 origin/master". With
the default branch.autosetupmerge configuration (value "true"), git
will automatically add origin/master as the upstream tracking branch.

When the user pushes with a default "git push", with the intention of
pushing their (new) topic branch to the remote, they get an error, and
(amongst other things) a suggestion to run "git push origin HEAD".

If they follow this suggestion the push succeeds, but on subsequent
default pushes they continue to get an error - so eventually they
figure out to add "-u" to change the tracking branch, or they spelunk
the push.default config doc as proposed and set it to "current", or
some GUI tooling does one or the other of these things for them.

When one of their coworkers later works on the same topic branch,
they don't get any of that "weirdness". They just "git checkout
feature1" and everything works exactly as they expect, with the shared
remote branch set up as remote tracking branch, and push and pull
working out of the box.

The "stable state" for this way of working is that local branches have
the same-name remote tracking branch (origin/feature1 in this
example), and multiple people can work on that remote feature branch
at the same time, trusting "git pull" to merge or rebase as required
for them to be able to push their interim changes to that same feature
branch on that same remote.

(merging from the upstream "master" branch, and merging back to it,
are separate more involved processes in this flow).

There is a problem in this flow/way of working, however, which is that
the first user, when they first branched from origin/master, ended up
with the "wrong" remote tracking branch (different from the stable
state). For a while, before they pushed (and maybe longer, if they
don't use -u/--set-upstream), their "git pull" wasn't getting other
users' changes to the feature branch - it was getting any changes from
the remote "master" branch instead (a completely different class of
changes!)

An experienced git user might say "well yeah, that's what it means to
have the remote tracking branch set to origin/master!" - but the
original user above didn't *ask* to have the remote master branch
added as remote tracking branch - that just happened automatically
when they branched their feature branch. They didn't necessarily even
notice or understand the meaning of the "set up to track 'origin/master'"
message when they created the branch - especially if they are using a
GUI.

Looking at how to fix this, you might think "OK, so disable auto setup
of remote tracking - set branch.autosetupmerge to false" - but that
will inconvenience the *second* user in this story - the one who just
wanted to start working on the topic branch. The first and second
users swap roles at different points in time of course - they should
both have a sane configuration that does the right thing in both
situations.

Make this "branches have the same name locally as on the remote"
workflow less painful / more obvious by introducing a new
branch.autosetupmerge option called "simple", to match the same-name
"push.default" option that makes similar assumptions.

This new option automatically sets up tracking in a *subset* of the
current default situations: when the original ref is a remote tracking
branch *and* has the same branch name on the remote (as the new local
branch name).

Update the error displayed when the 'push.default=simple' configuration
rejects a mismatching-upstream-name default push, to offer this new
branch.autosetupmerge option that will prevent this class of error.

With this new configuration, in the example situation above, the first
user does *not* get origin/master set up as the tracking branch for
the new local branch. If they "git pull" in their new local-only
branch, they get an error explaining there is no upstream branch -
which makes sense and is helpful. If they "git push", they get an
error explaining how to push *and* suggesting they specify
--set-upstream - which is exactly the right thing to do for them.

This new option is likely not appropriate for users intentionally
implementing a "triangular workflow" with a shared upstream tracking
branch, that they "git pull" in and a "private" feature branch that
they push/force-push to just for remote safe-keeping until they are
ready to push up to the shared branch explicitly/separately. Such
users are likely to prefer keeping the current default
merge.autosetupmerge=true behavior, and change their push.default to
"current".

Also extend the existing branch tests with three new cases testing
this option - the obvious matching-name and non-matching-name cases,
and also a non-matching-ref-type case. The matching-name case needs to
temporarily create an independent repo to fetch from, as the general
strategy of using the local repo as the remote in these tests
precludes locally branching with the same name as in the "remote".

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 Documentation/config/branch.txt |  4 +++-
 Documentation/git-branch.txt    | 18 ++++++++++-------
 branch.c                        | 27 ++++++++++++++++++++++++-
 branch.h                        |  1 +
 builtin/push.c                  | 20 ++++++++++++++-----
 config.c                        |  3 +++
 t/t3200-branch.sh               | 35 +++++++++++++++++++++++++++++++++
 7 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 1e0c7af014b..8df10d07129 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -9,7 +9,9 @@ branch.autoSetupMerge::
 	automatic setup is done when the starting point is either a
 	local branch or remote-tracking branch; `inherit` -- if the starting point
 	has a tracking configuration, it is copied to the new
-	branch. This option defaults to true.
+	branch; `simple` -- automatic setup is done only when the starting point
+	is a remote-tracking branch and the new branch has the same name as the
+	remote branch. This option defaults to true.
 
 branch.autoSetupRebase::
 	When a new branch is created with 'git branch', 'git switch' or 'git checkout'
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c8b4f9ce3c7..ae82378349d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -221,13 +221,17 @@ The exact upstream branch is chosen depending on the optional argument:
 itself as the upstream; `--track=inherit` means to copy the upstream
 configuration of the start-point branch.
 +
-`--track=direct` is the default when the start point is a remote-tracking branch.
-Set the branch.autoSetupMerge configuration variable to `false` if you
-want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
-were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote-tracking branch. Set it to
-`inherit` if you want to copy the tracking configuration from the
-branch point.
+The branch.autoSetupMerge configuration variable specifies how `git switch`,
+`git checkout` and `git branch` should behave when neither `--track` nor
+`--no-track` are specified:
++
+The default option, `true`, behaves as though `--track=direct`
+were given whenever the start-point is a remote-tracking branch.
+`false` behaves as if `--no-track` were given. `always` behaves as though
+`--track=direct` were given. `inherit` behaves as though `--track=inherit`
+were given. `simple` behaves as though `--track=direct` were given only when
+the start-point is a remote-tracking branch and the new branch has the same
+name as the remote branch.
 +
 See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
 how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
diff --git a/branch.c b/branch.c
index 01ecb816d5c..962aa7c8609 100644
--- a/branch.c
+++ b/branch.c
@@ -44,9 +44,9 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			string_list_clear(tracking->srcs, 0);
 		break;
 		}
+		/* remote_find_tracking() searches by src if present */
 		tracking->spec.src = NULL;
 	}
-
 	return 0;
 }
 
@@ -264,15 +264,23 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 	if (!tracking.matches)
 		switch (track) {
+		/* If ref is not remote, still use local */
 		case BRANCH_TRACK_ALWAYS:
 		case BRANCH_TRACK_EXPLICIT:
 		case BRANCH_TRACK_OVERRIDE:
+		/* Remote matches not evaluated */
 		case BRANCH_TRACK_INHERIT:
 			break;
+		/* Otherwise, if no remote don't track */
 		default:
 			goto cleanup;
 		}
 
+	/*
+	 * This check does not apply to BRANCH_TRACK_INHERIT;
+	 * that supports multiple entries in tracking_srcs but
+	 * leaves tracking.matches at 0.
+	 */
 	if (tracking.matches > 1) {
 		int status = die_message(_("not tracking: ambiguous information for ref '%s'"),
 					    orig_ref);
@@ -307,6 +315,21 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		exit(status);
 	}
 
+	if (track == BRANCH_TRACK_SIMPLE) {
+		/*
+		 * Only track if remote branch name matches.
+		 * Reaching into items[0].string is safe because
+		 * we know there is at least one and not more than
+		 * one entry (because only BRANCH_TRACK_INHERIT can
+		 * produce more than one entry).
+		 */
+		const char *tracked_branch;
+		if (!skip_prefix(tracking.srcs->items[0].string,
+				 "refs/heads/", &tracked_branch) ||
+		    strcmp(tracked_branch, new_ref))
+			return;
+	}
+
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
@@ -603,6 +626,8 @@ static int submodule_create_branch(struct repository *r,
 		/* Default for "git checkout". Do not pass --track. */
 	case BRANCH_TRACK_REMOTE:
 		/* Default for "git branch". Do not pass --track. */
+	case BRANCH_TRACK_SIMPLE:
+		/* Config-driven only. Do not pass --track. */
 		break;
 	}
 
diff --git a/branch.h b/branch.h
index 04df2aa5b51..560b6b96a8f 100644
--- a/branch.h
+++ b/branch.h
@@ -12,6 +12,7 @@ enum branch_track {
 	BRANCH_TRACK_EXPLICIT,
 	BRANCH_TRACK_OVERRIDE,
 	BRANCH_TRACK_INHERIT,
+	BRANCH_TRACK_SIMPLE,
 };
 
 extern enum branch_track git_branch_track;
diff --git a/builtin/push.c b/builtin/push.c
index cad997965a7..447f91f5b47 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -2,6 +2,7 @@
  * "git push"
  */
 #include "cache.h"
+#include "branch.h"
 #include "config.h"
 #include "refs.h"
 #include "refspec.h"
@@ -151,7 +152,8 @@ static NORETURN void die_push_simple(struct branch *branch,
 	 * upstream to a non-branch, we should probably be showing
 	 * them the big ugly fully qualified ref.
 	 */
-	const char *advice_maybe = "";
+	const char *advice_pushdefault_maybe = "";
+	const char *advice_automergesimple_maybe = "";
 	const char *short_upstream = branch->merge[0]->src;
 
 	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
@@ -161,9 +163,16 @@ static NORETURN void die_push_simple(struct branch *branch,
 	 * push.default.
 	 */
 	if (push_default == PUSH_DEFAULT_UNSPECIFIED)
-		advice_maybe = _("\n"
+		advice_pushdefault_maybe = _("\n"
 				 "To choose either option permanently, "
-				 "see push.default in 'git help config'.");
+				 "see push.default in 'git help config'.\n");
+	if (git_branch_track != BRANCH_TRACK_SIMPLE)
+		advice_automergesimple_maybe = _("\n"
+				 "To avoid automatically configuring "
+				 "upstream branches when their name\n"
+				 "doesn't match the local branch, see option "
+				 "'simple' of branch.autosetupmerge\n"
+				 "in 'git help config'.\n");
 	die(_("The upstream branch of your current branch does not match\n"
 	      "the name of your current branch.  To push to the upstream branch\n"
 	      "on the remote, use\n"
@@ -173,9 +182,10 @@ static NORETURN void die_push_simple(struct branch *branch,
 	      "To push to the branch of the same name on the remote, use\n"
 	      "\n"
 	      "    git push %s HEAD\n"
-	      "%s"),
+	      "%s%s"),
 	    remote->name, short_upstream,
-	    remote->name, advice_maybe);
+	    remote->name, advice_pushdefault_maybe,
+	    advice_automergesimple_maybe);
 }
 
 static const char message_detached_head_die[] =
diff --git a/config.c b/config.c
index a5e11aad7fe..8dbeb1932e5 100644
--- a/config.c
+++ b/config.c
@@ -1781,6 +1781,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		} else if (value && !strcmp(value, "inherit")) {
 			git_branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
+		} else if (value && !strcmp(value, "simple")) {
+			git_branch_track = BRANCH_TRACK_SIMPLE;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e12db593615..9723c2827cc 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -886,6 +886,41 @@ test_expect_success 'branch from tag w/--track causes failure' '
 	test_must_fail git branch --track my11 foobar
 '
 
+test_expect_success 'simple tracking works when remote branch name matches' '
+	test_when_finished "rm -rf otherserver" &&
+	git init otherserver &&
+	test_commit -C otherserver my_commit 1 &&
+	git -C otherserver branch feature &&
+	test_config branch.autosetupmerge simple &&
+	test_config remote.otherserver.url otherserver &&
+	test_config remote.otherserver.fetch refs/heads/*:refs/remotes/otherserver/* &&
+	git fetch otherserver &&
+	git branch feature otherserver/feature &&
+	test_cmp_config otherserver branch.feature.remote &&
+	test_cmp_config refs/heads/feature branch.feature.merge
+'
+
+test_expect_success 'simple tracking skips when remote branch name does not match' '
+	test_config branch.autosetupmerge simple &&
+	test_config remote.local.url . &&
+	test_config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git fetch local &&
+	git branch my-other local/main &&
+	test_cmp_config "" --default "" branch.my-other.remote &&
+	test_cmp_config "" --default "" branch.my-other.merge
+'
+
+test_expect_success 'simple tracking skips when remote ref is not a branch' '
+	test_config branch.autosetupmerge simple &&
+	test_config remote.localtags.url . &&
+	test_config remote.localtags.fetch refs/tags/*:refs/remotes/localtags/* &&
+	git tag mytag12 main &&
+	git fetch localtags &&
+	git branch mytag12 localtags/mytag12 &&
+	test_cmp_config "" --default "" branch.mytag12.remote &&
+	test_cmp_config "" --default "" branch.mytag12.merge
+'
+
 test_expect_success '--set-upstream-to fails on multiple branches' '
 	echo "fatal: too many arguments to set new upstream" >expect &&
 	test_must_fail git branch --set-upstream-to main a b c 2>err &&
-- 
gitgitgadget

