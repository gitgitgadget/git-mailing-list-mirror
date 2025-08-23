Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481B20D50B
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921368; cv=none; b=b2UckLjLrrpmVagI4/Eja4CYdMiZLni+V4PdGnX0t+uX3D0JC6UefnMVs5dskT8FquEJVTxITN+ccIS+gB8X18L7XVn0iqqJmFhKx7CIqZS7aNuPclPGKeJ5ENq46bUA+RXjYvSdBpVIR9/HnwVdi7K4ugNwTzYftLxRx+BJY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921368; c=relaxed/simple;
	bh=5n7z2SEZ+4PpADWzAODCXlZ+fp/nSBQ1xfFg7PBw7Fs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PxqOSWz+jQAe9WdemkM4NYJWla5AcWNR4tX+3LBjfys6QpAhy9vbor9rAHA3QgQGfqPgd3xGuEUXah2KCoGSCqn0MR+GIfTKS9o7g+HYCLCahBjOAgpOmuZdvBfBstzW7dH9NkntEtUy9nsvppa3tHiNdOYY//26kAI4fDXE3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7y7rkQZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7y7rkQZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so496464f8f.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921364; x=1756526164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWxhDTpKMLASLd31/zds6DpREzNb1kDyvrPTerYAtDg=;
        b=O7y7rkQZe5+pOTJmWSygSjSxBmnoyS70jRPCRlvSHlyyi5lCEnuyk3Ar21ms0sLNb9
         RypWKpD4xdiDrBuTBeaKezI4YJf0V0YPbwb0aXww9qCt9OExOJ0ndR7+uJgksrFtVA1m
         QI2e3wqBzQsJqVud+MQpds0BwUXy43q0pngjOEybAh4PUKEpmvh8bPyJsYje6Vx5+o+E
         JW3n5BMX3TWlwZdC0C4N+VUjhSOYjvyOm7OLc7hMnbitrViHdSncQuuFfpw92uskSdw6
         fmQR/OYMbhw7oE1f1tZv4LLVcdfFMhQLL/w8QMUU43tO4f+FiLeA7n76VBBZT+0Drs9p
         XHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921364; x=1756526164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWxhDTpKMLASLd31/zds6DpREzNb1kDyvrPTerYAtDg=;
        b=Kn1gk+mL2sixG/+70MHIhMvP9LEvx/Df7rhmimzE/LWzWG6L9yuEgGHziLjD9ZEO9P
         q8uB+hW6MEC0vzNAdqnuIcY125pZ5UZdsWnJwZt41YDO5KtgTb7Xf4Yq5Xv5g3ahmoE+
         KQUbguFkiBo3jgLwXUG3tv4qkEjmGrDafTiKgvMVtXSgODfYaI0z7lJfglQCK212LMNF
         4ENQoofh5ZLGSQrDgE8QDvK8TGjEMYdrbmCym2GEWJjAkvmL8x56ugRNJxqbMhdwE2k6
         40Om+SJ2D4FiSEMeGuqR+/tSkibOz4FpU1tG7yLcsb5/N5/qVPdEd/YKAoj+nVInnx5d
         FSlw==
X-Gm-Message-State: AOJu0YwMw872UD4BgWPj8NgtSJBt8K99v0VlZa4sR5tckEocG8eY6Yxi
	06dqYauXFUZRmt6cyoyr6CT8iefNeqh8DCkZmYLd596HvkfMLFGzy7yU74xxBg==
X-Gm-Gg: ASbGncuIRxWLDIPlHZBvXBc/9qEzjyBnWN8Av4U8HZsL6sS7wXtgNJA94YpXX949SO2
	wH2RDvnXsRb4xFlJSASA0nnpo0kA2FAVttACAOCB0DTxxVX2n/gPNZGZvPAWvvasNLJZ2T0NZan
	yceJE47+6SV4kMAU6k47GN/Q0K2nUk0mVF2f37x1SFnnFTZDQhQRaKpOO1d8alIQSIBFr+f0CyA
	uMUx3PThLjJRRUJ6k9QvntlnJEElqmrtI1dZKHOSWSfKJPiwFPPWh9aZLu4d1yRnuozAnJNuXi9
	5DjzPhiKidruP31JsB18aWeleUgP9+X64avHbk2SMu9tGbc9cy3WLBxfjmHNIiSS4Xk1pYKWF3B
	FomDiE5to+p+bj/bkhcJQzFJPMCpLm+iugl9jyQ==
X-Google-Smtp-Source: AGHT+IEm0c6m3a2E4unDrd144WaS7+42zQ8FMSYcabDnzhGyfd1gjN4iOsfsFOGEvApU71xpyt+syg==
X-Received: by 2002:a05:6000:1882:b0:3b7:8b5e:831d with SMTP id ffacd0b85a97d-3c5dbf68764mr3037109f8f.17.1755921364333;
        Fri, 22 Aug 2025 20:56:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm1830049f8f.47.2025.08.22.20.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:03 -0700 (PDT)
Message-Id: <0d2b39c3e0324de129404035def6f54754cc6225.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:45 +0000
Subject: [PATCH v3 04/15] win+Meson: do allow linking with the Rust-built
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
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
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
 config.mak.uname           | 4 ++++
 meson.build                | 1 +
 3 files changed, 13 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 2fa5fab0fa83..0f7396621df8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -123,6 +123,14 @@ jobs:
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
     - name: Install rustup via github actions
       uses: actions-rs/toolchain@v1
       with:
diff --git a/config.mak.uname b/config.mak.uname
index 3e26bb074a4b..6805e3778a16 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -740,6 +740,10 @@ ifeq ($(uname_S),MINGW)
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
+
+	# Unfortunately now needed because of Rust
+	EXTLIBS += -luserenv
+
 	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
diff --git a/meson.build b/meson.build
index 324f968338b9..5aa9901bfc0f 100644
--- a/meson.build
+++ b/meson.build
@@ -1267,6 +1267,7 @@ elif host_machine.system() == 'windows'
   ]
 
   libgit_dependencies += compiler.find_library('ntdll')
+  libgit_dependencies += compiler.find_library('userenv')
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
-- 
gitgitgadget

