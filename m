Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E7274B25
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344899; cv=none; b=cxm95Jg1aHFtGCIdnBWHFUQB3HGmizwEZYb7/rIW9+Ss/9qHJeX/CPrp+4vYFDyQQmHceJGMTEpn06zc9FaWJMHka2/FgB/guW2Fo6P3hJGxHaztb6cdT+YSbjonIbwUeIVnRDlINtvL+a5I+8SaF1IZXThq5pMZqMXRe9aC9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344899; c=relaxed/simple;
	bh=fQ87LiQFKbLRM/i4mjzBsv2E0HvwF8CsCfVWyy4Z7Q0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CfGhvz49yJ3bQALtx4zGUFLoJIMGIxUrPCTPovXSQ3t7FkbJZ5eg+eL0ookjmeImCkyGCfN+Rmm1uQ7cg1PGsfcCCkzSds7zsv9z5jcPDxGENjaj8NNX2+Q1F4mn5lYxxEjvv24mrkFQsMwFpbM2rvlv5P/6odqQ9uUcvP3nrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1dM6M4c; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1dM6M4c"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a54700a463so442453f8f.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344896; x=1753949696; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYRBlSAsmMJQqpXiO3jLj3gEzjVaCAA/hi0uoadvqts=;
        b=I1dM6M4cqNRPmMLbDABWFhJxffAXpr849s1XqcLVCS0IWxSk3XmxeT5he9pCmryu6q
         bT2rtBvVfwNmXIRhuJA48vAXNJvZXDYfEq7SAM4W52oteHrvjsReBggBMSTmF8Rdg4ke
         vUSnqhTrfVHKJ9j24lO9kY/iVkx6arpMhegrEJk+wyRyc6xI9YnVVyXtDupgdce49VDx
         v0qLbUPEM7jWTxsNFaUUrmCisMyt/3NJU86LYd43uj0vYkqvkG85rgi5/knv4dt/h3gS
         oheIvRqi3w3bGjg3azSSGCeah4G0jDquYAB4DhLUPBWesDjWHKvJP8huDVTtvi/ZCebW
         3rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344896; x=1753949696;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYRBlSAsmMJQqpXiO3jLj3gEzjVaCAA/hi0uoadvqts=;
        b=NpU+CB6mFeGx1gzouyDlQ/Siuc5SpK0nZdfhbNkLHqJE9DjY42bnNePtfszHpnjpwi
         nNuV6MmRlIk2qf0PmDQ8TdZ6UYW6eQPWn0Sn9raX5DSeT0ZxfAxEMa+ZnjL/ypJdhS/J
         sMV3YlXrAj9XF17jnOToKijUOh+QbGJCgIyHGAH1J7kxhLpHwMY6L9l7IOLglbH+nKRd
         5UMtUS7fB8DJ3shPzjdYHo9l5WbaPwrEDdjFiAUJSebB8yEb87nofiOTZULHqxgK0vps
         07F4TyF5kUBnjOj3oBgIPN5DPF37CttW7mhJz+8fxth+36DzrT5nRcn9z/CRbp52ux/q
         jO2g==
X-Gm-Message-State: AOJu0YxngprSmG2SuL+xpD1PS96yRcpxwYqy8dH86s0Uf+hZ/rlNrppC
	mpCvUMy6drmk66yrfJ94xD+u+mF1hQ9qRwKxCkMWPG4IhUK0I/zLIjCAwhbE+P4o
X-Gm-Gg: ASbGncvMn/DBGTaG1zj62IsxRHRZWO9mIOTRNFUzpaaq5X+gGnJGx/rFtdfo7y4BI8m
	OM+7UthM8x4kmhSPDDuonIsFv8fEQ85O8CiSbcIGf6SsQyayg7N/1ScoGwryolDCN7ZVTA4JFFp
	qfHSKTtsO931NpEpommFajwEz9DgDZnQ7ERAr6xMSE6AR26Sf9YWvuaFaIetDHZC74R6s1YMvli
	KH/bfhbCtP1/U5cFrxzwRCw28O1aif1di4dmcCBSVlpo9PVx4zgK9WHabDDbJAGKTUCLUPY1Ne1
	FiU5k+5aF1H+RAhx1j+XekYZuyiGeBXRQvxjZRVaQjLvInEoH2TnpyKMrRyWZVSDr1N1Rr5Q89M
	=
