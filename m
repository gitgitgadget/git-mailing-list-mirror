Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237874AA1D3
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947656; cv=none; b=ZAmDSYAk8uhSZu+tQ5zEkWHUNB14ipMyAiORl/rc0dcNPDIZQ0u7eRdQjDEqgLzYleF/lOkIOA6kL0AI8lbs/zjDWtJaxaMljUiUeYLzZiUvx/L9zR3WZv3KtE0zpUkEPD3y6VE8iQwoXNU2/7/CvXYfGGRErewI5dWul308Z0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947656; c=relaxed/simple;
	bh=+NCLRd3YfHvO1hmbPmpRoofqm9VaMz4KVcOzcUNUxXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D86B3QDJvGT0dQm9i1FNlgUeW28MOg4A/touVcilD3jnEAayREuDmRx8k+X2ahlA6t1uoVis5/Mc1hLzSKtJxNbyLVQE/kMCDWagkoRtkQ5I4oOB9Im2YeanypPGb36I+xORf86Iy6IuJ14J7vO4Dubd+uyyKmuR5/TBH86RRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=PSynmu0r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RH+LN6pz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="PSynmu0r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RH+LN6pz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1DB78EC01AE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:27:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 09:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790947653; x=
	1791034053; bh=jTMfTsiEMlzxek/TbvsILyPYgQbp0+XqvHkwulRW1Zk=; b=P
	Synmu0ra6GDwhBtCXjYEvFoF1W2Yl+yIobLahnf7NG97K/YccUZCZD1bXIE4GImU
	Dsl3HnvlmxD7ps42mqosb2DGROWzz2Dl/JSUitTwjGWu+tND594Wu/ahlJebnPr8
	1lEZZG0pg65BLMO8rkRbLhnBH0b05/11qLFVmrbzYredWzEKbGSTcJc2Pzgx5mkH
	l2OpJt0vNUl5eeO1UKbywO/I/51kEObknjxl0uBCEUI9HTR4EOcXkbUQ4J71j7T2
	3dOAntBo2pV8R+Trx9IwEudUSoebqR73XWORNRJcRo5AaLxnsdNeoB/JqyYazxXw
	aTUKBjmRKouPLfBUHsDCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790947653; x=1791034053; bh=j
	TMfTsiEMlzxek/TbvsILyPYgQbp0+XqvHkwulRW1Zk=; b=RH+LN6pzHLuZC7nOj
	stVMytn7j3SKYpnUajW/hj+zNDK3e+jh1viNy0WE0fKRz/6mYDofnTowZmGVd5k/
	vu7EN/HLzSrmH7FhEQR7cAZ++Eb9yWZr11E27tbcf0nbnkTBpcXIYxURV1gJ99jO
	l1q3rgJD0kmYDG6WwcuGJi3rFFf89A9bsL+O+nEQsUUrZdIAHAu4Thu8f0lGct8F
	xplFaXT2z66FN+zVZygfSljSZ1CyqzlJBR4Eg0KYhzRaelPXK1qZq6S4fy/5oPFK
	KsoX5vUYQQabbSJlTkg2tFvVl8fXMe6NHxAT1/j+EHmo5RK8QjGcOzeq/RXn4vsj
	w7KCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790947653; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KTeAwAyFtLUJWyyGyFJFCUoG6lvXKXIwB/X47+R1TjXcKPp
	dvCrX4oqzmvIHjxo2b+9ucFRxf0GB0Ih3V3pXJYezBKju3Lrwr0KwdX3XSff128c
	ZXeMmfetAGuwcSwkVTtVIJBJqplDHYYScGcp2r+WQSmTlHbXXf4cC5r6b9/C++wY
	vTYxh1/1egBjIG4dnQJXeBeAefJevngZ05t+XpqWajOsbjhqsrgCh6fwfzplPneK
	b+KhpQn5H0Yal5p9daohulmod2PEltqm5zmQUGUOcdHo6IvCA97WQF7PSUYRFC3R
	umZDi3QPzmCQC3ZnqCw39i9UmIy2Tq7sgJ+JtJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:A9g05DQD8x48dxGLYzvBN27VXQ71mqMZB7ziQ1p3p/Q=:+NCLRd3YfHvO1hmbPmpRoofqm9VaMz4KVcOzcUNUxXE=;
