Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0F416D0A
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599464; cv=none; b=G4XLHowbiGOE2VQuKeJHBZaadXFCy2emLCROX0O8vM9ZKVXqHmPc1ruhQc32prff0EKilnJpUN7vNECPP1/9PC00RSV4Tc+PpMVxCGMpkTz6x4raXnZ6v+xztAhpAcAr/pWmsLTAWgOSHuf8ro1UzwCehcUGxo3NiTPo2/w2HjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599464; c=relaxed/simple;
	bh=MTweZApy02AlPTMDu32Q4O9VH0caNS12+d4KhpfvJkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTHr9Qe8PUOZ6gH8pN7QqB5rK50BkAGuK14w8Ojq8xIc3zl+0mXurk0EBnTx7QM2UmnfIi3kUf2EsENB8WQaXt45nkGaoXAvqcXrN2c2r1ewd+GBw/wVoYcX+bNoqZcq1InA8t18GPSUmP6Z3LAAkFv9SkSeG8/nRHiQ4WeCTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nAoOZ/Wo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOQdvApD; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nAoOZ/Wo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOQdvApD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B480A7A0149;
	Tue, 16 Jun 2026 04:44:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Jun 2026 04:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781599462;
	 x=1781685862; bh=ZY5mbYHMp0b17M/cg6ILnOdp5JxBh9XiNYUbfhIT++s=; b=
	nAoOZ/Woz/VbqwUIAGSxGJ8sLKrZb1YwlWjBNmAbxxLfNbIVz8u0EDCZpQhkNBfA
	HSeotwRb9VjRuR0ZcrzEO752ABNzQiHrW4lOeO4tLgUXfPqefLMdNwLAv37ZEnP/
	l8I73wZRES5gwlmNP6R0AUTDBAGCRm+OU28EgTZYZiwc81F+Ff4Tkfh0uwzzgzu9
	lATJuiniKc/9fLJlvMSeBi7oVTXVlY8Z2lqZHRoSjSwQxFwFJb9EAMrAjj8aEwa8
	t6ngojIUrp2UaYtPvdVm39JoTPxFxIxvZGnUoIWtwO64oCdyY0LeXVleKe8a+BKl
	9ff0mePH06sspDIVkuu6ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781599462; x=
	1781685862; bh=ZY5mbYHMp0b17M/cg6ILnOdp5JxBh9XiNYUbfhIT++s=; b=g
	OQdvApDBUwhMYu9tgmVkojCTy37UnXBWZL2ev74ySduodtiIOogSnpmt9hr852Eq
	g5uHYtcL8bDcQ09WLo37VGnc5MjxOCpoowDiIkypWrNjR8Z9gsB2Z8hsNoloLIQ9
	FSf+ldaePioRUx0RNKtSCqnCMD6fIVCRLAnqatMzNB1PY34kXqnffu/Gg90f00BV
	wHwcAvugnV4EF1uLzEtjIjcPI1gcYNQ3nU10FKtkD5JVj2WBdNKwIe15AqsfU8dF
	Eg1NyTmvb2M+YJ6vb8nGOtpPRLe5tYfwiVdJkZRFklvCTWIrNmFqn1beZYLcqgbV
	sSRn7soIhcEnTKF4dmhVw==
X-ME-Sender: <xms:5gwxamwlsZfytTGfGWtS7FAHrgMHq1e1is7HQYlA4Eh8neu_GCVZ6g>
    <xme:5gwxaoSWL74IVej6bZgcsIwb9JDSSu_9ggNy2GDVuUOE2GwB5hDi6Ws5PDA2SX44Z
    9ps2oFOCOzx5aEBah_gIpzkcf3oKUGhb2UT7G6kkFnCAJBtDTlTTQ>
