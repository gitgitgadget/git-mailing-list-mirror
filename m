Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E531FFC50
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111604; cv=none; b=ZqkJeOBQ/NxmFmU52NiHIFY44w1VChqIuxADkVAFyYqpq63YG0hvgRtbsyFUSVUxvL4PuNsF4FYQiJIpUJI2Y4hiHe84nj2C/B4Xg+TxJpjaB2UTEA/zvEq1+l/iDGQiM8CjXcUxSVXFgXdlTQ9mgON6Gl941FET4CzRMJKbCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111604; c=relaxed/simple;
	bh=otJGhNiThf5O8c61S4VPmiPUqgWpz4UIfonwknaha+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=D9268B0cuZx8+a3Uzxj1vIHu1jbOxbOuXmzdQgWjHAGHKQ/W6ARoqpQGJXI5cFisH+hiYVLWuLrTkILlijpBKY8Ko5F6bIGfdfi7rezupoLFAOmer0vd/p+bo8mpqOYPbGzN+k5puiFoHPkNVsveVxJM9QEPZ7WVMEUrHEMYf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjqmPTlM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjqmPTlM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so7171305e9.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 01:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749111600; x=1749716400; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Av1HdUTjR7mOwMbZ3PiWvVYk9Etz0kYj61cM56wQeA=;
        b=fjqmPTlM9w/sElMFKDxh5vYGRHZBcdwNI2cZHO3AMnZWjFxzHPIggPrUHVQ3sZcjzL
         QECOhZEHjV8UVVyJuqTviIm0L02Prqjh1VGJydvwAReE3FT8tObnmaJGHq/4YOMKcdhO
         dMzIMTnaPFGS3t27JPy1OkQwqvayKGWi4YdlctkVCOkWyFYLgoFTwbCj//Y8u3ro1/HM
         zuFgzG0STw4QSVC9mr9Of9f4IIjpesBElbATXetK6KfAiZgNVuvlFKKzTYXZD0RAzHjD
         eb+SFA8zs0vkBYBRFV2mroVxB16VP6A5IAbccsUHvlXhuFd/P+KnV1T7k15F5WjK0IyC
         UB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111600; x=1749716400;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Av1HdUTjR7mOwMbZ3PiWvVYk9Etz0kYj61cM56wQeA=;
        b=fF34SHuOf5S1QYJJ7PXLuotMWGUcNbneQ7sei9NoITDByV8vtzZ46FIUYyKTqYyPCa
         7Z3oWqi6eScoGDmUbMfmQfCH/9vlzNHPALgGG8xT0207o05BjbmUXvjEQXjHHPBT5tZa
         r2ZTy02BeRgm4bYfmkQWOTMW9Yrx5QKANXgaJB41HAZO5WpydTEGfGYJyhJAqJaD2QeW
         WZ8dvTYY2G49n5b361oUSx0NGNNnuqrOVGgjrKrKP1hJ8ABpte9FtiANmz7l0oTSVMyr
         Nh1GFsBFWzHloFM/rtzveVYx0fZgGD1lmWcrc0141issgl85MfaDbf+4HPQFropmPUhV
         SvoQ==
X-Gm-Message-State: AOJu0YwiN+Xq9Gc6FM8nsfvvzevWIfQ+uEbZuAfN/13c9mXhay9/FPc/
	lXxyoZ98ieVYn76+UpYIX53gUTItxChjxi+G/i8XZxESdHQw73lQvr5p
X-Gm-Gg: ASbGncslglOddi1H0qOv/2ybTB1L4oo6BchJoUVyJlEi1Cc+T4SfIwwggoKyvdJTJDG
	rLp1r8QZNeOK8uylE4XfGIqSVMsHT9L9QZatt94I8WZNd6vp1b8HRFieqn1j91tMDEiZ7EVHFnE
	zaJliASnzGBCuyOuTSN+HB5hWgM37JJQGQSCmPz8h/QsekC6rAE/61XsnCFXA4vMR71sLxBwkuq
	FzxH1UP/Ix44ISF8cOD2xweOzzgxPRuiosuGkPLtJjtCoXLsXIGJ1Zl1RQ0pwMyhgu5SzOk45FE
	AbEtvHApUKnMKKjrI2PsaTh7YPpBIpvoprfvun+bME0udA==
