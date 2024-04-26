Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0C14D2B8
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145103; cv=none; b=I/yEeSpX1Hg2Y/yVYZZQYbYlV9n/zGhZH7oECW+yhWcTXNlVD2OyrxQMODqkARaJVbPPRag3eJnKvIXq2v8SD7r727/s+2khOZ9Tk/XFUWN7Zas9gFTP829g8oSbJlKYtUazN/k0Maij2flnLQw9qqkkKfVL6F2wZtRkPLtUIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145103; c=relaxed/simple;
	bh=iNIkoEmQvkUJK84bg5g1ZOTuo7h5AvSc+mkvfedZIic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw6jtLnQuIXaNRkTIscyBLl2afAqshZcKH9he/6JT/CPFqk7G20aMbbP6s8e1Yw3e3Hl+sC2wsG5UccGXxKlDQgJygRkCGbrYlsvtA8fKF+weIEK+yUBWMjNHAQWrhmoYZ7tO+eTvEfPlDvQGwRRrUjY4yVGUub9Ajw+txfG1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GutGBdde; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GutGBdde"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so2823747a12.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145099; x=1714749899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xCXqbm+FBh5J/qpYAF+6Pe+dBymrlULxx9Vzq6hlVU=;
        b=GutGBdde7vQbOSccBnqpu/iXgdAi+6avx8zEPCLeRx5PdBtvuK/NeAxqUqNy1Cz7ML
         XaBrp4GfEYiBcTRKnXtgH1d/l+R6PFqRHH/j3duVDlvWjfM30+Kr74IXBaRhmkSlzAHY
         5c6qJbDsuNwTV54L1fA1ZCEAYPEt0d+ndnjaV7Dp+PSe7qECalGYcu4nJBFxG6TRJ/z8
         1lFR755EZ1h8V/s1HUUwd+RASBO3el2oewgTjSoG5L+EKiuOncEyHm9vl6GNX8W8+wSg
         z3zq+P0QLtDRqOZSZqxRPEESxdGYWK0A3trkQUFya2H5UixsNY3udBoMxA0zNKSyINnG
         2tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145099; x=1714749899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xCXqbm+FBh5J/qpYAF+6Pe+dBymrlULxx9Vzq6hlVU=;
        b=klCrGWcHmRLxna08X8kRgHNvdOcMBfR7kgKIFL4+EFvs2+ojMFLfSYxqR4FXxFpFzv
         tau/NPsZEXiMpAcMiKcH/uPJBdgutZyBmoyoV8cWHfjQLzjKkMfIo/vBOamp5DXGnOZ2
         +iL4ajSzVI5YTIcoxu4kXWHgJy/0AhWvbTHWretdr8Zv9ru92CcMyS8JeYLtZ0wn2e58
         fwPcRpvywXVEqcYJtdT7o1krdqFslSKb5Ah5o2wUtkdp5+EiaV0OVtIskN+1UXRQxda3
         1BrtgEQQW+i3uewhqR9dMTaKuUSpTeg+PKqUet3z1LJEh1XVmfnCVY5nYpWAbIMsP+9M
         oAZw==
X-Forwarded-Encrypted: i=1; AJvYcCX4VkT0gJm0oVjdMeMtUXo50KrW2WXQD4kLhPcXgOcj5fbdenTteEGBnbU29CrnOuxpU4iMSQeMPzEgcbXjINl86cKO
X-Gm-Message-State: AOJu0YyX2RcYqih1yqKOkeTlejkm+8BvgH1Ky+ghRb7fe/wKqERqI+WE
	emXs6iLF52tZ32l6DCkOTRRd7coEumiE1HQHv5hDGSL+yS4bOu4S
X-Google-Smtp-Source: AGHT+IGt2T9GwQnYPzQgK4OZ7OQBGgN4+K4QL4xp4rhZh4OYCcjp0RBAseV0gjKXbZ8t7ZbpLSP1uw==
X-Received: by 2002:a17:906:1c48:b0:a58:9297:91a1 with SMTP id l8-20020a1709061c4800b00a58929791a1mr2225939ejg.53.1714145099252;
        Fri, 26 Apr 2024 08:24:59 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 6/7] update-ref: add support for 'symref-update' command
Date: Fri, 26 Apr 2024 17:24:48 +0200
Message-ID: <20240426152449.228860-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426152449.228860-1-knayak@gitlab.com>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
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

This command will also support deref mode, to ensure that we can update
dereferenced regular refs to symrefs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |   6 +
 builtin/update-ref.c             |  91 +++++++++++++-
 refs/files-backend.c             |  14 +--
 refs/reftable-backend.c          |   3 +-
 t/t1400-update-ref.sh            | 196 +++++++++++++++++++++++++++++++
 5 files changed, 299 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 7a33f70767..0cd4c37820 100644
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
@@ -123,6 +125,10 @@ delete::
 	is provided, verify that the symbolic ref <ref> targets
 	<old-target> before deleting it.
 
+symref-update::
+	Set <ref> to <new-target> after verifying <old-target> or <old-oid>,
+	if given.  Can be used to delete or create symrefs too.
+
 verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index ae68ffde5e..5001d80ae4 100644
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
@@ -225,8 +260,8 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname,
-				   &new_oid, have_old ? &old_oid : NULL,
+	if (ref_transaction_update(transaction, refname, &new_oid,
+				   have_old ? &old_oid : NULL,
 				   NULL, NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
@@ -237,6 +272,57 @@ static void parse_cmd_update(struct ref_transaction *transaction,
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
+
+	if (*next != line_termination)
+		die("symref-update %s: extra input: %s", refname, next);
+
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
@@ -505,6 +591,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-update", parse_cmd_symref_update, 4, UPDATE_REFS_OPEN },
 	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f5e271a442..59d1ab3eeb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2386,7 +2386,8 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			update->new_target, update->old_target,
+			update->msg);
 
 	new_update->parent_update = update;
 
@@ -2610,7 +2611,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
-	if (update->new_target) {
+	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
 		if (create_symref_lock(refs, lock, update->refname, update->new_target)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
@@ -2628,12 +2629,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		 * phase of the transaction only needs to commit the lock.
 		 */
 		update->flags |= REF_NEEDS_COMMIT;
-	}
-
-
-	if ((update->flags & REF_HAVE_NEW) &&
-	    !(update->flags & REF_DELETING) &&
-	    !(update->flags & REF_LOG_ONLY)) {
+	} else if ((update->flags & REF_HAVE_NEW) &&
+		   !(update->flags & REF_DELETING) &&
+		   !(update->flags & REF_LOG_ONLY)) {
 		if (!(update->type & REF_ISSYMREF) &&
 		    oideq(&lock->old_oid, &update->new_oid)) {
 			/*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e203c697f2..a00f55802a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -908,7 +908,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
+						&u->new_oid, &u->old_oid, u->new_target,
+						u->old_target, u->msg);
 				new_update->parent_update = u;
 
 				/*
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 452fc1da50..3cfef9fbe3 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1360,6 +1360,7 @@ test_expect_success 'fails with duplicate HEAD update' '
 '
 
 test_expect_success 'fails with duplicate ref update via symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
 	git branch target2 $A &&
 	git symbolic-ref refs/heads/symref2 refs/heads/target2 &&
 	cat >stdin <<-EOF &&
@@ -1852,6 +1853,201 @@ do
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
+		if test_have_prereq REFTABLE
+		then
+			grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err
+		else
+			grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err
+		fi &&
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
-- 
2.43.GIT

