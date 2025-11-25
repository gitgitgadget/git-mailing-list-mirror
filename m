Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1A332EC4
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090083; cv=none; b=ALpoflEdX0iX1FXbki63+8nt/lGfVgHOxJN50Xwqd2tUMH/q4SzPIiMm92tCL4vc4r/7p29cmAdYmGSv7adTgRo1CcrHS6rBBVEfqQDnvfYgBK2n4yjWeY0Ts3yMKKL4IlxZZ+HlyPiek41psLlPi2LbOjIir0XfEDrG9DLO/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090083; c=relaxed/simple;
	bh=+fvhROQmpDUlp2bzxYriz6U5pSsVS9Sll6BGQwKfZcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kskbEFYt79TFdETCPjrAr/D0giFdZWMSiCUmdVbQEUQ9PgtborVekf3Afl7DfO039su8+89OtYitbPAz0glDa1RTyM1aQP43vt7hUrwVbVUVHJsuY2Di+e7egA5o9TMB3Pj5kJtzXUheA+rRORyTrzV71bH3x2d0KxuMtNc/lJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAufZsET; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAufZsET"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2955623e6faso67413995ad.1
        for <git@vger.kernel.org>; Tue, 25 Nov 2025 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764090080; x=1764694880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEbld/oMpNDBdSFfhcWnN68wyptSHOmna64Gqo/YMFU=;
        b=HAufZsETOIpoSmjcbJhV2NppznyoAuDHZd9GcD4EByNNG/iofeA7VA7rxF2Vh6i4CY
         VKVKEDTKSrLwK239dnRrZwSJeKv6ehdl03/MQ5rwiZJEkb+275rBNcDbiiLnIhQEuj4S
         2fL+F609GpjQuC+/6De+2CVVXOAHjdY9RXxkL101rB/NZoN6yf+QqRidelve43djR4wR
         8z/1vAAmm8SZG9CP8mLK9+w3TKsOA0XT4N5QAbPd2AyKtDpsgXo5Sfzi0IMQUZKgabWN
         AW8LLU8UvYGHK1tPW5IBDS8RoKFo/4FD0cAmbgHNZ/cmYxpnUB3D768blCtr+tnxoEEX
         WAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764090080; x=1764694880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEbld/oMpNDBdSFfhcWnN68wyptSHOmna64Gqo/YMFU=;
        b=mA1TdT7mmwZF1SSb7Y5QVSNB0S33JKIwRsyAK5OV+yifNXiwUCIlw4djBCAdjIpuCM
         xQsdzRsdt7dTyXniPIVB3tAfVBcpQy/9MDs+6i6ecE9d4eTRIGzW+bLV7kQeh0w1eq/s
         DnnQIx1yTj/M4j51BXg6yyXx5daANu6r/8jrEq2XqYpJ0q0NY5s9SrTBzBAa1qjW01gd
         EeymK11Abs9PjDGrjY3JXoUVXNgcq/R+JqcpK0nd0zJvAEwOwyct606dQtoBkpDVv+ik
         DW+OWVfXu6HYpc55gQTIYMN6fV7f1uEWYsQGxV6f/PeIQNimdOVOZlxDg1m9mB+cNW3y
         1WQQ==
X-Gm-Message-State: AOJu0Yy/i14u9awu4DIC4goxPFkN02COL0FxlZUgWVhN53n1DkzOuQVQ
	4ybflZlP+JszyG4OLJR0J8aSrlz9yE/czGMnhhAH8wFEcSFd1Pb3UsnFSLOnvnJG
X-Gm-Gg: ASbGncvHCN6KwKZ6I1QqnxgiP0XWvclkbr95Dmdr4U0ZAm/hTWig/ud3EBWh2Uf4v4z
	ytmS9Xy/O7uPNmYf5JUPgN4BPew6Qpw5y8x36nbzaZlnaIUSWgDmBqlZjX1oXUqWpng6qOletUg
	9pN42iwtp0D+40NPdgWuzbkDXn8eppjJEqdfDySODioQoXrBJaAMdLDboUL1F9Pvg3kkvCgZuf7
	fYHvWQDjmMffvgCfW/Dw1QxFiO3riUeVRQW6cIJzxvBhhXp/Pv2gkWWpSUhlt0mRmrfaJy722/u
	h2544xG0ELSgU6B94wOcWTv4+axtJrpM5EUoXy2U8mhZayg7RQpMGqk499yPeNz1XIWuc6L3U34
	Wmg686JbuFmMFGgUFyz0KNa3jbo8QABAJLG2MfRbLK5+ZYlerVZASRfGhvbiSCTrooWc2B4+M3m
	gL8t24K6RL3j1WhR2h/N3y2yoHl6WcdPULm/JyH61UaXXsPY/4bbpX7LvVaNogrg==
