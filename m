Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A0388899
	for <git@vger.kernel.org>; Wed, 13 May 2026 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660313; cv=none; b=C9a4++HvkB4r7/a92FT/3u8T3tT3UAtNQh8DTm1g1Ph6QjWZXIDZnLs2azLJ5w941GQuJ76Zn01sga9o1RdGUdpuKaR9LoNOCltOfS7CGSHwUB8ngKLK98G2V6B67Xa/8Ct/ucoiUZSevFD5+8FtS2CcpWWE4mGC+61cE/Us85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660313; c=relaxed/simple;
	bh=7w5ycdVFPVn7YPll75/6/69c+TGWO7kb1LNjvTjP2KM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=LGBTpzuUcVcD0VVBnA8EWQPy9Sg5gzXKHrtGQkMwpAdmN/nJPFo9I2X1NRWt3Mmh+rOQnGVMlXGjrUbwZDN0aytR6MSrzYtwO32nxRRdM0J5ZUJr9tN6PL52AH2H2LFYqaPUh9DvksgEyV+Rhso0b74vGjYPvB1MLGPZITm0eBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alexandersandstrom.se; spf=pass smtp.mailfrom=alexandersandstrom.se; dkim=pass (1024-bit key) header.d=alexandersandstrom.se header.i=@alexandersandstrom.se header.b=kH7qnfwS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alexandersandstrom.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alexandersandstrom.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alexandersandstrom.se header.i=@alexandersandstrom.se header.b="kH7qnfwS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8e3849de7so153728e87.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alexandersandstrom.se; s=google; t=1778660310; x=1779265110; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpfXzK7oExaz+DnOKRsMKZeVlMsDNfiE9iyZqwmZFEM=;
        b=kH7qnfwS/uf1nqomzL7Q4HU9/aol2Y8NVbhNSyfJUdg+yPiQyQzApWx+Pv19/c915H
         moPs7KnJ1t8FPT5QYDrQd28gsSKSgTlH3nw+8csjBpejHa4wyCHrmcxaPcqRGYvSCn4w
         EJl9xCfcxSp33u6o6whfO9KT6laUVDgvNLwb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778660310; x=1779265110;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpfXzK7oExaz+DnOKRsMKZeVlMsDNfiE9iyZqwmZFEM=;
        b=naaWUsTi4F6otymgbukPGLa7XrLT631wUtYN5SRUYsHKTUOCCA4ye7ajlFyU9n7pul
         bf3praWQfGMfa5Hj0+C31uDAnDfJpdvLiYboAyjA5ZwjVJFZ6ygDAo+fG2rydLOOH9By
         GDma1CsGqEqloiwUi+GqdFE8YmONTXvVf/bXDw2x7kzKqb9yKkItgFR2Ov3OPNokZDV3
         hdz0JmkTWNfsEd0yOxEVVZhwhKD62JM5JnaSWSZcuuOIJGD1Ky94DOaIaW90ZwReirOc
         gh8b4o3YoJpb9gnU5Atue3evZWqNxcq3FI9O6m3mYIO7qCEzYS5dzQsQLayUA5YrD82M
         7n3A==
X-Gm-Message-State: AOJu0YzU0HbAwNsQR0gzX80MD98B5XA4zkew04AYdGyEFuQB7gxM8fEJ
	w1OGM8frPe3tyE07az34w9gSfbuJWo4xf8NrVkC4N2IjJsH4ujGNhbUHcQaLXudG2bz0bYkVd1L
	B6Rs=
