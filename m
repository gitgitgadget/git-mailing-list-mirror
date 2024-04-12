Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697151C36
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915966; cv=none; b=A7jq8pXLC4bBfp/gcI86Md00GYJbTOTlpjgFzTjELb8Hg5ueMLlB5dnzuZ5q5m1RofdFfFea/5rn/7k2Gh3HEPbI8JksagUhRWK+oAsRym1egQAbg3hmzbwHHCghmnsS2rcgGqItdX8C0jM9K+hu/yk14unv1yEyw/0GF3cMyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915966; c=relaxed/simple;
	bh=36/OR6e0Ux8u+mL6Pq+tyf201+v7xZpeUgyMuRHH+2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1fMws+SeZ5KQ3BRtjKaN25hGeEy41vwXah9dM+UNB1SQ5I2ertbiT9Gtm8vj8E2dT3D3KDYhn2HJfuKXE4H5l3FtxZ7BVjWq+FKAVs4lzmwaiuVfKRPRoiFpbZRzTmO3ryyVgcbtk9KAOr7YMdffcva1aIzrtz1DMlwEWXh2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ1bqcQN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ1bqcQN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso952884a12.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915962; x=1713520762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLX5r1EDDCIedTdBkAXz1fDSm9fYX1S4eN8FpC3vSYY=;
        b=lQ1bqcQNlWv1Lev0b02a94PcbrfriuKEtD3YMm3udfXGJE1oP85Gs0DJTc3mr5yUuL
         Wk4BlQ6l0TvFjtUfvvlgvkpcnjmLTZerUacJuVfO5z5u00qWDhOF6MGOF3bzoAmlVGFA
         f5qf7re0K297j8wVcnT2JGChBsR8pKQm3NqPFNIqfgMTJnyieFNgeyhlBgAj0qizcvNo
         PUa9AhxetNLpsUzbHv+UX0sS91SPmW2+qwNWvDmQt3xjlSTVC95ndyrB9VhLy1IfBUaP
         syGTzp7LKkzU50Oo0o8y8P5EjrbhP7do8QzbK2K3fZBUt9gSLUWPi+aL3KuS0H2XUYEk
         wbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915962; x=1713520762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLX5r1EDDCIedTdBkAXz1fDSm9fYX1S4eN8FpC3vSYY=;
        b=umhQfbbLU058xBaBqWNT/eTuGh1zNuKeWfskPdv6T+sYAgR6niuiRLZxa4gGjBHmCk
         zxn4d1oSggMuPoXbL6wQ59hNrNvKGwK2+65zXOWMITSZUWZHXGxuyBtsoincPGS9su0V
         kgbcgRC4mI1WGvkYE/O4M6ogt6JN6X/QT2abJW+CIO8Ijb8UDthyp8uFa7KI28MBlBol
         gbFD9ED9QyYcyuvvyzv28t6hijdAuOfWqR3C/LMG5k4pyPKwdQrFZugcpn9MY3ahhjNd
         NSVn9Q+4atzVNDxAbhT6gy22+Qsr5wYz8Q0+7fHhBl887Dr/KsqiVKdFh6OrCC4mDqjn
         IPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXB4EaUu1DEUH0VwJUnElS0z3zbEwa+TtWbg7lxUf+fGG6Fd+MHAKC/p56kiUbi6+Kp0byg460w7MtNj7eYOy3dUHy
X-Gm-Message-State: AOJu0Yzj66Iy5Nmpl4gRrAQRFJkNq1sFzrrsSG/k15c7nEH3RL3xu2cT
	UdhIX2ILviY80wyecvSSCvL6FLiyW2nQWO8aEwtA9LKPm3vXkvaZ
X-Google-Smtp-Source: AGHT+IFoeBR/cI4C+o3XtHQdxNd0ueKFiKklqOcQ0PzhUYQEYba5jeDNwNv9n4ASQLtoHEPsquD5dA==
X-Received: by 2002:a50:cddd:0:b0:56b:b6a2:2048 with SMTP id h29-20020a50cddd000000b0056bb6a22048mr1445447edj.24.1712915962438;
        Fri, 12 Apr 2024 02:59:22 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:21 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 3/7] update-ref: add support for symref-delete
Date: Fri, 12 Apr 2024 11:59:04 +0200
Message-ID: <20240412095908.1134387-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Similar to the previous commit, add 'symref-delete' to allow deletions
of symbolic refs in a transaction via the 'git-update-ref' command. The
'symref-delete' command can when given with an <old-ref>, deletes the
provided <ref> only when it points to <old-ref>.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  6 +++++
 builtin/fetch.c                  |  2 +-
 builtin/receive-pack.c           |  3 ++-
 builtin/update-ref.c             | 34 +++++++++++++++++++++++++++-
 refs.c                           | 16 +++++++++----
 refs.h                           |  4 +++-
 refs/files-backend.c             |  2 +-
 refs/reftable-backend.c          |  2 +-
 t/t1400-update-ref.sh            | 39 ++++++++++++++++++++++++++++++++
 9 files changed, 97 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 749aaa7892..ef22a1a2f4 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-delete SP <ref> [SP <old-ref>] LF
 	symref-verify SP <ref> [SP <old-ref>] LF
 	option SP <opt> LF
 	start LF
@@ -87,6 +88,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-delete SP <ref> [NUL <old-ref>] NUL
 	symref-verify SP <ref> [NUL <old-ref>] NUL
 	option SP <opt> NUL
 	start NUL
