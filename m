Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566253E833E
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691379; cv=none; b=uisliBGHEVXHA0uu4weucyB5tQ7SSLVhxJ02h5P5IdwRm/G/d+9id6RFT1CMrou5bPsSMNggmEMNBSzrcgoHup0M/BTOXihMqvFRXJB8y1v/pKdIMuwz52opE+jBBsc9gyT88LYgK2xU92XlAygCQISkKAkH8BixzakzY+v+BzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691379; c=relaxed/simple;
	bh=2BuHMrdJHnKwmctezRzrhoPEsc0ovVWBXfykbKdHgNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzmI87Dz0jtZTNIv5PfYAR567Le34igcHloGqlMrcQkbe9MwwVlf4wq8ie208koIlPOlIRnYr04MHxvCzrnOJ6N2aVQ6/LAlIzxoZOEuyHWjRiGTr8ySDkDlc1If9GWCLfZXMA5EEhDqDHnirxFwk1+ZpMM/sgpJXqYKu8p0CPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RBdPjBeG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWMv6RZh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RBdPjBeG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWMv6RZh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C9AB01D0011A;
	Wed, 17 Jun 2026 06:16:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 06:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781691377;
	 x=1781777777; bh=BjhBMlSyTyMbpV9KIY1J5MHBNreRxulPqqaoDfEVGp4=; b=
	RBdPjBeGup40kITw3VVWCk9PB//Kk/hDXe4SpvbqVMCQzLVmF29uoKUn1xS6TbEC
	WM9XG8zPP1S3GGsuqC4KgX8BaWBa5L1owC9bRRAsycQ27dnAp2gS3hc65wtgToYP
	0BPGRklKstpn5/RcCOoDqVNOx7VZfmdkFggMy7/NuNolXzePjDBTQX5Xyatr0Lpv
	slK7ul1D9A9LWYmqXBIQ1GeG+pvW19aSoBYQDFlVorm3YOvsDSiAQ4r0HJ4SJLUc
	GlFZRN2CjtONpGy+RvoZFsFfdJUTcSJgif1UsL2V6E4rBuiNBTZbTm60b4E7HLiS
	rRJYAQ9xkyYs5NKlmfEZgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781691377; x=
	1781777777; bh=BjhBMlSyTyMbpV9KIY1J5MHBNreRxulPqqaoDfEVGp4=; b=h
	WMv6RZhrY1w+DjjzMLIz6bnA+MDDCah+3102+BQ98X20ObgRZ++xpy1fsJ3vgMK6
	9TtFo0n3BeRIZwYr9y5oY113/thpPnCpOKLX8lcCRpQwFePePuxRcIJZ0lyDB7HE
	/C1yHK24rBpIsXYMJsQh7ztVCfdMDz+lRRsULTAAa52pv2WSpchGnNcmy+ev/KDe
	rPQpLe3dps0LRMMyc1/2bYjIcHh3e5zyGqQgpuD1UFlVeSIqMMpWrmML5LckshDd
	ysAAfQlto0vFGyf9hHcws77kxcxaqGykx/aEPvWYajmVwoULeY2UQCXAv1PFLoLg
	p0Dcsqf/I+GI/KkvSmgkg==
X-ME-Sender: <xms:8XMyauE16eIIjnV7InPtqc5cu3pcX70rlfgkVu_f-RfFXkU0jsMNRg>
    <xme:8XMyalW2s8U6cKuKvezYZLELi7wN9vol5TqIOx0dJhNAjO7oCq_0bwwjBmInh3Dl3
    zo6cGiNIQpLtpcMiY0djWayDd1TM23pXQ4Km6DaBsWUkLB9SqMY>
