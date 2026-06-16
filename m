Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808D416D02
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599466; cv=none; b=JPGZf++VaE3bSAYaX+gRQJtg0w0OGxNeE0jO7093GFoCCD6nHVVnQuxwn53sgcaMOmx0O0JY5syuZUD2JIjRjFdTvHIX8AVcPRqijDcl6Zgzy/XjoCn0h/8yyl5c41UzGWImXaC+4EHbgZxVZY3y8nb1tP97NpKKf8AryZEbh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599466; c=relaxed/simple;
	bh=Qd2WYg8CVH5wMAn5kpcm+9/pq0R/EmlKfkxXNcwKahc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NoJnxUtm7SDmvrNRFgk3otQ9wrI/vT+PsO9Z4rupY3hxOQvPm7lcUZ447x+jwiszk15LQhXhjjItNkgtS330JAc8+U39p7mEhhhpANe0zdKNkgohIwYTzYNZoPDtATvyh73q6qrpGwEJTqwLGl0jpWiT9TSyPQPunTmiAcVafso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OdCuwkn4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=guT7brVD; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OdCuwkn4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="guT7brVD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7A2D7A0182;
	Tue, 16 Jun 2026 04:44:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 16 Jun 2026 04:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781599464;
	 x=1781685864; bh=+ejAjZA2GLrvg+8KKiNv/qqd3SOHb7Ub6SgXvEdma+Q=; b=
	OdCuwkn420PuvemtrJZACud76v+PSJK9X1YNolZtKF0Ibcr4Ch2Jcvq2F3tYWXEH
	OJYB6a79eu+crB26z7qwPXVo8ZYTQ3nupFF2FSyHWlvcrjiobm4/WRPs05VUUdHV
	nFEzGwyqKUAcojWt8RACLhftsDToUjFlpNpRGW4qdnakLyolrqKPlhMO+dIiEOMA
	DCxgV5K5bVJrUhB7yJkRh/FVuwZoZ6gLvX5tXSeOozyQsfG/EE55i6adie+wrhvE
	cyybcxWjmUZMV/jiGa/vX9XaA/HOBsjGLbAxMlfmt/JkzJT2sNYlJjz+KTFfvo1x
	K3W4UfUWnZwkX2K3qSG5sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781599464; x=
	1781685864; bh=+ejAjZA2GLrvg+8KKiNv/qqd3SOHb7Ub6SgXvEdma+Q=; b=g
	uT7brVDW9oGvZbpZjYDRhFXUV+njwbN4hx3NzMW5Y0rtTJ0V5fw+TS7dW8oApnAn
	uoIJ+0LBEleUTMWm4rsRqcE2DDNjK0DWjiHPa1HAxok6oVm4rCPtZsvU5JNnsOo7
	gF8OyDTcTYXOd9vyy0T1tWUkntq27VmusxPcv9Y1Yd4ifi7qH/uS372UsZ5mTAcK
	aIM6Sg3TJg8wX6ndCuodTxGsqnPeZoNqkMxXrzgHd9yvDgZPjYZ7/KKLHbpU/FXl
	peiXJgnugGlWwUyuig/hF+Df2fYQXH2FfGniaXaIdQE6+A2vyeGGNERfzW4X4rH9
	6Xt40SpY8agog+sZYTxDg==
X-ME-Sender: <xms:6Awxat25Js-abjcjpj9Dy8WgCFk2KC3XskS8FRdANtM1JqBaJTs84Q>
    <xme:6AwxaqFQydRTitAyPDOUgfDl1JWOY0kH8zLYoJ0QWoOIb0TG0PvHIMDSuNvY7L8ID
    L5Fb0kKXnkwSEfRFPzAYURNe00JG3VTPjGtc3F5kAD5mdciF07p-w>
