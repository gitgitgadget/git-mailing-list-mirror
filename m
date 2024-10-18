Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8A15E8B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254252; cv=none; b=O+Hav70pUgSk4CRIIXW8u7XuEGT+ESDX6N2W7d8xBPMIdZNvv3h+kGv+9OhqF2+eEmSgzmhB1tygFKwaA05hkM2P0g9AZAMi1JofApAztjzLoyt8psFc7GHnSHMkgBKJzJhb7d+6C/faxykf53yzStnpDu+/peb4pdFW+fxpFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254252; c=relaxed/simple;
	bh=npcUUff1Aue9H4baG8ofarwLyq9anAoodlM71P0Ez3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLEX6nmsCjrWvQBTsFLnu/GjpIg8R99w+bWJf8RCORliifn3slwLqHUZ/YVnrN/nSAN3vXzAPyMpbJvIGXTMDpLQdG/4zRzXixUYxKVEhkY2dyTdPndf6QCIpTWmYx4kp1jqfbF5KF9a/8Q6hmkU3ddLaK0vPOTas40c35x4a88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HqQoWmb7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpzpZ5e9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HqQoWmb7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpzpZ5e9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EB6111400CD;
	Fri, 18 Oct 2024 08:24:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 08:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254248; x=1729340648; bh=8EvgIjaYAR
	l+9GD4efqDkU4hKwU6ZJnZgp5GOlWrzWM=; b=HqQoWmb71SVqp2je6bJyZE7CJ6
	pJwTXOwbGEb2eE5pRTCBpBxg584ingQ9QhqElsyu5i88+d/wS+XT5eWt00Y4Ye2a
	gaWMYZgyvm98WFCzEfhC0UV0vRxUMnaKxu5ZlaN6K3cY3OdQNQuVZaMFK9UPI/X4
	dkw9X5EugQ6AZjGWbtMgtUTSULNwxCY0b1M3WeehFP6wilRvQW3xN9S4Xh+P2Ppm
	SogNmspjQC/ui4amUNy281vjKTuT2Q+DfJWkW4vRuAJ4apgiIHEHTHibKd+s+CHw
	/jidHHp1Ni4Wp01A2Dw2zhfGFGQ2OP+jyirpjk9BNJFxGMJVZ9SKRjs0WdCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254248; x=1729340648; bh=8EvgIjaYARl+9GD4efqDkU4hKwU6
	ZJnZgp5GOlWrzWM=; b=HpzpZ5e9FlczXR9/zb+Dui7bBFmgB2woR9Y/npR5nRwq
	vAaPUMN/oFTHtR3b88N7Abdn8FUS5wd0kO4YWaCMS6VKgaDT6fSyw6J6OLKRO2xd
	EGjD3n3xb/zZ++vYwM+9jxK+lOrMMuf0EFqKu6L0Xmda4lQOsIKXs63b1FnxEOur
	GX27l0tVa8wVCfSUN/wyxGpG4ynMSPys32ccGKcA30c3RiifCLRZiOrOrmm8HVdB
	AFgiQgC7KBt0/EllvlXTmIm6HI28YIF6p8g9SpAR+Ydsmb+omLqL9tUy1xI4CjHO
	ClaLleOOLvZxq5Woi0jOKD6DKXbl6Ljj/N8xt2Q4lA==
X-ME-Sender: <xms:aFMSZwbAGpOO8TIfi17aYKTgx4RHf5Tbh6PqMoO5yXZeSuyWGOeTpQ>
    <xme:aFMSZ7ZCZyy-iljWYsu9uueI3EvI6I7hJucof8JzRWAoSZcrODt3Ps2Z1etE0rBQR
    TWgK0fKkbQrUIkxHg>
X-ME-Received: <xmr:aFMSZ69DD_miQAVs532XRQhJJ0192sG5Qr5X4IoliClquq4Cbd5kxmkI9BRuitFfvrGwzkTiOTvGxzeiJ1_yH4kg4qPhO1edCk-06xE1NzfG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhho
    nhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aFMSZ6p3hi6EtClDAHpsiRTOKqsWDcDY47W6vgAP6gvxSsDS8NMINQ>
    <xmx:aFMSZ7pzv5dqB_EG_U1TbyI4wBVqAs7uYUwc97B6qIO5QxAqdkv5NA>
    <xmx:aFMSZ4T-2xpK2BdVPAk6bfMqmbo2xDSaK8RtnwjX0GqnVlqb_D2mVQ>
    <xmx:aFMSZ7qHo6IKRNK3yw4Po2NEZg3W9HkNAIZSULrytWzP3r5z4X9L0w>
    <xmx:aFMSZ8cycH3hARYG00UXtvu273q32vTedCaDMxxYxN29M4ba7Rl1U3gP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16aeaf35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:22:46 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 05/15] Makefile: use "generate-perl.sh" to massage
 Perl library
Message-ID: <b40bc302291253a27d3f619999b1936fce3b4f1d.1729254070.git.ps@pks.im>
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
 contrib/buildsystems/CMakeLists.txt | 20 ++++++--------------
 generate-perl.sh                    | 14 ++++++++++++--
 4 files changed, 24 insertions(+), 22 deletions(-)

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
index ee1ef7ce8fb..770ad830292 100644
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
index 7fb6a149f21..ddf39dc90e7 100644
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
@@ -856,7 +859,7 @@ string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
 string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
 file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
 
-foreach(script ${git_perl_scripts})
+foreach(script ${git_perl_scripts} ${perl_modules})
 	string(REPLACE ".perl" "" perl_gen_path "${script}")
 
 	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
@@ -877,19 +880,6 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
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
@@ -1131,6 +1121,8 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_
 string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" git_build_options "${git_build_options}")
 string(REPLACE "@TEST_SHELL_PATH@" "${TEST_SHELL_PATH}" git_build_options "${git_build_options}")
 string(REPLACE "@PERL_PATH@" "${PERL_PATH}" git_build_options "${git_build_options}")
+string(REPLACE "@PERL_LOCALEDIR@" "${LOCALEDIR}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@DIFF@" "${DIFF}" git_build_options "${git_build_options}")
 string(REPLACE "@PYTHON_PATH@" "${PYTHON_PATH}" git_build_options "${git_build_options}")
 string(REPLACE "@TAR@" "${TAR}" git_build_options "${git_build_options}")
diff --git a/generate-perl.sh b/generate-perl.sh
index 12e116b76e5..cb1629857c6 100755
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
+case "$(basename "$INPUT")" in
+*.perl)
+	chmod a+x "$OUTPUT";;
+*)
+	;;
+esac
-- 
2.47.0.72.gef8ce8f3d4.dirty

