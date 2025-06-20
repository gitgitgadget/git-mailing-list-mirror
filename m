Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE420E309
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403756; cv=none; b=lJ8elT7Dvru/LgxfR3m2/FHkzqT3anukr9lLAilA7o/gF0ceGMvazNYG8DMoN0ehOM5xujBkX9HhPjV7M/wjHg8/Mw0yk9CXj0cd23ueMNPG2kuQYrPN7fi6bKCJLQ+iOjum0Ga1VXCdArMKhpIL2Haqh6aZZ4kvBoTVwXyLabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403756; c=relaxed/simple;
	bh=tT9ztQB5zA055hYEkrXj9u/CgQZf55Kp6s09ZZuNg+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KD57wQ45Ypc/PUjHS2sXghHTmzRU30q8q/kAumv4Tih2qHCwkV+hYWR15S6QLf5NXKUrb/PPmZ5OnbEubUmzXWTNoS/l1ZbVR3lCA54gGEeCbgM02GwozXlnRtJZBT5C+0yoLI+MB2X+VClIfix0A9uwvn8uLfuiAXY2aft6Jus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH5kru3O; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH5kru3O"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a52874d593so1396584f8f.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750403753; x=1751008553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpN0NduHPKzsTrIToGxJzFqugTeSLiFjLmF+GhGkjWk=;
        b=HH5kru3OMXgDRRYcTOlQdB+k0b8noACOzfdEFaqXcz0JnmCjFbcouVGzoIUGjR28FS
         Ejz9pOjBOPKck5ebCJ2B7OdTbgMfbKi10CaSG1tnrGLHR804GKpCxY0uIS/luBrqtcSW
         pVkLs206mK14s97duVDbRlzRFjdbWQCjGisx9XOIGve+Z9cbaJjpbnL8uytIbJZT0FJy
         yZ389gUdua+3KBSYFBY4OhWJTqunm5eM/W/xWHcTY0yBucIfLJ5oF7avCdy7nQklO2f2
         kG7XSBqwk839uTuFujOcM7FFqFpNhMFKwXqKcxvL5cZ1GrgZxBBeEOgbyusZfC0fE1bo
         9snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750403753; x=1751008553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpN0NduHPKzsTrIToGxJzFqugTeSLiFjLmF+GhGkjWk=;
        b=TpUCYio/NlI/06vIEbYXIt22LrsoZU1xz4IGnghb3yD2wt7i2ja/cTMlXfeCaUhtTh
         KkbbkQWHOxr3PCRoU5NUb9XrD47egPyygNdRTAX1srQvAD1VLCrki+DyzJuhCNrPfS4E
         6Kqokhe0bhOS+4KLX4LaNC1XpktGel9yM2hduChjgFM4/1SjX0vFk5cJw0vsyQGO4qN5
         gcumTXSBtNpXugKlaJFcq/9Pglg9zPEYXO/Rf2n3BpAT73BXIsq2RRjSJaUW5wcKdAJM
         d626KhIU7V7ppPXPkLhvdYtss/+VmgOVes8CrTJvAA3eXM2hA1lDb0VWQK/+CPgQHgvE
         0byA==
X-Gm-Message-State: AOJu0YxZO5yo/a5VtB4QsrinmQPgwcEOVFY1q5kddc32VATGUg3ei7SS
	O2GVRGx0i4gPZ7JbkgrtxkSdOXjeKijmOBBNhzfc/hnOcxvb99Er1vag1FjZqaUX3MI=
X-Gm-Gg: ASbGncsp6zeYIojGM3Tpqq7hA2B4Ce/kvfu8ZO60ovV0sBeznGVLlc2nqVYgykxH8/Q
	scXWcRpXe08NjmlONJYt00w37cwJEn6MUFow+v+RKzAs2Ch2kdXogb+Ky9I/lmDMyj4M24mywmn
	MDb3vdaCYxo9dyDMkXptq1EvCtZ9LHsHOez+TUZdOq3Jxj4ajBxrHx+F6swrVtadWPHaVKcv2YJ
	qqrCOldQkipbWaBZLn8WR8CBKVUG2WwxVL+wQQkDfJA8tMK4HAnC1+FMiHAw7j+9qvNUfL4rqjR
	FZpdyEazVIoXGZLSaeCQsCmclxaW3KeXtcUN78BqJknKyfcZNuD3X/Zf7VO1Wg8SvsryBMksny2
	DiR5qb3umy7vTlw6lEyA4oNTuDZa8KGKqg5w=
