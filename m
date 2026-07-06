Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696A3909BF
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344445; cv=none; b=d5O6BygnfrZ/8N69Mui6yy6Iu62Qao8feDIKYRvQNv6XeqwKiL8IPLv25CRa1tFtd4EtJNj9P3TX70mWwVCQ+Roh0hHcJFMQCLqVT1wFr3O+dtpSilz3zXVcw0jIdN9V8GvpQtiATPqqHunBUKX8hg1BcpNow01zw2bTBWiC7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344445; c=relaxed/simple;
	bh=NQvKi5xscfwg7sYcKrAPbiURqIE042Bqw9yogAvtMDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L6sI00OGhhd1o9iSTLmb/67QWyxiePO/V2CQcEqE1dUKaviUhL9yQyi04myy3Px7F8FmcjyrUdCKVcVquA7UUHZAtNBbjkHAHELoMMQdvHcRikYrqi5VgWQdAop1UqpHXjUHVeKx4P51xzQNW6GUcGvLd0Y5yUxamUYhFVePKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=en88+D6X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffOz6t0u; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="en88+D6X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffOz6t0u"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 347357A008E;
	Mon,  6 Jul 2026 09:27:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 09:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783344440;
	 x=1783430840; bh=ruKL9sstOHMNUki75cba/Af4YrDugOMtTjMfutHDRDQ=; b=
	en88+D6XN2SMdE8rKWxTk8LBtJ8G4cY9HQPomsV/QNK7TIILYu79CS8Y2QpksyUg
	mxlF8vcwSFdztHLUHmGwZLE/Gfcx5KphfzsAFPG+U8RbCPyRoi3Hgo0ZGUAGeoes
	rFj+YUQiblpEMtV+8EdpEo7Bb2Q5aB1hLCu6s3OR5mW8YRKyVy0Gw7yTig3Fs4HM
	RGcAT3vs+1E3r8eN68ui/EH15bN2M8dNTIJqmLuzbeG4U6id2ME7U/BMc8MOtE2L
	JhUFFy2X02xCpQZq6AKaKd6GjQ6MXSTGrZjTgGZxqjFljdChzA8GhydImbZTREbA
	LuMTIhHhJAO3itSw5WwFzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783344440; x=
	1783430840; bh=ruKL9sstOHMNUki75cba/Af4YrDugOMtTjMfutHDRDQ=; b=f
	fOz6t0uG+Po6tLgWIqrk1S2nxwZHZHwDA7d9CBSUEzdICtYAdSjiMHNFfvPQ5WB2
	dVQc1NSZp290jz2uve+OvgOgitDUJoLD1oy90NksPxXT4GxTxp6fBIfIwn6UbcDS
	uJvF0b/WLgLRnWVMdQSAzQH9FYhf2m10574ceot6iBqKW8/oUK/J4DPAvorbkluB
	zFbUQjSbliNfiu/bQnkj/0Sp521sxWryPYERTNC0Jh4QJ5lvcn1iroCpwJexRFSS
	KrErVsn3l+b3FvvYa+UDi8+b0duG/RVDQHaUsnpreovoMA3PzWtpiMxkI9WtmxCv
	qMiynucnVCZrnbE/k8jtg==
X-ME-Sender: <xms:OK1LamJxpk1d_tZdxTugwlK7-XRj5lVinPxukifkC3vPFznS2VBKhQ>
    <xme:OK1LallK5s0um6jw5tZlW3XCbVtPn3UBFnCYMGigRIfXDGgWS7N_TCeTfJAd5Ocl7
    KLATwbNr-h8uSokqs8HlAcBsJMQ09ps8fWnUrsyRb9ZdtLMZbWwdw>
X-ME-Received: <xmr:OK1LakGmY36DG3_PafCtxKM4cPBwZfz5TyuVV4r1AZVW7mWqathCpK0i3Go0xQ3LxpxM7X6R4WWJeiwlOHtRX5Z--VMIEbzwU6vBxXA_uA4>
X-ME-Proxy-Cause: dmFkZTEmtKt1vSKShAPboZPYT14LFPHAQLmZQL8HeMcMNZh2HaSH7rwtkBchsGaP+EOEaT
    XJblBl6/TLzY+Uo3N3dUuf0ZAVCFzmrF9FbzS0bF/DTcB4zyCuGtvTQNvidCb2vi1hWuDP
    eRcetnyyHpuTDvOIXbtl88uvzKYHHqY+lBakIXy1wRmPnyD9eWcAfgwtaOkUlAq9uvgAOP
    P0beWMG1snmxfmfYukDTozaF0rrDZ2NOCe5NyDQETqprVTj7IS265oL4HEax2I4y4ZSSLb
    jbTHM4Rcxb/IVS1szRL/uFkANjToTKTPxX9n1MqDvSHCGbDNUGnEcxPYHGcVkp1Y5mbfiM
    eXvxmArWOQX0iUjkvaWOhu7kh0m+vBBWDsJ3gOPg3jLEV7YJ6TcrVmTYPYjoRyf56oRMet
    3dzWB5/TJ2R6GcyQoTfWXQDPuWGFf8Sjbb+kgqwcmUe/X34WGlL+7gFYa9odI35KtecjuC
    jyW20gqCR3mvt2u7RXE+o5DMjF2EtiMs+E83iJOQ0nIRiL1Mc6hbNktrA6piEzbO8xZOqU
    u3kJVa01POvsKTzyCN+8p4rMoMw+npEh4P1Io6NKjEM2vWivQFxMvUrbV19XE3rG7Ewbfd
    J3CcnN43Le0ujZXFzNB6d20npnTC3HTBlP/oEHercn6EYaJTjuRGTKFibJRg
X-ME-Proxy: <xmx:OK1LalGzguLMc3dJWwoA2MqvAALORzPP1LAZO-TEXpt8Luy9RLPDIw>
    <xmx:OK1LahObztVVqjXkUE0UJITf7FkQM8uCH4Ovvyid9dbNL2Cd_a_MXA>
    <xmx:OK1LakGaYCICxvtusGX8yEp9rUrqD-p18ngUGNSVbRGHBCJkj_5t2A>
    <xmx:OK1LaoMdd21b9twHTXpegXXlIpbRvHcS5GG-7QZo8jwdzNdcl5xSxA>
    <xmx:OK1LamMpeYS9JZ8n__Gb8qrd6UOh-suap1LUa-Nuj0NZEYtWX1Z366R7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:27:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2aae1c6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 13:27:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 15:27:07 +0200
Subject: [PATCH v4 4/5] builtin/refs: add "create" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pks-refs-writing-subcommands-v4-4-d51f6ce7f830@pks.im>
References: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
In-Reply-To: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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

