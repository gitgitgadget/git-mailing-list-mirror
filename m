Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE66134CB
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111605; cv=none; b=jJrsNCCRAL9sMFb3hutR24sRdVWN3dhV+bv2b3bsiEvPq9BBzYRR7ygfmQsPRH+9ljoV04mm8squz9Xqr47ReqSy/9li4a22zm14PKnGv2t7YRsX2iPmcPpzw4nBnAis6ryA+CKtetEvidr1nvmXJXyNXcvzYuKid3BG/aIOkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111605; c=relaxed/simple;
	bh=9Kz1Lhv6z0uGmFSc6aEktbW3CUgGy+nWa7QcaWp74g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZubbxkGueFtBE2mWSXcpPWLrxYnfL8TKsYlpTc0SSDyHKhgg776K5S1reGp8tN1OV/DFocs2E0JhT06iPBAy0FJ5A7G2F2wzOAPKbNk8GR37EQXiiEatkGduq61TrVqBR+lLUD005PmokPeKqPv61DoG50Eo9jYbRn2rmPCwzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOtvN8ns; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOtvN8ns"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso3998535e9.2
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749111601; x=1749716401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnBz9Wedyh1HOoBpiwf90KCDelCL9FPbXHo526WzoPk=;
        b=NOtvN8nscGJhPsYxLR7Ha5G6GdcETPEywoR+XK9kij7IcqV0hMECm/he1aloNt08JO
         xg7HCr7UhNebfctcx8kV43FsCWWKWIRDtw+dz7jnVRK+EkJg6qLLQrzSlxvmm9/pJNpQ
         ZLnb5tTMclSZ+Srlovpys6Dogtl3+iAE7U/OLVimMU+eWgigRQcPBCWPBWw1QM2Uj+EL
         Hm2HYEgREmDK8IslnTjJUlaHUwM7+bPXgknhNsr7p8OkHss6TeRH5NACkymJYhfDF9c1
         YyGTjnnH0SDHPsQ1XYkW9abP3ZYRqlGuPY1eIhL2XbARTfkzsCXTS5wMu3ct1Ia1fRwQ
         b9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111601; x=1749716401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnBz9Wedyh1HOoBpiwf90KCDelCL9FPbXHo526WzoPk=;
        b=JkSXqJGcmrG/ioXjKcQRwj4XO8VkF8nMWmGG7y+ofWO5Vw8rD2IblLKfpZR1Gpd0QH
         qGqJSSukIBklq1j4MV3NOMFA3FP5uszwoCbrH8yXD1VkJzJKBdm0WnKzCtIEqRef2pgV
         WqM7vKFYHmFK3am3WgEB0qou1tY6NdlpFJ6wWlUYUK5eAPPFx5VCrh75oMccd/8HBj3T
         0+gISsRaFwhCwfTLlBPidvDG6+kG4bKmWEYaBx7F5FWpAvr0Vvl2L1BuZB19RzLheA33
         XrHsUzXV5xphCOZbwyfVA9pnkQD78Jp6y0dhzq2a2hunxzq+IPep2SKUq2CnWIcNNAjO
         1Agg==
X-Gm-Message-State: AOJu0YxZAVVxg/wkWuK5Jh2MwYnKSbQqeZf7n/ebIjtp4xOiNruPJROm
	gx85MuBp2ddIely237a5GXgdmyI00jTgRnodDe2VMaLkZDuKzJQG0aFO
X-Gm-Gg: ASbGnctVT7ZXzWLiZShi4LCZYzXneYgySXai3GCVNfUnuqyOTsKfGdtkIn11cPyECcF
	TyVIYO07dMSGF136HOUPWSs5XQnsRAN2jh6GVx4vxRxuquC2K4+8g3xMJiqYAQ/Ez9C4238iZ9+
	lRvAXE/seHcEwcFz+6G3kmexKPT/7AMYqBgiYPBTwbeLfIG52XUFqdBJSvKJLJCsjJx4T82FPaM
	4g65GglvvSyUEFJJnUU5tAzRx3HFTPQ4Xa4F4IJ2mIqvYh3avRX4ZkEXhVUvXfXSa4uqxD0G3Mr
	Dl9hMh/Rw5WIbALD/59A1S5WBK/xmFFV3207WpMlOzmUZA==
X-Google-Smtp-Source: AGHT+IEeNbXvGejeYbWeVJRmOzxjkZq98NzMNg25RgcqFOIs/371wkDFGR3G51GGHuGMRdICnbS1Bg==
X-Received: by 2002:a05:600c:4f0f:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-451fb60cffemr12611745e9.10.1749111601163;
        Thu, 05 Jun 2025 01:20:01 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7449:f1fe:b27a:8a6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb178379sm10194725e9.10.2025.06.05.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:20:00 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 05 Jun 2025 10:19:55 +0200
