Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BC42E000
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344440; cv=none; b=j7uibMWPdRx4iyrrWuumq63c8ydla/TH5YzdWtrnaQjZ+S0FacOPUOevy+TzXBQJzdd2QrZb6iPPxLlRYxRwf5DWBDL9OOVwzN/khLMAn4gJ4Sv+no/ofS5OYg/0TnwU+wIT2KnmekhX/fEvvQvJdDzTzjEm5Yzyw7ijfopLfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344440; c=relaxed/simple;
	bh=Mm+d9kliVOYY5EUqG1UoefNUzF1v0BqdwpgGAwzPTPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4ZH2zVXn8M0nqvMPxs7dvsPiudsFWsGH61+Nl/AYfIKtt0AXAjMeZdeSKMWgmhEo1srQ90iqoS9JI1iLTccrT5c58u6lj9eVtvHTM37OKB/1bPyZz4yfzVoOm4AL8t6Gr6aCcCWzzMFBLa7hnirvLk1ZHW8dDNr+XCN2/B9vyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FzI17hIj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOrTzb6P; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FzI17hIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOrTzb6P"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9231C7A016D;
	Mon,  6 Jul 2026 09:27:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 09:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783344434;
	 x=1783430834; bh=wpUe3/xOQr8y2eLID0Evk2f0hsIC4K3zFOs7SpSwXbw=; b=
	FzI17hIjhZT0cvorF5edsSKuPTyMeqroWATUqHls0qNtwY/9zvZAGBpg+1SO1qtV
	8db33EFiCmznyRC5RpTPtuEaYWqbdEpZ8irsozEmlmCLDiiH+nfEz6rxBzf7Px6J
	eWJkfg+oVfDi8+xDmzpND87p0E3rLeeNyhf+50vMlQIfSDBBUQ7aYl3OGD7RQYkk
	ZpRtzpfQAA2ZVUKY/6P/1Ncw9Y681NZ4PRs3ZaETZRbsELVlL6KSSN5RJx292kJh
	BYJXLVlEC07A7APbT8Joe8JBA7KC6A7ESibsaKe7A+LUH2OAoQxGw7shBa+io2dq
	L0HNKPEo60yZR3QnP7KnRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783344434; x=
	1783430834; bh=wpUe3/xOQr8y2eLID0Evk2f0hsIC4K3zFOs7SpSwXbw=; b=g
	OrTzb6PCzct/7utK5QXAiIs0BCROKFHrWbAwH4MosXrjO5EolwitS9WUEE7DAHoU
	x5LpC5dzdGRR/WD5VXxUKk3sTalhdUJ0N4HTmv8l6GFOnbLQsg8/wwxaBCySA+/f
	YIWp/wDLucRMCnXZckEfnOuha9xd6uHmW4nhYVRMajEDkZ06MUoYxVqR1rGlyG4T
	12g0m1rQpHOyYGoSkPbhBGX0i8QmBPFNNcjg0yBN3N9fia20OAm3uPrNrg+ff3k7
	MF7rfIWr5vDIVwy5nC+ZwgCgKG7q5XfIYXmn4f3D7Leweu9cbpEUjbOB4w2jdmQ8
	sUa51ehIOOfw/vtLZks0g==
X-ME-Sender: <xms:Mq1LaglzRf9Ych44KBW8HAmT8SrlXZit6vY0_roa-qROAtFjN71fBg>
    <xme:Mq1LanQICqJSxeLzCtAv7ucIhBdmmkAJviaSZcoPSv3ylpKZ245y9tehbtT4JV_BT
    6BIY_MYV5VLmXdXyoaWRFsWdKYrp-zYDXMvu6P4pHvJBQxUUbQWRg>
X-ME-Received: <xmr:Mq1LasDZS5nUP_YDDzDe5X0UY_-cqFkDZ_QdPu0-jyVkyuTlYs95zxOIDcYX8lwUHUFZSJgPPOu4T2SkGjdjm1w7AoJDApxwWesAigvZV0U>
X-ME-Proxy-Cause: dmFkZTGmkoL1fQMVt3Y9VhFIAhL9ZJIzDkq3EWLQg2Xy60xhBQNOdU3yeSNWtyur7wa+zp
    HmQVWqwr5HOVD8HHxN05/bzMr12IZT1tfZFhB4fEzrvxjBhOC/mwgYAKTmjYGlyR1pZiFr
    xkvOmAp4zJ7FN8u8y0ftJxNlCFqapxv+dvBgtjCV4GoMNfHGzoN3gWOwjSfGiVZwdyIgsf
    BqUW0s2PAypR4UoEipHqRldrFUvJ+Wx+cG6QP27viYk+PUptz21xn77awYf9PjvL7kzx19
    mYqXICYGBgkOCOG4hQJ6La/K3kujvDaHLDAPasiem9y1yJctTXrDjKFVkzSU9xQMcyg8jq
    PjJ56LUSqEhqWCGWx6zolu4Zwd9EF36VUUGAE43ZAkh0HY3FN0/5E3BDaxtq5ovFraCdJp
    TXncNcJPixsxwwEnLs9tzjnuOdke08HXsIVU5hHAaIncNObMr5zTPdWeyQzPn4w8EnItP1
    F128NM2VWKdBg3gCM76aVAyGQPnCp6sco77Zb0ScAy1i3mDmmICDGrjZ02OdU3gndUxFSq
    bNCJMp9/ml+L3e7DPurjYnHu6IFm4PVD/4l+U3rUQgXxGwBDvyJHv+6IdJmA1VJ6Z4h6rb
    VgH3V2vutwjiVKLpkM+imc2iNjY611Fa40od66Fv8LxltoS8HgVBCANjTm8w
X-ME-Proxy: <xmx:Mq1LamS6uJDbQWlWvyAMe4iOk2_-WsI7tYfJgTlbikelA0AyB0zMyw>
    <xmx:Mq1LaiqwroyupQVL-v-LGY77_8QQWuyORq6Wkx7C0j_bYIZgWzGLBg>
    <xmx:Mq1Lagw_8LU5OGL8pTJ-vMgWUzZGw8kq_2z93BMBBNE0fLw-Ajmiug>
    <xmx:Mq1LavKp0kR99hH8L0UyKsQ7JqaamDnWUm_PJe2kWdzNM57klkhq-Q>
    <xmx:Mq1Lag5upln0fkZJhTdomF7Jj-AseNTO3m1rZH705C53Yq6yqwb0eUWO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:27:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af03a038 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 13:27:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 15:27:05 +0200
Subject: [PATCH v4 2/5] builtin/refs: add "delete" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pks-refs-writing-subcommands-v4-2-d51f6ce7f830@pks.im>
References: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
In-Reply-To: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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
 Documentation/git-refs.adoc |  17 +++++
 builtin/refs.c              |  51 +++++++++++++++
 t/meson.build               |   1 +
 t/t1464-refs-delete.sh      | 152 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)

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
index 0000000000..c88063e494
--- /dev/null
+++ b/t/t1464-refs-delete.sh
@@ -0,0 +1,152 @@
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
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git update-ref refs/heads/foo $A &&
+		git refs delete refs/heads/foo &&
+		test_must_fail git refs exists refs/heads/foo
+	)
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
+test_expect_success 'delete symref with --no-deref verifies target OID' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git update-ref refs/heads/foo $A &&
+		git symbolic-ref refs/heads/symref refs/heads/foo &&
+
+		test_must_fail git refs delete --no-deref refs/heads/symref $B &&
+		git refs exists refs/heads/symref &&
+
+		git refs delete --no-deref refs/heads/symref $A &&
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

