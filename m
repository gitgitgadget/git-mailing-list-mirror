Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5C76041
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690664; cv=none; b=tNu+DrD0A7LdWiDf2sPFrXTbKqgIn0DDMRnbzenbJYy2zHSRp34fWj2YjfumE5fPNKjHgRWLJJmHjeOLB7VmXJDzZKUhu8pEkqZiZPKwucBcfGGAggjHRnkgd71iID5t142z3IzYcopcxVdVv849b2DGa4aFxHliWR296fgTMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690664; c=relaxed/simple;
	bh=8paGH59SR3pCWQUOksh/Oz9bTxDwal3QVWz3QZav0X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFaSurWfZ+7wGkSQOTSZyUhiyO9eQnxZkatvXSInVD19SPPP/VIobB71v4kvLUz5nDlCX93bJUxu1yu/p1Gs30d6K73O7Xk1V0/drXiQw58/CPGAJTJlPJWsKTgdA+1OtPvJJAXyciNTmT/d8x4NytXdsl78iNTmJzWjMlUR6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdG2thlO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdG2thlO"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso1189063a12.1
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690661; x=1716295461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+0laZt++158xV0IHh0Gek/IRXzorOm2aqdCHNE8jQQ=;
        b=cdG2thlOMGuIBUYQk1ITH0QlyilqLQQBPFObuhZsIq5yw6TRgn/QiPA/B88t++q9hj
         mtONG4A3JvDnhwgmbk3XfBBMkKIJBzXV8F+hZlbuY4LMOElVs9yDvKYSU/rRUrEbulJF
         928wKKZHBXmyfzrVi5+Xkb/txMmWTE0hIbaySEqOYtZm/lc/jUwVRgPWBTSYX9bqyqpH
         KATVPqfoGL88gFkN1OPsmKAiQuo2HApjhI3lqj2Bd8rkDZUOXNYcV8ePW+33cW/DfnBB
         rYD09zEIFmmejrVMkM9rVAquuodvx4Ir2gV8D3N7J7amWuD5ON1mDE9jBNOT0IqEkbdp
         vfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690661; x=1716295461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+0laZt++158xV0IHh0Gek/IRXzorOm2aqdCHNE8jQQ=;
        b=VpfoWKKgNoipG0yvETr6xyK6A0aqzGLA8Wx5jbXIjfT3SUaIpLKcqoMf/XZ/MD+cp4
         SDxeUe+RNgdQNjeLh5A2NOAtnXDQQr020L8VxZgmV5Qbc4dybrB/R/os+wFseGAvwiQp
         7dHA1Fqs8xCj2oHoJdtdt08Zm0OlQij7LskYrBIUiCSqv0fkig4sWvfviIvKwH2+0FVS
         phgQCrnPrYZKapmkxkRxKqbWtlSHYlu2/T6T5gR2rHK/fSKMVlUDG5ooECGIgBmZzbz5
         BEf2VVXBNeTzMYL8D15vmHey97/VS61xvj/ccRkZ/t/VBPTUfMC8WPAeBJYj5rAv4Y6N
         QMZQ==
X-Gm-Message-State: AOJu0YwKRft0CDVVMSx3gtSnZLWI3AXJFfhUMlg4JlsIym722AcY2kMA
	ITGBtPB7iWFBtuuhiCowIdqCGiLX4LE57rG75qDgK3HcTo6irG9D
X-Google-Smtp-Source: AGHT+IHvVRMaAgfCt6MsAoiXA4RAz9u38VkRv9kIMtG7LPjY+2c0dSKm2qGKqsKyFm1hirwtkxpiWw==
X-Received: by 2002:a17:906:4bc6:b0:a55:aded:200d with SMTP id a640c23a62f3a-a5a2d1af6acmr1012739566b.12.1715690660998;
        Tue, 14 May 2024 05:44:20 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b019edsm730530566b.174.2024.05.14.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:44:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH 6/6] update-ref: add support for 'symref-update' command
Date: Tue, 14 May 2024 14:44:11 +0200
Message-ID: <20240514124411.1037019-7-knayak@gitlab.com>
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

