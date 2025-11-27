Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29862D47EA
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205858; cv=none; b=MmR3KUuCTHxSGNH+uAsK17mxvoJW3FE4fZ38VOuGaIy8ue6+pwrzVceNpkYgTRypX+imyHh6Lu2f6WNmaNfXoEVIkO7SzWo2IaIt9zRu5R7ve3LzvGSCMrvGajx8ZCYk5GQl8FmZxfhSPZY+1eFv6YohL+OK32joNXdf2yUqKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205858; c=relaxed/simple;
	bh=rC3TVpfNdaOum2MhplAhem4GWgTass3MdspBeOPVwcI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hz8zdryVXx+q903/pPj9ictpDo30dsmBfvm+EK3mWBzaBm7UsJIkuk94fTe+Ok6n3P0xELIMP2+Y2y/eXmDWAT1YwN1Qznd5xTAr5pjvvmPmVLMAbO0IYrZWZq0l7YVmc17KocfwtmUwkZZlBASTlrGkqdX13JfP+dgr++7H8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnAyphSO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnAyphSO"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-43379251ff9so7693835ab.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205855; x=1764810655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN5K/+pB3c6X7NhO0gjqW5J11pKpyvRxYpzWgWh1+iI=;
        b=mnAyphSOvC7uzjnDut2BIzSYY7SW9esQ/VyHI7yHUCZxSg9NNzeZBAuZg1NurAPIVp
         u4/uaX1WM8ZO0qnSRABdFVT8aqVtt5WgdbQdXDc3QEanz0LDDNrC8UpnPHJnzrC/ci1z
         sym9AIcQ4SddvrdodQPwRQUzMuW/HBedULjp1DacsklBLKutaw6OSJIdjV3lGDNRmcp5
         fyF7jL7IXKsqc/6XRhf/QKtMt6tjstJVAiZQuBIDunMFZ0uURj1WSmMuszPThMrlVeVy
         GBSBPEq8veXE58jwciSj+VjfvpvSbaZWB92jW6uA6vyuC3HcaYcGAlNTQ5uN841HTfVG
         MgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205855; x=1764810655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GN5K/+pB3c6X7NhO0gjqW5J11pKpyvRxYpzWgWh1+iI=;
        b=B+ovZmzFEInQQhI6uVLxA8Qf7+gbjJCEqUiQgKrfSrQNaQi1risTOkKhxz2sEzK/rn
         U+eJsu+2oSM640MfqFnk19BiqwwUKWRkq+b0IJBCzDN4SL4x7TRlIMZZ3pedNxbZ7QiP
         6T6fjJWladPX2Zs1iRvyrdq/6K8ndKJt2a5NDrz6s9VWK0Y39Xre/fS1q3eeEFw8Jvtm
         GncF2M5mfX+eLCQZcZ3SdyksDA1aZVwF58mXDPi5LrQqleK0wUtU6o/X1eqqYkc1NX3U
         a+yC0jDmc0JESvaXmovf3nNvvvYyK6JB25rVKoigB1zM/HQESOcyWxxrxmlEkNN/LXaD
         6YHw==
X-Gm-Message-State: AOJu0YxUYRzMYk1Vs9edd50Y1LHURAkJKuzm2rEr9bpThd/zvDcmJkw2
	GCWKsZ9PCt7DNw5CRWYRndyT4xmk/N8lHIXVzTjOMQ2nw+gC6WXbmrpf1eg6QQ==
X-Gm-Gg: ASbGncutsgqpeOr9Yh2zrkYmjkkcvnrgD820B6cOAeYk7GkfSZbORgJ0xu4x+owuarT
	yNFvETbh0U2CH4qp/WBsVKIlhf2xgbVIX6wFUwR7uKAPQ/0WlUIQ63l4gqy6hsxLTLyjftVDJd5
	iTaiURlaJexSIiOfBO55VH3B8hXAkYuKe5riv+HJE2Gb8PnWXS7RIcXKxm0zb54FJwgLeS6K3C4
	I3ZkGaii8n+SDOo2doMb1T/385ocjKdi2hmXYyYYXISJvjRnUpeWyFICmdjrZGsSm/hYFQqrkQH
	pPBTa0LfPmn2xvhYtXAANjoOu/tCjq3sX1Incn1i10HhvEHbt6jCjJ1iFJm1FrHwDrY5MZvqmiV
	gLNXOxwSUitag8TpNUPLyh6JXpm8UznCVUqOMSHo0j3OvvDCi3HgOSzpNZcVOcqZAvOploQuues
	6k9IfLr7fPfyn1/Q==
