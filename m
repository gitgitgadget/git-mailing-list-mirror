Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293EA19AA7B
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767195; cv=none; b=i5aENjVbDagudjnZhtnzmfcvLEFfeDavypv2OWIVnLojnOmtm7oT8LRRHtuO+kOUtMDjjFJNWF12+EmOj/gTcTszpoLh70XpSDi/RHvPXdnymqvtqnYDrZF3tihL91MPAkqG+3JcKvXutM+i2Rx3LRwIIo3iJLxRlGQXbBtcXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767195; c=relaxed/simple;
	bh=O2+/Q+Pfe5DyK11g9zZwE8t13U2HhLgOEVhqVIWKfbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHV6zAgXtvMvwk9/XzZWoV/SunAnaP+ztX9gE/WA7VEPmMXuytY2qLmn2sXxz2/J62rA1DlKbDwpmT1gACiimMf3MDW2l9rpe6JBhNRGwl1vPu5hU046XRqCRT2aDx8kA+iUfc/tKh1/nfr5+IeTsBgtite0RymqoUWsw5765/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRRJWQSs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRRJWQSs"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eabd22d404so22433491fa.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767191; x=1718371991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI8zy/rRUgerxKZmHDTJz4Abr5iixEv9BJDLAsh9Fec=;
        b=XRRJWQSsLBoPUCxTXw6KcAIl5GHl78zAGVPhA2qjHqDfo4J1ZLu8p9Apy1V5loOCjt
         82oNVUEC4FhUv34cE+Plo19x+Qavf5EsqPh8Y0xFDPgS8+EpivMEJw+Y1B1J68OGLRmw
         qr+lVLkW6CJlmQYMUHpBuofaIhzI93ELmQYGhI4h6e4aNJaEZUqM5md+7MBKsmDOi1HR
         +LKEYaSqEo2XW00H84ZERgVWMdGfSOVWlm+tdvEDGsK7/dLmPTjlvHihzI7zL0UOGrJV
         Ycvb1K18vBP2CgREmPszHZ9iYftEWZ8k6morrvLfA8boOyEXsrlNotSXE6VhB22W1ZLb
         q/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767191; x=1718371991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nI8zy/rRUgerxKZmHDTJz4Abr5iixEv9BJDLAsh9Fec=;
        b=hF/xL5oldV/GuNMFzY/tbvu9JybORuEssW55N+RFPmbX9yT0LZdNiIdleQkeRug4xy
         iNpssge/Bhu6C42/LY81hJtAYRZ/yINuaJViwCWbUl+e0yK2AngnMswdlRRfLwUNN1Id
         2o2dqVjFRRthuSZKsXYSfTj4+e9WT2yCxFJwuuxDiKXOF72e7WDx33wpW2nP1ooB3kAq
         fUYcAwxxt02efCdV1eLDxFgYsPG/CB7sr2IZsEL6GW164bcbDLub3N524jebTygq8T67
         vnTYVW71DxIEzz53jv75ZgBi+SudBVVtXwSPs1e5Rq03JNcTeACh8O462WJyzA+c/QbR
         650A==
X-Gm-Message-State: AOJu0YxoKykqGvAtZEKHmj5r0nvSd4d/D68HMCoJqcQu9y1TLIM7EUcC
	5KU1CJ2cF9jY0ITXTPKdIX4CXeLA7zRgsjmjY7PT1/3TcF6L8hxR
X-Google-Smtp-Source: AGHT+IED6m3Gc7bbaGI7Qo9chjkjmCAferv65KxsUFX3NmG5OOdD8t03+phNb+RL/PBdcxQhIoK7Vg==
X-Received: by 2002:a2e:a16f:0:b0:2ea:e26d:c9b5 with SMTP id 38308e7fff4ca-2eae26dca5amr9717931fa.30.1717767190962;
        Fri, 07 Jun 2024 06:33:10 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 4/7] update-ref: add support for 'symref-delete' command
