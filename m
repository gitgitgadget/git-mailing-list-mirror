Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F61D89E4
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971559; cv=none; b=RnLb/YeUjMjffhzJADpxsKv6LSvys0gWsbT8U14Ai8oCTBBhYknjXb6LJAaPbkGeK7fzPDLkNv36+S6WmeFoHdhxcG6NBd+ZGr25T9KcBVH2l6PhotHWT+ydmcg1PrWNwoNeWuG55Pxa+HPVGz1ML91tgugvxNP660k8sF80fyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971559; c=relaxed/simple;
	bh=xkZfCi4X1Ldw/0SNtpoujoiCwgv8qj+6s5L+QDlMSDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfYsK89bAXKw4o+i7MAU3TFJgBk7uAcplDO/RpSVjjTuk8t3c82phDWHgjvkrc7S2BMzQQBluJacvuc0+WAlFNXuIJmfKREH13l+3NRWpYPBSpkTCBESA0tU1Ba7aBcS4SD9sIzuwc9GD+abYqONNQO7sjEIfDooYqKFtSlgMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbLXb/rz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbLXb/rz"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163a2a1ec2so2519385ad.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736971557; x=1737576357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=79fTpxMfs5oQJiK51bTPCuk7iBIsy1BLKvA0OCh8vfI=;
        b=YbLXb/rz37SB9kog/WaQPGIFdQdV7et9ugQZheum3yOpAoa5ElyekuAWXNKLu/Y6JB
         OHwaCZAE1+5s51LQGpaaXIBYI4SbBswbZkomrFFKCwfYULR7DB7fAtqCzaDvi7eL9Ck2
         RiCHv9TK4Fa63OCcMIE9xxbhwTVBv2pfk5nscXiM8RIC8Co7IWRDBPNSmq+K4tXJF4Ah
         aYvCSMC0STDll4EgyHQxaDID2ECCzboFxpvq+DXGRXcFTN5h+NNSlHTV6w50zcSG+AZA
         jwUxc9JN406RvDaMYG2HVhb20VZVpZ5RppouTpHOm5T/S2eTQY8+lUrMRpQmk+iaNKA4
         NvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971557; x=1737576357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79fTpxMfs5oQJiK51bTPCuk7iBIsy1BLKvA0OCh8vfI=;
        b=QFJEcPU7yMkdB6ni0go39bCQEygUUA4636+vz1lDYKNMSVSmko70aviiZ8oYY2EUEv
         PXmR5hAfbsyPHWxfnbKBc2P1uwAHY3Xup6Oqldd0yUGOm2pFbeFsA8RAkn7RS3qeTR+6
         +ZutdYKhH9qcdYyXJAiOZ4hUpHheAFNM76z7wKef3sW7oHt1ERSJhu7CvH/lCrg/vghJ
         nriNUj4AwSd82g0DwuZEDZTFHUxNZyMsQAbqOOdGUUyufDkoLk79WJxdYP1TbResQcdV
         LGOxxv37NoPopUdks3//HGbEymgpecDwKTj2RM3WLDyVihE3OjnH7BpliDp4PrU9Oo86
         N4Lw==
X-Gm-Message-State: AOJu0YwXZLbjtlHfl10gYNFgOvWYUp9G3ZWwcJUGelOVM+VP0B5jrNXx
	r9C7jCp+g/yiuvaTBv3arPrWVgeZm32c/jGxqrQLRlo78uSsSRd8+bIzhj1Ezmw9IfOyB63R0oi
	JuNHWLQ4OfJunzXgZEyCWX4amANmqOIAo2jnffTNrItKbSzaJcp+dNjtccyTFDZYSEaSHK2Gmgd
	QycSuglisfYCxdJ2tosyQnzd/7PeGlndy0klHpNGE=
X-Google-Smtp-Source: AGHT+IF0EhhCqGp6jXXtxpMrIGqB0g/geeTv0PRd1dTHXIK23xBbtdsklv3RHBFrxU1gN9XbNuw0RzkefDkHmg==
X-Received: from plbbb6.prod.google.com ([2002:a17:902:bc86:b0:215:5322:d126])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f681:b0:215:385e:921c with SMTP id d9443c01a7336-21a8400b31amr387117285ad.51.1736971556917;
 Wed, 15 Jan 2025 12:05:56 -0800 (PST)
Date: Wed, 15 Jan 2025 12:05:44 -0800
In-Reply-To: <cover.1736971328.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1736971328.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <84706f0db79fd83d93ea7b40e226300e69658d17.1736971328.git.steadmon@google.com>
Subject: [PATCH v6 5/5] Makefile: add option to build and test libgit-rs and libgit-rs-sys
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
to their respective Makefiles so they can be built and tested without
having to run cargo build/test.

Add build variable, INCLUDE_LIBGIT_RS, that when set, automatically
builds and tests libgit-rs and libgit-rs-sys when `make all` is run.

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                    | 26 ++++++++++++++++++++++++++
 contrib/libgit-sys/build.rs |  2 +-
 t/Makefile                  | 16 ++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 230d366457..133090a145 100644
--- a/Makefile
+++ b/Makefile
@@ -416,6 +416,9 @@ include shared.mak
 # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
 # programs in oss-fuzz/.
 #
+# Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
+# test the Rust crates in contrib/libgit-rs/ and contrib/libgit-rs/libgit-sys/.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -2238,6 +2241,13 @@ ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
+ifdef INCLUDE_LIBGIT_RS
+	# Enable symbol hiding in contrib/libgit-rs/libgit-sys/libgitpub.a
+	# without making us rebuild the whole tree every time we run a Rust
+	# build.
+	BASIC_CFLAGS += -fvisibility=hidden
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -3895,6 +3905,22 @@ build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
+.PHONY: libgit-sys
+libgit-sys:
+	$(QUIET)(\
+		cd contrib/libgit-sys && \
+		cargo build \
+	)
+.PHONY: libgit-rs
+libgit-rs:
+	$(QUIET)(\
+		cd contrib/libgit-rs && \
+		cargo build \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgit-rs
+endif
+
 contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
 	$(LD) -r $^ -o $@
 
diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
index b6c65193bc..3ffd80ad91 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -14,7 +14,7 @@ pub fn main() -> std::io::Result<()> {
         .env_remove("PROFILE")
         .current_dir(git_root.clone())
         .args([
-            "CFLAGS=-fvisibility=hidden",
+            "INCLUDE_LIBGIT_RS=YesPlease",
             "contrib/libgit-sys/libgitpub.a",
         ])
         .output()
diff --git a/t/Makefile b/t/Makefile
index daa5fcae86..45fe6089b2 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -177,3 +177,19 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
+
+.PHONY: libgit-sys-test
+libgit-sys-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-sys && \
+		cargo test \
+	)
+.PHONY: libgit-rs-test
+libgit-rs-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs && \
+		cargo test \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgit-sys-test libgit-rs-test
+endif
-- 
2.48.0.rc2.279.g1de40edade-goog