X-ME-Sender: <xms:RbG_aqyh7K-kB7RmNgOAbj9m7wXf2jPiRXU7kUsvFyToneu3FAsgzA>
    <xme:RbG_atQewBZ7banHV9bLt0kz2DIUTuEh__9byvgg2uWgvGMR7g85p2fq63r6WPOoG
    IgSrfCQSgdzWfvlM6nGm3X3prbbbqBiS7qBF3DWc5JdYPfqAbLqXq6K>
X-ME-Received: <xmr:RbG_ahWm2fyId2lpURnzMCU7pTJi_sCwc1zpGc2kdTx0xCL4ICt6fKWXsMI2TKKr2Ry0aohbLgwVDtRzTTG6atu79NgcC5Xn3r-sR-8fVTs>
X-ME-Proxy-Cause: dmFkZTES2ku0SqNb2DiDQqCKzJ1AhFM3ETkz+plOTKaUsCTU5JJBtioiH5rjMiRv5MB5cN
    6PcKOzzuLmD+RTUxITX+OCgg6daTq10FYd6xI2/Z3ClOrDJrnlRruXq4bg/TXcRF1aR/DF
    V2u6ujFRWukqFwwrvQ9y/KFKfemxtEvlVH4m1YuQgYDLMGSAZ0GchrMxUxC/CFs8X6epYm
    aYTQwlTbw3fC41S+K/kkF3S3wlr0PhdltW7YJrHQg8s6MIAmOCMUAnGIjSpBYZ+o806A3P
    UfUODwHscW3EQOv4z14Wj+7MW0rzpYCGey91tDk5q+gkXMZqhWTz61jtuk8Gpo1SOLU3PM
    BchlyJiBdOAh/m7YSCFGtQWePibBGjJoG35V9QURgG91mWQivH3sDM6S0rYS/5QE23+W+7
    eCxVP2Aej8p23Xf7egIa/HG5bddEpoG5uVc2ayVyNTf8lrmGvf1hlxzx5OA6eOhFPqyL3/
    4yFK7iajp9u7fjlYOPbt3oQR3+9Epb1NkRvpzfGm9FEm2+yqkokCaOyl2BjvEObhBbjsSU
    TmUs6IZVLK2ES8Q/Z5FF8GYzRhdclXJRz6xWXUt9b3LeehLS4AOkFyjqdpXxUruLUaZ0Gf
    sXPJtB1lXVKbVrJenPkNib29Lk3DQhFOeKzAObZg6QbteLbSY8P6RwiEed+g
X-ME-Proxy: <xmx:RbG_avaiXl60BVG78ld-htPbEYZDO7QJwiU0Yvhigf-BkBSi04m-7g>
    <xmx:RbG_an2cvXB05mcOpxHSN9xaPLa9HcL4F8-RiJ6ormyZ33YUQKPung>
    <xmx:RbG_ahg9JlNwMX89MZdVtqAKl4fW6UURqOh2ZiqLP6FepmHTQ5LZNg>
    <xmx:RbG_aramNmz26WXwnlQAd2HcSb_QDGj-HW6gIRDExwyxTyYpe73xeA>
    <xmx:RbG_av_I9FsLJWz7B99zrVrglWoQE7r7c7dnOKBcz2DV06mE-MtRp_JB>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 09:27:31 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v4 2/2] history: sign rewritten commits
Date: Fri,  2 Oct 2026 22:27:18 +0900
Message-ID: <20261002132718.3830-3-git@5ouma.me>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --gpg-sign/--no-gpg-sign support to git history and honor
commit.gpgSign when creating replacement commits. Thread the selected
signing key through direct rewrites and replayed descendants while
preserving the original author identity.

Load history configuration before parsing command-line options so
command-line signing options override commit.gpgSign.

