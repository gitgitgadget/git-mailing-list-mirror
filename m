Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CB3B14D0
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272518; cv=none; b=KrWmFjBdvI6oSUZJrK3YkfLzxl1duuEXuU5ljxQ2E3rOERwGTSUScngXGgg02bOOY0ELM6PDPSIZ1C0edP6tp7QuwA6GEqNQe4T1pfwKVYWFnnJ2EUePEenLx9+Hoxcs5hrUxqwK8KYeH4jw90vhIbdgpMNz4dX4lIT1V2STSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272518; c=relaxed/simple;
	bh=xvOLceDWsKebrIqtZrybEkp7hM7uZ7gmBmeMRIECuM4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i9y3vg0qfhRMVHqUvuHaWOwYuUIWL9B/LepqqkAVbq6sqjFclEgXKnZpA0CkTPucJTxkg0UHp8PGQ+Cu7mbmkJ53jihVOA584MRuVZfmUrG76DOEjiNUWgX8k8Jk9ajcpLGobNphiUhdbX+qBIuIe8T77+c46TTupR+iHzkeKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5AmPPFG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5AmPPFG"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9371bcf1f8fso347459685a.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272515; x=1788877315; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UMtObwUrDNmmFpfjW7+vU8cK/N1GIogid0JSAc4ngD8=;
        b=c5AmPPFG7wtBO43Aa+ugU0T+AkRCGadv3EeQqR5PUv8QNTMpQGflM2t61I1yUIED0Q
         4TeoX6cfGdnsBxAQRJ6xpf0OVmGbofHj2Qpt+HLzoKofWmAofekkueQiv4zdnHO657H/
         0QlzURpBqgZX0GweHdBwOaItSAAiizFiG74dYEP4uy3hjSUpXe+3jR1c5Tat9WLi0UEk
         DlrkTwf1Q5h3hrekDrGAFNMDHERkQ+c3hJnRuhs9ML++Eu6JiUz8mhzwloWirS6WISDs
         ikyOasW0wKXLWDj+Q99UHAQ5wOcLU8utKid6mREEb+tl9xNGBK1Xh9JZuLiZJ4B+165T
         P7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272515; x=1788877315;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UMtObwUrDNmmFpfjW7+vU8cK/N1GIogid0JSAc4ngD8=;
        b=HC+doqd5OZjmIQuWAr7aMkqdeu30w9aGgXyxmPGRa71AUvNxXhmBlOy6a8+mLVOwoH
         V0eG6g4Ad+qNhVuUYVUVumDsE8kIREvRVtXobDlf2TjGVBAkmlQFGUw52RpKBkUVWE+w
         ywFSz/aN1nbE2/1YaGAU/BDyMD2RPurqIH02qWHwhBm/UWct4LAjFHQHVFZUWqKEAlSM
         zS+mwCuUrY236va5hz088VNTO6TW+naXkuxeQ8zOkfbGRG7aGlIsuScYP++QvyDocGKH
         JL0ugV+j2Lw2a2e3M0AGxKabVCGReL+XiP5TS00vAVUqQvr0d6aPjyfgEtBkMsVt/9yg
         ALqQ==
X-Gm-Message-State: AFuF++kTrxYWloQIVg/CtPzzFDgBy+3FftVKhDvSqJ9TUTe3T+CkkOBE
	Lw3OUqpsEp3ZNuJk/OU0g4kDlaGLF/BvrEaJbX3Ri0iLHoMRmf42M+lTmRr+6IdH
X-Gm-Gg: AR+sD12gVqzaZe8FYHQVNe9IqBI1zpZnoJNKZF2VdApChqMasPuhfTtY+sRpWYdbErr
	0E4aQe+UwVordpmGE8LliIiGjr7axjQlQ/brSGxhmgoONH7OLfp+SUP69ptzILbvLc/5u1b/uZ/
	enj2P4Bi0+PXYS5li6hyKnEX4LzSlbxLVN5llQnw+yEgUMrjCXE7HLS7PRq6b5FLMAhODbJfkzL
	dO4mxGxWYFvqGOaQVZ63AfBCjTcZXtsslV7nHFrAVaDZzOxlguDPijYlKju9OQBU5KCjqiY1/t+
	10rKHwCmRHP/mFAmfc7FYdgmJygOKQ9LN8PBGaCv9LNUpYSEWigMi7KphUrQ2koPOOT6CkRnQFM
	8qZUrlBfUQJm/HxRxiwQyjrs22EzEBt7sG5ReuYIbFDW+sWDQ3tEJmbA4Rhb3beixd2UU7mYhnO
	79Oj0w6V5ZTFvGRl1N9wY//TDQY65stLjrnW+ZOb5+H7q6/MxZMjatA1FOiqNix68=
X-Received: by 2002:a05:620a:8086:b0:939:16f6:4d01 with SMTP id af79cd13be357-93916f64e85mr3727770685a.21.1788272515060;
        Tue, 01 Sep 2026 07:21:55 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.218.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93918b0f825sm1016995785a.40.2026.09.01.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:21:54 -0700 (PDT)
Message-Id: <7a24630fb944aa34adebde1e9087383080c04406.1788272509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 14:21:49 +0000
Subject: [PATCH 2/2] ci(windows): build with Rust
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
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 ci/lib.sh                  |  3 ---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 85cfedf5b0..d85e6c434f 100644
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
+        UCRT64)     target=x86_64-pc-windows-gnullvm  ;;
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
