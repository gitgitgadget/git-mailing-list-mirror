Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD734A31B
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073075; cv=none; b=iN6C9P4/JeOSGIF4gCwd51LVjkTS37EmTfBp5k0pod6fRV5wnuFYclx5eRTQYLupPsban/aBeD5159URU7oApttqa0s+QGVS6El18zhB9r4aia4n4Vijfoblr5uXYiXaqDxNjOilQZ5AV7lGBYpmIaDkeP4b/ZMNIsFNGu5FOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073075; c=relaxed/simple;
	bh=2hiz0cPqZDChn1sBTpBf0yXLYNaTKdPtCyrfFNvE1PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCliqTIkwgeoVlj5Zqb/y9hSENgQAtWPT1qdTgOMBLtfOKh6v7V0mP185hMstl3PAzVdjHUL7K9WUStSMmgUH7mq5QbZB3z3XgJjaTDruoNMTh/3bYZANd5keUOLi0zSO2yvilRrppot005yTXbV7RpSmUq5aRRk8A6G88dNdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jznGZ1DH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ug9GhxVa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jznGZ1DH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ug9GhxVa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 65E3D7A0413;
	Fri,  5 Sep 2025 07:51:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 07:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073072;
	 x=1757159472; bh=l+K1v7b+Q3lvrXbbM6SBv8vnRc3mQMbExRDUTPdBqq4=; b=
	jznGZ1DH20tookPuUEkjxnWtqBPga9pilG/vSkIVVLqk9wZCeomi1tfjE3uGedOC
	iifDcQst3yRdHgDWNUFak/nbAZ0kdrZ6viRiHrhiQ+FUL8B4n87pbwZTLHTJKA7K
	hJgKX/UlShvd4MQse6coEHt95C7oWQmVV+DO21JE2CHFa5JCl8hXPhl2UYTypxOd
	NrQYhPxJggWbKJ8RW1+SonjQy4ZCqBqcmgZe7E2qAZdHISTcMamKshuwburTgEkL
	FoBv8V8SfycpUmk79ZZVKREvP1XeOBiklwwV/opYoLuAbHJFib3wmFXaTaUbxY8I
	eRd+EusKamZiXUHSYK95tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073072; x=
	1757159472; bh=l+K1v7b+Q3lvrXbbM6SBv8vnRc3mQMbExRDUTPdBqq4=; b=U
	g9GhxVa63AuEIKEDcjQKc/skEV2rh7hZ0+X1/Fn+W5Z+TytZ8+tuHcBdJarToHuB
	M7XJ6nRoL0KZ9nkq93+VPaUT/+XAXSTkhUBkNEDQfHbnTtIcMf/w/gfp55yHGA/p
	ZeGqYFQHI5gjTf0Arj6M+/HvQmsxNNu12fZArxollMaD7X8+Wvyj/4TqxnTL+rR9
	G00EWEyT/58w8uG8X9gsjPlsmocsyVoqzOXOYKzWTLKyiEdC2Io5bRVd0lPFx6lI
	qE5MObrsgvQ6nLjbi8MVfpDffwP7yrxN+tHelCENBmRNkO5yccYcZE/KDOHe9wR6
	X3eyckO6KOSFeNoadcJaw==
X-ME-Sender: <xms:r866aMkWFP0Kf-nvgQJkBfQmxthoKo7xOQBKwRbPisqpdQUzEStO6g>
    <xme:r866aL_aDWDn3xJ1rOfk-r0PRVUSJKV57Qconsbi9jH_KYt-HknJ87DmD3K_jxpez
    NgLT81AqS_PwAmpbg>
X-ME-Received: <xmr:r866aCHStinOjDqMn9r94F9ZHVrbjXofv8rfX9KEDS5GkLxKalx9phbswtJMH7ij9ccuFVmd_mL_V37PK0oscNRcVJWPhAPvrAtRyHNPma-Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    tggssedvheeisghithdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sM66aPK90wTb_d0D7qaT0G3N4o-qiWVLPzH8pseCDjJ1Hv56TgoRNw>
    <xmx:sM66aClwTl3G_fHsJbStrzHiCF3Ladc_PhbZtVxZQk7Wa3c_A0SrZw>
    <xmx:sM66aIycIbtXQyUm0rfH8Syp3Mc9sFtA3kB9DYbvcQzqR1OxKeGQqw>
    <xmx:sM66aMvir8yzy5QUQp05iI26-6LDfIah90m2Iyw2d2FzUITo0oiQlg>
    <xmx:sM66aIq054O2DlKYycBTsCxSC8KSI4xzpSt4lMZ6SxcU8Qyqzo57JDdr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id def11774 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 13:50:58 +0200
Subject: [PATCH RFC v2 2/7] Makefile: introduce infrastructure to build
 internal Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Introduce infrastructure to build the internal Rust library. This
mirrors the infrastructure we have added to Meson in the preceding
commit. Developers can enable the infrastructure by passing the new
`WITH_RUST` build toggle.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore |  2 ++
 Cargo.toml |  9 +++++++++
 Makefile   | 45 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1803023427..0833453cf6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,6 @@
 /fuzz_corpora
+/target/
+/Cargo.lock
 /GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 0000000000..17a4f4da0c
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "git"
+version = "0.1.0"
+edition = "2021"
+
+[lib]
+crate-type = ["staticlib"]
+
+[dependencies]
diff --git a/Makefile b/Makefile
index 555b7f4dc3..e7b3c8e57b 100644
--- a/Makefile
+++ b/Makefile
@@ -483,6 +483,14 @@ include shared.mak
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
 # in /foo/bar/include and /foo/bar/lib directories.
 #
+# == Optional Rust support ==
+#
+# Define WITH_RUST if you want to include features and subsystems written in
+# Rust into Git. For now, Rust is still an optional feature of the build
+# process. With Git 3.0 though, Rust will always be enabled.
+#
+# Building Rust code requires Cargo.
+#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -918,6 +926,11 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
+ifdef DEBUG
+RUST_LIB = target/debug/libgit.a
+else
+RUST_LIB = target/release/libgit.a
+endif
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
@@ -1387,8 +1400,12 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-# xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
+ifdef WITH_RUST
+GITLIBS += $(RUST_LIB)
+endif
+# Other libs may in turn depend on what is in libgit.a.
+GITLIBS += $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -1411,6 +1428,19 @@ BASIC_LDFLAGS =
 ARFLAGS = rcs
 PTHREAD_CFLAGS =
 
+# Rust flags
+CARGO_ARGS =
+ifndef V
+CARGO_ARGS += --quiet
+endif
+ifndef DEBUG
+CARGO_ARGS += --release
+endif
+
+ifdef WITH_RUST
+BASIC_CFLAGS += -DWITH_RUST
+endif
+
 # For the 'sparse' target
 SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
 SP_EXTRA_FLAGS =
@@ -2918,6 +2948,16 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(RUST_LIB): FORCE
+	@OLD_STAT="$$(stat $@ 2>/dev/null)"; \
+	    cargo build $(CARGO_ARGS); \
+	    if test $$? != 0 || test x"$$OLD_STAT" != x"$$(stat $@ 2>/dev/null)"; then \
+		echo '   ' CARGO $@; \
+	    fi
+
+.PHONY: rust
+rust: $(RUST_LIB)
+
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3768,6 +3808,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
+	$(RM) -r target/ Cargo.lock
 	$(RM) version-def.h
 	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) $(test_bindir_programs)

-- 
2.51.0.417.g1ba7204a04.dirty