X-Google-Smtp-Source: AGHT+IHx5h6BBFi1jT01U0iAvGpWy1aFIsHdsZZuz1b2yP8QOp2sjtY4Ueey1YXKyYqRJyTX3l9amw==
X-Received: by 2002:a17:903:11c5:b0:295:ed6:4625 with SMTP id d9443c01a7336-29bab1c50ebmr41684225ad.47.1764090079392;
        Tue, 25 Nov 2025 09:01:19 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:30a4:b776:b45d:b475:12df:68c0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6346sm17014834a12.4.2025.11.25.09.01.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 09:01:18 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 1/1] replay: add --revert option to reverse commit changes
Date: Tue, 25 Nov 2025 22:30:56 +0530
Message-ID: <20251125170056.34489-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125170056.34489-1-siddharthasthana31@gmail.com>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git replay` command performs server-side history rewriting without
requiring a working tree. While it currently supports cherry-picking
commits, it lacks the ability to revert them.

At GitLab, we use replay in Gitaly for efficient server-side operations
on bare repositories. Adding revert functionality enables us to reverse
problematic commits directly on the server, eliminating client-side
roundtrips and reducing network overhead.

Add a `--revert` option that reverses the changes introduced by the
specified commits. The implementation follows the same approach as
`sequencer.c` (around lines 2358-2390), where cherry-pick and revert
are essentially the same merge operation but with swapped arguments:

  - Cherry-pick: merge(ancestor=parent, ours=current, theirs=commit)
  - Revert: merge(ancestor=commit, ours=current, theirs=parent)

We swap the base and pickme trees when calling
`merge_incore_nonrecursive()`, effectively reversing the diff direction.
The existing conflict handling, ref updates, and atomic transaction
support work unchanged.

The revert message generation logic (handling "Revert" and "Reapply"
cases) is extracted into a new `sequencer_format_revert_header()`
function in `sequencer.c`, which can be shared between `sequencer.c`
and `builtin/replay.c`. The `builtin/replay.c` code calls this shared
function and then appends the commit OID using `oid_to_hex()` directly,
since git replay is designed for simpler server-side operations without
the interactive features and `replay_opts` framework used by
`sequencer.c`.

The commit messages follow `git revert` conventions: prefixed with
"Revert" and including the original commit SHA. When reverting a commit
that itself starts with "Revert", the message uses "Reapply" instead.
Unlike cherry-pick which preserves the original author, revert commits
use the current user as the author, matching the behavior of `git
revert`.

Mark the option as incompatible with `--contained` since reverting
changes across multiple branches simultaneously could lead to
inconsistent repository states.

Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc |  35 +++++++-
 builtin/replay.c              |  86 ++++++++++++++----
 sequencer.c                   |  23 +++++
 sequencer.h                   |   8 ++
 t/t3650-replay-basics.sh      | 160 ++++++++++++++++++++++++++++++++++
 5 files changed, 295 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index dcb26e8a8e..ad7dc08622 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] [--revert] <revision-range>...
 
 DESCRIPTION
 -----------
@@ -54,6 +54,18 @@ which uses the target only as a starting point without updating it.
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
 
+--revert::
+	Revert the changes introduced by the commits in the revision range
+	instead of applying them. This reverses the diff direction and creates
+	new commits that undo the changes, similar to `git revert`.
++
+The commit messages are prefixed with "Revert" and include the original
+commit SHA. If reverting a commit whose message starts with "Revert", the new
+message will start with "Reapply" instead. The author of the new commits
+will be the current user, not the original commit author.
++
+This option is incompatible with `--contained`.
+
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
 	be passed, but in `--advance <branch>` mode, they should have
@@ -141,6 +153,27 @@ all commits they have since `base`, playing them on top of
 `origin/main`. These three branches may have commits on top of `base`
 that they have in common, but that does not need to be the case.
 
+To revert a range of commits:
+
+------------
+$ git replay --revert --onto main feature~3..feature
+------------
+
+This creates new commits on top of 'main' that reverse the changes introduced
+by the last three commits on 'feature'. The 'feature' branch is updated to
+point at the last of these revert commits. The 'main' branch is not updated
+in this case.
+
+To revert commits and advance a branch:
+
+------------
+$ git replay --revert --advance main feature~2..feature
+------------
+
+This reverts the last two commits from 'feature', applies those reverts
+on top of 'main', and updates 'main' to point at the result. The 'feature'
+branch is not updated in this case.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index 6606a2c94b..7258d0bbc5 100644
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
@@ -57,10 +58,25 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+/*
+ * Generates a revert commit message using the shared sequencer function.
+ * We use oid_to_hex() directly instead of refer_to_commit() since git replay
+ * is designed for simpler server-side operations without interactive features.
+ */
+static void generate_revert_message(struct strbuf *msg,
+				    const char *orig_message,
+				    const struct object_id *oid)
+{
+	sequencer_format_revert_header(msg, orig_message);
+	strbuf_addstr(msg, oid_to_hex(oid));
+	strbuf_addstr(msg, ".\n");
+}
+
 static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
-				    struct commit *parent)
+				    struct commit *parent,
+				    int is_revert)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
@@ -78,8 +94,17 @@ static struct commit *create_commit(struct repository *repo,
 	commit_list_insert(parent, &parents);
 	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
 	find_commit_subject(message, &orig_message);
-	strbuf_addstr(&msg, orig_message);
-	author = get_author(message);
+
+	if (is_revert) {
+		generate_revert_message(&msg, orig_message, &based_on->object.oid);
+		/* For revert, use current user as author */
+		author = NULL;
+	} else {
+		/* Cherry-pick mode: use original commit message and author */
+		strbuf_addstr(&msg, orig_message);
+		author = get_author(message);
+	}
+
 	reset_ident_date();
 	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
 				 &ret, author, NULL, sign_commit, extra)) {
@@ -261,7 +286,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  kh_oid_map_t *replayed_commits,
 					  struct commit *onto,
 					  struct merge_options *merge_opt,
-					  struct merge_result *result)
+					  struct merge_result *result,
+					  int is_revert)
 {
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree;
@@ -273,21 +299,41 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 	base_tree = repo_get_commit_tree(repo, base);
 
-	merge_opt->branch1 = short_commit_name(repo, replayed_base);
-	merge_opt->branch2 = short_commit_name(repo, pickme);
-	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+	if (is_revert) {
+		/* For revert: swap base and pickme to reverse the diff */
+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
+		merge_opt->branch2 = xstrfmt("parent of %s", short_commit_name(repo, pickme));
+		merge_opt->ancestor = short_commit_name(repo, pickme);
 
-	merge_incore_nonrecursive(merge_opt,
-				  base_tree,
-				  result->tree,
-				  pickme_tree,
-				  result);
+		merge_incore_nonrecursive(merge_opt,
+					  pickme_tree,
+					  result->tree,
+					  base_tree,
+					  result);
+
+		/* branch2 was allocated with xstrfmt, needs freeing */
+		free((char *)merge_opt->branch2);
+	} else {
+		/* For cherry-pick: normal order */
+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
+		merge_opt->branch2 = short_commit_name(repo, pickme);
+		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+
+		merge_incore_nonrecursive(merge_opt,
+					  base_tree,
+					  result->tree,
+					  pickme_tree,
+					  result);
+
+		/* ancestor was allocated with xstrfmt, needs freeing */
+		free((char *)merge_opt->ancestor);
+	}
 
-	free((char*)merge_opt->ancestor);
 	merge_opt->ancestor = NULL;
+	merge_opt->branch2 = NULL;
 	if (!result->clean)
 		return NULL;
-	return create_commit(repo, result->tree, pickme, replayed_base);
+	return create_commit(repo, result->tree, pickme, replayed_base, is_revert);
 }
 
 static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
@@ -350,6 +396,7 @@ int cmd_replay(int argc,
 	int contained = 0;
 	const char *ref_action = NULL;
 	enum ref_action_mode ref_mode;
+	int is_revert = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -366,7 +413,7 @@ int cmd_replay(int argc,
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto <newbase> | --advance <branch>) "
-		   "[--ref-action[=<mode>]] <revision-range>..."),
+		   "[--ref-action[=<mode>]] [--revert] <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -381,6 +428,8 @@ int cmd_replay(int argc,
 		OPT_STRING(0, "ref-action", &ref_action,
 			   N_("mode"),
 			   N_("control ref update behavior (update|print)")),
+		OPT_BOOL(0, "revert", &is_revert,
+			 N_("revert commits instead of cherry-picking them")),
 		OPT_END()
 	};
 
@@ -395,6 +444,10 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
+	/* --revert is incompatible with --contained */
+	die_for_incompatible_opt2(is_revert, "--revert",
+				  contained, "--contained");
+
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
 
@@ -496,7 +549,8 @@ int cmd_replay(int argc,
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
+						  onto, &merge_opt, &result,
+						  is_revert);
 		if (!last_commit)
 			break;
 
diff --git a/sequencer.c b/sequencer.c
index 5476d39ba9..e6d82c8368 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5572,6 +5572,29 @@ int sequencer_pick_revisions(struct repository *r,
 	return res;
 }
 
+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject)
+{
+	const char *revert_subject;
+
+	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
+	    /*
+	     * We don't touch pre-existing repeated reverts, because
+	     * theoretically these can be nested arbitrarily deeply,
+	     * thus requiring excessive complexity to deal with.
+	     */
+	    !starts_with(revert_subject, "Revert \"")) {
+		strbuf_addstr(out, "Reapply \"");
+		strbuf_addstr(out, revert_subject);
+		strbuf_addch(out, '\n');
+	} else {
+		strbuf_addstr(out, "Revert \"");
+		strbuf_addstr(out, orig_subject);
+		strbuf_addstr(out, "\"\n");
+	}
+
+	strbuf_addstr(out, "\nThis reverts commit ");
+}
+
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9..2d4a2d3fac 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -205,6 +205,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
+/*
+ * Formats a revert commit message header following standard Git conventions.
+ * Handles both regular reverts ("Revert \"<subject>\"") and revert of revert
+ * cases ("Reapply \"<subject>\""). Adds "This reverts commit " at the end.
+ * The caller should append the commit OID after calling this function.
+ */
+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject);
+
 void append_conflicts_hint(struct index_state *istate,
 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index cf3aacf355..5fcd730b54 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -314,4 +314,164 @@ test_expect_success 'invalid replay.refAction value' '
 	test_grep "invalid.*replay.refAction.*value" error
 '
 
+test_expect_success 'using replay with --revert to revert a commit' '
+	# Revert commits D and E from topic2
+	git replay --revert --onto topic1 topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+	NEW_TOPIC2=$(cut -f 3 -d " " result) &&
+
+	# Verify the result updates the topic2 branch
+	printf "update refs/heads/topic2 " >expect &&
+	printf "%s " $NEW_TOPIC2 >>expect &&
+	git rev-parse topic2 >>expect &&
+
+	test_cmp expect result &&
+
+	# Verify the commit messages contain "Revert"
+	# topic1..topic2 contains D and E, so we get 2 reverts on top of topic1 (which has F, C, B, A)
+	git log --format=%s $NEW_TOPIC2 >actual &&
+	test_line_count = 6 actual &&
+	head -n 1 actual >first-line &&
+	test_grep "^Revert" first-line
+'
+
+test_expect_success 'using replay with --revert on bare repo' '
+	git -C bare replay --revert --onto topic1 topic1..topic2 >result-bare &&
+
+	test_line_count = 1 result-bare &&
+	NEW_COMMIT=$(cut -f 3 -d " " result-bare) &&
+
+	# Verify the commit message contains "Revert"
+	git -C bare log --format=%s $NEW_COMMIT >actual-bare &&
+	test_line_count = 6 actual-bare &&
+	head -n 1 actual-bare >first-line-bare &&
+	test_grep "^Revert" first-line-bare
+'
+
+test_expect_success 'using replay with --revert and --advance' '
+	# Revert commits from topic2 and advance main
+	git replay --revert --advance main topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+	NEW_MAIN=$(cut -f 3 -d " " result) &&
+
+	# Verify the result updates the main branch
+	printf "update refs/heads/main " >expect &&
+	printf "%s " $NEW_MAIN >>expect &&
+	git rev-parse main >>expect &&
+
+	test_cmp expect result &&
+
+	# Verify the commit message contains "Revert"
+	git log --format=%s $NEW_MAIN >actual &&
+	head -n 1 actual >first-line &&
+	test_grep "^Revert" first-line
+'
+
+test_expect_success 'replay with --revert fails with --contained' '
+	test_must_fail git replay --revert --contained --onto main main..topic3 2>error &&
+	test_grep "revert.*contained.*cannot be used together" error
+'
+
+test_expect_success 'verify revert actually reverses changes' '
+	# Create a branch with a simple change
+	git switch -c revert-test main &&
+	echo "new content" >test-file.txt &&
+	git add test-file.txt &&
+	git commit -m "Add test file" &&
+
+	# Revert the commit
+	git replay --revert --advance revert-test HEAD^..HEAD >result &&
+	REVERTED=$(cut -f 3 -d " " result) &&
+
+	# The file should no longer exist (reverted)
+	test_must_fail git show $REVERTED:test-file.txt
+'
+
+test_expect_success 'revert of a revert creates reapply message' '
+	# Create a commit
+	git switch -c revert-revert main &&
+	echo "content" >revert-test-2.txt &&
+	git add revert-test-2.txt &&
+	git commit -m "Add revert test file" &&
+
+	ORIGINAL=$(git rev-parse HEAD) &&
+
+	# First revert
+	git replay --revert --advance revert-revert HEAD^..HEAD >result1 &&
+	FIRST_REVERT=$(cut -f 3 -d " " result1) &&
+
+	# Check first revert message starts with "Revert"
+	git log --format=%s -1 $FIRST_REVERT >msg1 &&
+	test_grep "^Revert" msg1 &&
+
+	# Now revert the revert
+	git replay --revert --advance revert-revert $ORIGINAL..$FIRST_REVERT >result2 &&
+	REAPPLY=$(cut -f 3 -d " " result2) &&
+
+	# Check second revert message starts with "Reapply"
+	git log --format=%s -1 $REAPPLY >msg2 &&
+	test_grep "^Reapply" msg2 &&
+
+	# The file should exist again (reapplied)
+	git show $REAPPLY:revert-test-2.txt >actual &&
+	echo "content" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'replay --revert includes commit SHA in message' '
+	git switch -c revert-sha-test main &&
+	echo "test" >sha-test.txt &&
+	git add sha-test.txt &&
+	git commit -m "Test commit for SHA" &&
+
+	COMMIT_SHA=$(git rev-parse HEAD) &&
+	git replay --revert --advance revert-sha-test HEAD^..HEAD >result &&
+	REVERT_COMMIT=$(cut -f 3 -d " " result) &&
+
+	# Check that the commit message includes the original SHA
+	git log --format=%B -1 $REVERT_COMMIT >msg &&
+	test_grep "$COMMIT_SHA" msg
+'
+
+test_expect_success 'replay --revert with conflict' '
+	# Create a conflicting situation
+	git switch -c revert-conflict main &&
+	echo "line1" >conflict-file.txt &&
+	git add conflict-file.txt &&
+	git commit -m "Add conflict file" &&
+
+	git switch -c revert-conflict-branch HEAD^ &&
+	echo "different" >conflict-file.txt &&
+	git add conflict-file.txt &&
+	git commit -m "Different content" &&
+
+	# Try to revert the first commit onto the conflicting branch
+	test_expect_code 1 git replay --revert --onto revert-conflict-branch revert-conflict^..revert-conflict
+'
+
+test_expect_success 'replay --revert handles multiple commits' '
+	# Verify that reverting multiple commits works correctly
+	# The output should show both revert commits in the history
+	git log --format=%s topic2 >topic2-log &&
+	test_write_lines E D C B A >expected-topic2 &&
+	test_cmp expected-topic2 topic2-log &&
+
+	# Revert D and E from topic2, applying the reverts onto topic1
+	git replay --revert --onto topic1 topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+	FINAL=$(cut -f 3 -d " " result) &&
+
+	# Verify both revert commits appear in the log
+	git log --format=%s $FINAL >log &&
+	head -n 2 log >first-two &&
+	test_grep "^Revert" first-two &&
+
+	# Verify we have both "Revert D" and "Revert E"
+	test_grep "Revert.*E" log &&
+	test_grep "Revert.*D" log
+'
+
 test_done
-- 
2.51.0

