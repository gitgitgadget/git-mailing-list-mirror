Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57F53E17
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915969; cv=none; b=N0rIQt99FXxe74moR5Ihq/oj98yktuckz4U7KaIZir74+CRAwf7An45zY1s+ZvMrdRCqrucBI3uKNLwFAnSSMyVKukzmJjJ49NKZ0fmM9/XzYMCffbkfhpB28jkT/MpFSdQZ21WO2wV67HLh1Ei84bvU5rWL2MYYxDTdUgsEQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915969; c=relaxed/simple;
	bh=lyVS2iCrkoFXGhE4l//XRE/5TiIvCaWV+PBq/yD3aZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EriAOl47KiPT3f6L83rPx72GLZxt0Szokgm9c+UoW+7P9vEUBeARFkJlcIxYT5dn+GcrlrFzowVW/B9gQneaM5iS2FA4rnqLxrc7knfKrQrqlCOElZvUmwL05VWU1iVOAj0MrMAgihtXYLnGyAjGpr2UvJRsaYiCXBp69tiROeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW0mi9uj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW0mi9uj"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so916594a12.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915966; x=1713520766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3Y4TKyjk5msJRfWV0PLyViMD0KiEG4rhidjrHu7YvY=;
        b=LW0mi9ujrESJ8Cg2Ff1PxUA9bVprmY1WNMdHXc9fpxWB4HmPvWC2zebcpG7sRiuK3Q
         zkAg59hU4T9hh0KY8giOXi+mWWDj8F1yDsDm9Y8UKEH/RIdob7+8t91kkZQJQ4MCPjq5
         z37gNDdGTcxSaVxOnBTBAAgb9KGUQAP4T8i2vug0fRHk/98HqBWZq2edjBUHTyltAMn/
         /3+07UWLU8Zd1gCuCVFPvd9c5Z6HMzbSebuAEP2t2261hin4P1NV9iQ9flFr1/4xPYD+
         C7tBd8ZcFGOvcBRr7qBwsF4FoqqTXaapbqAM2HKMPlNy8/R4ExF5C0+aHVfClUwab1Sj
         ry5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915966; x=1713520766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3Y4TKyjk5msJRfWV0PLyViMD0KiEG4rhidjrHu7YvY=;
        b=o1IvoZ38MTKJAxi0alHSdCtj7cDJmnufsbH1UWXrcrYcFWh+sGnTrVJjaFenMk3SAC
         qn4pOccARDWOQ6rD9nJhkNIrGn7+Ubav2b/io/so8I5grMpEXmDpRsK6XSKpHezM3TxB
         4gkLKOaXTNwOM+V6A/jzOgNBx3Zuui0Nfqa88vKHz06vTkk2GL3+mF1Y83rTJqLM4IqN
         PZ3SXyd7eeqi/AFocBy0hCA2sO4P3ZsxW0GIQkk9cqR4ViHx9tUDn8kY8WTCvG+kWPC6
         7qm379yPRss/q1KAqXCACjoQElGtcvW/ZEuapS9q2Sr/vcW8oKnyl3U9waXlqO/g4h9G
         ufrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg2ElqmG9xeGT+eoAfvXOmHVjMd0Kf3uzFcH5/XGJzmqgG4bgcH2NMGmiT3DdITKI5yN8mJlKMWGPxLEZpJ+LXkMtX
X-Gm-Message-State: AOJu0YxZNj8Z7sOOb6xFnHcPV8lnYNZDq5fjwAVyIp7BPbso+TUVhwrl
	pKvTXzv9wtcywl+dl7kLQIEOJ9c75kcqZGMPBX0xS/d7kUKw7aSI
X-Google-Smtp-Source: AGHT+IHBeEnyw2qQeAoG0YHtGC9CJjy4CXOk/Vj9Fr7ioBDrkH2AO29iz0x0ulNhrWbBkZ8jhygl8Q==
X-Received: by 2002:a50:c318:0:b0:566:4a85:ceba with SMTP id a24-20020a50c318000000b005664a85cebamr1221469edb.1.1712915965924;
        Fri, 12 Apr 2024 02:59:25 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:25 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 5/7] update-ref: add support for symref-create
Date: Fri, 12 Apr 2024 11:59:06 +0200
Message-ID: <20240412095908.1134387-6-knayak@gitlab.com>
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

Add 'symref-create' to allow creation of symbolic refs in a transaction
via the 'git-update-ref' command. The 'symref-create' command takes in a
<new-ref>, which the created <ref> will point to.