X-Google-Smtp-Source: AGHT+IEJ75SnajKnC0j99YybI+1mOOuxFLPyRCdqE7QtBicP+uAp5fGz/btZhlS9o0FFALgmWNd3IQ==
X-Received: by 2002:a05:600c:35cf:b0:450:cde3:f266 with SMTP id 5b1f17b1804b1-451f0b270f0mr53989635e9.22.1749111599621;
        Thu, 05 Jun 2025 01:19:59 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7449:f1fe:b27a:8a6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb178379sm10194725e9.10.2025.06.05.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:19:59 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/2] refs: fix some bugs with batched-updates
Date: Thu, 05 Jun 2025 10:19:53 +0200
Message-Id: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClTQWgC/7WOTQ7CIBCFr2JYOwboj60r72G6oDAUEksN0Mam6
 d0d6xnczTd5ee/bWMLoMbHbaWMRF5/8FAjk+cS0U2FA8IaYSS4rXskG6mvdgjImYkqQMWWwyj9
 nQvABskMI+M7QRxW0A63mhAb6FXqVtaMzosWIQSPML6OoAGRpbVXUDRdlyWj3RRH/PpweHbHzK
 U9xPRQX8f3+bGou/2CzCODQ8sII0xdWcLwPI1Ve9DSybt/3D7dR03cyAQAA
X-Change-ID: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, sunshine@sunshineco.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11709;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=otJGhNiThf5O8c61S4VPmiPUqgWpz4UIfonwknaha+g=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhBUy5hUvcmk/UbXpIKC/M/JrruT/3T7bgQa
 1AGjVTPvJ9kLYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoQVMuAAoJED7VnySO
 Rox/LZIL/2tbAq7+Z2keBemCNBWt23yZ9vMufmFYxxetPzLuwu3DO9JShXmkoRllc90UE0d/svx
 7JidWzZPZ43JeiBJBV4flRPCnxzW8Cvtxl31ROaMWGTaP315LPU/cWSuqQ42QRYhQyZXwbyM6Ux
 QCq55ghn5SogjK7n9+18Zf/gaOjqXG8Ge3qmA17djWNT5bLx+LmkTyewn/6cVrr/znTAqSqDUTc
 Id8QBnVkDVVSqxQwOYMEdfGUd1FzejZhm7ehljmF5zw9jWdPdYcqk4q/BwcVd8JvEwBZdTjQ2vr
 6xFWvduCXkJiF4Im6T8pkDxJPEmm8He4gNt3lwXYjP3MIFdzTEo+kVMAaCzNoskZpOrthGtxqv0
 B4/Tm2INiGLyaYrtzrYFc97iGRrVvBmcSJw7S0B1AF1mHgB+OWxf8xsQUG8QcF1p38HsuiOEHkc
 m4F8uIHpC8O2K0xHZd9dT3cXO4nvzdpHcz2vghJoPI/llCaVf0BWshgiwtjU5ExZ0kcraRwXsp5
 rI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08) we introduced a mechanism to batch reference updates. The
idea being that we wanted to batch updates similar to a transaction, but
allow certain updates to fail. This would help reference backends
optimize such operations and also remove the overhead of processing
updates individually. Especially for the reftable backend, where
batching updates would ensure that the autocompaction would only occur
at the end of the batch instead of after every reference update.

As of 9d2962a7c4 (receive-pack: use batched reference updates,
2025-05-19) we also updated the 'git-fetch(1)' and 'git-receive-pack(1)'
command to use batched reference updates. This series fixes some bugs
that we found at GitLab by running our Gitaly service with the `next`
build of Git.

The first being in the files backend, which missed skipping over failed
updates in certain flows. When certain individual updates fail, we mark
them as such. However, we missed skipping over such failed updates,
which can cause a SEGFAULT.

The other is in the git-receive-pack(1) implementation when a user
pushes multiple branches such as:

  delete refs/heads/branch/conflict
  create refs/heads/branch

Before using batched updates, the references would be applied
sequentially and hence no conflicts would arise. With batched updates,
while the first update applies, the second fails due to F/D conflict. A
similar issue was present in 'git-fetch(1)' and was fixed by using
separating out reference pruning into a separate transaction. Apply a
similar mechanism for 'git-receive-pack(1)' and separate out reference
deletions into its own batch.

This is based off master 7014b55638 (A bit more topics for -rc1,
2025-05-30), with the changes from kn/fetch-push-bulk-ref-update merged
in.

