Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93223ED5B3
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691385; cv=none; b=npxCPAsjU+NSRjvXoZcy7T7emPUOl2Jy6SyHZOu5bL+OpIcczzQEdpLHvE26Mtpe92WSeSeAc7UYZUkYUR3dpfIhTFXSLs83d7xURib4B1f+TOJI7kBBPluTklYaVp74UTdtWZ7J5IOBnYfMZnQ9KvEiKLORYHt8nwg6C3x5zXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691385; c=relaxed/simple;
	bh=nfq01AMIlYN0i4rzia+Bnv/P6/02vogEkiZuqt/YGWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIPCwTLddGqCdYFMTaqHYjvwUI8yR/F2gjSsc1u7nd/qWlvo9c+7g5mM053XXdZIuGqPb9CbVOaCe0qJfcDyUzpcz6cBX5eLhvxVL2CgGgifMs3VGDwVOpUnHYvR6gp5kq1WJZbq/AL0v5n6Wu5hR50yawZMgp+ESphzQr026b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oy75CvpZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbMBw7fl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oy75CvpZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbMBw7fl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 077487A0165;
	Wed, 17 Jun 2026 06:16:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 17 Jun 2026 06:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781691382;
	 x=1781777782; bh=6zS1wOLWg5CYIxcOqnEkOilrvLuQlBjHCZ11TPaumgo=; b=
	oy75CvpZ69fne/QNDjTr9T8XTVhMmqqqYhiDHmtAzFp9jRrH3AN1y/LIxRBU8fuw
	Q/tqmPQhHWBsGcUcVpkKbwXe3krYebajPc+6zbIBljNyuZgI0lcVW5IvMdPJcn/E
	cpf+3w75PPbvxe94PTLewA5LALSksuagrzY2V0yvHspm29Fw2pyf9YVPntcGvyYO
	KW5s3ZaXj/7w6KN06OX20/BB6S6G+QmnM/jfoqwmnzeIUvpPqMXBfHw4OclR6ete
	0yQStyoq2oLdTUtWrfUttNnTHbzahKAWL0dt44zwjmSpdLJtDwTV0SWz5YJ8RstM
	o4pd4Rv6+xe4O/wS7kCWRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781691382; x=
	1781777782; bh=6zS1wOLWg5CYIxcOqnEkOilrvLuQlBjHCZ11TPaumgo=; b=R
	bMBw7flDNRzw86PuIa/4+QuOqHNxuiYezBAbmEj61Xn/wOZeRs8TUssbWk19oR84
	me1zh/Bcr3dZpl6cbq74fMuRUelgwX3fhI7seaCLxuVZ0NbaDWkpYUz8hJr2PubL
	J3vztJA1SLOH9qULpLfQAsxZXg8rDNyV5SrCN5utNa5/rU9fz+/exw4hGdQc41hM
	EcA0vS57rI1oPfoNaIeuz2Dra53JGBEwdlUKwXaDkqnUpOSG8YFjerPV49RZ7YdD
	rkkD5XLLNyfbuVTFMzC/I1hVN2ZDVCvQsu4lNJfFlF1AQVRpVLPYuTQY8hx8wpJa
	cswC0hfesxO9U63sL3SMQ==
X-ME-Sender: <xms:9nMyatHHJnUIFeIIvnxbob-13PFBVosSyivwdsBf_01EM98Zj8Fgsg>
    <xme:9nMyaoV5SASH9mDAq5d-F2J-EflssPOxM6sAdZ1_AtFh2Wesxz2C42P9upuxMGHIG
    yMjnTHcrI_hG3X3daZbYJVlmyrS0__dstszMsX8tHLKwNscJp2bhQ>
X-ME-Received: <xmr:9nMyaswx7oCYamwUieBuwVGquGCh4NsUuUaZtlEro6bnYoSzCNtnMp2V_9XGyImB4f93DrCftgBwmeZ3sd9s7B1EAUJgAJG9S--5bqw>
X-ME-Proxy-Cause: dmFkZTGPPwBHyAXz5x1I7OYOiRdtCrhtNG4XnRxyMbqSN7NXuq7recUrUDnRYJ73MG2KVT
    bstzfeIosm0JsDHqZTEeQMzNZKP2I6LGLfLNaMP+/nbCc0Wv9EG8zprdHaBz7FnJJi3U8u
    uFOFzIIi221V06qZlojMOSN4QVLhJ66IdtGkMigldyBsQwpndHkMrMJ9L7QXYgeY6j+eB0
    uwblKmPbpzXCU9x+xjsViaxwX/D24mJhq173Gu3Lvxz1x9hI+zeCo7Yzemv66fYS9BRmIu
    Ak/otypqs8M5sWo+KinhOr863LRbA3K9AMapHi1JtA7ESkn3PddSNga374vMZ3bmHs36Gb
    FWZbOXLKz/5xu4cBxrmiS7r9Y1GLNq0wHsHZnMIGWSCT45ev+Ntb7Y9JfmAfs0pZ+Asn1l
    9VyVpI15XH1JdEdQ6pnMwmDMyIDPQ7i91ULdDUmjupUqAQC9aoIvZ9v9ZJDi3UGHdl0dnM
    fcSiiPcsypLXapw5Ldnta/NfnYE967VgwqzGvrQSMsf9fodTJEvphdqE9o9k5kso6lI8nx
    HFr7SjzPV6GYGg8QFs88HEg5gyn7QEMuW9daIaSVY6bHB0HCOqlg5VqZXCJdMhkvlxDd0i
    +ON/7HpaKUYc8IXPGuqgIMtQVXUtdPMHQbaAOfZrEj2eAfyzww/LWJDaE0vQ
X-ME-Proxy: <xmx:9nMyauPEEt6Ydjmtm3S_kC5KI3K0lkfLTLtc8C636aqGI-HR71q5EQ>
    <xmx:9nMyal5E7K9xKbTx9zhbqJ6wjLcuxT3dxaBMSoZb-ZBNKQ0Erqq0fA>
    <xmx:9nMyanN7RVVHU_twpXormk7MQ0kospk5yhzSa2gaTsP9e1ZWJVxhmA>
    <xmx:9nMyarmUFx-F-j4useqTEa2uUfxv10h4hTl4yL6QBGIsxXky4_IJSw>
    <xmx:9nMyaocS-ZwmUW1e4hkTnc_C_HgMwRz6pGo9NqFhJte-4mMXjCsXFQD->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 06:16:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d539e83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 10:16:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 12:16:01 +0200
Subject: [PATCH v2 4/5] builtin/refs: add "create" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-refs-writing-subcommands-v2-4-07f3d18336f9@pks.im>
References: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
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
index 08453ae1c8..92e62fd5df 100644
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
+		die(_("cannot create reference with null old object ID"));
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
index 0000000000..85c8bd6ea2
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
+		test_grep "null old object ID" err &&
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
2.55.0.rc0.786.g65d90a0328.dirty

