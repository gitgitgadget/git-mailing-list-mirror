Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7D43F4B7
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289200; cv=none; b=lxye1Q64hXhOvfN8ZLUmMAetd0Ot0Rqa+sgasjX9XY1E4Lwv7e1YUnhsVoMBxGnlWFY5BS0G6GNu7GsEhGBBVMsvSEQnWMSKHBehHdNAlKTaMGu52uDeu7Cyqw0WUQi0kroCIMa7KkXEme+9rLv/CXr9QM6Wwqz4/ZHU8eKjxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289200; c=relaxed/simple;
	bh=G0LYkHactgQSGtZPWloyXULRBjZtPGmqi6BrSxMmn4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4ebJn6kMSxlbeJf4zER1SF63UoHnshorVX0PxdRCtlRsUL5z0rGQTpehLvXHcWRJzFYU1D+GVE4sTWQsOIfm+j2doYPDqSTfw6l5P0MO4Ukbvpp0qnhUX4vmJHVtF1E8OYmYpJLJ5+IS9257MBITMFBmQvZfD4N8jS4fJEHAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9ldNTxp; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9ldNTxp"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a98505364aso570264a12.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289196; x=1790893996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVsRJrHyMpTI40o+1Sz2mRcm/fZ436QtWx7E9HnX6zg=;
        b=I9ldNTxp0ZCbSEVTO1Y/AWola4I3jAJ15bFmUZbO7D+EM5eseVWwF6wykp4S3fjMT+
         saWUya4j1kz6EW7dEdVFP0uDoUVqmPSiSkYBbW3JzvKB8uzynJSDylcv++68OS0Bux0o
         QUuAOVzFrHJjmW9YLL65oI6P1fLfxfnYckriOu17ZnH/tHVPjGK1kMT8U7g1RTL2QVs6
         lpApcmpbvnXMbddPgQkjIzQPIkfH3j3AkqL6IsVUYRK3aTm5dP1VI10xoJnakXgipRh/
         QBDZwjmKbVTQgJs62j0IF+u3T5fJg1UnQ03ICA7dAEzg8lm2A3DdvS1Rm960FfykP++V
         q5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289196; x=1790893996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVsRJrHyMpTI40o+1Sz2mRcm/fZ436QtWx7E9HnX6zg=;
        b=SX9n0yQXtcRl0YspU5i4VM2j4WAsyRR0P5+32sFN7+a3zLlb2Jajk9WY1ZCVs69KdN
         kzZTyt4+P9ymYpADEpSQRCfnmEjs+dRh86QcKMmkgL5/SWXePNo1vsyH0zMp9HtSNzz3
         tvQVYTa8E06HtOopGs/t4PUzYvUZRXjaj13xkSBxi/Wx6DLjgCVzUEvlmiene8eki/Ji
         Yb75IpgHwZ0QlQ/iE0tXRSMia67TebLJKXVjYIfjihqLzVWGsXEcqYRjIpGt3CN+tYW8
         dl9cACE3381bh981JEfiLc+esv9duUZGuJEWThKI5NjOwnt2YkeIBF8xZ1oCnykixlZ0
         Xd/w==
X-Gm-Message-State: AFuF++laWVCsW93wRbfBnXbDJWL+H9vk2is3HP8MgeI7rkluu26J+qzd
	TLxLx03qKa4NUtKekFoBfGXamENsXf5zvGC7SmyJGhLE1UsYBlZ5/9bobKQoV8/q
X-Gm-Gg: AYBFou03xy8FmPKQ+XLBJrymE9joDDE50MH/opQKj0zeSvvhSpjHCvQ8Ir301vios+r
	ZD8UXXDHIkeQnUbY9I6ypd2z0Z1cm8ANxAcNptNgl8tq8Pe9YmZgzKf777OrCgRIQ8wxexPtdW/
	msEC+CaQrIdwRh5WCZ7wDaDYBG9NJ4RsYSPeGmEkxuKfP6TmoP4YsLeOxAhR5MhNP1Ouo8J/qXv
	8oD+YUlYQ0Qtf60dUACTI6phBpTe1DAUB4Jqct+7x/K5+hQnf5YnOAJ7syITXeBcnOtt4ftCGam
	L8dTxfzSpKzbS6ZdTUBRckioIHT90eDt7zmwHNz4rwS3n+Zji+PEWGLXC4BMXW04WKtqjhD6eIm
	HXXIuzMCG4ec/jo55hPf13gFnCYKKuWINiYGho9JLGOqbSt78+baAFwud73djRmeoTMCJxCLPxs
	To7xOe7alVoXFHDIRtE8a7klQeCJIeRVA2Y0ztPLaTqp2kRJWs+H3z6IOd8kFqlhmUWw4S5xJLD
	M4UhBniwAfV9GSg8h0X+p0zThM8T0sg/wco//61c6qvkI6GKEjG8Fo6zWjWYQQOOQ8Lj0o7mySR
	p7JW1lUJOhRuPPegtQVCNCqDE6y34YvzaquPe54JVOaolpJw
