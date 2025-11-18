Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981F350A02
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465284; cv=none; b=Xh+oSYz3p7Al7uIHQjlUJKzFzgHUZlEf0hROzPG4vrLgpefG4U8GV3uyfI04/fjTqeJprpBb3hUdJRnBruDnnxI1rtSc5nikMwIGXLejO5lgf0DBkSfRFji0MR/MHlMpH9FgPwxyV0sr7lqFoZvMQcGEP5BxayBLzOtYlcjJi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465284; c=relaxed/simple;
	bh=cQKxmEI1js/gJNejbNKH4ayXD7o0xrUCPLHkGJPChm4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=jf803Am8P59tf/6FMtfXxCGRt8fu6suTyqRyWdZCS5dyAGDfDNMDZo98CsrBsunXek6HJ7iGkoDd16mkly9+LfM+lh4NJcCID3lEep/8qCttOhE4ufvm01IPGHVC+4GrhT3+9kIQgPz5qhyjKBJyRLIXQKUwvRhDoOYeGfTRM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFkf4nrJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFkf4nrJ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b728a43e410so869921966b.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763465280; x=1764070080; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3GihAShbvIklLTPHTNbon+ftNViC6po+KIqFTdkp0E=;
        b=RFkf4nrJtbjPUXMA3NbWLOwgMsT/vQ2yy+5cir99aFkwc/nRCD853WLdOrNDxkwiyY
         3mJaISgKAVmwFI8baxclAspIXhWSIJWT8GXwKijgbXgAV697q0IsQVqcUMMeirywpp9Q
         w2uE+ehUlHTLH3f1DWVHwngT6pJjP+RqFb1T2kabKaJkyymCgPVjBcNlS5X28+OnGvT5
         ekthCWVqRHMc6VjMvCy/ALRZoXGuLnRiuW/xpOi2/HdOsQuoKEZq3vfFA+ow43+4chQJ
         csSXQ6w8sWDC1CeaWVehY+mh57KYFf8yGZTJOgyaP3u6iLw2aqVdXL0ATs5uwYabD7Kx
         VrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763465280; x=1764070080;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3GihAShbvIklLTPHTNbon+ftNViC6po+KIqFTdkp0E=;
        b=MMWNQmrwsRPUskk6mQOG9rdQymEXBmNtZKN8H8QzNEjIF1niBlFfoBiGZV56tnQ1p3
         Ff58vWB2bDR4ZMdUwZ/U+IUL2RoPGQdvAZr4pGCMa2MG1KmScKU1I3iAk8hMobF9v+zU
         Ki460ieatkenE9ZXcr5jIndRlmxs42rDND8+UWpCXw8oQmED3iI6g6SNkqWQy3rizSrQ
         qvffCAp9QwMupvnbQ+ZGU96DF6HrW/cwqQjKG2hZFMbaS4i8XhOrXKpPGoZMA98as5te
         LB4JK8w1K86MTtGgu7mVuT62kqgR8NPpgbZIxjDvWvdiaDSmXAeO8c8tbdV3R6JRve74
         EY+Q==
X-Gm-Message-State: AOJu0Yyqg0944N0Zhx7a9aIUGenspLK5cvYkeQrFLRbZ/lRnIRIRiEr9
	hg2k7wEgLkIqJAFX/b9xydDU1Joj5KTQsWbzNff5GMnc+2NFuFUSlu6e
X-Gm-Gg: ASbGncupqh2xIkQgMUTOwcNI+J9rYuCHUCBSbVUzsGPwUMEMw0UJCoMJ41RRrkX/C6k
	oVvGjPw+dSkMJO+POC+adoTr93NzklI/cUNq8hzl8Suk4IkipYgGDmnkQT3757dLLsOyU7SsiFP
	gnFx/47Ba6MR1SiE+veHLKZb3cFDG/ToHT38LrHvJTmsISbv2c05NhrFK0sX84cbnu59X1I3U7s
	bjaRTSoILu45F7WuaHbYsQ5kn1V+4e8CHU7Ck8Ow5KGpTdvgWwl+rfjQ5hEG93E1bp7yGd0HRll
	q046Bo7YvEZMu7se/V/uF+Lr2vCKeh7gkDvNwnv9gxRHAvJcur6RTQq8t1ivIRvdtkYGabYq+ql
	X88G06cdr1BHg9ayPxHwdveaDRDJjCMijM9n22LcUjMXHfF18zzpvHyTl0ihZMvuG+bHFlEWvrf
	rK7A57
X-Google-Smtp-Source: AGHT+IFOsEninqAPijMW3kWO809gEQfD9hAW1C7y/jgVrAj6ATB2TGOsb4HIWm+6CG+ICaujRh4x7g==
X-Received: by 2002:a17:907:1c27:b0:b72:b289:6de3 with SMTP id a640c23a62f3a-b7367bff073mr1704618866b.58.1763465279895;
        Tue, 18 Nov 2025 03:27:59 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:118:b28a:3b78:ce56:def6:5cf8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73718fec4csm1005451066b.39.2025.11.18.03.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 03:27:59 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/3] fetch: fix non-conflicting tags not being committed
