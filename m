Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951C14F9F9
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313518; cv=none; b=gj/BwCb37Bk3uQL+6RBSsY5zl57rj3XfxqetIbL1vWHGq2XSSHueU8o9A918K1jjTiODbGRa2TY2yzLy2fch+kQ3wsQXameVSQpj9hIqj3EtpUaB4qmW9x6S5iD0Huc2T4KvqH65oN9ydL/ZQTpDjXsY/5pF75sUKxASPH1i+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313518; c=relaxed/simple;
	bh=BeVtGXf4a/rJhwe8glmirevg0hzLjpynIf+ofb7MHVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPZQgndvACxzE/QpeAfewmFJKRwGs3OFt4OtFJOpcF0W4AsAXAEGvkqV6nlnxZsVYpIz8ikxhUQsbgh7dycrfzxWRnq2YidTJUewZ1FFGyN6liU4mykOQIjpkZKtJTUBE3seL3DvJXNj7BwlDbau8uyL9O+hEFMBBcSARErKzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nC1jhUF9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q70UHE55; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nC1jhUF9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q70UHE55"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AF4041380280;
	Mon, 11 Nov 2024 03:25:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 03:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731313513;
	 x=1731399913; bh=0ElWoFd9wQsgt5GQPAjntmxtu0WbNlJo9MtCLEgrHag=; b=
	nC1jhUF9FgBoo8lmCAEFu1BzWhD8SYZsTKPpMMjoxnn4EVkLITWS8xqhfz/Vu4GF
	DlEYUQVQE3P6+4sYNW2JkndoGpW0A8KGaWQOBHEZ5PEPE1GO88nPDzzos2LW7tCc
	ZYPHm7PUIC+L8sZrMmILV0vSXUs4uunZi50H7BWEG21bAKFJzHOqXup3NRoZxTVV
	KG4K+mXB88LFdwHGTgN6bXnPScqGrZsH2Y062eCHt61n0Ub8J94KFPP5ey5xWZ2A
	YyfipnWOjp1TvVIyfqzS17otKRVYFLYlw7z4zOCyMgvxHSxPsJV2Jk6ejTCeeF8G
	TSu/e0yyLvQrb4GrVDYPZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731313513; x=
	1731399913; bh=0ElWoFd9wQsgt5GQPAjntmxtu0WbNlJo9MtCLEgrHag=; b=Q
	70UHE55rrKP4V1tc692QY6930NWT5uq//kBf1ohVyzMJ5DtGR2E2cumUyKgzrjY1
	mFi7AYZ7flukyDjHOKw5aPsa2kP5diGZGG62XcITml7cViivnxOL2gNDwrkfrPIO
	2oGTKL5VMA+tBwX7V3npJ4Zlo6G/HbvQBXhG0xx5HzelknEOYWbZ10FYNR0+maiE
	oQ9VrOzJgVcQBG4fIA/ehmn0xw1HM2SQ6rVajzvDu38LpOlZMbKQwgxM8D0FLajO
	VHWgAQTKDyI4MxHhUZaOvivUO74jSow9F7lLHVpQC6n8/6zdOsgv0j0yHdwatJD4
	wfhfyd0yvN7fNAkILlibw==
X-ME-Sender: <xms:ab8xZ0ZRtv-5rJJAHqnCR7nv9BGAYESlF4oAgfIBfyvy29xW0JT1wQ>
    <xme:ab8xZ_aaI5ZDWC25T_n6YpEOE9qiAVkjzeg0i0Kl4FIAro_a8IEQBWo9aFCbi219s
    Xw6bSMqZF1-EWktWg>
X-ME-Received: <xmr:ab8xZ-9WihABKDk1_aUeyElJwVmroafk7-1meQrXJ0lokiAfgc3zAeh02-z56RzThahFFvbs9o2njYmf7AiXscsGQl7OCZa_pXz0pUnOENLDCJrP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ab8xZ-opOQBBBAvV9gxDkRM5H2HYrR7dKpA61THTlP8w7szBaF00sw>
    <xmx:ab8xZ_rY-j8ikCrgSF1ApKB4kDX-uL_61Z9T7YeJm1LGGsSdC4ygOg>
    <xmx:ab8xZ8SaHfDmsFQiQLDcb01imB6RS6ubq76OhUX6My1BFFsBNSQE7A>
    <xmx:ab8xZ_qO9Ozdr_6dPl64LdlbUua5HNHKL9fF36n7KwWYZY3wSOUnIQ>
    <xmx:ab8xZwlDZ7XOj7p5lxproS968GOmoZH3tNpy6lIpjgpvzHtQmvULMuXu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 03:25:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85a0bc31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 08:24:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 09:24:57 +0100
Subject: [PATCH v2 1/4] t/unit-tests: convert "clar-generate.awk" into a
 shell script
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-pks-clar-build-improvements-v2-1-d4794d8d1b30@pks.im>
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
In-Reply-To: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Convert "clar-generate.awk" into a shell script that invokes awk(1).
This allows us to avoid the shell redirect in the build system, which
may otherwise be a problem with build systems on platforms that use a
different shell.

While at it, wrap the overly lines in the CMake build instructions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                             |  2 +-
 contrib/buildsystems/CMakeLists.txt  |  7 ++--
 t/unit-tests/clar-generate.awk       | 50 ----------------------------
 t/unit-tests/generate-clar-suites.sh | 63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/Makefile b/Makefile