We also support the 'core.prefersymlinkrefs', wherein if the flag is set
and the filesystem supports symlinks, we create the symbolic ref as a
symlink.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  6 ++++
 builtin/clone.c                  |  2 +-
 builtin/update-ref.c             | 36 +++++++++++++++++++-
 refs.c                           |  9 +++--
 refs.h                           |  1 +
 refs/files-backend.c             | 38 +++++++++++++++++++++
 refs/reftable-backend.c          | 19 +++++++++--
 t/t0600-reffiles-backend.sh      | 32 ++++++++++++++++++
 t/t1400-update-ref.sh            | 58 ++++++++++++++++++++++++++++++++
 9 files changed, 194 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index ef22a1a2f4..a5b1f42728 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-create SP <ref> SP <new-ref> LF
 	symref-delete SP <ref> [SP <old-ref>] LF
 	symref-verify SP <ref> [SP <old-ref>] LF
 	option SP <opt> LF
@@ -88,6 +89,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-create SP <ref> NUL <new-ref> NUL
 	symref-delete SP <ref> [NUL <old-ref>] NUL
 	symref-verify SP <ref> [NUL <old-ref>] NUL
 	option SP <opt> NUL
@@ -121,6 +123,10 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-create::
+	Create symbolic ref <ref> with <new-ref> after verifying
+	it does not exist.  Can only be used in `no-deref` mode.
+
 symref-delete::
 	Delete <ref> after verifying it exists with <old-ref>, if
 	given.