Add 'symref-update' command to the '--stdin' mode of 'git-update-ref' to
allow updates of symbolic refs. The 'symref-update' command takes in a
<new-target>, which the <ref> will be updated to. If the <ref> doesn't
exist it will be created.

It also optionally takes either an `ref <old-target>` or `oid
<old-oid>`. If the <old-target> is provided, it checks to see if the
<ref> targets the <old-target> before the update. If <old-oid> is provided
it checks <ref> to ensure that it is a regular ref and <old-oid> is the
OID before the update. This by extension also means that this when a
zero <old-oid> is provided, it ensures that the ref didn't exist before.

The command allows users to perform symbolic ref updates within a
transaction. This provides atomicity and allows users to perform a set
of operations together.

This command will also support deref mode, to ensure that we can update
dereferenced regular refs to symrefs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |   7 ++
 builtin/update-ref.c             |  85 ++++++++++++++
 t/t1400-update-ref.sh            | 191 +++++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh |   4 +
 4 files changed, 287 insertions(+)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 364ef78af1..afcf33cf60 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-update SP <ref> SP <new-target> [SP (ref SP <old-target> | oid SP <old-oid>)] LF
 	symref-create SP <ref> SP <new-target> LF
 	symref-delete SP <ref> [SP <old-target>] LF
 	symref-verify SP <ref> [SP <old-target>] LF
@@ -89,6 +90,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-update SP <ref> NUL <new-target> [NUL (ref NUL <old-target> | oid NUL <old-oid>)] NUL
 	symref-create SP <ref> NUL <new-target> NUL
 	symref-delete SP <ref> [NUL <old-target>] NUL
 	symref-verify SP <ref> [NUL <old-target>] NUL
@@ -119,6 +121,11 @@ delete::
 	Delete <ref> after verifying it exists with <old-oid>, if
 	given.  If given, <old-oid> may not be zero.
 
+symref-update::
+	Set <ref> to <new-target> after verifying <old-target> or <old-oid>,
+	if given. Specify a zero <old-oid> to ensure that the ref does not
+	exist before the update.
+
 verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 16d184603b..389136dc2f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -98,6 +98,41 @@ static char *parse_next_refname(const char **next)
 	return parse_refname(next);
 }
 
