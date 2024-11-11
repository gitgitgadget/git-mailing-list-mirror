Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DE1A3035
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339074; cv=none; b=nBGFL1CmyJyhKybfBIJCBURx9Fmk9+VNSPIc0KPJy0rKEeZFIc2qqFa8m50IlKGSAef3EOmpMpVH6O8GHS0HOoS+yKK44l76Qp5SVrqnuDpgCvRbTqQjkOZIfHv+wVJ2f9Cg3VYqZbMr5wx3Ffxk38Yq2aiWauTTOxeUccydXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339074; c=relaxed/simple;
	bh=KLm16Ytd+Vw2fG2S6fntNIRKkPSX5ZfpOqWb7njJ2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajPnNSOHt8v6x3X4hEgZGmiILDW9i0+XxnCIjFVR3cwS02iBMWzClGrWVhhKJ27Rkcb5wSFrV44TaDFqSXjj2T42vUgV2gw+f/FY8hzIGGdrHG2EB4tNx8SAWCZlq77geQK6J0UAlGRXKy8WFDkPFh1j3QsbMMdGx7sT5pwDy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wOuOgidq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/+97XCi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wOuOgidq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/+97XCi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DA9213806E0;
	Mon, 11 Nov 2024 10:31:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 10:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339071; x=1731425471; bh=qR3/A2Vl68
	qTq/MbCbHgXGYFNfU5jB8aYFkcxKv0ssI=; b=wOuOgidqoMBgkRiemAVMRsEH3F
	XfxNf9bf2EC2Pi0luoLX0jYNUMip1bcq/O2EHdyQtKiGnKJj/XnY0y58Hd0RD1EV
	2YrG62vWTS8am+sfnGOrVv9lmvthuvV6iT7HqYAWDhltocLZAXxVMuCNzhG13sAk
	vQVUC91bfftS8G57IkRA3Ogsxx60wZagHR2lwX+QAANsAql9HdRNirW8VLR7uFG4
	Y3GKp/QNcIpjqcD7ztOv11Ynm3WeDEuniGHAy0SgAyU7jjfu1cNy4bY3uoOZJ+0H
	Va5lGL0psxZTc7nm7jwevP4MYYO31oShs+/b7/Z6VHr1JuDiIAzdH0qkZnWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339071; x=1731425471; bh=qR3/A2Vl68qTq/MbCbHgXGYFNfU5jB8aYFk
	cxKv0ssI=; b=E/+97XCiUd8QssL9FHMqYyL1s9Xwc5l0JQ4lloVhS3QYV72ZvZM
	rsdtdl+zdNckL1JRcnWnddufjZUX0GOmMc6aESHjZMssRhrbGdeFM96p9rfOwRbl
	yubBJ4CDfqlMcqkRW5ydrkfHozBy1sQgU79NXBtefrcbijhQ2LhHkdnKAu2QFI3Y
	PX/dsZ6BN2oVSM1PMmc9D9UJzj0LB9P27UpfZNEKFBC1KBBopyXa58qFhpWqfTkd
	3aQwM0F1QbDkf+SD8/NEoGBBpuElWS5sW0IzpOCfjUN9USZYqDuxmYdsx3/M2vM/
	D47tuw382mojmUn6ow9NaHXteZM9jpiClEw==
X-ME-Sender: <xms:PyMyZ3GSBY3q82frjy4g7W3N0pwnFfhEBWdGMOgp8JksroGVaFs3Sw>
    <xme:PyMyZ0X8ElMyM83TnQ16oT7VuifDoqP40QcDtKlGSEpxNwEQ_Vk4JFwSCOolSAH9K
    xCngUDGQTHsNCd46Q>
