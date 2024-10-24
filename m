Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286C1D5AC0
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773609; cv=none; b=nKttSniq82wzTeg82C2XNzGqZNIzW5+tbWd0sIaQ0WgYLJsTVmX6sdTm/dAEfaW0huD33TGj4aS42PfyFlJ8eEzgqRkoxYy8fdG5ekLAD+EIlZ2xPBT/eICSPp3Jfn/XmPvIx+Fm+JaFurrXMAAXgu+ssEY2S570HV0e7FMBF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773609; c=relaxed/simple;
	bh=uCvd9f0GeuYayjyp0TOskk/OPq2SQ3xnk9a1mXRwsv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tlkx1+4QM7gwr53gzr5RYrd8o7ir3ziVNX0qdafBuFc51qFRhxwV5dm+AYdeJGU5CwTb1mjtNd/pyLJUgmgiH06Ip3GjdmsZbEcWVnJntR0uenHL8hFHMnHLxrPTctlrE1mS2pJGQiXILci50/cDGA+tTy4RwRyOYq8R9yaFhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2aQTV2MR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DJfkI3Nv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2aQTV2MR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJfkI3Nv"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EAD52540148;
	Thu, 24 Oct 2024 08:40:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 24 Oct 2024 08:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773603; x=1729860003; bh=bdW4qRqzga
	hdsTggIQ4zlOF1Xog/R5NS6mDp9KNgHJo=; b=2aQTV2MRB53mg/Zje1wnNC4hi5
	0/X0uL+aUjheraS3pRWcv9MF+Y3BSJzH1Z/pEXAEk3A9qKARsgJeFdee+VTqz6V3
	OJOqo7Vkw6SJrOcN8gd6WaKP2svSV1qydeavr0QIkDD14KIYeC/yUkePx3Pv+biQ
	qj8Vzdpc3RmEMiX046pY5/m1MbbspqUJLInAvubjST2YlsLLTXx0/cz2plfvIpTK
	Xv3CsuAM3E+MD/dqxZz39vntGbX+gnrGxwdw7reVrud6zbujZHDdXgOkAWMFbepQ
	nCD2zZEXdlpWjvuKcG7Y+wAO+/6Sg6jfeCOn6a8cSG2xOQdqQoe1fK7Gtelw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773603; x=1729860003; bh=bdW4qRqzgahdsTggIQ4zlOF1Xog/
	R5NS6mDp9KNgHJo=; b=DJfkI3NvlflT2uwpgYg1jlWaizMtXvXNqzosiSpuoG7Y
	wNWY/09ioCvxGbuSCtCxZajbA2Y6Qz7zQlsZ/LboJeyTIrOsp3M8d6qpZZ1g3scQ
	OgJf5aiwx+k1L8vUdRlF3mxwDDPkw5fA/k13gXB83JLsd/TI83FfDkjs/g+7nw48
	ASwiI99THpcKGXmZdnc4m2Sa0PvXr6FkRnfpNNam7r9gu941rggVwsTVL6RRXIAV
	l3jWDCCNoLe6+Evmgs3/9d5uWit371j6TTUY6KtjSuEiKFMqbnEw1T99Kvo6/jXG
	OoYfBbiK9+PlUFkucw/FT6DZM4TKlFEgjKb4djhoRg==
X-ME-Sender: <xms:I0AaZ_zpZ6wGVJu4BtY-cFsd0wXM9yzgUvanOS4JCP4860PVuuuqyw>
    <xme:I0AaZ3QkvUiTcXIbrb0U6yWjhENiY3AYrTGFgUpg_wCDmkQypxsela4DjrJx-M0o4
    EPKAp7DdNyTR17DFw>
X-ME-Received: <xmr:I0AaZ5UVmRE6XPErS4hfGAbIS80__vwKEoYCZ6fWDc5i1a_drbe1gd6IhfZxHgNlA4an0aN8TGwepG_ct6RLR0k_V3gXo_e2eyMQqvrqrypYNbHH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I0AaZ5h60WcHzX58qhELJ0HL7ihqFMaWar0bLFdnkPJWZ-_8oGHrmQ>
    <xmx:I0AaZxCHuXgrV8JkJtG_-jsrVlg9ZopJ5zL1rRwSd74zwbVuYLOjyQ>
    <xmx:I0AaZyJ-_fmDP6Pn8Lr3kFvr1oVN9Fti-SDgiMRHISYBCpmdJe2i_Q>
    <xmx:I0AaZwDSNmbsuxpt099OCBLezFRQhmYHWwS9DUAE4uw0h9dt1T3JyA>
    <xmx:I0AaZ7CzSOnjaz0heUY5DDLOOEpv95-gBiYyOu5mYwwDvTlnnuRJxqvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2b11a57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:04 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:39:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 05/19] Makefile: use "generate-perl.sh" to massage
 Perl library
Message-ID: <eddafe1cf8935fd25d107645168ace3f65e1064c.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

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
2.47.0.118.gfd3785337b.dirty