@@ -119,6 +121,10 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-delete::
+	Delete <ref> after verifying it exists with <old-ref>, if
+	given.
+
 symref-verify::
 	Verify symbolic <ref> against <old-ref> but do not change it.
 	If <old-ref> is missing, the ref must not exist.  Can only be
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 66840b7c5b..d02592efca 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1383,7 +1383,7 @@ static int prune_refs(struct display_state *display_state,
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
 				result = ref_transaction_delete(transaction, ref->name, NULL, 0,
-								"fetch: prune", &err);
+								NULL, "fetch: prune", &err);
 				if (result)
 					goto cleanup;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ebea1747cb..6b728baaac 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1576,7 +1576,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
 					   old_oid,
-					   0, "push", &err)) {
+					   0, NULL,
+					   "push", &err)) {
 			rp_error("%s", err.buf);
 			ret = "failed to delete";
 		} else {
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4ae6bdcb12..3be9ae0d00 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -294,7 +294,7 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 
 	if (ref_transaction_delete(transaction, refname,
 				   have_old ? &old_oid : NULL,
-				   update_flags, msg, &err))
+				   update_flags, NULL, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
@@ -302,6 +302,37 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+static void parse_cmd_symref_delete(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *old_ref;
+
+	if (!(update_flags & REF_NO_DEREF))
+                die("symref-delete: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-delete: missing <ref>");
+
+        old_ref = parse_next_refname(&next);
+	if (old_ref && read_ref(old_ref, NULL))
+		die("symref-delete %s: invalid <old-ref>", refname);
+
+	if (*next != line_termination)
+		die("symref-delete %s: extra input: %s", refname, next);
+
+	if (ref_transaction_delete(transaction, refname, NULL,
+				   update_flags | REF_SYMREF_UPDATE,
+				   old_ref, msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(old_ref);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_verify(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -445,6 +476,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
 	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
 	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
diff --git a/refs.c b/refs.c
index 124b294c9f..6d98d9652d 100644
--- a/refs.c
+++ b/refs.c
@@ -981,7 +981,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
-				   flags, msg, &err) ||
+				   flags, NULL, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
@@ -1220,6 +1220,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
 		free((void *)transaction->updates[i]->old_ref);
+		free((void *)transaction->updates[i]->new_ref);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -1252,6 +1253,8 @@ struct ref_update *ref_transaction_add_update(
 	if (update->flags & REF_SYMREF_UPDATE) {
 		if (old_ref)
 			update->old_ref = xstrdup(old_ref);
+		if (new_ref)
+			update->new_ref = xstrdup(new_ref);
 	} else {
 		if (flags & REF_HAVE_NEW)
 			oidcpy(&update->new_oid, new_oid);
@@ -1317,14 +1320,17 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int flags,
+			   const char *old_ref,
+			   const char *msg,
 			   struct strbuf *err)
 {
-	if (old_oid && is_null_oid(old_oid))
+	if (!(flags & REF_SYMREF_UPDATE) && old_oid &&
+	    is_null_oid(old_oid))
 		BUG("delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      NULL, NULL, flags,
+				      NULL, old_ref, flags,
 				      msg, err);
 }
 
@@ -2748,7 +2754,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 
 	for_each_string_list_item(item, refnames) {
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, flags, msg, &err);
+					     NULL, flags, 0, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
diff --git a/refs.h b/refs.h
index a988e672ff..60e6a21a31 100644
--- a/refs.h
+++ b/refs.h
@@ -758,7 +758,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int flags,
+			   const char *old_ref,
+			   const char *msg,
 			   struct strbuf *err);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8421530bde..f74ea308b5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2501,7 +2501,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
-	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
+	if ((update->flags & REF_HAVE_NEW) && null_new_value(update))
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7a03922c7b..935bf407df 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1122,7 +1122,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		if (u->flags & REF_LOG_ONLY)
 			continue;
 
-		if (u->flags & REF_HAVE_NEW && is_null_oid(&u->new_oid)) {
+		if (u->flags & REF_HAVE_NEW && null_new_value(u)) {
 			struct reftable_ref_record ref = {
 				.refname = (char *)u->refname,
 				.update_index = ts,
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d8ffda4096..cf01c5d867 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1715,6 +1715,45 @@ test_expect_success "stdin ${type} symref-verify fails for mistaken null value"
 	test_cmp expect actual
 '
 
+test_expect_success "stdin ${type} symref-delete fails without --no-deref" '
+	git symbolic-ref refs/heads/symref $a &&
+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+	grep "fatal: symref-delete: cannot operate with deref mode" err
+'
+
+test_expect_success "stdin ${type} fails symref-delete with no ref" '
+	create_stdin_buf ${type} "symref-delete " &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	grep "fatal: symref-delete: missing <ref>" err
+'
+
+test_expect_success "stdin ${type} fails symref-delete with too many arguments" '
+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	if test "$type" = "-z"
+	then
+		grep "fatal: unknown command: $a" err
+	else
+		grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
+	fi
+'
+
+test_expect_success "stdin ${type} symref-delete ref fails with wrong old value" '
+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	grep "fatal: cannot lock ref '"'"'refs/heads/symref'"'"'" err &&
+	git symbolic-ref refs/heads/symref >expect &&
+	echo $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-delete ref works with right old value" '
+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
 done
 
 test_done
-- 
2.43.GIT

