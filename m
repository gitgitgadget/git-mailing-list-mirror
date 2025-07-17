Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2E6EB79
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784349; cv=none; b=UoIMFe2NDhwEpqHvJUs3sReWPeN6jvxPoC268dpdM/qBBtURJEPyQ/kSwcvGfmWcCIP1OiPtMoQvAO+svTl9JziQxyEu0x3xnpTlwbqWlbDYggYLtd4fNW/IWizijTi2zUesT2ER+LIbVZtKyDpLpLysmvyGVTGdLkrOOWgSCJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784349; c=relaxed/simple;
	bh=TyTLUM3EUAIJFjApDhhBV16Ats45L1XaVYKsN1lZ+as=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=aFjcMqxeg4GEtCAN8gD1ysqbYg64GzcIBThwMwl8THbFsqFp1YEussNU1m6oxgMdzHNN/HtgL2ftetSNFv4plqRWr0+DPTuWuqCfkrBCHgduBorPgyRg6bVvjmkLdmdwTCGkKoAHvTCrePzdx7e9WgvceE1UCyQOdJLHrPe5JV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHYNaULS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHYNaULS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561ca74829so16018895e9.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752784346; x=1753389146; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Tvo8+JnH61yeE0Ep3cAkMPptF+/VPvx5KbeDfU23y8=;
        b=WHYNaULS3iHaw6+Sg6tHKw8226mbH0tU3UDqotBACwR61WwVUvYwFz7YDQ3fkwp8Ev
         2lP28BK1GtKxePU0wjAOOHjWfNvUui9MUQC66i+7oKfwrFkN3DQgSlX83wPexeENN9Cx
         Dd2bBUvuOQoqGf6k/CsT4xvEKWDWSEG46RmYS0qCJji95uSKY6n6ZlKC33TI0k3KrsT/
         sTZ0Sn51/MfQzXdTl51bfOp/J52Fjxmp//YahjEUPvoi8P4vSaHoK3MNtjaLJhWM0IVd
         H9W3nNkfatoi+fU5l1aYE8i9HRMjYpscKe2Yu9HVLWMHUTHUVo3caxa8PWIRwpYUNK89
         Ih1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784346; x=1753389146;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Tvo8+JnH61yeE0Ep3cAkMPptF+/VPvx5KbeDfU23y8=;
        b=HG17eJUtLrhBEqKU8ZEi2NEAna7NGr4Qv6uGHPYUvWoliYT/OWYpLtMPk8g6RlYPvy
         qyhwtMUSIRNW7KBP2y/q8xmwNdo5arvfbHNZjp4B2OnOj8mfOf4jl5ViI3sTrR6NGrZx
         k5apNJstzAkBJTknffFvHtWruM3kfaxIU8N0Ji+I3fccxp3/Ch1m0KsmmBQ0CUsILkyd
         RtDL65FLfkBAYzBCz8sLKxJOwNESxG3j+PwoUhh7Lev6Fn6FidS3CXYBJB9utZxqv1u8
         FKmumaE5ARpPdPnBB2voyFbloIv2XqcjnWkrJwbpUqo10hCWITlI3AUL072J9QRrznRK
         hp+g==
X-Gm-Message-State: AOJu0YxEUzFRbGEfBEWizdgVCuY+hh7WMmjKpo4YGiR53yEJtlECokZU
	diaEygOZIpVjP7d1WkXntugMI4Kn8mSFXhWb53dBfn31k2sS9yYqY/G5zXPLGg==
X-Gm-Gg: ASbGnct7QGa3Rnswin9tTKJfWWL1Yk92ph1dMPIovS/RPcMvaGcjJ2avcmLUpmG8TC6
	cBFURrROi5FC2KG6/l/jJ8HvF3QOecvzEwjxHzL/NLlUFT40R4O7FhlhrSxfChaILqBYFzhWrjI
	bfVnEI2fAAXDoybtQpABWkWEGpmwkEUPZ9gDES6Pqo0IOhmBpJRvjbO3yif8BblUO4YEbcC59n1
	KpNXmKL6DFXoXHCU2jpIQYhUa4rNG4qmViINQ1RDwb7Rz9anT/VBK7QCHsZijOquax/bvJhCTxe
	hzcf6wdFpcBQ1WUHglojCvok1L8ouL+jqCo9ymjiSx6yUcy1TvzWMudgsH9E6Gd5uEvWHKqEeDp
	6Yrj5cyTBYzOzOwz8dgy+0vg=