X-ME-Received: <xmr:PyMyZ5K_t8pycCV2A1KwvTT-xtcpdSvxk-f3YtGkDYFkZHohVgNWqeRMChQkpvTDg7796ufUXIw0Wz11lYspJyHfosf-wk4Y0eKqKPaB8R5Xpgv_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepuggrvhhvihgu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PyMyZ1Ep1eEqRWKA4MV9jj5KdHKEB3EZOHyp--j1SoX_oQcQIuss_g>
    <xmx:PyMyZ9Uh0Tt5dd9cNnTGY97PMFE4ZNKV2LDUTQSoJ97y_xq1yxDl9A>
    <xmx:PyMyZwNis8Oz0C2WKhlyc26Ogt_wGzQYtXVqyUsfePrsy_UaTGJS2Q>
    <xmx:PyMyZ83-0OQHrZayOUuc9bEG1P8cet2rwxXSc36fILcF9MZ6Fvwx4g>
    <xmx:PyMyZ5qw_a0JYYMe2O68sqX4zWdK--9AxU4ZxF2rV6P_X4F5AHMNWK8e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e8e4f6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:34 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:31:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 10/19] Makefile: allow "bin-wrappers/" directory to
 exist
Message-ID: <33c9c32285346fea142b5332d1580449edef3c03.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

The "bin-wrappers/" directory gets created by our build system and is
populated with one script for each of our binaries. There isn't anything
inherently wrong with the current layout, but it is somewhat hard to
adapt for out-of-tree build systems.

Adapt the layout such that our "bin-wrappers/" directory always exists
and contains our "wrap-for-bin.sh" script to make things a little bit
easier for subsequent steps.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                                      | 1 -
 Documentation/CodingGuidelines                  | 2 +-
 Makefile                                        | 6 +++---
 bin-wrappers/.gitignore                         | 9 +++++++++
 wrap-for-bin.sh => bin-wrappers/wrap-for-bin.sh | 0
 contrib/buildsystems/CMakeLists.txt             | 6 +++---
 6 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 bin-wrappers/.gitignore
 rename wrap-for-bin.sh => bin-wrappers/wrap-for-bin.sh (100%)
 mode change 100644 => 100755

diff --git a/.gitignore b/.gitignore
index 6687bd6db4c..349673c55c9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,7 +12,6 @@
 /GIT-TEST-SUITES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
-/bin-wrappers/
 /git
 /git-add
 /git-am
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 30fda4142ca..982b705f0d8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -583,7 +583,7 @@ For C programs:
    Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
    run `GIT_DEBUGGER="<debugger> <debugger-args>" ./bin-wrappers/git foo` to
    use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
-   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
+   ./bin-wrappers/git log` (See `bin-wrappers/wrap-for-bin.sh`.)
 
  - The primary data structure that a subsystem 'S' deals with is called
    `struct S`. Functions that operate on `struct S` are named
diff --git a/Makefile b/Makefile
index 975c18dfb8f..c409a0e1b7d 100644
--- a/Makefile
+++ b/Makefile
@@ -3199,8 +3199,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+$(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3696,7 +3695,8 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
-	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
+	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
+	$(RM) $(test_bindir_programs)
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
diff --git a/bin-wrappers/.gitignore b/bin-wrappers/.gitignore
new file mode 100644
index 00000000000..1c6c90458b7
--- /dev/null
+++ b/bin-wrappers/.gitignore
@@ -0,0 +1,9 @@
+/git
+/git-cvsserver
+/git-receive-pack
+/git-shell
+/git-upload-archive
+/git-upload-pack
+/scalar
+/test-fake-ssh
+/test-tool
diff --git a/wrap-for-bin.sh b/bin-wrappers/wrap-for-bin.sh
old mode 100644
new mode 100755
similarity index 100%
rename from wrap-for-bin.sh
rename to bin-wrappers/wrap-for-bin.sh
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 73a3cbf5302..4f652927b1f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1061,20 +1061,20 @@ set(wrapper_test_scripts
 
 
 foreach(script ${wrapper_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@PROG@" "${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@PROG@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
-file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
 string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
-- 
2.47.0.229.g8f8d6eee53.dirty