X-Received: by 2002:a05:6402:4391:b0:6aa:8d22:a8c3 with SMTP id 4fb4d7f45d1cf-6aac8e1073fmr3068923a12.0.1790289196297;
        Thu, 24 Sep 2026 15:33:16 -0700 (PDT)
Received: from localhost.localdomain ([37.31.48.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dd7dc5sm210791a12.21.2026.09.24.15.33.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 15:33:15 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH v6 1/1] refs: report old values to transaction hooks
Date: Fri, 25 Sep 2026 00:33:10 +0200
Message-Id: <2af3eeadd18806c5298d53072428656885cff89d.1790269745.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790269745.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790196627.git.maciej.ciemborowicz@gmail.com> <cover.1790269745.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference-transaction hook reports an all-zero old object ID whenever
the caller does not supply an expected old value. Consequently, batched
branch, tag, and remote-ref deletions report zero as both the old and new
object IDs because refs_delete_refs() intentionally queues unconditional
deletions.

Changing those callers to provide expected old values would make the
deletions conditional and alter existing command behavior. Instead, record
the current raw ref value separately for the hook. Read it before the
"preparing" hook, then refresh it after the backend has locked the refs so
that the "prepared" and later phases report the value protected by the
transaction's locks. Keep this value separate from old_oid and old_target so
it does not set REF_HAVE_OLD or otherwise constrain the update.

Only resolve these values when a reference-transaction hook exists. Preserve
symbolic refs as targets, consistent with the hook's existing symref format.
Document that an unlocked "preparing" value may differ from later phases if
the ref changes before it is locked.

Add coverage for batched branch deletion, tag deletion, and remote pruning.
Also exercise a concurrent update from the "preparing" hook to verify that
the deletion remains unconditional while later hook phases report the value
actually removed.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 Documentation/githooks.adoc      | 17 +++++----
 refs.c                           | 54 ++++++++++++++++++++++++---
 refs/refs-internal.h             |  8 ++++
 t/t1416-ref-transaction-hooks.sh | 64 +++++++++++++++++++++++++++++++-
 4 files changed, 128 insertions(+), 15 deletions(-)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..f60dd1d582 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -509,14 +509,15 @@ receives on standard input a line of the format:
   <old-value> SP <new-value> SP <ref-name> LF
 
 where `<old-value>` is the old object name passed into the reference
-transaction, `<new-value>` is the new object name to be stored in the
-ref and `<ref-name>` is the full name of the ref. When force updating
-the reference regardless of its current value or when the reference is
-to be created anew, `<old-value>` is the all-zeroes object name. To
-distinguish these cases, you can inspect the current value of
-`<ref-name>` via `git rev-parse`. During the "preparing" state, symbolic
-references are not resolved: `<ref-name>` will reflect the symbolic reference
-itself rather than the object it points to.
+transaction, or the value observed while preparing the transaction if no
+old object name was passed. `<new-value>` is the new object name to be
+stored in the ref and `<ref-name>` is the full name of the ref. When the
+reference does not exist, `<old-value>` is the all-zeroes object name.
+Because references are not yet locked in the "preparing" state, its observed
+old value may differ from the value reported in subsequent states if the
+reference changes before it is locked. During the "preparing" state,
+symbolic references are not resolved: `<ref-name>` will reflect the symbolic
+reference itself rather than the object it points to.
 
 For symbolic reference updates the `<old_value>` and `<new-value>`
 fields could denote references instead of objects. A reference will be
diff --git a/refs.c b/refs.c
index 92d5df5b71..d2d25402c3 100644
--- a/refs.c
+++ b/refs.c
@@ -1260,6 +1260,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
+		free(transaction->updates[i]->hook_old_target);
 		free((char *)transaction->updates[i]->rejection_details);
 		free(transaction->updates[i]);
 	}
@@ -2606,6 +2607,8 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 	struct transaction_feed_cb_data *feed_cb_data = pp_task_cb;
 	struct strbuf *buf = &feed_cb_data->buf;
 	struct ref_update *update;
+	const struct object_id *old_oid;
+	const char *old_target;
 	size_t i = feed_cb_data->index++;
 	int ret;
 
@@ -2619,12 +2622,18 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 
 	strbuf_reset(buf);
 
-	if (!(update->flags & REF_HAVE_OLD))
-		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
-	else if (update->old_target)
-		strbuf_addf(buf, "ref:%s ", update->old_target);
+	if (update->flags & REF_HAVE_OLD) {
+		old_oid = &update->old_oid;
+		old_target = update->old_target;
+	} else {
+		old_oid = &update->hook_old_oid;
+		old_target = update->hook_old_target;
+	}
+
+	if (old_target)
+		strbuf_addf(buf, "ref:%s ", old_target);
 	else
-		strbuf_addf(buf, "%s ", oid_to_hex(&update->old_oid));
+		strbuf_addf(buf, "%s ", oid_to_hex(old_oid));
 
 	if (!(update->flags & REF_HAVE_NEW))
 		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
