Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF753EE1EF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691387; cv=none; b=uFSm9ru0bDGBep1o4nhc8twexipjLM82Xs3YUT8hyETLdz9TePpbAFjHNcet+SZOc4jxScFsvXPGcBxpJyGLkDcbNn5th9jqA644BLfOFTerXyFbaPnMTT+9beXNLxfdpOMHvmZikyJG0/J0g1hPkl/inpcV8G/f/5HFwwmWWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691387; c=relaxed/simple;
	bh=r3wkdxJf3DGXDyBKBNwZKIJ3TH/RXiZZpuNBiXcHa6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFlM+pahbKUVVOeAE/95latX4GjcW3k+guldFmZ3Xz/+eVcPB3r3nWJqrlrwPnU3Ws3D9la+YBLG4zgUV1/I7orE0cfc+2zrW9GwWR5qUk1XxvyFPAHcvNmSDNuaroYwV8p9sf84+TQK1WyLzSPGojfKU0uGmFGn1nyklHms4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FPdXMQJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hj/vzUT4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FPdXMQJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hj/vzUT4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 22BC31D0011B;
	Wed, 17 Jun 2026 06:16:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 17 Jun 2026 06:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781691384;
	 x=1781777784; bh=Pd06I8ycFWg2ltI2/sTPAgxpW2Xr2smh4RQlYfpDZ1w=; b=
	FPdXMQJXUVEeSCoAd++z0bqFEvZi7zW+Xw4pzoCHL8rtdGBFkrfCSXUt51C8AFBy
	dnfsdTH78WG420t+wvnsV5uDxA6G4FLCBszH3zoS2xfUtCpby25lHRaCNhpF0++2
	qGvJmKl/Rl+roq4sRu/ZkXmfNHlBSglBSDnKBlKRTO9nWkbfHudyU3vPqUGcdJnl
	Li4TfxJQBKY6cVr38Br0doJJqOAlL6ET4/3SIG3j7ha/w5rWb74jv971jdPUsTtr
	IxwyAumrGvy8OlY/oC8DfxaWxTy7fG/XtqMh3kj1z0JeYZwnEE29BHiK/cu92gyR
	FOEIUnYCGq95S82DcnNd/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781691384; x=
	1781777784; bh=Pd06I8ycFWg2ltI2/sTPAgxpW2Xr2smh4RQlYfpDZ1w=; b=h
	j/vzUT4IRjZkhCIR1tMWXazdTD+xbf4Fq3AtZB6R8dOcu8JwFauKEzK4TezBLD/p
	rsSgAP+LZRFg623+KHU23qAM0J2hnVj7DetqJEn6zltgCuWrfkF+jJ+Ovi2V+ZYE
	7Y+XDomB215xHarKaTv2+eOIfkNOTdhlDvOpF4HU022THQiepgufsUqzP+iuwUYv
	Rb3syDD63RLedqCuBxD5S4qSwKvlf9Im9NKCv5irWKLxNF2AxkdtXXVmGBMwjnEW
	pKKleNSfQ0NV1YP2hG7t1yjxjWY3Z+HdsdflMtboO3RkIKP07vuMXQQVGZlMsyhi
	2IS8PgLkM3gVDSFaSRQ1A==
X-ME-Sender: <xms:-HMyakDDH9sAhztkm0IqfVRM81wNJSZT1t6Lz4Mh6bPIXayABLIJaQ>
    <xme:-HMyashBhS1uTgHKix_bnd-_74zjBynpkb4Fbe7dnYXwmZxnuF2oq2mDfLQrBVLCl
    bWLAQBBwQBlwMRf8eihsWGjKMlXYfHTzeBFQXtTSnazZTjYXDTl>
