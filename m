Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB9212D7C
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796878; cv=none; b=M7cELgShWzJyuuUcM76FzGE6Bkx02hxO4385X2n72xcLhsE9B2mhrvuy7CRsE2foV/HfD1E6OsmqzgiweEnf72S7fICT4DRFu81SaARERD89pzcHEUAh9ImGPh/5yF1qqqDP8SdCpqzEQN1RL5o9u/AwR6qW8UaOtQW/EsFfXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796878; c=relaxed/simple;
	bh=40XScl39yG4cXmUPYSfWGNLwAe8Ar2GaopsxHKtTwgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmzIvuK65HSkN2ZUiiqHuCheAXFENp94QFjUr4noOdoYXKT3iDd8Qnh3P04vZUUh7CpCPn6pTJrGXr1yrwdmeBIvS9VuphnMS8hAxCecFCCLngN5v3qoNiywqpH+zyrj1ZwMX8W/04uR10HONTk5LgdpMdah8V5NJT6UsQ3/k9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGRYroSc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGRYroSc"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso79181366b.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757796875; x=1758401675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quDTRpBS0dMj1VBjtECcPXuPKq2QudEOGd9FgdcOqtU=;
        b=BGRYroSc6JXTDz/2HHv5q6WQnTnuiuM49qeckyyOZcvxycUWC7wFJjo1q42ipywVZD
         r66OMP47SX4btVpy8kVO6d96C8Pd9DQ68zz2f+/0xs7shLwHp6KLeIajSROPmGZVhxdE
         zNc1Yne3NN/96+WYrkk45+wGZy2wJKxWz2oSLxBH5x5U2Hlj+SikeqCGGjqgQpwwkkWA
         ah6WoQ5UDH8ToqOUNSVObB6pURL6siY1V1QnIc5Tuz2zvYNUxF4pG+zlzZmMbaiai+hR
         vAZ7v1bVriesZBfJ6NpBzDnp+LxKtJbx3Tt9Whbb5GARjxNKQ50yWKmXrsTrWHS/Is7G
         qVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796875; x=1758401675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quDTRpBS0dMj1VBjtECcPXuPKq2QudEOGd9FgdcOqtU=;
        b=hNEVxvNXXiwpdber55rW+DiYT/33/BfCeoa8r2H9b1NAm4eqd1qo16m7GliVHfhCVb
         2LQLCVu5Rz3OVXfRrO29CrrJELKGwBzNXlYAXkd9eXpmTmxpbvbrgG3D1nTJH4PcPcmk
         IO1AxqSvL0JxxVeBqV2JFAKkb7T7JETwn9auH09PAGmqRgjCB/O+pH+1daU5KFtYg+uM
         Xkt1Ccl0Rh6KYMU9wwBWhlzunJabWFzXuSefOu7HnWGqJZpnYJ3eJBG4VQ+0vQcKBQjo
         vvGWQDm6y6YRd8cJc8x+lCzoOQoRuCjoXupdN8mrA8RABpcUOyhTVBl1gcDeXR4dE36h
         Tc4w==
X-Gm-Message-State: AOJu0Ywsc05DJvIWwSLDSn/41OMwek3z+1pcyGP+ovgbDhOEpQ41D15i
	0tzpp2HHuzQyMOBJv4Y8xqxA2jTqaOl//0iWruQ3gfryo9KS9wckbTe7
X-Gm-Gg: ASbGncvbmtwWhucmyRV53zBeVarRQNzrRdJ+uAOpHnDoPr3V77KmnqFuSFjWUSv0xon
	+n5fiTWotHE0hx+5dCR0EVhA6S9bmVIdBT2FPhkUFpIfQqFdCZUhrIX4UioA819uSzDT8TfG2J+
	fsOVOlDyp176MGG6jIpDas8rN+LUE3xPBrVbowvwzLW0Qf4phoFDqb9rGcO7Iv7tuZlKvGNlXQx
	oqcI6mmeA1sgKMqnc+7CzRwZT3PP+twDlvcuHUjc/pF8PNhOMjVu3tOBIxqVrZNDqszjL/6UM4U
	E4jLX+0cYuEjrBNaT2KV067w81p9EnfMTrH8F1uxtndz7xZuSihVV1LKNFX0vcrhLyZ0zA+Osoo
	NKgaSyQEoKzk1ZIdkQNlBDrBA/SDK