@@ -2660,6 +2669,36 @@ static void transaction_feed_cb_data_free(void *data)
 	free(d);
 }
 
+static void resolve_transaction_hook_old_values(struct ref_transaction *transaction)
+{
+	struct ref_store *refs = transaction->ref_store;
+	struct strbuf referent = STRBUF_INIT;
+
+	if (!hook_exists(refs->repo, "reference-transaction"))
+		return;
+
+	for (size_t i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		unsigned int type = 0;
+		int failure_errno;
+
+		if (update->flags & (REF_HAVE_OLD | REF_LOG_ONLY))
+			continue;
+
+		oidclr(&update->hook_old_oid, refs->repo->hash_algo);
+		FREE_AND_NULL(update->hook_old_target);
+		strbuf_reset(&referent);
+
+		if (!refs_read_raw_ref(refs, update->refname,
+				       &update->hook_old_oid, &referent,
+				       &type, &failure_errno) &&
+		    (type & REF_ISSYMREF))
+			update->hook_old_target = xstrdup(referent.buf);
+	}
+
+	strbuf_release(&referent);
+}
+
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
@@ -2709,6 +2748,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	if (ref_update_reject_duplicates(&transaction->refnames, err))
 		return REF_TRANSACTION_ERROR_GENERIC;
 
+	resolve_transaction_hook_old_values(transaction);
+
 	/* Preparing checks before locking references */
 	ret = run_transaction_hook(transaction, "preparing");
 	if (ret) {
@@ -2720,6 +2761,9 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	if (ret)
 		return ret;
 
+	/* Refresh old values now that the references are locked. */
+	resolve_transaction_hook_old_values(transaction);
+
 	ret = run_transaction_hook(transaction, "prepared");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c3ac7b556f..a7471b2481 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -99,6 +99,14 @@ struct ref_update {
 	 */
 	struct object_id old_oid;
 
+	/*
+	 * The old value observed for the reference-transaction hook when the
+	 * caller did not provide an expected old value. Unlike old_oid and
+	 * old_target, these fields do not constrain the update.
+	 */
+	struct object_id hook_old_oid;
+	char *hook_old_target;
+
 	/*
 	 * If the new_oid points to a tag object, set this to the peeled
 	 * object ID for optimized retrieval without needed to hit the odb.
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 4fe9d9b234..fcc7404943 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -14,6 +14,66 @@ test_expect_success setup '
 	POST_OID=$(git rev-parse POST)
 '
 
+test_expect_success 'hook gets old values for batched unconditional deletion' '
+	test_when_finished "rm -f actual" &&
+	test_when_finished "git remote remove origin && rm -rf empty.git" &&
+	git init --bare empty.git &&
+	git remote add origin ./empty.git &&
+	git branch delete-a PRE &&
+	git branch delete-b POST &&
+	git tag delete-tag POST &&
+	git update-ref refs/remotes/origin/to-prune $PRE_OID &&
+	test_hook reference-transaction <<-\EOF &&
+		if test "$1" = committed
+		then
+			cat >>actual
+		fi
+	EOF
+	git branch -D delete-a delete-b &&
+	git tag -d delete-tag &&
+	git remote prune origin &&
+	cat >expect <<-EOF &&
+		$PRE_OID $ZERO_OID refs/heads/delete-a
+		$POST_OID $ZERO_OID refs/heads/delete-b
+		$POST_OID $ZERO_OID refs/tags/delete-tag
+		$PRE_OID $ZERO_OID refs/remotes/origin/to-prune
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'unconditional deletion remains unconditional' '
+	test_when_finished "rm -f actual" &&
+	test_when_finished "rm -f \"$(git rev-parse --git-path delete-race-once)\"" &&
+	git branch delete-race PRE &&
+	test_hook reference-transaction <<-\EOF &&
+		state=$1
+		while read -r old new ref
+		do
+			if test "$state" != aborted
+			then
+				case "$new" in
+				*[!0]*) ;;
+				*) echo "$state $old $new $ref" >>actual ;;
+				esac
+			fi
+		done
+		marker=$(git rev-parse --git-path delete-race-once)
+		if test "$state" = preparing && test ! -e "$marker"
+		then
+			>"$marker"
+			git update-ref refs/heads/delete-race POST
+		fi
+	EOF
+	git branch -D delete-race &&
+	cat >expect <<-EOF &&
+		preparing $PRE_OID $ZERO_OID refs/heads/delete-race
+		prepared $POST_OID $ZERO_OID refs/heads/delete-race
+		committed $POST_OID $ZERO_OID refs/heads/delete-race
+	EOF
+	test_cmp expect actual &&
+	test_must_fail git show-ref --verify refs/heads/delete-race
+'
+
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
@@ -65,7 +125,7 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID refs/heads/main
+		$PRE_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST <<-EOF &&
 		update HEAD $ZERO_OID $POST_OID
@@ -87,7 +147,7 @@ test_expect_success 'hook gets all queued updates in committed state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID refs/heads/main
+		$PRE_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST &&
 	test_cmp expect actual
-- 
2.39.3 (Apple Git-146)

