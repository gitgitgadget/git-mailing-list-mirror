Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3219AD45
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767196; cv=none; b=Y97yLwy+2MCEJ0sCZs0ELFjdmWIwfoj+rD6ngWQY1NJcksqe8/Ki3nLa3J45Qp0Xh2uApkrwXbHmEoNWAC3uY4tVdz0HIsDZcPKt65n29qjwjRAJfA/f9Zdx0zffOinLMi34WE9OZQr546Bj/1+xD5Ku9679a0Kyx4d5+8+1iBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767196; c=relaxed/simple;
	bh=tccQa9apapwPadVEimKtQhpBVPCWKWR/m8xEkXqMkyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3/Crv3+ZOfaIjMf7SZg+uj7OOriUdN7cZo3+ZXGUCU05ojin/Fn6pOh9Q719e6WlYXlQ3ATD5uaAsbdzfAh5LMgd1AbzY/tBb2sC0u9w99vdjlEGFBm/yuUWMjpnTkBjGEMa8GqOxuahfI4ejCG7pb4HM7SIv8jzxzd6YgXXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvMoeTFn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvMoeTFn"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso2528273a12.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767192; x=1718371992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFcj+mdknZOgGisB0w6Lt0rRxZc3ODf2cQ1u0SvmRjM=;
        b=fvMoeTFnv4gFEolVQcmDJiTnCM4VnEs7MLl1f6GP08HqTecDNE4ewxtWaGnK6frHDK
         tILzDVIfdOYHWjFuv8AioxgorLUN7ssooEOmB+VXNNqRk57cw3X7GFvR3iY0up14xARi
         +VMGUKY29rPk5Edq50dfbAYQH4cZOc34K0U//9L7Hn6vrYnlbHCKi772jr5V7zHCTu8T
         v/YRCukrMn84zEYtxkf0nSL8mNJ81EuvzIEM1dzVH7X7BiJR7ckvIgN5qbfo0pC0jpsM
         B9ILwhiCgU/z+hlc41mRovUy69p5/SLTmJmHKykMhzZO3vMgcTZ81ZFVVnNaRPajRJps
         KWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767192; x=1718371992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFcj+mdknZOgGisB0w6Lt0rRxZc3ODf2cQ1u0SvmRjM=;
        b=irv/BBAGbfSa4jJES1mwW+64ZF0hlcSb4M275GcwwVdAE8GYZS+1KnEC7AiPajYtD2
         1XFx2csZ6FRDILHNhNoc44n6oF3aWOPvAhv1IEVxzKokbDLHjtALcgj9lOjQd+FWfx0n
         NHRIGTGSyZ2uW2jxyRZyxFq/xdadxqngNW94W3VDrBL6Tjj34PUmkxKIJn34nBnBUAaP
         YMBwWqmXget2psfKt25sZU1Cfp6ekDyGqNTqVT3e7vMm3S6JPmaRqWhbKlEvD1v6+ah0
         KjZhlHbvVGY4oMwbO2O3YMpbw+gH2yNrWaPKQXzNgq780EOpyJKJm5quNkSZO2zoz06g
         s8tA==
X-Gm-Message-State: AOJu0YwI7UlH0JDg4J/tuN/s/95vmOumdU/tFxFbCR1/L0AzW5mSKyYx
	qffBjsDH0BXatY9pXMRfTI9bN3vIzZ9v5K0d/4dEJ0666aIZr5x2
X-Google-Smtp-Source: AGHT+IEJI++86zx4Kp/8R0fdLyXl56Aq+qqPHGwH3JyObXLaWEdiXADTZfOEB1BLs3Sgmhu6S0jOAw==
X-Received: by 2002:a50:8a82:0:b0:578:d846:fc0a with SMTP id 4fb4d7f45d1cf-57c4e412760mr2106232a12.20.1717767191869;
        Fri, 07 Jun 2024 06:33:11 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 5/7] update-ref: add support for 'symref-create' command
Date: Fri,  7 Jun 2024 15:33:02 +0200
Message-ID: <20240607133304.2333280-6-knayak@gitlab.com>
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

Add 'symref-create' command to the '--stdin' mode 'git-update-ref' to
allow creation of symbolic refs in a transaction. The 'symref-create'
command takes in a <new-target>, which the created <ref> will point to.

