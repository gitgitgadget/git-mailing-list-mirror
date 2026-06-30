Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C040862E
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820164; cv=none; b=P6E9sDAFX9/lnJuoTyo5jeDdbwR3yhCNNJ7ZcbDi3L1GWHtHIX9Y1J7IN+BSR6mdxmQnnzliNcEBrvo1QzfArBkyuKo+qDYPQ7ixsuXvRFAQS2vm7Nc1EOgIaceKu00V7hzfARajxTikK5moayFxaWJFA9yDdM8Ffuy3tyBXSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820164; c=relaxed/simple;
	bh=NQvKi5xscfwg7sYcKrAPbiURqIE042Bqw9yogAvtMDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cO/7NgPM07SRq+Pr+kfblF9CJZfALOvxYf8jbKU35Crt9F61JyZka/rDQycwSiCPNCqkzrm7XLziogaYTnURlGMCZcvlNc5nbJvRkaNgbQgoNXEM64tIF6vdgDqoa7l2fZoRjppM7NIhbCqZKBuzvTAsweSKpRcRyTfn6q+cGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bg5RglzW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YaE31LQy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bg5RglzW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YaE31LQy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 214F37A00A4;
	Tue, 30 Jun 2026 07:49:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 30 Jun 2026 07:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820161;
	 x=1782906561; bh=ruKL9sstOHMNUki75cba/Af4YrDugOMtTjMfutHDRDQ=; b=
	Bg5RglzWWWX7LpeRaFUX4NrI0oVHqnfOd6EPSdAM/3FAZNy+V3o5VxubKJD8RCw2
	lMa5Nmk1kjJWsIsfSAY7U1tmPtNl4LG60Lj2LX4Y5V0NxjouQaFoz1B86nPE5MD/
	f3LpMGPalCFgmQj1jS4wsqa+UW2kOpvZahndzRNiwxCMkfTbgLMdTrwSUKs2WPPg
	jJzaT35B1FFpx4Vw8Z2e1bct3HeOW+tzvZcoaKEKI4knkEYwipZ9mo/Jxgcizcay
	8e37OPmEcDWO4bGSg3/aBgF8sC/HYywNkUepEW99ZfxuvSdTeWu8kBPyYk/7cHEQ
	hZ+4v6E3Dwx1QsS6G0M80w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820161; x=
	1782906561; bh=ruKL9sstOHMNUki75cba/Af4YrDugOMtTjMfutHDRDQ=; b=Y
	aE31LQy/tU9kJJMXFh5a9Y2SJo24aG9c8w1/N4K9JgWs3aCxyw9HvdgtOFDreHSN
	o4J+PGuK0qcDU0yBfZDU54skZFV6aePKhMgeAC6jaJWcwqQG3225kloi7m46mP3P
	ZY9ho6PnSLAP1T/G9Rbt5xLKq9FarNp/E5CcJd+Qtm7sGCBAc6qAB12gMNC2pszt
	DKJ52BdsNHVogzSW86+Qk2XeXV9gdAVJHGPjUU1pKjOALDPbOuX6/KKJLy3t24ze
	Oj0sUHe1c0vLxESf8rEB6OHx9MGM6E+vvEg+egm7T0Pcg6EpqU8buGVKu11cANwx
	zEzy/JW1GYR/JXGmb+hlw==
X-ME-Sender: <xms:Qa1DakYZSF_XTTVS4x1PoYCFOffqV3UAAdgWnZcpf8_qRyJpKKFYUw>
    <xme:Qa1DalZGgzGHIr9-cq4iRqsvjQZ1jLxAdfAoDZ_oATOS_R4kbdw1oXVjDZ9vN9c-w
    KwGHmtU78Luz9SpSFIgmmiAAs_6FBAB_8xl7RNCINp0JWN65bUR9g>
