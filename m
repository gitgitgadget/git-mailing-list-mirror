Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA63E30E85C
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403754; cv=none; b=YGBnYxSO/nfXZTDE4NBBqWgPjNZtG8WKzWDRELR+1MU8+oJqO6RWbYa7swRDa64+dC/4y58Xuim7/o4bYAFbUmL2zdNbBzTVlQW5+N70QYTBTSXGx5WA5TGsVTuumsPBysqnF7S6iAGYN4CVf7XNSaSpscNDXI4Ob7+ElIJTBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403754; c=relaxed/simple;
	bh=aMVfZDW5429oXP1dVXIUHnlii4jM4oTsYwkWM6kDrrQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CSUtwTn5kLMS8YWKoVswK0BIMiOzpqpLkpKJ+gpocy//s7v24Uz4Clt0vyEr236Gi5nPu+Jxv7m9uUYaIWqw9EZyw/mzhF8Tv748lsMQ+n5kgHZ6yCzYp0XE/IGrk3tEICHystTdHugfxQEke2tPdIJDygnW5xsSw1e/HMLw+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifiDCB2w; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifiDCB2w"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375e72473so685149f8f.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750403751; x=1751008551; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DP0A9uQmIkGjyt7EHY8pTHNZ4eNuWWpnNoxbLq+v2/g=;
        b=ifiDCB2w/x+2i0r6tkJgpNnK9VIhnjBjg70rLubqWtfEtjsi9m++77KjMp/kyoCUc8
         nQ8tXPK7jJVXnC/JrbcQMUKjGuq+gT1+y5YQqedzh68mDPwjula/w+jYqMMO6oyWEF9Z
         Jwvb+v9LGcATjc8YlTdvmPQrZ5ZVXp/eS48OyrYiizGST7fHgXWDj4dO1HtzceCNCrGH
         HZF2QwpB/Z3fO+zXBI31wkppIzDiTEaZ5W08e0ztEoquPRO+ugoxMasxVBbpzejHZZHx
         VbqgDko/qx9ip6ekV49hZL4ucHomsLBW9BYJ4CscA2o2NzzguIvUc2TEbCXWTI7N9c48
         jMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750403751; x=1751008551;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DP0A9uQmIkGjyt7EHY8pTHNZ4eNuWWpnNoxbLq+v2/g=;
        b=gdtEXgYQpSGFLUcMPgnbPJYZzNa4G3wA5E+Bsmbul+3j1r5RWbd1BE9Uacy2PABlVn
         Yoh6Rx9SZDErxw7dKZwU58t1QhYfPJ2NwSe/T7dyqGbd7S3VuEhAsnnyDfhETllA12Lk
         groIa7hepCnSFS9099b2gy0dnaJYn6RavE889zNMDSjArcRBP9wrkDsgBD2ZSZLpcow/
         GHnkZegjeXFHr7k74B0mv50j2ojsYNLk2LF5jw/iMn4nWoraJmuZEMJCocMUnzQJ9Ne1
         BxgTqIapUhiso6wTs3ba+m1DBWRDRIbDX2USIavMXH/p/mLhVxKutmH3Pw+FBvc/QXoL
         xKZQ==
X-Gm-Message-State: AOJu0Yw1nfeq0vzLpRs+wgfeiPn352zeVbbeKEJ9P00GBBFptMsy7HzM
	Q2K57p8z7PNfTV7R4hZ6GZt8ngFcmkhQfcCyrGXLFBJJfYU6Eb9ZAYNg
X-Gm-Gg: ASbGncuwNQcYGWUjRUhSSquqMLNhN7EEd0+83fo6hQNOMKA3dZpMEvirtNHhfEOfBZf
	COWtvehELZpdVb6sOs3c0ld3Sr7KeVSfSnJz4jiN/WN4dSZ2ORw/eqYhE1QngGWtDFm8X2WEIJQ
	tPbKa5j/8oIx5ypPkhnhL2JH70FlX1vtekgUbn/H2WfgfqVe82wH9geWyosp3HePH+l50nZYfNp
	0lBPzkS/UTrtmfNPNA4N7JyOGU4PMLhXtzncqnfNQ7IFQ51jw9YYB3nmqnINvwiqFE/LPb89QVV
	dJRZnrht3WWEAznOyLM6L67e15xXSU7JFi2QEPx2OfCtNO74gJq1wv+DqNUZda+0+y90kGOKhtZ
	duVliE13h2MjRt0fybtuwPcQM
X-Google-Smtp-Source: AGHT+IGJZPb74pZ73TclTi9xT8AhXIrGB0ot5BmEnCFwAvPJ+1r1qiJjmCllqafnEKA+/9XMGMu+ZA==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3a6d12ecf48mr1230881f8f.57.1750403750729;
        Fri, 20 Jun 2025 00:15:50 -0700 (PDT)