+/*
+ * Wrapper around parse_arg which skips the next delimiter.
+ */
+static char *parse_next_arg(const char **next)
+{
+	struct strbuf arg = STRBUF_INIT;
+
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
+	if (line_termination) {
+		/* Without -z, use the next argument */
+		*next = parse_arg(*next, &arg);
+	} else {
+		/* With -z, use everything up to the next NUL */
+		strbuf_addstr(&arg, *next);
+		*next += arg.len;
+	}
+
+	if (arg.len)
+		return strbuf_detach(&arg, NULL);
+	return NULL;
+}
+
 
 /*
  * The value being parsed is <old-oid> (as opposed to <new-oid>; the
@@ -237,6 +272,55 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+static void parse_cmd_symref_update(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	char *refname, *new_target, *old_arg;
+	char *old_target = NULL;
+	struct strbuf err = STRBUF_INIT;
+	struct object_id old_oid;
+	int have_old = 0;
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-update: missing <ref>");
+
+	new_target = parse_next_refname(&next);
+	if (!new_target)
+		die("symref-update %s: missing <new-target>", refname);
+
+	old_arg = parse_next_arg(&next);
+	if (old_arg) {
+		old_target = parse_next_refname(&next);
+		if (!old_target)
+			die("symref-update %s: expected old value", refname);
+
+		if (!strcmp(old_arg, "oid") &&
+		    !repo_get_oid(the_repository, old_target, &old_oid)) {
+			old_target = NULL;
+			have_old = 1;
+		} else if (strcmp(old_arg, "ref"))
+			die("symref-update %s: invalid arg '%s' for old value", refname, old_arg);
+	}
+
+	if (*next != line_termination)
+		die("symref-update %s: extra input: %s", refname, next);
+
+	if (ref_transaction_update(transaction, refname, NULL,
+				   have_old ? &old_oid : NULL,
+				   new_target, old_target,
+				   update_flags |= create_reflog_flag,
+				   msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(old_arg);
+	free(old_target);
+	free(new_target);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_create(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -502,6 +586,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-update", parse_cmd_symref_update, 4, UPDATE_REFS_OPEN },
 	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7955988ecc..f7d00cc024 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1360,6 +1360,7 @@ test_expect_success 'fails with duplicate HEAD update' '
 '
 
 test_expect_success 'fails with duplicate ref update via symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
 	git branch target2 $A &&
 	git symbolic-ref refs/heads/symref2 refs/heads/target2 &&
 	cat >stdin <<-EOF &&
@@ -1848,6 +1849,196 @@ do
 		git reflog exists refs/heads/symref
 	'
 
+	test_expect_success "stdin ${type} symref-update fails with too many arguments" '
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "ref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-update refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} symref-update fails with wrong old value argument" '
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "foo" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		grep "fatal: symref-update refs/heads/symref: invalid arg ${SQ}foo${SQ} for old value" err
+	'
+
+	test_expect_success "stdin ${type} symref-update creates with zero old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update creates with no old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update creates dangling" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "refs/heads/nonexistent" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo refs/heads/nonexistent >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update fails with wrong old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "ref" "$b" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err &&
+		test_must_fail git rev-parse --verify -q $c
+	'
+
+	test_expect_success "stdin ${type} symref-update updates dangling ref" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update updates dangling ref with old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "ref" "refs/heads/nonexistent" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update fails update dangling ref with wrong old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "ref" "refs/heads/wrongref" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+		echo refs/heads/nonexistent >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update works with right old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "ref" "$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $m >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update works with no old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $m >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update fails with empty old ref-target" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "ref" "" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update creates (with deref)" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin ${type} <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+		grep "$Z $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin ${type} symref-update regular ref to symref with correct old-oid" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse $a)" >stdin &&
+		git update-ref --stdin ${type} <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin ${type} symref-update regular ref to symref fails with wrong old-oid" '
+		test_when_finished "git update-ref -d refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse refs/heads/target2)" >stdin &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		echo $(git rev-parse $a) >expect &&
+		git rev-parse refs/heads/regularref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update existing symref with zero old-oid" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref refs/heads/target2 &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: reference already exists" err &&
+		echo refs/heads/target2 >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-update regular ref to symref (with deref)" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_when_finished "git update-ref -d --no-deref refs/heads/symref2" &&
+		git update-ref refs/heads/symref2 $a &&
+		git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref ${type} --stdin <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/symref2 >actual &&
+		test_cmp expect actual &&
+		echo refs/heads/symref2 >expect &&
+		git symbolic-ref --no-recurse refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin ${type} symref-update regular ref to symref" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" >stdin &&
+		git update-ref ${type} --stdin <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+	'
+
 done
 
 test_done
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index ff77dcca6b..5a812ca3c0 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -163,6 +163,7 @@ test_expect_success 'hook gets all queued symref updates' '
 	git update-ref refs/heads/branch $POST_OID &&
 	git symbolic-ref refs/heads/symref refs/heads/main &&
 	git symbolic-ref refs/heads/symrefd refs/heads/main &&
+	git symbolic-ref refs/heads/symrefu refs/heads/main &&
 
 	test_hook reference-transaction <<-\EOF &&
 	echo "$*" >>actual
@@ -190,10 +191,12 @@ test_expect_success 'hook gets all queued symref updates' '
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
 	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+	ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
 	committed
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
 	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+	ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
 	EOF
 
 	git update-ref --no-deref --stdin <<-EOF &&
@@ -201,6 +204,7 @@ test_expect_success 'hook gets all queued symref updates' '
 	symref-verify refs/heads/symref refs/heads/main
 	symref-delete refs/heads/symrefd refs/heads/main
 	symref-create refs/heads/symrefc refs/heads/main
+	symref-update refs/heads/symrefu refs/heads/branch ref refs/heads/main
 	prepare
 	commit
 	EOF
-- 
2.43.GIT

