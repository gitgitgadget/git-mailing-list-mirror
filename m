Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CB34F497
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295485; cv=none; b=LtaNKbEAAm8t2wZUQQozkAxwDt3pb5GSzeT1eK2yMtXzWa5Y48L5gBpxPsti9Kne62qGWaT20hgmYIn0FWi0cX5hSZIHCCLhzwQ/zI6pwcCPvvSRjQDWjYwg8wqfuLVVjpiYfPfGpPz8AFa89h5sFwFsWb8G+5mVGtJFXFOqqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295485; c=relaxed/simple;
	bh=jpuIPORCkuC6X+ePCQOAbqBxtAWbBnS+IbOAxwMnHd4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NLFj74drBoJmLZTHyOLi1bwoEyubmewj1iaGNdQ6QOhaIpfcXB2IMWCd4UQrdNem/jvJKv1TzvVVKF0t++oCL8RjSzHu4idyy3jezaze6pbbZwqkGXdTfuccJ+nhM1b6yFV9/FmstdlpL5u3CSYbZ9jpuQSyT3gTVCH0EKaYHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0yLBVSK; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0yLBVSK"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso16631996d6.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789295481; x=1789900281; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w3K/u+P88PBfhmazXlSGPe71t0FVVNCHXYJIPfIoWSg=;
        b=a0yLBVSKWBFEw6xKdqc35uR/PkvqdvxAYBdHiD8wyahFWKncD0sY52PbXZph21l8/c
         BiyllVhpnv+zeLVvdidDPePm6/9huByS+K0PO/4oPbjTJej+61oQF/g3M/ByLpCp0Or+
         D8lSbKFJcb+MS2t5A6kLzCfBcqL+IC+hPNG7E46wP0+R+VIPujlNpY44vPbquz9iKY0l
         s1KAWZ1wnAQYnKLoCkLW1fLisgWR5gkHagY7LpaEkbu8NID0hDmXi4VNM8IuwnMaXC09
         xYd3l+Kv9zJtHtFBuzUDqVi/IH1ZPFBM+4A6ColVFfyHydY/l7cfKj5/kz6Mjs3Rn6Xp
         rUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295481; x=1789900281;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3K/u+P88PBfhmazXlSGPe71t0FVVNCHXYJIPfIoWSg=;
        b=m4jz5YFhXXwGHvLWAglS8FO3m70tivg1sIvr2mLeAN0zMKJ6DKD89BPZswGMebuLia
         n0CFE7UMqmkZ2iD+PY9sP6UuIFWMQFSONIv0cDv9slAZQu2ZhqT8jfvLOTIcioJ+2aVe
         hOHeJzd4x8b31O2WTtDGoJXMrzGEXaHwXubreOYKsGgg16PyaEdBcUJp0quRABRdY68b
         Nx9XY3JwPOpAC9QOk0j5AnABcjyX1R1Kk1Ftr3c4PfoB4mIK4q7bRHqpeIkm7BurrYLc
         B/1+LhN3Fzr73miPwf9tApQKdE4pJ1dhOl0AzRU1r6t+0ztlL9EYTc/A/bESvHvWc+z/
         rRfg==
X-Gm-Message-State: AFuF++m7waeZH5YIK/2yfK6WkK4BpKDuICuoezkC6YmQ/+CUG46GGWCC
	D03SruMbx0ryYT/T2LPFrLLseegHOprFa10pu4YY1kFIu2JHkcnA1BAsrko3XGiD
X-Gm-Gg: AYBFou3pgUNBriRmrVSGMjeFFnaKSOecuupV2tAn8DBwVbwtuLaYnuJFdv7ShNa1y5a
	D9Js3FTCmun3plQkDN1iUV2g4K78n8n1A7wmjJgn0HrhRXAo5ODtOD67rrrc7u6wHbLcBXsXEup
	MyUtQatYhagugNAnFtd6CrHZeuSbO4KXoSc+h3cToKY++U7dfxqqBZV/vrXZNL/OP2WAzrPxfGY
	xhh1Cify/sQqRoXzICaDp8lhQMuQEXVb47QVK5ZnitPUe2tZ+IHO+sNmUDxMogjya1g2CFratox
	7UzJgCqKwtLSHSn2aADwfUtsNT4FD6R5Wx4XLEHI3SUH7YmI6NeMvKau4SSTy1mgkefyldKQe7r
	CLsTXxLSPW65qMMd/Iir7HTeHBjR4ScTkyQRQLcqLHCohMF4CQ76RVRia8wls7kfQRXTwd2136S
	AXDtwrXbFETRfp494HQX5bkWgVGIFmp3qAzPFSK7d+j17dlLG4jn1LNouqMjy0c9ezYhIP1zf3x
	vE=
X-Received: by 2002:ac8:6907:0:b0:530:fede:bc9e with SMTP id d75a77b69052e-530fedec173mr13465691cf.50.1789295481170;
        Sun, 13 Sep 2026 03:31:21 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.119.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca30855csm68443561cf.1.2026.09.13.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 03:31:20 -0700 (PDT)
Message-Id: <76469029ff9ea99fa552c2b65da3c0957e2d73f5.1789295476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.v3.git.1789295476.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v3.git.1789295476.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 10:31:16 +0000
Subject: [PATCH v3 2/2] ci(windows): build with Rust
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