X-ME-Received: <xmr:-HMyalOof2PO99Z8SGZivfynGx16Rt9pyMW1r_m_zYbFkNE4GCWAQL5rP76_AZkC84cgQGUws5wk14fBlfwsl3iAuyiJZKVFnUxH1ME>
X-ME-Proxy-Cause: dmFkZTGYkCicS8+LzALMgNjwGFA1uqPyJHokDT9Yx0MO/xMBuC6OFhwwmUvn3DhVT3er/t
    2nnWvgOwtk8EnUemkLUHGEqWS+7xKnF7U06ZxMbJS0UnIongvRaEwfVDwEr2IKM4HMnC0h
    d1iZFRYCIWcq6eyRlKJ0vT1GnRk4Lmk6K9Tpy62r6GER8M0iJiOZaroTsq36bswpKp6jTz
    FUxIRmx0SpIp4fKNVbTzmelgO1uaEk8Syl44Nwl7YGDg77HABssCJ2FNCEfK1bVup8V/Sj
    PqNd5+tGh8vnrdEWXSnQcIqH5XPoHaExvCTWfmieTzRJf1ihBHWD1mo0Hfe862GovsSxLt
    4t+CnjSRJ904aVdEgvEykmlBrKeArnWt9+bFTszrZIfuhOiwpynlwDlS5p2wF+lCq400fB
    9QLtf8WVp8VLn7xfv8p7uuDAJQenzCOVw6NjmmvBS/9176JILrbCpUjFBxt0XhiDyuiaHy
    Mttse+B04Sa+9wgfu9AbA+x1hz2kumMOTKq44mRusN+6nkwzPJU6nO3bFkmBpj8wT8YMDM
    HtHDHOp4dqpyB8MkB//YD+MW0eeXdd59saqDCxFhQ1dFLgzcbstwoANwhkyYeH2wY+ZQgN
    ZFYiI/ICqdtFF07QZWsEViRErvgmsQ8meAIQPYF61zAAy93wsKHiAIj0TElw
X-ME-Proxy: <xmx:-HMyal6G81ywN9eIJsjwUZlwEl8m3QLE3ULEEGMwn8BXn35BNi2Hxw>
    <xmx:-HMyar0n16py-wQwOFsfHfGJnlQyE0WYrarJgsaWreJBCh7mhYcOxg>
    <xmx:-HMyauakIzH1LCIc-olZnDGr4ywmQKLW4bZk7Achr9TUZLaZhtAZqw>
    <xmx:-HMyarCM8EWwyDyZLzCyE-hJn87jR9MHsL5HKpz1Y-mtz6Adb-h7Gw>
    <xmx:-HMyanZx186cjDLRof-FHpZxil8Ebifgh38krlBpS8oCXTv-JEYpTHuq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 06:16:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5c4248d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 10:16:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 12:16:02 +0200
Subject: [PATCH v2 5/5] builtin/refs: add "rename" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-refs-writing-subcommands-v2-5-07f3d18336f9@pks.im>
References: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Add a "rename" subcommand to git-refs(1) with the syntax:

  $ git refs rename <oldref> <newref>

It renames <oldref> together with its reflog to <newref>; even when used
on a local branch ref, the current value and the reflog of the ref are
the only things that are renamed. Document it and redirect casual users
to "git branch -m" if that is what they wanted to do.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |   6 ++
 builtin/refs.c              |  49 +++++++++++++++++
 t/meson.build               |   1 +
 t/t1467-refs-rename.sh      | 131 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index e6a3528349..ce278c59bf 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -23,6 +23,7 @@ git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude
 git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
 git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
 git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
+git refs rename [--message=<reason>] <old-ref> <new-ref>
 
 DESCRIPTION
 -----------
@@ -71,6 +72,11 @@ update::
 	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
 	ensures that the branch does not yet exist.
 
+rename::
+	Rename the reference `<oldref>` to `<newref>`. The old reference must
+	exist and the new reference must not yet exist, and both must have a
+	well-formed name (see linkgit:git-check-ref-format[1]).
+
 OPTIONS
 -------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 92e62fd5df..c7aa1a327f 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -30,6 +30,9 @@
 #define REFS_UPDATE_USAGE \
 	N_("git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]")
 