Also, support the 'core.prefersymlinkrefs' config, wherein if the config
is set and the filesystem supports symlinks, we create the symbolic ref
as a symlink. We fallback to creating a regular symref if creating the
symlink is unsuccessful.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  6 +++
 builtin/clone.c                  |  2 +-
 builtin/update-ref.c             | 32 +++++++++++++++-
 refs.c                           |  9 +++--
 refs.h                           |  1 +
 t/t0600-reffiles-backend.sh      | 32 ++++++++++++++++
 t/t1400-update-ref.sh            | 65 ++++++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh |  3 ++
 t/t5605-clone-local.sh           |  2 +-
 9 files changed, 146 insertions(+), 6 deletions(-)

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
index 23993b905b..6ddb3084e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -576,7 +576,7 @@ static void write_remote_refs(const struct ref *local_refs)
 		if (!r->peer_ref)
 			continue;
 		if (ref_transaction_create(t, r->peer_ref->name, &r->old_oid,
-					   0, NULL, &err))
+					   NULL, 0, NULL, &err))
 			die("%s", err.buf);
 	}
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0cb7eef3c6..9c40e94626 100644
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
index 01f3188a09..8807e87e3c 100644
--- a/refs.c
+++ b/refs.c
@@ -1268,15 +1268,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (!new_oid || is_null_oid(new_oid)) {
-		strbuf_addf(err, "'%s' has a null OID", refname);
+	if (new_oid && new_target)
+		BUG("create called with both new_oid and new_target set");
+	if ((!new_oid || is_null_oid(new_oid)) && !new_target) {
+		strbuf_addf(err, "'%s' has neither a valid OID nor a target", refname);
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), NULL, NULL, flags,
+				      null_oid(), new_target, NULL, flags,
 				      msg, err);
 }
 
diff --git a/refs.h b/refs.h
index 974cf4dd08..28e3bb8a42 100644
--- a/refs.h
+++ b/refs.h
@@ -708,6 +708,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 92f570313d..b2a771ff2b 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -468,4 +468,36 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
+test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs true &&
+	cat >stdin <<-EOF &&
+	start
+	symref-create TEST_SYMREF_HEAD refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_symlink .git/TEST_SYMREF_HEAD &&
+	test "$(test_readlink .git/TEST_SYMREF_HEAD)" = refs/heads/new
+'
+
+test_expect_success 'symref transaction supports false symlink config' '
+	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs false &&
+	cat >stdin <<-EOF &&
+	start
+	symref-create TEST_SYMREF_HEAD refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_file .git/TEST_SYMREF_HEAD &&
+	git symbolic-ref TEST_SYMREF_HEAD >actual &&
+	echo refs/heads/new >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 9dbe28bd13..253263320d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1799,6 +1799,71 @@ do
 		git update-ref --stdin $type --no-deref <stdin
 	'
 
+	test_expect_success "stdin $type symref-create fails with too many arguments" '
+		format_command $type "symref-create refs/heads/symref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin $type symref-create fails with no target" '
+		format_command $type "symref-create refs/heads/symref" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin
+	'
+
+	test_expect_success "stdin $type symref-create fails with empty target" '
+		format_command $type "symref-create refs/heads/symref" "" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin
+	'
+
+	test_expect_success "stdin $type symref-create works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		format_command $type "symref-create refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-create works with --no-deref" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		format_command $type "symref-create refs/heads/symref" "$a" &&
+		git update-ref --stdin $type <stdin 2>err
+	'
+
+	test_expect_success "stdin $type create dangling symref ref works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		format_command $type "symref-create refs/heads/symref" "refs/heads/unkown" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo refs/heads/unkown >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-create does not create reflogs by default" '
+		test_when_finished "git symbolic-ref -d refs/symref" &&
+		format_command $type "symref-create refs/symref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		git symbolic-ref refs/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual &&
+		test_must_fail git reflog exists refs/symref
+	'
+
+	test_expect_success "stdin $type symref-create reflogs with --create-reflog" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		format_command $type "symref-create refs/heads/symref" "$a" >stdin &&
+		git update-ref --create-reflog --stdin $type --no-deref <stdin &&
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
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index a3055869bc..339d8c786f 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -163,7 +163,7 @@ test_expect_success REFFILES 'local clone from repo with corrupt refs fails grac
 	echo a >corrupt/.git/refs/heads/topic &&
 
 	test_must_fail git clone corrupt working 2>err &&
-	grep "has a null OID" err
+	grep "has neither a valid OID nor a target" err
 '
 
 test_done
-- 
2.43.GIT

