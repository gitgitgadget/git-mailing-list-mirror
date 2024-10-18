Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27387198836
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254268; cv=none; b=t+jlDuRajwMBk24JAFuHdXH3nDKU8MPREORqJpFCUlSkve8DiQkWSqJv7VkQVLjvF5J3fagb/IWNaqum+G1CbZjOE38APQ7gvXBYUhGcElx8Hgtj/UkwQBvQEaRdA2ruOW2vDTfN7GPE2vNun5ckWlMJy/uLSHotMguGkMsJa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254268; c=relaxed/simple;
	bh=h8RQ/MvOS9E3lPN/ZoV4X+AfpIqWrzo5lsgH0boar58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCYXFAB3boF4e5FNOK7eU/gWNm6ppg7MLqfjCTAa79EaaBjf78Gfj+XsEA3KdOqQxVJyQOVEf/PllTkC/WQDL79c6zgKir5LPI08G1cCw1DEUEZscfqfZe6/+uTivNNe/p5KX7czKGIioWhzNmoJvrnUoAQGz+p1sljhrLLCt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TS1d/43z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIyA/ykq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TS1d/43z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIyA/ykq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 452B025400B8;
	Fri, 18 Oct 2024 08:24:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 08:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254266; x=1729340666; bh=nSgylnJA7N
	xQflbHnM6Y99MH5ieJXRFMkZP3hNaS50w=; b=TS1d/43zL3CZDz2fkHoofumAD1
	vmT4kVJ7TjIf4fMLAP0dZmA3Q30XiEg5rUns083U6Iz6hksHpFn/7Mx8HtmdcpJ4
	bmGMAf5ljJKQ7jutukxltzTsA6u51B/kmIrh6/1gIPvZdW30GB9CG/XemFZKPacR
	bqOJktlhEKzJJK5Ofq5atfZsbuLabzpdO+v1DDiQRpk8iyObVkXGj9Car5sm7Bdh
	rBOLIqed42BqtOUjwFL3utgQBchai4xsQ+JUHk3BOImqWewqc6kQnSQmaKIXxn8Z
	KyK2LEcW2UIzQbvbloKOtt4Yfp6wqJmtYOI9jNCeDhBETBeHQOzSECobZ8KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254266; x=1729340666; bh=nSgylnJA7NxQflbHnM6Y99MH5ieJ
	XRFMkZP3hNaS50w=; b=KIyA/ykqJVfv2MxjwCl8bdfXw6tvXz4kkYz/eqUotE+j
	ILGi/xoPZUcolyKBYFD+jKS+Fy+2jeGBfBIjDyxcWEIwMZCXkQUi8MwOR4dAcIAW
	/IPWzrdU0uLq2Lpdgk6hpJWnpy/TMANaaSt+YY8CgTmJX/+2b5zX/MnENu7AQ22O
	WRXeKmNr3k9MSf9Vx6UK5e1zIJSFywtOV8hj15or4fFO/OogkO8Nfuwp+HrLvgwI
	Had1YzSOhSVD9HLzVwZL8jDMzatvmsMNsxOq6oNf9MYKcmxemkUFe1JZbL5k0pmk
	HEkgzUq0HyKqKuJLSM0bq44Uatagj3fxbLhgeHDZRg==
X-ME-Sender: <xms:eVMSZ8VozbmGrQ9vS0EtUqyfbnxV7okVecHCDRRpxotxHVJ85dnekg>
    <xme:eVMSZwm2KFy9ZUPJagoNYPbZUkNK3Qoi7VZRvnYw6i9q1ssgzYkBQ8OfG2pr2RGf9
    EbWmmBqsmYTsHIeuA>
X-ME-Received: <xmr:eVMSZwbwjWZZFTt4fzeisHhuhDwaaQqynMj4ADHwLQB1R9A2XpbdZdJ81q8k9mIakBX76KCw5aRWzKmIl7uqDiN47R7HGYI2pJlw4uCMrx2f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhies
    rhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:elMSZ7UCgO6zqP--zH6ia52UkwCksraNnhDgJkRY3bvlrjkLFUtcDg>
    <xmx:elMSZ2mJD0DGZVLD1WQc0OqRzERarbkz-1MCf6d4KAklL-j0HCop-w>
    <xmx:elMSZwd0xHekRnzbPY4Yfi6LyPZn1Flt0K9T3Nhdn7kj2QfdhUe6NQ>
    <xmx:elMSZ4FC9flO2sxcdSDJCEj1oITedsoZWDdXH5yapAGfV1hisS2ldA>
    <xmx:elMSZ0aJqswspB5lPekrsZm33LVQkJIuNEAOEUQllBjFtMSMp6TYNvam>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d892dca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:23:03 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 10/15] Makefile: allow "bin-wrappers/" directory to
 exist
Message-ID: <93869e5317870dc4ceeb80e285741c231d3fa7f1.1729254070.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

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
index d10a72132f7..dc6510028fb 100644
--- a/Makefile
+++ b/Makefile
@@ -3198,8 +3198,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+$(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3695,7 +3694,8 @@ clean: profile-clean coverage-clean cocciclean
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
index f4ffe64965d..fdf0c0ff769 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1049,20 +1049,20 @@ set(wrapper_test_scripts
 
 
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
2.47.0.72.gef8ce8f3d4.dirty

