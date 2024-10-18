Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2118028
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254250; cv=none; b=HL4pzDPMh5iHFzenCIVqjgIdj5cXhNXFywWkICdkDMIlUeEaKfKKEuznL/HexupAF43b35xO4+TztE/G5t3MedT98/DXFVo1VbVn9k2R979dzjOHDYkjhCkic/sNwYCs2HlUyVl/CFmGHQbGJk+MNvFsGHMNdISVwiuesvYFxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254250; c=relaxed/simple;
	bh=hJvqlkhJKMus2iXDH5XTqgIMg8pnLp66/vngg7V2tO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4K4h7Won5Ytc+QRadh7/HJo7UvenxWOiEJk7VLM5R6Hz92eGWphwTwGAL24pt/mMlEGSmQIoIhhjgQC8stBqerYWe8V967Xbb5+hYTfZI6wlOOmiI5X0VbkS6p9VXtm2lbqKtV6Ul0S4SjXE4XPgVAv6O7uMuYaWJ5nAE0CC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XfTgwYb6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTdoN10v; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XfTgwYb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTdoN10v"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ABF62540078;
	Fri, 18 Oct 2024 08:24:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 18 Oct 2024 08:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254245; x=1729340645; bh=Hs0henUb3i
	uKX4iuhSpI3W0rXMYOWK3yOqAGZzyExE4=; b=XfTgwYb64Ywnh3kuz/QOQe80/V
	hFOpfxtWuB9kMKa/WEYn/wn1o9/171719A097MNPe2PNodKvIBTOZQE2RFOxYgd2
	vUufxgNPs+a1H1SQHHPUnlliQ+/GfqBN5UnHt9+f3rdrBS4Ke7PRJdPmC+wc+2xi
	8ylqTEKQTSTND9hL8Lc+QG0Kkrt33xdph7cKe4NEvtEgFQ8HSIW1tS01A8lhv5ry
	Gag3zYJ/HYlYZqlYJkzHzogUJcVMrA74AxWqKCaqNHWx4cb2nxFeI/9ghB1a/dJl
	DF6LEMwgoTcY6RTopiHIXyXG757MBhIlhaPYnPVgU9yXIkqx75U0Hy/U8Z1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254245; x=1729340645; bh=Hs0henUb3iuKX4iuhSpI3W0rXMYO
	WK3yOqAGZzyExE4=; b=jTdoN10vUfliulWvn9lxQKqOO+nqLxXY2ZjdCIs5/+HI
	mcGW+YdGsfnYMxUjAu8eV53fH0Zng32PcKHIwSJYJmQvaYQvEjTgSOFieWI7gA7S
	u+z6boU0/UAzv7IVXXIy1TKf8WzzBLwTd7uTjp7tNRK1Mc1cQYBfDWTtTCpm0PVN
	CG0zBD5VctmRt88KHBixUHkr+XgI94D1ZjoqbK2bLi/h1qNaLx0huQPj8cc9nEsx
	ys7YJJq3QLqyHmMyTbd0xTdZanMOhennU3XK9HnOn2PNW7Sssw1gB9tchQfa9e7E
	hhsKyFzNbsgWl+WwmEvXrk5W9IcRyJwL+mbrYNI1eQ==
X-ME-Sender: <xms:ZVMSZ4Ccii5VTMk4IyOqx7gnhochFsPSKna3G2uqlHik4fF5aoWKtw>
    <xme:ZVMSZ6i-leebVaE5tk108cO9GuUAf3JKofVrPQ6sVV71X79XeZ3JzRTlVha5T3LjA
    oPvMqsV9uXHTnRggQ>
X-ME-Received: <xmr:ZVMSZ7l1TY6vfYRWzI7_aimjfUujuT4sy_B6lSAdq_aeOrr2QB_rL6L-jvxVp_TVxivpzM-Hj2Z6a4h7xqgB6-sGiI49kYuCANONTtJ9wpF6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZVMSZ-zBLmgWIGxKhaMMvdG_5dSw1qZBCW1SPfolbLiWEW_qn_GqvA>
    <xmx:ZVMSZ9Rd9ge4bN6nTAmjYcqggr5uyAH-FLh7rLRURM-e8ADcN7hbKA>
    <xmx:ZVMSZ5YHiZRDB7L2XBagSEVoLpz0DS9l9LQakOSQgtQF1WWn6SkWpA>
    <xmx:ZVMSZ2SQDuDxIwHUHNvmeqUgesjT-s6VGGcBwF8wRiIFwnbddwZrgQ>
    <xmx:ZVMSZ8Eh2HtyGK1k0gzmdYat4gWTsupr8pBqLqfGqCs3qSDaTgDfsoA4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2baaec32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:22:43 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:23:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 04/15] Makefile: extract script to massage Perl scripts
Message-ID: <4894179b94891439e3f125c262fb3ba42c2f864b.1729254070.git.ps@pks.im>
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

Extract the script to inject various build-time parameters into our Perl
scripts into a standalone script. This is done such that we can reuse it
in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 12 ++----------
 contrib/buildsystems/CMakeLists.txt | 20 +++++++++++++++-----
 generate-perl.sh                    | 26 ++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100755 generate-perl.sh

diff --git a/Makefile b/Makefile
index 394466b716d..ee1ef7ce8fb 100644
--- a/Makefile
+++ b/Makefile
@@ -2604,16 +2604,8 @@ endif
 
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
-$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN) \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	r GIT-PERL-HEADER' \
-	    -e '	G' \
-	    -e '}' \
-	    -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
+$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 608ad9714d4..7fb6a149f21 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -848,19 +848,29 @@ foreach(script ${git_shell_scripts})
 endforeach()
 
 #perl scripts
-parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
+parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
 string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
 string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
+file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
 
 foreach(script ${git_perl_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
-	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
-	string(REPLACE "@GIT_VERSION@" "${PROJECT_VERSION}" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	string(REPLACE ".perl" "" perl_gen_path "${script}")
+
+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
+		COMMAND ${CMAKE_SOURCE_DIR}/generate-perl.sh
+			${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS
+			${PROJECT_VERSION}
+			${CMAKE_BINARY_DIR}/PERL-HEADER
+			${CMAKE_SOURCE_DIR}/${script}
+			${CMAKE_BINARY_DIR}/${perl_gen_path}
+		DEPENDS ${CMAKE_SOURCE_DIR}/generate-perl.sh
+			${CMAKE_SOURCE_DIR}/${script})
+	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
 endforeach()
+add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 
 #python script
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
diff --git a/generate-perl.sh b/generate-perl.sh
new file mode 100755
index 00000000000..12e116b76e5
--- /dev/null
+++ b/generate-perl.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 5
+then
+	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
+	exit 1
+fi
+
+GIT_BUILD_OPTIONS="$1"
+GIT_VERSION="$2"
+PERL_HEADER="$3"
+INPUT="$4"
+OUTPUT="$5"
+
+. "$GIT_BUILD_OPTIONS"
+
+sed -e '1{' \
+    -e "	s|#!.*perl|#!$PERL_PATH|" \
+    -e "	r $PERL_HEADER" \
+    -e '	G' \
+    -e '}' \
+    -e "s/@GIT_VERSION@/$GIT_VERSION/g" \
+    "$INPUT" >"$OUTPUT"
+chmod a+x "$OUTPUT"
-- 
2.47.0.72.gef8ce8f3d4.dirty

