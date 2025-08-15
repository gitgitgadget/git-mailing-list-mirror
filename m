Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05F1D416C
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220988; cv=none; b=ebijwk2Nnt94dYj4+IBtGVYb3dKHxSbaBBh2j0B3Pe/v1GqhZkeL/dQpwHGnvTY6zBa3atwbXjP8nuqPYYpBqma4YBqdXfeXAEV2Wa32sSFmQaxgwGYFasNmqgMnkx4AZz00oeAf82TrMAvP8nIHfdmKAVC80o4rrcPj5YSQK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220988; c=relaxed/simple;
	bh=/Nwtk1e1yZHl14h51J2nWyByzc7JLY/i8J5Xvx25doE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oKWeu35+PMuJxg98369Z5dZBA1lz9bmr/VFSY5niWHhEblKEPET3aEIveDxK3PboqiuqCNUPaRKkZiFFTjErAA6VhZIj4srZvHYu0NoyHQ0vlXl48S10/yFUSCxstj+ynq6IXquDTtD+TGfLbIQ3H4Mm/4moL5CXZN+0L2a85xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz75/csg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz75/csg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b097037so8420325e9.2
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220985; x=1755825785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZGalV+gv4Cl3vmLIikV7I9lrhMUwt3Hi2uzm2QuQ3k=;
        b=mz75/csgEtcPypeao844XwIVSb+J8tWTnwt/nn5ARvnnchzYcx5dNbGAyas4TLLgYT
         HscPXR20d7vBITiD1TnTsEga9NIZWCwuyNcsaGr9Vk4+qtNIPnzqPcTCzUFyYNjoBaYC
         a9vsswDy9TscXEmunLTPW97mEOJjP7iG9PbFEpSqSvX9aoMc7+AvfwmePXOGKw6ET2P1
         If5Qug14AKZvQno3nbzqACcv56jhF83wCPvf9zTIA/knflf37EX0Nny7WfXuQAo/SZMF
         zNe3zKbanZL76i0SPK7oXbc9SVYamTajbFcFvmQhwykmf8auMTkOnXR9wIPfOJwIwDVA
         tuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220985; x=1755825785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZGalV+gv4Cl3vmLIikV7I9lrhMUwt3Hi2uzm2QuQ3k=;
        b=RNvAJe4dJPDF4WYGii/zoRbrLw1OffBS7bSHfLaXxIRl2SWdb3VuFKfGRs7F7jwYNV
         hF9ENBsuMU+pIkStafjIhOtK7nSsUDvBHMqNoushTGlp0LFYCt20HbTv54ARxGysw1Bq
         F9bH6FefGybthbJZJjz74OaVI5+ZKrjNjLJncfDXdrOqj0zXNhDxTp06drJ75APoKVLo
         X4dT9bwGKuDZ/OXbPElmBWtR5zfOKG8wlBwttqzOLX99BnefwF5VeWU9u1MUd3nE557T
         ti0vlegjYqFaZVKD+LrcrTNSzdmObnGjD+wZxsdjDFDtYZ3MKtdR+y3q48hhk2A++f0s
         fZJg==
X-Gm-Message-State: AOJu0Ywx2jFnAQyeBBYzGDWRxkA3niIeVLKmc9apx1wlYPRoJtwG30/j
	jtvrrlM8BNAInoyRpD7HxKgj0VN7csrGLW6Eh9iwkiAK5f65iFpG0cg/2BAjrw==
