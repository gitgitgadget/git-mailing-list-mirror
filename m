Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A1406822
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820158; cv=none; b=u72yJL8kkRBCxkeXt4YOD4sr/9pcl2NxsnbqtjIOuHWg/mNgp/K7tLKo/r4dJe6OVId1ohdCs8bJ1XleI4RHEodvcO4fKiQvt0TnK80VjWQHWQ1AJFm4dZdA5VuiZfIhbAx5fmp15+wh/Br61boUlg67qAX94lm64/u+A80gQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820158; c=relaxed/simple;
	bh=PGNEgSMSr8FzvhXGeM9/C9xhmSXakxJoCcomUEv5ei8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1OOdjpJEmUuhhZgkzfsT8eX/c5k38qMBDKzMqF+sPe+Vq5qsyRktmTR1Hi7k/TauxFpX6/55+ikwfI5E3PvQd4BLC2TLMCY9y102qDjjGo+nW1D0iIQRDY6iQvivcDc7A3uMNKD1XKypXIHfH6hDun1vUxicl8dJgjS4MXhDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lx8tWu0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NaglFCqt; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lx8tWu0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NaglFCqt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E9F6C1D000D6;
	Tue, 30 Jun 2026 07:49:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 07:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820156;
	 x=1782906556; bh=5BubIZGU4sCzaU83oG2TZThZKQI/YC2d9OnhHTnqt0s=; b=
	lx8tWu0fYiNezUPmj/yagnpLcwmK9ARrfMmX4aPhURWLr2fWhb3LxOkUU544HPdv
	b+2K0vhn8DreeZj5CyMXW1diSYtPB95FZ9TAH0CbbK3edQ6GWGUII1E+eIcDN3aU
	nifrZyy7qnEKp3JKivW3fwnOMRYYMLHcovpKbAYg6d4YJpfmFs0F7YomXWB/ULjl
	F+vxIc+yKw84ydEseBZH2e3oBUhWp3HrFeYn8shWCYpKbXMMhPpbpetTIB7L1Y6M
	j18275WAMqJTcCXDezk1jEPQrPm+EvGgu6GgJ4n2PVYsDF+85y8f+WjMdzIrHldJ
	Z2q04Yy+6VAjrPq5bpznGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820156; x=
	1782906556; bh=5BubIZGU4sCzaU83oG2TZThZKQI/YC2d9OnhHTnqt0s=; b=N
	aglFCqtvu3XBsnFXKkHO7egVN/LwyTbdazMt7cVA+6ClBLXovbqVpw0fkDrXt3gA
	IZ9XOngOMo93pZZw0qrajJwiuSmrAJ6cD+vmgP6zd9D8kyCkTRDvZMJelD//Ffv7
	JJftLKqPE7Yr0E6infS/ko5uQ9niDrsxzYvSMSpXXURnuZok7uXQocFxJOhVr+Vq
	WpsgjTaSaXoEXkK2ibvmq2dAKxvcAX26H59QY/ZpDbVP+HhZjeqk/pLI48jiOq9E
	+ZE67oW8jP68oGwE2N8njJ6luXgRT5k1MXmPEWCv0ZrEHwarKXYnQJoaK8sOikGT
	TCfNekNSGcT0hnmVqxE4w==
X-ME-Sender: <xms:PK1DalPK7RVHWjA1iFE1KHiwtyVBXDhoDi_TjKGd9qHfIji_yMXmhg>
    <xme:PK1DaoKt0qz8cEE3VbTJvQC4AhufBq0thja5xsu0DfBc6fkVpis-TeepPAalxkcr3
    ZLTjNNfNiQ6G6pmH0Y-aIY81-qsiuCvf1BKiu_c2k4WDK5t6gle>
X-ME-Received: <xmr:PK1DamH1SLUCkaSab7L4DGCpvzn6QjAZ6eGlqzJaJxnsg6_AXxFRpaMmMwt98aUVWVgJHxnnuTSypBq3-VXgm3QiRH3FCFAYX84UD1_wmDRE_w>
X-ME-Proxy-Cause: dmFkZTGC2szVQkDaHMGWu8x0Spy+Nui0qUO65jcAzORicIj/uF2IQwm6PE1k+iEZ/mZgZt
    x3B7QknX1atPvT+D+QhChjmaAFmStw8wfoxzqXoRU+majWRzYp1dcWY1elHRcgoUtflQgM
    g1pEqIAgiwljjKYiP255ZcltSFPL+qawrWp1fneip6gJetr1+aXwhP8TYwmjQxigefmQ9g
    nEhmGWCjHrgf6kuTK/nZLI6VrK5iLlQxIxRPhk67rEHmx+XY9P8HwAex+ifmHnHhkq+duT
    nYJS1hzZGcgU7w7oTNJ302gliI5CIgfp+sxfp+4RVuBFMABNDTYIcH0V1Mifhy7sad0+a+
    8+5Fon2tfSJ294QaZq+MhPOIhoRPFWovnTDZdTrTX0S7BrP6RL8JbDB8VGL7Lz05E4c2f1
    62DXhAQT6l0QNwZl+enZR1PCflIljrueHF28YtO5J9Y6s3tH+cj+y3ZZrJF+Bc/bNn0Tzt
    UhkS+SXbiHWVuN6ELHZRz0sc3fJEvABBFQJBN/hcBCTU5sclxcWps2blRFIMBJcy/DdKeU
    JkdozcYIkdPVHQIHQfokofCvmAoTTkygTe28e0fna6OhRBW0cONjaUMVxkqfF0lsMVI4k+
    H68Esd/ELqmNJ16SssaiozPfTsCOHeB1zkQaxlRPIcXx9agfZK8z6Rlt+t2A
X-ME-Proxy: <xmx:PK1DagQeuPkZVNXECktFqNABViTps-iJucUiyot5kLS5j2nf7BhHjg>
    <xmx:PK1DaiFLpH_v4n_Rg8w12OyRW1aq3qqQxQtEYVLVL0ZwhfNEqIaS4A>
    <xmx:PK1Das9VdLDFOAHALRrI6g_omwr3PxG4TFpN0Z__l_yg3fXBC9K8yw>
    <xmx:PK1DasJ6RvVWjD4lJg4s0Zq7aTe7uoH8VQb7tKKC6L36X7ThddcBIw>
    <xmx:PK1DanxrKXsi0yNRxyWWU0_Z7auw6Rxv6y74mwcO5mhgiMfkDsPd22fd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:49:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3ddd702 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:49:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:49:05 +0200
Subject: [PATCH v3 2/5] builtin/refs: add "delete" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-refs-writing-subcommands-v3-2-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
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
2.55.0.795.g602f6c329a.dirty

