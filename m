Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B66BFBB
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690660; cv=none; b=hz4A+PSSu6tN6cURoUDRQWh98eL+20bWvqqV7xMh3IhEkIgdQo76kJhQ67Gq6MGE3IObzA46MhtdbvVL3p06onRS+nfG39d2P6LmCCN2RmFYcwfezxBDSYv0an/taGSPC8nO3Yr8Wvaoy45mxs0SIizEv2xQUkdARc5aNn0DVUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690660; c=relaxed/simple;
	bh=OLUGdXNYYrdcSKczPkPLqKgFd1ZNTW3g1JAKX/bQ1DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCONya4PwKAR/Ce050iNK09X3cvsM6o6PuuzUZquEODV65prfRYTL2mOMsNiw+uIIzqr5OnBIbI0ynGq1pDa4FNouNkcPdfBrPlhdH43o7w0vPZBoOT1Df8JZSJidr4QDH10DetP0H5VLRpVr6itaJI/giAcpLcpC43FxLFghxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfEOxPYX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfEOxPYX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a0168c75so26922866b.1
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690657; x=1716295457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx9rLaFRPbB573U/Fwx9Pco7rETAQKVhR7jc6iym0cI=;
        b=XfEOxPYXrLZV4bWbOEbaHfsjTDuUBHn6HnVEZTTPfx8kM1Wnrx5Lxj1UO3sAwnoCpV
         30pOzHmRZ0IhTuY48YBoQR2hPv8ktJM0+nUdbqhlwXuvNqLPdGE6TcyD3+cPX7B+LoGE
         9uTWoeelxNYXhRaAKWuYWsutr5sLjnDMevFveT9/x4Nn3DLGZzemxERIcjsTyiZZQplS
         E37U+Nmt1sdLnbq5OS5ABJOlWZAQJVZ919alCt4LNJVC2r6KYAIGWuY0uiJ5Yf7uO+Vx
         MbXhaZ21VXciilMZxtmBVwgR85nzxXPTb/BUeKufCBeL1PUITtXXWtpCXSMMJ0wq+S7T
         rhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690657; x=1716295457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dx9rLaFRPbB573U/Fwx9Pco7rETAQKVhR7jc6iym0cI=;
        b=Ff5VZvB8SHRFHAwxgogVGvLFeSqr8BvpM0p7yPfILfx1YwkFyAlhCSc1y4GHmK0nOZ
         Gxbpasn7N1sisnCsdoc3M6OqVzR9TlzbmS1z/cMS2whbNWP7PSCSpbI/kyig0zChm+uj
         kzfx5h7CXGQS0PaqzaEg2VWcTSSY6W9EnHfc5AvwGJ5D6H3Iu3RNdyZQqBGck6M6DFcM
         7N/VLlgNndLpzsOCoqEjs0Uhjg0A6PaAfQ6pfmB33JfYIm6SoQn0KDVQ/fvK+F//izCa
         qEXzqEIdE3IfiJO0g1LuQOFevA4i9fCsVfDLzzn0HxZxc6YQGAatHalDiBXYpUX1b1LN
         Ucwg==
X-Gm-Message-State: AOJu0YxOjb6B1usolNO+2U8X2Wkrg+nonGjvIrCzl7BIIbcZiWkbrjVH
	htomKzrRWcq9PpuasoAOgX9Dbetf1cEHweQh4OQNTXYTCPCI97PywLtu/Q==
X-Google-Smtp-Source: AGHT+IH9gEdBIQ7q4SHoUTRDL6mBw1TiUZQIG9aSw+gW+KoaS2oG7BOu19rC45QdB078PZsT/bRJSw==
X-Received: by 2002:a17:906:3ad2:b0:a59:a857:85ce with SMTP id a640c23a62f3a-a5a2d65d591mr829710866b.52.1715690656335;
        Tue, 14 May 2024 05:44:16 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b019edsm730530566b.174.2024.05.14.05.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:44:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH 2/6] update-ref: add support for 'symref-verify' command
Date: Tue, 14 May 2024 14:44:07 +0200
Message-ID: <20240514124411.1037019-3-knayak@gitlab.com>
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

The 'symref-verify' command allows users to verify if a provided <ref>
contains the provided <old-target> without changing the <ref>. If
<old-target> is not provided, the command will verify that the <ref>
doesn't exist.

