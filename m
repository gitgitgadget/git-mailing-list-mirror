Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A51DFE00
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485829; cv=none; b=fV7TYdwUKOApFcxQqEhvnHg0NeU2fdxXoIavDPNyTl6TA0OoQlAB1J5Xg/zj/rcCexnGHUyUO/WL8UJ0d2ZuCgOvn8C3U5PFFzywXOEojoI2LMacCOH4U4Os/aeIVZVXPcgJ7/3PoF5YTAX6roqHHfeIilH6qVKXXT4iCeKU72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485829; c=relaxed/simple;
	bh=+jRGbOikhFlp1Obhs2pIF5uY9+6Olg6ULAuPE6+3lBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tij3LULN7/DmICCF1IFiAbGZ+FWWSJ2FjuygBYkkvRraAgEaQHJ3Z0TsEm853kQkiRcK5dQtaPWVzGvevDOlnOQxWm8FR3EKGCLNdA93Nk68KyC2E+0UPB6MPMK1IFHOF7LBBSxr9y9Qtyu3bYSiTnMYICGHUEuU8PCie/wjIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ASGG45pS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YttHEZp1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ASGG45pS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YttHEZp1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E8C91140179;
	Wed,  9 Oct 2024 10:57:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 10:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485826; x=1728572226; bh=sqQDqrTsrZ
	Wh1vS1neHzoERWFcXNo+fas8ffRvnEN+A=; b=ASGG45pSFmQwZmS1fkLm2l+43C
	gY4wcv0eknN8hPCgODa0SuI07SI7Mn11eNKNhStKbNXDbdMcjzJQoK5CbcsOzbIY
	lvtt4cC2kvAsJLTWG7QXMufuiTZW2vhRGRkTitX7WtTzPSMRUvqIxiF3ktQBkBjn
	PDDDosMa18MweKOTX/jbfB8jjqYzSFFIaJx7rXET5yoVeTiDRv93zYuntmNvwiwm
	jiW0xDFjc5spPSz/pn/aPSHEoQmYyYZEmnq9xnePN/U7+rjc/B9RGLgdudM9DnTl
	0oA/woU7WO1/RZaNSlGAy+L2eLsZpX0EpbGk4stGz4EA25KmDfyTlpBHuJ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485826; x=1728572226; bh=sqQDqrTsrZWh1vS1neHzoERWFcXN
	o+fas8ffRvnEN+A=; b=YttHEZp1ahYhhc0EJTqGYOxGwnfry6cAH5IsT/XTR5HZ
	7//VWPGnFAuhaIGWC9Mi/bqn4Ao4FgoTo9jNKTZ+lYKgpCpMTtQiPmvXV2uTah5J
	JLHOakVAJiUGTDWnxclyNAeyD1pE9g0E4Rbrr41SUWxMi2TWQNrXctrIdpdTmTt5
	zqUU1v9R/5TCcoS75F/C3nFGZBeFyf70T80GSnLIjbtjsmvSuon2Jr5I65fbZZ+e
	o53hVsA6eAOmcKmE4p/eRzUbI2Yup54yhm48IKabNjlQRlXSD7OfM8ky530y11TZ
	7eSaLfv0MuyNQzLIslnZ8j0B4BWy1CKs/K5+Fv0w1Q==
X-ME-Sender: <xms:wpkGZ2nPkw0Wt_--JxDqYA0zV0MmY_gezpGN2RQgbrCpNRHx_mhn5Q>
    <xme:wpkGZ93BCR8OD1yDxNPxodeVAiYqR3dxY0bZx0qeoPw4EM6RKJFxxaGyJdMew2Clr
    D5M7_O0hDrtuJnXpA>
X-ME-Received: <xmr:wpkGZ0pxcFBqjgUnpgi1anDlnecp3mWRXjtMc8HdWrXUdQAXfbDzKKfIPDmSY0-1Y11WqVkKc-X9ldmKCBSI-fYABN2i5effPFZFfMVOowjVEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:wpkGZ6kkxCassALLundvzFUvG8MQYS6CHhlf1Ja8tHAcL1jSgnZ8sg>
    <xmx:wpkGZ002g1AkuRArM8LDZ5hNQhrvs-Px9P4oBy1H9RLI6MrR3klH3g>
    <xmx:wpkGZxvpiYAshibj66vLh9v1hZ5ZThglHT_SfIDc65Z3TnYPRrPUNg>
    <xmx:wpkGZwUUqGPoj8hnTyJk7DePXh2fDmlVPWCV-5SQ6VxxmY6a_iTpdw>
    <xmx:wpkGZ4_F47-MYUjxJ-z_v8C78j0GqPXf58X1snnRmMbnWnBX34u40OD3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:57:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc5e03ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:56:02 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:57:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 19/24] Makefile: allow "bin-wrappers/" directory to
 exist
Message-ID: <9fd1aeb1e967df5740687e1141859b8015646452.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

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
index 3263245b032..ad831567444 100644
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
index 46327596275..554d8ea83b2 100644
--- a/Makefile
+++ b/Makefile
@@ -3215,8 +3215,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3712,7 +3711,8 @@ clean: profile-clean coverage-clean cocciclean
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
index d63c9078345..e32ce8ce8b7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1078,20 +1078,20 @@ set(wrapper_test_scripts
 
 
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
2.47.0.rc1.33.g90fe3800b9.dirty