X-Google-Smtp-Source: AGHT+IG27KntnecfWqM6T8zqSwJK8LuQyShBTn9oOwWlOufrmSjsHQIDBlCWM2Tf48kB1WNstR05qQ==
X-Received: by 2002:a17:906:1611:b0:b07:dbf9:a2a3 with SMTP id a640c23a62f3a-b07dbf9a7ddmr321572066b.14.1757796874886;
        Sat, 13 Sep 2025 13:54:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5b4f:6b96:ff06:27eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ef574sm635383466b.73.2025.09.13.13.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:54:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 13 Sep 2025 22:54:29 +0200
Subject: [PATCH v3 1/4] refs/files: catch conflicts on case-insensitive
 file-systems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-1-195569740b57@gmail.com>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12746;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=40XScl39yG4cXmUPYSfWGNLwAe8Ar2GaopsxHKtTwgI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjF2gjGQ7SkAvRrKu3EWpBm7MYtBsQ6rpwLd
 +euwMcaODMTgIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoxdoIAAoJED7VnySO
 Rox/cbsL/RpBNWiE7VcilBxZsOE2/A57W5sB3HN3QDb/1OrHYV1g/sVKTGREc1YrjiA3qgOtwHk
 NUJKBpxhJahuNYQhf+pYUNUJSXWOrhrOn1fjrnpnKPkrEI/WoB0KNLUenKxfYRW2i7RmTafYTum
 RM6iFJsOYTqEN4RaT+su9Ha3YPo8RPpKQJRGmg6Ah39NY+NKDHLIHVjLzYzpxQXomLhZ/q8n7Zp
 7b/EPcE1KhaMqUQ5TNRs75+w2d3AN1e6k027+QKbrSI+omiqve5j8ZgxKAR84scs6iVbBfdN1L9
 g9dOVKZtO8zwC137/U0IbI4doC3fX6YWkQknWhurAX4KXMQaZRpR1utxvdGRnJOCaSY5OdXUjwC
 auYF/XeFpUVwvtFftXDys9/DlczW/g9e5ZyvQYJFxDd58dxmwq8Xg9BimKUfO8aldbHkwH5OLFh
 tdw7o1TrQz4pBs4VJH23v+RrnYyT3MV5nZVpHNEtA0NWXKjfDiexU2vXI6QUzi6DLV1DXVhRYa7
 Bo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

During the 'prepare' phase of reference transaction in the files
backend, we create the lock files for references to be created. When
using batched updates on case-insensitive filesystems, the entire
batched updates would be aborted if there are conflicting names such as:

  refs/heads/Foo
  refs/heads/foo

This affects all commands which were migrated to use batched updates in
Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
that, reference updates would be applied serially with one transaction
used per update. When users fetched multiple references on
case-insensitive systems, subsequent references would simply overwrite
any earlier references. So when fetching:

  refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
  refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

The user would simply end up with:

  refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

This is buggy behavior since the user is never informed about the
overrides performed and missing references. Nevertheless, the user is
left with a working repository with a subset of the references. Since
Git 2.51, in such situations fetches would simply fail without updating
any references. Which is also buggy behavior and worse off since the
user is left without any references.

The error is triggered in `lock_raw_ref()` where the files backend
attempts to create a lock file. When a lock file already exists the
function returns a 'REF_TRANSACTION_ERROR_GENERIC'. When this happens,
the entire batched updates, not individual operation, is aborted as if
it were in a transaction.

