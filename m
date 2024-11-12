Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6CE212D04
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431019; cv=none; b=bC4jtkBRzwb+T+VVLQIOesjVk4J0v5xEVIT8p0EeX8ZfjrxvTYsylMVQnUOntz3wUTVq/UxpgElfNbJDfaw+NOHmgg5ZTyDX/9HNRBsvQ8+fFdLO7kGGdk+Dwn0A4zgXiO1C8gosLC4uSUcAa4hQj7rZQeJ73l+tuf3DfontXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431019; c=relaxed/simple;
	bh=MhxFIGrpwCWOjGExL+U7U5pcHT7mnL9lxAzrQSL3Gts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKpHL3nFVHw91VshI3DRCAWkFf9vey9nxSTfuFbLv7QmjL+dNN1IpuYi7k/cIyylPodTBNhV/rEDJJkweX5RjXQsl4GCzLfu3LB8rT7bUKzbXV25V8aoHLeNRukuXIeCRAzM8irgwtx+RjHzs3fr4AzUx3L4k506o8aJHlSymz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rRJv+YSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OdH3AGS4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rRJv+YSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdH3AGS4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 184EE114014B;
	Tue, 12 Nov 2024 12:03:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 12:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431014;
	 x=1731517414; bh=Z76dInhQSIWaEnE2MOAgZWceTZi7Hg5mGlHYPT2QbgU=; b=
	rRJv+YSiu/dCsfOro0K7T/gUpOVwxmcOueS2OWC1kip5zQI5Dxl1jz3CkOxkz0td
	wYUbpnOS9b9NzfZWTCegl7p9ApMzdptYHZIbnkUb39QdH+6So0E++dKJfIE1sX1T
	0jM7atVq7e53s/YR3CAZyVJKZlskYzxUlmX+//tFv33Rcc2Wy+ZC2juLEKGJ/PMA
	Or0xTBDsB4dQNpWQYsoms3Ema18wT1ECNhL3bRATgvTTYJmLvd9eMxaSnGSpLt3h
	rdaL0jDG8xsoIfn0zIkNBhPZwKeuGkNkCya4JEtiGQAOpFgSY0FgR4W/dsw3oyH/
	gCuEVIQohuX7sSix+lwOcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431014; x=
	1731517414; bh=Z76dInhQSIWaEnE2MOAgZWceTZi7Hg5mGlHYPT2QbgU=; b=O
	dH3AGS41pxYUbl8CqOeob6Rq6Thwb7SFib3XIPOsnUh0LWl0/Vk31YMbXMUfK3mX
	W/M0iFDgpRLIO4tX9MZL9tvzvOAdG491ZIcYvq4rcg+h7lmUMbKKhkjbkm/pbLR3
	k4p9/U4vSRU96jMDtqdQ3cFffFnOE8xDenINuAtl7+9/7R34vLBA0StwTRHLai7J
	T+X4cocQHTVRTdHIETJFZqH6sKC5FRTspuNLLMibQeNmF2/eHYmHbiJqyemGS6Mw
	E6ZO/62v1QW/B9XWyGSRdJhFibxRgvhTBy4HygWswfFdJO/YJ95HHcLpFACQHoOA
	5Q28M+5MLaH/st6vsxxfQ==
X-ME-Sender: <xms:ZoozZyrAnI2yJctB9lqCTTIxbYQnpxKiMXBjjyYRB3ih98fV5oL2vg>
    <xme:ZoozZwqqEfs6V__ZcanYG55MSfTdzfjidnnRWl5JrNPmKTDDHV4T6qi42lk8PXrLE
    bO-mOldL3-FR3FKLA>
X-ME-Received: <xmr:ZoozZ3O64il4ry51ILIJFiVEdsUKQbYqrGS6-j7fzfULrWE3NVig0WoamNwe2Yn01Es3nCJtImDkIEYrf1dChTDlITLO6jRzrsoPs99Z7EyYxjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdr
    ohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:ZoozZx4h9GkNKUq1zuJxOxZTlyUOujdAvt0YtWw-Adds111K8740_Q>
    <xmx:ZoozZx7Snjr7gBLMRJd4cXzWRBfWCQ8vOj_F129zgH9atwOcVCSDiw>
    <xmx:ZoozZxgH9d6VJ3wczTN609cJaSMLjLVGk7tIk2h0uoVGr8YfZ08kqg>
    <xmx:ZoozZ74mcd_MfeaHfhL5xYC0Bo55ySJcxUm9YPtJ-TFvx9mwVt9Pyg>
    <xmx:ZoozZ2HF6y1hhVXRjByrhcf0D4Z_bZyojbnmm7qpJCOV8pdC2nmV2u5C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb7426a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:48 +0100
Subject: [PATCH RFC v6 05/19] Makefile: use "generate-perl.sh" to massage
 Perl library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-5-648b30996827@pks.im>
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
index 55e363a83d6ca2561fe1429b072892f9facca9d8..cff71e5e84c69d87bb67b72f7bcfecd639ae7188 100644
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
index 2ae337c61b5fdf54e6ae277053c24696fe91083b..97504c3d7e4aa67041139c6bc9d5731874de19ef 100644
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
index 12e116b76e5f39c14c9992e9a75090917e72e957..cfbff20f55bb8adf9f0c59e30bebd6b28432bc22 100755
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
2.47.0.251.gb31fb630c0.dirty

