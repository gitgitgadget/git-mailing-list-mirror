Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE676EB5B
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690662; cv=none; b=psP4H60r5faqse/phLumQwBnuKaMQwrpJ5Jq41Lw10VQ5qKlUKLVshLgTbTXqzsYKGfuPxDUtD+fHMbjw9OKbkZ/2oH2MZU0RW9wmaSQsi6sm2BRbL73YAF+mkDGfWGKTTl/bbMxWJJZPDLEqLX0TICwSYuxpWI8H1/+0j92fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690662; c=relaxed/simple;
	bh=H2noO7Ox77dyHTPcjWGS9hMvnRpEw1BFgCOUphT6Ve4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOesRp7Q9G1rRTXshy5xhpCe4TSQaKSq/z7e4DpyoOAV5qNsybM8bqACBvvowm2vOynkRgYa7N+edmsCwx0yysUmkEfE4CCLmM+aXId0egimjAzxq4+bbhJbri1/mmjf30o1DtUGGm6b8Rc6kwbalGM5WHQlH4aVDINXkIbqCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg1eW8f9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg1eW8f9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572d2461001so55420a12.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690659; x=1716295459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/u1IAqB4liMlXYJK8OJ071/4d4w4Ma8fQTPrbGMUvs=;
        b=Pg1eW8f9jTt+Ckkl0zVvz1lN804LvkPbh8FrTnvmfG3UuDHIpjI1iIgkjJ+Zmg+ef1
         M+ux0WxCSru6KI8xG6J6hXXj+7jiRW1Q0gNbXGVAzwGjUVRQh9nExLGA6AgZ7lwHyJFd
         JU69nmfjbIOmFHaq2eL4ZHWf9FzeoBBNpDLp0OXT60Mliajv9TNNzwNnkXs6DpTCEA34
         CPxStSKTuzKHVpHfipYX6GVzKlECVbMRXZZKP9PMR32X8lyDrLJtApuuNP/55AZpq5r5
         +tp/KtIBgUh5tvHOCit/HBM1A7J7EYPfVBMdxQ8CB8fZ5IMk0ebogC4wPNrKrklR+jnO
         iDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690659; x=1716295459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/u1IAqB4liMlXYJK8OJ071/4d4w4Ma8fQTPrbGMUvs=;
        b=bu/iaUsPfEARCafiR3IlMm562VKGKEXlCYfeA60PpJjecLx0rUuuhmxQCQamcQ8jnm
         nd2y8GqX+MNqbgvqYFaoKYc3Asl1tUb0fyqzcJY0+oaWGIRpT1Vk9+soVKa1ZcL1+jW6
         f0bE6KWzDT4/zi2mVL2dgNQFTFTlsQVG0kpE3fZxoIsNzgIXDRDeItq9wE4M5l0i7Eu7
         dYLzGruMha8YgDs15zr5Vsux5ENAX/mo0LB746eggUpK0l4qa9UOozOjGf7J8bAuTyTU
         rkmnU9mjCsLGYWKykffLjR3CkCmqbXSgU3CaEDaXppmQ/5Y2skZf9URbOs8JZTidfK79
         XPGA==
X-Gm-Message-State: AOJu0YxP3rK077I6iKYkEfqRumgYvfnmQOmVUOb4M5CVFXLV3rStheK/
	OJ2I835mZO/iYvfEk+wr5gVgKJQU9A70owsVp2DtulSbtwnf2a4u
X-Google-Smtp-Source: AGHT+IEKK2oHY436ct8FSRdyyFWJnJIA/yH8YPVoZ6gcIwn2WFRVszczTwJSRX7Tny3FO9N5r7twUQ==
X-Received: by 2002:a17:906:dc92:b0:a59:bc9d:a0a3 with SMTP id a640c23a62f3a-a5a2d6bc037mr1241742266b.75.1715690658534;
        Tue, 14 May 2024 05:44:18 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b019edsm730530566b.174.2024.05.14.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:44:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH 4/6] update-ref: add support for 'symref-create' command
Date: Tue, 14 May 2024 14:44:09 +0200
Message-ID: <20240514124411.1037019-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514124411.1037019-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Add 'symref-create' command to the '--stdin' mode 'git-update-ref' to
allow creation of symbolic refs in a transaction. The 'symref-create'
command takes in a <new-target>, which the created <ref> will point to.

Also, support the 'core.prefersymlinkrefs' config, wherein if the config
is set and the filesystem supports symlinks, we create the symbolic ref
as a symlink. We fallback to creating a regular symref if creating the
symlink is unsuccessful.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  6 +++
 builtin/clone.c                  |  2 +-
 builtin/update-ref.c             | 32 +++++++++++++++-
 refs.c                           |  7 ++--
 refs.h                           |  1 +
 t/t0600-reffiles-backend.sh      | 32 ++++++++++++++++
 t/t1400-update-ref.sh            | 65 ++++++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh |  3 ++
 8 files changed, 143 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 16e02f6979..364ef78af1 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-create SP <ref> SP <new-target> LF
 	symref-delete SP <ref> [SP <old-target>] LF
 	symref-verify SP <ref> [SP <old-target>] LF
 	option SP <opt> LF