The command allows users to verify symbolic refs within a transaction,
and this means users can perform a set of changes in a transaction only
when the verification holds good.

Since we're checking for symbolic refs, this command will only work with
the 'no-deref' mode. This is because any dereferenced symbolic ref will
point to an object and not a ref and the regular 'verify' command can be
used in such situations.

Add required tests for symref support in 'verify' while also adding
reflog checks for the pre-existing 'verify' tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  7 +++
 builtin/update-ref.c             | 80 +++++++++++++++++++++++----
 refs.c                           |  9 ++-
 refs.h                           |  1 +
 t/t1400-update-ref.sh            | 94 +++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++
 6 files changed, 206 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 374a2ebd2b..9fe78b3501 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-verify SP <ref> [SP <old-target>] LF
 	option SP <opt> LF
 	start LF
 	prepare LF
@@ -86,6 +87,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-verify SP <ref> [NUL <old-target>] NUL
 	option SP <opt> NUL
 	start NUL
 	prepare NUL
@@ -117,6 +119,11 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-verify::
+	Verify symbolic <ref> against <old-target> but do not change it.
+	If <old-target> is missing, the ref must not exist.  Can only be
+	used in `no-deref` mode.
+
 option::
 	Modify the behavior of the next command naming a <ref>.
 	The only valid option is `no-deref` to avoid dereferencing
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 21fdbf6ac8..6dce1cd663 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -76,6 +76,29 @@ static char *parse_refname(const char **next)
 	return strbuf_detach(&ref, NULL);
 }
 
+/*
+ * Wrapper around parse_refname which skips the next delimiter.
+ */
+static char *parse_next_refname(const char **next)
+{
+	if (line_termination) {
+		/* Without -z, consume SP and use next argument */
+		if (!**next || **next == line_termination)
+			return NULL;
+		if (**next != ' ')
+			die("expected SP but got: %s", *next);
+	} else {
+		/* With -z, read the next NUL-terminated line */
+		if (**next)
+			return NULL;
+	}
+	/* Skip the delimiter */
+	(*next)++;
+
+	return parse_refname(next);
+}
+
+
 /*
  * The value being parsed is <old-oid> (as opposed to <new-oid>; the
  * difference affects which error messages are generated):
@@ -297,11 +320,47 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_verify(transaction, refname, &old_oid,
-				   update_flags, &err))
+				   NULL, update_flags, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	strbuf_release(&err);
+}
+
+static void parse_cmd_symref_verify(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	struct object_id old_oid;
+	char *refname, *old_target;
+
+	if (!(update_flags & REF_NO_DEREF))
+		die("symref-verify: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-verify: missing <ref>");
+
+	/*
+	 * old_ref is optional, if not provided, we need to ensure that the
+	 * ref doesn't exist.
+	 */
+	old_target = parse_next_refname(&next);
+	if (!old_target)
+		oidcpy(&old_oid, null_oid());
+
+	if (*next != line_termination)
+		die("symref-verify %s: extra input: %s", refname, next);
+
+	if (ref_transaction_verify(transaction, refname,
+				   old_target ? NULL : &old_oid,
+				   old_target, update_flags, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
 	free(refname);
+	free(old_target);
 	strbuf_release(&err);
 }
 
@@ -380,15 +439,16 @@ static const struct parse_cmd {
 	unsigned args;
 	enum update_refs_state state;
 } command[] = {
-	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
-	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
-	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
-	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
-	{ "option",  parse_cmd_option,  1, UPDATE_REFS_OPEN },
-	{ "start",   parse_cmd_start,   0, UPDATE_REFS_STARTED },
-	{ "prepare", parse_cmd_prepare, 0, UPDATE_REFS_PREPARED },
-	{ "abort",   parse_cmd_abort,   0, UPDATE_REFS_CLOSED },
-	{ "commit",  parse_cmd_commit,  0, UPDATE_REFS_CLOSED },
+	{ "update",        parse_cmd_update,        3, UPDATE_REFS_OPEN },
+	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
+	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
+	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
+	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
+	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
+	{ "prepare",       parse_cmd_prepare,       0, UPDATE_REFS_PREPARED },
+	{ "abort",         parse_cmd_abort,         0, UPDATE_REFS_CLOSED },
+	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
 static void update_refs_stdin(void)
diff --git a/refs.c b/refs.c
index 59858fafdb..ee4c6ed99c 100644
--- a/refs.c
+++ b/refs.c
@@ -1331,14 +1331,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
+			   const char *old_target,
 			   unsigned int flags,
 			   struct strbuf *err)
 {
-	if (!old_oid)
-		BUG("verify called with old_oid set to NULL");
+	if (!old_target && !old_oid)
+		BUG("verify called with old_oid and old_target set to NULL");
+	if (old_target && !(flags & REF_NO_DEREF))
+		BUG("verify cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
-				      NULL, NULL,
+				      NULL, old_target,
 				      flags, NULL, err);
 }
 
diff --git a/refs.h b/refs.h
index 71cc1c58e0..48cec1ba72 100644
--- a/refs.h
+++ b/refs.h
@@ -781,6 +781,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
+			   const char *old_target,
 			   unsigned int flags,
 			   struct strbuf *err);
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ec3443cc87..8784c59a53 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -890,17 +890,23 @@ test_expect_success 'stdin update/create/verify combination works' '
 '
 
 test_expect_success 'stdin verify succeeds for correct value' '