---
Changes in v2:
- Modify the test in the first commit to no longer do a quiet grep,
  and some more tests.
- Remove the second commit as it was unnecessary.
- Modify the commit message in the last commit, to also talk about how
  we now use 2 transactions at minimum but this is still better than
  before.
- Modify the logic in the last commit to no longer use an XOR and
  instead loop over the two different scenarios (deletion updates, other
  updates).
- Link to v1: https://lore.kernel.org/r/20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com

---
 builtin/receive-pack.c           | 90 +++++++++++++++++++++++++---------------
 refs/files-backend.c             |  7 ++++
 t/t1400-update-ref.sh            | 45 ++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh |  2 +
 t/t5516-fetch-push.sh            | 17 ++++++--
 5 files changed, 123 insertions(+), 38 deletions(-)

Karthik Nayak (2):
      refs/files: skip updates with errors in batched updates
      receive-pack: handle reference deletions separately

Range-diff versus v1:

1:  1c0ea8e209 ! 1:  65bcb5d2cf refs/files: skip updates with errors in batched updates
    @@ t/t1400-update-ref.sh: do
      		)
      	'
     +
    ++	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
    ++		git init repo &&
    ++		test_when_finished "rm -fr repo" &&
    ++		(
    ++			cd repo &&
    ++			test_commit c1 &&
    ++			head=$(git rev-parse HEAD) &&
    ++			git symbolic-ref refs/heads/symbolic refs/heads/non-existent &&
    ++
    ++			format_command $type "delete refs/heads/symbolic" "$head" >stdin &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
    ++			test_grep "reference does not exist" stdout
    ++		)
    ++	'
    ++
    ++	test_expect_success "stdin $type batch-updates delete with incorrect old_oid" '
    ++		git init repo &&
    ++		test_when_finished "rm -fr repo" &&
    ++		(
    ++			cd repo &&
    ++			test_commit c1 &&
    ++			git branch new-branch &&
    ++			test_commit c2 &&
    ++			head=$(git rev-parse HEAD) &&
    ++
    ++			format_command $type "delete refs/heads/new-branch" "$head" >stdin &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
    ++			test_grep "incorrect old value provided" stdout
    ++		)
    ++	'
    ++
     +	test_expect_success "stdin $type batch-updates delete non-existent ref" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
     +			git update-ref $type --stdin --batch-updates <stdin >stdout &&
    -+			test_grep -q "reference does not exist" stdout
    ++			test_grep "reference does not exist" stdout
     +		)
     +	'
      done