X-ME-Received: <xmr:6Awxarjw3J5-_auXGp7ER8KIe7cyLcZ3mu2yiH4kot5fZO05K4Uav_c8-N7aqkTauYdl6Fuv4s6E3LFKJ9cryUqhTzu505unasWIsa-ms9L4JQ>
X-ME-Proxy-Cause: dmFkZTEOlVcZWEzrPwdEy18ZWCa4jjcjf5fltFevy+Diy6LjKc+K1bJlLYqbhA0NRBEQm2
    JAgZMioNj2OWNFjvTShEZoGoUC51PcaK2LMwh49sGR0sX9pSceUhjiLidkEXPS2D08z/T4
    MP3ukocLsR8NDbbj6mTjc/vzuHfnpBg4PuGK+0KA6biGsJi0qEAcGXBzOI2hQr9AC6q5Ec
    fWfU7ZTcOn2vArbq2/qwCqPAcGetGEUuYC0GBZPi+akfXmvZnskqo82CNkKs8lxMH+VyOB
    gLvf9BMFIswaJfbZCBPSv+WrIWWSswq4fTNe9DbgxCbqO6jXxmORZoyMyPXUIwEIauCbCi
    3aPHn0V/Vm4myOTDs/PdlnJiDW0ySUwXWB2ZsFeNQ86ftu0KeGm491I3Xj1HFnzeXLQ+v+
    CLj7iMpIvmNdS6rmtAxE4JTti2xcCd/ciwNHFtjyRC6cqRkN+ttq7biNbTIjW8flZo4IXF
    tYLXOIRnmIbrP3RDu9L5qjpNRRT4A/DqjjzEQX8fHMqJYGl04qvLBxMLh5y9EQW9QGvzA/
    tKt4R2i8urgR8htTCld7v4jwX3caSTQu9Wb7IoRWZ5srbjYNHSDy+qAnuZmadEBAAlySBK
    FTqfzOMRGDEi+4NZV4YxzFJ5XKbT1mzRqXKai8+YeDjvUf9itExaFrHJ5P/w
X-ME-Proxy: <xmx:6Awxal8X0sVXMflqYN5vry1CXyufcZXOMZCQeIRlzkP39PU2Al4QQg>
    <xmx:6AwxairLzdJVWytrrDbPdHAuPmurKEj53HToWoiT6ZpC7nk5PCn9rA>
    <xmx:6Awxak8od_pzNaGq33dRJuC1qmgBFhvS4PKxlotpH_MUBdFwbEc0oQ>
    <xmx:6AwxamXWWzmsozSq-flKQQjWXazyVp0RM12Wj7WYaJZKnPF73eHtBg>
    <xmx:6AwxapP69oIAh0_MAxj9zH-6av0TS3tRWKVYYfB9aa5kA0FBd8cS1tLE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 04:44:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e53fac2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 08:44:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 16 Jun 2026 10:44:08 +0200
Subject: [PATCH 3/4] builtin/refs: add "update" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Add a new "update" subcommand which mirrors `git update-ref <refname>
<oldoid> <newoid>`. This follows the same reasoning as the preceding
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |   7 ++
 builtin/refs.c              |  50 +++++++++++++
 t/meson.build               |   1 +
 t/t1465-refs-update.sh      | 179 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 237 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index c03e8e6ac3..0a887cf5e5 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -21,6 +21,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
+git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
 
 DESCRIPTION
 -----------
@@ -58,6 +59,12 @@ delete::
 	reference is only deleted after verifying that it currently contains
 	`<oldvalue>`.
 
+update::
+	Update the given reference to point at `<new-value>`. This subcommand
+	mirrors `git update-ref` (see linkgit:git-update-ref[1]). When
+	`<old-value>` is given, the reference is only updated after verifying
+	that it currently contains `<old-value>`.
+
 OPTIONS
 -------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 69eb528522..3238ddf3f0 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -24,6 +24,9 @@
 #define REFS_DELETE_USAGE \
 	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]")
 
+#define REFS_UPDATE_USAGE \
+	N_("git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo)
 {
@@ -219,6 +222,51 @@ static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
 			       argc == 2 ? &oldoid : NULL, flags);
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
+		die(_("invalid new object ID: %s"), argv[1]);
+	if (argc == 3 &&
+	    repo_get_oid_with_flags(repo, argv[2], &oldoid,
+				    GET_OID_SKIP_AMBIGUITY_CHECK))
+		die(_("invalid old object ID: %s"), argv[2]);
+
+	return refs_update_ref(get_main_ref_store(repo), message, refname,
+			       &newoid, argc == 3 ? &oldoid : NULL, flags,
+			       UPDATE_REFS_DIE_ON_ERR);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -231,6 +279,7 @@ int cmd_refs(int argc,
 		REFS_EXISTS_USAGE,
 		REFS_OPTIMIZE_USAGE,
 		REFS_DELETE_USAGE,
+		REFS_UPDATE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -241,6 +290,7 @@ int cmd_refs(int argc,
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
index 0000000000..e7582a6195
--- /dev/null
+++ b/t/t1465-refs-update.sh
@@ -0,0 +1,179 @@
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

