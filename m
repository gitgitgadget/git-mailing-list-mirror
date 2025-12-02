Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE279CF
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706598; cv=none; b=KDd9DKeFogsRt7f/eL9cReLqdC8Ukp68r+qF4lHWDqyPfRxUogKZQtwTflvwWNsxMDoCG795UlRENi1Wi2qHgQY7MnAeNSpsiVhx1oPdQv4/5366bv92oJ24ieHWYU+zGvyJCAcgLb+82ZbB2vxEKATxaHZ8YDuJz2hcuIkHLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706598; c=relaxed/simple;
	bh=ANgXB48rKqqTFH5gWWD79yQkAFrbDnyyY5XXXiTCEZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9fCdN9dUcO/hhy5LhrsUskqhSNoaCpfNI9VvTQO93mHRdRlH7Z1RYSNBDu+plHvuEdj3o/dqRmCLee1k/IM5EU/qf4/nnCBCJkdz5D8ghBFrn11gfS0z6H4D1/1jFoR1CPkJZ+lAfaqBFdI1G0dcTHzL2U0juuKtDA4pD+jKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdPqLq8h; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdPqLq8h"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2984dfae0acso91616645ad.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 12:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764706595; x=1765311395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5V5gvgL2iGJY5JKnEE/tXiLJV3Thi3PCiRoqhyXzHA=;
        b=kdPqLq8hbWmuXwqZOTxRcX1CSxJw9vN/I0C/UlmMbzBtSxEDaq0QxKLRMmA8hEyDqI
         RC2HpM5oZk3JRWTuHxUhFDGnhdXwgXURg0WqcsUlbnVEnoefJ+0pSO4dFhVnFL9DrSrw
         Zi+wHc6aKd8Vtre6wG37DHcvxS4ClwI9AihiTobYmzpq8Na/yJZnRolcb3dsDoJoWkBc
         +3h4TbNvDQuZnIpf1W7dDZaNpeCzVSXIKhC9cbkpjMGBEbvEr4/Lohmvrt0lKlE2kC1B
         cyL6+ReQYO/LI0Y6nK6LneRhBcpwDazBx6VXhYmVqQDoYzIbTPIK36hryPqqgJmO6jKn
         3cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706595; x=1765311395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5V5gvgL2iGJY5JKnEE/tXiLJV3Thi3PCiRoqhyXzHA=;
        b=OaQA0AobfmEwEuC9sXQTSJxIcroeaXSSEqXZ6tJ0GfiD+763W2V7pJcyeKjSbawyUA
         +KbsEKU+w78iZyp4UpDnAmEf2AqqhKpjtPyYegk7cNcC95ThfG5cqjUHThIwSAoDWJt1
         6D4HPH9/gPwEqt4NaG5Nwin5pxN4JejZJd3S2vzfqE5Zzw7NFeGKWpo5aqbnL9B/S+No
         Yvl07M/tycrSUbAc/Sa/NIG/1xCYxIQK0C6fIilJkUcgd6YmKkgp1G2g8DN52cdZMuc8
         Ut4wTNO/FBt4goUR1Pw0Okz6VYLQ0TUNr+pYUPym0TlDLnLhnohHGi2brefQZe5ywq6+
         9gFw==
X-Gm-Message-State: AOJu0Yy1vntViBcHGABlG/l9Y7Ekgc1fzpV7hgDoFhGQgfSto65jhfgU
	UI0iBGfuP7NyES1y78C3V1Wk1JKE2wrt2BeXah4tX4YrruR406+QAsGXAPRC+BTL
X-Gm-Gg: ASbGncs59vf2rUFVTaN+AFBYWroVVTw7LDTlgIwK5F/nrZ2WR1TWy1oBx+Mnvcu7O8f
	n+GLtBG/a+Z3esPLvi3uS7KfUwTSQXI2PaUORbvZ3sU7B+00mZ7mOeRAMT6DV+wCjXZN8wo8wNa
	+QsYruLHXp/s05xDWrdlNPz0qHi2Y7TNuSZvZ7L9m1mOBIKy/0+12D9h2D7cOSvb0FiPn6CHmSU
	1hEHNs/i+fz67W2pInl3dzXEyioZ1MjAHhaRJvEdJp8Y5ghmiD2AeW/3BpxGMQzWoIJoON4Yl6g
	YLVW9OduqmhSTFGtkyUjuOWCCVzs6MyENbkQo8HoXuxz3vuaOBmT1WuFRadCaq8psdys1/m89AG
	ApFFcSFgo7mvZBYpRZd4vjCnFJx0DP8oZFkiqwYJeUmqrly+cvcaTiAYLutz7D0UN3Uy32dBos1
	ZoFq1CRqyXQ9Rb24OvwOtAm9yYPNdiTYkyAqFqYj6QHXDFNh4B3HtKR+8AMqtlQ3v/s5jebpDl