X-ME-Received: <xmr:5gwxal-kdimD0PQHGeFP6ysScw2dNM7qZlzuqHzHZjUcf4IE_-Y8tgQaGEtHSqQ1DMtGxa0rzk7xn69E3UuuFEn4cV3NXKDeKBIUTs5OiystFA>
X-ME-Proxy-Cause: dmFkZTFBk5CWSueBh1W9d8KzddL0zCsFFQZw01Xrj+/G5WsDERV5CEq8iQgMA6rkpb01Ha
    XO2sPvtgztpkfBWoASmLj0xbcH+OHbEp/Ntqa65jJ4lH6/LQsqzJ7SHT2FgmtGJB1bHeOC
    XIiagSI94YMf3JJr8g7IUXkjs6Pr+wY/2pTVtxWi1fdmXxZn+NBj8tS76E8hIvNsBuZH+U
    ZHkSQm05igjvDv2JMx40FszLieL925SSqFNBjj2D1t/vQhNyThEajaqNQ/yZQKKtGC60AS
    8hoKIO7fl2Xgg5O+wx88z/9O8HKF0b73BMtkEJnjSrGaDQbnxxwJdEfVcGMAxHBIm2BdW3
    wJcmDAM43Js2KqGHXmfT21iLhThUOBTrd6b8UhdNTBiucv/fJ4QC1XlAZxz8SS2nQIRwKM
    a/QBsd7yTEvq5eNxGsIgSs5eZQPCPSJ8OutY1bczQOZrsOS/BWaGpgN0o6V5rV5vD5VdeX
    +ZExGnw1Bqm+6pPzgixEwIyio8hMHq+0g0pQMYC+g9S/R1qMagoiZUUs/5TFV1yGH5Tr4j
    p5opTprOKjhEH5WhD4JqX+pQ18snAEA17JWCBb/dxjB1dMLY8TigJ8Okzi+jutWt/RJlPP
    kK4kNGIMCVdohskbDqPBQPKiPkkru14cNvq7rMRykAyE/ax2vPFhrZrMlXrQ
X-ME-Proxy: <xmx:5gwxanqfn1AXA2Sv2BKJksbepGkaU_1s2Ye5cxJ6_NWJCF_Hi1MKEg>
    <xmx:5gwxaqkAfXdBmJL0swrkCLGqU6WLHLQZq9f8aARJ_wqr-x6ow5xobg>
    <xmx:5gwxamIJNfbFwco7dWp41Qp-J5ZWv0WQmRPSnMrhAx_K97_5WEyRcw>
    <xmx:5gwxany97_gApzwzjUhUlE1fu6JWjxJWsADuCvFDr8BcMvhIjQiABQ>
    <xmx:5gwxaqJZgcretU_Ochs1qG9KXpuN9fMua3fQLEAZyLOfOKj2NDnXQvYT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 04:44:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f32c8b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 08:44:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 16 Jun 2026 10:44:07 +0200
Subject: [PATCH 2/4] builtin/refs: add "delete" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-pks-refs-writing-subcommands-v1-2-9f5219b6109d@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Reference-related functionality in Git is currently spread across many
different commands: git-update-ref(1), git-for-each-ref(1),
git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
hard for users to discover what functionality we have available to work
with references.

We have thus started to consolidate this functionality into git-refs(1),
which is a toolbox of everything related to references. Until now, the
command doesn't handle functionality of git-update-ref(1).

Fix this gap by introducing a new "delete" subcommand, which is the
equivalent of `git update-ref -d`.

Note that we're intentionally not using a generic "write" subcommand
with a "-d" flag. This is rather harder to discover, and subcommands
that are implmented as flags tend to be hard to reason about in the code
as we'd have to handle mutually-exclusive flags that stem from the other
subcommand-like modes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |  17 ++++++
 builtin/refs.c              |  46 +++++++++++++++
 t/meson.build               |   1 +
 t/t1464-refs-delete.sh      | 133 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index fa33680cc7..c03e8e6ac3 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -20,6 +20,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [ --stdin | (<pattern>...)]
 git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
+git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
 
 DESCRIPTION
 -----------
@@ -51,6 +52,12 @@ optimize::
 	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
 	offers identical functionality.
 
+delete::
+	Delete the given reference. This subcommand mirrors `git update-ref -d`
+	(see linkgit:git-update-ref[1]). When `<oldvalue>` is given, the
+	reference is only deleted after verifying that it currently contains
+	`<oldvalue>`.
+
 OPTIONS
 -------
 
@@ -90,6 +97,16 @@ The following options are specific to 'git refs optimize':
 
 include::pack-refs-options.adoc[]
 
+The following options are specific to commands which write references:
+
+`--message=<reason>`::
+	Use the given <reason> string for the reflog entry associated with the
+	update. An empty message is rejected.
+
+`--no-deref`::
+	Operate on <ref> itself rather than the reference it points to via a
+	symbolic ref.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index f0faabf45a..69eb528522 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -21,6 +21,9 @@
 #define REFS_OPTIMIZE_USAGE \
 	N_("git refs optimize " PACK_REFS_OPTS)
 