X-Gm-Gg: Acq92OFu9vFo+Ii/s4nznDwHs/7c+hKd/CGdi1KNnz1RIxi2NOpyYzpznDse4BkjtRb
	FUKKZW34XzRJObCQFaPfMRb0HlEX7hVu2on5jf18dGTVbY/LtOF9ELx7wsO3748avQCyvy9SFGE
	P87lz9ZOxGWA7Kgbb7YtSuRYZL30qsM/ymdpzq97OE2OiYlcHXjciedwfZ7r2Ir7/ovVyCxu9C5
	Mh2vZ0zTiQ3B6CMcCmlHDxx3L5QHiQO5zDc7e0dYrnP0lKMM5eW4+RGhgPhiWvoVKIn+ArXtnpV
	v49QhiBbxJEwA6gk5GEmmc5pYCHqJdb/Bhhi4uqRGw2xM16SRGCInlG3JNAuYm0CaJ9MFXTzvM6
	I+eTxJnKmKY2GmIdSJsNIek2AxxUPOPKWTjjKG4jWLKIfq5Sz7+gWTXOvIFrZKt4/YzodZnti1m
	q22MW4YJ68SUSuTMYM31ejmaMSLeDfNygiHsn1WynbTah7M8qwdsOHg3zgkdfEWbG5D4iJjSa+e
	/GAKRSF/Ww=
X-Received: by 2002:a05:6512:1193:b0:5a4:11b0:fae8 with SMTP id 2adb3069b0e04-5a8ef96426cmr321551e87.1.1778660309935;
        Wed, 13 May 2026 01:18:29 -0700 (PDT)
Received: from smtpclient.apple (151.236.205.53.c.fiberdirekt.net. [151.236.205.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8c6f78bd7sm2363627e87.74.2026.05.13.01.18.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2026 01:18:29 -0700 (PDT)
From: =?utf-8?Q?Alexander_Sandstr=C3=B6m?= <mail@alexandersandstrom.se>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Bug: lowercase "head" resolves to wrong commit in linked worktrees on
 case-insensitive filesystems
Message-Id: <95BE8E60-1684-4E0A-9E46-E61E81D06CE1@alexandersandstrom.se>
Date: Wed, 13 May 2026 10:18:18 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)

Hello everyone,

I ran into a bug that took me a while to figure out. 

I'm sadly not a good enough C programmer to submit a proper patch,
but perhaps this bug report will at least be indexed by search engines
and help others that might have this issue to understand the cause. 

My guess is that it will happen much more frequently now that 
worktrees are more popular.

**Report**

On case-insensitive filesystems (macOS APFS/HFS+), `git rev-parse head`
(lowercase) in a linked worktree resolves to the main worktree's HEAD
rather than the current worktree's HEAD. This causes commands like
`git reset --soft head~1` to silently operate on the wrong commit.

**Setup**

```sh
$ git init main && cd main
$ git commit --allow-empty -m "base"
$ git commit --allow-empty -m "main-only"
$ git worktree add ../linked HEAD~1
$ cd ../linked
$ git commit --allow-empty -m "linked-only"
```

**Expected** `head` and `HEAD` resolve to the same commit in the
linked worktree (or `head` is rejected as an unknown revision).

**Actual**

```
$ cd ../linked
$ git rev-parse HEAD
<commit: "linked-only">
$ git rev-parse head
<commit: "main-only">
```

`HEAD` (uppercase) correctly resolves via the per-worktree ref at
`.git/worktrees/linked/HEAD`. But lowercase `head` falls through to
general ref resolution, which opens a file named `head` on disk. On a
case-insensitive filesystem, this matches `.git/HEAD`, the main
worktree's HEAD, instead of the linked worktree's HEAD.

Without worktrees the bug is latent: `.git/HEAD` is the only HEAD file,
so the wrong codepath happens to produce the correct result. The bug
becomes observable only with linked worktrees, where the main and linked
worktree HEADs diverge.

**Impact** `git reset --soft head~1` in a linked worktree silently
resets to the wrong commit, staging unexpected changes. This is
particularly confusing because there is no error or warning. The
command appears to succeed.

I realize one argument might simply be "lower-case head isn't a thing",
so feel free to disregard if that is the projects stance.

**Possible fix** During ref resolution, when the input string matches
`HEAD` case-insensitively but is not exactly `HEAD`, git could either:
- reject it with an error (matching Linux behavior, where lowercase
  `head` fails with "unknown revision"), or
- normalize it to `HEAD` and route through the per-worktree codepath.

**Environment**
- git 2.53.0
- macOS 15.6 (APFS, case-insensitive)


Regards,
Alexander

