Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F712F59C
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339063; cv=none; b=ECZluxtjWDVdR1NEtgmM3rCUf1CEK6HeFaZZttBvPJ38qXSMti1brIX5BeOF83xfOTBXq4gI1bi1U+QWOAgl68Tse9iSfqOCbWcPfJ2NiJODrnOWFhUnQTpvkXA1ogvfnPYeF0ntheebSM7kIvJF8kIBcDlH/v71RksejSzGDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339063; c=relaxed/simple;
	bh=Co3vQ05sQAXWZlXUQzyiR4ZxUHECrKSJJ0fMVYt347w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj1HZGxbjVntpeF/8KWDUfLLPoY+jTNmgF4TJCX2CChhHaWh4DwKm3q3qtgtv2wvtUfYlFgjPo4refkEbhzkqeULv5BwEn4gbuxB/r93o9jjS0y6Q8MpN/eR8E440+tMAR+/iZngkVLVw4QlOfsGTdAiUzcf6JGYbWYaAZwlQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GWO2a/JV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxQbIRo6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GWO2a/JV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxQbIRo6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85100114019A;
	Mon, 11 Nov 2024 10:30:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 10:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339058; x=1731425458; bh=DOb1P4/Px2
	WU4FAqbK0GOXGqNUyGpt7OhPhfQnFYlgI=; b=GWO2a/JVleeIfib9apwPp7xTl+
	oLVygdte5Fd2wjWAaNIKpC0+Wx4KxygOZfEXJrteGPUVlIiXLtTGpAQAh1gxDTqE
	ZqjdKt5h5nYjaFRVcUZu8c7hdqoj/dhOWXNDCCS+V2yJk4uHrD3McAKPjoVxxQfs
	edYKX8c6GVBlZlU8xFDcWqwPeHpUfKQT4u3isrOH2ncTTUv6LwEG7yS1mHsvV3QV
	SRyZsJ5j50sKB49tw6w/hMztcUqi5u98P+/uCDjHu6PD8bCMDUuR4qCBbh0VD/53
	S9mxBfs7MGjlApOgjFDLnk9IgujqdZjQVUeq+isnXKkX/baRXNCeiRzyYXlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339058; x=1731425458; bh=DOb1P4/Px2WU4FAqbK0GOXGqNUyGpt7OhPh
	fQnFYlgI=; b=RxQbIRo6D+Ci5Zxa076whBtiuZmgSN2U0Q15UqfHE/4zS+uNJde
	ocbDXHozMp4ZlMjYtOE+1y9Y+KZOUDzEoNtm+UiNxNIseMylY7j/V772eIkgkT0r
	XQ3y+q6+nrzvpeipZRM3FyG6NWx3oTo4Weso0G5TohRS+LPEM0iLNB5e+roRRrfo
	cFPIcjpAKuHlZybzoK/LyIA5XoYuSBvpFeAXpcWUEqAauDfsKilmp7Q+ZeHjLPD5
	/fEgzuTASBg8Imqsab4sJI0+VuqPtesYnykB7HYYR+SKCYHLK6Pq78IjfkUAKyyD
	kSpaGG9NWfkZ20yhqOZxDcMaIGLqJsyR30w==
X-ME-Sender: <xms:MiMyZ1X1A9p4isKfYurtG-ej8hO6xy_o1xG2PACOcQFJiIK5K8kHmA>
    <xme:MiMyZ1nva4pBJGHPZxZykIU12VQS3BJ047u_K91EINNpbUv-RIUqZgFiM9jhfnQ-1
    BGkR9taB2n353Ad6w>
X-ME-Received: <xmr:MiMyZxY3a7SnR6hWJX4hDcKEcIT3e5LS2RzbgLF_MUPjnjtsXGDdUrR-cmAI_Uf63xuejORCFvkVV4wC2nwuM0oFdQTqistkIXLzg_WysHW5JFiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhn
    vghsrdhplhhushdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MiMyZ4WkT0Zm6D8HazM6lK3TtCVo6aZbMPD-oaPfN9_qqLWlZO3xXg>
    <xmx:MiMyZ_lOmLroljCUB_iELl4pTaYBOFpzPDoALRwBP8T7IV3x8C18lA>
    <xmx:MiMyZ1fyP4bFaZsoeqfRK4cFmbVPzwQqn33rNeA2vP_IeUYHl2XTig>
    <xmx:MiMyZ5HqxemvKd3ORPntkJUztlzRtu-1BiQjN1ltptJ_urCFx25kbQ>
    <xmx:MiMyZx4RThM7vwvzDiznSnNG6Ut5BXKDkwj45n-foshF7w7WgzxOM5bF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:30:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33e292a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:22 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:30:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 05/19] Makefile: use "generate-perl.sh" to massage
 Perl library
Message-ID: <87dc74adfd4ca03a8f36e314733db36698d599cf.1731335939.git.ps@pks.im>
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

Extend "generate-perl.sh" such that it knows to also massage the Perl
library files. There are two major differences:

  - We do not read in the Perl header. This is handled by matching on
    whether or not we have a Perl shebang.

  - We substitute some more variables, which we read in via our
    GIT-BUILD-OPTIONS.

