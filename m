Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FB1C1735
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810360; cv=none; b=eSry29Njt5FktMWYeY7NLS1+UbLG6ZDhfMSCTlf5YR6yAA4rfkDaoR712bD4cgIBFem0W4DeMD9OdHn6aDuQOXnucDPx3jIBF/PSnRr3VZdoEAb8fSZmSnYDWGKBzmF4g7/7xC/vEiUd8WUTgXJ/KKajjlNVUxTzff1HX+2SURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810360; c=relaxed/simple;
	bh=IM7FNu+NZS++Nj2M2ixmZT7J4n0P/yLaYf1EunZ7N04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGBbgnXDq2WjyzhsjC9SJSAlNUlyMFckW+jTZCSwkc4g4j3kXVHaLYk++MnPYzwyZmoR6mpWe24NqJI47M3G6XiMS6BZmTqwRs/47vEsUErYmZu9a7GYdsTYevup/Gpaj4mEIZFF7mteDDt8MCABGMrgjhmSwQK3dhT7OhE+VOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gaisoXFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkF+JZau; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gaisoXFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkF+JZau"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 92072138020F;
	Thu, 28 Nov 2024 11:12:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 28 Nov 2024 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810355;
	 x=1732896755; bh=0gMVlWoWqQvuprk7ZpnNJ0M/9wBozyx6cYd88WQglK8=; b=
	gaisoXFVbWWY/s3iDkKd9bQnLr22UOfNchDusfUh+zTuTjPO+cRFMG45iTeAgUvN
	mxXIgPTL6zxcTbLxV3Qp8ms9wQ45BBLng0X5zu/bZmAhHD0+SpIsgqZDGDNNXtZv
	W7RPu5ZCQfGJ6/TAHPhAiiMBxNkx7AQm3DvPTRh2ZyLhXMtxCcTNY9hsYLrPgeRf
	RAEcSB0CpglYO25YufGVlBOgMW/W453AToqS7gtLpTPdIiWGqsokO7z533oh7YNE
	3lBZY22dDAi9fjGA4QEPIgbUtK8fbSKw6P6QtfpqBl61NAaZRJvjY0t5CcI+VfkI
	qqQ6YdJeGyIGmVmwDSX73A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810355; x=
	1732896755; bh=0gMVlWoWqQvuprk7ZpnNJ0M/9wBozyx6cYd88WQglK8=; b=I
	kF+JZau4EusUTb3W5apUcdwkdrWEY5jpA+g8a+ICumUzDTRG0SdUgq7ShR+/3pV1
	iRi+6F1RzktuuM5F0fcZbGTIgrhnV5gOBju9cxZxiLCLoh646rVbEzwIB20nlhEI
	KWQNhpbTrr2ooX3egmezL2UDsgqP1UrNTCQpujf6skyC0QSwzAS2eaevYdff9A2w
	6T9vGxbPjxs3s7GPIolyMWElZtT94mw/4WDDdQB5ehFyurpDde1nN7u7o13h+L66
	Lgndo8LM9mfZH2i1eTlDD5TLvXQsBuZ9p2SweLN+iQ2fhUSYRi4Tb7yiHiRaGiai
	T9C2iCrhH4N0rIdvMSzwg==
X-ME-Sender: <xms:c5ZIZ2iZ7xISBh7Wg7RSQoGlsUVaLyfTuQve_iIDScL1inFYcz5TCg>
    <xme:c5ZIZ3DdrTcrOEaP5eeRXCicXLCiEHFzBN9yajdaNN5YBPoO-2yRtQy2MCAkw53uJ
    Y0DT5Vt40UqYlortw>
X-ME-Received: <xmr:c5ZIZ-FAmiQl49o1qhA68vFiqWThF0_uo52rfqFHRsGy0IH_I9uoufLkJOmIk2uOiP48jE3Obo96-BH1qsSIxM1GwBYP8bGedbNN_ouHcNZARQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgt
    phhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:c5ZIZ_QxR14bkWfSL_oTtlpcx43sBrtBae4lcj_EIxdpBMqsboNpBA>
    <xmx:c5ZIZzxBZfwAuvCTgYHLslTm2UhCEzjenIGqoa_nLeVpK7iknBQNxw>
    <xmx:c5ZIZ95K7xtODJpbQxx9lRe69E9nERa2XrnIodG1sxcPGtZtxScp4A>
    <xmx:c5ZIZwzma92Q3SMrna2gK-UjlLBRbXFeegJKpIgImJMKrAljdmdh4A>
    <xmx:c5ZIZx7RhWGAlqACkelCsORjeCk3ZFgznQaivag3rzur3eMSAiPqlsxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8987a325 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:10 +0100