Cover configuration, command-line precedence, explicit keys, split
commits, and replayed descendants with GPG-gated tests.

Signed-off-by: Souma <git@5ouma.me>
---
 Documentation/git-history.adoc | 18 +++++--
 builtin/history.c              | 96 +++++++++++++++++++++++++---------
 t/t3451-history-reword.sh      | 63 ++++++++++++++++++++++
 t/t3452-history-split.sh       | 44 ++++++++++++++++
 t/t3453-history-fixup.sh       | 39 ++++++++++++++
 t/t3454-history-drop.sh        | 50 ++++++++++++++++++
 t/t3455-history-squash.sh      | 61 +++++++++++++++++++++
 7 files changed, 342 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 2e2e31f521..1fcc30150a 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,11 +8,11 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]
-git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
-git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
-git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
-git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
+git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
+git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
+git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>
 
 DESCRIPTION
 -----------
@@ -180,6 +180,14 @@ OPTIONS
 `--reedit-message`::
 	Open an editor to modify the target commit's message.
 
+`-S[<key-id>]`::
+`--gpg-sign[=<key-id>]`::
+`--no-gpg-sign`::
+	GPG-sign rewritten commits. The _<key-id>_ argument is optional and
+	defaults to the committer identity; if specified, it must be stuck to
+	the option without a space. `--no-gpg-sign` is useful to countermand
+	both `commit.gpgSign` configuration and earlier `--gpg-sign`.
+
 `--empty=(drop|keep|abort)`::
 	Control what happens when a commit becomes empty as a result of the
 	fixup. This can happen in two situations:
diff --git a/builtin/history.c b/builtin/history.c
index 54cea3523f..43ba76f5a1 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -30,15 +30,15 @@
 #include "wt-status.h"
 
 #define GIT_HISTORY_DROP_USAGE \
-	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]")
+	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
 #define GIT_HISTORY_FIXUP_USAGE \
-	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]")
+	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
 #define GIT_HISTORY_REWORD_USAGE \
-	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
+	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]")
 #define GIT_HISTORY_SPLIT_USAGE \
-	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
 #define GIT_HISTORY_SQUASH_USAGE \
-	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -110,6 +110,30 @@ enum commit_tree_flags {
 	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
 };
 
+static int history_config(const char *var, const char *value,
+			  const struct config_context *ctx, void *data)
+{
+	const char **sign_commit = data;
+
+	if (!strcmp(var, "commit.gpgsign")) {
+		*sign_commit = git_config_bool(var, value) ? "" : NULL;
+		return 0;
+	}
+
+	return git_default_config(var, value, ctx, NULL);
+}
+
+#define OPT_HISTORY_GPG_SIGN(v) { \
+	.type = OPTION_STRING, \
+	.short_name = 'S', \
+	.long_name = "gpg-sign", \
+	.value = (v), \
+	.argh = N_("key-id"), \
+	.help = N_("GPG-sign rewritten commits"), \
+	.flags = PARSE_OPT_OPTARG, \
+	.defval = (intptr_t)"", \
+}
+
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
@@ -117,6 +141,7 @@ static int commit_tree_ext(struct repository *repo,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
+			   const char *sign_commit,
 			   struct commit **out,
 			   enum commit_tree_flags flags)
 {
@@ -160,7 +185,7 @@ static int commit_tree_ext(struct repository *repo,
 
 	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree,
 				   parents, &rewritten_commit_oid, original_author,
-				   NULL, NULL, original_extra_headers);
+				   NULL, sign_commit, original_extra_headers);
 	if (ret < 0)
 		goto out;
 