+#define REFS_DELETE_USAGE \
+	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo)
 {
@@ -175,6 +178,47 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
 	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
 }
 
+static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_delete_usage[] = {
+		REFS_DELETE_USAGE,
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
+		OPT_END(),
+	};
+	struct object_id oldoid;
+	const char *refname;
+
+	argc = parse_options(argc, argv, prefix, opts, refs_delete_usage, 0);
+	if (argc < 1 || argc > 2)
+		usage(_("delete requires reference name and an optional old object ID"));
+
+	if (message && !*message)
+		die(_("refusing to perform update with empty message"));
+
+	repo_config(repo, git_default_config, NULL);
+
+	refname = argv[0];
+	if (argc == 2) {
+		if (repo_get_oid_with_flags(repo, argv[1], &oldoid, GET_OID_SKIP_AMBIGUITY_CHECK))
+			die(_("invalid old object ID: '%s'"), argv[1]);
+		if (is_null_oid(&oldoid))
+			die(_("cannot delete object with null old object ID"));
+	}
+
+	return refs_delete_ref(get_main_ref_store(repo), message, refname,
+			       argc == 2 ? &oldoid : NULL, flags);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -186,6 +230,7 @@ int cmd_refs(int argc,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
 		REFS_EXISTS_USAGE,
 		REFS_OPTIMIZE_USAGE,
+		REFS_DELETE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -195,6 +240,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
 		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
+		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index c5832fee05..1ccf08a3b5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -223,6 +223,7 @@ integration_tests = [
   't1461-refs-list.sh',
   't1462-refs-exists.sh',
   't1463-refs-optimize.sh',
+  't1464-refs-delete.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1464-refs-delete.sh b/t/t1464-refs-delete.sh
new file mode 100755
index 0000000000..4a36d3866b
--- /dev/null
+++ b/t/t1464-refs-delete.sh
@@ -0,0 +1,133 @@
+#!/bin/sh
+
+test_description='git refs delete'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+setup_repo () {
+	git init "$1" &&
+	test_commit -C "$1" A &&
+	test_commit -C "$1" B
+}
+
+test_expect_success 'delete without oldvalue verification' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	A=$(git -C repo rev-parse A) &&
+	git -C repo update-ref refs/heads/foo $A &&
+	git -C repo refs delete refs/heads/foo &&
+	test_must_fail git -C repo show-ref --verify -q refs/heads/foo
+'
+
+test_expect_success 'delete with matching oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git update-ref refs/heads/foo $A &&
+		git refs delete refs/heads/foo $A &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'delete with stale oldvalue fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git update-ref refs/heads/foo $A &&
+		test_must_fail git refs delete refs/heads/foo $B 2>err &&
+		test_grep " but expected " err &&
+		git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'delete with null oldvalue fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git update-ref refs/heads/foo $A &&
+		test_must_fail git refs delete refs/heads/foo $ZERO_OID 2>err &&
+		test_grep "null old object ID" err &&
+		git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'delete with invalid oldvalue fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git update-ref refs/heads/foo $A &&
+		test_must_fail git refs delete refs/heads/foo invalid-oid 2>err &&
+		test_grep "invalid old object ID" err &&
+		git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'delete symref with --no-deref leaves target intact' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git update-ref refs/heads/foo $A &&
+		git symbolic-ref refs/heads/symref refs/heads/foo &&
+		git refs delete --no-deref refs/heads/symref &&
+		test_must_fail git refs exists refs/heads/symref &&
+		git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'delete with message records reason in reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git update-ref refs/heads/foo $A &&
+		git symbolic-ref HEAD refs/heads/foo &&
+		git refs delete --message=delete-reason refs/heads/foo &&
+		test_must_fail git refs exists refs/heads/foo &&
+		test-tool ref-store main for-each-reflog-ent HEAD >actual &&
+		test_grep "delete-reason$" actual
+	)
+'
+
+test_expect_success 'delete with empty message fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git update-ref refs/heads/foo $A &&
+		test_must_fail git refs delete --message= refs/heads/foo 2>err &&
+		test_grep "empty message" err &&
+		git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'delete without arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs delete 2>err &&
+	test_grep "requires reference name" err
+'
+
+test_expect_success 'delete with too many arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git refs delete one two three 2>err &&
+	test_grep "requires reference name" err
+'
+
+test_done

-- 
2.55.0.rc0.786.g65d90a0328.dirty

