Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AA2DA777
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749802227; cv=none; b=kpgwzEnLRTJlSQJXNze3FmGlus56Lo8f0VR5X4ws5SPGjMMmDCBgYw3/GjkfXHxw9n/mXMz7D7tdDVdPUsNseDN7MD30ZWRUNs7Rm+gYwSvdcG5ENF838nhbKWbQeKXbt3ZjPUkGOL/I+vtvVzFwG4ZLzCiTqt29Tps0Sv3U/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749802227; c=relaxed/simple;
	bh=MmPc+AHeOzcOBuT7l0LUjeRYM1S6g7qBXuS0QFUbDzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=adT/W8OPm3BYKHlPRhXCA6H/E245Y5wQK2dh2jizqRkA7X2ZmClrgYniI5IgkeXvZuvW5WJcc3s8gSN4Yr0lFRj/xaDQe9TU6KT9w+IY6ASYoj3o8s2jQb5ZBkpbua4cOhUhVl+P/208zzu1S/HuRPVuCqPV10ukAYKy/CyIg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYN+TvLU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYN+TvLU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so20645815e9.0
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749802224; x=1750407024; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ue/bpE6rWOykqw2BoagENYxwKZ46tGxl5NeWAKjOyE=;
        b=eYN+TvLU5K0TLEqz1d7huTtpZOJvCnFN7+/jHCyB4Wrd67oagVm/Em5BN+jVc9ff3+
         HS31E8WjSW4ILQwT2wp1ILy32nIGFQ/Il920YS7ZFnhwB/eC1Nk6q2RyhXK886zHKjkN
         F/bCVqYhAPROrwpPS+3TfLa9eC42WssraPx8md40HB2pkEdck2rEIFAZnx/RgKRLygpX
         M+a6TyIDOE2Tx7+FZIIq2SbPuzMwomWVwpGEPelCa9RzDYM7iA+sQi81vXT0ZrYQJJHg
         Jy6rJ5sIYeH1wnyTqv1I/PtyMEhAOl+W7XbOJ5DRh7yNbhd/BMOE3LBoTTTxmENq4QrN
         e54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749802224; x=1750407024;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ue/bpE6rWOykqw2BoagENYxwKZ46tGxl5NeWAKjOyE=;
        b=AsRjXaHHfl9Ikc7M7r+Fhe195u5zgBz+6Z1vXSAtFl5mgAp4o71dE6ykL7JtFauza3
         v0a2/3QZQcDaAkSsZ3bk4NEjjXta5uoPgjTc7Z1l6ikVUV4FON+481eRyjAuAL43Iz3Q
         kwNRUXEo8u8UCv+00WQCN5WsaA9+zOU3rKHIQregQOk/h/gPLMN8Q9SHUmeYK9uy1UG7
         ltiWdVkkO/LDnUx8VNI6sOEEzJ7oaEn/N+pC72hivm2V330/1+FXaIRp/ebuyXTC2Dny
         DVPsNl5MrmUH6VLjFxfChyAioo7hO9dXKwBGnxSUb+ML+/xvQqHqbwfBtXR+KikQWVBG
         3psw==
X-Gm-Message-State: AOJu0YwwdqIPPVDE6GlfrYMGI5dT8/eDGYSYw5MskssDXPpa460rPwVG
	acq3na3adBTT1ujsC96QtwTuAW15ACtRsyofNTXGgtH6jGPW17diEkNbebIyBUmA
X-Gm-Gg: ASbGncut2StDBjOA4zImHb4Q4wIpcKUrI8q3yd4g1Qq7ZqP+fiQZc0Rn/gCaDDYthJB
	PfqJDc0NvS/nMv/M59pG1BRi8SgKkiCW4wxU53NGOVRxBAqYq7ez9LYxI6ztaL2yuSdRiPhvH9/
	9QUmLvGnCm5cPvRBR0qyfdwJbndaIrJ+vjGf7Vo44VBSlhBB41/7gQn+Jjer4XJ0Yx/hDJx6KEw
	g5aBsQnvlMBfrFzZ+NWNQHFQNeTmvD1lsVr80IVKCI+e0bs0+gk4m6TrHRSl6O64aBOchtLJqYI
	xkIoIcBOgyzi2z5b+Pq6JrSvbe3KMO250igdRkELQqgdnncGiF1ZKCiP
X-Google-Smtp-Source: AGHT+IGFpid7aGcaqMF19VsJjS7EWGEh1rMdEeIyV0a3QKpT5n95RhOjYZE8TS+i+RfyZBcPKrvAPQ==
X-Received: by 2002:a05:600c:870a:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-45339a3b3aemr7488965e9.16.1749802223493;
        Fri, 13 Jun 2025 01:10:23 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9a6e:abf0:b0ed:9106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a63sm1615191f8f.11.2025.06.13.01.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 01:10:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/2] refs: fix some bugs with batched-updates