Subject: [PATCH v10 09/23] Makefile: use "generate-perl.sh" to massage Perl
 library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-9-79a3fb0cb3a6@pks.im>
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
index f0ca240493c94aa41a6b6241a8474e42f7cdc8b9..050432f9fc49f93d0f6ed98c1307405c52761be0 100644
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
index e33c5b966c7c6cc9ea5d8a072458f11221a21513..b8f96581097d7a29a745afd81de2f58b703da7da 100644
--- a/Makefile
+++ b/Makefile
@@ -3095,13 +3095,9 @@ endif
 NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
-perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
+perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS GIT-VERSION-FILE GIT-PERL-DEFINES
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN) \
-	sed -e 's|@LOCALEDIR@|$(perl_localedir_SQ)|g' \
-	    -e 's|@NO_GETTEXT@|$(NO_GETTEXT_SQ)|g' \
-	    -e 's|@NO_PERL_CPAN_FALLBACKS@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
-	< $< > $@
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@"
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(call mkdir_p_parent_template)
@@ -3168,6 +3164,8 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
 		-e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
 		-e "s|@PERL_PATH@|\'$(PERL_PATH_SQ)\'|" \
+		-e "s|@PERL_LOCALEDIR@|\'$(perl_localedir_SQ)\'|" \
+		-e "s|@NO_PERL_CPAN_FALLBACKS@|\'$(NO_PERL_CPAN_FALLBACKS_SQ)\'|" \
 		-e "s|@DIFF@|\'$(DIFF)\'|" \
 		-e "s|@PYTHON_PATH@|\'$(PYTHON_PATH_SQ)\'|" \
 		-e "s|@TAR@|\'$(TAR)\'|" \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5cb9a209366e80ef141c6349fea9ddedb2f83d1a..52b479e2e5342c3a08c83ecf77a83504778f16a0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -853,6 +853,9 @@ endforeach()
 
 #perl scripts
 parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
+#perl modules
+file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
+list(TRANSFORM perl_modules REPLACE "${CMAKE_SOURCE_DIR}/" "")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
@@ -869,9 +872,12 @@ add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
 		"${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE.in"
 	VERBATIM)
 
-foreach(script ${git_perl_scripts})
+foreach(script ${git_perl_scripts} ${perl_modules})
 	string(REPLACE ".perl" "" perl_gen_path "${script}")
 
+	get_filename_component(perl_gen_dir "${perl_gen_path}" DIRECTORY)
+	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${perl_gen_dir}")
+
 	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
 		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
 			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
@@ -893,19 +899,6 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
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
@@ -1155,6 +1148,8 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_
 string(REPLACE "@SHELL_PATH@" "'${SHELL_PATH}'" git_build_options "${git_build_options}")
 string(REPLACE "@TEST_SHELL_PATH@" "'${TEST_SHELL_PATH}'" git_build_options "${git_build_options}")
 string(REPLACE "@PERL_PATH@" "'${PERL_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@PERL_LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
 string(REPLACE "@PYTHON_PATH@" "'${PYTHON_PATH}'" git_build_options "${git_build_options}")
 string(REPLACE "@TAR@" "'${TAR}'" git_build_options "${git_build_options}")
diff --git a/generate-perl.sh b/generate-perl.sh
index 95072522da4aaabc74164737b72568ccfe4962fc..65f122ebfc76dcce607aca07fdbd9dc9e65a6b19 100755
--- a/generate-perl.sh
+++ b/generate-perl.sh
@@ -18,10 +18,20 @@ OUTPUT="$5"
 . "$GIT_VERSION_FILE"
 
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
2.47.0.366.g5daf58cba8.dirty

