Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775022D780
	for <git@vger.kernel.org>; Sun, 21 Dec 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332802; cv=none; b=j+dPKbZibkOwI6K5EdRW7805wcGRXE0Zf3whzPx01dbME++LhXBR95+NIi4WiqY7OI+EM6mbKg3yBfrzBTE32IpgHIjECkC2iDzeQ8MU0DpYW5GN7GpZAwtSLcpF0KaNLn9JFPwEZHOsUcezThYg07qPFdxo4nwKH/pVQk/kt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332802; c=relaxed/simple;
	bh=29XITL7EM8oSZ7QwCNbVjF9fSyYJRJUl8WPqmZkPPGU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=XYaVXa1HlUAXnDKJCkNk0ZnDLFPAeQUX8NP9/QNDDtHAWIMfpvWIZeI//xaZntmONEQ4WWxCZmo5PbZps6atPRD4JmIjvL5RssBVJ07b52eaazfw+QkqV+irRTGGjndSsH3981IWIgH6VrGOB0Wdg7X/o5oKTAru0e7GyXbYnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOi2gGhT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOi2gGhT"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c0224fd2a92so3132262a12.2
        for <git@vger.kernel.org>; Sun, 21 Dec 2025 08:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332799; x=1766937599; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXDBpDgvsONOQt8Msq7rfqHdXNsMb2t6vhPROZdisRQ=;
        b=IOi2gGhTHvqboYdtxmWpLwJqG454S4EZYMVkUwLajECCy8LTo9uj3eeqGPWnvY4fRW
         I7ahL/wDo3LSmSUn+PaOw8EBvFxVRopvTRfTTxuW1heH7DhJtQbaeJrtS0dh+baK58EP
         gsTeYhUyHZiP68TYJ3wWECgV5guMq2DSf8TQh/YxHPWrxreZ5FJTkhcnDGgv5uhUbYD1
         MtchAqqAicvZ6DlJF9vKP6nzsngvcZWGMiNKDMmu9mxZbPAra5r4ByOGJrm+0OfBuJ9c
         3vIQslaRfGOCIDFe+AzlsaRzSzx0dMZRqnQ5mxaB4UG3fjGq00pOsyEqynj6YCgMBWdG
         6W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332799; x=1766937599;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXDBpDgvsONOQt8Msq7rfqHdXNsMb2t6vhPROZdisRQ=;
        b=XR3/V0uiMKQ3UIh+6eD7SG8fXYbQ0tXtdhByUg/cbCVdS3BiwsjpRS3U5tSJ1k3pvQ
         NrZHHfmxCCV/1MO14hCaWyVwIlqEW1V0sXu/pn9bU7wPH1QvgT8YPckAhRuyHIrQLVD5
         Z5Fx4xDWqDwZKE9KG0+toYk8OhWZ5gruODIJhS+VcngREVinMeZoKir2eK0t56jBgQT6
         2qqKjXWoEgUIfFn9w4LWNIu6FzNh19t9ZOoUrucwbduMd4EsEaU/GUJbKI6vhGMGH2Rz
         97lSGGXskt/qLhj5BOCGslylJNSpB+LWV43qgmygcQYhr6BK683crsI6TZMIC2pNWjiw
         Spag==
X-Gm-Message-State: AOJu0YybyzK6/Vsxvmo1c7C4OV8T+UDAjme1uUhwAGf2531V4aOa8NFZ
	ICZAgZQ1sgtXDO/7+VcDeOz31of3V5LiyO01fBX0NPea5XZX3bwaWrNafkwG4Q==