X-Google-Smtp-Source: AGHT+IF34nHPHR99GqmW36GGXSnboVAOoLVdyi+AMpY1BaO+ccO3O/xKzz733Cnd4XZYCCm6Ne5P8g==
X-Received: by 2002:a05:6000:310e:b0:3a4:d31e:4af3 with SMTP id ffacd0b85a97d-3a6d1307038mr1368563f8f.37.1750403752547;
        Fri, 20 Jun 2025 00:15:52 -0700 (PDT)
Received: from [127.0.0.2] (bmly-13-b2-v4wan-168438-cust286.vm4.cable.virginm.net. [86.24.93.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c66esm1217101f8f.47.2025.06.20.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:15:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 20 Jun 2025 09:15:45 +0200
Subject: [PATCH v5 2/2] receive-pack: handle reference deletions separately
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-2-f35ee6b59a82@gmail.com>
References: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
In-Reply-To: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6905; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=tT9ztQB5zA055hYEkrXj9u/CgQZf55Kp6s09ZZuNg+8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhVCqWxFXn+j6NPP5BJu1J2p0ssTOrU7eqEY
 GM615CvB0QJ6YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoVQqlAAoJED7VnySO
 Rox/sPML/jv9xMKZZszNqG0Wb/zXYPUY/8bbyIH5ooNVXqx9k9M67MqEVaDvNe1EzY1Y0bV2r/o
 PcJgVzFvxp1Z7yX7VMYDTrDtWAAxCRAbpaK41+ZneWEI+UUYVDmXdisqtLS0WtOdqy1cYn1UuQ9
 Z6Km1Q/tjJArYSpAgkIn/yhtEzefGvX2W74g6Vk8BIECzmcUNWfAhZY7kA1I8XsVr/Et3yEmRsi
 319IChqpa667fMiVzBxkuLfS4QBvgkUfonA5rJEMFimmvryomwqFJs2BJxKTkROn1GANyMtCmpN
 LMDtW/wKJiz2IVcgN0UAh4gh/OJpyHQ0IJQ+eOXi6BqlwMw2J5u0WWrb5sLklKvog18goLe6BHf
 cN2OFKmElqrzXXCeeYQ3AhTxIMZDSf8MQKYmNLgPGTrjqMpF87Dexc3ZXy9/W5QhsY1NUjhTeAj
 pc1kE5MQGIcjDhmRQP1Z+XQmSOnlclQEy90hmjjQD703SZxP7HTmL6gdPkWQTG3jzdu2qSmWam5
 ss=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
we updated the 'git-receive-pack(1)' command to use batched reference
updates. One edge case which was missed during this implementation was
when a user pushes multiple branches such as:

  delete refs/heads/branch/conflict
  create refs/heads/branch

Before using batched updates, the references would be applied
sequentially and hence no conflicts would arise. With batched updates,
while the first update applies, the second fails due to D/F conflict. A
similar issue was present in 'git-fetch(1)' and was fixed by separating
out reference pruning into a separate transaction in the commit 'fetch:
use batched reference updates'. Apply a similar mechanism for
'git-receive-pack(1)' and separate out reference deletions into its own
batch.

This means 'git-receive-pack(1)' will now use up to two transactions,
whereas before using batched updates it would use _at least_ two
transactions. So using batched updates is still the better option.

Add a test to validate this behavior.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 102 ++++++++++++++++++++++++++++++++-----------------
 t/t5516-fetch-push.sh  |  17 +++++++--
 2 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9e3cfb85cf..1809539201 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1867,47 +1867,81 @@ static void execute_commands_non_atomic(struct command *commands,
 	const char *reported_error = NULL;
 	struct strmap failed_refs = STRMAP_INIT;
 
-	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  REF_TRANSACTION_ALLOW_FAILURE, &err);
-	if (!transaction) {
-		rp_error("%s", err.buf);
-		strbuf_reset(&err);
-		reported_error = "transaction failed to start";
-		goto failure;
-	}
+	/*
+	 * Reference updates, where D/F conflicts shouldn't arise due to
+	 * one reference being deleted, while the other being created
+	 * are treated as conflicts in batched updates. This is because
+	 * we don't do conflict resolution inside a transaction. To
+	 * mitigate this, delete references in a separate batch.
+	 *
+	 * NEEDSWORK: Add conflict resolution between deletion and creation
+	 * of reference updates within a transaction. With that, we can
+	 * combine the two phases.
+	 */
+	enum processing_phase {
+		PHASE_DELETIONS,
+		PHASE_OTHERS
+	};
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
-			continue;
+	for (enum processing_phase phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd) || cmd->run_proc_receive)
+				continue;
 
-		cmd->error_string = update(cmd, si);
-	}
+			if (phase == PHASE_DELETIONS && !is_null_oid(&cmd->new_oid))
+				continue;
+			else if (phase == PHASE_OTHERS && is_null_oid(&cmd->new_oid))
+				continue;
 
