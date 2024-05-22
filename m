Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21280BFE
	for <git@vger.kernel.org>; Wed, 22 May 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368617; cv=none; b=Z0zvsB9P6cF0TlfCiNgu4tQIFtIhasXYtQ9RNB65kxv8D3mIlioc1/gHQEXQMe1YLmGZ/FeFe0K4OxJH2XDASUcY3xKg47JnrgaHyivqetAG2muuv0pyryAUGZzkg3k9gY9RgXDedCBMdsM+hjhL6wjjvRKkwGSQTNKNNEh1lAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368617; c=relaxed/simple;
	bh=Br9HqqB6n8DrUFVagCs9rVJA5vs3IXgdk/3gEySm/Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ+8eGI11IZIvPuQiDd/KGHZi4bmwC1COrBlNxuVYknoKK4c+lWobp+ltyNNxUerGwSqr89Z1XZjZg9PrLOpVmj7DZP6zhcYH7wIchm30OSFlKhIJuKZ8qNnx3wYw/0KrR8fxNOorHYn3mVM0yLUq1CgmSBSBa3rMeZz0sIXLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms2EKgQ4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms2EKgQ4"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so10530921a12.3
        for <git@vger.kernel.org>; Wed, 22 May 2024 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368614; x=1716973414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahlZJWUfmbLcZZKQnxiAgNBy5cxwIMvOmpKms7NkTiA=;
        b=ms2EKgQ4rQ1TKFwpSuXcAG7600f4ScB0qPvTwT/ui4vVGJV2jTDX1ED+gY3hXLbx2I
         7QP0ixO4lrw/mmL1xyrVuuzFOXWU8P4dreq5qJrqG6NzmpQ/wVLFTJjLiWKT2N1otnJR
         l1oDmqw8JMfW5aZljkjpEiLaPiR9ImJKTS4ikW3vJ7cnKzf09G55WmNYUzAJwToWpQTY
         yH/IJ/HyPJXN4/29IUOG6BzemrsceITcv2Kd4tgvb4BUFw2XcynyEj7rv+JlOmUC6Y7u
         lQ7q7A2kwtwX6yi7yZV7OqICXH1JQ1h471Qy6Jp4xm55MzrnCivHGmcJj5tyRt+qMa38
         nieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368614; x=1716973414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahlZJWUfmbLcZZKQnxiAgNBy5cxwIMvOmpKms7NkTiA=;
        b=EjCPXWEoVO1FHibNUe2RC+6aawLGWMRerLdeNIcV0+e4SKx+4HdN9dG50UZBrlPnSE
         evJRvG+dYSgfnT0+oCFit5ZGHfx9IG4EK3lBjezuLq+pPSYxLa9c49kW6SoOGjXOCPx7
         LEn+I+B7LHOcIG47ShrEK3Ak/S+2bC3H9ZrUFIjb7ivoO0hjVJmK2tDu0vTAIojGP7He
         T4EDDXBuwQzkBVipXRPOaYbH/x9LtqKN6FLgt+4JyRfEtyCBXzdvrj1A3lx1jud3oy2/
         LXMQtDbk6SMQs7shsRgi//Gh/Od010UvdajXr4+5SZ3PuLsIEbyR3v0UrpdlAmUtlMjs
         wP8Q==
X-Gm-Message-State: AOJu0Yzkp6FjwTtOMpyk/M7vJSFBWlLJVJDO6CyVN6nRCUaQDQ46MU4i
	eYdhS4kXpuOr3VrdBnN51yj+UF7iQyjD3n/m1M3N+PBV03981q4FlP1SZ1Ff
X-Google-Smtp-Source: AGHT+IGfIu6FoZjxFoeQr0Ea88NWCYz5J3z9bKPDnNw+d39iKnh3LEExjKqhFBhj2p2CsJLnRhtoIQ==
X-Received: by 2002:a50:bb03:0:b0:578:258c:1091 with SMTP id 4fb4d7f45d1cf-578329fe356mr787494a12.4.1716368613994;
        Wed, 22 May 2024 02:03:33 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:414d:df4b:1d67:e754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm8281354a12.61.2024.05.22.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:03:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 4/6] update-ref: add support for 'symref-create' command
Date: Wed, 22 May 2024 11:03:24 +0200
Message-ID: <20240522090326.1268326-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522090326.1268326-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240522090326.1268326-1-knayak@gitlab.com>
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
index 3afebfcb63..7172f31bf2 100644
--- a/refs.c
+++ b/refs.c
@@ -1302,15 +1302,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
index a390cffc80..7cfb5e8c6c 100755
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
index 22d560f0bf..78001f879a 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1783,6 +1783,71 @@ do
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

