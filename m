Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1A34EF07
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789315037; cv=none; b=FbR6eT3dVcultHdsBOc2ztueQ2cwNORtILqh+fR/7rHyEBJqWwiPy7Yel8mYsFpVHLJ5wZjh+SwjV6fQk3mwks0ZVNl1Bl5qGo2HdyxsNQcf1wyEDorgi/ALqYxggNQfUB/fHQi0h9vlifjC3fzTVGh/S/XjVXHXOTdAfOciLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789315037; c=relaxed/simple;
	bh=xnZFOEGiUHAe119rstOncsp91jrrJaIKKxuP0AjawPI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nX72Jp51Jbx+CB5adVBjnS2mJl40vcGSa3HJDHC0Jh9uwIrUlUyWfY2jNP7ZULDy2wiL3aJsrZpIQlXmv5ZHnoWTRC+qFVYyn6d1JiKAPAMfSkTIXuhf90T1/QtjCyzy9I64NdqOg9dSd6dNbxthS24uMlao5Jj2/ZaiukTvj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWkZJYc5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWkZJYc5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso24988645ad.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789315036; x=1789919836; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4jS43hAq3jGgXzuEyiVQgRJaAICK5d3l/JjPKq4xGQU=;
        b=iWkZJYc5pr7M41SWV7rYZSLU9g1+wfuGMMOVg6o9HDX5vAtz0/cQEDoPXTyHDYhy1e
         I+GdCSMLrH3VrrXrsq6eJ1cfNxyk6ZwvGwYT8NVYuLk5KvZ6HwSM61xG67GqjpqrI77d
         VzHMqq0RCOmXjN5DNeaG+gIaW49ybp/QqPIONVuCDH9owrteaivhRYsMDocpFMWILLoU
         UF3Wf03ty1mBIjSWRCKfSYFvzkKcS9qOoi2eZO6bu6vTybWN6j1ihSwu3BlFw4KjenFO
         p09BozjAy27HbqbeblAQpNOsuo/pWqOcDUFXFrMqxkCWGNpFJ3az0+I+Pl0WA77nPKHd
         baNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789315036; x=1789919836;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jS43hAq3jGgXzuEyiVQgRJaAICK5d3l/JjPKq4xGQU=;
        b=AJKg2DYuImSfjNiDo4xkLbGzV7BCwTMIjlFRiyaIZCXsv7VTEkcabC+WIbz6x2pgaU
         TAoHp90xNO+mmEyZFeId7C0IaDMVgL28ubJ0LB4X2El6WENJvX/lQNh+lkcvQEmNvvPJ
         +ETwwN1WZQGYsVKrGSSbkMcpdnqkCJo3MouZRPiDKIjXtRadGiTkhK2M3RE+NCkzNIsh
         8UPhjvwwCelm52dH9sr1mO6lHPH8wQRm4NFW+YTkw66/fzfJaAcwWWt83oSLCUfiWamw
         P2kka/dtkTcRr3XfPYSUPVz+PajqYaqlB4grOars32W4h/fumAI+s6aGtJJgrkYYv6sk
         SBSA==
X-Gm-Message-State: AFuF++mLCK9ttiPC5vBu40ACuF3nc9eZx2eBQCZ7ggC9BAR1GMgApIQc
	X+0dld5xvTyLbEPe6rFCqTFEuYtfpPgw4PaJFh87R8e6Zg0+HXKtmNdeobYaXA==
X-Gm-Gg: AYBFou3RUxg/yb54DMCKfwdpERA9QqNcnuKL4BRRB5OFd5DzBHG4QkBxPQg8LW9HZ00
	4cl+AgdVtAlPl/A8GUBO0yeoiIk5HPf1QtO/hLV/clARBIVyyEwByoCX6X7efaJN7Ulb2CCJWH/
	Xj5ks/6rX9jKcWEKeUSFwNlQbHjTFmmJDFFZq4K4s6JkGzm0Lnc0gZjGE3UY8Y/JF0VTnXBNqpk
	dhyE3YqRLGCphprDbFZhql+r/QQsJ7WRupZSNWb++HM3tCeSyj6U/yQDXijaCT3d9UcjfMnitZ0
	8AqVNiaVTt8i0QlcLvrFQ1l0Cp8zBuDDzapvEn8lj5e3MHnWTmw+ALsn3FGlNifp8ZI5+dLSghe
	oRXr6pHjNnegxx0ZV3oqCtG/Ud6wz4ba1+cF2CI4Qxlqoqj/7HVugeTpQL/OdceSEJBua+TOxad
	mFNtSwT79Dkt5liW24Rx0k2oqDRpimwsBaqYE3qhfjfONuwAgPhpp++NSay1MwX9lJqK487EmHn
	Ks=