@@ -88,6 +89,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-create SP <ref> NUL <new-target> NUL
 	symref-delete SP <ref> [NUL <old-target>] NUL
 	symref-verify SP <ref> [NUL <old-target>] NUL
 	option SP <opt> NUL
@@ -121,6 +123,10 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-create:
+	Create symbolic ref <ref> with <new-target> after verifying
+	it does not exist.
+
 symref-delete::
 	Delete <ref> after verifying it exists with <old-target>, if given.
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 93fdfc945a..ac1e131d8b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -546,7 +546,7 @@ static void write_remote_refs(const struct ref *local_refs)
 		if (!r->peer_ref)
 			continue;
 		if (ref_transaction_create(t, r->peer_ref->name, &r->old_oid,
-					   0, NULL, &err))
+					   NULL, 0, NULL, &err))
 			die("%s", err.buf);
 	}
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0ef9c38d8d..16d184603b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -257,7 +257,7 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, &new_oid,
+	if (ref_transaction_create(transaction, refname, &new_oid, NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -267,6 +267,35 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+
+static void parse_cmd_symref_create(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *new_target;
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-create: missing <ref>");
+
+	new_target = parse_next_refname(&next);
+	if (!new_target)
+		die("symref-create %s: missing <new-target>", refname);
+
+	if (*next != line_termination)
+		die("symref-create %s: extra input: %s", refname, next);
+
+	if (ref_transaction_create(transaction, refname, NULL, new_target,
+				   update_flags | create_reflog_flag,
+				   msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(new_target);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_delete(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -473,6 +502,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
 	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
diff --git a/refs.c b/refs.c
index c2c9889466..6b724343fe 100644
--- a/refs.c
+++ b/refs.c
@@ -1302,15 +1302,16 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (!new_oid || is_null_oid(new_oid)) {
-		strbuf_addf(err, "'%s' has a null OID", refname);
+	if ((!new_oid || is_null_oid(new_oid)) && !new_target) {
+		strbuf_addf(err, "'%s' has a null OID or no new target", refname);
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), NULL, NULL, flags,
+				      null_oid(), new_target, NULL, flags,
 				      msg, err);
 }
 
diff --git a/refs.h b/refs.h
index 053c382f0b..055cc9173b 100644
--- a/refs.h
+++ b/refs.h
@@ -753,6 +753,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index a390cffc80..cc7e20431e 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -468,4 +468,36 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
+test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs true &&
+	cat >stdin <<-EOF &&
+	start
+	symref-create TESTSYMREFONE refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_symlink .git/TESTSYMREFONE &&
+	test "$(test_readlink .git/TESTSYMREFONE)" = refs/heads/new
+'
+
+test_expect_success 'symref transaction supports false symlink config' '
+	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs false &&
+	cat >stdin <<-EOF &&
+	start
+	symref-create TESTSYMREFONE refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_file .git/TESTSYMREFONE &&
+	git symbolic-ref TESTSYMREFONE >actual &&
+	echo refs/heads/new >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index fbc6b234cb..7955988ecc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1783,6 +1783,71 @@ do
 		test_must_fail git symbolic-ref -d refs/heads/symref2
 	'
 
+	test_expect_success "stdin ${type} symref-create fails with too many arguments" '
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} symref-create fails with no target" '
+		create_stdin_buf ${type} "symref-create refs/heads/symref" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-create fails with empty target" '
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-create works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-create works with --no-deref" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" &&
+		git update-ref --stdin ${type} <stdin 2>err
+	'
+
+	test_expect_success "stdin ${type} create dangling symref ref works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "refs/heads/unkown" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo refs/heads/unkown >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-create does not create reflogs by default" '
+		test_when_finished "git symbolic-ref -d refs/symref" &&
+		create_stdin_buf ${type} "symref-create refs/symref" "$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual &&
+		test_must_fail git reflog exists refs/symref
+	'
+
+	test_expect_success "stdin ${type} symref-create reflogs with --create-reflog" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
+		git update-ref --create-reflog --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual &&
+		git reflog exists refs/heads/symref
+	'
+
 done
 
 test_done
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index ccde1b944b..ff77dcca6b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -189,15 +189,18 @@ test_expect_success 'hook gets all queued symref updates' '
 	prepared
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
 	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
+	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
 	committed
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
 	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
+	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
 	EOF
 
 	git update-ref --no-deref --stdin <<-EOF &&
 	start
 	symref-verify refs/heads/symref refs/heads/main
 	symref-delete refs/heads/symrefd refs/heads/main
+	symref-create refs/heads/symrefc refs/heads/main
 	prepare
 	commit
 	EOF
-- 
2.43.GIT