X-ME-Received: <xmr:8XMyalz2-aOOB-h4wnbuAxegkGR3UZC3PzpnA5iIVfyoOOzFk0Ny_fyQGHhlEMSVQwl_PAIsp3IuQ55Ev-6J4czWPa5ZFg68zsXBoFE>
X-ME-Proxy-Cause: dmFkZTGYzi+m86FQk2DQwqFzBehG1fRSk41ZWKJRb9rgteJj65ae+gY5yjRePyX8Xx6lqy
    WpIssYxpPvNFGS3oYXPOIv3d6UcfFZlUbFy4gJEq0rkI/Y1pl32pqFGZxDJfmrrtM4ScQE
    eknsL03/Gqod8O5hg9M2XnifZNYisyunvBY3S7HvVOPD8lVP6Mavd5F1OhYT0ojCmvHoEr
    qqrGQrbhp01iLfArgiR5pC7cPTTr8BFs41lHlbnpYx9OWdnXsT6R/bKUmJ9DLfg/DKavhJ
    clDDrHfGMiHAjiRZWRQ1M8+FwzQq3C6Z0UiFOm74M/2oWCIk0yJOtJg/7bzSyHlSV2AEFd
    jO7asy/IS4OV5IBes3T0xLK8McfpncfvYRfDloUMkpp7L+0BSxu0fDgs8Q2/Tm33BQRPQq
    tj5W0NJpE2Xq7w6ppWF5PDs6TmWsUxz/H2XauZU1qp8NT6rlvTQGSUh0coBflqW3YVZzX8
    HL0934ULZG1VmhhJPhUYo3r49PgomEj5/gpROLTFYszOaIQIE2aazFpf4DqlwZbCzM4pPR
    Toniph8P+JoVa0HBmtNe1o4WxoHC+ar+BMwzGB6zDrc299Ovbibd6aePJuipWLyVY7AoAx
    yZQqfjmgDspQN1IgkoF6pJqE/+3oSoPq4RDmi3JlwW7WaF73PJCRE41skvYw
X-ME-Proxy: <xmx:8XMyajPWbnFTkPNqYsdWscSVo_J9HyRRjngZ2o6vebdHI4GGMbVAPg>
    <xmx:8XMyam6DbXv2JWCJL2lJc8mGzPZzimNp4bj4zyBqRSrEoYdjB036-g>
    <xmx:8XMyakO1tRz0vk0YQzH8l6n3uNueKtwC7DUnA9a2PKMQBGxC5ZjMsg>
    <xmx:8XMyakkSkYmCukqnLZzTx_caNv-39SYVUkV3v9LlrzKP0L79N4YwmQ>
    <xmx:8XMyapfIW6EkVadhngYdWkl9DVJmdQh2ta2HSbswC6IxuEIHkuXDoP17>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 06:16:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71dff847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 10:16:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 12:15:59 +0200
Subject: [PATCH v2 2/5] builtin/refs: add "delete" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-refs-writing-subcommands-v2-2-07f3d18336f9@pks.im>
References: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
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
 builtin/refs.c              |  51 +++++++++++++++++
 t/meson.build               |   1 +
 t/t1464-refs-delete.sh      | 130 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index fa33680cc7..2633934463 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -20,6 +20,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [ --stdin | (<pattern>...)]
 git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
+git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
 
 DESCRIPTION
 -----------
@@ -51,6 +52,12 @@ optimize::
 	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
 	offers identical functionality.
 
+delete::
+	Delete the given reference. This subcommand mirrors `git update-ref -d`
+	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
+	reference is only deleted after verifying that it currently contains
+	`<old-value>`.
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
index f0faabf45a..edb7d61663 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -21,6 +21,9 @@
 #define REFS_OPTIMIZE_USAGE \
 	N_("git refs optimize " PACK_REFS_OPTS)
 
+#define REFS_DELETE_USAGE \
+	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo)
 {
@@ -175,6 +178,52 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
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
+	int ret;
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
+			die(_("cannot delete reference with null old object ID"));
+	}
+
+	ret = refs_delete_ref(get_main_ref_store(repo), message, refname,
+			      argc == 2 ? &oldoid : NULL, flags);
+
+	if (ret < 0)
+		ret = 1;
+	return ret;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -186,6 +235,7 @@ int cmd_refs(int argc,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
 		REFS_EXISTS_USAGE,
 		REFS_OPTIMIZE_USAGE,
+		REFS_DELETE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -195,6 +245,7 @@ int cmd_refs(int argc,
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
index 0000000000..efff7d0574
--- /dev/null
+++ b/t/t1464-refs-delete.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+
+test_description='git refs delete'
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