index d06c9a8ffa7b637050c9619a367fbe61e7243a74..5232b913fd20f01a7e5f41d46178e93d52c9f534 100644
--- a/Makefile
+++ b/Makefile
@@ -3907,7 +3907,7 @@ GIT-TEST-SUITES: FORCE
 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
 	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(filter %.c,$^)
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
-	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
+	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-suites.sh $< $(UNIT_TEST_DIR)/clar.suite
 $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
 $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8974bb9fa202a0556fd9b16d105836d8cb66f543..da99dc3087a218d30e0fd1044567d7148d0d80a9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1008,8 +1008,11 @@ add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
 	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
 	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
+	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
+		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
+	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
+		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
 
 add_library(unit-tests-lib ${clar_test_SUITES}
 	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
diff --git a/t/unit-tests/clar-generate.awk b/t/unit-tests/clar-generate.awk
deleted file mode 100644
index ab71ce6c9fc2c3d49d826f3550a95be893114508..0000000000000000000000000000000000000000
--- a/t/unit-tests/clar-generate.awk
+++ /dev/null
@@ -1,50 +0,0 @@
-function add_suite(suite, initialize, cleanup, count) {
-       if (!suite) return
-       suite_count++
-       callback_count += count
-       suites = suites "    {\n"
-       suites = suites "        \"" suite "\",\n"
-       suites = suites "        " initialize ",\n"
-       suites = suites "        " cleanup ",\n"
-       suites = suites "        _clar_cb_" suite ", " count ", 1\n"
-       suites = suites "    },\n"
-}
-
-BEGIN {
-       suites = "static struct clar_suite _clar_suites[] = {\n"
-}
-
-{
-       print
-       name = $3; sub(/\(.*$/, "", name)
-       suite = name; sub(/^test_/, "", suite); sub(/__.*$/, "", suite)
-       short_name = name; sub(/^.*__/, "", short_name)
-       cb = "{ \"" short_name "\", &" name " }"
-       if (suite != prev_suite) {
-               add_suite(prev_suite, initialize, cleanup, count)
-               if (callbacks) callbacks = callbacks "};\n"
-               callbacks = callbacks "static const struct clar_func _clar_cb_" suite "[] = {\n"
-               initialize = "{ NULL, NULL }"
-               cleanup = "{ NULL, NULL }"
-               count = 0
-               prev_suite = suite
-       }
-       if (short_name == "initialize") {
-               initialize = cb
-       } else if (short_name == "cleanup") {
-               cleanup = cb
-       } else {
-               callbacks = callbacks "    " cb ",\n"
-               count++
-       }
-}
-
-END {
-       add_suite(suite, initialize, cleanup, count)
-       suites = suites "};"
-       if (callbacks) callbacks = callbacks "};"
-       print callbacks
-       print suites
-       print "static const size_t _clar_suite_count = " suite_count ";"
-       print "static const size_t _clar_callback_count = " callback_count ";"
-}
diff --git a/t/unit-tests/generate-clar-suites.sh b/t/unit-tests/generate-clar-suites.sh
new file mode 100755
index 0000000000000000000000000000000000000000..d5c712221e46a2eaa288fff5262438e5f04d6f72
--- /dev/null
+++ b/t/unit-tests/generate-clar-suites.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+if test $# -lt 2
+then
+	echo "USAGE: $0 <CLAR_DECLS_H> <OUTPUT>" 2>&1
+	exit 1
+fi
+
+CLAR_DECLS_H="$1"
+OUTPUT="$2"
+
+awk '
+	function add_suite(suite, initialize, cleanup, count) {
+		if (!suite) return
+		suite_count++
+		callback_count += count
+		suites = suites "    {\n"
+		suites = suites "        \"" suite "\",\n"
+		suites = suites "        " initialize ",\n"
+		suites = suites "        " cleanup ",\n"
+		suites = suites "        _clar_cb_" suite ", " count ", 1\n"
+		suites = suites "    },\n"
+	}
+
+	BEGIN {
+		suites = "static struct clar_suite _clar_suites[] = {\n"
+	}
+
+	{
+		print
+		name = $3; sub(/\(.*$/, "", name)
+		suite = name; sub(/^test_/, "", suite); sub(/__.*$/, "", suite)
+		short_name = name; sub(/^.*__/, "", short_name)
+		cb = "{ \"" short_name "\", &" name " }"
+		if (suite != prev_suite) {
+			add_suite(prev_suite, initialize, cleanup, count)
+			if (callbacks) callbacks = callbacks "};\n"
+			callbacks = callbacks "static const struct clar_func _clar_cb_" suite "[] = {\n"
+			initialize = "{ NULL, NULL }"
+			cleanup = "{ NULL, NULL }"
+			count = 0
+			prev_suite = suite
+		}
+		if (short_name == "initialize") {
+			initialize = cb
+		} else if (short_name == "cleanup") {
+			cleanup = cb
+		} else {
+			callbacks = callbacks "    " cb ",\n"
+			count++
+		}
+	}
+
+	END {
+		add_suite(suite, initialize, cleanup, count)
+		suites = suites "};"
+		if (callbacks) callbacks = callbacks "};"
+		print callbacks
+		print suites
+		print "static const size_t _clar_suite_count = " suite_count ";"
+		print "static const size_t _clar_callback_count = " callback_count ";"
+	}
+' "$CLAR_DECLS_H" >"$OUTPUT"

-- 
2.47.0.229.g8f8d6eee53.dirty