diff --git a/builtin/clone.c b/builtin/clone.c
index 74ec14542e..c0eed8e795 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -547,7 +547,7 @@ static void write_remote_refs(const struct ref *local_refs)
 		if (!r->peer_ref)
 			continue;
 		if (ref_transaction_create(t, r->peer_ref->name, &r->old_oid,
-					   0, NULL, &err))
+					   NULL, 0, NULL, &err))
 			die("%s", err.buf);
 	}
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3be9ae0d00..24556a28a8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,7 +258,7 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, &new_oid,
+	if (ref_transaction_create(transaction, refname, &new_oid, NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -268,6 +268,39 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+static void parse_cmd_symref_create(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *new_ref;
+
+	if (!(update_flags & REF_NO_DEREF))
+                die("symref-create: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-create: missing <ref>");
+
+	new_ref = parse_next_refname(&next);
+	if (!new_ref)
+		die("symref-create %s: missing <new-ref>", refname);
+	if (read_ref(new_ref, NULL))
+		die("symref-create %s: invalid <new-ref>", refname);
+
+	if (*next != line_termination)
+		die("symref-create %s: extra input: %s", refname, next);
+
+	if (ref_transaction_create(transaction, refname, NULL, new_ref,
+				   update_flags | create_reflog_flag |
+				   REF_SYMREF_UPDATE, msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(new_ref);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_delete(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -476,6 +509,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
 	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
diff --git a/refs.c b/refs.c
index 6d98d9652d..e62c0f4aca 100644
--- a/refs.c
+++ b/refs.c
@@ -1305,15 +1305,20 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_ref,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (!new_oid || is_null_oid(new_oid)) {
+	if ((flags & REF_SYMREF_UPDATE) && !new_ref) {
+		strbuf_addf(err, "'%s' has a no new ref", refname);
+		return 1;
+	}
+	if (!(flags & REF_SYMREF_UPDATE) && (!new_oid || is_null_oid(new_oid))) {
 		strbuf_addf(err, "'%s' has a null OID", refname);
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), NULL, NULL, flags,
+				      null_oid(), new_ref, NULL, flags,
 				      msg, err);
 }
 
diff --git a/refs.h b/refs.h
index 60e6a21a31..c01a517e40 100644
--- a/refs.h
+++ b/refs.h
@@ -744,6 +744,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_ref,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7c894ebe65..59d438878a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2609,6 +2609,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
+	if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
+		if (create_symref_lock(refs, lock, update->refname, update->new_ref)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		if (close_ref_gently(lock)) {
+			strbuf_addf(err, "couldn't close '%s.lock'",
+				    update->refname);
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		/*
+		 * Once we have created the symref lock, the commit
+		 * phase of the transaction only needs to commit the lock.
+		 */
+		update->flags |= REF_NEEDS_COMMIT;
+	}
+
+
 	if ((update->flags & REF_HAVE_NEW) &&
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {
@@ -2904,6 +2925,14 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
+			if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
+				/* for dangling symrefs we gracefully set the oid to zero */
+				if (!refs_resolve_ref_unsafe(&refs->base, update->new_ref,
+							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
+					update->new_oid = *null_oid();
+				}
+			}
+
 			if (files_log_ref_write(refs,
 						lock->ref_name,
 						&lock->old_oid,
@@ -2921,6 +2950,15 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				goto cleanup;
 			}
 		}
+
+		/*
+		 * We try creating a symlink, if that succeeds we continue to the
+		 * next updated. If not, we try and create a regular symref.
+		 */
+		if (update->flags & REF_SYMREF_UPDATE && prefer_symlink_refs)
+			if (!create_ref_symlink(lock, update->new_ref))
+				continue;
+
 		if (update->flags & REF_NEEDS_COMMIT) {
 			clear_loose_ref_cache(refs);
 			if (commit_ref(lock)) {
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 935bf407df..6d42838e15 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -856,7 +856,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * There is no need to write the reference deletion
 			 * when the reference in question doesn't exist.
 			 */
-			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
+			 if (u->flags & REF_HAVE_NEW && !null_new_value(u)) {
 				 ret = queue_transaction_update(refs, tx_data, u,
 								&current_oid, err);
 				 if (ret)
@@ -1064,7 +1064,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		 * - `core.logAllRefUpdates` tells us to create the reflog for
 		 *   the given ref.
 		 */
-		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
+		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && null_new_value(u)) {
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
@@ -1122,7 +1122,20 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		if (u->flags & REF_LOG_ONLY)
 			continue;
 
-		if (u->flags & REF_HAVE_NEW && null_new_value(u)) {
+		if (u->flags & REF_SYMREF_UPDATE &&
+		    u->flags & REF_HAVE_NEW &&
+		    !null_new_value(u)) {
+			struct reftable_ref_record ref = {
+				.refname = (char *)u->refname,
+				.value_type = REFTABLE_REF_SYMREF,
+				.value.symref = (char *)u->new_ref,
+				.update_index = ts,
+			};
+
+			ret = reftable_writer_add_ref(writer, &ref);
+			if (ret < 0)
+				goto done;
+		} else if (u->flags & REF_HAVE_NEW && null_new_value(u)) {
 			struct reftable_ref_record ref = {
 				.refname = (char *)u->refname,
 				.update_index = ts,
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 64214340e7..c5061c26cf 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -472,4 +472,36 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
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
index cf01c5d867..f4e63fae6e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1754,6 +1754,64 @@ test_expect_success "stdin ${type} symref-delete ref works with right old value"
 	test_must_fail git rev-parse --verify -q $b
 '
 
+test_expect_success "stdin ${type} symref-create fails without --no-deref" '
+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" &&
+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+	grep "fatal: symref-create: cannot operate with deref mode" err
+'
+
+test_expect_success "stdin ${type} fails symref-create with no ref" '
+	create_stdin_buf ${type} "symref-create " >stdin &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	grep "fatal: symref-create: missing <ref>" err
+'
+
+test_expect_success "stdin ${type} fails symref-create with no new value" '
+	create_stdin_buf ${type} "symref-create refs/heads/symref" >stdin &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	grep "fatal: symref-create refs/heads/symref: missing <new-ref>" err
+'
+
+test_expect_success "stdin ${type} fails symref-create with too many arguments" '
+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" "$a" >stdin &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	if test "$type" = "-z"
+	then
+		grep "fatal: unknown command: $a" err
+	else
+		grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
+	fi
+'
+
+test_expect_success "stdin ${type} symref-create ref works" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	git symbolic-ref refs/heads/symref >expect &&
+	echo $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-create does not create reflogs by default" '
+	test_when_finished "git symbolic-ref -d refs/symref" &&
+	create_stdin_buf ${type} "symref-create refs/symref" "$a" >stdin &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	git symbolic-ref refs/symref >expect &&
+	echo $a >actual &&
+	test_cmp expect actual &&
+	test_must_fail git reflog exists refs/symref
+'
+
+test_expect_success "stdin ${type} symref-create reflogs with --create-reflog" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
+	git update-ref --create-reflog --stdin ${type} --no-deref <stdin &&
+	git symbolic-ref refs/heads/symref >expect &&
+	echo $a >actual &&
+	test_cmp expect actual &&
+	git reflog exists refs/heads/symref
+'
+
 done
 
 test_done
-- 
2.43.GIT

