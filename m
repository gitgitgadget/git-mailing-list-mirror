Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C119AA68
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767193; cv=none; b=t2rtsaH6RU9b31xFQ5cYyU3e+y8hX01YYE3l1zDWkO+lYPPJdL+VrKiYixLo0/KWHPcKK0+4Pm+pNnQktd+dPZupwr1CR4WTfmmd0DQ6XITsRe1LtK4c3AICQwrIcD6BbTfroQhGrJt4u55WTT8TA9cqdiFePCG3MsXn8jOMxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767193; c=relaxed/simple;
	bh=DulOYP/O2rDjF+Kq+d881KvIYFo+QkDB93eOxpKGvSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAKqJckxSdKvuD96cKC9yj5xXTVLlkeBFWkMpTYv9a2IDnFABe5IL0f+NW+84drEzaSLLoIsGLcH7EbD9Z0pHJ1py5niocLDIDtEm+QR2hp1DsB61gHBYXsY8q/V0GR0xFF03FxLYMJNOyZ7uhSOSuNWwZM2rOoN95WI+mnkL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkFt+7bN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkFt+7bN"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso2747356a12.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767190; x=1718371990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJvj8oLK2adoo0Kr1iYI2blFmO78bImN1wU6pM5d93A=;
        b=lkFt+7bNjJRFie389KVe6ZFWrje0aXjscWQNfU/99T8lxaWu7oQVfU5xZezjiRcBoK
         PCunio5bmap0qi74jMUkQE1xXvzMDcPeMn9DXfq8rfpIE9SQxXyOYeH52LV+1AfjucO+
         EhpjAfmM09d6+Eoh7DaIeym02zwbc+ar4pEJDYfcBz+oPAKjiFKXHkO/7pYUvrQPNLm6
         Qm7KPX6k0N9XexVMjbMnwEH1j6pJ73DDZEpb7/sj4voJho5mAeHHtWXAzRlYSXaXzv6k
         CoJORKFiFnQ8LMqVzXvTWZykqHJWWLCpeV8rev2AAA3VC5+nXhoYDFc5v2Ve3VsKpzfs
         pFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767190; x=1718371990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJvj8oLK2adoo0Kr1iYI2blFmO78bImN1wU6pM5d93A=;
        b=X2xUKZz1Nxz/fbRPttfsl2QspsIL+Til/YihKRxAbapx9geP92/h+KinUg9+Hu7fRj
         P7DPTZZ8C5QlMwHEbG/w1f4Ju6QPV0lcAOT4rQkGMgG7x4zgqgrLkJ3JKmL/Y1qZD6k4
         EeSRwVZLMKIKaGUl+8JTFtn2xxwl4Ye/tNrPnt6eRhK/HVt5YDCZ0ivq6fPfzbWo9mw4
         KfruwisN1n8bS/uATjdi4ccFiwIVQW3IIxHsOu/rT8nlL2nAvF9/sJncq/TjFSQwGK5l
         L4V6eW/kbjtQYw/XeYnIJjqseqZ1ssH9/E+kpOpO/q2OlbaX0P0DcBzGDhmQ8eH3JSmZ
         SUvA==
X-Gm-Message-State: AOJu0Yzu6s/IKig2QVlT6QbMGPSPAL4VqhyNcuWokUo8IkjPDno3iIh4
	dQKXv/IWbC6clDuQAEQejkFQVPX/8/yOn3uJixMBa1bw2EW+GM4gly3oFwfg
X-Google-Smtp-Source: AGHT+IGS/n5JjRQfG6yHJ6r2uS2rL/FY9C2q6MrdxSbBEYdJESQjJjW16WdQzwBV2+Bq2VEv+2d6Lg==
X-Received: by 2002:a50:9359:0:b0:57c:5fcf:b570 with SMTP id 4fb4d7f45d1cf-57c5fcfb69bmr742851a12.32.1717767189793;
        Fri, 07 Jun 2024 06:33:09 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 3/7] update-ref: add support for 'symref-verify' command
Date: Fri,  7 Jun 2024 15:33:00 +0200
Message-ID: <20240607133304.2333280-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240607133304.2333280-1-knayak@gitlab.com>
References: <20240605102958.716432-1-knayak@gitlab.com>
 <20240607133304.2333280-1-knayak@gitlab.com>
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

Add required tests for symref support in 'verify'. Since we're here,
also add reflog checks for the pre-existing 'verify' tests, there is no
divergence from behavior, but we never tested to ensure that reflog
wasn't affected by the 'verify' command.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  7 +++
 builtin/update-ref.c             | 80 +++++++++++++++++++++++----
 refs.c                           | 11 +++-
 refs.h                           |  1 +
 t/t1400-update-ref.sh            | 94 +++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++
 6 files changed, 208 insertions(+), 15 deletions(-)

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
index 6cda1c08aa..50f5472160 100644
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
index 50d8d7d777..cdc4d25557 100644
--- a/refs.c
+++ b/refs.c
@@ -1297,14 +1297,19 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
+	if (old_oid && old_target)
+		BUG("verify called with both old_oid and old_target set");
+	if (old_target && !(flags & REF_NO_DEREF))
+		BUG("verify cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
-				      NULL, NULL,
+				      NULL, old_target,
 				      flags, NULL, err);
 }
 
diff --git a/refs.h b/refs.h
index 34568ee1fb..906299351c 100644
--- a/refs.h
+++ b/refs.h
@@ -736,6 +736,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
+			   const char *old_target,
 			   unsigned int flags,
 			   struct strbuf *err);
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index bbee2783ab..52801be07d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -892,17 +892,23 @@ test_expect_success 'stdin update/create/verify combination works' '
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
@@ -1643,4 +1649,88 @@ test_expect_success PIPE 'transaction flushes status updates' '
 	test_cmp expected actual
 '
 
+format_command () {
+	if test "$1" = "-z"
+	then
+		shift
+		printf "$F" "$@"
+	else
+		echo "$@"
+	fi
+}
+
+for type in "" "-z"
+do
+
+	test_expect_success "stdin $type symref-verify fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		format_command $type "symref-verify refs/heads/symref" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type <stdin 2>err &&
+		grep "fatal: symref-verify: cannot operate with deref mode" err
+	'
+
+	test_expect_success "stdin $type symref-verify fails with too many arguments" '
+		format_command $type "symref-verify refs/heads/symref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err  &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin $type symref-verify succeeds for correct value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		format_command $type "symref-verify refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin $type symref-verify fails with no value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		format_command $type "symref-verify refs/heads/symref" "" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin
+	'
+
+	test_expect_success "stdin $type symref-verify succeeds for dangling reference" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
+		test_must_fail git symbolic-ref refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
+		format_command $type "symref-verify refs/heads/symref2" "refs/heads/nonexistent" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin
+	'
+
+	test_expect_success "stdin $type symref-verify fails for missing reference" '
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		format_command $type "symref-verify refs/heads/missing" "refs/heads/unknown" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: cannot lock ref ${SQ}refs/heads/missing${SQ}: unable to resolve reference ${SQ}refs/heads/missing${SQ}" err &&
+		test_must_fail git rev-parse --verify -q refs/heads/missing &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin $type symref-verify fails for wrong value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		format_command $type "symref-verify refs/heads/symref" "$b" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-verify fails for mistaken null value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		format_command $type "symref-verify refs/heads/symref" "$Z" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
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

