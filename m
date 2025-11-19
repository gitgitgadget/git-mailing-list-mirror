Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFF21E0BA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588801; cv=none; b=ApacRTbFUKHuMWoHuPdcAxca/Ovy1EhQAOlmjuTpwu78FEEXcdz+UR5z5n8kx5MrOea6yEsOfGyi5amkLF+M2A0DIav04H6+oAxOOnnJ+yoc6qrwsHr3AX1d9AHBsJbtNC2+5rG1OV5fD67ertYwY6xzY38gVma8oODBVBeyXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588801; c=relaxed/simple;
	bh=U5ZluR2TRwGc/eU6lyAtjnra3BqujkEcLZE9QmCssZk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=g34YBHPnCpJQo1fdIjjs4d2p53b2Om+0yVpHiw8HcG1TwMYwgV4PMjqlJa+NhZnGzSvllkg4OZHWPvdtmMb5KCunTc+QtpcBO3/4yOZFRAcxKWTO9JCDYntVxVcTbrbacJjwrt8yyBV6Pe4B5ctgWbmbGwcXPnLkd86V9+EiyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhkXKoac; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhkXKoac"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso211313a12.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588798; x=1764193598; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjn3rn4BSZxBWwjpU+sIj2B36b88tT4zYBjHTSTosHk=;
        b=jhkXKoacg7eqfFu7oVtufuZW5OvUjcL44k5f99B+KbVSniuUMQqVNkN6bPW3bwouby
         9LLneD2GEdHGKFVITKhnsrpIDXt/lSulE8L2ZZiZlauQVlIU40RKUI0ARuxM51hSgDcx
         qRq3vZBsbpxuh5w/RBShKhKUmnv4d+MaGC0FVenpgD9B2HGdOkFDlJzHCgiozJCjsCd1
         1R/hDeg4AhmoPHHMlzDv1PcitaQmqQ8P5Q33DBPX2djiVse8pqhmghF6Fwv177q+QWht
         b2kA7fT2KFZzUQghzGoVFHa2QEXBciaFfXNDuGAe9QFbBTwTe4ysBXj4+HswKDrKN68j
         HLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588798; x=1764193598;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjn3rn4BSZxBWwjpU+sIj2B36b88tT4zYBjHTSTosHk=;
        b=Rn82j6KIzEN6DNyNOYY8at4v2N9xC+gzzfHILwWWJFkcOsUOxbDCKsjIDn0HVlX0ol
         vGa0VJhjZXXYwTwQ7iFy2khvvylqmJviLOBrGbZt1rN5hXd0V/vkDbrq5XzkuN8e42LB
         CHVVSK/jMxl5LDG8kcu0bwz/XDIBMlHD0/BGAJFzqPXMRt/NvFDxYtZsbr11Sr4KyMEA
         MxdqTWtGG9I4WTZ8QUuE4gXIkugqLDTNkA3ouS0LkjG4ZaAR6GrCuR1HDmXlK6yoMhHm
         IUZf81P1zShiKcRObJXIX3+vCcSI8J0BLLoxMg7suv1N+EdkLk83rs83ewVgHXCS3tkI
         eK6A==
X-Gm-Message-State: AOJu0YxF/O1Rsa5go+QINiR7m6xYYAuWhdTBAgIpvZ+m5LuOReWsbjmX
	RSsxAmzqf8e/90praUv0+K2PkbKtG8bkYnWgKI82BGktMuZP5F+YI8eG
X-Gm-Gg: ASbGncsQ3wuzX5AIW18boyMvLrSQm6aZzWbvA9nOHG/QSmABzzzFkRYXfJRP3BtnSfo
	Bc+u38Ak3Oq4Zqb9xD4X9Nf7VBf1OoAz3KHnDDTjnKChZ59pSBL2ah5ABIP+c4li7XIhcUYf0Es
	ldrq3puGbwg+bf0FgvvqQJOyrTHjxgYeFGEZ9LCqarTe69F5rT4yGEqnV6wZrb/RWbE4Pw4VYVl
	6ez/silbJ+TOMvUXgS5z8SMXC4qk6GYH8djbXO1IZPB4MkOC5joMfkUo5G97eyYErFp8kyt0isy
	YHVrZRDSDh8afAweV6W6xYmSIy7EqBge2da3yDJobxkvsX2wN0fKYO9DuUkGdQZYFH7tkJgx9OU
	/dO9IAej0pPvqtxPkDfsa8PYzrXQJRNwcTW0OUcuKH+5vyvJICC74V3IXpDr5xrNWbAq7/oSok+
	qqb3tb3hUJy+bLqz+kDrfA4Xj4WQ==
X-Google-Smtp-Source: AGHT+IHazEjNnTtla3wFxrm7+OrxUfZK6Nprz7zzY1IMYODgJXqmnvqwJ/Qp9x2Q7KSorRF4oGPigA==
X-Received: by 2002:a17:906:478b:b0:b73:9792:918b with SMTP id a640c23a62f3a-b7654e6e0e7mr71632566b.27.1763588798141;
        Wed, 19 Nov 2025 13:46:38 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:119:a01c:1871:c4bb:6fef:656d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d73430sm40760866b.24.2025.11.19.13.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:46:37 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 0/3] fetch: fix non-conflicting tags not being committed
