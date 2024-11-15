Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3D10F2
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655982; cv=none; b=KyLS4hLWEihti5cISUiBmD+0cujT8aeW7b4iCEnkFA4+oq4PJWj2gBJNEFdOE+y+ZXaNiJUweC4r/KerHze3XqfYIytudOq9hmudOi4r3lgSHDRskLGHdxFK67sn+RK5b0mrnsLIg4+ZQoG9WUfCxem8/5WIOa5RDPfhMr+/uLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655982; c=relaxed/simple;
	bh=B/9MfdFJg2GSXkewf4DQy7E56ZPd51dwEvPhgvpsNHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5iJqMnOVqu5fl/07j8eaM/81GSJ6VqqbsHF/iOR43vBuOaCNBxyCJKX0ML9Uilw08aD7hgkWt3p3UF8u+xkcmqmgv8qqXQ587PTH8HWGBhj4BgW0TuUTmYrSbo6zicFHhKl1xnjz0hN/Wr5/FcpNhg4vCac9ZbigLMgKa1QYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j6ioix2O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JORJh7RT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j6ioix2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JORJh7RT"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65AF01140092;
	Fri, 15 Nov 2024 02:32:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 15 Nov 2024 02:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655979;
	 x=1731742379; bh=x0hbpADx1T/LFhkWIoc/wMq9alvjLZs/DvZfLHxYkGc=; b=
	j6ioix2OFzSjwsdN5JItt/joYW1N7UYQOypbOUzOZLMDlSqzQdlgnFlfjigOwET+
	jVxSuUst3H5PFNon6kAgY3pDjGQlpF4p/NzYLtKg51cJlTpQhyNcFHUAQn4gwgzd
	ko/tMxzDNpbgFfE7rlS+sbm/+YrpMNlC+qIp08hHmQN9AtszYergLpTb5zq60ZFI
	zHEtlTwMRFnoPlVAUwrwuATUHrk1ilj0BBU0duSUNRtJHuY7Au/h+DSatpEfUfHC
	jB/wmryz0mQ1fngohBTiLmgYHv9eBOfjdXGkchC70bKLHEBevte6yHHDGvgYeKqQ
	KVugJXk3f5b38yLp46qncQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655979; x=
	1731742379; bh=x0hbpADx1T/LFhkWIoc/wMq9alvjLZs/DvZfLHxYkGc=; b=J
	ORJh7RT1EBsWSmB80yac7rslafWTvegcyGJnpm5CFljYmtuipKNq0Mu2T7UQSpRe
	TMhxhiU+Pfkmp1J6yWz4dapR0/nrIV299FyHu98NnxY4vvD71nhXgBE7CimQz/hy
	HJqcm0JWBJcOKj/SBRoBMsDnyt0nKX5dKNa3BZRQbtvnMjaCjyTESx39V6t6J9l9
	VF547faMpwTyWCoBLXfI/tN0kbAr5cNUdEh14yl3R0Pff4AEscg9AwPyrujw9Dw6
	lj0z99d6TtI7QUtjIn/mF4MKsByka8AbgHkk6z0EDim2uSKIVZHv8dWG8Fd/o8Zr
	6TEAfeNMftn/S45TzFYYQ==
X-ME-Sender: <xms:K_k2Zx1CG1Pk-_TVy0iIOAmVKTi22nwATlo018bg8zcw08Xnl5Zsqg>
    <xme:K_k2Z4FQs0BONGd_ki7SDU4aEeQSk70xPdZcW2foJB_QzH7dRSsu2Q5d-_RYDsUyd
    svSbarqiwIJK6bCZw>
X-ME-Received: <xmr:K_k2Zx6F-bKddBIn6Ii3y6-EjvulN9d-3S-posEgCj_lp5CNEKy-eME2irDQChRgv0yWvWxhL1LIC45Ttsvh9YAbdzFKp_Sngt5BZVQ_wvmxAHjI2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K_k2Z-0NYmL27ilxNiC3t51T2PXD3CnL_bk_DxI-3wSo-yDMeQ0RjA>
    <xmx:K_k2Z0GgApW0ByUOyI0IKbk36vXdwu9xoduAzrcuNktZJs36aja2Hw>
    <xmx:K_k2Z_8962hQOa0W7ZZHcjZdsM8ZAlUOmTyDh2gHC9dDXmQqIr0EvQ>
    <xmx:K_k2ZxkRjsE78OR7c-HUH7dLkEb0NLCTTQpy9KMlJmgjoGXPGqddhw>
    <xmx:K_k2ZwhKfYQpapg23ctf11PTgueRzeS0KmIGH0DuU9LEDfBRGtqxltUP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:32:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d618c669 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:32:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:32:41 +0100
Subject: [PATCH v3 1/4] t/unit-tests: convert "clar-generate.awk" into a
 shell script
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-clar-build-improvements-v3-1-29672bf65ec6@pks.im>
References: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
In-Reply-To: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Convert "clar-generate.awk" into a shell script that invokes awk(1).
This allows us to avoid the shell redirect in the build system, which
may otherwise be a problem with build systems on platforms that use a
different shell.

While at it, wrap the overly long lines in the CMake build instructions.

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
2.47.0.251.gb31fb630c0.dirty