Change this to return 'REF_TRANSACTION_ERROR_CASE_CONFLICT' instead to
aid the batched update mechanism to simply reject such errors. The
change only affects batched updates since batched updates will reject
individual updates with non-generic errors. So specifically this would
only affect:

    1. git fetch
    2. git receive-pack
    3. git update-ref --batch-updates

This bubbles the error type up to `files_transaction_prepare()` which
tries to lock each reference update. So if the locking fails, we check
if the rejection type can be ignored, which is done by calling
`ref_transaction_maybe_set_rejected()`.

As the error type is now 'REF_TRANSACTION_ERROR_CASE_CONFLICT',
the specific reference update would simply be rejected, while other
updates in the transaction would continue to be applied. This allows
partial application of references in case-insensitive filesystems when
fetching colliding references.

While the earlier implementation allowed the last reference to be
applied overriding the initial references, this change would allow the
first reference to be applied while rejecting consequent collisions.
This should be an okay compromise since with the files backend, there is
no scenario possible where we would retain all colliding references.

Let's also be more pro-active and notify users on case-insensitive
filesystems about such problems by providing a brief about the issue
while also recommending using the reftable backend, which doesn't have
the same issue.

Reported-by: Joe Drew <joe.drew@indexexchange.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c       | 21 +++++++++++++++++---
 refs.c                |  2 ++
 refs.h                |  2 ++
 refs/files-backend.c  | 33 +++++++++++++++++++++++++++-----
 t/t1400-update-ref.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh      | 22 ++++++++++++++++++++-
 6 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 24645c4653..c7ff3480fb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1643,7 +1643,8 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 struct ref_rejection_data {
 	int *retcode;
-	int conflict_msg_shown;
+	bool conflict_msg_shown;
+	bool case_sensitive_msg_shown;
 	const char *remote_name;
 };
 
@@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
 {
 	struct ref_rejection_data *data = cb_data;
 
-	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
+	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
+	    !data->case_sensitive_msg_shown) {
+		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
+			"trying to fetch from has references that only differ in casing. It\n"
+			"is impossible to store such references with the 'files' backend. You\n"
+			"can either accept this as-is, in which case you won't be able to\n"
+			"store all remote references on disk. Or you can alternatively\n"
+			"migrate your repository to use the 'reftable' backend with the\n"
+			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
+			"Please keep in mind that not all implementations of Git support this\n"
+			"new format yet. So if you use tools other than Git to access this\n"
+			"repository it may not be an option to migrate to reftables.\n"));
+		data->case_sensitive_msg_shown = true;
+	} else if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT &&
+		   !data->conflict_msg_shown) {
 		error(_("some local refs could not be updated; try running\n"
 			" 'git remote prune %s' to remove any old, conflicting "
 			"branches"), data->remote_name);
-		data->conflict_msg_shown = 1;
+		data->conflict_msg_shown = true;
 	} else {
 		const char *reason = ref_transaction_error_msg(err);
 
diff --git a/refs.c b/refs.c
index bfdbe718b7..4c1c339ed9 100644
--- a/refs.c
+++ b/refs.c
@@ -3321,6 +3321,8 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "invalid new value provided";
 	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
 		return "expected symref but found regular ref";
+	case REF_TRANSACTION_ERROR_CASE_CONFLICT:
+		return "reference conflict due to case-insensitive filesystem";
 	default:
 		return "unknown failure";
 	}
diff --git a/refs.h b/refs.h
index eedbb599c5..41915086b3 100644
--- a/refs.h
+++ b/refs.h
@@ -31,6 +31,8 @@ enum ref_transaction_error {
 	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
 	/* Expected ref to be symref, but is a regular ref */
 	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
+	/* Cannot create ref due to case-insensitive filesystem */
+	REF_TRANSACTION_ERROR_CASE_CONFLICT = -8,
 };
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 088b52c740..01df32904b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -647,6 +647,26 @@ static void unlock_ref(struct ref_lock *lock)
 	}
 }
 
