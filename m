Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA81C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 07:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiB1HPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiB1HPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 02:15:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082F38BC4
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:14:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so5190433wmj.0
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZNu7dZY1xWeGS5CZCm814JP+Tl8wZ0RkLtQo4rOAJs4=;
        b=TO+l4ZMVJzZzkuuh9eDUPCvcNYYhTVHwKJj7/FQgTBs6frlwgd0Kc/bYlprSFZCF1t
         Xs6uz7Ckmp1Nu0Mmm6x9bAozAlaSgf6KNQbFlz3BcRjwGIp1/ndC9Ec5fJofSRr8W4Et
         m2Tf6X7l2IXn0I3TgkeVOs3jkj61Nd9HvApXpQL9CKGCuTxAiT7P65rNsARgdq958dN9
         dYOg9iLdlBtiu2e/Jw6CRIPi0q8J1Vz0R3hJN7Su8keDwIyZzLuxmj8KZqI3LKhQLQ14
         0/yntu39USuj/mmWTxmTYC5Bc7EmgNNHOG+yWwehrN5dDzDUIhfUlBW2WgyWK2Cj7Rxy
         Yscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZNu7dZY1xWeGS5CZCm814JP+Tl8wZ0RkLtQo4rOAJs4=;
        b=tgp7bt0HhKqpbLDX4j4WhzPVujSVJhwWmeF/PINmP043IkmjfD3L0KnFSwIP7dpQ/y
         ELRwYYnkQQlxhj7HfFrQU03/zatYQiWDovtugaPtEqTeYbn9q/c1e86H9I1HqDd3BYFL
         DBi2cmIRf+gtiHS01Yr+fsWG2xGPIaTcBY+1QmWJbjmjDzw8cpyrlScwPVwDFR18e+Ce
         9WrKJtJZMeFmvXv/S8JeYl1i2EasQjLwoj4lMw1HmKpY2qve/hsqz2h9PltSu4UY/QWJ
         NIzmdC9gTA49WNYFORvAn0jw4dJcfp9ehc8xoBe+cCB9Bt2fPeWdYYJqpEyH2Lm+lEw+
         ZD/g==
X-Gm-Message-State: AOAM530BApp49FOFB2uGfo186TiFiSeCqOkiuOgGyiHmc7yCcuXo1WI7
        Iet73jRApiI9+BuX61hy4rc7LlIc2PE=
X-Google-Smtp-Source: ABdhPJx9DyVqGuwveTO/RfmL1x9CNR9NKhbNufEFViZAAUJ3iAZEff8Twhr2y1wUnHFo1sJBEzoDXQ==
X-Received: by 2002:a05:600c:3546:b0:381:7a9d:eee2 with SMTP id i6-20020a05600c354600b003817a9deee2mr679838wmq.24.1646032469257;
        Sun, 27 Feb 2022 23:14:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b001ef57f562ccsm9823876wrn.51.2022.02.27.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:14:28 -0800 (PST)
Message-Id: <0b5d47895120539d6a72a91398f33a0e33df7cd5.1646032466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
        <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 07:14:25 +0000
Subject: [PATCH v3 1/2] merge: new autosetupmerge option 'simple' for matching
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
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
a user branches to a new local feature branch from an existing
upstream branch, eg with "checkout -b feature1 origin/master". With
the default branch.autosetupmerge configuration (value "true"), git
will automatically add origin/master as the remote tracking branch.

When the user pushes with "git push", they get an error, and (amongst
other things) a suggestion to run "git push origin HEAD". Eventually
they figure out to add "-u" to change the tracking branch, or they set
push.default to "current", or some tooling does one or the other of
these things for them.

When one of their coworkers works on the same branch, they don't get
any of that weirdness. They just "git checkout feature1" and
everything works exactly as they expect, with the shared remote branch
set up as remote tracking branch, and push and pull working out of the
box.

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

Any experienced git user will presumably say "well yeah, that's what
it means to have the remote tracking branch set to origin/master!" -
but that user didn't *ask* to have the remote master branch added as
remote tracking branch - that just happened automatically when they
branched their feature branch. They didn't necessarily even notice or
understand the meaning of the "set up to track 'origin/master'"
message when they created the branch - especially if they are using a
GUI.

Looking at how to fix this, you might think "OK, so disable auto setup
of remote tracking - set branch.autosetupmerge to false" - but that
will inconvenience the *second* user in this story - the one who just
wanted to start working on the feature branch. The first and second
users swap roles at different points in time of course - they should
both have a sane configuration that does the right thing in both
situations.

Make these flows painless by introducing a new branch.autosetupmerge
option called "simple", to match the same-name "push.default" option
that makes similar assumptions.

This new option automatically sets up tracking in a *subset* of the
current default situations: when the original ref is a remote tracking
branch *and* has the same branch name on the remote (as the new local
branch name).

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

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 Documentation/config/branch.txt |  4 +++-
 Documentation/git-branch.txt    | 18 +++++++++++-------
 branch.c                        | 19 +++++++++++++++++++
 branch.h                        |  1 +
 config.c                        |  3 +++
 5 files changed, 37 insertions(+), 8 deletions(-)

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
index 6b31df539a5..81613ade8bf 100644
--- a/branch.c
+++ b/branch.c
@@ -252,10 +252,29 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			goto cleanup;
 		}
 
+	/*
+	 * This check does not apply to the BRANCH_TRACK_INHERIT
+	 * option; you can inherit one or more tracking entries
+	 * and the tracking.matches counter is not incremented.
+	 */
 	if (tracking.matches > 1)
 		die(_("not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
+	if (track == BRANCH_TRACK_SIMPLE) {
+		/*
+		 * Only track if remote branch name matches.
+		 * Reaching into items[0].string is safe because
+		 * we know there is at least one and not more than
+		 * one entry (because not BRANCH_TRACK_INHERIT).
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
diff --git a/config.c b/config.c
index e0c03d154c9..cc586ac816c 100644
--- a/config.c
+++ b/config.c
@@ -1673,6 +1673,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		} else if (value && !strcmp(value, "inherit")) {
 			git_branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
+		} else if (value && !strcmp(value, "simple")) {
+			git_branch_track = BRANCH_TRACK_SIMPLE;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
-- 
gitgitgadget

