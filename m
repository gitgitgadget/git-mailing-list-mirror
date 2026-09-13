Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606C36F8F2
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789315039; cv=none; b=G+UdzMEALrMeagS9fAuFzwrFQz0IukwKRr4jibaACofNaRt9JzGAz2p4UCXkfqr+dHUSETyVsx3Cq1zcIdKn2ePN17WoJbpR+2csTGdTGAUm3yA3G8SseXdr9XgZRnR2hxuac0pSJz/5U+xKZPpS0LgAJVRr5NtDAyfcDOjC1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789315039; c=relaxed/simple;
	bh=jpuIPORCkuC6X+ePCQOAbqBxtAWbBnS+IbOAxwMnHd4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OoZq9Pwmiie97be9VAswtTBnl8x3fk+Q+VlF7BgXs8FtoKrPMgMlhKZfP9HKp7CeCEBnYOMj53C+hZPeq6D7uMNHENb+9F7CMxbi+UVDZ/nzvoTsvcuO4XXGV3FszxWYcgR421UQbnQlqUaDlzW8OwBt/4eKbC5q0MtN86rMhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIWC11F6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIWC11F6"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2200317a91.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789315037; x=1789919837; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w3K/u+P88PBfhmazXlSGPe71t0FVVNCHXYJIPfIoWSg=;
        b=QIWC11F6rSlejfONZKecqnNHY70qC0e9Wq98I/Q7lce6PvFFlEShjpsFDDwK6Fls0z
         p1Ll8D5TjsPJ5CQQfHkpa49I1UK3sl2jByKmieOvY11Wy8my0O1FoZWBtfXoShrL7JsF
         pjtE/UhVaOMcv/EZY5YswZHUL3mYAjmrSB/gE8OFamNObkXxONvuISlHEZaYlv177MpD
         dHm6SzcZs5zLTxYXsRF8K+BkvS8QJAWKuq0uWqDzUHb0XdHxGYedLuiSbBLrhkr2WpCW
         KJDEM/JKyDTLuzhlQeSBd4FAU++9RdLCALNpr0ljHVMj9Kuqdb0YYGaEXHpfRzF3UF+W
         fkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789315037; x=1789919837;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3K/u+P88PBfhmazXlSGPe71t0FVVNCHXYJIPfIoWSg=;
        b=LNLgFQU17r8z3PLpiH4sf+UkNf71/88zC5+E3NV6GkuusuT2SIAYTECKoInBkfW+OM
         0Y7HEenDgvHFNCvSw31UexkQcE1i/0z9oUnvgbmqgORcPgDd1IBsyVYdPuSCHtdKhTqP
         1l1YDh4CunOrw+NSXYdgK5j6mluS+vme8fzzl9MfGWKY8D9qFafoQGK0LYGB/I7zg4wG
         YQJy4t1Zyo1s+B4NmfIxZq52tGFbHVljZPviFna44KK+B0P/urFQ/EkpxXDpAf049B5C
         2FryWUCw92kzkSr4aVv+8cJ/treIqjhWkLw5wpWaz48oKBGHEpG9EAyT2xXFPbEFdgEp
         G/2w==
X-Gm-Message-State: AFuF++lEYb0w6YgF75LBXQSiSy3l/EEUVQTX2Wk0YLcvECDnU3GJ12WR
	Zt1zCq81mQWVR93rCb1LYvGcvwJvKBxHPPjiHDo9DiOZ1fmW1kV0kKnWYGBB4Q==
X-Gm-Gg: AYBFou1byDEaDnPz4KuS4oWBEQHMyfTOs/VPmFEQVJ7NF4kDxvo7ewWyFeUYMRg9tD4
	9nM3mJldQ9iMkC26o51i7ZhpC8FUkFpvFfC9RoI28djiz8VXzN9O9/fw1D4j3KDWWhtC6upq9J3
	W+I/6x5rwwLivyNXIKW58aUYMdMLy7x/s4QRQBCivBwRRQMOlx9pRxSq9lEv6euoKgkQSQG9iN/
	nSswgx5lUsBkcfL86kAJiUtOoYBUt2QINao50K85jcKPp7FOEpsTk9nZVRMHmns5t6VHnfdsaG1
	bCVJziuXEo1J+f6QyhnODPJQ7rILIFDrXSPs+oH9VCBpfHg+byKp/Nxfipm0iWNofNK6k0xalbh
	8NQ4EvBfL5pFKKf8IFIZP1zQlXgZ5zuJQ1DQq+S7dSSxfOaZe0sGbXTRwqFAJcPWz8foDnN3U5+
	SS8UdolTvL8yR0cQTJZvcRVDm4ZpJ0DmNh6ha3+oqVqwy8/ODFPx2bqvnFYz3e91KX7fxPim/DL
	A0=
