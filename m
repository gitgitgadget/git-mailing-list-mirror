Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561D2C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 03:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhLUDad (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhLUDad (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 22:30:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852DC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so23503564ybe.8
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+vn0j67gPeUBa6LPemVTfRHRGOJIpC/uXzfU737Gxc0=;
        b=aWqZitbbv9Ozd/cduAmn5/wd6UaATmir9zK5NAPVnIqxXnrYcefowA0yD0xoJPVmdX
         nddvb6if53t/lNkIbHZ+At5MUaxTudmNRehbw7o4WI57skQTWKIjWFXw/4hP5l8fImZf
         /boj8ObirOYOuOM+yi0674Hv9MyOlWq5kNKPo6EaKYgzyIiUfeN+9nUZ0KNyQ32A1pOc
         Ezh0xki77w6DQ6EyPUNbSWjfsTRWrknqTtaDLrQoau/KNyG+XulqG9UVlakKzyfiuVC9
         5C/qoqHNGpz1Nh1P0mWDwvkBHGCd8ykAR6vABB8GjOab60YDBZNVLRGc88XMMi+wwFCv
         VoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+vn0j67gPeUBa6LPemVTfRHRGOJIpC/uXzfU737Gxc0=;
        b=ALoLXE0nQYG1yoB2Y+pur9dyvN9QR4wzs1k7k7DnodW3AxCZ0dWB7JIH2hj30U2i5r
         n5tZQWSlfQC55FDFtEaD7RkcZIObGXD43/88Hhx7cs83pk3u7qB2dWz90y3fetcqs+bT
         QF4+Lbstd17TP4dYfJcvsSXTPgYtqQ62fvSGkcPS7V8aJVBQ1Yw4hATeLfBBT2hX8VfG
         RVoeq6YSiD7ABlrM9eBzUoaigZQ0yQLMhE8dpQ1S1WEcOfDrtycsHusUUaTSWi/PQZ0N
         +ncoQwyKLlDT3BNLVbz7S068xyjSIIca1N1CZTnVZRts5Uyl2YIa/bdyxYs1YIcam4r4
         UWaA==
X-Gm-Message-State: AOAM533bMwKItpnI0q/4h7AeOHtsHRV7zI88WZOYXCxowIEA5BPh0K7o
        ohC0Q0jBxx9ASUJOEoP2MSdOe3uZ0C1kKpg5tuCKnJcedEnjwL6icbJkxdJBSHs1DT1jaONGR3X
        evzRWOlRiSCJp+EuWdLQk2Wb6clTTtRalLBhzhYXs0VREf+Na53KqXNSqElXo67M=
X-Google-Smtp-Source: ABdhPJzHObNL17yJsyQq70KOfps5MwfE8lU/H6veC+eTYbRZs2MQQRzvg6SlbHBw3cFg1blrXCoiacCf5I0w+g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:e4d8:c4fc:fa70:c18e])
 (user=steadmon job=sendgmr) by 2002:a25:c054:: with SMTP id
 c81mr1817440ybf.463.1640057431875; Mon, 20 Dec 2021 19:30:31 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:30:23 -0800
In-Reply-To: <cover.1640039978.git.steadmon@google.com>
Message-Id: <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v8 2/3] branch: add flags and config to inherit tracking
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, chooglen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be helpful when creating a new branch to use the existing
tracking configuration from the branch point. However, there is
currently not a method to automatically do so.

Teach git-{branch,checkout,switch} an "inherit" argument to the
"--track" option. When this is set, creating a new branch will cause the
tracking configuration to default to the configuration of the branch
point, if set.

For example, if branch "main" tracks "origin/main", and we run
`git checkout --track=inherit -b feature main`, then branch "feature"
will track "origin/main". Thus, `git status` will show us how far
ahead/behind we are from origin, and `git pull` will pull from origin.

This is particularly useful when creating branches across many
submodules, such as with `git submodule foreach ...` (or if running with
a patch such as [1], which we use at $job), as it avoids having to
manually set tracking info for each submodule.

Since we've added an argument to "--track", also add "--track=direct" as
another way to explicitly get the original "--track" behavior ("--track"
without an argument still works as well).

Finally, teach branch.autoSetupMerge a new "inherit" option. When this
is set, "--track=inherit" becomes the default behavior.

