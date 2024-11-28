Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE81C07F4
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810359; cv=none; b=BePjU9z/u2VjljhhT3sKsAa3aOBejLcqKMlFq5T2fXGnHAJFJDckJ9dweeFJUX76ziiRb5qcYPZggYsJD3Df1V7tCctWKR52Y5/nRj/mNG+QqQbtUeleHYsrws1MG8QqK7BrlzM8BNRdwbujl+MORNT4kf/5xIaeEtlPezIZXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810359; c=relaxed/simple;
	bh=0C+RC8O3vMDFHqaBmOZG6DROaXCAxRDA2B52F8HXurI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=insqa0dvWmzSNgdwvSnzRRXykYJ6pGZr0thMglMpwOGzE6VMTVKi7a0ClneO3bmMRbLLBGhBjV5K9tj3xkgfmGOdDMPFFURQNJaAK49yzH1DwbKGSXytyHtbuCGgHEZCdft/P269alIY/q9ecKfSX1Y5lhfDpAgrcmcCgxLvX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s66vENIx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C768V7y9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s66vENIx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C768V7y9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0218D1140132;
	Thu, 28 Nov 2024 11:12:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 28 Nov 2024 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810354;
	 x=1732896754; bh=XYdtsrXhV4I0yWvHtknCFR+m0gknjoSsuQuVFDUKtXQ=; b=
	s66vENIxOC5fOVaCHBDZtqlL/bmeXRgMyCSmv5iM8AGHSeo2slLGOJbNAq7hzrwb
	Ry5et7N4xQ2oJhzdZigCSqa3wfa8RSIuz3ryXVwm0cjjaVR1jCFzy1nBwIfXK+0X
	eBEoaXqXR/7KbRUwR+zm1I3p2nMEvkLdGxliiuQ5GdpM4KrhBZ2o1LupUK9QuYGP
	3pXtK3aGDyqFA4HviGU3V4wivPIGFFiHebIMtUB+CVSYbGh8GebMwjYrDtHyFQTP
	a/EMsjr8ZXgfD7pCy8GCd9d8w66K1K/kLS+oMnBPTtmqQznF+4H6KpyE6uanX6s2
	9YW4hQtsQE7IsccXPtrPcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810354; x=
	1732896754; bh=XYdtsrXhV4I0yWvHtknCFR+m0gknjoSsuQuVFDUKtXQ=; b=C
	768V7y9n0y4GwaPqxQAGv4WnlsEO5g3Lj6MIWOnVfLCt8xMgy1fJ8cVR+HqLM5lh
	bLTGktakXz7yO2kPTFUoMe1HHrhH7FSaFHEzKnXr8XeqSHQ9vX7Vr1RAv7YBD5iJ
	ICst9lso4TH06wUEKEzgr8q1R+EEIzWYzW9Hb/49ibTAMNCAvPK5lRQmf4+26T1K
	cFlkggsLIMz5Xn2w9I4I2cJXjJMXEUveAaLgmZsMSiLR2wNvOxKNhhXMP9RAK4Yw
	6gtgrpxgU8N3/kQtpvQCxaByJuDsSq/ih6EsdEYM0kATzWn93eQDHvlLlQ+Wdl9E
	G6khN+4Ih0M2ExlxeXDeQ==
X-ME-Sender: <xms:cpZIZ-U17QsUBdYz31w_9vkFJ3VRiI1GsNB6N9Q2tBQXOFbjV6uinQ>
    <xme:cpZIZ6nMfb-Kyk_DJ_6O3q_Hckgk7zgBkP0BbEbjaiyo6CIUuTUhNVBZSGFcK80X3
    5jMZFK8kY-KWBjmBQ>
X-ME-Received: <xmr:cpZIZyZSnL9RdkujSp27yBRSQWNum7PENPMR6E2xxU8mgeIjD-dZam3WwQ_Y0tu7QwX4dvdpxQZ9hVemI8wVR13wVJtA3DTPzXCSEFKbVpvamw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehr
    rghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvhhiugesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesgh
    gvnhhtohhordhorhhg
X-ME-Proxy: <xmx:cpZIZ1WKSPtqyA0oRA6iuhxnt8nl7gTdaW1BxVszcGWC_7-2P5QIkA>
    <xmx:cpZIZ4kIy6Jgwm3JoZDfbdIvy6Ia0bY8SVCT2QOb2kHjWQegOIx4zg>
    <xmx:cpZIZ6dUUOfMThceJySjRCVjKbrIZYn7bwqsrl79HvnEHw0QXW4hKg>
    <xmx:cpZIZ6Gm0_eCAw-iqmQPU_jEmrJnrT1JdXIPJdKtMSxU8ykodmxqjA>
    <xmx:cpZIZyffUJbW4DAhaRuacPovFzMSIsQtJlV84cAg68dz4Iz4Ta6YB_Pg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3da37785 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:09 +0100
Subject: [PATCH v10 08/23] Makefile: extract script to massage Perl scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-8-79a3fb0cb3a6@pks.im>
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
2.47.0.366.g5daf58cba8.dirty