X-Received: by 2002:a17:90b:4c11:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-39d9b96848amr23020207a91.0.1789315036785;
        Sun, 13 Sep 2026 08:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed79absm22985818eec.17.2026.09.13.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 08:57:16 -0700 (PDT)
Message-Id: <f6c2f52fb35944b8b9122e2184645613c57973aa.1789315032.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 15:57:12 +0000
Subject: [PATCH v4 2/2] ci(windows): build with Rust
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    James Le Cuirot <chewi@gentoo.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Windows runners used by Git's GitHub workflow's `windows-build` job
ship `rustup` plus a `*-pc-windows-msvc` default toolchain (see
https://github.com/actions/runner-images/blob/main/images/windows/Windows2022-Readme.md
and
https://github.com/actions/partner-runner-images/blob/main/images/arm-windows-11-image.md),
but no precompiled `std` for `*-pc-windows-gnu` or
`*-pc-windows-gnullvm`. With the Makefile now picking a GCC-compatible
target triple based on `$(MSYSTEM)`, the build step needs that
precompiled `std` to be installed before invoking `make`, otherwise
`cargo build --target <triple>` fails to find a usable `std` for the
chosen target.

Add a step between the SDK setup and the `make` invocation that selects
the matching triple from `$MSYSTEM` (which
`git-for-windows/setup-git-for-windows-sdk` exports for every subsequent
step) and runs `rustup target add` for it. The mapping mirrors what
`config.mak.uname` derives from `$(MSYSTEM)` and `$(HOST_CPU)`, just
enumerated explicitly here since CI has direct knowledge of which MSYS2
subsystems the matrix actually exercises (`CLANGARM64` for the ARM64
runner, `MINGW64` for the x86_64 runner). Technically, we only need to
handle MINGW64 at present, but the switch to UCRT64 is imminent, and the
other case arms serve as a very fine documentation of what people should
do for other MSYSTEM values.

For a `staticlib` crate-type `cargo build` does not invoke an external
linker, so no further toolchain components (e.g. the `gnullvm` LLVM
linker) need to be installed; `rustup target add` alone is sufficient.

Assisted-by: Claude Opus 4.7
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 ci/lib.sh                  |  3 ---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 85cfedf5b0..0972547395 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -114,6 +114,30 @@ jobs:
     steps:
     - uses: actions/checkout@v6
     - uses: git-for-windows/setup-git-for-windows-sdk@v2
+    - name: Install GCC-compatible Rust target
+      shell: bash
+      run: |
+        # The hosted Windows runners ship a rustup-managed Rust whose
+        # default toolchain targets the MSVC ABI. That produces a
+        # `gitcore.lib` which the MinGW GCC used by the rest of the
+        # build cannot link. Install the precompiled `std` for a
+        # GCC-compatible target triple matching the MSYS2 subsystem;
+        # the Makefile selects the same triple via $(MSYSTEM) and
+        # passes it to `cargo build --target`.
+        case "$MSYSTEM" in
+        CLANGARM64) target=aarch64-pc-windows-gnullvm ;;
+        CLANG64)    target=x86_64-pc-windows-gnullvm  ;;
+        CLANG32)    target=i686-pc-windows-gnullvm    ;;
+        UCRT64)     target=x86_64-pc-windows-gnu      ;;
+        MINGW64)    target=x86_64-pc-windows-gnu      ;;
+        MINGW32)    target=i686-pc-windows-gnu        ;;
+        *) echo "::error::Unsupported MSYSTEM: $MSYSTEM"; exit 1 ;;
+        esac &&
+        rustup target add "$target" &&
+
+        # Ensure that cargo.exe is found even with the minimal SDK's restricted PATH
+        CARGO="$(type -p cargo.exe)" &&
+        echo "export PATH=\$PATH:${CARGO%/cargo.exe}" >>/etc/profile
     - name: build
       shell: bash
       env:
diff --git a/ci/lib.sh b/ci/lib.sh
index 6c52154eac..c6ccbf8c17 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -391,9 +391,6 @@ linux-asan-ubsan)
 osx-meson)
 	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=osxkeychain"
 	;;
-windows-*)
-	export NO_RUST=UnfortunatelyYes
-	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
gitgitgadget
