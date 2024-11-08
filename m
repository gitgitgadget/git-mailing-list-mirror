Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C711E0DEE
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071810; cv=none; b=pjqHSq/aGBlkNGA6jfELJaiM51XLn+GVoteHLEB2OW6DLyhJdQyiSUJtz22evXTPGImtRuaO1fMCAJuY0EnnHBkSU0blJgG7zF3z8W2uVszbPAMm1e0xvxAlC5Yr0/1IRez8i3V8ANyKy5mqZy7VXU7MQ3esYgBTU28NrUi1+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071810; c=relaxed/simple;
	bh=G7xU4yN3UU10MOnvinAd/adQUnB5Jr2ylgPitHF6K9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyA+Hdcm35BL+oQUXlgtZUU6BLTPVi3+Tqu8kYTcjDgHkk0K6awRZqrceLj0X2duYL8brFlDf3+J9Zv/0Yjvnv/vTiuvIYoXSlAwl4hB/rzfU4ZHhs4vZCRKwMUglCuUZYMmvfW5M+NLsmwC7pcjqcaveETn4kHvpJ2BQETWoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qBdg+k3v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mr+Uf0Ax; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qBdg+k3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mr+Uf0Ax"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C15F91140171;
	Fri,  8 Nov 2024 08:16:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 08 Nov 2024 08:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731071807;
	 x=1731158207; bh=9t9dsn5gpzcpy78WvofQbDLwsiSUtREWkK4IGm4W1K0=; b=
	qBdg+k3v+Luh/wcxaKYQ6zT+wIBzNfapTgsfjGyytd7HIPlq7CmLjfhtnwgugcu4
	5sM2RzJP8ZPHnsh15rIuTI+jLk4l6PB3auktrlfNwjDpNqs7pimqrdOFKxwVQ+0b
	vvbmhSlK39RK8BDSf0fwdmmdlRj5/pJX4D8viIOt9L425B5qdx2rCA2K4NxPWFoe
	sgLx4U9Wwth2+HwiU8RbxGPiW4Nrorpdk1niD6YCzjBDQfw5xliIhylMidFXy3JV
	CZ0jqoitP2kR1N63jSbompSA/b4YwT9T2/1svOTJlCF2TV28QfdxIcD5OLAkphlk
	kwfx94kPg0sTU4luLV3hWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731071807; x=
	1731158207; bh=9t9dsn5gpzcpy78WvofQbDLwsiSUtREWkK4IGm4W1K0=; b=m
	r+Uf0Ax9hSZE2hTmhNUXsox40SnQhR6scTbnfWav/7m5UNjATxaSnK+JFC0N7ox+
	vhbNsSfwH5GSs2iyuPHapSIylGTvP07ksk/SGYtSVBUYiSXvyrQERjvSBPWFvyyF
	HSBAoOI3a34Z7Qql8mfGhBbBL9k09sh0HWEZARMRasuZCh/q1wnTSLAup6vis/i8
	bBV4Gm0fkzCtCRGDRdTUkm9idvL0r5lkR008+HcXTB2i3CFIMSNQPklXaxSOBAV5
	GRozYv8efXzEJ1sKMlo3z9ChsskUH9+k1Hc7IKPEtTCf5NHrWRfMOTjfOJjbWlBl
	dJo8gorP2mzoHQGKgfTyw==
X-ME-Sender: <xms:Pw8uZx4JcNCWYiemNOSLmvGGwjfvWoh35aAVH7f84tUeTyzvtynX4A>
    <xme:Pw8uZ-7xghvznFYyVOTUMPXwbePZsqAiEtVsk9BmRi38di8cWcFO6IDW84OeBk3IR
    tGGIeDxN_c0ezSFIg>
X-ME-Received: <xmr:Pw8uZ4cu5b468gzmRqjgUEGQX2gHb9gEaxyLoVpF4TLIhRW2q1jNq7RNQP2L0owqJsvWdcEoaxrDSp0qqiwI0x-VPUKDTkbquxia-Feso39Ar-w>
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
X-ME-Proxy: <xmx:Pw8uZ6KFuWqCj9RIKGmheCJKcQ2U78IwYmr9_vy5lZLBsKtsB6Cx2Q>
    <xmx:Pw8uZ1I2qQiygYPFD6XaZmiZvvCS-4iMbseXz0y0UQu84Xc27gB_2w>
    <xmx:Pw8uZzxpWGeJXRDShz9YYlEvNE_PhiZY3I4y4EX8AuvXDbx7D1d4OQ>
    <xmx:Pw8uZxJIHu1dvklWIC5ymCU3SyPlhq1tiqwI_SPU0VA7ggGKK69x6A>
    <xmx:Pw8uZ106FptbEUA_ilTSJQD_qa-ML5abyrRj7paCiLOq9za54YlFZNDc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 08:16:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e61387be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 13:16:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 14:16:24 +0100
Subject: [PATCH 2/3] cmake: use SH_EXE to execute clar scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-clar-build-improvements-v1-2-25c1fe65ce37@pks.im>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
In-Reply-To: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 30bf9f0aaa (cmake: set up proper dependencies for generated clar
headers, 2024-10-21), we have deduplicated the logic to generate our
clar headers by reusing the same scripts that our Makefile does. Despite
the deduplication, this refactoring also made us rebuild the headers in
case the source files change, which didn't happen previously.

The commit also introduced an issue though: we execute the scripts
directly, so when the host does not have "/bin/sh" available they will
fail. This is for example the case on Windows when importing the CMake
project into Microsoft Visual Studio.

Address the issue by invoking the scripts with `SH_EXE`, which contains
the discovered path of the shell interpreter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index f31936e5c8dea76a4bc1eba75d87468c809f59ee..041967e2e187476cb9d26b329deb388765c48420 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1005,10 +1005,10 @@ parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
 list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 list(TRANSFORM clar_test_SUITES APPEND ".c")
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
-	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
+	COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
 	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
+	COMMAND ${SH_EXE} "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
 	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
 
 add_library(unit-tests-lib ${clar_test_SUITES}

-- 
2.47.0.229.g8f8d6eee53.dirty

