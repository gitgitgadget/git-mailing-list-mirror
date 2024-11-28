Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770861C1ACB
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810360; cv=none; b=bJA399h/V1HXQ5K9vie9bBWQolSbTXrBTaI/2a31t4P4jsGofT8irc0YfKnfVAQtLrKaCs5GhmZXEzE133f2u/4H6UWQzBfsRzRHfZ8YtchHBrPvGPGv8NCyyc/BtV1j5h8gYeIi5GGh2Qp9TXcY8jeq39XLzoZCy4NejIM+HZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810360; c=relaxed/simple;
	bh=K6mbsKAqXF/ESD5kcwKjtRWNXHEQx4Zpw3yc8gvtPGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8dIhE+VzvNtc5xrcEDx3ea4CKLnH8m459OWLa3WiPHraibSON0iBTFLM3hcDrX5Y/9Nw+DDmmoO54YlKheZyf5RhCf02Rgb5q+EacMsq2H3YBk1XPBbjP3oIGkGjanUhXTDAQH3AHijCx6ekTAkYHOAjVFZDjoNt3JyIOYordE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xdnbsTTy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1SQyhbs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xdnbsTTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1SQyhbs"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D38921140136;
	Thu, 28 Nov 2024 11:12:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 28 Nov 2024 11:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810357;
	 x=1732896757; bh=PqC2RvT2puU5yRjq776rBa0kuR4Qr9VK7lA9UYRyUCc=; b=
	xdnbsTTykTdv3QtjzkSfrWWjnpxXNdyER1YVf1kCSiTaR6KhO6F5DjKIsYUYsS3O
	LI3Xhz30Xv3N7so5qLACwyRmp8KbcYWLEfs9v6t2CKH1AYHDuBzIYa+vO8idGzfv
	XOa8hmAmL7VYVHGcG7MU7/H+beyu1HGq4AMKYnx96S6VfzLY1eRadNtaYuL3bDVx
	/tuiNL2Qz/RvNhZ/UxOZSwXbnTVYh1qlHPpFkIDJQjzuD0qsa9wY+lD1uInPgwTh
	VSjPhSIu406UJU6SDTBYhD4jY8xt2rqF2xtdbOL5Ofr8bIO7CL5HKdgPfRFOjKqR
	GDNo/9bfVOOZNVKBRmMFaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810357; x=
	1732896757; bh=PqC2RvT2puU5yRjq776rBa0kuR4Qr9VK7lA9UYRyUCc=; b=R
	1SQyhbsgdQTVHr/kzOFVKPQEkMLhdLUBfraVpR/X6TrCifaTSlPtblh9Fe7VpuC/
	Idthx+9xI1vd2xudfjPVXGTOlM5UiSptn5woHnxNUAIpgA9RM10cEAL/oVRIH1YH
	psbodEKyCqtnSZepMCRPQ6x9ZBgRVGJv00sfd5mSm8/lM37dwaO1BsH9UMJWIrjb
	UFUpXADjjIXH+OFAZndF9u9X9Qc0ctE730ffnDWelAuFI9YTPkz3sXvv8RYFP1hu
	t0jLPowz5AoTDOeiOXzOZh3vmo5IuT6F6riwThD3KNhRAPKHIbyj4vEEWFFyc0Uc
	AiDrT/cvYceSFm8qoX7nQ==
X-ME-Sender: <xms:dZZIZ1jOqxQJ064WEw7LHL6q6c35DIbfn3Lt9BKDiLI1kWXoOgqvMA>
    <xme:dZZIZ6AHoPn0iYlKGjv-fmyTBJlMoUWaorpb0G6CWc4yQb_YBCWpHyopR5OnYWZcJ
    XRZVqLppsrnoOZoWQ>
X-ME-Received: <xmr:dZZIZ1FX3c6Tyk1_8N_mlhRqiKRFQFvtFuJpz8et7WekIJzMiGGxjA8rXXrCZj3xl7BSqHvkSkdum6PRJSDbq5Avd0rIuTk3JKTA5Owwo1fk-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheprh
    grmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:dZZIZ6RfQPKbE99hos32o6-bId19w5_onn5JDgSZgG4GzZZCTYIzWA>
    <xmx:dZZIZyzVyZoYlimaoQm8P9SvUpQjnN-pwS53uAVMBNUM_swXT__3XA>
    <xmx:dZZIZw7o62rx48HXC5iVHmPLDV6LfvyKgVdpYkOGZ7Q8vY6ArvKZiw>
    <xmx:dZZIZ3zzc_wreJjYzNzNO8607zQ5lIKBCt3_k_tCN0TzdrN3RAi2Rw>
    <xmx:dZZIZ04apKJ_UhCLoEWmsjOYNDIQqaE6SueZi6YmagqUjPlj1op91UNC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92f7d53e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:15 +0100
Subject: [PATCH v10 14/23] Makefile: allow "bin-wrappers/" directory to
 exist
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-14-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

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

diff --git a/.gitignore b/.gitignore
index d3be460040c6120d862a25dff1abd325b93b37fd..e82aa19df03fc865eaa0468f12b734cec0c48a2c 100644
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
index 87904791cbcea6e57d0fb3c7d4e27f2b0d80b95f..1df9d0c42f1ee7b16ecd7abc22d2653dbf9bae2e 100644
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
index 61639d17dc364acf30ffd2d317015d8db440acc1..14ee6817cf9d9d03312a9cbd93b8ee218241d3d4 100644
--- a/Makefile
+++ b/Makefile
@@ -3206,8 +3206,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+$(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3704,7 +3703,8 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
 	$(RM) version-def.h
-	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
+	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
+	$(RM) $(test_bindir_programs)
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
diff --git a/bin-wrappers/.gitignore b/bin-wrappers/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..1c6c90458b758641d0311e812563b32dd4656b48
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
index de2c24e66b5b94e18368aba576fc11418e2aa049..259dc838b73dcda6ab98776fab61788d90754e03 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1088,20 +1088,20 @@ set(wrapper_test_scripts
 
 
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
2.47.0.366.g5daf58cba8.dirty