X-Gm-Gg: AY/fxX6Ze/f4wr/mYR0FPAsqknQmnRDfojxQEIpv4TCuf9Or2nPxXN7y8Lqx0cWeZ3n
	UIO0Xx367JVjnUYVzR28IXjpyVSJbDVJL9Mq9v9esRoI42ixOH99IzOonlr+lNLbUy71BAgncXo
	F9l3W7sQsiXnWJUziiLFknwNRyow19DSDu8LkBegTg55f+iSFkdXjHF/1Odt0hSPVilxuVOBgwS
	MmlPaXx1DC9dxWHypiYkF0Piy4SViXHnU+2dG94ZtQNIPXDqwh2nMLrEW0CzHan3QMKwCh9TiiC
	FZKsz4wFgGGZWY7bbAG21BPrtiPwM2rc9ZVm5nbXamToinjyyGyutrylf4hwhNrIsxGLi6cG8Xh
	gV0KWvu4+92lAXOst2KgdKnH8bODX4TH2yYTzN8KchYvKLtiYfx8+aRo9PkYtno82IQLqZZP0We
	IXwzcUgOL7npTSbpawNvRQPQ==
X-Google-Smtp-Source: AGHT+IFwWTZUrN284YEzJwVLy1BBMGaW3DqGA+C82gPZ6X84KtY6XXP5Btn+V+z7iKOxkp5fB49/qA==
X-Received: by 2002:a05:7300:ef97:b0:2ac:22ac:30 with SMTP id 5a478bee46e88-2b05eca8baemr8225717eec.34.1766332799283;
        Sun, 21 Dec 2025 07:59:59 -0800 (PST)