+	test-tool ref-store main for-each-reflog-ent $m >before &&
 	git rev-parse $m >expect &&
 	echo "verify $m $m" >stdin &&
 	git update-ref --stdin <stdin &&
 	git rev-parse $m >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent $m >after &&
+	test_cmp before after
 '
 
 test_expect_success 'stdin verify succeeds for missing reference' '
+	test-tool ref-store main for-each-reflog-ent $m >before &&
 	echo "verify refs/heads/missing $Z" >stdin &&
 	git update-ref --stdin <stdin &&
-	test_must_fail git rev-parse --verify -q refs/heads/missing
+	test_must_fail git rev-parse --verify -q refs/heads/missing &&
+	test-tool ref-store main for-each-reflog-ent $m >after &&
+	test_cmp before after
 '
 
 test_expect_success 'stdin verify treats no value as missing' '
@@ -1641,4 +1647,88 @@ test_expect_success PIPE 'transaction flushes status updates' '
 	test_cmp expected actual
 '
 
+create_stdin_buf () {
+	if test "$1" = "-z"
+	then
+		shift
+		printf "$F" "$@" >stdin
+	else
+		echo "$@" >stdin
+	fi
+}
+
+for type in "" "-z"
+do
+
+	test_expect_success "stdin ${type} symref-verify fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: symref-verify: cannot operate with deref mode" err
+	'
+
+	test_expect_success "stdin ${type} symref-verify fails with too many arguments" '
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} symref-verify succeeds for correct value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin ${type} symref-verify no value is treated as zero value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-verify succeeds for dangling reference" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
+		test_must_fail git symbolic-ref refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref2" "refs/heads/nonexistent" &&
+		git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-verify fails for missing reference" '
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		create_stdin_buf ${type} "symref-verify refs/heads/missing" "refs/heads/unknown" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		grep "fatal: cannot lock ref ${SQ}refs/heads/missing${SQ}: unable to resolve reference ${SQ}refs/heads/missing${SQ}" err &&
+		test_must_fail git rev-parse --verify -q refs/heads/missing &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin ${type} symref-verify fails for wrong value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$b" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-verify fails for mistaken null value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$Z" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+done
+
 test_done
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 067fd57290..fd58b902f4 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -157,4 +157,34 @@ test_expect_success 'hook captures git-symbolic-ref updates' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook gets all queued symref updates' '
+	test_when_finished "rm actual" &&
+
+	git update-ref refs/heads/branch $POST_OID &&
+	git symbolic-ref refs/heads/symref refs/heads/main &&
+
+	test_hook reference-transaction <<-\EOF &&
+	echo "$*" >>actual
+	while read -r line
+	do
+		printf "%s\n" "$line"
+	done >>actual
+	EOF
+
+	cat >expect <<-EOF &&
+	prepared
+	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	committed
+	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	EOF
+
+	git update-ref --no-deref --stdin <<-EOF &&
+	start
+	symref-verify refs/heads/symref refs/heads/main
+	prepare
+	commit
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

