Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885320767B
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491534; cv=none; b=SKz/hhtgnVaISlB4U4+9QFSOKJaslApmQH1l4b8Fp+gswafiHYB5V3c219BpEFyqr08SbwFu2wRJ0QeNiZNgSIMYhuD83gUvBygFLH91tqiTj3QJ0oOo/3CTYbJDA7dv8oeZyG9uHrGvsq1e0LCQPgs3+fryU/tRnJZpgt3ytPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491534; c=relaxed/simple;
	bh=mzgdhpGIgDoJJ2CAvyw1NY+AcJ9mXhao6Zj/FMbM0Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOQRTnh7QcIX8iqNVEtYawrazAZmMjPRzicaKSFGW2aFpOHmSOGNH7eM6OJk7C0UY/6bCV7zE0/7z2V2kQS1LP/egGu0Ly7NGsa8AVi1pxsdJMmRuuwhzwYtkkEVAq3Xzu1cc6oBwjZ1/SAogxw0gs7cQ/DAPKMT9igjPAU8esM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iewShWPr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+90rVQc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iewShWPr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+90rVQc"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D92D2540178;
	Fri,  6 Dec 2024 08:25:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 08:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491528;
	 x=1733577928; bh=3q1YCNa0sleM7/wNQim08U7GGhNfTVhfJd07CVGAfP0=; b=
	iewShWPrLIeU1ubxt4k596yMpm54iSyFUCv3l6Lltw5gwlNT0DRo1e5iN19WfYTJ
	n+WopmElnKR74KQpqTYopPnkuqS7whnDWbW5mk0g/NfHvut6bDFf1DHXA5WofwIV
	HGNa4q+sWh/739qMhnzrtb9JWwt5fUx6jwRBSzvehV2/EqS7yESD8ROCe0Q7JmTn
	X2MUpO1ZrAhp3FlOlxXUApxXgIBvbP30MkB6Im77ou5ZnVQfg7vClImDNS4ZOhI4
	3VQtzUBmb7SNweEFn63Un3M7Gx0VIExHFvN2pNHlvoKaNeBW7hvtpymRS4Vvm66X
	aegjSPzCzpkbpkqN4ZyWrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491528; x=
	1733577928; bh=3q1YCNa0sleM7/wNQim08U7GGhNfTVhfJd07CVGAfP0=; b=B
	+90rVQc8dnzKcEqaOwh9joLAwqvpyL1XiPGyU3qIx1NNtXdYG1LkejPU6lyWz5ze
	ejm8/lQ/5Qzwh62Be/4BqMcMMalW0h3pJ99m1qZdY+gcbXLROgMGM++AH/X0eQOY
	KOKQo0ZBL593osR6DaVUYR2n3nCn6Pl7Oya99+nEI0Fxyy2YKBytq+DfYjb5Ohi8
	l4XxgzLgFoLTf9LdML6zqk3fU9AjzHYB/gAAnhfQXgx3vkfyqWq6Qj4kM638M9uW
	OID30LTRiwOG+3fWiJrE2YrSM5+i6y4N39cPjCv+dwaRwEJKbvONXWcCx/Ly3by2
	xPLfuD+0PTlT07i832Z9g==
X-ME-Sender: <xms:R_tSZ_CkhbHQC2d5paxRHbQ5pzPpiVMlZasmqter6y9X9jOnsglMmg>
    <xme:R_tSZ1j2TB1segfUpRCkRgna1oIM84lbSTp9OQRK62Z_mfYubVg1v3sVjfTJ3rc2g
    d6iBrbQ82XYDJKQdw>
X-ME-Received: <xmr:R_tSZ6lLmP-iUPhJmUJ5SWlE0LtPS2O8ZIHoRv1oNhaPE-r8d6z-Q50d0Ju0rdbBkH_Xv9UEB9C1mlf3mhL6gpoqgkOzDgpeGdwelrHLA5RcuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegvshgthhifrghr
    thiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:R_tSZxx5gTp-l5ylfa36WUoy4tWox66HYEPXKPeXMmhD_b8aYcFNpQ>
    <xmx:R_tSZ0R9A2ZU20-q9mQ0s1l3YpdlTKBsvKTaRtOe5iPK82fHcElXSg>
    <xmx:R_tSZ0YKnoVs0LhNHq2qy729QFdLxFoiOdfH-PqHe2DlBOP0FU71vA>
    <xmx:R_tSZ1TVqoDKxCVjYiJxy5Gd_QTfYsKU3adn_8hLgV4F4YWSwqH5Rg>
    <xmx:SPtSZ4Y6g0-Tig2GmOLWg9kjNcyE6QZ6EG2zPQB62E_UiJC8V_xTl8QG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64044bc2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:23:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:43 +0100
Subject: [PATCH v11 08/26] Makefile: extract script to massage Perl scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-8-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
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
index c0815b8fff297020a25deb73b2dc15d3bea2852e..714f1284010d4bb0c0daff0db3052a4cdf9a08f1 100644
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

