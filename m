Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A273ED5B3
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691382; cv=none; b=FR058SPfJ+Ex0QH38baT/J/Scxf79Jw0ZE/ii9+rSsMpWD8AVwisyk86tf5S30K7Wczp2ee+qMqpzUIzgBd3tLGLiDKcZhKWJ0Y14Z2v3iLr9h/Iy+SDLRKhaT00SGqFBbXiMLCpeIa1MkuHem3zjjo6+0TrC43iRwwgiZVDKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691382; c=relaxed/simple;
	bh=+HxRAjAxRvqjrrF1Pt89iCMTkF+DctvdJske1xhzGJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPop3Cr1NFrGzckTnTYKlev0UFKVMheHMu4vzvAmxb8YfkUqoI0vP2UWE47GK4yI2jXrrGfo31N4aLF58/9tOnlHxZTL5ZuGljqaBtG5YyKiQuX9t1x1mGgzDj8Fu6WEFwXd5o6HBtQZA6tSWMEG5023JJZXjVjAHrcpciQlBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DSR8ea7z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4JYnCSZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DSR8ea7z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4JYnCSZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E60747A018D;
	Wed, 17 Jun 2026 06:16:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 06:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781691379;
	 x=1781777779; bh=fpE7DXX69DvpFXD0Haa1i2zpx3ulO22IXlYAjRqLtA8=; b=
	DSR8ea7zk+yYP2ohvsZfOith3oS0QyPK28Oot8RMyku27gjLl1kdG9GIW+7WPZc+
	h1AUH1sfb8YnI65BCySyPy9C9a69eRWbn3fQ8aY0Xyiiv1D3VjZo+HpTQ80iEkBQ
	48KLvMjZvjFV4qEDyZNOfYzj3ldFqhpHhjn/IvqyP6yVxVAgLkz2A7IKFtQ5GS1w
	7CUBdygQUTrnb4mTcr+K5oC5AbVn+6DOvNtMlpci1HImcf5juVqb6yQO9aUTX/nb
	37PLOQDlL7hskziYdgsEH9IdAg/F3JE7LH7v7I+jmJxrZ9GZ92LI0W+GBL35U+vn
	qUJXDa20a0KJByhDo2vOhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781691379; x=
	1781777779; bh=fpE7DXX69DvpFXD0Haa1i2zpx3ulO22IXlYAjRqLtA8=; b=k
	4JYnCSZaPzy+khk6ZUqMTjmpJ3wqgA44zP6hVGik9nBsNqeqtfSPJLUBFEFhtPQC
	AMBS5ZuFGNeemoEyeAFqeMcI6O3mBUri4Ydv+xHgEO6MTPH/zfmek84J9fm00V1H
	HPMZ2nvTBkm2FQYItUjsjTwM2WETjUlIYKNRZaglRSW8CMj9uGomm0AWqWLrGXqv
	d3GV/N5+2EmF7KuJ36swau41bYTA7Gdnrr07nfNtN3Ue8Ilj/0KaqWgKZXY0ftLc
	zsF/36MVE/oVavw/R+OY11FLPy1abg/3CwPCpatkiqJov5dPMmePtRQi9yuVOIB1
	RpB4dTpAXWjez3+5xghDw==
X-ME-Sender: <xms:83Myai35ElnMbVEfv1V0UaO2V4pwh9a1PB0qD39oMBAcKeG_YRyncQ>
    <xme:83MyarElAo0fMfeHoTRJ6xHryVKTde3KtZXYXJ0SZ9hWS9_ZEacr5M4ldCFU_FeCo
    adqgkfVCNYyU3Y_f-2dQyIlYYqxPzToi3RztXCGcIKXmyzKzrRK>
X-ME-Received: <xmr:83MyaogIPGmlYEGI6R3R-ea1TrkYV9G9bLsff0JI_lPH9DzcqfGtXB-WiOgFh2jV5tE2FwiuH3a7AE0qhUo4F6xpF9jt9JVsqx0_w5w>
X-ME-Proxy-Cause: dmFkZTGYzi+m86FQk2DQwqFzBehG1fRSk41ZWKJRb9rgteJj65ae+gY5yjRePyX8Xx6lqy
    WpIssYxpPvNFGS3oYXPOIv3d6UcfFZlUbFy4gJEq0rkI/Y1pl32pqFGZxDJfmrrtM4ScQE
    eknsL03/Gqod8O5hg9M2XnifZNYisyunvBY3S7HvVOPD8lVP6Mavd5F1OhYT0ojCmvHoEr
    qqrGQrbhp01iLfArgiR5pC7cPTTr8BFs41lHlbnpYx9OWdnXsT6R/bKUmJ9DLfg/DKavhJ
    clDDrHfGMiHAjiRZWRQ1M8+FwzQq3C6Z0UiFOm74M/2oWCIk0yJOtJg/7bzSyHlSV2AET3
    3qIOZ/+sGZ+tLv4HMLPP3BsdKC1/dptkS1sTYju1+47ijVuufVEXnARoIxWOSl9yW8suPL
    tdPrfEgvZDIaVnQAhQZFytdwYmp0v25my2W8PN/7EPPVR/jqwslWGF6vocbOGP3BNtzRoX
    Xn9dLrzFfTF9fT8kiLjfhCUe5F331XbGHlKPrz0rkbIMy31l/csGv7yj3LupeMxknlyeuM
    uqFvb6LxEVE3b8ujcZGccgV88CZVjme7gOkMVXaZrAhfq3f637BA2kEKNYvywm78Zjl16S
    O4e6VhkXdKbuyjWjxXQvSU0IvlxexPXvjcIcIBgyTzFsxA7HLpbZ9g6caPng
X-ME-Proxy: <xmx:83Myau8adLPpj-JsL-PfKxPm2Z42hB9uDiJS7xraHfRp2_o1QAs-ug>
    <xmx:83MyanqvvLho7qxBudFyahdnZeR5u2myvP2izi8z7MGO8ArmBu1GoA>
    <xmx:83Myal8-DlweZcVTfRrOTtvb240YTc26eYE6NUj2VycDZOQWVAR8JQ>
    <xmx:83MyajWbQruWYxO-rE92DU2eBR5cW0t13BKEXL0Y74LeBNLvoU82Ew>
    <xmx:83MyauMhBTWCmUO2nrJ548mY0ttceOAIJtnM0VHBTtvd4VDYnmLlm-6u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 06:16:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa84713c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 10:16:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 12:16:00 +0200
Subject: [PATCH v2 3/5] builtin/refs: add "update" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-refs-writing-subcommands-v2-3-07f3d18336f9@pks.im>
References: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.rc0.786.g65d90a0328.dirty