Date: Fri,  7 Jun 2024 15:33:01 +0200
Message-ID: <20240607133304.2333280-5-knayak@gitlab.com>
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

Add a new command 'symref-delete' to allow deletions of symbolic refs in
a transaction via the '--stdin' mode of the 'git-update-ref' command.
The 'symref-delete' command can, when given an <old-target>, delete the
provided <ref> only when it points to <old-target>.

This command is only compatible with the 'no-deref' mode because we
optionally want to check the 'old_target' of the ref being deleted.
De-referencing a symbolic ref would provide a regular ref and we already
have the 'delete' command for regular refs.

While users can also use 'git symbolic-ref -d' to delete symbolic refs,
the 'symref-delete' command in 'git-update-ref' allows users to do so
within a transaction, which promises atomicity of the operation and can
be batched with other commands.

When no 'old_target' is provided it can also delete regular refs,
similar to how the 'delete' command can delete symrefs when no 'old_oid'
is provided.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  5 +++
 builtin/fetch.c                  |  4 +-
 builtin/receive-pack.c           |  3 +-
 builtin/update-ref.c             | 33 +++++++++++++++-
 refs.c                           | 14 +++++--
 refs.h                           |  4 +-
 t/t1400-update-ref.sh            | 68 ++++++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh | 19 ++++++++-
 8 files changed, 140 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9fe78b3501..16e02f6979 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-delete SP <ref> [SP <old-target>] LF
 	symref-verify SP <ref> [SP <old-target>] LF
 	option SP <opt> LF
 	start LF
@@ -87,6 +88,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-delete SP <ref> [NUL <old-target>] NUL
 	symref-verify SP <ref> [NUL <old-target>] NUL
 	option SP <opt> NUL
 	start NUL
