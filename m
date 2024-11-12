Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B61213EEE
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431021; cv=none; b=nKBRPrEFY0TdxFexDZGbh6g9nwiXwHfdT2V+rMf9CzR0GCFfL5j27wRu8wFo/KA48jlbBCDEPRSmlZJnOTF7yiJEeh1Fci599cnIONdVRmQOBxjAlDH7+SFJbqr0aTceauX28adbZ9biwrQo/REVTQMQm3QIv8ASWZisiScDHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431021; c=relaxed/simple;
	bh=xVLUJABDOPNXcNwJFI5NN+3q9pBsMYgCpRu0HgefDLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XS2hmJp/CkIbxd+g3Ic5FeN8VKPCCVfxLM5Po3mSGGsP41YpYwEeWtnSvcjdeAeSXyfFleSZO8/f9SA9R613N2eJ6wVH80rDBoI/Tnb1YKweSsmLyIAxFhX2BXEX8l+g4WXrxEpE2BNEoBWlsVNM1f8v1i6zmkwQFbhgs+OLsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3rL4+iBl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JmiHKdHU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3rL4+iBl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JmiHKdHU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B64EE254014F;
	Tue, 12 Nov 2024 12:03:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 12:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431018;
	 x=1731517418; bh=4UT4UwBsOFGbieXrNW6MLWI37zDh5jsXUPk5SFfJS2Y=; b=
	3rL4+iBlMt96GJwgjCW4CdUncZpLBij5IrQ2ZkvOtyFpJhcP6fKfPKsANxR0g7K7
	TN/LA3/AVomcArwDsIOyNdfS+lxqUSWHfvDDgJ5396AmLj+2NBkN3NPtGXtGmi4W
	LHoaHjOiqS/gd6xyEC1WFRZsTNvyd9O0/i3tF5w3HHnBvGyNoI+K7PVTSnSspxif
	Kg7z+4owCoNEPmoYAFqjSlFeP5zoMKpqPnM8Bjn08Dv+lqwz+FQZwG2/Q4YRHFzN
	0YRqFOTnxcbs7s0Rb2fYBHyh+xdoR5VJ79BTtNOQMxBuMFpwNokdHSlb0aDFAloG
	On3z1raY114Mxff02cjhMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431018; x=
	1731517418; bh=4UT4UwBsOFGbieXrNW6MLWI37zDh5jsXUPk5SFfJS2Y=; b=J
	miHKdHUXMaXT/W2kOmmowKUmo++YSuPgqXUbtv2cnrXIOVtAgNzmlAdCuiUys8cr
	jBHQgjIE1soYRBZ+Tk/U7EbdpAH0gAzgmPaVmMirlSgxX+ZGyCK6Hgs9srg64pBx
	2SBos0jtKpnrFT+EaWw266XNoWKfKPFKLeCgOYciSogMirKbtIFVvmWX26OcUhxl
	g5Ts/mzUvHwKCSFtiuZhTOi292DXu7CM5SUx74xIOecTmkxREke9n+yXoY1mR31q
	YuC6lYn7Q0g3rpjRHUosuubob/jPMfeF9C8yyEgLH8Nd+lDdf3LL20TvGsC/hJKI
	Q74K5f6r6nJvkGJNjvATA==
X-ME-Sender: <xms:aoozZ48nww2I6gkokCOsAlkuUgUiFQrr_qvWn37P8tv4vDrIF4A6KQ>
    <xme:aoozZwtubPN3jMNh39Kfk2YzGVFf1XiCc7MsHArBmx6SxAiNYnwasam_krkxWDERO
    l9HBMhpisOaajJJwQ>
X-ME-Received: <xmr:aoozZ-AUjQP4V2KQD-AdMPSNxdRSMeWCklQxB7fA6XUoTy23yR-ZtXvROk39P0hNTBLfqaC6ThgY-NVOU57tN5OmgBobOwo6y4Q8lZh6u_c_uBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehrrghmshgr
    hiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:aoozZ4ePNgfNIpgzFmz7BzlfwgQGjiSv74cT0NdJGJvrBKnjX6SXTA>
    <xmx:aoozZ9Mq5rWuiWIJfkpmnVOrbv4mU9dllg8EFBRMAHLGgAM3G7OwnA>
    <xmx:aoozZylq5DK37_HWpA3uIEPtvKiJ26WoXhvEDqiFs5gqvFAFRD9cOQ>
    <xmx:aoozZ_uaC8HU1pNknefh1ykv0CMKeQ0_CYeAnfZXqJmluEDpLnd9Pw>
    <xmx:aoozZwqgOggspxEQyro_g4mYnrX2RhTKVpAxZ7w0g65Lzg6muJ8SfP8X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9df015f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:53 +0100
Subject: [PATCH RFC v6 10/19] Makefile: allow "bin-wrappers/" directory to
 exist
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-10-648b30996827@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
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
index 6687bd6db4c0a6adf02292a9cb545d3e5270e2b0..349673c55c944f0e098ebbe8f74be60fdaa0a304 100644
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
index ba79a514cc4f906ead5b64884cfeeb06c62e4635..f6f4381c8e6246e8dbab0ca0193320146edc9dca 100644
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
index 73a3cbf5302fb8fac9965299a19b28e7b47478a9..4f652927b1f3a2906bc5cfd0f7ba44a025770883 100644
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
2.47.0.251.gb31fb630c0.dirty

