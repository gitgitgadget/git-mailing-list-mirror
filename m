Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E429194AEE
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528645; cv=none; b=Y+7f391efsSBV4vTKwIFBU/2JLUKQJfR0mBud1qJDVJDW7lWDSsb0YsV9rM2b1JuEanaKJjgEfJ9WDejAyL2b1jKstIfHIlrVyXquuDQtsall2iKAVQ8Z2pG426It9AMyWmwXNWP12uHDIdGGd1up0wTyJfE6p2htsGVb9rxbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528645; c=relaxed/simple;
	bh=oey6OM0n3g1L0jSfGt7wFXaKE9gR4FImEoyH9ENdsPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spTrft9C4XsCMZ00/VKNBfNHuhKJ1jVzuw7dPLiDze3LrGJcy8ieOmSdtD0c34lpLRR6n79DhfUdueH61TBotPMevDbwoHEkmUd/PmSSjrs3yqf53dIEZEBroA0ZSlt6eBb0cSsiyHt9ijgOVWNZZsY5pfUzrr5VhLrU7I2pubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TzUh4YDa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rYMgg/jI; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TzUh4YDa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rYMgg/jI"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2089B2540130;
	Mon, 25 Nov 2024 04:57:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 04:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528639;
	 x=1732615039; bh=GQ6hh1rht+69I9K2QWFDPEBdQ36K5PAWtTMxKXIlYCg=; b=
	TzUh4YDaal7m2Teq8NV0zDkjbp4CmoJ8VRLYCFYqgO06/rU0BQSRoEE1zDOEaVXK
	sxrmIV63puIBC13NGNjR88IEKO+py17rx9+aIkcLrMl19RGfKjTUTGQE+l9ClzWL
	4OpoEnRAYaoXnLH15IFHr9TeP/q8pNvBUpUxOtUP87LXTb40pOICTpl0221FFZuE
	jiGlOPtkPz2K+2BDYaKzOxH9oQDRTj4YuFfi9+Nj7OkdVCClj2fQ9Q+UzTtCaSsE
	z4UqOQL69K7McpPHfEe21AMhZJMAaJuq7MtbY0/Jy8rsAvkpwL6GrEy1rUmwqP1z
	LspnsmWzJh/tW1u0P9TSKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528639; x=
	1732615039; bh=GQ6hh1rht+69I9K2QWFDPEBdQ36K5PAWtTMxKXIlYCg=; b=r
	YMgg/jICL+HNLG786x88cet12q/eW/0ZY9hEtRmn76ee+U3EQRDb5RNPOVO78h5h
	MZBy14N+/UXgHD3PwJLFeqiut0lx1xZz367wg5A5RyjBlyhdQrCOQ4PuoOfQcr13
	HAyYSzIWBFojHjE3ye69rkMiTyfZeWdDzUWwsRUwa/nMbIF2Mm2PkG6O2qhSAMlD
	pMMKWYih3zzL/Q0hPZhv+7pdRw6Fc3I1t33NEzKH0EC8SZL4M5nQEYjcdMIv49Gl
	EjxQ/FuoJQSSkO4QiA+LJe/4yE4/uTP+Hd33f7AaRbw/ANozaf132x2ezm7n4+m0
	oIQvjOgYR37EUfXlo2yEw==
X-ME-Sender: <xms:_0lEZ9dOrOHECcn5y04RtM-ydm1wMYycysiZeGIuNuZNkWHJ-UL5Ag>
    <xme:_0lEZ7PXXE00ZgMeqdark2A06w3YMw3JdzAcZZKqrrolQ3mDLnSGxIYj1OGkWUvAT
    bHW636x8dziYaRSDQ>
X-ME-Received: <xmr:_0lEZ2gBt2QHrkeg4JOmYA1yDrpioAKeOk7CHG8lsoyvqU2q_rHgE4bEC7SKsQ8tdz4fszSir9GKA_Ch19gAKawh4PKzaagau_pd4aqL94Q0JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    gurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmih
    hlhidrohhrgh
X-ME-Proxy: <xmx:_0lEZ2918g3kdFygFkwTOsFCl_Ug7JcEF7-577aGqcMA9gODtvXeBw>
    <xmx:_0lEZ5t-VYaCOc0W-AZ9XGtb-tOJ-gpFIE2wYYycIapDV84X2twYfw>
    <xmx:_0lEZ1HG8KP8mYt1BDJ58vtoGWVxuW3Pm0b8aW550EFRiu1btaweng>
    <xmx:_0lEZwPI-qLE-tOPXH6vAMJ7E6r8tattNNlUxywSFaxu0bKvJORjJg>
    <xmx:_0lEZ1EP-fzYpAMnoS9euTyFBCyRmEv2iGUINhI6d3iX5Sl_qJJOxM64>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ff85090 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:56 +0100
Subject: [PATCH v9 08/23] Makefile: extract script to massage Perl scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-8-1c6cf242a5f1@pks.im>
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
index 0e289d1dbcbfa48e4566fb3e6d4eedd87ae2d141..e33c5b966c7c6cc9ea5d8a072458f11221a21513 100644
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
index ecaae8965cd43d4a5a36201b8760296b52147dc2..5cb9a209366e80ef141c6349fea9ddedb2f83d1a 100644
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
index 0000000000000000000000000000000000000000..95072522da4aaabc74164737b72568ccfe4962fc
--- /dev/null
+++ b/generate-perl.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 5
+then
+	echo >&2 "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION_FILE> <PERL_HEADER> <INPUT> <OUTPUT>"
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

