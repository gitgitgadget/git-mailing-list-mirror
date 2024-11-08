Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32743197A82
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071810; cv=none; b=nYJl+/UTEED03mXsm8VRtQFSAyFPURxk8V3FvSyCWN232HcexpYgrnQ40EGkuQthSkqSuNydLfkOPQKYZIapOz6w0kY37kJGrcXFh+XSUywNAD19sL7u5iRFVCNw5n/XmAqsswBENcfIIu14MJ/muI1bwo083ZsvQ/4vxUXyGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071810; c=relaxed/simple;
	bh=BAeSfJBcDqLtOJyWhvWt6T2ttSXwwmJ5dgC56yEfPnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGwu4GxZ3jVdfbhAh1dZ1Mqg0ukkE0q2O2i4cU6b2SANqjrjoiDccSou/h4snHIbPq34bMt2C/T+O78BhyMcdRQztd2atHOExZzvDFC2ml8GYZelTRjGSDG/loOjmyuxJ/fn4MUTupEh6ZtpghlO4AYvjUSeMjZkexUdSMeL1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3uQDuHGb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeGRWU9i; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3uQDuHGb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeGRWU9i"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D48211400EF;
	Fri,  8 Nov 2024 08:16:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 Nov 2024 08:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731071807;
	 x=1731158207; bh=Oh6BzHxnewDNyRMnOENDzQWAIzEkKRCVZm+v1eCjTcw=; b=
	3uQDuHGb3oUrvQpku4DF/jdBJ4S/LFe1eIYez3REiYLcs4M3X0709aMrSNeY1S3y
	q7fQg+1Eoow+FMbe5IctkjZ7cBDYQSVFhhnbhl8eZg6RVdpmhDi1MXUfd/86G6fh
	O+qwJZxTu5t2CUbl0TpoFPq+MArGHVkEjOQuTtPVlB5dO/LebBYumyrcvp0BBX0I
	uL2KUvmAnTG4RNGg6NJ49CVQUBA+0qPAscNc7H44cLBwIgFtm0QarR5RtjX7n7h8
	lTO3c+HHOGgHk8q4aJ2wHjUiwLHfox2VWNy9Pekmc1dz7/XFOg/NoxMPZxeJOp9y
	MN5rhX+9nDudAipqomKRTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731071807; x=
	1731158207; bh=Oh6BzHxnewDNyRMnOENDzQWAIzEkKRCVZm+v1eCjTcw=; b=H
	eGRWU9ikp93pFUQ54CVQK+Zjs899IqYQanppOgmGxwu9r28Ii4B0YmCqDUaX/haM
	SAeJz5KFGIfkox57RjkflnjHpINKFuyb/5alrFmxvHuq1ckoyxuCi4g1UQrhbpFU
	//TKqGRJ3Dx9szYSfjdJltpegjFa4XrvgEPdVikWWyJhhXRt91pAWMEg6NNI8o06
	733IWvM7ttDCyESEVSoAbEV5uN3DdtabGG1PE4NzHadDHESjUKFTPSzv3lRK253G
	b+1XXnYb4/IuhzNEcv2DU3ILe7txsSkuUdMrqGGrJEnAorOYLKgld4oKDtGWg7pI
	FkjIPexlW/E21m4Q1+pgA==
X-ME-Sender: <xms:Pw8uZx80E4Yzj-__-gJ7T8FU13CInEBGqE7JWohp_DZ2Ic1o2NzQ5w>
    <xme:Pw8uZ1sni433E6MjurzxAOVXKutws7HEhY192PG8aA1_SU5GQYTEbai91Zxw8y7Nj
    TMrdmA9Xx_l5QkVlA>
X-ME-Received: <xmr:Pw8uZ_Db33KCqPIj5Niu2nDGKFWAKMEZ_BWgCPaZO8phuZD8xW4UBJO4l1_c5xbF5EB7einw0vocM5HSfzmthuMocGK-XKXHp73PsGSuAseFbRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:Pw8uZ1exDS8V5Yg0-VER30UPfAi6E0r39iw59vnkxXUvYkkF8-BHRA>
    <xmx:Pw8uZ2NwoIAxUg8x6iCFd2K99FFXWvGYglR3KQqrWcMToHfSelWAAA>
    <xmx:Pw8uZ3loc98HGE7SxTOgDF310rbDxrcdTWFHauY4OUEiBVmJSa231A>
    <xmx:Pw8uZwvDKYTXOMRZy8g0-3filFoqeaJSYsknZNu7PRYQacwc976z-A>
    <xmx:Pw8uZzoE6aFU2xdFDW9mxUEBhHE8_8h6vnH_m2D4PlNQ5mSBMHnWovAv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 08:16:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b45f375a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 13:16:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 14:16:23 +0100
Subject: [PATCH 1/3] t/unit-tests: convert "clar-generate.awk" into a shell
 script
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-clar-build-improvements-v1-1-25c1fe65ce37@pks.im>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
In-Reply-To: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Convert "clar-generate.awk" into a shell script that invokes awk(1).
This allows us to avoid the shell redirect in the build system, which
may otherwise be a problem with build systems on platforms that use a
different shell.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                             |  2 +-
 contrib/buildsystems/CMakeLists.txt  |  4 +--
 t/unit-tests/clar-generate.awk       | 50 ----------------------------
 t/unit-tests/generate-clar-suites.sh | 63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 53 deletions(-)

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
index 8974bb9fa202a0556fd9b16d105836d8cb66f543..f31936e5c8dea76a4bc1eba75d87468c809f59ee 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1008,8 +1008,8 @@ add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
 	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
 	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
+	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
+	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
 
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