+/*
+ * Check if the transaction has another update with a case-insensitive refname
+ * match.
+ *
+ * If the update is part of the transaction, we only check up to that index.
+ * Further updates are expected to call this function to match previous indices.
+ */
+static bool transaction_has_case_conflicting_update(struct ref_transaction *transaction,
+						    struct ref_update *update)
+{
+	for (size_t i = 0; i < transaction->nr; i++) {
+		if (transaction->updates[i] == update)
+			break;
+
+		if (!strcasecmp(transaction->updates[i]->refname, update->refname))
+			return true;
+	}
+	return false;
+}
+
 /*
  * Lock refname, without following symrefs, and set *lock_p to point
  * at a newly-allocated lock object. Fill in lock->old_oid, referent,
@@ -677,16 +697,17 @@ static void unlock_ref(struct ref_lock *lock)
  * - Generate informative error messages in the case of failure
  */
 static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
-					       struct ref_update *update,
+					       struct ref_transaction *transaction,
 					       size_t update_idx,
 					       int mustexist,
 					       struct string_list *refnames_to_check,
-					       const struct string_list *extras,
 					       struct ref_lock **lock_p,
 					       struct strbuf *referent,
 					       struct strbuf *err)
 {
 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
+	struct ref_update *update = transaction->updates[update_idx];
+	const struct string_list *extras = &transaction->refnames;
 	const char *refname = update->refname;
 	unsigned int *type = &update->type;
 	struct ref_lock *lock;
@@ -776,6 +797,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 			goto retry;
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
+			if (myerr == EEXIST && ignore_case &&
+			    transaction_has_case_conflicting_update(transaction, update))
+				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
 			goto error_return;
 		}
 	}
@@ -2583,9 +2607,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 	if (lock) {
 		lock->count++;
 	} else {
-		ret = lock_raw_ref(refs, update, update_idx, mustexist,
-				   refnames_to_check, &transaction->refnames,
-				   &lock, &referent, err);
+		ret = lock_raw_ref(refs, transaction, update_idx, mustexist,
+				   refnames_to_check, &lock, &referent, err);
 		if (ret) {
 			char *reason;
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 96648a6e5d..08d5df2af7 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2294,6 +2294,59 @@ do
 		)
 	'
 
+	test_expect_success CASE_INSENSITIVE_FS,REFFILES "stdin $type batch-updates existing reference" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+
+			{
+				format_command $type "create refs/heads/foo" "$head" &&
+				format_command $type "create refs/heads/ref" "$old_head" &&
+				format_command $type "create refs/heads/Foo" "$old_head"
+			} >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+
+			echo $head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref >actual &&
+			test_cmp expect actual &&
+			test_grep -q "reference conflict due to case-insensitive filesystem" stdout
+		)
+	'
+
+	test_expect_success CASE_INSENSITIVE_FS "stdin $type batch-updates existing reference" '
+		git init --ref-format=reftable repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+
+			{
+				format_command $type "create refs/heads/foo" "$head" &&
+				format_command $type "create refs/heads/ref" "$old_head" &&
+				format_command $type "create refs/heads/Foo" "$old_head"
+			} >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+
+			echo $head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref >actual &&
+			test_cmp expect actual &&
+			git rev-parse refs/heads/Foo >actual &&
+			test_cmp expect actual
+		)
+	'
+
 	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ebc696546b..57f60da81b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -47,7 +47,13 @@ test_expect_success "clone and setup child repos" '
 		git config set branch.main.merge refs/heads/one
 	) &&
 	git clone . bundle &&
-	git clone . seven
+	git clone . seven &&
+	git clone --ref-format=reftable . case_sensitive &&
+	(
+		cd case_sensitive &&
+		git branch branch1 &&
+		git branch bRanch1
+	)
 '
 
 test_expect_success "fetch test" '
@@ -1526,6 +1532,20 @@ test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	test_path_is_missing whoops
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "You${SQ}re on a case-insensitive filesystem" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch1 >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

