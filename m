Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5130C61C
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340814; cv=none; b=oF+UitDLJwgHF6RxQ6mvqKDcIfTZCIk0kioJ98qeKgSjk09Ti/LW0iMbD7xdZGo91hw8QQhBvu/8ph+NpnImEGflzFsEAwoU7dqwcDwKNPEQ9rmSU614hrjuSSvYhV7IV8kumxNUz7XLBTg4WD+/bD7HQEWuECzz7/OsDgjBw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340814; c=relaxed/simple;
	bh=lg3wqVaS/pfFZrW4M1GyZQr0pzilEsJPmPbMS/Sgi9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5EaPIH6kYdmHVi3R8B7nNvw7mN9FKfZLvYFCBadti9acLv8fFIOhXKOJ0icPOmqiXT5P90QtB2uZSIsFXHOVCd4XHEUMVWYRv5MQjxHcg6iP1m/4CCaa24qZnCSOSzlakAfivs3cXQOkWuilTxxgGVAPNLxXdHEFJFkkiVjpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MoVlVr6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3eHUImO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MoVlVr6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3eHUImO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C037140006B;
	Mon,  8 Sep 2025 10:13:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 10:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340811;
	 x=1757427211; bh=OvzrQvCD9FQWM8O5f18DUOzgtvCXPL23vjdP9t5E+f0=; b=
	MoVlVr6KZKxlpihSqJzhfQTqabwgrzjM1KqwSMJ0vW6s8PKPX7p1MZiFa6/F1bgi
	Tf8UQA4/5jgjmDMGgXR+A2rZwIY22JpnFWm5/t3x4sGPyTVTuStxXzIrE85+n6+s
	20fVoFPY22xE+ZEoiq/6XPM3EPFpH1D2CvkWF7oY4G+/577hquEdLDwtrRcCGNhl
	unMWWtOMKh/qrs2CGCWz3lg1P/9IhKCQGdpbbZ6DxQsVp+5QKT1nWHGaFKocw633
	Gg5hnHFQrQ3PlP1Ddm+i2OT+JlM26ULEjk+QkJcJBJsET14i8FBiaM16tTZmcPg+
	16/d3uc9IMdEm58EwHlT/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340811; x=
	1757427211; bh=OvzrQvCD9FQWM8O5f18DUOzgtvCXPL23vjdP9t5E+f0=; b=A
	3eHUImOEtLfLQst04rYs1E3RGVE0qyGrD8LFRLq0/ESNXYICSCNCyW8a13759OK2
	ZHHcGEaj6Ms4lklPjZ5r2FhzX2gn46NZwn5WQSJHeZWai2eV6col+TKGRAtcCkWt
	fKsqPwBAy3IDV5rpqJqUopxdIjE+vOwyCIKy/2ufAzoFVrZqswVKQ4yv3mBVxCUF
	1VmURLWXVCBin/9YMCWP81fmdStNJdo1z32FROxMTgQyXSK/KX64ABJwGOwuR5pK
	Ji4SQya1cZdMRtY3ecpj6HqtvUYqOSPafhi68IMlhD6/qMsm8is0dvesoEtUnsij
	vJ0ogde4uAgc5D9AadwAQ==
X-ME-Sender: <xms:i-S-aOzIwHKRtzE9SGThCuCSjCOC1Rn0RowR6_1io2u30yz3lU0xjg>
    <xme:i-S-aKYl5TSAbjPkQQKtrzgX_JsFU-wtkExSOEdx8ZXOMQe5Ekoo83gHSrRjjhxRE
    gIkIQgoleS43lBFDw>
X-ME-Received: <xmr:i-S-aHxAoZXULMVsf56_rAjx-VKtB6xtLjUND_qQJ_iFUwwjNRTJ_ci7VHx-gdPOS5RTki7jlys-Z2kkuyE4RpDAKdLpx8glds5Fj3TLm4uR8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgholhhlih
    hnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhm
    rdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:i-S-aLF8rjxm97wOhf6qDgddXkK7ggkvQxRGf4LmSEukcXrw_Np2xA>
    <xmx:i-S-aHxB5SaQLn2WAC3jFxRGp1rXnNMegW30gt6ZO3BcB86pKFBfZA>
    <xmx:i-S-aONO7QIol_jPttfT-04694QoQze74Y4TBSjPEJ1MhM5yMHlCYg>
    <xmx:i-S-aNb72DpH84boOjWEAciEm-AWqJJdLtYCXCVcSQua6VVOrH5r8w>
    <xmx:i-S-aGkbnphkl9pJfnsj3bR0pBm2PVff6Ja4XYjxstjkNfZhP16cnZqS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d2a9785 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:10 +0200
Subject: [PATCH RFC v3 3/8] Makefile: introduce infrastructure to build
 internal Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-3-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
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
 .gitignore |  1 +
 Makefile   | 37 +++++++++++++++++++++++++++++++++++++
 shared.mak |  1 +
 3 files changed, 39 insertions(+)

diff --git a/.gitignore b/.gitignore
index 1803023427..60c3ba2d97 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,5 @@
 /fuzz_corpora
+/target/
 /GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
diff --git a/Makefile b/Makefile
index 7e52625d75..94950a0ffe 100644
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
@@ -683,6 +691,7 @@ OBJECTS =
 OTHER_PROGRAMS =
 PROGRAM_OBJS =
 PROGRAMS =
+RUST_SOURCES =
 EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
@@ -918,6 +927,11 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
+ifdef DEBUG
+RUST_LIB = target/debug/libgit.a
+else
+RUST_LIB = target/release/libgit.a
+endif
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
@@ -943,6 +957,15 @@ BASIC_LDFLAGS =
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
 # For the 'sparse' target
 SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
 SP_EXTRA_FLAGS =
@@ -1475,6 +1498,8 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
+RUST_SOURCES += src/lib.rs
+
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
 	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
@@ -1504,6 +1529,11 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
 ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 
+ifdef WITH_RUST
+BASIC_CFLAGS += -DWITH_RUST
+GITLIBS += $(RUST_LIB)
+endif
+
 ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
@@ -2918,6 +2948,12 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
+	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+
+.PHONY: rust
+rust: $(RUST_LIB)
+
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3768,6 +3804,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
+	$(RM) -r target/
 	$(RM) version-def.h
 	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) $(test_bindir_programs)
diff --git a/shared.mak b/shared.mak
index 5c7bc94785..0e7492076e 100644
--- a/shared.mak
+++ b/shared.mak
@@ -56,6 +56,7 @@ ifndef V
 	QUIET_MKDIR_P_PARENT  = @echo '   ' MKDIR -p $(@D);
 
 ## Used in "Makefile"
+	QUIET_CARGO    = @echo '   ' CARGO $@;
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;

-- 
2.51.0.417.g1ba7204a04.dirty

