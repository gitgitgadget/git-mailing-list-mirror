Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4037FF5D
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344443; cv=none; b=n4Tr17/D3tM2pW+y5fyFfmlrhM4NmN2IubSHpa1bjfHHZFHuZeI0T45Sk9fdXHq9LLMlRA5JUlpUfRI4nKhEz8eUDnURxkGS8MXyd80vhhlFOkJLqpQOQ0MhF4LaVqlTR+B32CnESHyDkrQ7B5CAJLryO2gYSvTWMTFS8ZVPQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344443; c=relaxed/simple;
	bh=oRsYUt+OvFNQ3qt3Pr+cFVywbi4vUNqoaQ08vKYI3RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrqVOHMaEkwIC6ALZpvcM9/UvqkB9ToypAf0gUUHVHI8rMyVNrGH/VsYDVdef+dq567/pTPA3xFG2MY919mHFU6rQKy9dl03NczZ8USWmuNGjuObNEoPQAZ6kO197S8neEMTR4u+MG2Hjn2aMpNEUz63hcMKOetn9jpYC/OYHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=laIdKvny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLfqAKGT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="laIdKvny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLfqAKGT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 09EC91D00112;
	Mon,  6 Jul 2026 09:27:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jul 2026 09:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783344437;
	 x=1783430837; bh=XQPBeukgYe9N+8r2CyyHDIijfdh9KpXhjW7GWU0YD0M=; b=
	laIdKvnyCzBWSkIB00hKfexgFzdp4DWSZ4H94QoLVGk0aSegYIOuJxkC7V8N5+gH
	rmMo7zHvPD9aXv0NosFHgWR55k7Ssks4sDPtL3qcFueqUyV7+7giPFHucJkJflce
	3FUOZzxjrHwtPL5YxvxG1A5ya77PlDw+wXrQ1QfenOZSeDy3ojwOOcX4Bh8pe+S7
	8USFCT1ar6PKYhZ4X7GDVctWmGfkwD3mvUTw7wAxo4bh02cBywOImk2sLmlT005f
	o+5gwMvHbJDlf28lj791WV/1mORjE1QFu7Lu1V2f7njsSU2RDeQ0Jenz26nUcgEz
	oCnVD0til6uWa5EtAnL5/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783344437; x=
	1783430837; bh=XQPBeukgYe9N+8r2CyyHDIijfdh9KpXhjW7GWU0YD0M=; b=S
	LfqAKGT5xqNtPXXL9dXhB5cSKDGdcnIBg98Ljq6HNlW5ntdl50NsPfV7yOxriz3E
	0r+byGlE8HyE1e13724f/sTop7DpS7WdDJe9gmnDxMngAfj+o9uxIfxqgObKgoBp
	eyDjBowOl5JEzC5RSOrv/CZYiZTfMlBc88yvdqaeUzi3T6ESPwHxrXsq9GceMB7d
	pT4tIcwhL3oVwLjqhKygKj22GMzjBwfI8dLre2gejQDHANIekEmQroeP/b1oQnUU
	T9stTSZswI++YOXoBHtRCn37Be/CFvX6TdeoT8xuwcI4zNNx/ino4quE2gSIXQAj
	2sYoxq2embGNamBVe9Inw==
X-ME-Sender: <xms:Na1Las9laTzAW7enx6KoWDddeY-9QxCAeKK32B5BK2EYJytLzPrK8g>
    <xme:Na1LasJK_ngA3FCBo3sQ9kseQaXbRfg3cp4Q_JxsfZIiAzmtwPBczNmxb410XANQP
    78ldWISVHkB7rmtPmeVA8kHwmlk-3EjIsq185eSq_Fwhsxayern4w>
