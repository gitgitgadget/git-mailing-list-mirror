Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6220CCEC
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491533; cv=none; b=WlooR2lLWDOLoFIsgTeOlM3CuHAWGb2ES8aRua08fwn0aLBkM+gkNcZwu926COCERPp+fsDGsUtN+zDC9K0S0EMDXKkPzCkqxfrtzJpRAPDOCD+CyZC0Rvtf2iuQ0hJRGMuu2IDD+2VbdFeJDSR7J+iL8JXpABMG2ssA2TuZk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491533; c=relaxed/simple;
	bh=54kJFDittsT1RFTMsqkiMsZOb3Sfq5i79DwCURL9JUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jifxLqef8jCuImR1giShPToGYu8NWo3kqCet/A2l7LAPQ/mVPtLesaXhrBfYbc5ny2tnbkwjoYFzQ4ipAGpZ2IpFESuehLM30QQMONgqeZqimFbO6eHMK+jKV8kqWvbOMFx54LXgge7+oM9M2K/pSO0UtI+I9GC8tnRKId8XrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nm7xj6bQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+i4aHxx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nm7xj6bQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+i4aHxx"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 06E3911401B1;
	Fri,  6 Dec 2024 08:25:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 08:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491530;
	 x=1733577930; bh=2KzsPe+THYHGM8G68g2X77LPzhdr88YJQTacUKd7/AU=; b=
	nm7xj6bQ/EJeC33BrDO0NDXqnnqo9AOo558IHycCi9WVGw+AFMYNrkQ/1h7uV48P
	Q3iVpVljhfATsz5ziJs+LDff1mQCSggFUnCHmyXZduHYfzBMUbH4VGn+RmuKnU03
	h5Z7H1q8Xld6phBWpU2VOZE/tJZiPZkac1BedP7q4HgddV3W5hp7AY1YYKxZomjl
	GsfW2uKyubX3x4PcJD6DQVJDw9Ji9xN3x5WD+4U9USSWixj8zTftOBw95iU0y6XR
	tUykBHVrWO3KzT4N7nJvGv258slbcrPiynmW3fIT4N1UGujcvd8UcfGofkAfJqx1
	OokXmY94xv7y+OTLfUu4Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491530; x=
	1733577930; bh=2KzsPe+THYHGM8G68g2X77LPzhdr88YJQTacUKd7/AU=; b=v
	+i4aHxx6vICN50IwktJTb8UNbV3s7Mrv5a2ZaVg/j1xw7oU4QB8rW1Mv0zDZdiN9
	ocHAIpi+LNl8JGexxsoK2rdLxjAxJ/n0slRVY4+8XWW9LS5ouEIMgrWKjAhtEPS8
	q4eOHPrxWx4khb6wmDKWaA1KX5vJDHtOkGhK2on/w5sfjetbMcYBNmCs1tGYLfeK
	U0uWjLwVwmwb9CDBJdhvX3oYZx/zJziug7d1dL0tRI7wb3YIppe9rnVa+gZsuvN+
	M1yWZ20sgElPUG/YhaHqVEQRZS5nsxbJMPshj1j6Ce5F5XZQJc6Ne1ujZ7BLOCGs
	5AzrWP95bdY1aFfI+KHLg==
X-ME-Sender: <xms:SvtSZ8PgrJ6XNdM0IIa16OX3pTqtb2UsttKiKIE5ZJnUWbmci1q1bw>
    <xme:SvtSZy8BRXeo0sOB4DN0Z7Fo5HvqfVc8-B331IzkHMQWKX5AfTsjQ9WFn8HfoNmr_
    25ZCLd-DNIRbBu3JQ>
X-ME-Received: <xmr:SvtSZzQTJphmgVIQ4ojguW6WEuKcLit9KGEWXIXDEmI5IZ9rQll_ra1j67yu0NrsD9kvU1Rh7INwLtWHrUKvUkQ0c98_bZ97l7MPYT3oQXJOKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjheitheskhgusghgrdho
    rhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtg
    homhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SvtSZ0tRSg7iiyAPeRZ-XJJzoUo2zvTzTTM4Gh3mN082XQUfHGOysQ>
    <xmx:SvtSZ0fDFRI5vG_52lymSU1n9Q4yFrgmSBB1V6bYLwmI84uQVInlBw>
    <xmx:SvtSZ42LEFmtAPkvnxwq1Xiu9For9_xBOK4aapak4hzrR_p7XWnUIg>
    <xmx:SvtSZ4-qBSjxQfXOZqRKJ2gMjQiXoW9RCaQkFUSzjpHbqgsb-cfSLA>
    <xmx:SvtSZ42bxBjJx4bOxXoyvwruRxKttwF6KOuX7K8Tf25V_gc6kJb4blBj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7cba169 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:46 +0100
Subject: [PATCH v11 11/26] Makefile: extract script to massage Python
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-11-525ed4792b88@pks.im>
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

Extract a script that massages Python scripts. This provides a couple of
benefits:

  - The build logic is deduplicated across Make, CMake and Meson.

  - CMake learns to rewrite scripts as-needed at build time instead of
    only writing them at configure time.

Furthermore, we will use this script when introducing Meson to
deduplicate the logic across build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  8 ++------
 contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
 generate-python.sh                  | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 2ad644e85649f7bdea391ead6356ecee1e9e737a..32648a1c92d378820873c50fd799f7d4614395d7 100644
--- a/Makefile
+++ b/Makefile
@@ -2635,13 +2635,9 @@ endif # NO_PERL
 $(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
 
 ifndef NO_PYTHON
-$(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
+$(SCRIPT_PYTHON_GEN): generate-python.sh
 $(SCRIPT_PYTHON_GEN): % : %.py
-	$(QUIET_GEN) \
-	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
-	mv $@+ $@
+	$(QUIET_GEN)$(SHELL_PATH) generate-python.sh ./GIT-BUILD-OPTIONS "$<" "$@"
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN) \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index defdd958bb64906489482b77752b1a137282824f..93c865ee2bf0fc7eb42f21a2c015a2e1ea5cd737 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -899,10 +899,17 @@ foreach(script ${git_perl_scripts} ${perl_modules})
 endforeach()
 add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 
-#python script
-file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
-string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
-file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
+# Python script
+add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/git-p4"
+	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-python.sh"
+		"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+		"${CMAKE_SOURCE_DIR}/git-p4.py"
+		"${CMAKE_BINARY_DIR}/git-p4"
+	DEPENDS "${CMAKE_SOURCE_DIR}/generate-python.sh"
+		"${CMAKE_SOURCE_DIR}/git-p4.py"
+		"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+	VERBATIM)
+add_custom_target(python-gen ALL DEPENDS "${CMAKE_BINARY_DIR}/git-p4")
 
 #templates
 file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
diff --git a/generate-python.sh b/generate-python.sh
new file mode 100755
index 0000000000000000000000000000000000000000..31ac115689d9cb1736f170c3b8215592bd7baf3f
--- /dev/null
+++ b/generate-python.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 3
+then
+	echo >&2 "USAGE: $0 <GIT_BUILD_OPTIONS> <INPUT> <OUTPUT>"
+	exit 1
+fi
+
+GIT_BUILD_OPTIONS="$1"
+INPUT="$2"
+OUTPUT="$3"
+
+. "$GIT_BUILD_OPTIONS"
+
+sed -e "1s|#!.*python|#!$PYTHON_PATH|" \
+    "$INPUT" >"$OUTPUT+"
+chmod a+x "$OUTPUT+"
+mv "$OUTPUT+" "$OUTPUT"

-- 
2.47.0.366.g5daf58cba8.dirty