@@ -119,6 +121,9 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-delete::
+	Delete <ref> after verifying it exists with <old-target>, if given.
+
 symref-verify::
 	Verify symbolic <ref> against <old-target> but do not change it.
 	If <old-target> is missing, the ref must not exist.  Can only be
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 75255dc600..d63100e0d3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1386,8 +1386,8 @@ static int prune_refs(struct display_state *display_state,
 	if (!dry_run) {
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
-				result = ref_transaction_delete(transaction, ref->name, NULL, 0,
-								"fetch: prune", &err);
+				result = ref_transaction_delete(transaction, ref->name, NULL,
+								NULL, 0, "fetch: prune", &err);
 				if (result)
 					goto cleanup;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 01c1f04ece..0a30fac239 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1576,7 +1576,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
 					   old_oid,
-					   0, "push", &err)) {
+					   NULL, 0,
+					   "push", &err)) {
 			rp_error("%s", err.buf);
 			ret = "failed to delete";
 		} else {
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 50f5472160..0cb7eef3c6 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -293,7 +293,7 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 
 	if (ref_transaction_delete(transaction, refname,
 				   have_old ? &old_oid : NULL,
-				   update_flags, msg, &err))
+				   NULL, update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
@@ -301,6 +301,36 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+
+static void parse_cmd_symref_delete(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *old_target;
+
+	if (!(update_flags & REF_NO_DEREF))
+		die("symref-delete: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-delete: missing <ref>");
+
+	old_target = parse_next_refname(&next);
+
+	if (*next != line_termination)
+		die("symref-delete %s: extra input: %s", refname, next);
+
+	if (ref_transaction_delete(transaction, refname, NULL,
+				   old_target, update_flags, msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(old_target);
+	strbuf_release(&err);
+}
+
+
 static void parse_cmd_verify(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -443,6 +473,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
 	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
 	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
diff --git a/refs.c b/refs.c
index cdc4d25557..01f3188a09 100644
--- a/refs.c
+++ b/refs.c
@@ -950,7 +950,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
-				   flags, msg, &err) ||
+				   NULL, flags, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
@@ -1283,14 +1283,20 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   const char *old_target,
+			   unsigned int flags,
+			   const char *msg,
 			   struct strbuf *err)
 {
 	if (old_oid && is_null_oid(old_oid))
 		BUG("delete called with old_oid set to zeros");
+	if (old_oid && old_target)
+		BUG("delete called with both old_oid and old_target set");
+	if (old_target && !(flags & REF_NO_DEREF))
+		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      NULL, NULL, flags,
+				      NULL, old_target, flags,
 				      msg, err);
 }
 
@@ -2599,7 +2605,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 
 	for_each_string_list_item(item, refnames) {
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, flags, msg, &err);
+					     NULL, NULL, flags, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
diff --git a/refs.h b/refs.h
index 906299351c..974cf4dd08 100644
--- a/refs.h
+++ b/refs.h
@@ -722,7 +722,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   const char *old_target,
+			   unsigned int flags,
+			   const char *msg,
 			   struct strbuf *err);
 
 /*
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 52801be07d..9dbe28bd13 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1731,6 +1731,74 @@ do
 		test_cmp expect actual
 	'
 
+	test_expect_success "stdin $type symref-delete fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type <stdin 2>err &&
+		grep "fatal: symref-delete: cannot operate with deref mode" err
+	'
+
+	test_expect_success "stdin $type symref-delete fails with no ref" '
+		format_command $type "symref-delete " >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: symref-delete: missing <ref>" err
+	'
+
+	test_expect_success "stdin $type symref-delete fails deleting regular ref" '
+		test_when_finished "git update-ref -d refs/heads/regularref" &&
+		git update-ref refs/heads/regularref $a &&
+		format_command $type "symref-delete refs/heads/regularref" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: expected symref with target ${SQ}$a${SQ}: but is a regular ref" err
+	'
+
+	test_expect_success "stdin $type symref-delete fails with too many arguments" '
+		format_command $type "symref-delete refs/heads/symref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin $type symref-delete fails with wrong old value" '
+		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-delete works with right old value" '
+		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q refs/heads/symref
+	'
+
+	test_expect_success "stdin $type symref-delete works with empty old value" '
+		git symbolic-ref refs/heads/symref $a >stdin &&
+		format_command $type "symref-delete refs/heads/symref" "" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q $b
+	'
+
+	test_expect_success "stdin $type symref-delete succeeds for dangling reference" '
+		test_must_fail git symbolic-ref refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
+		format_command $type "symref-delete refs/heads/symref2" "refs/heads/nonexistent" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		test_must_fail git symbolic-ref -d refs/heads/symref2
+	'
+
+	test_expect_success "stdin $type symref-delete deletes regular ref without target" '
+		git update-ref refs/heads/regularref $a &&
+		format_command $type "symref-delete refs/heads/regularref" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin
+	'
+
 done
 
 test_done
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index fd58b902f4..ccde1b944b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -162,6 +162,7 @@ test_expect_success 'hook gets all queued symref updates' '
 
 	git update-ref refs/heads/branch $POST_OID &&
 	git symbolic-ref refs/heads/symref refs/heads/main &&
+	git symbolic-ref refs/heads/symrefd refs/heads/main &&
 
 	test_hook reference-transaction <<-\EOF &&
 	echo "$*" >>actual
@@ -171,16 +172,32 @@ test_expect_success 'hook gets all queued symref updates' '
 	done >>actual
 	EOF
 
-	cat >expect <<-EOF &&
+	# In the files backend, "delete" also triggers an additional transaction
+	# update on the packed-refs backend, which constitutes additional reflog
+	# entries.
+	if test_have_prereq REFFILES
+	then
+		cat >expect <<-EOF
+		aborted
+		$ZERO_OID $ZERO_OID refs/heads/symrefd
+		EOF
+	else
+		>expect
+	fi &&
+
+	cat >>expect <<-EOF &&
 	prepared
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	committed
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	EOF
 
 	git update-ref --no-deref --stdin <<-EOF &&
 	start
 	symref-verify refs/heads/symref refs/heads/main
+	symref-delete refs/heads/symrefd refs/heads/main
 	prepare
 	commit
 	EOF
-- 
2.43.GIT