2:  5c21a3770e < -:  ---------- t5516: use double quotes for tests with variables
3:  38eb79bd41 ! 2:  e65b29b5f1 receive-pack: handle reference deletions separately
    @@ Commit message
         similar mechanism for 'git-receive-pack(1)' and separate out reference
         deletions into its own batch.
     
    +    This means 'git-receive-pack(1)' will now use exactly two transactions,
    +    whereas before using batched updates it would use _at least_ two
    +    transactions. So using batched updates is the still the better option.
    +
         Add a test to validate this behavior.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static void ref_transaction_rejection_handler(const char *refname,
    +@@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *commands,
    + 	const char *reported_error = NULL;
    + 	struct strmap failed_refs = STRMAP_INIT;
    + 
    +-	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
    +-						  REF_TRANSACTION_ALLOW_FAILURE, &err);
    +-	if (!transaction) {
    +-		rp_error("%s", err.buf);
    +-		strbuf_reset(&err);
    +-		reported_error = "transaction failed to start";
    +-		goto failure;
    +-	}
    ++	/*
    ++	 * Reference updates, where F/D conflicts shouldn't arise due to
    ++	 * one reference being deleted, while the other being created
    ++	 * are treated as conflicts in batched updates. This is because
    ++	 * we don't do conflict resolution inside a transaction. To
    ++	 * mitigate this, delete references in a separate batch.
    ++	 */
    ++	enum processing_phase {
    ++		PHASE_DELETIONS,
    ++		PHASE_OTHERS
    ++	};
    + 
    +-	for (cmd = commands; cmd; cmd = cmd->next) {
    +-		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
    +-			continue;
    ++	for (int phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {
    ++		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
    ++							  REF_TRANSACTION_ALLOW_FAILURE, &err);
    ++		if (!transaction) {
    ++			rp_error("%s", err.buf);
    ++			strbuf_reset(&err);
    ++			reported_error = "transaction failed to s1tart";
    ++			goto failure;
    ++		}
    + 
    +-		cmd->error_string = update(cmd, si);
    +-	}
    ++		for (cmd = commands; cmd; cmd = cmd->next) {
    ++			if (!should_process_cmd(cmd) || cmd->run_proc_receive)
    ++				continue;
    + 
    +-	if (ref_transaction_commit(transaction, &err)) {
    +-		rp_error("%s", err.buf);
    +-		reported_error = "failed to update refs";
    +-		goto failure;
    +-	}
    ++			if (phase == PHASE_DELETIONS && !is_null_oid(&cmd->new_oid))
    ++				continue;
    ++			else if (phase == PHASE_OTHERS && is_null_oid(&cmd->new_oid))
    ++				continue;
    + 
    +-	ref_transaction_for_each_rejected_update(transaction,
    +-						 ref_transaction_rejection_handler,
    +-						 &failed_refs);
    ++			cmd->error_string = update(cmd, si);
    ++		}
    + 
    +-	if (strmap_empty(&failed_refs))
    +-		goto cleanup;
    ++		if (ref_transaction_commit(transaction, &err)) {
    ++			rp_error("%s", err.buf);
    ++			reported_error = "failed to update refs";
    ++			goto failure;
    ++		}
    + 
    +-failure:
    +-	for (cmd = commands; cmd; cmd = cmd->next) {
    +-		if (reported_error)
    +-			cmd->error_string = reported_error;
    +-		else if (strmap_contains(&failed_refs, cmd->ref_name))
    +-			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
    +-	}
    ++		ref_transaction_for_each_rejected_update(transaction,
    ++							 ref_transaction_rejection_handler,
    ++							 &failed_refs);
    + 
    +-cleanup:
    +-	ref_transaction_free(transaction);
    +-	strmap_clear(&failed_refs, 0);
    +-	strbuf_release(&err);
    ++		if (strmap_empty(&failed_refs))
    ++			goto cleanup;
    ++
    ++	failure:
    ++		for (cmd = commands; cmd; cmd = cmd->next) {
    ++			if (reported_error)
    ++				cmd->error_string = reported_error;
    ++			else if (strmap_contains(&failed_refs, cmd->ref_name))
    ++				cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
    ++		}
    ++
    ++	cleanup:
    ++		ref_transaction_free(transaction);
    ++		strmap_clear(&failed_refs, 0);
    ++		strbuf_release(&err);
    ++	}
      }
      
    - static void execute_commands_non_atomic(struct command *commands,
    --					struct shallow_info *si)
    -+					struct shallow_info *si,
    -+					int only_deletions)
    - {
    - 	struct command *cmd;
    - 	struct strbuf err = STRBUF_INIT;
    -@@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *commands,
    - 	for (cmd = commands; cmd; cmd = cmd->next) {
    - 		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
    - 			continue;
    -+		if (only_deletions ^ is_null_oid(&cmd->new_oid))
    -+			continue;
    - 
    - 		cmd->error_string = update(cmd, si);
    - 	}
    + static void execute_commands_atomic(struct command *commands,
     @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	/*
      	 * If there is no command ready to run, should return directly to destroy
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	 */
      	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
      		; /* nothing */
    -@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    - 			    (cmd->run_proc_receive || use_atomic))
    - 				cmd->error_string = "fail to run proc-receive hook";
    - 
    --	if (use_atomic)
    -+	if (use_atomic) {
    - 		execute_commands_atomic(commands, si);
    --	else
    --		execute_commands_non_atomic(commands, si);
    -+	} else {
    -+		/*
    -+		 * Reference updates, where F/D conflicts shouldn't arise due to
    -+		 * one reference being deleted, while the other being created
    -+		 * are treated as conflicts in batched updates. This is because
    -+		 * we don't do conflict resolution inside a transaction. To
    -+		 * mitigate this, delete references in a separate batch.
    -+		 */
    -+		execute_commands_non_atomic(commands, si, 1);
    -+		execute_commands_non_atomic(commands, si, 0);
    -+	}
    - 
    - 	if (shallow_update)
    - 		BUG_if_skipped_connectivity_check(commands, si);
     
      ## t/t1416-ref-transaction-hooks.sh ##
     @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '


base-commit: 931c39f05e078e0df968a439379cb04b5c4666ef
change-id: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144

Thanks
- Karthik