Date: Tue, 18 Nov 2025 12:27:54 +0100
Message-Id: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpYHGkC/4XQwWrDMAwG4FcpPk/Dsh3H7LT3GD0otpIY1mTEI
 ayUvPvUnkwg7PgL6ZPQQxVeMhf1cXmohbdc8jxJ8G8XFUeaBoacJCujTYOoLfT5F1YaCkzzCj2
 vcczTALpHb5Bc65JTMvuzsDS+3K+r5DGXdV7urzUbPqv/iRsCAnsbiTsfEe3ncKP8/R7nm3qKm
 6kVf6YYUTzq2LlOcxvDUbG1Es4UCxoIDcklLhH3R8VVCuKZ4kTB0KRgPUdv6Kg0tXL6l0YU2yJ
 TK4gNqVb2ff8DPUylLdIBAAA=
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4359; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=cQKxmEI1js/gJNejbNKH4ayXD7o0xrUCPLHkGJPChm4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkcWD1t4UCrE3DVfvNLtPJum83wzS9pn6NH3
 18jaD1/LzzCTYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHFg9AAoJED7VnySO
 Rox/CoMMAIaBNVUU0TunKGoAgmQpq2C7K7fChWHKxWKCRINmA4njkQUbyYxm/EaU4ZA61NNjg5V
 urmqhXPt4Gz9BV1XuBvh1rOBMCz3rc7dJNxacxwd+uui+Bvp3yWELsFu6k8iweULQeL/aCcCg0g
 ZFTMFB0P86kvwdEJj5lyEfBICWq1QNv6v/EY5qj/IRlKTspg5bZ3SKuF6zuv7510boyWbJrZkgG
 TS33KAzxzH7y1KyluFr2zlCu2FaEUc9+DTohBoEYHNc0Kil9nFn069ZsQtH3itTBfDR6Y1KhCOn
 swPTJ8nZbG62JpVzYSi4Lu6q+er83XwU33Jz2kMT7keBL2K0aysva4DWfNnvGIGB4tsrhwRes8S
 3u+VZz6TDzUiBmWwKWQcmSqHCLOGVjcIXKqqye7+fdlbpZR+qekl/IBsVk+Zfn6fZ1+ky77tyNN
 vQ6bLwNVviFBnuzc4aMaHunxX904lfvj8KJbIwPq/Ao36O0u/3ydvPLD4+UcqA/yk0E6ns8egG7
 ss=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This fixes the bug reported by David Bohman [1].

The 'git-fetch(1)' uses batched updates to perform reference updates
when not using 'atomic' transactions. One scenario which was missed
here, was fetching tags. When fetching conflicting tags, the
`fetch_and_consume_refs()` function returns '1', which skipped
committing the transaction and directly jumped to the cleanup section.
This mean that no updates were applied. This also extends to backfilling
tags.

The first commit, extracts out common code for committing a reference
transaction and handling rejected updates. The second commit ensures
any failures would also commit pending updates.

The third commit fixes another regression around failing to do
post-fetch operations when ref updates fail with batched updates.

[1]: id:CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v6:
- This version adds a new commit which handles another regression where
  if reference updates fail when using batched updates, we skip doing
  the post-fetch operations. Namely:
    - Updating 'FETCH_HEAD' via `commit_fetch_head()`
    - Adding upstream tracking information via `set_upstream()`
    - Setting remote 'HEAD' values when `do_set_head` is true
- Link to v5: https://patch.msgid.link/20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com

Changes in v5:
- In the previous version, I assumed that the `prune_refs()` function
  also triggers committing of batched updates. However this was
  incorrect as the transaction for batched updates, is only created
  after the call to `prune_refs()`. This makes sense, since we want to
  isolate deletions from the rest of the ref updates, to avoid
  conflicts. I've amended the commit message accordingly.
- I noticed I missed cleanup of the repos created in the test, which
  I've now done.
- Link to v4: https://patch.msgid.link/20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com

Changes in v4:
- Cleanup the code in the first commit to make it simpler to read.
- In the second commit, we were specifically checking for `retcode > 0`
  for committing the transaction. This is a bit confusing since that
  begs the questions why not `retcode < 0`. There is no real reason
  there, so I've change the code to simple do `if (retcode && ...)`.
  I've also added more information about the flows which would commit
  the transaction in the commit message.
- Link to v3: https://patch.msgid.link/20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com

Changes in v3:
- Split the patch into two commits. One for extracting out existing code
  into a new commit and the other to perform the fix.
- Add back error handling when commit via the normal flow.
- Instead of calling the commit function at every failure, make it part
  of the cleanup code.
- Link to v2: https://patch.msgid.link/20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com

Changes in v2:
- Add a comment to explain the purpose of `commit_ref_transaction()` and
  how it works.
- Also extend the same logic towards backfilling tags. While I was able
  to add a test for the happy path, I couldn't figure out how to test
  when `backfill_tags()` tags would fail.
  Tangentially, this flow seems to only be triggered when using the now
  deprecated 'branches/' remote format.
- Remove unneeded subshells from the tests.
- Link to v1: https://patch.msgid.link/20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com

---
 builtin/fetch.c  |  71 ++++++++++++++++----------
 t/t5510-fetch.sh | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+), 26 deletions(-)

Karthik Nayak (3):
      fetch: extract out reference committing logic
      fetch: fix non-conflicting tags not being committed
      fetch: fix failed batched updates skipping operations

Range-diff versus v5:

1:  ab03acf218 = 1:  21f2518724 fetch: extract out reference committing logic
2:  8a9982ee75 = 2:  9ca27b08fa fetch: fix non-conflicting tags not being committed
-:  ---------- > 3:  33a7654bfa fetch: fix failed batched updates skipping operations


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
change-id: 20251103-fix-tags-not-fetching-0f1621a474d4

Thanks
- Karthik

