Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABC407CF0
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820166; cv=none; b=GL7MvEcFnzn193eBk6VFLGMEOWWmNEIFJ8MWis0weBx3JYPh8akqep5RMn22f45Sx8FReWji+py/Me/pWHGnMhVs62uXoNHIX3cjroNicHSVDzTCWfZMAaK58fYs4ItFfYzVwBu9ZtjX1aOf7CVELy6PS7CuBDN04E52HMMdh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820166; c=relaxed/simple;
	bh=7Xb5+0+EUZeNJpFqI9klBW7EnNr1G0cw6soM9y/k89o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poChYYyv2PKN8RTW5cvcVbDZmNdO938GEz51qtK3ilmpSbn1kgyZun76UHFkfqoiWx6F6FFfMizGpNkeGZexIzbIPdLTRgUrIAA+qKwHsxK8mhGVfffIircCPbkRBCL1pctYetlBtv+C0tzKgph5M4X0MF+ZhZPhdWX1LT+G7JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P0TiMN2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjursjIa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P0TiMN2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjursjIa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3339B7A0090;
	Tue, 30 Jun 2026 07:49:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 07:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820164;
	 x=1782906564; bh=pdtPsCh7XKGdFj/vwhRkocsyFcD3iT4y0+UBiA4D5Y0=; b=
	P0TiMN2iE2Jfk6hnS4mBcCEHU3JIeFORLeGC98bBVXsGtJdQnOxamM7zWpk82I+q
	TPBZM0Y6Gqza8MrQdmIgIwMe8JptbmpSNDsuwfWZjSJpZs5Rbh0lMmlDxTxV0w3v
	IsMdaiJFvounI7L6T4ldd3iO6m0tDzM9uaArJdMXS0ysu4CqMeKxVKNIMOZLI6ia
	9xWEYedgKgZ4hXIjokALTvKeY0rZnJDKJjBWLMKBbvWT4CvQKHDNVcz12Bpsm8MQ
	d9WlXwiCTGIoVTWYcxC5BUjpIUxDDJ1H+eAtRVoszIyquyM4nGPgvudnKLe+IaUx
	h+8a35ViotkYuJaA21gKYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820164; x=
	1782906564; bh=pdtPsCh7XKGdFj/vwhRkocsyFcD3iT4y0+UBiA4D5Y0=; b=Y
	jursjIa5I9eagt8ESoiVqDC/2yDqvXDEHnadlzR6Be4YUBfGkev48AKVSdoRW5C9
	fs8fk+21foSbQpIva5LH24uzXAeVNY8cIkM0nXU5EoCpq0wxQOZD7QoqJVNsWVjg
	5NJgfhYCOv1nuM7/xKy8SE3fJQVpGn4kCBfiB/4MIFfNh01huiChy4TYIXvF+EtN
	9SZRkW9tDONX0VsjA1DL/Nb00K8vKoUGKFCYnu6IZZQ/KHKf0FtOvduPbJqutFuk
	k5Y8Ncq+iZqGn/2LY20BEMmPHvBWL/AOtm3BZ6ZlTNE9l3p7CxwgK3FpvQvRBwMp
	9NKp4agbWOetNQQPnlu2A==
X-ME-Sender: <xms:Q61DallpsDeT137j5iTCIHltmuzt_JX8doSz9GtZnWUX3M3u4Vyxcg>
    <xme:Q61Dam1wYlkdeZphd8FhETlCTmr4T4wEt1AAjNK_U_6DyW8gFbbHbp4_2u_JI57JN
    oNdArYw5nIr4haMHhpHgmNMnsU3c8ZxNEwyxW1CQhaiqPf73gGH>
X-ME-Received: <xmr:Q61DapTCsN7qYZQR1_ocoMeM0YMFAfYvBFVBI27IRwWu7EpLo61rlqUixOI8RgGgRbHpAXB1-jvpZVe0KWmHUsnJc8i972o_qk1s0BX4QPrurw>
X-ME-Proxy-Cause: dmFkZTGPn1VYZMbRkJlHedMEcOxkt9RlxB5ISj2RvhAjsQ1SFILO3S+m+rE7n5JOATU8H1
    8XKaME0iq1mYar3zG2r6eFgb4/RbNhRpNSNHVQWrd2Ht70QfmQtiMJELKncKiz1lTqIRED
    sfUF8fUkEYTjkgBatlzgOGdL5UDmpV43sqU0lNw56DR/1+hi9mEgxHwuQTPajk8efosn8R
    IkOYQXMFdkzShDvaCWOLZSLisZgXn2JayO7x6RI0OZ3C1Q0it0wqzXr8FJIAvpNIjwL9EU
    B9jsWo4actexlqadqeRIhizZsHq92C26qmJaloA/9RJuYA+HJr3J5AXQ2L2i5e1XdWbtAr
    dx/jb73LaeH67EFqjAJBTzbJu3hXm4gOrJq4+ZMmG2H2+h3AZEB/Lyk3PoS3Ry9o4wS5eY
    kxvbIhkegZ6Iecgl//wPiqx02ae46yRYcAUbar2gtAe+3E9NEhZRnYvcqSE6oBjY+BloKY
    c7Zylnko1NVL+U1eZTqJ0sZYgby9QAO5KD31fICHlmq3KmxobeKnd9fCAfzDFQqBibza80
    0dObltKDwOM9NqcfKTm2bG7bdkI7S+F06pJL6vymfZK+ssFLl/uvNfIwqvie0yQfL4Fuz8
    4GLiCx3+AF36LaMb+jtkVkjV6VkhGbzIVZRIFj3M+MBKD0HHXH1HNoAEBOSQ
X-ME-Proxy: <xmx:RK1DagsaXoDDPfKY95oNC3hu5IgkXy161-amOwZsqBfT3MND66XMTg>
    <xmx:RK1DamZ2Yanm81xOFPNwOBGU8xcLy8JktL1E-cLfWJdVcUKjK4CI7w>
    <xmx:RK1Datv4fubgF5Bk4Z5EmshDLPZf3VwzTrz1RVG5E284YFlEnRxAEA>
    <xmx:RK1DagFqHWeOygKY9JYFtVYvnabDB2npyGf5YVVF1QCETQjCGCEu4Q>
    <xmx:RK1Dag8Y2j_MkY-kKAiZSoKxMBHbXyVTLS6DoMLBpDCdRnOynZF5yIpI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:49:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f902f572 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:49:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:49:08 +0200
Subject: [PATCH v3 5/5] builtin/refs: add "rename" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-refs-writing-subcommands-v3-5-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
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
2.55.0.795.g602f6c329a.dirty