X-Google-Smtp-Source: AGHT+IEqgTr3NnNQlZJD5PD3+qGH1rZyQQst5VOgC3AeS15FNOcwVYgHTWxmPGyZTnehPMqW46P2pQ==
X-Received: by 2002:a17:903:3204:b0:298:2637:800b with SMTP id d9443c01a7336-29bab148a83mr345557055ad.31.1764706595102;
        Tue, 02 Dec 2025 12:16:35 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:30a4:b776:698d:fcda:3aba:18d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40acc7sm162058925ad.2.2025.12.02.12.16.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 12:16:34 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/2] replay: add --revert mode to reverse commit changes
Date: Wed,  3 Dec 2025 01:46:11 +0530
Message-ID: <20251202201611.22137-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202201611.22137-1-siddharthasthana31@gmail.com>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git replay` command performs server-side history rewriting without
requiring a working tree. While it currently supports cherry-picking
commits (--advance) and rebasing (--onto), it lacks the ability to
revert them.

At GitLab, we use replay in Gitaly for efficient server-side operations
on bare repositories. Adding revert functionality enables us to reverse
problematic commits directly on the server, eliminating client-side
roundtrips and reducing network overhead.

Add a `--revert <branch>` mode that reverses the changes introduced by
the specified commits. Following the architecture of --onto and --advance,
--revert is a standalone mode that takes a branch argument and updates
that branch with the revert commits.

The implementation follows the same approach as sequencer.c (lines
2360-2399), where cherry-pick and revert are the same merge operation
but with swapped arguments:

  - Cherry-pick: merge(ancestor=parent, ours=current, theirs=commit)
  - Revert: merge(ancestor=commit, ours=current, theirs=parent)

We swap the base and pickme trees when calling
merge_incore_nonrecursive(), effectively reversing the diff direction.
The existing conflict handling, ref updates, and atomic transaction
support work unchanged.

The commit messages follow git revert conventions: prefixed with
"Revert" and including the original commit SHA. When reverting a commit
that itself starts with "Revert", the message uses "Reapply" instead.
Unlike cherry-pick which preserves the original author, revert commits
use the current user as the author, matching the behavior of git revert.

Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc |  36 ++++++++-
 builtin/replay.c              | 145 ++++++++++++++++++++++++++++------
 t/t3650-replay-basics.sh      | 111 ++++++++++++++++++++++++++
 3 files changed, 267 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index dcb26e8a8e..eb297c7530 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
 
 DESCRIPTION
 -----------
@@ -42,6 +42,24 @@ The history is replayed on top of the <branch> and <branch> is updated to
 point at the tip of the resulting history. This is different from `--onto`,
 which uses the target only as a starting point without updating it.
 
+--revert <branch>::
+	Starting point at which to create the new revert commits; must be a
+	branch name.
++
+When `--revert` is specified, the commits in the revision range are reverted
+(their changes are undone) and the revert commits are applied on top of <branch>.
+The <branch> is then updated to point at the new commits. This is similar to
+running `git revert` for each commit in the range, but works without a working tree.
++
+The commit messages follow `git revert` conventions: prefixed with "Revert" and
+including the original commit SHA. When reverting a commit whose message starts
+with "Revert", the new message uses "Reapply" instead. The author of the revert
+commits is the current user, not the original commit author.
++
+This option is mutually exclusive with `--onto` and `--advance`. It is also
+incompatible with `--contained` (which is a modifier for `--onto` only).
+
+
 --ref-action[=<mode>]::
 	Control how references are updated. The mode can be:
 +
@@ -141,6 +159,22 @@ all commits they have since `base`, playing them on top of
 `origin/main`. These three branches may have commits on top of `base`
 that they have in common, but that does not need to be the case.
 
+To revert commits from a branch:
+
+------------
+$ git replay --revert main feature~2..feature
+------------
+
+This reverts the last two commits from 'feature', creating revert commits on
+top of 'main', and updates 'main' to point at the result. This is useful when
+commits from 'feature' were previously merged or cherry-picked into 'main' and
+need to be undone.
+
+NOTE: For reverting an entire merge request as a single commit (rather than
+commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
+which can avoid unnecessary merge conflicts.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index 6606a2c94b..7660f7412f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -17,6 +17,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
+#include "sequencer.h"
 #include "strmap.h"
 #include <oidset.h>
 #include <tree.h>
@@ -26,6 +27,11 @@ enum ref_action_mode {
 	REF_ACTION_PRINT,
 };
 
+enum replay_action {
+	REPLAY_PICK,
+	REPLAY_REVERT,
+};
+
 static const char *short_commit_name(struct repository *repo,
 				     struct commit *commit)
 {
@@ -57,10 +63,32 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+static void generate_revert_message(struct strbuf *msg,
+				    struct commit *commit,
+				    struct repository *repo)
+{
+	const char *out_enc = get_commit_output_encoding();
+	const char *message = repo_logmsg_reencode(repo, commit, NULL, out_enc);
+	const char *subject_start;
+	int subject_len;
+	char *subject;
+
+	subject_len = find_commit_subject(message, &subject_start);
+	subject = xmemdupz(subject_start, subject_len);
+
+	sequencer_format_revert_header(msg, subject);
+	strbuf_addstr(msg, oid_to_hex(&commit->object.oid));
+	strbuf_addstr(msg, ".\n");
+
+	free(subject);
+	repo_unuse_commit_buffer(repo, commit, message);
+}
+
 static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
-				    struct commit *parent)
+				    struct commit *parent,
+				    enum replay_action action)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
@@ -77,9 +105,14 @@ static struct commit *create_commit(struct repository *repo,
 
 	commit_list_insert(parent, &parents);
 	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
-	find_commit_subject(message, &orig_message);
-	strbuf_addstr(&msg, orig_message);
-	author = get_author(message);
+	if (action == REPLAY_REVERT) {
+		generate_revert_message(&msg, based_on, repo);
+		author = xstrdup(git_author_info(IDENT_STRICT));
+	} else {
+		find_commit_subject(message, &orig_message);
+		strbuf_addstr(&msg, orig_message);
+		author = get_author(message);
+	}
 	reset_ident_date();
 	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
 				 &ret, author, NULL, sign_commit, extra)) {
@@ -90,7 +123,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);
@@ -166,6 +199,7 @@ static void determine_replay_mode(struct repository *repo,
 				  struct rev_cmdline_info *cmd_info,
 				  const char *onto_name,
 				  char **advance_name,
+				  char **revert_name,
 				  struct commit **onto,
 				  struct strset **update_refs)
 {
@@ -196,6 +230,20 @@ static void determine_replay_mode(struct repository *repo,
 		}
 		if (rinfo.positive_refexprs > 1)
 			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
+	} else if (*revert_name) {
+		struct object_id oid;
+		char *fullname = NULL;
+
+		*onto = peel_committish(repo, *revert_name);
+		if (repo_dwim_ref(repo, *revert_name, strlen(*revert_name),
+				  &oid, &fullname, 0) == 1) {
+			free(*revert_name);
+			*revert_name = fullname;
+		} else {
+			die(_("argument to --revert must be a reference"));
+		}
+		if (rinfo.positive_refexprs > 1)
+			die(_("cannot revert with multiple sources because ordering would be ill-defined"));
 	} else {
 		int positive_refs_complete = (
 			rinfo.positive_refexprs ==
@@ -261,7 +309,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  kh_oid_map_t *replayed_commits,
 					  struct commit *onto,
 					  struct merge_options *merge_opt,
-					  struct merge_result *result)
+					  struct merge_result *result,
+					  enum replay_action action)
 {
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree;
@@ -273,21 +322,39 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 	base_tree = repo_get_commit_tree(repo, base);
 
-	merge_opt->branch1 = short_commit_name(repo, replayed_base);
-	merge_opt->branch2 = short_commit_name(repo, pickme);
-	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+	if (action == REPLAY_PICK) {
+		/* Cherry-pick: normal order */
+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
+		merge_opt->branch2 = short_commit_name(repo, pickme);
+		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
 
-	merge_incore_nonrecursive(merge_opt,
-				  base_tree,
-				  result->tree,
-				  pickme_tree,
-				  result);
+		merge_incore_nonrecursive(merge_opt,
+					  base_tree,
+					  result->tree,
+					  pickme_tree,
+					  result);
 
-	free((char*)merge_opt->ancestor);
+		free((char *)merge_opt->ancestor);
+	} else {
+		/* Revert: swap base and pickme to reverse the diff */
+		const char *pickme_name = short_commit_name(repo, pickme);
+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
+		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
+		merge_opt->ancestor = pickme_name;
+
+		merge_incore_nonrecursive(merge_opt,
+					  pickme_tree,
+					  result->tree,
+					  base_tree,
+					  result);
+
+		free((char *)merge_opt->branch2);
+	}
 	merge_opt->ancestor = NULL;
+	merge_opt->branch2 = NULL;
 	if (!result->clean)
 		return NULL;
-	return create_commit(repo, result->tree, pickme, replayed_base);
+	return create_commit(repo, result->tree, pickme, replayed_base, action);
 }
 
 static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
@@ -345,6 +412,9 @@ int cmd_replay(int argc,
 {
 	const char *advance_name_opt = NULL;
 	char *advance_name = NULL;
+	const char *revert_name_opt = NULL;
+	char *revert_name = NULL;
+	enum replay_action action = REPLAY_PICK;
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
 	int contained = 0;
@@ -365,7 +435,7 @@ int cmd_replay(int argc,
 
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
-		   "([--contained] --onto <newbase> | --advance <branch>) "
+		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
 		   "[--ref-action[=<mode>]] <revision-range>..."),
 		NULL
 	};
@@ -378,6 +448,9 @@ int cmd_replay(int argc,
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
 			 N_("advance all branches contained in revision-range")),
+		OPT_STRING(0, "revert", &revert_name_opt,
+			   N_("branch"),
+			   N_("revert commits onto given branch")),
 		OPT_STRING(0, "ref-action", &ref_action,
 			   N_("mode"),
 			   N_("control ref update behavior (update|print)")),
@@ -387,18 +460,28 @@ int cmd_replay(int argc,
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	if (!onto_name && !advance_name_opt) {
-		error(_("option --onto or --advance is mandatory"));
+	/* Exactly one mode must be specified */
+	if (!onto_name && !advance_name_opt && !revert_name_opt) {
+		error(_("exactly one of --onto, --advance, or --revert is required"));
 		usage_with_options(replay_usage, replay_options);
 	}
 
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
-				  contained, "--contained");
+				  !!onto_name, "--onto");
+	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
+				  !!onto_name, "--onto");
+	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
+				  !!advance_name_opt, "--advance");
+	die_for_incompatible_opt2(contained, "--contained",
+				  !onto_name, "requires --onto");
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
 
 	advance_name = xstrdup_or_null(advance_name_opt);
+	revert_name = xstrdup_or_null(revert_name_opt);
+	if (revert_name)
+		action = REPLAY_REVERT;
 
 	repo_init_revisions(repo, &revs, prefix);
 
@@ -452,10 +535,13 @@ int cmd_replay(int argc,
 	}
 
 	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
+			      &revert_name,
 			      &onto, &update_refs);
 
 	/* Build reflog message */
-	if (advance_name_opt)
+	if (revert_name_opt)
+		strbuf_addf(&reflog_msg, "replay --revert %s", revert_name_opt);
+	else if (advance_name_opt)
 		strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);
 	else
 		strbuf_addf(&reflog_msg, "replay --onto %s",
@@ -496,7 +582,7 @@ int cmd_replay(int argc,
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
+						  onto, &merge_opt, &result, action);
 		if (!last_commit)
 			break;
 
@@ -508,7 +594,7 @@ int cmd_replay(int argc,
 		kh_value(replayed_commits, pos) = last_commit;
 
 		/* Update any necessary branches */
-		if (advance_name)
+		if (advance_name || revert_name)
 			continue;
 		decoration = get_name_decoration(&commit->object);
 		if (!decoration)
@@ -532,7 +618,7 @@ int cmd_replay(int argc,
 		}
 	}
 
-	/* In --advance mode, advance the target ref */
+	/* In --advance or --revert mode, update the target ref */
 	if (result.clean == 1 && advance_name) {
 		if (handle_ref_update(ref_mode, transaction, advance_name,
 				      &last_commit->object.oid,
@@ -544,6 +630,17 @@ int cmd_replay(int argc,
 			goto cleanup;
 		}
 	}
+	if (result.clean == 1 && revert_name) {
+		if (handle_ref_update(ref_mode, transaction, revert_name,
+				      &last_commit->object.oid,
+				      &onto->object.oid,
+				      reflog_msg.buf,
+				      &transaction_err) < 0) {
+			ret = error(_("failed to update ref '%s': %s"),
+				    revert_name, transaction_err.buf);
+			goto cleanup;
+		}
+	}
 
 	/* Commit the ref transaction if we have one */
 	if (transaction && result.clean == 1) {
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index cf3aacf355..1c4e1cb666 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -314,4 +314,115 @@ test_expect_success 'invalid replay.refAction value' '
 	test_grep "invalid.*replay.refAction.*value" error
 '
 
+test_expect_success 'setup for revert tests' '
+	git switch -c revert-test main &&
+	test_commit R1 &&
+	test_commit R2 &&
+	test_commit R3 &&
+	git switch main
+'
+
+test_expect_success 'git replay --revert reverts commits' '
+	# Store original state
+	START=$(git rev-parse revert-test) &&
+	test_when_finished "git branch -f revert-test $START" &&
+
+	git replay --revert revert-test revert-test~2..revert-test >output &&
+	test_must_be_empty output &&
+
+	# Verify revert-test was updated with revert commits
+	git log --format=%s -n 5 revert-test >actual &&
+	cat >expect <<-\EOF &&
+	Revert "R3"
+	Revert "R2"
+	R3
+	R2
+	R1
+	EOF
+	test_cmp expect actual &&
+
+	# Verify commit message format
+	test_commit_message revert-test -m "Revert \"R3\"
+
+This reverts commit $(git rev-parse R3)."
+'
+
+test_expect_success 'git replay --revert with --ref-action=print' '
+	# Store original state
+	START=$(git rev-parse revert-test) &&
+	test_when_finished "git branch -f revert-test $START" &&
+
+	git replay --ref-action=print --revert revert-test revert-test~2..revert-test >result &&
+	test_line_count = 1 result &&
+
+	# Verify output format: update refs/heads/revert-test <new> <old>
+	cut -f 3 -d " " result >new-tip &&
+	printf "update refs/heads/revert-test " >expect &&
+	printf "%s " $(cat new-tip) >>expect &&
+	printf "%s\n" $START >>expect &&
+	test_cmp expect result
+'
+
+test_expect_success 'git replay --revert reapply behavior' '
+	# Store original state
+	START=$(git rev-parse revert-test) &&
+	test_when_finished "git branch -f revert-test $START" &&
+
+	# First revert R3
+	git replay --revert revert-test revert-test~1..revert-test &&
+	REVERT_R3=$(git rev-parse revert-test) &&
+
+	# Now revert the revert (should create "Reapply" message)
+	git replay --revert revert-test revert-test~1..revert-test >output &&
+	test_must_be_empty output &&
+
+	# Verify Reapply message
+	test_commit_message revert-test -m "Reapply \"R3\"
+
+This reverts commit $(git rev-parse $REVERT_R3)."
+'
+
+test_expect_success 'git replay --revert with conflict' '
+	# Create a conflicting scenario
+	git switch -c revert-conflict main &&
+	test_commit C1 &&
+	echo conflict >C1.t &&
+	test_commit C2 C1.t &&
+	git switch main &&
+	echo different >C1.t &&
+	test_commit C3 C1.t &&
+
+	# Try to revert C2 onto main (which has conflicting C3)
+	test_expect_code 1 git replay --revert main revert-conflict~1..revert-conflict
+'
+
+test_expect_success 'git replay --revert reflog message' '
+	# Store original state
+	START=$(git rev-parse revert-test) &&
+	test_when_finished "git branch -f revert-test $START" &&
+
+	git replay --revert revert-test revert-test~1..revert-test >output &&
+	test_must_be_empty output &&
+
+	# Verify reflog message includes --revert and branch name
+	git reflog revert-test -1 --format=%gs >reflog-msg &&
+	echo "replay --revert revert-test" >expect-reflog &&
+	test_cmp expect-reflog reflog-msg
+'
+
+test_expect_success 'git replay --revert incompatible with --contained' '
+	test_must_fail git replay --revert revert-test --contained revert-test~1..revert-test 2>error &&
+	test_grep "requires --onto" error
+'
+
+test_expect_success 'git replay --revert incompatible with --onto' '
+	test_must_fail git replay --revert revert-test --onto main revert-test~1..revert-test 2>error &&
+	test_grep "cannot be used together" error
+'
+
+test_expect_success 'git replay --revert incompatible with --advance' '
+	test_must_fail git replay --revert revert-test --advance main revert-test~1..revert-test 2>error &&
+	test_grep "cannot be used together" error
+'
+
 test_done
-- 
2.51.0