-	if (ref_transaction_commit(transaction, &err)) {
-		rp_error("%s", err.buf);
-		reported_error = "failed to update refs";
-		goto failure;
-	}
+			/*
+			 * Lazily create a transaction only when we know there are
+			 * updates to be added.
+			 */
+			if (!transaction) {
+				transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+									  REF_TRANSACTION_ALLOW_FAILURE, &err);
+				if (!transaction) {
+					rp_error("%s", err.buf);
+					strbuf_reset(&err);
+					reported_error = "transaction failed to start";
+					goto failure;
+				}
+			}
 
-	ref_transaction_for_each_rejected_update(transaction,
-						 ref_transaction_rejection_handler,
-						 &failed_refs);
+			cmd->error_string = update(cmd, si);
+		}
 
-	if (strmap_empty(&failed_refs))
-		goto cleanup;
+		/* No transaction, so nothing to commit */
+		if (!transaction)
+			goto cleanup;
 
-failure:
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (reported_error)
-			cmd->error_string = reported_error;
-		else if (strmap_contains(&failed_refs, cmd->ref_name))
-			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
-	}
+		if (ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			reported_error = "failed to update refs";
+			goto failure;
+		}
 
-cleanup:
-	ref_transaction_free(transaction);
-	strmap_clear(&failed_refs, 0);
-	strbuf_release(&err);
+		ref_transaction_for_each_rejected_update(transaction,
+							 ref_transaction_rejection_handler,
+							 &failed_refs);
+
+		if (strmap_empty(&failed_refs))
+			goto cleanup;
+
+	failure:
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (reported_error)
+				cmd->error_string = reported_error;
+			else if (strmap_contains(&failed_refs, cmd->ref_name))
+				cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
+		}
+
+	cleanup:
+		ref_transaction_free(transaction);
+		transaction = NULL;
+		strmap_clear(&failed_refs, 0);
+		strbuf_release(&err);
+	}
 }
 
 static void execute_commands_atomic(struct command *commands,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dabcc5f811..1649667441 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
+		refs/heads/main $orgmain $newmain
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -808,8 +808,8 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
+		refs/heads/main $orgmain $newmain
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -868,10 +868,10 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
-		refs/heads/seen $orgseen $newseen
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
+		refs/heads/main $orgmain $newmain
+		refs/heads/seen $orgseen $newseen
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -1909,4 +1909,13 @@ test_expect_success 'push with config push.useBitmaps' '
 		--thin --delta-base-offset -q --no-use-bitmap-index <false
 '
 
+test_expect_success 'push with F/D conflict with deletion and creation' '
+	test_when_finished "git branch -D branch" &&
+	git branch branch/conflict &&
+	mk_test testrepo heads/branch/conflict &&
+	git branch -D branch/conflict &&
+	git branch branch &&
+	git push testrepo :refs/heads/branch/conflict refs/heads/branch
+'
+
 test_done

-- 
2.49.0