Subject: [PATCH v2 2/2] receive-pack: handle reference deletions separately
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-2-26cd05b8a79e@gmail.com>
References: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com>
In-Reply-To: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, sunshine@sunshineco.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7440; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9Kz1Lhv6z0uGmFSc6aEktbW3CUgGy+nWa7QcaWp74g0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhBUy5IBz5ywYFQG+iiIE34aQzj7K7uAQJmM
 kKjcWzb8sNyrIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoQVMuAAoJED7VnySO
 Rox//twL/jMYDtrY78KABawl+w3WjJIQ73yaJlznmRW1yT0VeBhqBV6TcjSuLmE5OTq9mXJNAIa
 h9MLrDmLVLP4LkaQ48nr67ZCS7oCul5be/pYfbIeexzUAMhpzJFQHIWK8DjDkFhIuKyYF07Fzh1
 jQajeTJMh9Z2Ao08gippTChb6oTd2TKnuGxsoPRbOg2ffW7SoJYjmyajL+ZzpmhEQh1w4ZyjcKG
 QTHEAugEwzg/8A5WbgltVHNOUTuXTnAbs4A9ODINxxo9UPSuy+rTbsylvzqZL9vaL/cawApQGpx
 Sv4NoWoo3ZvGv/fqSbKhFuxOtAAjJqAIv8rYbthKaCohwk78PSr09XbypV37VquD4hliJFl0fG/
 sT8jaSsce+pKEDrzQFhXUDHG5WV14OLO115YzD9qHfWnoOWKpDr4lkLGpE6IGav6uwsQvPnT5aD
 9ztNaU5qho40VDAfhDMXEzsZZvoijTXb/VCOkW7BWdjr5WcpMjb+h1zSmdknidvFxDcsUbhgcV5
 B8=
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
while the first update applies, the second fails due to F/D conflict. A
similar issue was present in 'git-fetch(1)' and was fixed by using
separating out reference pruning into a separate transaction. Apply a
similar mechanism for 'git-receive-pack(1)' and separate out reference
deletions into its own batch.

This means 'git-receive-pack(1)' will now use exactly two transactions,
whereas before using batched updates it would use _at least_ two
transactions. So using batched updates is the still the better option.

Add a test to validate this behavior.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c           | 90 +++++++++++++++++++++++++---------------
 t/t1416-ref-transaction-hooks.sh |  2 +
 t/t5516-fetch-push.sh            | 17 ++++++--
 3 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9e3cfb85cf..34db4377ca 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1867,47 +1867,66 @@ static void execute_commands_non_atomic(struct command *commands,
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
+	 * Reference updates, where F/D conflicts shouldn't arise due to
+	 * one reference being deleted, while the other being created
+	 * are treated as conflicts in batched updates. This is because
+	 * we don't do conflict resolution inside a transaction. To
+	 * mitigate this, delete references in a separate batch.
+	 */
+	enum processing_phase {
+		PHASE_DELETIONS,
+		PHASE_OTHERS
+	};
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
-			continue;
+	for (int phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {
+		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+							  REF_TRANSACTION_ALLOW_FAILURE, &err);
+		if (!transaction) {
+			rp_error("%s", err.buf);
+			strbuf_reset(&err);
+			reported_error = "transaction failed to s1tart";
+			goto failure;
+		}
 
-		cmd->error_string = update(cmd, si);
-	}
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd) || cmd->run_proc_receive)
+				continue;
 
-	if (ref_transaction_commit(transaction, &err)) {
-		rp_error("%s", err.buf);
-		reported_error = "failed to update refs";
-		goto failure;
-	}
+			if (phase == PHASE_DELETIONS && !is_null_oid(&cmd->new_oid))
+				continue;
+			else if (phase == PHASE_OTHERS && is_null_oid(&cmd->new_oid))
+				continue;
 
-	ref_transaction_for_each_rejected_update(transaction,
-						 ref_transaction_rejection_handler,
-						 &failed_refs);
+			cmd->error_string = update(cmd, si);
+		}
 
-	if (strmap_empty(&failed_refs))
-		goto cleanup;
+		if (ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			reported_error = "failed to update refs";
+			goto failure;
+		}
 
-failure:
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (reported_error)
-			cmd->error_string = reported_error;
-		else if (strmap_contains(&failed_refs, cmd->ref_name))
-			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
-	}
+		ref_transaction_for_each_rejected_update(transaction,
+							 ref_transaction_rejection_handler,
+							 &failed_refs);
 
-cleanup:
-	ref_transaction_free(transaction);
-	strmap_clear(&failed_refs, 0);
-	strbuf_release(&err);
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
+		strmap_clear(&failed_refs, 0);
+		strbuf_release(&err);
+	}
 }
 
 static void execute_commands_atomic(struct command *commands,
@@ -2024,6 +2043,9 @@ static void execute_commands(struct command *commands,
 	/*
 	 * If there is no command ready to run, should return directly to destroy
 	 * temporary data in the quarantine area.
+	 *
+	 * Check if any reference deletions exist, these are batched together in
+	 * a separate transaction to avoid F/D conflicts with other updates.
 	 */
 	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
 		; /* nothing */
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index d91dd3a3b5..b2aaa1908f 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -119,6 +119,8 @@ test_expect_success 'interleaving hook calls succeed' '
 	EOF
 
 	cat >expect <<-EOF &&
+		hooks/reference-transaction prepared
+		hooks/reference-transaction committed
 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
 		hooks/reference-transaction prepared
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

