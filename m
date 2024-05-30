Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374B183A76
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070997; cv=none; b=WBw5U27usJoIqdqfSCNQxxaUSppgIoTFbv8HsMfc8DwxwC6mFJf9az0agRwrtMSJRX4iE+IqD8pOP/kAky+ikpzAOViF2lPAjBNA7csSE5P6I8XRRczJqy63HC5x4sdIQz3tpmt313rVTvDMGtzdl3SxUHIoKJXZLnauUJHyB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070997; c=relaxed/simple;
	bh=tiRuPtvercZ0wZKawjnBDx6NJkn30RHmBchWppcY4bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPaR4wETDif0wsj1bFp/U8S3/NkbK3vfTIyuLWvzRngN+OhBSuF+aAiUAtWLlLojFg8in0ckvoNC2w6LeVDSWdgK8Dr7tVaYbVVQk0N1mLPj20k6LOLdPmwK6nfeLnwBGQfFJpgyVgrhKm3ICq1S9BpryFq0gY7DV/UmO1sIPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUNwQ20g; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUNwQ20g"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so75542966b.2
        for <git@vger.kernel.org>; Thu, 30 May 2024 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070994; x=1717675794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMRISS7mUGkw4slVTRAQy5TTwVBVebdhoajcmAY0VMw=;
        b=TUNwQ20g3DB24Elg0ibiGl7ZZoLkUuNRGFnUKBY1/eAt4Og4bRqfYy7cR8kDp93Isc
         uNW4v0oF1awpIP1x4qH+wA7C8j7UOnjO7N+2FKvmYFOF+NtuwxTGyCCXn+ntl563k38X
         fpscZg7zOkQ3rl8KsGq0d1TRZY6Ygt9UICQ4tLOZvHlk/te4ox4iilEhocxMwvwqZpYt
         3m02D3x/df3hsHs9vttCqUMJ+L3tl0zc+E5eJFVfKwpyQi/g0ugvx97/+uYEBNeVwRSx
         mQCwDpu+kAq4ej2Qex5UyrmbGNHDrZbMF+lnL19vKtHVMWSbJyR1bUZK9mhlTsu9+RBR
         Ui4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070994; x=1717675794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMRISS7mUGkw4slVTRAQy5TTwVBVebdhoajcmAY0VMw=;
        b=oA39EZQlAPCAK9WZBKiLc/hZHRyXaRo0Heq08EDyO0AfKkd+WBWrdLLBQBrIHXiWmh
         w2H9xHAfCftMMKjliGcaRnjfz1CzsJQ5squgMS9yDUE9wKFSXAVHV1Tdoh9joXzfjV8q
         CFElfUkdutZVTRS7Dts9Vet1k4/LAtQL19ndSbJnLEDG1y+vPF4MsoIy1PJ3/HMdA6vS
         F2UXjdcIHtvHDCWvmhTkML+L43K90E5QhygqCw1VqLOjWUE+PnaxduuaKWz6yDOLiD2S
         2DRyZAu34zJztkldum1rHjv5kdV/mAplgK9FrgYfXdsAbYv2ZhE1B8MFRZlClsj3eMN2
         6hqA==
X-Gm-Message-State: AOJu0Yxz+xBN6JZBL3FY89EoJChNk5xH2piAmtfzifKq2itg8Y82phfx
	fZh5SK7UwTeYvGZL3CDdqkxGrm6fWNVisDbyhHuwg8BXotO0Cfxe
X-Google-Smtp-Source: AGHT+IGWjS52u2lYnkyVvOCFm6TQyo883cJWFdmIYrajupwZOrW5NzoUpbBnUqOJ7Y5LspeKAJZ/CA==
X-Received: by 2002:a17:906:ccce:b0:a59:9c58:763a with SMTP id a640c23a62f3a-a65e8f6f3acmr133142666b.46.1717070993544;
        Thu, 30 May 2024 05:09:53 -0700 (PDT)
Received: from laptop.modem.local ([85.100.180.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e105sm831393866b.172.2024.05.30.05.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:09:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 4/6] update-ref: add support for 'symref-create' command
Date: Thu, 30 May 2024 15:09:38 +0300
Message-ID: <20240530120940.456817-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
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
index a78c2f9c85..5ebfecf617 100644
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
index e29abebe1d..e2b8d9a6c8 100644
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
index a054a4f998..1a58764298 100644
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
index 848d6fc42e..3d5f00ffb8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1785,6 +1785,71 @@ do
 		test_must_fail git symbolic-ref -d refs/heads/symref2
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