X-ME-Received: <xmr:Qa1Dasksp6WAGw6pLewUwWClksh-zvjYZN4zoSazS8t2dp0dh-b4ieS-P9YO6B8L9pZTlENs66IaNhFkMpbEInafoYnNV4GEZooGwlSKlJHTFw>
X-ME-Proxy-Cause: dmFkZTGa65W6+of1Q4+eW6G2IMPlthsJffBXuRILpRstTzA1oUOCmOWTHFUW4BiZ64SG6R
    v0B+R/yU7mkHHGco8rzYcWUss+p9sUt2A4vEaicKdlFfvp1ySYZfQ8+jnPZ0WJqVAI/wT1
    haTi4iiqGSMRmt75N9WtsQUF4C1ZmWBP5HHRHgGhK3sSwA/1aElaMC7bDURFAnu4El1raE
    Um7DuVgwCbmi2FtLLatW2+HbwKcGGU8whY4hHj3Lv27JPYKUl6EXbhQKCEta0Mg1XC2blD
    4BBCkWWmyG53ivt/t4iHYa8gFDObrpO5+XJoaoFtTd6w99tqre8SYtvH2Op4rncNDeCKNe
    n2q1/8xgQvl59FDENNBCSEf5xv1O1m9vAhETxlfAGVMkzEuPd/rNCoyKqDPH2bGiJWiZSt
    4f8ApqfPfNwu1jdxuZn2lAOJKfxbFhSpx+P+rSpV34XUX7350vnVJQnrU1gYUzWi/LaOp3
    v6M0wJ0Gfeks4Ro8n67219YpJv47gFqZK8In/RN7B57wh5V6lsEkZ9yAetuk3I4OB8+1eM
    izsJDsFqnnXNtptvsgEIWQyWIUfCOltdfeX5CMtu+GYIfLJEKOAlibIsZEtQ3acAunvfBZ
    kvdvgBtrrrg7NuFxEpw5RbEXKi3bSLMRECv5uGAaBlqXMbKwQICJFbB3s7HA
X-ME-Proxy: <xmx:Qa1DapzwkHkRAJOjcp1C26SsNhPStuTA77X7-k2krMx8TTmGGXNfaQ>
    <xmx:Qa1DaiMYefxt9KxBxLxO6QLkIGLRTyaa2YY2qbj-S5-N7NAAAqQbpA>
    <xmx:Qa1DalSkGoOmSfb_ojPROixiTfqb6Nyk0lpLbqv4EKXCihdvChvkWA>
    <xmx:Qa1DaoYiAPPqVOYXyiMUq83zEEVWCaQ1Q473utiukGcXDyz320PIaQ>
    <xmx:Qa1DanxCce1MRJ2-MU25lXxwkd3rynXLankjAwLQnVVU9ofzFcHujTcV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:49:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb63f9f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:49:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:49:07 +0200
Subject: [PATCH v3 4/5] builtin/refs: add "create" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-refs-writing-subcommands-v3-4-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The "update" subcommand cannot only update an existing reference, but it
can also create new branches and delete existing branches by specifying
the all-zeroes object ID as either old or new value. Despite that, we
already have the "delete" subcommand as a handy shortcut so that a user
can easily delete a branch. This relieves them of needing to understand
the more arcane uses of the "update" command, and of counting the number
of zeroes they need to pass.

But while we have a "delete" subcommand, we don't have an equivalent
that would allow the user to create a new branch, which creates a
certain asymmetry.

Add a new "create" subcommand to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |   5 ++
 builtin/refs.c              |  52 +++++++++++++++
 t/meson.build               |   1 +
 t/t1466-refs-create.sh      | 151 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 6475bdcc62..e6a3528349 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -20,6 +20,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [ --stdin | (<pattern>...)]
 git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
+git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
 git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
 git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
 
@@ -53,6 +54,10 @@ optimize::
 	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
 	offers identical functionality.
 
+create::
+	Create the given reference, which must not already exist, pointing at
+	`<new-value>`.
+
 delete::
 	Delete the given reference. This subcommand mirrors `git update-ref -d`
 	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
diff --git a/builtin/refs.c b/builtin/refs.c
index 08453ae1c8..1ebaf30149 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -21,6 +21,9 @@
 #define REFS_OPTIMIZE_USAGE \
 	N_("git refs optimize " PACK_REFS_OPTS)
 
+#define REFS_CREATE_USAGE \
+	N_("git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>")
+
 #define REFS_DELETE_USAGE \
 	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
 
@@ -181,6 +184,53 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
 	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
 }
 