X-ME-Received: <xmr:Na1LavYoxlbdxltXMoAOsmnnCH_qrYumvvu-nHbavx41TCr2Zc36l3IqQYYPsEBjxapotr0XQvnE4vosFggPBxiXpjpsfoB6C9hmJhfWAno>
X-ME-Proxy-Cause: dmFkZTGmkoL1fQMVt3Y9VhFIAhL9ZJIzDkq3EWLQg2Xy60xhBQNOdU3yeSNWtyur7wa+zp
    HmQVWqwr5HOVD8HHxN05/bzMr12IZT1tfZFhB4fEzrvxjBhOC/mwgYAKTmjYGlyR1pZiFr
    xkvOmAp4zJ7FN8u8y0ftJxNlCFqapxv+dvBgtjCV4GoMNfHGzoN3gWOwjSfGiVZwdyIgsf
    BqUW0s2PAypR4UoEipHqRldrFUvJ+Wx+cG6QP27viYk+PUptz21xn77awYf9PjvL7kzx19
    mYqXICYGBgkOCOG4hQJ6La/K3kujvDaHLDAPasiem9y1yJctTXrDjKFVkzSU9xQMcyg8BO
    DtwHaVZvP1Iy4e4jJ812K5ZsZgmLbKDb4DpryWu+i61tk4feFLqq43o9eWFbJn3j0ufsYZ
    +xTqVCK7udofh9nEPwaf5RUegkIotbydAJDR4ZnzWPYPksO0+fVXN8WqHF+fUdjPY9lepp
    7EFvSdFsgrHXGVD2Wk4yBIx9iVjbAe29s3Htq+UkqlUDtyebwEZefG2Gz14Ub1Avvtvsnl
    iz9BSoWoPPM+PZQYMVRgAVsKUcxTS5Sge7YXgbCGYDOVWVP9KtoBTXipg4AZzklATaQ7cg
    8Xe/3Lc7TXBci9R6ohBylSRg74kD5sZboKr/oh+R4cIQjnl5TebofFQ6QRGw
X-ME-Proxy: <xmx:Na1LamL4vvpZb1buDbU3T14jo7TpRQSQlIoeZsFPJKqc8etw00oA_g>
    <xmx:Na1LalBJMbeqepA8dwWY32EGzxvv6Eo17obrWMjBVm3QaUo0msMX6A>
    <xmx:Na1LajqYK0j2O5e_E2_WMvNe1aRLh2pAZYPZSpTwbIIiSIPEhzJGjQ>
    <xmx:Na1Laoj2nvRRQGis8yC5iVTGyLlCV02vRdP3LonVH4zx6zTaRBwH4Q>
    <xmx:Na1Lakq0NeBSS7PEo9r5ENA6uO4hba1WyMsMqrjDk0cHZDOi2FwNlVUi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:27:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00198652 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 13:27:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 15:27:06 +0200
Subject: [PATCH v4 3/5] builtin/refs: add "update" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pks-refs-writing-subcommands-v4-3-d51f6ce7f830@pks.im>
References: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
In-Reply-To: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Add a new "update" subcommand which mirrors `git update-ref <refname>
<oldoid> <newoid>`. This follows the same reasoning as the preceding
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |  12 ++
 builtin/refs.c              |  55 +++++++++
 t/meson.build               |   1 +
 t/t1465-refs-update.sh      | 268 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 2633934463..6475bdcc62 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -21,6 +21,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
+git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
 
 DESCRIPTION
 -----------
@@ -58,6 +59,13 @@ delete::
 	reference is only deleted after verifying that it currently contains
 	`<old-value>`.
 
+update::
+	Update the given reference to point at `<new-value>`. If `<old-value>`
+	is given, the reference is only updated after verifying that it
+	currently contains `<old-value>`. As a special case, an all-zeroes
+	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
+	ensures that the branch does not yet exist.
+
 OPTIONS
 -------
 
@@ -99,6 +107,10 @@ include::pack-refs-options.adoc[]
 
 The following options are specific to commands which write references:
 
+`--create-reflog`::
+	Create a reflog for the reference even if one would not ordinarily be
+	created.
+
 `--message=<reason>`::
 	Use the given <reason> string for the reflog entry associated with the
 	update. An empty message is rejected.
diff --git a/builtin/refs.c b/builtin/refs.c
index edb7d61663..08453ae1c8 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -24,6 +24,9 @@
 #define REFS_DELETE_USAGE \
 	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
 