Date: Fri, 13 Jun 2025 10:10:16 +0200
Message-Id: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjcS2gC/7XOu27DMAwF0F8JNJeF3rE79T+KDnrQsYBGDiTZS
 BD438Mki4HO3ngJ4vLcWcWSsLKvw50VXFJNU6agPw4sjC6fEFKkzCSXhhvZgT3aHlyMBWuFhrX
 B4NLfTBFShjYiZLw28MXlMEJwc8UI/gbetTDSWHDAgjkgzJfoqACkHgajbMeF1oz+XugkXV+mn
 1/KY6ptKrcXcRHP7VtjudxBswjg0HMVRfRqEBy/T2eq/AzTmT01i9wKzB4CSQJpQ+TGd+7Y/xO
 orcDuIVAkQBG0sL3yUZmtYF3XBypzgIU2AgAA
X-Change-ID: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6461; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=MmPc+AHeOzcOBuT7l0LUjeRYM1S6g7qBXuS0QFUbDzs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhL3O6odfyETwvcc8PZjNNwfydAItDd2UOQA
 AY/J1AIMqXkRIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoS9zuAAoJED7VnySO
 Rox/8DoL/24MxN6QkpJeyxJAkJF1F8IJSK8x6E+BxAU0+6x0EGjFiB/5vsxPVT+L+4jRrnCH031
 yFHQIGYJyU4lWpNZbC3QJvEFZE5UJBcYtMic2kl/C68lP61sKuf340ouP82qa/6MQK4V3/76WiT
 cQ68sFsVz/3ZiupL/ue875gGx1YQpvMfIcINFYfk2B/pp8zB5WVEuV4G3ynjoFqTCQgW8I7I/nd
 FMvDq6bYA6E3tTENMP7iLLeXRQlsgr6zQEXjTi9u++ymEQ/l2+KzdjBfNnNcYly5fgbPprP+PR5
 0+U60G8AKxSmCnb8l0XjS58F4GaBnj5syFPPabQTwgi/ZLSaKpRU+tdv8h6ozYmCyZxwuGTwT2g
 7hOYL9tS9iYSyqc97Bo6521LPm/wibPiYSbiDklPyWQx48oneUM0CHDJ7uiSxLtehlDMD7lz0bZ
 c74P9wADo1OTEHumegl3PXXCaaMzuHffQ+4jkWpyEQxOcZsSrJpB2J0Razqef8+dtV3rnvsjHK8
 P0=
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
 builtin/receive-pack.c | 98 ++++++++++++++++++++++++++++++++------------------
 refs/files-backend.c   |  7 ++++
 t/t1400-update-ref.sh  | 45 +++++++++++++++++++++++
 t/t5516-fetch-push.sh  | 17 ++++++---
 4 files changed, 129 insertions(+), 38 deletions(-)

Karthik Nayak (2):
      refs/files: skip updates with errors in batched updates
      receive-pack: handle reference deletions separately

Range-diff versus v3:

1:  6a9a7fdcbf = 1:  44291af073 refs/files: skip updates with errors in batched updates
2:  3175c3430c ! 2:  c8026de30e receive-pack: handle reference deletions separately
    @@ Commit message
     
         Before using batched updates, the references would be applied
         sequentially and hence no conflicts would arise. With batched updates,
    -    while the first update applies, the second fails due to F/D conflict. A
    -    similar issue was present in 'git-fetch(1)' and was fixed by using
    -    separating out reference pruning into a separate transaction. Apply a
    -    similar mechanism for 'git-receive-pack(1)' and separate out reference
    -    deletions into its own batch.
    +    while the first update applies, the second fails due to D/F conflict. A
    +    similar issue was present in 'git-fetch(1)' and was fixed by separating
    +    out reference pruning into a separate transaction. Apply a similar
    +    mechanism for 'git-receive-pack(1)' and separate out reference deletions
    +    into its own batch.
     
    -    This means 'git-receive-pack(1)' will now use upto two transactions,
    +    This means 'git-receive-pack(1)' will now use up to two transactions,
         whereas before using batched updates it would use _at least_ two
         transactions. So using batched updates is still the better option.
     
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
     -		goto failure;
     -	}
     +	/*
    -+	 * Reference updates, where F/D conflicts shouldn't arise due to
    ++	 * Reference updates, where D/F conflicts shouldn't arise due to
     +	 * one reference being deleted, while the other being created
     +	 * are treated as conflicts in batched updates. This is because
     +	 * we don't do conflict resolution inside a transaction. To
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
     +				if (!transaction) {
     +					rp_error("%s", err.buf);
     +					strbuf_reset(&err);
    -+					reported_error = "transaction failed to s1tart";
    ++					reported_error = "transaction failed to start";
     +					goto failure;
     +				}
     +			}
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
      
     -	if (strmap_empty(&failed_refs))
     -		goto cleanup;
    -+		/*
    -+		 * If no transaction was created, there is nothing to commit.
    -+		 */
    ++		/* No transaction, so nothing to commit */
     +		if (!transaction)
     +			goto cleanup;
      


base-commit: 931c39f05e078e0df968a439379cb04b5c4666ef
change-id: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144

Thanks
- Karthik