Received: from [127.0.0.2] (bmly-13-b2-v4wan-168438-cust286.vm4.cable.virginm.net. [86.24.93.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c66esm1217101f8f.47.2025.06.20.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:15:50 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/2] refs: fix some bugs with batched-updates
Date: Fri, 20 Jun 2025 09:15:43 +0200
Message-Id: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAKVWgC/7XSO27DMAwG4KsEmstCb1udeo+igx50LKCRA0k2E
 gS+e+V0cdvZG3+CIL+BD1IwRyzk7fQgGZdY4pRaUC8n4kebzggxtEw45Yoq3oPutAEbQsZSoGK
 pMNj4NbcIMUEdERLeKrhskx/B27lgAHcHZ6sfW5lxwIzJI8zXYNsC4HIYlNA9ZVKSdvfaRuLta
 fr4bHmMpU75/iQubOv+aDTlB2gWBhQMFYEFJwZG8f18aStf/XQhm2bhe4E6QsCbgGsfqHK97cw
 /gdgL9BEC0QTIvGTaCBeE+iuQOwETRwjkJnDtLzA405lfgnVdvwH23b4ZuAIAAA==
X-Change-ID: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5912; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=aMVfZDW5429oXP1dVXIUHnlii4jM4oTsYwkWM6kDrrQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhVCqUw5MFJfdJVeqP4J8v2RUj+m4FhKYyLB
 +HM4pcc684MN4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoVQqlAAoJED7VnySO
 Rox/lb0L/Ri36iSACPmqYDtrv8Fa6aR/aBUWW8VsyOjjrM7rMTOQYKb/ddUd7gXW7aHnG2wmEl2
 DTOMc2DCq+/MCgTxX5XOxThTLdq7cWKaEIbg/5QV1mMFIxCRpoEiw+TVhIWx8r3xGByRhgj6vFS
 i/txuPUDLBN/c0cLKvmz8s+E+ThST5JCwClEMeoJ/W7Yc0a88vt2ZTF3yccINO20h9pFz+j2V/P
 xAWJI5fuT+9ZA7IS+Hqd3zb28EAf7iGRrrKBKKN3EnkbBdKpeVcXFUAh1clD4uRqm2EPeQh4Kyn
 xAh0Cl+D+Cg7RiuF2V7TS07H3LfBbq2QcqHrEgo5dy0gciz2RUaffZHBcorFpjLAV/1AH/zRrMZ
 rlbFC0QfP+KPdWZxgGJCI1z7Nb1Z77olgju4B0RESWamsuqYiN2FftfijybrNIuZv8N6WHYvtWD
 PZw5sZIHyLuWSPcH+D9Qz0pH3eWKLTLSW4ySDW6Y0WYKcFY/75zwa4aFAZ6zD2V2F/FOvSE9eV6
 uU=
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
Changes in v5:
- Modify the commit message in patch 2 to also mention the commit
  which adds multiple transactions to 'git-fetch(1)'.
- Also add a NEEDSWORK to the existing comment to mention how conflict
  resolution within transactions can remove the need for multiple 
  transactions.
- Link to v4: https://lore.kernel.org/r/20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com

Changes in v4:
- Swapped out F/D for D/F in the second commit, since we are talking
  about conflicts between a directory and a file, also D/F is more
  consistent.
- Fixed some typos in the second commit.
- Changed comment to single line.
- Link to v3: https://lore.kernel.org/r/20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com

Changes in v3:
- Cleanup the second commit message and remove stale comments.
- In the second commit, only create the transaction if needed.
- Link to v2: https://lore.kernel.org/r/20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com

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
 builtin/receive-pack.c | 102 ++++++++++++++++++++++++++++++++-----------------
 refs/files-backend.c   |   7 ++++
 t/t1400-update-ref.sh  |  45 ++++++++++++++++++++++
 t/t5516-fetch-push.sh  |  17 +++++++--
 4 files changed, 133 insertions(+), 38 deletions(-)

Karthik Nayak (2):
      refs/files: skip updates with errors in batched updates
      receive-pack: handle reference deletions separately

Range-diff versus v4:

1:  0ab0890bf1 = 1:  9248bfd474 refs/files: skip updates with errors in batched updates
2:  e45ec3139b ! 2:  00bf816b2d receive-pack: handle reference deletions separately
    @@ Commit message
         sequentially and hence no conflicts would arise. With batched updates,
         while the first update applies, the second fails due to D/F conflict. A
         similar issue was present in 'git-fetch(1)' and was fixed by separating
    -    out reference pruning into a separate transaction. Apply a similar
    -    mechanism for 'git-receive-pack(1)' and separate out reference deletions
    -    into its own batch.
    +    out reference pruning into a separate transaction in the commit 'fetch:
    +    use batched reference updates'. Apply a similar mechanism for
    +    'git-receive-pack(1)' and separate out reference deletions into its own
    +    batch.
     
         This means 'git-receive-pack(1)' will now use up to two transactions,
         whereas before using batched updates it would use _at least_ two
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
     +	 * are treated as conflicts in batched updates. This is because
     +	 * we don't do conflict resolution inside a transaction. To
     +	 * mitigate this, delete references in a separate batch.
    ++	 *
    ++	 * NEEDSWORK: Add conflict resolution between deletion and creation
    ++	 * of reference updates within a transaction. With that, we can
    ++	 * combine the two phases.
     +	 */
     +	enum processing_phase {
     +		PHASE_DELETIONS,


base-commit: 931c39f05e078e0df968a439379cb04b5c4666ef
change-id: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144

Thanks
- Karthik

