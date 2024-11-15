Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC318B475
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655305; cv=none; b=siVfgOvbeTM6Tn5uXpDQSXkoFYMU6ouaIpJdjF8v8HTAd1dIJpvRNuVhhdDagUVaiD6dnuqCCy8T3n676KAhbelkvJB5ICigSxTJfmG4PP8g/jzhsd/X01VnMCkwCRQXNlid+yjQj4ik3XS3X+SCEcxxEuai8PUwxdCjj17ezvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655305; c=relaxed/simple;
	bh=cdopJZGz9yfRhV61IKFXoeM6uxWLDKMp8gpw9KRsWW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVROI2mToLS9n8f3XdVyckMkjvwMEKxRCKoicYIMi45Ne6CmMdsqKHNAsUgPWNG2WT1SXDOYgJRKYTPEBfLT+A7c4c7+xFcpelZVO7xuJ8TFN5Pyo19iEqo2Hycfs3grGYmM+ptYJpvwyqSdeZPPaKzYnQrmC+eD/rX28PpuOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oB0BEp8g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h9THIuPS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oB0BEp8g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9THIuPS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 52887138064E;
	Fri, 15 Nov 2024 02:21:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 15 Nov 2024 02:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655301;
	 x=1731741701; bh=DTQGfqspLqVKcejU/Ltotj1SP/r7nl+19+EXuxVRZuE=; b=
	oB0BEp8g2WqdAwcFC5wWuPTLIpxnsUnzp3hBtrpxF0g1apLwYzGrsxIVTL2sQT5+
	2McJEYhXK4G03ztJUd85TfxnXBKEXPAsejDH4bM6EqEjpSKuvlP3yJzBkLN4djID
	pCnZnUVwKVsKC6Id1Jsvv52euqta141pDgO4YgZLyh/EYXWv7bPXHBkzBbBUNwzl
	PXtHhxdvi3JC3oW2cWK2qbWs1fgzxdf66zxLtYNRNFeH7stPdHvTXpX+Z2n2cYVY
	fideIA7OTvnIMtvrjuZlUigz/yN19Hc8WAoV/3clNsDsCWJA5bZw6tfmB4yiHXBX
	HqEUohP3Bi9YFRBFC/2MSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655301; x=
	1731741701; bh=DTQGfqspLqVKcejU/Ltotj1SP/r7nl+19+EXuxVRZuE=; b=h
	9THIuPSTNdDjFxtp5fmjfbM8fDRXkinzlaZZR+deuKaEaxfLcBY5gkKds4pYFa37
	X4H2PSzuqdbxjWpexmgKboMJSwN91XG026Dy2ADN3FxrfxQ4jvW4r08IwbnTePc6
	R5eMIu7GLyuB0fj5IpMpmHdxX24OJRGJnioILDjygsWadXK8HYkWVVcESdHpcHJz
	LnYoaNMKw7GtR02m1WdoXfGNLVAjlo2rGa7WVALOqJe3aW9cMcE8AXcApz+WO0eg
	5ry0FIBQgCsiIu8QpSqfXX8iK3GpSffpSk6RGP9yKWfHV+as1bpUCBKjVRYuHvPU
	0bLMIk0ltGj7JhRg6gmGQ==
X-ME-Sender: <xms:hfY2Z7YO6rjttxWqeZ5VreS6CfDuLZJnGwDa9dZlB9owYjfIA1le_w>
    <xme:hfY2Z6bjnbAj9_U5-X66LznkZT0ErMKjwuJ5u4Z3H1Ql23o9RqXPTZAwDYvBagmfc
    bDXgSAQeVEQoIuJNQ>
X-ME-Received: <xmr:hfY2Z99pKdYdQcDwd9wmRB4zuYNGejwt7MiKUbmgEsXcxLjPa03XOg5VGUhL9p0MulRspK0gF66N5R-uPKPZn3TYHOHo7uZDZlNJmvhimLvu516H8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:hfY2ZxraN6VpELYpSe3KoBmXfi0H9aENhvSi98jZwQx8xXx1KqqYQA>
    <xmx:hfY2Z2r99l4nX36ni-xAn4pDQgbWfZ48jPH-L43VN2MZL8p47LW1Nw>
    <xmx:hfY2Z3S-dWEijAW8J__OUyngZSn4pqKcrcdfydzGhLMynqLH3uzSWw>
    <xmx:hfY2Z-rgy-V_wWkIgdOwHRQjV4RspkPG9v3tn79g3FrX82kzkyH6vg>
    <xmx:hfY2Zzi-Hy_WIx8mLtiwUjNIP8MUc7RcCq8ddOHnoTYlXxus2g4FPCs0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f93ce61e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:19 +0100
Subject: [PATCH RFC v7 07/22] Makefile: extract script to massage Perl
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-7-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
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
index fd4b061d0ad140cf0c9fcc09aa5946b2ca0ca7a5..669ee4fb8d28fd9e1aeb0a794d5ce44ba60b5c9c 100644
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
2.47.0.251.gb31fb630c0.dirty

