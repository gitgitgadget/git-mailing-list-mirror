Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA171D0DFE
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882197; cv=none; b=F0uiGlu/Kkp0k7K7lPjWDbSrQFFchS696LYc1ElgfRIqHZ0Krxq9cZZfeiw0BXxgvKBC7XxqhSgfmN2ARFsk2RIS1mN38C2VqvZAaQniSKYU2sSjbE+xtHs8JZwZOTD223JZ5mkF0CE0rbKWiKc+Ha3cgvlXEy97fnIXqqg59Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882197; c=relaxed/simple;
	bh=AYj/GsYyhdYE35iXmXAQ7OEyaBKjTVeXn++XSDkLzCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+9nKC2/WTl65GbJ7wUI6P4JpoRIuNjNUIEyhL9Yo3lis35pQM4FMm88GSoRMleX70HkLFz2VI9H3E8wuPUfi8uFLGT5Q4G2q15CzMjaVNL+IdRg6gHHrH7IGjd+uvn4/r/j43N3nvshrF8Q0nUj9BrnDRxRzNBb8Bs0U/eB9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1QaGQOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WoewAkOQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1QaGQOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WoewAkOQ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 102171140170;
	Wed,  2 Oct 2024 11:16:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882195; x=1727968595; bh=/6GNTsZj0k
	pfb9WqHKlhNc+6YrtA9GHlv92e9zwRTZE=; b=Y1QaGQOdWtTb28FCDLGcM/U1Zp
	GziLSxitFNYy7iu/Twrx43oj2HjUZVGEj3OjmDtYI4nayw8TMamqIgFsDIWNjcwf
	fr5iFD72nrJIpg60deQNVIPRT+ay/wkqlLkWb89CXv4yNUz2z9sERGO6yIxfxhv/
	/ePV564edz5LTz1yrky181H+D7714kxFqMHuyXOx2J+QKL1uTHruB7bQqzbJktYk
	A6sIa4Y8QSLGyW36Xu5+mSOPHLfm+uVYN6laSoRiKUN7xXfFAZqtxClK3srPyJdX
	D/NoX8CDoSyaDp448L6wp8GEVMKnSvwT8LIQC00YC/hH47EfIehLIHJJ/gAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882195; x=1727968595; bh=/6GNTsZj0kpfb9WqHKlhNc+6YrtA
	9GHlv92e9zwRTZE=; b=WoewAkOQcc9BwcSXHFuzjiVYP19/vIeHOIkToFocR2n9
	IMhhmm40ramBaWyYC4HaacfSO5QhzcevnHopu3utuhHOY4LObXTeqHrnD9TMmECq
	P+qP+nPiNNu7RWHmhXu160wrqbf6zdqvNKHtFE4tjPbipPbOqr2de04Tyn4WgWN6
	xgExNtusLHhsbpX0kksumKp7jbEbnv148ES6HRK98iQu8aFbydtqspW7x2hs8JAZ
	5+Cl0tBXBnQmbxMGWgw6adjwBagfN5BPmEZauylAL0bpV6FWW9i/79CVkJcPFyh9
	UFP8Cyhgcop+BmkypLULtX1BgXNCLIALGXAYcXR78g==
X-ME-Sender: <xms:0mP9ZmNvJtl1H9fgY1GsQ_cljpIxRzcj1BwfUyheMwg4dQoVFOrHsA>
    <xme:0mP9Zk97qs71j2p-t0jAP5NWu7LYwYeAYeBW_UVwPwr2yA6Tgtrig3s68v4Ph7ptb
    5Of6J_Pk5XU1fYP0Q>
X-ME-Received: <xmr:0mP9ZtTSk0_nT0krHz73mHl_bXVHEFWt_3idc6MS-5IoDMtHkh8bCEaSwwgwPYLwvZQixTPm9Ami9GLGs_ZK6k1_ErBMtpVYSDqFusq6mnPxnZ2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:0mP9Zmuoriky4cmLGj23uWB8ElJaJpr6KalZUK7V0hyU07vOcY1njg>
    <xmx:0mP9ZueblfO-7iTp2xPTZ9A6Nlt1TdXZFvWUj4CSbJkeOtOnApOALA>
    <xmx:0mP9Zq2Hn6wVwhZ4JkZbgcdw71J8TuvZWCg5c4U9WDPfpOeZliSe9w>
    <xmx:0mP9Zi_E61_aaxLzsSavR7Tm3HG0l_d9Ph9F2OnHgo5OrLZAu4YT4Q>
    <xmx:02P9ZvqeSxCLCakwF6UP9oBrsuQnnObEM_TGUbzEYUOZWvqKm1ifMKCQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7abad843 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:43 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 17/21] Makefile: allow "bin-wrappers/" directory to exist
Message-ID: <4b356c0b6341741c8100cdf11e1634caa56eddc1.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

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
index 6687bd6db4..349673c55c 100644
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
index 3263245b03..ad83156744 100644
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
index 380b6a3dbc..b0c21c4c0d 100644
--- a/Makefile
+++ b/Makefile
@@ -3189,8 +3189,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3686,7 +3685,8 @@ clean: profile-clean coverage-clean cocciclean
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
index 0000000000..1c6c90458b
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
index 5884fa73b1..700f4e5160 100644
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
2.47.0.rc0.dirty

