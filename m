Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA462123FE
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431018; cv=none; b=YkggMAuyVesy/JNxREqCLjVr1ixo9fPzrIUi+NHb+sSR4Lp5l8LwW8r3/EWG+hQXfre2UwX1XwDOklApdQQJKlnczYjkWFPJYsn0IBe+XcHB+kb9eJCcwiGYQIbVlsBk0/vVVzEItBbG69kknS316EkJwnTcxOSpDogx5LEBja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431018; c=relaxed/simple;
	bh=XUCBYKpI8hy500fiQGdhUjQ4tWsG5viX1xUzGSQM5HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJ4cGlc5PtCLdoBqt8VdYHGyyoPvn+pZ0dM+7BHGy/8R5PDfiIamJDLs6GgDcJP803/KKKHE8tnbudcnPzbLfpJB4xzxdKm6NEDyfR+6BoyceaZnqfxvg0x6V+OW+kDnZsTlAXqcjZDcA98xbJNObDJG4KWBTq+abeVGXNndURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ydZzP9JC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+9UNp6c; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ydZzP9JC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+9UNp6c"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 05774114014A;
	Tue, 12 Nov 2024 12:03:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 12:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431013;
	 x=1731517413; bh=ChABssQd+SolAKeAA39lj0l1/QEaqSf4qtM5ZfURLE0=; b=
	ydZzP9JCIiq4V6PAcdyCqRXf02WXHaZSf1j4xgc1BsasIG30qUPY7W732bx9p17U
	HsaBhY/aMKPuAGInQsln/ngbCLzqC4wYVlkMK7qdbbX/hkXEtQy9K0H7cw8huZZ0
	PZgqzj+XhdqHfsunEZJvQfX9Mtb0vwPio1/No+Yl/AVLQpV+yD2grJicuxgx8Zg8
	buPUlvM24FOyk9kPqdbXg8uMI7hbq/TMVMIDHWF+tKUMQVcN7YtecCVulufcZ9h0
	7jSIm588ZEfU09TG/GTt6n5ANfTuk9Yi1nGRGugL8OtUhh3bv2dEhdYq2JhDX8DM
	3RCOv+g+rIpv5HnmRBJNOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431013; x=
	1731517413; bh=ChABssQd+SolAKeAA39lj0l1/QEaqSf4qtM5ZfURLE0=; b=U
	+9UNp6cuEcHZqpAqkQMu5BF7fkuLVYMPmF4XW+1/CUsoGZJObDfggoCxkTGwkT6U
	BXu9wr7QpLHvq49O7iWfWuF2n769Jlm1ScT08Qw32YH41OAmda5MtYZyCM4KYRVg
	wdS7jQGxeOrwJR34wvIHj7Fseuyjv83M+rgx+gwBHIN2BejEDOvOlxKwwR2Enpl6
	LhS6kWUvUH4m+urYt5qB8tHEgU9tGF2v2eR5ros24JvwfZql4t0TU8Hplr3690ar
	HD16uLdSHzm0s+PsrUWbXTzhw+Pmgl2N1vqy0j+c5xWhCi18NZgXi1w+y3CVvmDQ
	TdqtwCHvg8NiWOJdhhl0Q==
X-ME-Sender: <xms:ZIozZ-Enx9L4y5E06FFOWaFUIUXx9JJ5JhlekbdsFqSB1J8qZYFxRA>
    <xme:ZIozZ_U8AtZToY1Zu9yI01rKS8xSY1Pyac4rAW-fonTPfPMzgtLyNBckvhR2zjHz6
    fnUHIoPnIrW4fOIjg>
X-ME-Received: <xmr:ZIozZ4Jq9MDRdoZXTn8JcaNzjDuJm1dc6zspdZ8Qkwmi2kkd4qvthuY018RXcxnIh2jV9s4-wggr030PihM4mm9iPSkw0FyAp9xnKajpokAQS0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegurghvvhhi
    ugesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomh
X-ME-Proxy: <xmx:ZIozZ4GRffBHUiks2c3AFylss80c2OUEJXDVx95rXaN_FORlgN45yA>
    <xmx:ZIozZ0WeYHPQR-nhb02erFb1MZLimksVgX_LEQMAHIvoSEtP1QazQQ>
    <xmx:ZIozZ7P91yxF8FAOzCGDCuq1CgBTCJhYHJX_dZk5a_CsGjD6NuUHLg>
    <xmx:ZIozZ71oh7PBtEeTIUJJJG7VDl5C2wkO0ZF5-6W9NfPnogjWlJQyGg>
    <xmx:ZYozZ4QUjnaahy6T-kb6gZgt6iNe5WEWY7laREzagyVdSjskPBF3809w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 926d6852 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:47 +0100
Subject: [PATCH RFC v6 04/19] Makefile: extract script to massage Perl
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-4-648b30996827@pks.im>
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

Extract the script to inject various build-time parameters into our Perl
scripts into a standalone script. This is done such that we can reuse it
in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 12 ++----------
 contrib/buildsystems/CMakeLists.txt | 21 ++++++++++++++++-----
 generate-perl.sh                    | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 2a08473824ede4699e370de7f8b8af183449536a..55e363a83d6ca2561fe1429b072892f9facca9d8 100644
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
index 608ad9714d460b362e07d7169a9c386ba819d40a..2ae337c61b5fdf54e6ae277053c24696fe91083b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -848,19 +848,30 @@ foreach(script ${git_shell_scripts})
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
+	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
+		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+			"${PROJECT_VERSION}"
+			"${CMAKE_BINARY_DIR}/PERL-HEADER"
+			"${CMAKE_SOURCE_DIR}/${script}"
+			"${CMAKE_BINARY_DIR}/${perl_gen_path}"
+		DEPENDS "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+			"${CMAKE_SOURCE_DIR}/${script}"
+		VERBATIM)
+	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
 endforeach()
+add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 
 #python script
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
diff --git a/generate-perl.sh b/generate-perl.sh
new file mode 100755
index 0000000000000000000000000000000000000000..12e116b76e5f39c14c9992e9a75090917e72e957
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
2.47.0.251.gb31fb630c0.dirty