X-Gm-Gg: ASbGncscFQaFHVdntzP4yQcwe0D2RdDvOPuAA6PRjDKjyEkSID9Tuo+d2jsSLDVFaOM
	+KC1XA+WqqFeF6/0yM/u1ITuOmz82wTA8p4VTD4fiVcLXR/18pQp87cSxs+S5wetRXXFUgvWeHe
	IpFbrfGonORtK6fTFliAY2RnvJ3VrJFzHGkTEoINcjXq+e85MMvAzgSm1eriXKzvGwuOvsfbQ2P
	X6rqMSQr7175cPSdidwQMU5q0RDHKgYZqaL4u94f0VuQHFOk6jHImDU043Uvq54y3JJYwT6kbE7
	6cGLj6TYu11hrntwXUfyYXh9fkVUfxNCjHxwQjo+czMinkbA6C8sSxzw900QoYWaHYl3O0YrCtU
	0eNK3G4EluXR/BVK4BbyxIck=
X-Google-Smtp-Source: AGHT+IGF7kqnWiSDZE39M1bY0T3TWhOvqdUXj1V3F/iNbhtRF3M4IUGpbY8Ovu7CTDg82mBBi62H2g==
X-Received: by 2002:a05:600c:46cb:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45a21843b7amr2418035e9.33.1755220985078;
        Thu, 14 Aug 2025 18:23:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22144594sm240255e9.21.2025.08.14.18.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:04 -0700 (PDT)
Message-Id: <382067a09e34f63ca33d7ba40d828e8236405fba.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:46 +0000
Subject: [PATCH v2 11/17] win+Meson: do allow linking with the Rust-built
 xdiff
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
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When linking against the Rust-built `xdiff`, there is now a new required
dependency: Without _also_ linking to the system library `userenv`, the
compile would fail with this error message:

  xdiff.lib(std-c85e9beb7923f636.std.df32d1bc89881d89-cgu.0.rcgu.o) :
  error LNK2019: unresolved external symbol __imp_GetUserProfileDirectoryW
  referenced in function _ZN3std3env8home_dir17hfd1c3b6676cd78f6E

Therefore, just like we do in case of Makefile-based builds on Windows,
we now also link to that library when building with Meson.

Note that if we only have Rust depend upon libuserenv then at link time
GCC would complain about:

  undefined reference to `GetUserProfileDirectoryW'

Apparently there is _some_ closure that gets compiled in that requires
this function, and that in turn forces Git to link to libuserenv.

This is a new requirement, and therefore has not been made part of the
"minimal Git for Windows SDK".

In the near future, I intend to include it, but for now let's just
ensure that the file is added manually if it is missing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[en: Squashed a few of Johannes's patches, and moved lib userenv
 handling from an earlier patch]
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml | 8 ++++++++
 config.mak.uname           | 2 ++
 meson.build                | 1 +
 3 files changed, 11 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 8aac18a6ba45..aa18742f08c4 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -115,6 +115,14 @@ jobs:
     steps:
     - uses: actions/checkout@v4
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - name: ensure that libuserenv.a is present
+      shell: bash
+      run: |
+        cd /mingw64/lib && {
+          test -f libuserenv.a ||
+          /c/Program\ Files/Git/mingw64/bin/curl -Lo libuserenv.a \
+            https://github.com/git-for-windows/git-sdk-64/raw/HEAD/mingw64/lib/libuserenv.a
+        }
     - name: build
       shell: bash
       env:
diff --git a/config.mak.uname b/config.mak.uname
index a22703284b56..fbe7cebf40ed 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -746,6 +746,8 @@ ifeq ($(uname_S),MINGW)
 
 	export CARGO_BUILD_TARGET
 	RUST_TARGET_DIR = rust/target/$(CARGO_BUILD_TARGET)/$(RUST_BUILD_MODE)
+	# Unfortunately now needed because of Rust
+	EXTLIBS += -luserenv
 
 	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
diff --git a/meson.build b/meson.build
index 5e89a5dd0e00..af015f04763f 100644
--- a/meson.build
+++ b/meson.build
@@ -1260,6 +1260,7 @@ elif host_machine.system() == 'windows'
   ]
 
   libgit_dependencies += compiler.find_library('ntdll')
+  libgit_dependencies += compiler.find_library('userenv')
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
-- 
gitgitgadget