X-Google-Smtp-Source: AGHT+IG18pxCpgTrGWEjMQ+Lh/RSiFEGyoD+r+8Hm6XqSiBNO4cadr/4yidcTRko/ubvMR8jKTdGTQ==
X-Received: by 2002:a05:600c:6097:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-4562e3c4b98mr64799975e9.26.1752784345622;
        Thu, 17 Jul 2025 13:32:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45630ec9129sm50159245e9.29.2025.07.17.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:32:25 -0700 (PDT)
Message-Id: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 20:32:17 +0000
Subject: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

This series accelerates xdiff by 5-19%.

It also introduces Rust as a hard dependency.

…and it doesn’t yet pass a couple of the github workflows; hints from
Windows experts, and opinions on ambiguous primitives would be appreciated
(see below).

This is just the beginning of many patches that I have to convert portions
of, maybe eventually all of, xdiff to Rust. While working on that
conversion, I found several ways to clarify the code, along with some
optimizations.

So...

This obviously raises the question of whether we are ready to accept a hard
dependency on Rust. Previous discussions on the mailing list and at Git
Merge 2024 have not answered that question. If not now, will we be willing
to accept such a hard dependency later? And what route do we want to take to
get there?

About the optimizations in this series:

1. xdiff currently uses DJB2a for hashing (even though it is not explicitly named as such). This is an older hashing algorithm, and modern alternatives are superior. I chose xxhash because it’s faster, more collision resistant, and designed to be a standard. Other hash algorithms like aHash, MurMurHash, SipHash, and Fnv1a were considered, but my local testing made me feel like xxhash was the best choice for usage in xdiff.

2. In support of switching to xxhash, parsing and hashing were split into separate steps. And it turns out that memchr() is faster for parsing than character-by-character iteration.


About the workflow builds/tests that aren’t working with this series:

1. Windows fails to build. I don’t know which rust toolchain is even correct for this or if multiple are needed.  Example failed build: https://github.com/git/git/actions/runs/16353209191

2. I386/ubuntu:focal will build, but fails the tests. The kernel reports the bitness as 64 despite the container being 32. I believe the issue is that C uses ambiguous primitives (which differ in size between platforms). The new code should use unambiguous primitives from Rust (u32, u64, etc.) rather than perpetuating ambiguous primitive types.  Since the current xdiff API hardcodes the ambiguous types, though, those places will need to be migrated to unambiguous primitives. Much of the C code needs a slight refactor to be compatible with the Rust FFI and usually requires converting ambiguous to unambiguous types. What does this community think of this approach?


My brother (Elijah, cc’ed) has been guiding and reviewing my work here.

Ezekiel Newren (7):
  xdiff: introduce rust
  xdiff/xprepare: remove superfluous forward declarations
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: make fields of xrecord_t Rust friendly
  xdiff: separate parsing lines from hashing them
  xdiff: conditionally use Rust's implementation of xxhash
  github_workflows: install rust

 .github/workflows/main.yml |   1 +
 .gitignore                 |   1 +
 Makefile                   |  60 +++++++---
 build_rust.sh              |  59 ++++++++++
 ci/install-dependencies.sh |  14 +--
 ci/install-rust.sh         |  33 ++++++
 ci/lib.sh                  |   8 ++
 ci/make-test-artifacts.sh  |   7 ++
 ci/run-build-and-tests.sh  |  10 ++
 git-compat-util.h          |  17 +++
 meson.build                |  40 +++++--
 rust/Cargo.lock            |  21 ++++
 rust/Cargo.toml            |   6 +
 rust/interop/Cargo.toml    |  14 +++
 rust/interop/src/lib.rs    |   0
 rust/xdiff/Cargo.toml      |  16 +++
 rust/xdiff/src/lib.rs      |   7 ++
 xdiff/xdiffi.c             |   8 +-
 xdiff/xemit.c              |   2 +-
 xdiff/xmerge.c             |  14 +--
 xdiff/xpatience.c          |   2 +-
 xdiff/xprepare.c           | 226 ++++++++++++++++++-------------------
 xdiff/xtypes.h             |   9 +-
 xdiff/xutils.c             |   4 +-
 24 files changed, 414 insertions(+), 165 deletions(-)
 create mode 100755 build_rust.sh
 create mode 100644 ci/install-rust.sh
 create mode 100644 rust/Cargo.lock
 create mode 100644 rust/Cargo.toml
 create mode 100644 rust/interop/Cargo.toml
 create mode 100644 rust/interop/src/lib.rs
 create mode 100644 rust/xdiff/Cargo.toml
 create mode 100644 rust/xdiff/src/lib.rs


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1980%2Fezekielnewren%2Fxdiff_rust_speedup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1980/ezekielnewren/xdiff_rust_speedup-v1
Pull-Request: https://github.com/git/git/pull/1980
-- 
gitgitgadget