@@ -196,6 +221,7 @@ static int first_parent_tree_oid(struct repository *repo,
 static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
+					   const char *sign_commit,
 					   struct commit **out)
 {
 	struct object_id parent_tree_oid;
@@ -207,7 +233,8 @@ static int commit_tree_with_edited_message(struct repository *repo,
 		return -1;
 
 	return commit_tree_ext(repo, action, original, NULL, original->parents,
-			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
+			       &parent_tree_oid, tree_oid, sign_commit, out,
+			       COMMIT_TREE_EDIT_MESSAGE);
 }
 
 enum ref_action {
@@ -363,12 +390,14 @@ static int compute_pending_ref_updates(struct rev_info *revs,
 				       enum ref_action action,
 				       struct commit *original,
 				       struct commit *rewritten,
+				       const char *sign_commit,
 				       enum replay_empty_commit_action empty,
 				       struct replay_result *result)
 {
 	const struct name_decoration *decoration;
 	struct replay_revisions_options opts = {
 		.empty = empty,
+		.sign_commit = sign_commit,
 	};
 	char hex[GIT_MAX_HEXSZ + 1];
 	bool detached_head;
@@ -473,13 +502,14 @@ static int handle_reference_updates(struct rev_info *revs,
 				    struct commit *rewritten,
 				    const char *reflog_msg,
 				    int dry_run,
+				    const char *sign_commit,
 				    enum replay_empty_commit_action empty)
 {
 	struct replay_result result = { 0 };
 	int ret;
 
 	ret = compute_pending_ref_updates(revs, action, original, rewritten,
-					  empty, &result);
+					  sign_commit, empty, &result);
 	if (ret)
 		goto out;
 
@@ -533,6 +563,7 @@ static int cmd_history_fixup(int argc,
 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
 	enum ref_action action = REF_ACTION_DEFAULT;
 	enum commit_tree_flags flags = 0;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -546,6 +577,7 @@ static int cmd_history_fixup(int argc,
 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct merge_result merge_result = { 0 };
@@ -557,12 +589,12 @@ static int cmd_history_fixup(int argc,
 	bool skip_commit = false;
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -687,7 +719,7 @@ static int cmd_history_fixup(int argc,
 	if (!skip_commit) {
 		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
-				      &rewritten, flags);
+				      sign_commit, &rewritten, flags);
 		if (ret < 0) {
 			ret = error(_("failed writing fixed-up commit"));
 			goto out;
@@ -697,7 +729,7 @@ static int cmd_history_fixup(int argc,
 	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, empty);
+				       reflog_msg.buf, dry_run, sign_commit, empty);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -722,6 +754,7 @@ static int cmd_history_reword(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -729,6 +762,7 @@ static int cmd_history_reword(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -736,12 +770,12 @@ static int cmd_history_reword(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -756,7 +790,8 @@ static int cmd_history_reword(int argc,
 	if (ret)
 		goto out;
 
-	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
+	ret = commit_tree_with_edited_message(repo, "reworded", original,
+					      sign_commit, &rewritten);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;
@@ -765,7 +800,8 @@ static int cmd_history_reword(int argc,
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
+				       reflog_msg.buf, dry_run, sign_commit,
+				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -831,6 +867,7 @@ static int write_ondisk_index(struct repository *repo,
 static int split_commit(struct repository *repo,
 			struct commit *original,
 			struct pathspec *pathspec,
+			const char *sign_commit,
 			struct commit **out)
 {
 	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
@@ -900,8 +937,10 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
-			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents,
+			      &parent_tree_oid, &split_tree->object.oid, sign_commit,
+			      &first_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
 		goto out;
@@ -918,7 +957,8 @@ static int split_commit(struct repository *repo,
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
 	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
-			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
+			      new_tree_oid, sign_commit, &second_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
 		goto out;
@@ -946,6 +986,7 @@ static int cmd_history_split(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -953,6 +994,7 @@ static int cmd_history_split(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct commit *original, *rewritten = NULL;
@@ -961,12 +1003,12 @@ static int cmd_history_split(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc < 1) {
 		ret = error(_("command expects a committish"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -992,14 +1034,15 @@ static int cmd_history_split(int argc,
 		goto out;
 	}
 
-	ret = split_commit(repo, original, &pathspec, &rewritten);
+	ret = split_commit(repo, original, &pathspec, sign_commit, &rewritten);
 	if (ret < 0)
 		goto out;
 
 	strbuf_addf(&reflog_msg, "split: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
+				       reflog_msg.buf, dry_run, sign_commit,
+				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -1579,6 +1622,7 @@ static int cmd_history_squash(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	int edit = 1;
 	struct option options[] = {
@@ -1589,6 +1633,7 @@ static int cmd_history_squash(int argc,
 			 N_("perform a dry-run without updating any refs")),
 		OPT_BOOL('e', "edit", &edit,
 			 N_("edit the commit message")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -1598,13 +1643,13 @@ static int cmd_history_squash(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
 		ret = error(_("command expects a revision range"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -1629,7 +1674,7 @@ static int cmd_history_squash(int argc,
 
 	ret = commit_tree_ext(repo, "squash", oldest, message_template,
 			      oldest->parents, base_tree_oid, tip_tree_oid,
-			      &rewritten,
+			      sign_commit, &rewritten,
 			      edit ? COMMIT_TREE_EDIT_MESSAGE : 0);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1638,6 +1683,7 @@ static int cmd_history_squash(int argc,
 
 	ret = handle_reference_updates(&revs, action, tip, rewritten,
 				       reflog_msg.buf, dry_run,
+				       sign_commit,
 				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
@@ -1728,6 +1774,7 @@ static int cmd_history_drop(int argc,
 	};
 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -1738,6 +1785,7 @@ static int cmd_history_drop(int argc,
 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
 			       N_("how to handle descendants that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -1748,12 +1796,12 @@ static int cmd_history_drop(int argc,
 	bool head_moves = false;
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -1781,7 +1829,7 @@ static int cmd_history_drop(int argc,
 	rewritten = original->parents->item;
 
 	ret = compute_pending_ref_updates(&revs, action, original, rewritten,
-					  empty, &result);
+					  sign_commit, empty, &result);
 	if (ret) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index de7b357685..6dbe2143d3 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history reword subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 reword_with_message () {
 	cat >message &&
@@ -26,6 +27,37 @@ expect_log () {
 	test_cmp expect actual
 }
 
+test_reword_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "reword $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			reword_with_message $* HEAD~ <<-EOF &&
+			second reworded
+			EOF
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'can reword tip of a branch' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -77,6 +109,37 @@ test_expect_success 'can reword commit in the middle' '
 	)
 '
 
+test_reword_gpg_sign ! false
+test_reword_gpg_sign   true
+test_reword_gpg_sign   false --gpg-sign
+test_reword_gpg_sign ! true  --no-gpg-sign
+test_reword_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_reword_gpg_sign   false --no-gpg-sign --gpg-sign
+
+test_expect_success GPG 'reword uses an explicit signing key for rewritten history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		reword_with_message -SB7227189 HEAD~ <<-EOF &&
+		second reworded
+		EOF
+
+		git verify-commit HEAD~ &&
+		git verify-commit HEAD &&
+		git log -2 --format=%GK >actual &&
+		cat >expect <<-\EOF &&
+		65A0EEA02E30CAD7
+		65A0EEA02E30CAD7
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'can reword commit in the middle even on detached head' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
index 8ed0cebb50..e96f492cc6 100755
--- a/t/t3452-history-split.sh
+++ b/t/t3452-history-split.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history split subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 # The fake editor takes multiple arguments, each of which represents a commit
 # message. Subsequent invocations of the editor will then yield those messages
@@ -36,6 +37,42 @@ expect_tree_entries () {
 	test_cmp expect actual
 }
 
+test_split_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "split $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit initial &&
+			touch bar foo &&
+			git add . &&
+			git commit -m split-me &&
+			test_commit tip &&
+
+			git config commit.gpgsign $conf &&
+			set_fake_editor 'first' 'second' &&
+			git history split $* HEAD~ <<-EOF &&
+			y
+			n
+			EOF
+
+			$must_fail git verify-commit HEAD~2 &&
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'refuses to work with merge commits' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -141,6 +178,13 @@ test_expect_success 'can split up tip commit' '
 	)
 '
 
+test_split_gpg_sign ! false
+test_split_gpg_sign   true
+test_split_gpg_sign   false --gpg-sign
+test_split_gpg_sign ! true  --no-gpg-sign
+test_split_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_split_gpg_sign   false --no-gpg-sign --gpg-sign
+
 test_expect_success 'can split up root commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t3453-history-fixup.sh b/t/t3453-history-fixup.sh
index 868298e248..cd20a23115 100755
--- a/t/t3453-history-fixup.sh
+++ b/t/t3453-history-fixup.sh
@@ -3,6 +3,7 @@
 test_description='tests for git-history fixup subcommand'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 fixup_with_message () {
 	cat >message &&
@@ -21,6 +22,37 @@ expect_changes () {
 	test_cmp expect actual
 }
 
+test_fixup_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "fixup $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			echo fix >>second.t &&
+			git add second.t &&
+			git history fixup $* HEAD~ &&
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'errors on missing commit argument' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -229,6 +261,13 @@ test_expect_success 'preserves commit message and authorship' '
 	)
 '
 
+test_fixup_gpg_sign ! false
+test_fixup_gpg_sign   true
+test_fixup_gpg_sign   false --gpg-sign
+test_fixup_gpg_sign ! true  --no-gpg-sign
+test_fixup_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_fixup_gpg_sign   false --no-gpg-sign --gpg-sign
+
 test_expect_success 'updates all descendant branches by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo --initial-branch=main &&
diff --git a/t/t3454-history-drop.sh b/t/t3454-history-drop.sh
index 68a86d1e37..5b21078a7e 100755
--- a/t/t3454-history-drop.sh
+++ b/t/t3454-history-drop.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history drop subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 expect_graph () {
 	cat >expect &&
@@ -16,6 +17,34 @@ expect_log () {
 	test_cmp expect actual
 }
 
+test_drop_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "drop $* with commit.gpgsign=$conf $will sign replayed descendants" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			git history drop $* HEAD~ &&
+
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'errors on missing commit argument' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -88,6 +117,27 @@ test_expect_success 'drops a commit in the middle and replays descendants' '
 	)
 '
 
+test_drop_gpg_sign ! false
+test_drop_gpg_sign   true
+test_drop_gpg_sign   false --gpg-sign
+test_drop_gpg_sign ! true  --no-gpg-sign
+test_drop_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_drop_gpg_sign   false --no-gpg-sign --gpg-sign
+
+test_expect_success GPG 'drop has no commit to sign when dropping the tip' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+
+		git history drop --gpg-sign HEAD &&
+
+		test_must_fail git verify-commit HEAD
+	)
+'
+
 test_expect_success 'drops the HEAD commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index d21e9d9fc4..237afdfa26 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -3,6 +3,7 @@
 test_description='tests for git-history squash subcommand'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 stage_file () {
 	printf "%s\n" "$1" >file &&
@@ -40,6 +41,66 @@ check_commit_author () {
 	test_cmp expect actual
 }
 
+test_squash_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "squash $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+			test_commit fourth &&
+
+			git config commit.gpgsign $conf &&
+			git history squash --no-edit $* HEAD~3..HEAD~1 &&
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
+test_squash_gpg_sign ! false
+test_squash_gpg_sign   true
+test_squash_gpg_sign   false --gpg-sign
+test_squash_gpg_sign ! true  --no-gpg-sign
+test_squash_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_squash_gpg_sign   false --no-gpg-sign --gpg-sign
+
+test_expect_success GPG 'squash uses an explicit signing key for rewritten history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+
+		git history squash --no-edit -SB7227189 HEAD~3..HEAD~1 &&
+
+		git verify-commit HEAD~ &&
+		git verify-commit HEAD &&
+		git log -2 --format=%GK >actual &&
+		cat >expect <<-\EOF &&
+		65A0EEA02E30CAD7
+		65A0EEA02E30CAD7
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'setup linear history touching two files' '
 	test_commit base file a start &&
 	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
-- 
2.56.0