X-Google-Smtp-Source: AGHT+IHbGtJgwjdaPCef5APG7GzV/sPUickt0si3yhZsKpjKu4q/rTs5sI8NSCvju8EN7IQG+7dKvg==
X-Received: by 2002:a92:ddc7:0:b0:433:7183:c2de with SMTP id e9e14a558f8ab-435aa881552mr156730505ab.7.1764205855452;
        Wed, 26 Nov 2025 17:10:55 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436b85d1576sm602205ab.31.2025.11.26.17.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:55 -0800 (PST)
Message-Id: <0f797a238c3c102814a3402caca2539a518ecb74.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:35 +0000
Subject: [PATCH 13/13] rust/build-rust.sh: update dir_git_root variable
 instantiation
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile            |  6 ++++--
 meson.build         |  1 +
 rust/build-crate.sh | 15 ++++++++++-----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 6da9db7d83..848db03227 100644
--- a/Makefile
+++ b/Makefile
@@ -931,6 +931,8 @@ EXTLIBS =
 
 GIT_BUILD_DIR := $(CURDIR)
 export GIT_BUILD_DIR
+MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
+export MAKEFILE_DIR
 
 RUST_CRATES := gitcore
 .PHONY: rust-compile rust-clean
@@ -949,7 +951,7 @@ RUST_LIBS := $(foreach c,$(RUST_CRATES),$(GIT_BUILD_DIR)/lib$(c).a)
 rust-compile:
 	@for c in $(RUST_CRATES); do \
 		echo "Building $$c..."; \
-		./rust/build-crate.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $$c || exit $$?; \
+		./rust/build-crate.sh $(MAKEFILE_DIR) $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $$c || exit $$?; \
 	done
 
 rust-clean:
@@ -958,7 +960,7 @@ rust-clean:
 
 $(GIT_BUILD_DIR)/lib%.a:
 	echo $(RUST_LIBS)
-	./rust/build-crate.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*
+	./rust/build-crate.sh $(MAKEFILE_DIR) $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*
 
 UNAME_S := $(shell uname -s)
 ifeq ($(UNAME_S),Linux)
diff --git a/meson.build b/meson.build
index 94ec5e4ac0..3154cd684a 100644
--- a/meson.build
+++ b/meson.build
@@ -305,6 +305,7 @@ if with_rust
       build_always_stale: true,
       command: [
         meson.project_source_root() / 'rust' / 'build-crate.sh',
+        meson.project_source_root(),
         meson.current_build_dir(), rust_build_profile, crate,
       ],
       install: false,
diff --git a/rust/build-crate.sh b/rust/build-crate.sh
index b3debf70e5..50f5b0058c 100755
--- a/rust/build-crate.sh
+++ b/rust/build-crate.sh
@@ -3,10 +3,12 @@
 rustc -vV || exit $?
 cargo --version || exit $?
 
-dir_git_root=${0%/*}
-dir_build=$1
-rust_build_profile=$2
-crate=$3
+dir_git_root=$1
+cd $dir_git_root || exit $?
+dir_git_root=$PWD
+dir_build=$2
+rust_build_profile=$3
+crate=$4
 
 if [ "$dir_git_root" = "" ]; then
   echo "did not specify the directory for the root of git"
@@ -38,9 +40,12 @@ libfile="lib${crate}.a"
 if rustc -vV | grep windows-msvc; then
   libfile="${crate}.lib"
   PATH="$(echo $PATH | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr/bin)$" | paste -sd: -):/mingw64/bin:/usr/bin"
+  echo "PATH=$PATH"
 fi
 
-CARGO_TARGET_DIR=$dir_git_root/.build/rust/$crate
+echo "libfile=$libfile"
+
+CARGO_TARGET_DIR=$dir_build/.build/rust/$crate
 export CARGO_TARGET_DIR
 
 cargo clean && pwd && USE_LINKING="false" cargo build -p $crate $rust_args
-- 
gitgitgadget