[1]: https://lore.kernel.org/git/20180927221603.148025-1-sbeller@google.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/config/branch.txt |  3 +-
 Documentation/git-branch.txt    | 24 +++++++++++-----
 Documentation/git-checkout.txt  |  2 +-
 Documentation/git-switch.txt    |  2 +-
 branch.c                        | 49 ++++++++++++++++++++++++++++-----
 branch.h                        |  3 +-
 builtin/branch.c                |  6 ++--
 builtin/checkout.c              |  6 ++--
 config.c                        |  3 ++
 parse-options-cb.c              | 16 +++++++++++
 parse-options.h                 |  2 ++
 t/t2017-checkout-orphan.sh      | 11 +++++++-
 t/t2027-checkout-track.sh       | 23 ++++++++++++++++
 t/t2060-switch.sh               | 28 +++++++++++++++++++
 t/t3200-branch.sh               | 33 ++++++++++++++++++++++
 t/t7201-co.sh                   | 17 ++++++++++++
 16 files changed, 205 insertions(+), 23 deletions(-)

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
index 94dc9a54f2..c8b393e51c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
+'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -205,24 +205,34 @@ This option is only applicable in non-verbose mode.
 	Display the full sha1s in the output listing rather than abbreviating them.
 
 -t::
---track::
+--track [inherit|direct]::
 	When creating a new branch, set up `branch.<name>.remote` and
-	`branch.<name>.merge` configuration entries to mark the
-	start-point branch as "upstream" from the new branch. This
+	`branch.<name>.merge` configuration entries to set "upstream" tracking
+	configuration for the new branch. This
 	configuration will tell git to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
 +
-This behavior is the default when the start point is a remote-tracking branch.
+The exact upstream branch is chosen depending on the optional argument:
+`--track` or `--track direct` means to use the start-point branch itself as the
+upstream; `--track inherit` means to copy the upstream configuration of the
+start-point branch.
++
+`--track direct` is the default when the start point is a remote-tracking branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
 want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
 were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote-tracking branch.
+start-point is either a local or remote-tracking branch. Set it to
+`inherit` if you want to copy the tracking configuration from the
+branch point.
++
+See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
+how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
 
 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autoSetupMerge configuration variable is true.
+	branch.autoSetupMerge configuration variable is set.
 
 --set-upstream::
 	As this option had confusing syntax, it is no longer supported.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe4499..a48e1ab62f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -155,7 +155,7 @@ of it").
 	linkgit:git-branch[1] for details.
 
 -t::
---track::
+--track [direct|inherit]::
 	When creating a new branch, set up "upstream" configuration. See
 	"--track" in linkgit:git-branch[1] for details.
 +
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd505..96dc036ea5 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -152,7 +152,7 @@ should result in deletion of the path).
 	attached to a terminal, regardless of `--quiet`.
 
 -t::
---track::
+--track [direct|inherit]::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
diff --git a/branch.c b/branch.c
index a41a300f9c..e28c0c86e5 100644
--- a/branch.c
+++ b/branch.c
@@ -11,7 +11,7 @@
 
 struct tracking {
 	struct refspec_item spec;
-	char *src;
+	struct string_list *srcs;
 	const char *remote;
 	int matches;
 };
@@ -22,11 +22,11 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 
 	if (!remote_find_tracking(remote, &tracking->spec)) {
 		if (++tracking->matches == 1) {
-			tracking->src = tracking->spec.src;
+			string_list_append(tracking->srcs, tracking->spec.src);
 			tracking->remote = remote->name;
 		} else {
 			free(tracking->spec.src);
-			FREE_AND_NULL(tracking->src);
+			string_list_clear(tracking->srcs, 0);
 		}
 		tracking->spec.src = NULL;
 	}
@@ -189,6 +189,34 @@ int install_branch_config(int flag, const char *local, const char *origin,
 	return ret;
 }
 
+static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
+{
+	const char *bare_ref;
+	struct branch *branch;
+	int i;
+
+	bare_ref = orig_ref;
+	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
+
+	branch = branch_get(bare_ref);
+	if (!branch->remote_name) {
+		warning(_("asked to inherit tracking from '%s', but no remote is set"),
+			bare_ref);
+		return -1;
+	}
+
+	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[0]) {
+		warning(_("asked to inherit tracking from '%s', but no merge configuration is set"),
+			bare_ref);
+		return -1;
+	}
+
+	tracking->remote = xstrdup(branch->remote_name);
+	for (i = 0; i < branch->merge_nr; i++)
+		string_list_append(tracking->srcs, branch->merge_name[i]);
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -198,11 +226,15 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			   enum branch_track track, int quiet)
 {
 	struct tracking tracking;
+	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking))
+	tracking.srcs = &tracking_srcs;
+	if (track != BRANCH_TRACK_INHERIT)
+		for_each_remote(find_tracked_branch, &tracking);
+	else if (inherit_tracking(&tracking, orig_ref))
 		return;
 
 	if (!tracking.matches)