Date: Wed, 19 Nov 2025 22:46:31 +0100
Message-Id: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALc6HmkC/4XQwW7DIAwG4FepOI8JAwG0095j6sEhJkFakylE0
 aoq7z63JxQJ7fhb+LPNQxRaMxXxcXmIlfZc8jJz8G8XESecR5J54Cy00h2AMjLlX7nhWOS8bDL
 RFqc8j1IlcBrQejtYwb0/K/HDl/t15Tzlsi3r/TVmh2f1P3EHCZKciUi9iwDmc7xh/n6Py008x
 V3XimspmhUHKva2V+RjOCumVkJLMVJJBI28iR2Q0lmxlQLQUiwrELohGEfRaTwrXa00/6VjxXg
 g9IyYMJwVVyvNixwrGnWCLkUwnmrlOI4/3yGjFBgCAAA=
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6191; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=U5ZluR2TRwGc/eU6lyAtjnra3BqujkEcLZE9QmCssZk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkeOrtR/54fM9dObkU7oDrwZRgiAVQC7pQo3
 8vOx2NywaKdeIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHjq7AAoJED7VnySO
 Rox/+1wL/2CRjOW5ry/TVk9LCRHJ/9b6W42NWqPOKHh3+NFNVLJ+d/fQVoP5stoFbYt57AGVDlR
 k0sPQx+M68KQuZdefH29lkSQbyGdrIY3QzZ2RJQrYfSRbVaKiYlrUT9zzzsV/e0DinlGwAUQr3v
 fHMEFFCWhrDLNgSZ8DUK7b7HOnVg9cAqXoe9phv/EGEwwmSbIigWIQG+QJgXiu+6smcQTQNYA8o
 9FaGSMkC4QU27S9J5ORTi1SwPi+ik6S6RZ10LtIjQhN8Y1ubbbh2tHDMC6rsS+wJsHPM/79LJvy
 sbe5pW0RQkV02/F8B1InRj/DxGSl4V9xuK0vRE5ME67lXK4JCoy1tuuTwiZPMyrJ4aV/EZrCx/D
 T53alLm1og3h5y+AouL7f0iNVOsh12ViUBI1T8AtSh6Aw/GRxqcKtmA6X9RYiF0kUd22aRFOj9G
 ZBD/opLyTOSAiWnO6ekzU9b3kwym9Fhy03Moij0NkpzLt7x2l0l6y9GXhtC4FHIh4mFz9/erQs5
 NY=
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
Changes in v7:
- Don't use 'touch' to create new files.
- Drop the REFFILES requirement for the happy path test of 'git fetch
  --set-upstream'.
- Link to v6: https://patch.msgid.link/20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com

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

Range-diff versus v6:

1:  e16f0034a7 = 1:  c5b451d0a0 fetch: extract out reference committing logic
2:  5145e93e99 = 2:  59e97f54af fetch: fix non-conflicting tags not being committed
3:  8fb6ef3079 ! 3:  1bf509a96f fetch: fix failed batched updates skipping operations
    @@ t/t5510-fetch.sh: test_expect_success "backfill tags when providing a refspec" '
     +		cd repo &&
     +		! test -f FETCH_HEAD &&
     +		git remote add origin ../base &&
    -+		touch refs/heads/foo.lock &&
    ++		>refs/heads/foo.lock &&
     +		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
     +		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
     +		test -f FETCH_HEAD
     +	)
     +'
     +
    -+test_expect_success REFFILES "upstream tracking info is added with --set-upstream" '
    ++test_expect_success "upstream tracking info is added with --set-upstream" '
     +	test_when_finished rm -rf base repo &&
     +
     +	git init --initial-branch=main base &&
    @@ t/t5510-fetch.sh: test_expect_success "backfill tags when providing a refspec" '
     +		test_must_fail git config get branch.main.remote &&
     +
     +		mkdir -p refs/remotes/origin &&
    -+		touch refs/remotes/origin/main.lock &&
    ++		>refs/remotes/origin/main.lock &&
     +		test_must_fail git fetch origin --set-upstream main &&
     +		git config get branch.main.remote >actual &&
     +		echo "origin" >expect &&
    @@ t/t5510-fetch.sh: test_expect_success "backfill tags when providing a refspec" '
     +
     +		! test -f refs/remotes/origin/HEAD &&
     +		mkdir -p refs/remotes/origin &&
    -+		touch refs/remotes/origin/branch.lock &&
    ++		>refs/remotes/origin/branch.lock &&
     +		test_must_fail git fetch origin &&
     +		test -f refs/remotes/origin/HEAD
     +	)


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
change-id: 20251103-fix-tags-not-fetching-0f1621a474d4

Thanks
- Karthik