X-Received: by 2002:a17:902:c952:b0:2d9:56dd:f804 with SMTP id d9443c01a7336-2dd2a33646cmr233838025ad.13.1789315035634;
        Sun, 13 Sep 2026 08:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed79absm22985642eec.17.2026.09.13.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 08:57:15 -0700 (PDT)
Message-Id: <6e8648b21cc88d0a79c3fdff51ba5539ff642145.1789315032.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 15:57:11 +0000
Subject: [PATCH v4 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
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

When Git is built under MSYS2/MinGW with Rust support enabled, the
Makefile expects `cargo build` to drop a `target/release/libgitcore.a`
that is linkable by the same MinGW GCC used for every other object. With
Rust installed via `rustup` (the way it ships on the GitHub-hosted
`windows-2022` and `windows-11-arm` runners that build git/git and its
forks), the default toolchain targets the MSVC ABI; cargo then writes
`target/release/gitcore.lib` instead, which the MinGW `ld.exe` cannot
consume:

    LINK git-shell.exe
    D:\git-sdk-64-minimal\mingw64\bin/ld.exe: cannot find target/release/libgitcore.a: No such file or directory
    collect2.exe: error: ld returned 1 exit status

See https://github.com/microsoft/git/actions/runs/27341625000 for a
full example log.

Let's define the correct target, using the `CARGO_BUILD_TARGET` variable
that will be picked up by Rust, see
https://dirname.github.io/rust-std-doc/cargo/reference/environment-variables.html#:~:text=CARGO%5FBUILD%5FTARGET

Re-use (and fix) the existing `HOST_CPU` variable to determine the
correct value. Avoid relying on environment variables that are simply
not defined in Git for Windows' minimal SDK that Git uses in its CI
runs.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile         |  2 +-
 config.mak.uname | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fac3e8879c..ad1ba26f91 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
 else
 RUST_LIB_NAME = libgitcore.a
 endif
-RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
+RUST_LIB = target$(if $(CARGO_BUILD_TARGET),/$(CARGO_BUILD_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
diff --git a/config.mak.uname b/config.mak.uname
index 0b63be10b7..f3f3bcc4ef 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,7 +758,30 @@ ifeq ($(uname_S),MINGW)
 			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
                 endif
 		prefix = $(MINGW_PREFIX)
-		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
+
+		# A rustup-managed Rust on Windows defaults to the MSVC ABI and
+		# produces a `gitcore.lib` that the MinGW `ld.exe` cannot link.
+		# Pick a GCC-compatible Rust target triple matching the MSYS2
+		# subsystem instead: `*-pc-windows-gnullvm` for the Clang/LLVM
+		# subsystems (which on Windows is also the only choice for
+		# ARM64, where no MinGW-GCC port exists) and `*-pc-windows-gnu`
+		# for the MSVCRT-based MinGW subsystems. For a `staticlib`
+		# crate-type Cargo does not invoke an external linker, so
+		# `rustup target add <triple>` is sufficient.
+                ifneq (,$(filter %ARM64, $(MSYSTEM)))
+			HOST_CPU = aarch64
+                else ifneq (,$(filter %32, $(MSYSTEM)))
+			HOST_CPU = i686
+                else
+			HOST_CPU = x86_64
+                endif
+                ifneq (,$(filter CLANG%, $(MSYSTEM)))
+			CARGO_BUILD_TARGET = $(HOST_CPU)-pc-windows-gnullvm
+                else
+			CARGO_BUILD_TARGET = $(HOST_CPU)-pc-windows-gnu
+                endif
+		export CARGO_BUILD_TARGET
+
 		BASIC_LDFLAGS += -Wl,--pic-executable
 		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
 			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \
-- 
gitgitgadget