+#define REFS_UPDATE_USAGE \
+	N_("git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo)
 {
@@ -224,6 +227,56 @@ static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_update(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_update_usage[] = {
+		REFS_UPDATE_USAGE,
+		NULL
+	};
+	const char *message = NULL;
+	unsigned flags = 0;
+	struct option opts[] = {
+		OPT_STRING(0, "message", &message, N_("reason"),
+			   N_("reason of the update")),
+		OPT_BIT(0 ,"no-deref", &flags,
+			N_("update <refname> not the one it points to"),
+			REF_NO_DEREF),
+		OPT_BIT(0, "create-reflog", &flags, N_("create a reflog"),
+			REF_FORCE_CREATE_REFLOG),
+		OPT_END(),
+	};
+	struct object_id newoid, oldoid;
+	const char *refname;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, opts, refs_update_usage, 0);
+	if (argc < 2 || argc > 3)
+		usage(_("update requires reference name, new value and an optional old value"));
+
+	if (message && !*message)
+		die(_("refusing to perform update with empty message"));
+
+	repo_config(repo, git_default_config, NULL);
+
+	refname = argv[0];
+	if (repo_get_oid_with_flags(repo, argv[1], &newoid,
+				    GET_OID_SKIP_AMBIGUITY_CHECK))
+		die(_("invalid new object ID: '%s'"), argv[1]);
+	if (argc == 3 &&
+	    repo_get_oid_with_flags(repo, argv[2], &oldoid,
+				    GET_OID_SKIP_AMBIGUITY_CHECK))
+		die(_("invalid old object ID: '%s'"), argv[2]);
+
+	ret = refs_update_ref(get_main_ref_store(repo), message, refname,
+			      &newoid, argc == 3 ? &oldoid : NULL, flags,
+			      UPDATE_REFS_MSG_ON_ERR);
+
+	if (ret < 0)
+		ret = 1;
+	return ret;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -236,6 +289,7 @@ int cmd_refs(int argc,
 		REFS_EXISTS_USAGE,
 		REFS_OPTIMIZE_USAGE,
 		REFS_DELETE_USAGE,
+		REFS_UPDATE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -246,6 +300,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
 		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
 		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
+		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 1ccf08a3b5..2063962dab 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -224,6 +224,7 @@ integration_tests = [
   't1462-refs-exists.sh',
   't1463-refs-optimize.sh',
   't1464-refs-delete.sh',
+  't1465-refs-update.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1465-refs-update.sh b/t/t1465-refs-update.sh
new file mode 100755
index 0000000000..a9becdda99
--- /dev/null
+++ b/t/t1465-refs-update.sh
@@ -0,0 +1,268 @@
+#!/bin/sh
+
+test_description='git refs update'
+
+. ./test-lib.sh
+
+setup_repo () {
+	git init "$1" &&
+	test_commit -C "$1" A &&
+	test_commit -C "$1" B
+}
+
+test_ref_matches () {
+	git rev-parse "$1" >expect &&
+	echo "$2" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'update creates a new reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		test_ref_matches refs/heads/foo "$A"
+	)
+'
+
+test_expect_success 'update an existing reference without oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update refs/heads/foo $B &&
+		test_ref_matches refs/heads/foo $B
+	)
+'
+
+test_expect_success 'update with matching oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update refs/heads/foo $B $A &&
+		test_ref_matches refs/heads/foo $B
+	)
+'
+
+test_expect_success 'update with stale oldvalue fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B $B 2>err &&
+		test_grep " but expected " err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update can create a new branch with oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A $ZERO_OID 2>err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update can create a new branch without oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A 2>err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update refuses to create preexisting branch' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B $ZERO_OID 2>err &&
+		test_grep "reference already exists" err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update can delete a branch with oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A 2>err &&
+		git refs update refs/heads/foo $ZERO_OID $A 2>err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update can delete a branch without oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A 2>err &&
+		git refs update refs/heads/foo $ZERO_OID 2>err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update refuses to delete a branch with mismatching value' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A 2>err &&
+		test_must_fail git refs update refs/heads/foo $ZERO_OID $B 2>err &&
+		test_grep " but expected " err &&
+		git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update refuses to create preexisting branch' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B $ZERO_OID 2>err &&
+		test_grep "reference already exists" err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+
+test_expect_success 'update with invalid new value fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs update refs/heads/foo invalid-oid 2>err &&
+		test_grep "invalid new object ID" err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update with invalid old value fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B invalid-oid 2>err &&
+		test_grep "invalid old object ID" err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update --no-deref rewrites the symref itself' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git symbolic-ref refs/heads/symref refs/heads/foo &&
+		git refs update --no-deref refs/heads/symref $B &&
+		test_must_fail git symbolic-ref refs/heads/symref &&
+		test_ref_matches refs/heads/symref $B &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update does not create a reflog by default' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/foo $A &&
+		test_must_fail git reflog exists refs/foo
+	)
+'
+
+test_expect_success 'update creates a reflog with --create-reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update --create-reflog refs/foo $A &&
+		git reflog exists refs/foo
+	)
+'
+
+test_expect_success 'update with message records reason in reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update --message=update-reason refs/heads/foo $B &&
+		git reflog show refs/heads/foo >actual &&
+		test_grep "update-reason$" actual
+	)
+'
+
+test_expect_success 'update with empty message fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update --message= refs/heads/foo $B 2>err &&
+		test_grep "empty message" err
+	)
+'
+
+test_expect_success 'update with too few arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs update refs/heads/foo 2>err &&
+	test_grep "requires reference name, new value" err
+'
+
+test_expect_success 'update with too many arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		test_must_fail git refs update refs/heads/foo $A $B extra 2>err &&
+		test_grep "requires reference name, new value" err
+	)
+'
+
+test_done

-- 
2.55.0.795.g602f6c329a.dirty