+#define REFS_RENAME_USAGE \
+	N_("git refs rename [--message=<reason>] <old-ref> <new-ref>")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo)
 {
@@ -327,6 +330,50 @@ static int cmd_refs_update(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_rename(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_rename_usage[] = {
+		REFS_RENAME_USAGE,
+		NULL
+	};
+	const char *message = NULL;
+	struct option opts[] = {
+		OPT_STRING(0, "message", &message, N_("reason"),
+			   N_("reason of the update")),
+		OPT_END(),
+	};
+	const char *oldref, *newref;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, opts, refs_rename_usage, 0);
+	if (argc != 2)
+		usage(_("rename requires old and new reference name"));
+	if (message && !*message)
+		die(_("refusing to perform update with empty message"));
+
+	repo_config(repo, git_default_config, NULL);
+
+	oldref = argv[0];
+	newref = argv[1];
+
+	if (check_refname_format(oldref, 0))
+		die(_("invalid ref format: '%s'"), oldref);
+	if (check_refname_format(newref, 0))
+		die(_("invalid ref format: '%s'"), newref);
+
+	if (!refs_ref_exists(get_main_ref_store(repo), oldref))
+		die(_("reference does not exist: '%s'"), oldref);
+	if (refs_ref_exists(get_main_ref_store(repo), newref))
+		die(_("reference already exists: '%s'"), newref);
+
+	ret = refs_rename_ref(get_main_ref_store(repo), oldref, newref, message);
+
+	if (ret < 0)
+		ret = 1;
+	return ret;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -341,6 +388,7 @@ int cmd_refs(int argc,
 		REFS_CREATE_USAGE,
 		REFS_DELETE_USAGE,
 		REFS_UPDATE_USAGE,
+		REFS_RENAME_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -353,6 +401,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("create", &fn, cmd_refs_create),
 		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
 		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
+		OPT_SUBCOMMAND("rename", &fn, cmd_refs_rename),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 541e6f919c..a39fd8c4c4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -226,6 +226,7 @@ integration_tests = [
   't1464-refs-delete.sh',
   't1465-refs-update.sh',
   't1466-refs-create.sh',
+  't1467-refs-rename.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1467-refs-rename.sh b/t/t1467-refs-rename.sh
new file mode 100755
index 0000000000..f80d58e0f4
--- /dev/null
+++ b/t/t1467-refs-rename.sh
@@ -0,0 +1,131 @@
+#!/bin/sh
+
+test_description='git refs rename'
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
+test_expect_success 'rename an existing reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		git refs rename refs/heads/foo refs/heads/bar &&
+		test_must_fail git refs exists refs/heads/foo &&
+		test_ref_matches refs/heads/bar $A
+	)
+'
+
+test_expect_success 'rename moves the reflog along with the reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update --message="rename me" refs/heads/foo $A &&
+		git refs rename refs/heads/foo refs/heads/bar &&
+		git reflog show refs/heads/bar >reflog &&
+		test_grep "rename me" reflog &&
+		test_must_fail git reflog exists refs/heads/foo
+	)
+'
+
+test_expect_success 'rename with message records reason in reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		git refs rename --message="rename reason" refs/heads/foo refs/heads/bar &&
+		git reflog show refs/heads/bar >actual &&
+		test_grep "rename reason" actual
+	)
+'
+
+test_expect_success 'rename a nonexistent reference fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs rename refs/heads/foo refs/heads/bar 2>err &&
+		test_grep "reference does not exist" err
+	)
+'
+
+test_expect_success 'rename to an existing reference fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update refs/heads/bar $B &&
+		test_must_fail git refs rename refs/heads/foo refs/heads/bar 2>err &&
+		test_grep "reference already exists" err
+	)
+'
+
+test_expect_success 'rename with empty message fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs rename --message= refs/heads/foo refs/heads/bar 2>err &&
+		test_grep "empty message" err
+	)
+'
+
+test_expect_success 'rename with invalid old reference name fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs rename "refs/heads/foo..bar" refs/heads/bar 2>err &&
+		test_grep "invalid ref format" err
+	)
+'
+
+test_expect_success 'rename with invalid new reference name fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs rename refs/heads/foo "refs/heads/bar..baz" 2>err &&
+		test_grep "invalid ref format" err
+	)
+'
+
+test_expect_success 'rename with too few arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs rename refs/heads/foo 2>err &&
+	test_grep "requires old and new reference name" err
+'
+
+test_expect_success 'rename with too many arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs rename refs/heads/foo refs/heads/bar refs/heads/baz 2>err &&
+	test_grep "requires old and new reference name" err
+'
+
+test_done

-- 
2.55.0.rc0.786.g65d90a0328.dirty