X-Google-Smtp-Source: AGHT+IGuAB4uP62zIhXdjOuU2OUIs5Sbg4RGsa69c/v3kRQYWKu8gl0d/QR8xzjfx3Tv9PgnbZnJbQ==
X-Received: by 2002:a05:6000:1a8b:b0:3b6:1cba:a769 with SMTP id ffacd0b85a97d-3b771356cb7mr931783f8f.16.1753344895405;
        Thu, 24 Jul 2025 01:14:55 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586e7d1326sm14678865e9.0.2025.07.24.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:14:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/5] ref-filter: small cleanups and fixes
Date: Thu, 24 Jul 2025 10:14:41 +0200
Message-Id: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHrgWgC/x3MQQqAIBBA0avIrBtQwYKuEi1EpxoyC4ciiO6et
 HyL/x8QKkwCvXqg0MXCe64wjYKw+DwTcqwGq63TnTW4ZpTNp4Qhkc/nIei1mchF27k2Qu2OQhP
 f/3MY3/cDwZAdJmMAAAA=
X-Change-ID: 20250721-kn-small-cleanups-a01fe5d2756d
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=fQ87LiQFKbLRM/i4mjzBsv2E0HvwF8CsCfVWyy4Z7Q0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiB632Gedv70dKFbRNyrwcA3sd0KceXCETgG
 l2iIicDZwOJQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoget9AAoJED7VnySO
 Rox/JvAL/i9Z2tewsa9hcZSZV2CScaz5f6FKygywYsOVZxhw0b7ZSKi0WUV2f1kEYurxKz8YTmB
 YvtDFG2SmdkbpK8M+CyUXVBrWAz8gDJeNWkwJVWQj6yJNTCYWiArRJMySnNB0d7zQFEfHgPZjxK
 XyBOR9K42TF+DqVkHMCBZs+r6D1SdEFycQNkMluCPWEU0hBKvvwKqvnjrvRYov5GOvtDPHI0k+O
 bMOrhcEhJrZp6Yy15DYxQmd6pH8SB9CA0gdF7BHYBG9/ieOvXiGw2D/aQaiEsHMljMZ0AtfF9nn
 QDUn6fmyh2B6YmEuRPCQBcxb1lDN4Gdoe4/ZSfxB1B0pa8gFN9EcZOAlXJdF+GvptAR4OEeXbu5
 rMlXhyDqg9jlAZJyWxbaASGdrIZSpr1u8f3jdp8gxBlu8PrCT52Xivm/eGzaow0e5E/ttWda4/p
 b+o4ZLKSubBaHFsZZu7AOJJ8ARKhSMBXim7xJeWiCT+TCTTIbxOxNqzE9v6sgJ1MC8GVTSWRMo4
 IY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series contains a few of the small fixes and comments which I've
gathered from reviews of my earlier series [1] to add the
'--start-after' flag to 'git-for-each-ref(1)'.

Individually each patch doesn't hold too much weight on its own, but
together these small improvements add up. That said, if these patches
are too small for the noise generated, we could simply drop it or
combine some commits together.

This is based on top of 3f2a94875d (The twelfth batch, 2025-07-21) with
'kn/for-each-ref-skip' merged in.

[1]: https://lore.kernel.org/r/20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc |  9 +++++----
 builtin/for-each-ref.c              |  2 +-
 ref-filter.c                        |  5 +++--
 refs/ref-cache.c                    |  5 +++--
 t/t6302-for-each-ref-filter.sh      | 19 +++++++++++++++++++
 5 files changed, 31 insertions(+), 9 deletions(-)

Karthik Nayak (5):
      ref-cache: use 'size_t' instead of int for length
      for-each-ref: fix documentation argument ordering
      for-each-ref: reword the documentation for '--start-after'
      t6302: add test combining '--start-after' with '--exclude'
      ref-filter: use REF_ITERATOR_SEEK_SET_PREFIX instead of '1'



base-commit: 15fcbd8f16a2c119a5319b0657e52fe0f387df46
change-id: 20250721-kn-small-cleanups-a01fe5d2756d

Thanks
- Karthik