Received: from [127.0.0.1] ([13.83.162.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm23199774eec.2.2025.12.21.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:59:58 -0800 (PST)
Message-Id: <pull.2136.git.git.1766332796836.gitgitgadget@gmail.com>
From: "Pasteley Absurda via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Dec 2025 15:59:56 +0000
Subject: [PATCH] checkout: add remoteBranchTemplate config for DWIM branch
 names
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Pasteley Absurda <ceasebeing@gmail.com>,
    pasteley <ceasebeing@gmail.com>

From: pasteley <ceasebeing@gmail.com>

Add checkout.remoteBranchTemplate to apply a template pattern when
searching for remote branches during checkout DWIM and when creating
remote branches with push.autoSetupRemote.

Template uses printf-style placeholders (%s for branch name). For
example, with "feature/%s", checking out "foo"
searches for "origin/feature/foo" and creates local "foo"
tracking it. Pushing with autoSetupRemote creates "origin/feature/bar"
from local "bar".

Useful when remote branches use prefixes but local branches don't.

Works with git-checkout, git-worktree --guess-remote, and git-push.

Signed-off-by: pasteley <ceasebeing@gmail.com>
---
    checkout: add remoteBranchTemplate config for DWIM branch names

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2136%2Fpasteley%2Fremote-branch-template-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2136/pasteley/remote-branch-template-v1
Pull-Request: https://github.com/git/git/pull/2136

 Documentation/config/checkout.adoc |  10 ++
 Documentation/config/push.adoc     |   3 +
 builtin/push.c                     |  23 ++++
 builtin/worktree.c                 |   7 ++
 checkout.c                         |  49 ++++++++-
 checkout.h                         |   9 ++
 t/t1402-check-ref-format.sh        |   3 +
 t/t2024-checkout-dwim.sh           | 162 +++++++++++++++++++++++++++++
 t/t2400-worktree-add.sh            |  64 ++++++++++++
 t/t5528-push-default.sh            |  53 ++++++++++
 10 files changed, 382 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/checkout.adoc
index e35d212969..4b083d5c0c 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -22,6 +22,16 @@ commands or functionality in the future.
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
 
+`checkout.remoteBranchTemplate`::
+	Template pattern applied to remote ref names during checkout DWIM
+	and when pushing with `push.autoSetupRemote`. Uses `%s` for the
+	branch name and `%%` for a literal `%`.
++
+With `feature/%s`, `git checkout <branch>` searches for `origin/feature/<branch>`.
++
+Useful when remote branches expects specific prefixes (e.g., `feature/`, `user/`).
+Invalid templates (missing `%s`) trigger a warning and are ignored.
+
 `checkout.workers`::
 	The number of parallel workers to use when updating the working tree.
 	The default is one, i.e. sequential execution. If set to a value less
diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index d9112b2260..ae2031d069 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -8,6 +8,9 @@
 	to be set. Workflows most likely to benefit from this option are
 	`simple` central workflows where all branches are expected to
 	have the same name on the remote.
++
+When combined with `checkout.remoteBranchTemplate`, creates remote
+branches using the templated name.
 
 `push.default`::
 	Defines the action `git push` should take if no refspec is
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..c43d9dd7f8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
+#include "checkout.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
@@ -281,6 +282,28 @@ static void setup_default_push_refspecs(int *flags, struct remote *remote)
 	if ((*flags & TRANSPORT_PUSH_AUTO_UPSTREAM) && branch->merge_nr == 0)
 		*flags |= TRANSPORT_PUSH_SET_UPSTREAM;
 
+	/*
+	 * Apply template to destination ref if configured and we're setting
+	 * up upstream (either automatically or explicitly with -u).
+	 */
+	if (branch->merge_nr == 0 && (*flags & (TRANSPORT_PUSH_SET_UPSTREAM | TRANSPORT_PUSH_AUTO_UPSTREAM))) {
+		const char *short_name;
+		char *templated_dst = NULL;
+
+		if (skip_prefix(dst, "refs/heads/", &short_name)) {
+			char *template_result = expand_remote_branch_template(short_name);
+			if (template_result) {
+				templated_dst = xstrfmt("refs/heads/%s", template_result);
+				free(template_result);
+				dst = templated_dst;
+			}
+		}
+
+		refspec_appendf(&rs, "%s:%s", branch->refname, dst);
+		free(templated_dst);
+		return;
+	}
+
 	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
 }
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..9dd131d977 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -764,6 +764,13 @@ static char *dwim_branch(const char *path, char **new_branch)
 	if (guess_remote) {
 		struct object_id oid;
 		char *remote = unique_tracking_name(*new_branch, &oid, NULL);
+		char *templated_name = expand_remote_branch_template(*new_branch);
+
+		if (!remote && templated_name) {
+			die(_("No remote branch found for '%s' (set to '%s' by checkout.remoteBranchTemplate)"),
+			    *new_branch, templated_name);
+		}
+		free(templated_name);
 		return remote;
 	}
 	return NULL;
diff --git a/checkout.c b/checkout.c
index 1588b116ee..daa38b74b7 100644
--- a/checkout.c
+++ b/checkout.c
@@ -8,6 +8,7 @@
 #include "checkout.h"
 #include "config.h"
 #include "strbuf.h"
+#include "gettext.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
@@ -52,14 +53,23 @@ char *unique_tracking_name(const char *name, struct object_id *oid,
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
+	char *templated_name = NULL;
+	const char *search_name;
+
 	if (!repo_config_get_string_tmp(the_repository, "checkout.defaultremote", &default_remote))
 		cb_data.default_remote = default_remote;
-	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
+
+	templated_name = expand_remote_branch_template(name);
+	search_name = templated_name ? templated_name : name;
+
+	cb_data.src_ref = xstrfmt("refs/heads/%s", search_name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	if (dwim_remotes_matched)
 		*dwim_remotes_matched = cb_data.num_matches;
 	free(cb_data.src_ref);
+	free(templated_name);
+
 	if (cb_data.num_matches == 1) {
 		free(cb_data.default_dst_ref);
 		free(cb_data.default_dst_oid);
@@ -73,3 +83,40 @@ char *unique_tracking_name(const char *name, struct object_id *oid,
 	}
 	return NULL;
 }
+
+char *expand_remote_branch_template(const char *name)
+{
+	const char *tpl = NULL;
+	const char *fmt;
+	struct strbuf out = STRBUF_INIT;
+	int saw_placeholder = 0;
+
+	if (repo_config_get_string_tmp(the_repository,
+				       "checkout.remoteBranchTemplate",
+				       &tpl))
+		return NULL;
+
+	fmt = tpl;
+	while (strbuf_expand_step(&out, &fmt)) {
+		if (skip_prefix(fmt, "%", &fmt)) {
+			strbuf_addch(&out, '%');
+		} else if (skip_prefix(fmt, "s", &fmt)) {
+			strbuf_addstr(&out, name);
+			saw_placeholder = 1;
+		} else {
+			/*
+			 * Unknown placeholder: keep '%' literal to avoid
+			 * surprising behavior (e.g., "%x" stays "%x").
+			 */
+			strbuf_addch(&out, '%');
+		}
+	}
+
+	if (!saw_placeholder) {
+		strbuf_release(&out);
+		warning("%s", _("checkout.remoteBranchTemplate missing '%%s' placeholder; ignoring"));
+		return NULL;
+	}
+
+	return strbuf_detach(&out, NULL);
+}
diff --git a/checkout.h b/checkout.h
index 55920e7aeb..2549e8de30 100644
--- a/checkout.h
+++ b/checkout.h
@@ -3,6 +3,15 @@
 
 #include "hash.h"
 
+/*
+ * If checkout.remoteBranchTemplate is set, expand it using printf-style
+ * substitution:
+ *   %s -> the branch name
+ *   %% -> a literal %
+ * Returns a newly allocated string, or NULL if unset/invalid.
+ */
+char *expand_remote_branch_template(const char *name);
+
 /*
  * Check if the branch name uniquely matches a branch name on a remote
  * tracking branch.  Return the name of the remote if such a branch
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index cabc516ae9..f174bbf2cc 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -58,6 +58,9 @@ invalid_ref 'foo.lock/bar'
 invalid_ref 'foo.lock///bar'
 valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
+valid_ref 'heads/foo%bar'
+valid_ref 'heads/foo%s'
+valid_ref 'heads/100%special'
 invalid_ref 'heads/foo\bar'
 invalid_ref "$(printf 'heads/foo\t')"
 invalid_ref "$(printf 'heads/foo\177')"
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index a3b1449ef1..f409bc07c1 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -347,4 +347,166 @@ test_expect_success 'disambiguate dwim branch and checkout path (2)' '
 	grep bar dwim-arg2
 '
 
+test_expect_success 'setup for remoteBranchTemplate tests' '
+	(
+		cd repo_a &&
+		git checkout -b feature/newbar &&
+		test_commit a_feature_newbar &&
+		git checkout -b "100%special" &&
+		test_commit a_special &&
+		git checkout -b template_test &&
+		test_commit a_template_test
+	) &&
+	git fetch repo_a
+'
+
+test_expect_success 'checkout.remoteBranchTemplate with prefix' '
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D newbar &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+
+	git checkout newbar &&
+	status_uno_is_clean &&
+	test_branch newbar &&
+	test_cmp_rev remotes/repo_a/feature/newbar HEAD &&
+	test_branch_upstream newbar repo_a feature/newbar
+'
+
+test_expect_success 'checkout.remoteBranchTemplate handles literal %%' '
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D special &&
+	test_config checkout.remoteBranchTemplate "100%%%s" &&
+
+	git checkout special &&
+	status_uno_is_clean &&
+	test_branch special &&
+	test_cmp_rev remotes/repo_a/100%special HEAD &&
+	test_branch_upstream special repo_a 100%special
+'
+
+test_expect_success 'checkout.remoteBranchTemplate without %s is ignored with warning' '
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D template_test &&
+	test_config checkout.remoteBranchTemplate "fixed-name" &&
+
+	git checkout template_test 2>stderr &&
+	status_uno_is_clean &&
+	test_branch template_test &&
+	test_cmp_rev remotes/repo_a/template_test HEAD &&
+	test_grep "missing.*%s.*placeholder" stderr
+'
+
+test_expect_success 'checkout.remoteBranchTemplate with multiple %s placeholders' '
+	(
+		cd repo_a &&
+		git checkout -b user/multi/multi &&
+		test_commit a_multi_placeholder
+	) &&
+	git fetch repo_a &&
+
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D multi &&
+	test_config checkout.remoteBranchTemplate "user/%s/%s" &&
+
+	git checkout multi &&
+	status_uno_is_clean &&
+	test_branch multi &&
+	test_cmp_rev remotes/repo_a/user/multi/multi HEAD &&
+	test_branch_upstream multi repo_a user/multi/multi
+'
+
+test_expect_success 'checkout.remoteBranchTemplate + defaultRemote resolves ambiguity' '
+	(
+		cd repo_a &&
+		git checkout -b team/shared &&
+		test_commit a_team_shared
+	) &&
+	(
+		cd repo_b &&
+		git checkout -b team/shared &&
+		test_commit b_team_shared
+	) &&
+	git fetch --multiple repo_a repo_b &&
+
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D shared &&
+	test_config checkout.remoteBranchTemplate "team/%s" &&
+	test_config checkout.defaultRemote repo_b &&
+
+	git checkout shared &&
+	status_uno_is_clean &&
+	test_branch shared &&
+	test_cmp_rev remotes/other_b/team/shared HEAD &&
+	test_branch_upstream shared repo_b team/shared
+'
+
+test_expect_success 'checkout.remoteBranchTemplate with no matches fails' '
+	git checkout -B main &&
+	test_might_fail git branch -D nonexistent &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+
+	test_must_fail git checkout nonexistent &&
+	test_must_fail git rev-parse --verify refs/heads/nonexistent &&
+	test_branch main
+'
+
+test_expect_success 'checkout.remoteBranchTemplate still fails on ambiguity' '
+	git checkout -B main &&
+	test_might_fail git branch -D shared &&
+	test_config checkout.remoteBranchTemplate "team/%s" &&
+
+	test_must_fail git checkout shared 2>stderr &&
+	test_grep "matched multiple.*remote tracking branches" stderr &&
+	test_must_fail git rev-parse --verify refs/heads/shared &&
+	test_branch main
+'
+
+test_expect_success 'checkout.remoteBranchTemplate respects --no-guess' '
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D newbar &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+
+	test_must_fail git checkout --no-guess newbar &&
+	test_must_fail git rev-parse --verify refs/heads/newbar &&
+	test_branch main
+'
+
+test_expect_success 'checkout.remoteBranchTemplate respects checkout.guess = false' '
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D newbar &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+	test_config checkout.guess false &&
+
+	test_must_fail git checkout newbar &&
+	test_must_fail git rev-parse --verify refs/heads/newbar &&
+	test_branch main
+'
+
+test_expect_success 'checkout.remoteBranchTemplate with unknown placeholder kept literal' '
+	(
+		cd repo_a &&
+		git checkout -b "%d/literal" &&
+		test_commit a_literal_placeholder
+	) &&
+	git fetch repo_a &&
+
+	git checkout -B main &&
+	git reset --hard &&
+	test_might_fail git branch -D literal &&
+	test_config checkout.remoteBranchTemplate "%d/%s" &&
+
+	git checkout literal &&
+	status_uno_is_clean &&
+	test_branch literal &&
+	test_cmp_rev remotes/repo_a/%d/literal HEAD &&
+	test_branch_upstream literal repo_a %d/literal
+'
+
 test_done
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 023e1301c8..8b890d4b1e 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -730,6 +730,70 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 	)
 '
 
+test_expect_success 'git worktree add --guess-remote with remoteBranchTemplate' '
+	test_when_finished rm -rf repo_a repo_b bar &&
+	git init repo_a &&
+	(
+		cd repo_a &&
+		test_commit repo_a_main &&
+		git checkout -b feature/bar &&
+		test_commit feature_bar
+	) &&
+	git init repo_b &&
+	(
+		cd repo_b &&
+		test_commit repo_b_main &&
+		git remote add repo_a ../repo_a &&
+		git config remote.repo_a.fetch "refs/heads/*:refs/remotes/repo_a/*" &&
+		git fetch --all &&
+		git config checkout.remoteBranchTemplate "feature/%s" &&
+		git worktree add --guess-remote ../bar
+	) &&
+	(
+		cd bar &&
+		test_branch_upstream bar repo_a feature/bar &&
+		test_cmp_rev refs/remotes/repo_a/feature/bar refs/heads/bar
+	)
+'
+
+test_expect_success 'git worktree add --guess-remote with remoteBranchTemplate handles %%' '
+	test_when_finished rm -rf repo_a repo_b special &&
+	git init repo_a &&
+	(
+		cd repo_a &&
+		test_commit repo_a_main &&
+		git checkout -b "100%special" &&
+		test_commit percent_special
+	) &&
+	git init repo_b &&
+	(
+		cd repo_b &&
+		test_commit repo_b_main &&
+		git remote add repo_a ../repo_a &&
+		git config remote.repo_a.fetch "refs/heads/*:refs/remotes/repo_a/*" &&
+		git fetch --all &&
+		git config checkout.remoteBranchTemplate "100%%%s" &&
+		git worktree add --guess-remote ../special
+	) &&
+	(
+		cd special &&
+		test_branch_upstream special repo_a 100%special &&
+		test_cmp_rev refs/remotes/repo_a/100%special refs/heads/special
+	)
+'
+
+test_expect_success 'git worktree add --guess-remote with remoteBranchTemplate and no match fails' '
+	test_when_finished rm -rf repo_a repo_b nomatch &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git config checkout.remoteBranchTemplate "feature/%s" &&
+		test_must_fail git worktree add --guess-remote ../nomatch 2>err &&
+		test_grep "No remote branch found for" err &&
+		test_grep "feature/nomatch" err
+	)
+'
+
 test_dwim_orphan () {
 	local info_text="No possible source branch, inferring '--orphan'" &&
 	local fetch_error_text="fatal: No local or remote refs exist despite at least one remote" &&
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 2bd8759a68..e0d1c3cf02 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -294,4 +294,57 @@ test_expect_success 'default triangular behavior acts like "current"' '
 	test_push_success "" main repo2
 '
 
+test_expect_success 'push.autoSetupRemote + remoteBranchTemplate with push.default=simple' '
+	git checkout -b template-simple &&
+	test_config push.autoSetupRemote true &&
+	test_config push.default simple &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+	test_config branch.template-simple.remote parent1 &&
+	test_commit simple-commit &&
+	git push &&
+	git --git-dir=repo1 show-ref refs/heads/feature/template-simple &&
+	test_cmp_rev HEAD parent1/feature/template-simple &&
+	echo "refs/heads/feature/template-simple" >expect &&
+	git config branch.template-simple.merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push.autoSetupRemote + remoteBranchTemplate with push.default=upstream' '
+	git checkout -b template-upstream &&
+	test_config push.autoSetupRemote true &&
+	test_config push.default upstream &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+	test_config branch.template-upstream.remote parent1 &&
+	test_commit upstream-commit &&
+	git push &&
+	git --git-dir=repo1 show-ref refs/heads/feature/template-upstream &&
+	test_cmp_rev HEAD parent1/feature/template-upstream &&
+	echo "refs/heads/feature/template-upstream" >expect &&
+	git config branch.template-upstream.merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push.autoSetupRemote + remoteBranchTemplate with push.default=current' '
+	git checkout -b template-current &&
+	test_config push.autoSetupRemote true &&
+	test_config push.default current &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+	test_commit current-commit &&
+	git push parent1 &&
+	git --git-dir=repo1 show-ref refs/heads/feature/template-current &&
+	test_cmp_rev HEAD parent1/feature/template-current &&
+	echo "refs/heads/feature/template-current" >expect &&
+	git config branch.template-current.merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'remoteBranchTemplate ignored with push.default=nothing' '
+	git checkout -b template-nothing &&
+	test_config push.default nothing &&
+	test_config checkout.remoteBranchTemplate "feature/%s" &&
+	test_commit nothing-commit &&
+	test_must_fail git push 2>err &&
+	test_grep "No configured push destination" err
+'
+
 test_done

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
