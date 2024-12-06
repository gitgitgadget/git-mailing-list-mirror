Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8420CCE4
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491537; cv=none; b=IkEEx9LSoIbmA8vaMhkoKHU8vgyJD8IxXGRUb6KsvhCIQ1/GtFUxTXNqimwHOgHqPXXqFG3VfjNSXfiYCeCP7SghztFCNk/XbiT1lCyE1UpuxcH+wPF0SxhPCHS/taPZUJNawirvh8HUETFiw1t/ndu4tQT0tCZgy0lb55EUii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491537; c=relaxed/simple;
	bh=ZF74eHxTrxqJuvStnC7TTTEzu5XnY1CO7xYsFGyV1IY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWz1bzLsTmpqkDDxn9jp0u5Ve+tmDhXaa6qF7BGuKJTLgJN2d56lot8QUwfS+Ej2vRwZKs3bEe3hmm+ENHwgTBwbrAhykrljc+b9tqyUUHKYNKjBTUehc4iN59oGCsWcj8GYFw/CKH4OlxXpbJO+XwsysDP8trUgURRlfL1atKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=apsSDZFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3hv2I6Mo; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="apsSDZFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3hv2I6Mo"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 017622540170;
	Fri,  6 Dec 2024 08:25:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 08:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491534;
	 x=1733577934; bh=GH+0u6OJEatcwWP2rGbGtUTPliUJCqrfE2fzvneL4IQ=; b=
	apsSDZFAklJcc+hWcyJ8F6bxtJesNhlS0QeElhNV5mZx7I7WOQctUGFFa09L9Way
	m10CIskL/2H7aWqLD/Fk5k2s1NcozMyqE60eM+OrZLiWEnba+2wZzPV9fFCT2dWo
	VtVO1R/NKry1yhUeSqxhM58BywTvDSaM/J6X64M/hG+VOKNWrY5DQa/R0gizRS+s
	7G+N0AfaZ6QAQ0X2qweZcL+NPtJcrOY5yH4ZSDzuwD4W/jfay5vc1o++oGnO7d7i
	iVJZegQpVd/HXcO+hMq0/lmNZlO0TGuJs5spq/M+yz/O3R4otVdTbg4l3dllmS2U
	+9rMcymqdKjXrCIbTNMxdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491534; x=
	1733577934; bh=GH+0u6OJEatcwWP2rGbGtUTPliUJCqrfE2fzvneL4IQ=; b=3
	hv2I6Moews2bwReXrxovkIt/dwm9U8+EVdQ1aAwiG1WtOWA8+pejR4kxWcZDoPf7
	2aRlYkCnUSX3VsZoqm9A+4yVLTW54zaIzsdYumMi0kSgdoiIihf58VnOSUR61tWq
	fDBwUOrWB9phAuunwHL58eHTPClOUnN7D8IXOoh3JDLgeJtCUAdioPr9FBFqtbac
	Czx+ObQiePzIIDIMq+PyWSG+hGiAY03gKD79MxZT4U76R40Dfvs4DPItNLv8m5Ku
	vziKearQ4xwo+2fhOs+QJJGW4kfVFEmd/NghwCmY2ixk648vv70HfedcHzKwyvsR
	I3pgOf0EJKLrrEC3HaSqQ==
X-ME-Sender: <xms:TvtSZ0S-9eesGuQs5Rl8-n4LD5zlFlnFkqcfmAME3UDsL8ZHORl5hg>
    <xme:TvtSZxw3OTM3NOA-RDnrRCQu6dlQJSJdI4J2tsekWrF60QfJjfasRNYNMYzgK29wa
    vf6UkhWqlCwhtDkFw>
X-ME-Received: <xmr:TvtSZx33D0S9D6q83-flkSDSrvGUWEUwgIolRw84Lbf5LuA4f9157nGag_eg_xV3nfYiMxuDwaMBeE10-EGBCmc42-O_7DmM5Oapp74AGmQyXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    eprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthho
    pehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:TvtSZ4Cxb4wt98nLAQAfihutCtNN9-GYtAIYhmrmKpn4p22Zc2b4oQ>
    <xmx:TvtSZ9hXSwPUVt7O0mnTbYotELiSRrHmx77airenHhuTbfGGj__Dbg>
    <xmx:TvtSZ0oTB-QS3d1ZuKHAvovRXF7CA6SjYz3JUdJV0t55vkREFveevQ>
    <xmx:TvtSZwhELdmv4PMtmlAVlRpDQznLFJ7jttrK_sLtGSYrpKS-JTJikQ>
    <xmx:TvtSZ4qMELC1V7Pgj6VOTgoxwjv80WclUqxqyDXe4vKp79yic6BpPypc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 792852b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:50 +0100
Subject: [PATCH v11 15/26] Makefile: allow "bin-wrappers/" directory to
 exist
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-15-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
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
index 884da0d42a1b7860364aae98216ad6e7134179c9..ed9bae0f2ed692c910cb7e5956694f72d557eb9b 100644
--- a/Makefile
+++ b/Makefile
@@ -3203,8 +3203,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+$(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3701,7 +3700,8 @@ clean: profile-clean coverage-clean cocciclean
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
index e7bd45cbb68d1a313227cc6c335bba137d9d9458..9348665f226e21dd94e0b832b938b4521e79bfbe 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1095,20 +1095,20 @@ set(wrapper_test_scripts
 
 
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