@@ -210,6 +242,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		case BRANCH_TRACK_ALWAYS:
 		case BRANCH_TRACK_EXPLICIT:
 		case BRANCH_TRACK_OVERRIDE:
+		case BRANCH_TRACK_INHERIT:
 			break;
 		default:
 			return;
@@ -219,11 +252,13 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		die(_("Not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
-	if (install_branch_config(config_flags, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref) < 0)
+	if (tracking.srcs->nr < 1)
+		string_list_append(tracking.srcs, orig_ref);
+	if (install_branch_config_multiple_remotes(config_flags, new_ref,
+				tracking.remote, tracking.srcs) < 0)
 		exit(-1);
 
-	free(tracking.src);
+	string_list_clear(tracking.srcs, 0);
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
diff --git a/branch.h b/branch.h
index df0be61506..815dcd40c0 100644
--- a/branch.h
+++ b/branch.h
@@ -10,7 +10,8 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE
+	BRANCH_TRACK_OVERRIDE,
+	BRANCH_TRACK_INHERIT,
 };
 
 extern enum branch_track git_branch_track;
diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..ebde5023c3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&filter.verbose,
 			N_("show hash and subject, give twice for upstream branch")),
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
-		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
-			BRANCH_TRACK_EXPLICIT),
+		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
+			N_("set branch tracking configuration"),
+			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			parse_opt_tracking_mode),
 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
 			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a..45dab414ea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1532,8 +1532,10 @@ static struct option *add_common_switch_branch_options(
 {
 	struct option options[] = {
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
-		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
-			BRANCH_TRACK_EXPLICIT),
+		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
+			N_("set up tracking mode (see git-pull(1))"),
+			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			parse_opt_tracking_mode),
 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
diff --git a/config.c b/config.c
index cb4a8058bf..152c94f29d 100644
--- a/config.c
+++ b/config.c
@@ -1580,6 +1580,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		if (value && !strcasecmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
+		} else if (value && !strcmp(value, "inherit")) {
+			git_branch_track = BRANCH_TRACK_INHERIT;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 3c811e1e4a..d346dbe210 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
+#include "branch.h"
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
@@ -293,3 +294,18 @@ int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset
 
 	return 0;
 }
+
+int parse_opt_tracking_mode(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		*(enum branch_track *)opt->value = BRANCH_TRACK_NEVER;
+	else if (!arg || !strcmp(arg, "direct"))
+		*(enum branch_track *)opt->value = BRANCH_TRACK_EXPLICIT;
+	else if (!strcmp(arg, "inherit"))
+		*(enum branch_track *)opt->value = BRANCH_TRACK_INHERIT;
+	else
+		return error(_("option `%s' expects \"%s\" or \"%s\""),
+			     "--track", "direct", "inherit");
+
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index a845a9d952..f35dbfdd5a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -303,6 +303,8 @@ enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
+/* value is enum branch_track* */
+int parse_opt_tracking_mode(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 88d6992a5e..4d689bd377 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -62,8 +62,17 @@ test_expect_success '--orphan ignores branch.autosetupmerge' '
 	git checkout main &&
 	git config branch.autosetupmerge always &&
 	git checkout --orphan gamma &&
-	test -z "$(git config branch.gamma.merge)" &&
+	test_cmp_config "" --default "" branch.gamma.merge &&
 	test refs/heads/gamma = "$(git symbolic-ref HEAD)" &&
+	test_must_fail git rev-parse --verify HEAD^ &&
+	git checkout main &&
+	git config branch.autosetupmerge inherit &&
+	git checkout --orphan eta &&
+	test_cmp_config "" --default "" branch.eta.merge &&
+	test_cmp_config "" --default "" branch.eta.remote &&
+	echo refs/heads/eta >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expected actual &&
 	test_must_fail git rev-parse --verify HEAD^
 '
 
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index 4453741b96..dca35aa3e3 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -24,4 +24,27 @@ test_expect_success 'checkout --track -b rejects an extra path argument' '
 	test_i18ngrep "cannot be used with updating paths" err
 '
 
+test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
+	# Set up tracking config on main
+	test_config branch.main.remote origin &&
+	test_config branch.main.merge refs/heads/some-branch &&
+	test_config branch.autoSetupMerge inherit &&
+	# With --track=inherit, we copy the tracking config from main
+	git checkout --track=inherit -b b1 main &&
+	test_cmp_config origin branch.b1.remote &&
+	test_cmp_config refs/heads/some-branch branch.b1.merge &&
+	# With branch.autoSetupMerge=inherit, we do the same
+	git checkout -b b2 main &&
+	test_cmp_config origin branch.b2.remote &&
+	test_cmp_config refs/heads/some-branch branch.b2.merge &&
+	# But --track overrides this
+	git checkout --track -b b3 main &&
+	test_cmp_config . branch.b3.remote &&
+	test_cmp_config refs/heads/main branch.b3.merge &&
+	# And --track=direct does as well
+	git checkout --track=direct -b b4 main &&
+	test_cmp_config . branch.b4.remote &&
+	test_cmp_config refs/heads/main branch.b4.merge
+'
+
 test_done
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 9bc6a3aa5c..ebb961be29 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -107,4 +107,32 @@ test_expect_success 'not switching when something is in progress' '
 	test_must_fail git switch -d @^
 '
 
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	# default config does not copy tracking info
+	git switch -c foo-no-inherit foo &&
+	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
+	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
+	# with --track=inherit, we copy tracking info from foo
+	git switch --track=inherit -c foo2 foo &&
+	test_cmp_config origin branch.foo2.remote &&
+	test_cmp_config refs/heads/foo branch.foo2.merge &&
+	# with autoSetupMerge=inherit, we do the same
+	test_config branch.autoSetupMerge inherit &&
+	git switch -c foo3 foo &&
+	test_cmp_config origin branch.foo3.remote &&
+	test_cmp_config refs/heads/foo branch.foo3.merge &&
+	# with --track, we override autoSetupMerge
+	git switch --track -c foo4 foo &&
+	test_cmp_config . branch.foo4.remote &&
+	test_cmp_config refs/heads/foo branch.foo4.merge &&
+	# and --track=direct does as well
+	git switch --track=direct -c foo5 foo &&
+	test_cmp_config . branch.foo5.remote &&
+	test_cmp_config refs/heads/foo branch.foo5.merge &&
+	# no tracking info to inherit from main
+	git switch -c main2 main &&
+	test_cmp_config "" --default "" branch.main2.remote &&
+	test_cmp_config "" --default "" branch.main2.merge
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4b0ef35913..a049276439 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1409,4 +1409,37 @@ test_expect_success 'invalid sort parameter in configuration' '
 	)
 '
 
+test_expect_success 'tracking info copied with --track=inherit' '
+	git branch --track=inherit foo2 my1 &&
+	test_cmp_config local branch.foo2.remote &&
+	test_cmp_config refs/heads/main branch.foo2.merge
+'
+
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	test_unconfig branch.autoSetupMerge &&
+	# default config does not copy tracking info
+	git branch foo-no-inherit my1 &&
+	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
+	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
+	# with autoSetupMerge=inherit, we copy tracking info from my1
+	test_config branch.autoSetupMerge inherit &&
+	git branch foo3 my1 &&
+	test_cmp_config local branch.foo3.remote &&
+	test_cmp_config refs/heads/main branch.foo3.merge &&
+	# no tracking info to inherit from main
+	git branch main2 main &&
+	test_cmp_config "" --default "" branch.main2.remote &&
+	test_cmp_config "" --default "" branch.main2.merge
+'
+
+test_expect_success '--track overrides branch.autoSetupMerge' '
+	test_config branch.autoSetupMerge inherit &&
+	git branch --track=direct foo4 my1 &&
+	test_cmp_config . branch.foo4.remote &&
+	test_cmp_config refs/heads/my1 branch.foo4.merge &&
+	git branch --no-track foo5 my1 &&
+	test_cmp_config "" --default "" branch.foo5.remote &&
+	test_cmp_config "" --default "" branch.foo5.merge
+'
+
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7f6e23a4bb..4fdf88ba46 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -657,4 +657,21 @@ test_expect_success 'custom merge driver with checkout -m' '
 	test_cmp expect arm
 '
 
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	git reset --hard main &&
+	# default config does not copy tracking info
+	git checkout -b foo-no-inherit koala/bear &&
+	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
+	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
+	# with autoSetupMerge=inherit, we copy tracking info from koala/bear
+	test_config branch.autoSetupMerge inherit &&
+	git checkout -b foo koala/bear &&
+	test_cmp_config origin branch.foo.remote &&
+	test_cmp_config refs/heads/koala/bear branch.foo.merge &&
+	# no tracking info to inherit from main
+	git checkout -b main2 main &&
+	test_cmp_config "" --default "" branch.main2.remote &&
+	test_cmp_config "" --default "" branch.main2.merge
+'
+
 test_done
-- 
2.34.1.307.g9b7440fafd-goog