+static int cmd_refs_create(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_create_usage[] = {
+		REFS_CREATE_USAGE,
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
+	struct object_id newoid;
+	const char *refname;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, opts, refs_create_usage, 0);
+	if (argc != 2)
+		usage(_("create requires reference name and an object ID"));
+
+	if (message && !*message)
+		die(_("refusing to perform update with empty message"));
+
+	repo_config(repo, git_default_config, NULL);
+
+	refname = argv[0];
+	if (repo_get_oid_with_flags(repo, argv[1], &newoid, GET_OID_SKIP_AMBIGUITY_CHECK))
+		die(_("invalid object ID: '%s'"), argv[1]);
+	if (is_null_oid(&newoid))
+		die(_("cannot create reference with null new object ID"));
+
+	ret = refs_update_ref(get_main_ref_store(repo), message, refname,
+			      &newoid, null_oid(repo->hash_algo), flags,
+			      UPDATE_REFS_MSG_ON_ERR);
+
+	if (ret < 0)
+		ret = 1;
+	return ret;
+}
+
 static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
 			   struct repository *repo)
 {
@@ -288,6 +338,7 @@ int cmd_refs(int argc,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
 		REFS_EXISTS_USAGE,
 		REFS_OPTIMIZE_USAGE,
+		REFS_CREATE_USAGE,
 		REFS_DELETE_USAGE,
 		REFS_UPDATE_USAGE,
 		NULL,
@@ -299,6 +350,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
 		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
+		OPT_SUBCOMMAND("create", &fn, cmd_refs_create),
 		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
 		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
 		OPT_END(),
diff --git a/t/meson.build b/t/meson.build
index 2063962dab..541e6f919c 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -225,6 +225,7 @@ integration_tests = [
   't1463-refs-optimize.sh',
   't1464-refs-delete.sh',
   't1465-refs-update.sh',
+  't1466-refs-create.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1466-refs-create.sh b/t/t1466-refs-create.sh
new file mode 100755
index 0000000000..cfb21bf863
--- /dev/null
+++ b/t/t1466-refs-create.sh
@@ -0,0 +1,151 @@
+#!/bin/sh
+
+test_description='git refs create'
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
+test_expect_success 'create a new reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs create refs/heads/foo $A &&
+		test_ref_matches refs/heads/foo "$A"
+	)
+'
+
+test_expect_success 'create fails when the reference already exists' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs create refs/heads/foo $A &&
+		test_must_fail git refs create refs/heads/foo $B 2>err &&
+		test_grep "reference already exists" err &&
+		test_ref_matches refs/heads/foo "$A"
+	)
+'
+
+test_expect_success 'create with null new value fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs create refs/heads/foo $ZERO_OID 2>err &&
+		test_grep "null new object ID" err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'create with invalid new value fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs create refs/heads/foo invalid-oid 2>err &&
+		test_grep "invalid object ID" err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'create does not create a reflog by default' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs create refs/foo $A &&
+		test_must_fail git reflog exists refs/foo
+	)
+'
+
+test_expect_success 'create creates a reflog with --create-reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs create --create-reflog refs/foo $A &&
+		git reflog exists refs/foo
+	)
+'
+
+test_expect_success 'create with message records reason in reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs create --message="create reason" refs/heads/foo $A &&
+		git reflog show refs/heads/foo >actual &&
+		test_grep "create reason$" actual
+	)
+'
+
+test_expect_success 'create with symref target creates target reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git symbolic-ref refs/heads/symref refs/heads/target &&
+		git refs create refs/heads/symref $A &&
+		git reflog exists refs/heads/target
+	)
+'
+
+test_expect_success 'create with symref target and --no-deref refuses to create reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git symbolic-ref refs/heads/symref refs/heads/target &&
+		test_must_fail git refs create --no-deref refs/heads/symref $A 2>err &&
+		test_grep "dangling symref already exists" err &&
+		test_must_fail git reflog exists refs/heads/target
+	)
+'
+
+test_expect_success 'create with empty message fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		test_must_fail git refs create --message= refs/heads/foo $A 2>err &&
+		test_grep "empty message" err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'create without arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs create 2>err &&
+	test_grep "requires reference name" err
+'
+
+test_expect_success 'create with too many arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs create refs/heads/foo a b 2>err &&
+	test_grep "requires reference name" err
+'
+
+test_done

-- 
2.55.0.795.g602f6c329a.dirty

