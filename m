Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6E17C21E
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655306; cv=none; b=ngudxgLMpdnXtdQggox97gCfaM98Fm5lak5rFl55LotrKYVXzFWMChb/3A4y4yD+r3fXHLIADduRXU8kzarw1WuRW8CCgZ36x2YK6Z0xfgc2myC3Db8QfzjziVuUGBP4MVXm2N9BNdDN9YPwzC9pgwo27GwKnTLC22DS1oFib3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655306; c=relaxed/simple;
	bh=vaw8oGkTt/B6JnHTkJvJlinCt0nUMT5VnZx8yLFjk94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ec8XO86G/SW8bi20cSAAvkLOkHpGwPtyDsfIAGkoMSIyEW54+EfabeBAuwCvN5ORB4zCh8BMDQpKI8SjYhyIGaOIQ1uHOGhSuIUi3hbasQQDCdY/CyUOzrk2qApnHUMkC6ax/14+l7AefdYWsUNlhxveRC5wxsrdkfkeeMnF4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V9OEtcZr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzlNbZQo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V9OEtcZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzlNbZQo"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 500191380648;
	Fri, 15 Nov 2024 02:21:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 15 Nov 2024 02:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655301;
	 x=1731741701; bh=HyUrIcK8R3029r8MvxWn2ntl53lxfgGif0pN/pYTnnI=; b=
	V9OEtcZrta5GtRZ4l5X60apz4Ip437Vq9Ektul9vf4aaTvXHagQdKXN1GD6kA93d
	Oo0RvRKc1FmWxzBfeebhGmlOlalM3jNM0tiYkHHsbIv5XfU6/Ph/61npLO+3vWC6
	1iO+sUx1pkBMEOOzw3KwaGqAUuwliAinrO/Q0AVhkywybqnxlMDR3jfgjfqmVj+R
	Z/+nkNkN6ht6PmppP6Axb8Z3yFmzFCq1BCXG3S4hN0B7jjenM4R4iYTaMRSHMT0+
	+WpCD4VGqUy7XrQPgswj+yVgsedCFzeZvYLrLWveauTPYsqJM2E31c2NcKpiDlzt
	8AQwvHRiNterpEPK0acuAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655301; x=
	1731741701; bh=HyUrIcK8R3029r8MvxWn2ntl53lxfgGif0pN/pYTnnI=; b=X
	zlNbZQoZhXvaLPT5Gn3XunzxMBRXsYVKFdBqU5L3CeHBzmYhzYpZjV6BZoXL0pzt
	jmsdXCZERUx/67lELtD5crW40WkdFcHl5orAQcj2v/1LlpcNLEtxyrriWsyLgPit
	ntEti/QTEYaErS85g55mF739TfPuGk+GfUIZRq/N5PKOH7+jC9tNY8kN4FFbimAp
	zSn43UtLIIG6UqQlxDxe01kIpsiM6pNq9JHkBjR9hJwS79oOdMhzJWmfIHx+oF/0
	e1BWJ60OeqzXkOaYSKK4OQB5RnYBcUlljq4TK/czT49V0grcuq6Lh6QN8HOI+3nz
	9g5/UlFamu4WpMdkAvkgg==
X-ME-Sender: <xms:hPY2Z8zIfunQ2EFDUyP8k8whqAesSWKVfbufBXLQtbg6q0tOxWr2Zw>
    <xme:hPY2ZwTjaJ-hx6ntD43gy5uHX-ZWdQJNIbECDK0oL_Jeem-agX5TO2qIoU5lxrWqU
    P__FkLKpfzSE1QaZA>
X-ME-Received: <xmr:hPY2Z-WYrtKt35TtFFcn65kfdvvGvwTH_CpxZWBtGRPjNM7SdBGkWQWibVwGDvOKcsWLggc04VuYpD2pLxPNeDynrqMTFtua8hbiXJTdcPKknc-aKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmsh
    grhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:hfY2Z6hDtF8gbeRX1zzc9dk7FMgbgEcL7KJJau8c1xzNnZrvUgArYw>
    <xmx:hfY2Z-CCrf80dyrZaTR3Ru1OLixl1VMtLpsnaphoKtBAjD1_57wXOQ>
    <xmx:hfY2Z7KV3Cd7mYlZ0xOfG8OljcTrkwaUujJj6-GCc1n4RMFtWw-WUA>
    <xmx:hfY2Z1A6H_ZG-oA2QRtB-N2pDZbzBDySQ5p4Yb-unRcFcfvdf5_3zQ>
    <xmx:hfY2Zy6N-iN1E6IrX0y3OSPDsHolFYNqKzR-I_8aX0wksGCXzB-J0Y_0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7de4af95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:20 +0100
Subject: [PATCH RFC v7 08/22] Makefile: use "generate-perl.sh" to massage
 Perl library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-8-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 669ee4fb8d28fd9e1aeb0a794d5ce44ba60b5c9c..8aaa5bbfe2bd11aa88b7578e17b9839b1b9b0a0b 100644
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
@@ -3162,6 +3158,8 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
 		-e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
 		-e "s|@PERL_PATH@|\'$(PERL_PATH_SQ)\'|" \
+		-e "s|@PERL_LOCALEDIR@|\'$(perl_localedir_SQ)\'|" \
+		-e "s|@NO_PERL_CPAN_FALLBACKS@|\'$(NO_PERL_CPAN_FALLBACKS_SQ)\'|" \
 		-e "s|@DIFF@|\'$(DIFF)\'|" \
 		-e "s|@PYTHON_PATH@|\'$(PYTHON_PATH_SQ)\'|" \
 		-e "s|@TAR@|\'$(TAR)\'|" \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e2e7d3da2028cd36a9761f78607539080361b3ec..0f9180937e76cad4ad831d34877ea276413e76c9 100644
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
@@ -1147,6 +1140,8 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_
 string(REPLACE "@SHELL_PATH@" "'${SHELL_PATH}'" git_build_options "${git_build_options}")
 string(REPLACE "@TEST_SHELL_PATH@" "'${TEST_SHELL_PATH}'" git_build_options "${git_build_options}")
 string(REPLACE "@PERL_PATH@" "'${PERL_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@PERL_LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
 string(REPLACE "@PYTHON_PATH@" "'${PYTHON_PATH}'" git_build_options "${git_build_options}")
 string(REPLACE "@TAR@" "'${TAR}'" git_build_options "${git_build_options}")
diff --git a/generate-perl.sh b/generate-perl.sh
index f168cce734dbbe80b58b4b761b13e8a177f70642..d9eaed86218c5f74fdae06bf3170808104058fa7 100755
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
2.47.0.251.gb31fb630c0.dirty

