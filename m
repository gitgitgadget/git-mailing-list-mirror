Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E41953B0
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528646; cv=none; b=j8/juON89r5g+2DZoBUM32hVRApBWAXfwX+XXOiKzncQCm5aELQYFGhiK4fxAJIRQpM95Vy85MIDxs+R7c3ayZtcRrB/axfbLwKBWkOTO41/U4ckKtTygXsWUpolmNZge1kAcjiUGurGMVhNXnXmliZHnffrst/alhIbZciuJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528646; c=relaxed/simple;
	bh=Mn5Mj15Uqpvn2CI0S1I0TK+x6uu01m7tE3MiwqsjV+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=klDmKZK0amJ48DlgVCXqke47kSFDDWli3WKc8syWBbQqiZoqTTctm1greK6W5Xu3bgfIoVTzlk1xE+KA8B4LkG/3pJ+0IzYZGMYBFgdCbS5iuW3Nmu5kxC8Mf9+ZmfZt/h6NfATiE781+3wrV6YjMZukWIHlXB69EY8KoQ84ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JHGM6OpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jlmLWFaB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JHGM6OpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlmLWFaB"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 587DE1140166;
	Mon, 25 Nov 2024 04:57:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 04:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528641;
	 x=1732615041; bh=S2wEZijN4TssfbXP/qQLZnf3GZXMiy+6UaX9eYLTp2k=; b=
	JHGM6OpBctYpa8e7HEVFGKxMWV/gNN3LpIWL5JQeesion0EOqVPved84M163kI93
	y6P+Xlajssxh3Ag83IYBxsshca3+tA+vFw3oHAvLFKe11J4eJsHrqZGR7SGbfKWO
	bxIZiXNqHqaZIc3tb8zs9jNm/j+9yc5SG2s717tY0QgC7qR5gua48Xh2F9q85ZyT
	wXzL8VHsMLytWY7h3L2NlkJq+O672Zh1XKugKxuNBy6OU1kOol5AcpV4F3IMF1Ut
	G8IupnTpIXXTeDb2qfuJistNhGiYwSUj6uJSYvhfbCjkUD1IAMaSTbfYNm+fgmFa
	vIXcbD2BLLeccg++YWI+iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528641; x=
	1732615041; bh=S2wEZijN4TssfbXP/qQLZnf3GZXMiy+6UaX9eYLTp2k=; b=j
	lmLWFaBLK/Gi0BcGNBGo3GXhDf1bj7hfD4GVLs2xanG7JpgETasvPRW5pgaD7YbS
	f77qihoZI/01MK5El7H7wh16rFm91hmTc/8ZXldYR6TpX1ZmkbzaeYyOXYG5law7
	r1/NxsWyYWwn10+MRuDYyHUjoFACfOSiTOZ99e496BnDQ/gq/xo1lqHtrRQJHDvY
	CpxuOQ5HYIfeXtmPpnwEm5CM5nM9ypkB7Bb86q2HngFpDzFLwVi4ZdXBIlMNJfc1
	ip/FpDVUlxROquj+R6UGslujXbeX0q/ofrlqDkzlVUqvYaWlVesI88ZzibHrJFQo
	dXd8Lu5yvpl8Q3CXCNOag==
X-ME-Sender: <xms:AUpEZ9N71b1JLhWXkI8ebVDbb-GmpXFT8xaHOoXDwfByrpCIStul-w>
    <xme:AUpEZ_9mnwmkxSrBkxSCDU_1phYSyCktE5mZoWVf9xjevAKJJflR-JmLtR8uH1uQS
    ZyBRwXgdMQZw4mU9Q>
X-ME-Received: <xmr:AUpEZ8RM3Fsda_LxWtDUNFO0aFj6h03CdFeypV8sBX9ZzTU3gHY7It-wUyn4ITU00Amc8Dd1xKnYD7N9mFj6-h2PsXF9t3nw0hC0cFqjbFQlfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
    dprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:AUpEZ5szWAsTDQYIMJ6-lXQF8PE3Kd1Qh9klPo5lp11sJh2iJDMyAg>
    <xmx:AUpEZ1f_EkzXv_roBmZR52aRqLhjrflsrA-4seFuTSW3SGI-UHwzVQ>
    <xmx:AUpEZ11-mczm_mDftsf3lk3C3TIySCM46z1uwzkoHRTED55uS_jZ8g>
    <xmx:AUpEZx_tO5tsZfu3jrtzPVeVlxDsOX6NgdI3RhIk2COatQUKRvpnpg>
    <xmx:AUpEZ13ir4aqIAef7AVsM_uWCdsJSm9gB_CKuVb0q_Z0ac1cif5REIUV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c5c268e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:57 +0100
Subject: [PATCH v9 09/23] Makefile: use "generate-perl.sh" to massage Perl
 library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-9-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
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
2.47.0.274.g962d0b743d.dirty

