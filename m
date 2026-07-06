Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCA3A383C
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344450; cv=none; b=JRuOJtMeVxt4tX+/MJJBFUbrre36WBtla3y0hMzgDBiYA8y68Dq45EkB8OhRz/s/Ag7vL1YT8+yj1EEhQycrbQZHymGMcear53rvWRKbTxyBpHltG3Yb0NE1XHxgaU4sdyk40+N1zoBn+Wdixmm59sNIabibMzJ4Uz7/Wkc0KW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344450; c=relaxed/simple;
	bh=3NvyG8EzjbXA9fiiSiuVP5xDYzGEvpyQNJphrmI3q+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaoikxRL0J/Ce5+HhuUP9TdeagFSNkOdwHdjgIkb87qG5H6Br77HBBhZkbxnSOACexK3VkFE6TKvHcNbjFIIYe2N7UH6/qUFqrulIdilr9xQooktSHWfON22ZkDdREWWsdUuM6gmHCRYbQ8sNdlnOK6ivrN3bY1WU7P/7sbPhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Is53sYnF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9CPcYw8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Is53sYnF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9CPcYw8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A3147A0166;
	Mon,  6 Jul 2026 09:27:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 09:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783344443;
	 x=1783430843; bh=sSxAH2Sz/dP/pxvXzeFPQZxry3dKOQRADnXOC1cLuio=; b=
	Is53sYnFOa5+t2SIuRO0hGgH2n5XbUWOzISJbZhSpNGs6f3LzBjL6pyTKoOpkbny
	+7Ssnxawuo5mS+ca03C/iuNkRICIluE9yCehMKjT319FKDijKoAFgl7PhBf19jhR
	0rPXLjhwZd7Y5gLYDRwP6nBRufHh2N1BLvs6kA0l/pYeoM1iiQ3dU6IUX7byXsQz
	wf2dn9Ug8G1CKkTIQGda5Mo10OHBJ0I5WxEV7ykbkd29Ct5T8+xUpX7fKphyCR5a
	CmSK7BKB/V0tc7qMTpXAUMlTZDcOIGhiqjPkXip2FFWvtIIYDvX9uNJYAqTd4tls
	Dwg7fT/Wg4uQjiZL/aqusw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783344443; x=
	1783430843; bh=sSxAH2Sz/dP/pxvXzeFPQZxry3dKOQRADnXOC1cLuio=; b=i
	9CPcYw82J2RRru+mcf2ro79LtPmk4uSyU/W5D4HjctnwlpV4IMAmjvADqSQjmwiv
	8eTOquqNfCQxwzY9P0KytO+2RSLAfG5D2WoRhCQS5UDcQevDkJbetvikpLsXg7tC
	K1r/Nn6tR3Y8kxUNNleTHkss5qbT/2VaLAouw6Zf4XHvHTSM+9AiIcRVUHlDW2NS
	CAzMBr3GCftPUfe6MxYJXri7mwGjDZouU63oznFtSQYX2Gd5+IlSrtySpU+Ik8Yy
	SpgQzBeJ/TLu3Tgu6DPFdW27EosGEhBufeMRiu1bZTEN0iyk2wGQGPXvc/U7bbIg
	ZwlAmzggAeaJ5Gjisy92g==
X-ME-Sender: <xms:O61LanMWdTXeAGFDwbn1Ji8HXysL6WF6ZDIhkM1NfsGd_iLb_oRLbQ>
    <xme:O61LapbY2xI08OPbq2zbyuAn5vxFa0u-9wTvAb6PhaXuqhq7orMWN5vuz4Ro4F694
    1i90DJZpvsjwUIS12Zc-o07yLZhMLEhmJ1EYig6zsQToTpEfI1nOA>
X-ME-Received: <xmr:O61LajoE-H6TKrEmqDFwPa8fCVwgjyPaGEXm2_n5u0CRyRaRTTFLS7BM4pfzZXpN84DBfPlHXJkna48rZXjVyHOaJSKhkR5gF2TU-i_Z7AM>
X-ME-Proxy-Cause: dmFkZTGmkoL1fQMVt3Y9VhFIAhL9ZJIzDkq3EWLQg2Xy60xhBQNOdU3yeSNWtyur7wa+zp
    HmQVWqwr5HOVD8HHxN05/bzMr12IZT1tfZFhB4fEzrvxjBhOC/mwgYAKTmjYGlyR1pZiFr
    xkvOmAp4zJ7FN8u8y0ftJxNlCFqapxv+dvBgtjCV4GoMNfHGzoN3gWOwjSfGiVZwdyIgsf
    BqUW0s2PAypR4UoEipHqRldrFUvJ+Wx+cG6QP27viYk+PUptz21xn77awYf9PjvL7kzx19
    mYqXICYGBgkOCOG4hQJ6La/K3kujvDaHLDAPasiem9y1yJctTXrDjKFVkzSU9xQMcyg8HL
    D3uEGiPK5UtT+GUlcAk0F4efgMahzu3KPxVHmZk1/wY2qiuMqAOWpigUP3VCuzrcGzPrrS
    CEHjHDNoMYT26v16Z19aV1/4O30uzNo8+3RK29Ry9SR0WKRQPD/PMH9QknVadehb2wYXWc
    XvlYwSIROh6l0LD5vo+JwskITxt3Z1bMXjriH/1VgmfazCgbcZfxlmxR1eC21EUrmf61fa
    iYBOmUWK8qX6UkLhCk8bnpxnEDAEbnpMsXglTumqjaHxTrNFvgZ4gIM+Rxx+gC7BF7xB2R
    CMmrBjCVUz3KcfeS6e2+ulLn24xJnWbKQTwitfe449h9uUH/gC26gJDLp6Wg
X-ME-Proxy: <xmx:O61LalZsqP21piJhay8RBBqVULT6F6zPdb3QHtSMMLxJT3n5BALy8Q>
    <xmx:O61LajTgtC9O5TW4uC8q7nOsErqlY3O4HwD4u0JwtVfqPG7qJ59GMg>
    <xmx:O61Lak6v86PbP7IE1rBECQOiPJmPe4HCnzSV-6AiMqHPMpCYZp-HZA>
    <xmx:O61LagzC_Gt11mlAN3I57xBPcZJh5s_RSMcHAiy7P2MG0hcVcCPbHw>
    <xmx:O61LapBNMiB_lF17EfM6T44q34DX8Yv4JLFWeFsyW8kVGsdZPEDagPGk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:27:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1a1083e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 13:27:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 15:27:08 +0200
Subject: [PATCH v4 5/5] builtin/refs: add "rename" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pks-refs-writing-subcommands-v4-5-d51f6ce7f830@pks.im>
References: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
In-Reply-To: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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
 builtin/refs.c              |  49 +++++++++++++++
 t/meson.build               |   1 +
 t/t1467-refs-rename.sh      | 144 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+)

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
index 1ebaf30149..a9ca2058ee 100644
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
index 0000000000..2b28be75c8
--- /dev/null
+++ b/t/t1467-refs-rename.sh
@@ -0,0 +1,144 @@
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
+test_expect_success 'rename with symbolic ref fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs create refs/heads/target $A &&
+		git symbolic-ref refs/heads/symref refs/heads/target &&
+		! git refs rename refs/heads/symref refs/heads/renamed 2>err &&
+		test_grep "is a symbolic ref, .* not supported" err
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
2.55.0.795.g602f6c329a.dirty