Adapt both our Makefile and the CMake build instructions to use this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                |  2 ++
 Makefile                            | 10 ++++------
 contrib/buildsystems/CMakeLists.txt | 23 +++++++++--------------
 generate-perl.sh                    | 14 ++++++++++++--
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index f0ca240493c..050432f9fc4 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -1,6 +1,8 @@
 SHELL_PATH=@SHELL_PATH@
 TEST_SHELL_PATH=@TEST_SHELL_PATH@
 PERL_PATH=@PERL_PATH@
+PERL_LOCALEDIR=@PERL_LOCALEDIR@
+NO_PERL_CPAN_FALLBACKS=@NO_PERL_CPAN_FALLBACKS@
 DIFF=@DIFF@
 PYTHON_PATH=@PYTHON_PATH@
 TAR=@TAR@
diff --git a/Makefile b/Makefile
index e04a381e8f0..fc13d5bb01c 100644
--- a/Makefile
+++ b/Makefile
@@ -3093,13 +3093,9 @@ endif
 NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
-perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
+perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS GIT-PERL-DEFINES
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN) \
-	sed -e 's|@LOCALEDIR@|$(perl_localedir_SQ)|g' \
-	    -e 's|@NO_GETTEXT@|$(NO_GETTEXT_SQ)|g' \
-	    -e 's|@NO_PERL_CPAN_FALLBACKS@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
-	< $< > $@
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@"
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(call mkdir_p_parent_template)
@@ -3160,6 +3156,8 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
 		-e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
 		-e "s|@PERL_PATH@|\'$(PERL_PATH_SQ)\'|" \
+		-e "s|@PERL_LOCALEDIR@|\'$(perl_localedir_SQ)\'|" \
+		-e "s|@NO_PERL_CPAN_FALLBACKS@|\'$(NO_PERL_CPAN_FALLBACKS_SQ)\'|" \
 		-e "s|@DIFF@|\'$(DIFF)\'|" \
 		-e "s|@PYTHON_PATH@|\'$(PYTHON_PATH_SQ)\'|" \
 		-e "s|@TAR@|\'$(TAR)\'|" \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2ae337c61b5..97504c3d7e4 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -849,6 +849,9 @@ endforeach()
 
 #perl scripts
 parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
+#perl modules
+file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
+list(TRANSFORM perl_modules REPLACE "${CMAKE_SOURCE_DIR}/" "")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
@@ -856,9 +859,12 @@ string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
 string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
 file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
 
-foreach(script ${git_perl_scripts})
+foreach(script ${git_perl_scripts} ${perl_modules})
 	string(REPLACE ".perl" "" perl_gen_path "${script}")
 
+	get_filename_component(perl_gen_dir "${perl_gen_path}" DIRECTORY)
+	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${perl_gen_dir}")
+
 	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
 		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
 			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
@@ -878,19 +884,6 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
 
-#perl modules
-file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
-
-foreach(pm ${perl_modules})
-	string(REPLACE "${CMAKE_SOURCE_DIR}/perl/" "" file_path ${pm})
-	file(STRINGS ${pm} content NEWLINE_CONSUME)
-	string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
-	string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/perl/build/lib/${file_path} ${content})
-#test-lib.sh requires perl/build/lib to be the build directory of perl modules
-endforeach()
-
-
 #templates
 file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
 list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
@@ -1132,6 +1125,8 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_
 string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" git_build_options "${git_build_options}")
 string(REPLACE "@TEST_SHELL_PATH@" "${TEST_SHELL_PATH}" git_build_options "${git_build_options}")
 string(REPLACE "@PERL_PATH@" "${PERL_PATH}" git_build_options "${git_build_options}")
+string(REPLACE "@PERL_LOCALEDIR@" "${LOCALEDIR}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@DIFF@" "${DIFF}" git_build_options "${git_build_options}")
 string(REPLACE "@PYTHON_PATH@" "${PYTHON_PATH}" git_build_options "${git_build_options}")
 string(REPLACE "@TAR@" "${TAR}" git_build_options "${git_build_options}")
diff --git a/generate-perl.sh b/generate-perl.sh
index 12e116b76e5..cfbff20f55b 100755
--- a/generate-perl.sh
+++ b/generate-perl.sh
@@ -17,10 +17,20 @@ OUTPUT="$5"
 . "$GIT_BUILD_OPTIONS"
 
 sed -e '1{' \
+    -e "	/^#!.*perl/!b" \
     -e "	s|#!.*perl|#!$PERL_PATH|" \
     -e "	r $PERL_HEADER" \
     -e '	G' \
     -e '}' \
-    -e "s/@GIT_VERSION@/$GIT_VERSION/g" \
+    -e "s|@GIT_VERSION@|$GIT_VERSION|g" \
+    -e "s|@LOCALEDIR@|$PERL_LOCALEDIR|g" \
+    -e "s|@NO_GETTEXT@|$NO_GETTEXT|g" \
+    -e "s|@NO_PERL_CPAN_FALLBACKS@|$NO_PERL_CPAN_FALLBACKS|g" \
     "$INPUT" >"$OUTPUT"
-chmod a+x "$OUTPUT"
+
+case "$INPUT" in
+*.perl)
+	chmod a+x "$OUTPUT";;
+*)
+	;;
+esac
-- 
2.47.0.229.g8f8d6eee53.dirty

