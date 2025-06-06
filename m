Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36882857E6
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749199293; cv=none; b=hmQc7thI1TNFLb2cQubSm1jaVyfUUQWp7TIIhBy/kq6F/JaFysW5uG9h4v8m4lqfoKlFIP7rbr/sVMLQCfJVnq9nw7M9udh1afJjNBIQYwXkXt1QBNxjb4wZ+FU63QLpHWcyO5LiJ16T690GzlzU/bcn1ayeA8LmYE50H2J/eNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749199293; c=relaxed/simple;
	bh=LFsFcyMNuAbq2Sqm8X37nIY2ukDVJAk0JXAwDg6eurA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXbUZI+DUSpu7HtzgnZsIAiv3WUirtbjTJRPKP1Ds/xvI8EHJHeuC6azw+Xd7W2/ydY2JmrtAtQknvobIw69eqQ+KNHaTHouRLcFNNWOgV5fFdZkV1B3ssvAOfIbNq6lOZbLuHuTK9cdtCy9TFnf33DCSWYgzIj/qddOz0tSrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNtnLtBE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNtnLtBE"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6077e0f2697so647624a12.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749199290; x=1749804090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU/mJ4DPLgei9StXHjujOtx3JzUuQxQ+Dqzl4Xko23w=;
        b=jNtnLtBEChBav3dirIdb+bDcsKuneWrFXbJnQNH33OnVuMWbQAqZqaqtfggiLb4SzU
         ao9oiQz+4NX6EluYhr1t28sPh+MRx8vjDatUWWjHmyfzX+GZru//2jxHNG1WRvCwVsSM
         nvy2NC4EHmdiTUYlIQ/PTlNx/Rli0yfYPdaZUD39tvXEwBU1TJ640SoAhlaZ7ew+x8rH
         Gul4k00NrPhspEHgXujXUiIH94A0fVyVr9L1TAhTVUNHbRfOeRWMxPa2JxumYX7dBhXd
         iPTT/bMDGOtyJGbPbS5Q0NfjZ9cRd4y0s4xFQOPMfZkPUiblf+gH6O9uvPcmbNL0qk3A
         ZEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749199290; x=1749804090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU/mJ4DPLgei9StXHjujOtx3JzUuQxQ+Dqzl4Xko23w=;
        b=ZToauLCDqJeA83NXniT8AeAGjj7+6H9flBLW5tvkTcFztqk+SUPeMf0+OzHFsgkVC4
         aRI0aUYCaCja1RqwcL0ZyH1tXfocBZHwyqwP9CoZne1pVRk8di6/pkwR0c88p8NaPpwo
         RFCtMpi+foTJfvFUPekALbzYv+fdrMq3Z+y8AtsRxMI5Yq7prc9lD9Qf+hKmJQO4pxln
         Yj/VSwchrpNhCmC3WXR6/i1s4Yw5+3xJF50ncI1+4DP+s1ikvOv0bsosoBYaQ5j2h/E0
         dszJo9riobcej+Oz5AIlj5Con8MATI7W/C8qkeDllofSfnO4KkrIxuVtskffWTLYXotl
         YsuA==
X-Gm-Message-State: AOJu0Yxab1OI70eMn1oDO+x+jIPQNrZq40fD4GmZQi/XykYvtt+supqa
	a2JR//ZeoxeJAE5RdVArGoBgDDQ6BwRLhB35wbPIvTKB/O8ZgXSguPoz
X-Gm-Gg: ASbGncv4o2uZKOmAKOJDAGKabPJADIMjIxeOV/RZcfxKIHQSB7Ed5SeFmXa+MeX2naX
	133VR+f+4Gwm9rPwZwmdewAiO07fw1FqG7muMbd+pKrG91jjIrM3mTTU+7kbPVLD69Nh7+6Dxwh
	d4Jc8kEQEvSwqZG/kfEDg/8k7Tq2iqpTV5+Cb3AyNe4mbpP5Z2p4L3P22dD7CQXxj5DfYVdgEhi
	+8POsuFcOyzyYB+dGbsJZSRwwYS5+NPML+1WOZeOWD/ML7pfEOwJ29J45n02/5BRELIyJkjgnuH
	4j5rcVnTC1uXyyhr3X9coTyed82j+OcCIp8=
X-Google-Smtp-Source: AGHT+IFKSnFJwDd4iLrDRaow7iz+3pi5rb0JwSHWmK2gGMzG+S0PP/e+5thXPEI6gTJ3CioD9jH7uQ==
X-Received: by 2002:a05:6402:164d:b0:607:77ed:3629 with SMTP id 4fb4d7f45d1cf-60777ed3639mr1291758a12.1.1749199290248;
        Fri, 06 Jun 2025 01:41:30 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:1baf:dad2:9556:ca27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e654asm706910a12.69.2025.06.06.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 01:41:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 06 Jun 2025 10:41:11 +0200
Subject: [PATCH v3 2/2] receive-pack: handle reference deletions separately
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-2-e1c41693bd35@gmail.com>
References: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
In-Reply-To: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6717; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=LFsFcyMNuAbq2Sqm8X37nIY2ukDVJAk0JXAwDg6eurA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhCqa8DGmxgz53qrKUNDbB5SNoQFmvEo8Gia
 hpFCXwN5aLN/okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoQqmvAAoJED7VnySO
 Rox/3IYL/RlQl6DisKRlYQrCXvHZ8UAtr3EWVCtFFbY6oovUUETKkGtUIlxPy/uwC4VKUs44Y1f
 N3n63Ov0xetu3eXTEfmDKadcde/Gw0bOqkhRKb2g7P6hvqJY15wG1FXDwayuNDWBIRprBj7G/Ld
 nCLQYt87E3/N+mwlDaypwbbO5xpUMz16Ebj8aOyO4i1Nl74/SQXn7QTs3FKx8AHwfsUUBJ+OUPW
 fLpPET1CEyTgPHBsx4h5lEFM6r7CIMMOyxbO/di8DTZBqor/G67MFuDKYqnaoOidN7kqfl/fwcK
 I+5gPHEf0rf/B1ZBkkaf3w4fdDShKTnXc6e3BqbjVJxx/baSMoJIe4sJ2QN0z+AnDcauwNWsKGY
 zQCBbwYo3sPWNBmxSSgrO3LNF5pPF0PCAfwyphsTt92yr6IMIjksQHUm43F1GXD1xh0EVZf8gZE
 piBYlXRODpa/iYyCByCEwUJUsXTGbMEiRBHB4tXciRFxWp62jqFSUeUaeXsLYb2UIyMxYk74c84
 iI=
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

This means 'git-receive-pack(1)' will now use upto two transactions,
whereas before using batched updates it would use _at least_ two
transactions. So using batched updates is still the better option.

Add a test to validate this behavior.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 100 ++++++++++++++++++++++++++++++++-----------------
 t/t5516-fetch-push.sh  |  17 +++++++--
 2 files changed, 79 insertions(+), 38 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9e3cfb85cf..8ee792d2f8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1867,47 +1867,79 @@ static void execute_commands_non_atomic(struct command *commands,
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
+					reported_error = "transaction failed to s1tart";
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
+		/*
+		 * If no transaction was created, there is nothing to commit.
+		 */
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

