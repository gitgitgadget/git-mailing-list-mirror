Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E5211C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017069; cv=none; b=namcOAt/EediUhO4fn4T/bDmhfRJ5XW7LSJeLfffKUH2WRww3xCoWAHqR5rekmC+OpxodYkhezDF8NKlEOxMk78aTYXbOgQpzhO6TpeGuHs8ZAVAvk5BJaQNB+kCNA7UP50wiWhiNuJ2hnNsZPvY7Z6qegIVdt6gCh+ahwyBtBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017069; c=relaxed/simple;
	bh=UZiObA+Za5oo+fCQYJau7fqI67b8SMKZikIbopP9mgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecowN6ApiT1TLjKd42z1nfPxk8SCaj0s+7VO8wI0q0iaUiNIep4ZEjzwnr4N8tjD2bQ+NiCv9ggpDxnBqhiPLGP8H4G+eKmW0vShfSNa++ELYmmKhmhMgDrQxg0OzK8a5FA3v432jsrzKjKF8no5M7Px7KVMIMqZUwmfNQux1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FDkoPEYe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDFLwuXD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FDkoPEYe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDFLwuXD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B61331140173;
	Tue, 19 Nov 2024 06:51:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 19 Nov 2024 06:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017064;
	 x=1732103464; bh=/RPqQjqqa5uilES1mXbNiSILii9jbFQGP6DKatxWO5s=; b=
	FDkoPEYeXGXlHDHIxubK7hpD78wOuLS8BZf2J28ovCPsZO/xK8bcQ3TO8eMGu3QK
	SUfexjz7G2CW7aco15tenVuphVpVD2ioFPQ/t7+T+1NLHAlATLbD2c8pAfnDK0IH
	Oum/Eg5+O24Rq49qRNBCWkRpvY5mEpWy3lg8vInE3M4NsPR3cJub5GvxkTR/7liv
	wGY5XTFU11f7TwT83J/+cg7cAM0P9QgkhC5EBR5Ndc73BBwsqE8M0dX5lEdL2fhu
	M++USJPUAsG2jKUfX0bfhQKAWzRbqoxvXklRaJWEA/RtOoGVczARUQEjm7+fAZwH
	GJeN8XO2B85CBhR+gVB+8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017064; x=
	1732103464; bh=/RPqQjqqa5uilES1mXbNiSILii9jbFQGP6DKatxWO5s=; b=L
	DFLwuXDlhgvOPVoiA64ebqyn2e83O+Rsy/TiULYmrb9bWcfvKuBB3OJZkx4Z8QLB
	7xkC+ADvo77+xSxmqAVfyWmHh/gPH7k07Z5i5oNon2RKExgwzqWSdC7QLREwCQPQ
	aQBZC3Z5RmmqTWYnKQVN2Ep89sAfAkbO/hAn1U+24/nkJj50SZMzrobJUV84x5ss
	2zGbNeyuNbg4ndklP8kO7hoYxGham7o0F2GV5cZ6FBsw8Ajf8913PFNUjDgmOe/T
	ovUcCCqCWlViRJo+tjTAr2hFDpRmDaeB3JuifMzCoy2/qbEWnHOPxRqpnoidMhpM
	gQkBEMsbXihoUUBw00HKg==
X-ME-Sender: <xms:qHs8ZzyABj6H6AaoE1PSamDj31aOCm5jr-Hat2nWmhazOn38Oi3NKg>
    <xme:qHs8Z7SdQMfVuVzSH94hCDhSWlxqB3_F16xs1pti9_xq6Fx3s7nx-KqzQkcWRFiIQ
    XhtF2Tp2xxTXDXdhw>
X-ME-Received: <xmr:qHs8Z9U1g1Uh8GHIfcJCbZY7aUdjsYfDCeNicXcXd9GbgLlPBGtrP3Hv0V4x3Y4TlfDffjaUmod5OKrRaizMSXWOuJwfYfjdwY7MmHhz1u-BL-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:qHs8Z9i1euYjOkPh03wh9HeRlZ3kcoGZDP8rgSIuH5ejybBJjvijzg>
    <xmx:qHs8Z1BBA5EDvGykv1RW37iVJGKHJZpI82hmNPSfMkqP-r9HqrG9oA>
    <xmx:qHs8Z2JLt8GiNJEnuBe3bFHkJtV2dS69aOEQswfZIl1iBLeWpYgu8Q>
    <xmx:qHs8Z0C2uhUZrrx-GD94QSs-KI4v3IOowejk8xRNyI8-kSQAuVd_BQ>
    <xmx:qHs8Z57H_ABWXd19n9vm1IRNsfGpurMBR-4vd6DFg9yXdtoBbFT_v-3t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dff31c1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:45 +0100
Subject: [PATCH v8 08/23] Makefile: extract script to massage Perl scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-8-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Extract the script to inject various build-time parameters into our Perl
scripts into a standalone script. This is done such that we can reuse it
in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 12 ++----------
 contrib/buildsystems/CMakeLists.txt | 32 +++++++++++++++++++++++++++-----
 generate-perl.sh                    | 27 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 94b1ccc7b714743a149df5200a5a8d60b605c1ab..d3d7e06e930ab031561d0605c3f4a1d05c8e71a3 100644
--- a/Makefile
+++ b/Makefile
@@ -2606,16 +2606,8 @@ endif
 
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
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index f8892c49c6d317040b3b6447b88133b2bfff3fcf..e2e7d3da2028cd36a9761f78607539080361b3ec 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -852,19 +852,41 @@ foreach(script ${git_shell_scripts})
 endforeach()
 
 #perl scripts
-parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
+parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
 string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
 string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
+file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
+
+add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
+	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+		"${CMAKE_SOURCE_DIR}"
+		"${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE.in"
+		"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
+	DEPENDS ${SH_EXE} "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+		"${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE.in"
+	VERBATIM)
 
 foreach(script ${git_perl_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
-	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
-	string(REPLACE "@GIT_VERSION@" "${PROJECT_VERSION}" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	string(REPLACE ".perl" "" perl_gen_path "${script}")
+
+	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
+		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+			"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
+			"${CMAKE_BINARY_DIR}/PERL-HEADER"
+			"${CMAKE_SOURCE_DIR}/${script}"
+			"${CMAKE_BINARY_DIR}/${perl_gen_path}"
+		DEPENDS "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+			"${CMAKE_SOURCE_DIR}/${script}"
+			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+			"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
+		VERBATIM)
+	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
 endforeach()
+add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 
 #python script
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
diff --git a/generate-perl.sh b/generate-perl.sh
new file mode 100755
index 0000000000000000000000000000000000000000..f168cce734dbbe80b58b4b761b13e8a177f70642
--- /dev/null
+++ b/generate-perl.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 5
+then
+	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION_FILE> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
+	exit 1
+fi
+
+GIT_BUILD_OPTIONS="$1"
+GIT_VERSION_FILE="$2"
+PERL_HEADER="$3"
+INPUT="$4"
+OUTPUT="$5"
+
+. "$GIT_BUILD_OPTIONS"
+. "$GIT_VERSION_FILE"
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
2.47.0.274.g962d0b743d.dirty

