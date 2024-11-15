Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2D1862B8
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655982; cv=none; b=kUqzWb684wi6hRxi8DAbRjy4NFKTX3WcsDtW3k09RXThNyvu6FSi/iUpCev4NegHJorQ+Az4gwmwysFX2L5xlOGuPFbpN/RxJ7sysae8qBuXENCHSCLGkZXLRSvd05d+PgPpKd57eQM5Ag8vDGI18NrmknWijkMEtg/nSLr1lnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655982; c=relaxed/simple;
	bh=TjGKe4RYeBhoMCfSnbcGwSZSmIVBGNs9Aan5MRX3oVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAo1uHc7qL2x8MnBQiaE8uMLrOyq1v0PPyBfX0B9X9DNzj3GEmhKAoH2BuHrswTVW/N8nrcBPS7YrYB4F5qXH76cp/KpzE/P+zWn6RtXhJHjAFBqh2CsESj8FcpC5vlvJhR/lHFNxVzU1DY5D9rDtbNR0+lv5UuqBXrmN+DXyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VpuyFUn3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQaHfU+E; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VpuyFUn3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQaHfU+E"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B83EF11401A7;
	Fri, 15 Nov 2024 02:32:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 15 Nov 2024 02:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655979;
	 x=1731742379; bh=4n3O3qOtBdnmZcXhoGDD9gerYrN5YZXWzBrp0TOu6Jg=; b=
	VpuyFUn3ZafHOqx5AvZt2356o9M5f06W6ASn8niv90r+CGV/KhapNUxdEnobof0D
	2JQMla3tOEU8KcRaNxAz+pVR8VXHLY1D4cR/mUMUWufGZKKqOp5Q81tqutoRCE6i
	0fNQh4QydfDmJ1uof50pXHxJsfT7qYTQKmtNGIHh78CU5PpuI25dPfM0zGmm5JvL
	YK/He27BFU5ECR4eBn2YpveedWw6slQg+95XRbJtw2L5GAfelr1IxrOeSnBm8fHt
	ZXMoY/dTThn1WKC6YueOqZSQfYdt1fTFeHNI9pGItRMyJ4tI5Pi3WELRc4c9ydcZ
	LJNlDy90i3Q0MpZ0nKwzzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655979; x=
	1731742379; bh=4n3O3qOtBdnmZcXhoGDD9gerYrN5YZXWzBrp0TOu6Jg=; b=j
	QaHfU+E3UC8LIBUu5jMaHNN1rZSHsoqvTFWlIgd2R63Wu6xrxkIy9lp9W6w8qdWT
	YZXJNdV1h1nVTGtaE7p7sTLEOgFag38gfTHfVg/4ALdTJASsiwBlsmaTDGG7Cnmw
	72lFFQHyeNNVuCpNaRJ46UErp72nldlAfY2vqSGBk5LpREh64sPaeaOdDiarkU1V
	k1azbD4ULraKA74bcDRKr/jruwjrhJ5UxhLVElEPRPTIEDFb5GXzrD0OJiEcy6pq
	G67DfJCQLLnC/cOK4nQ23CLgahjbfuLjyj67ehOJT5+4Fq1BmjXFKz57wvY19Q9d
	4FL+D+qg/ZIRz2AAyaj1g==
X-ME-Sender: <xms:K_k2Z9FGy8OeGJ6bq2DdjppgbQSyeZ6sPamUO0iXyEHAKwTuPzVeWQ>
    <xme:K_k2ZyUJz81W0j-sIa5GRnsGjSQzSOCsiI2kj4lSzicIl7OwGrQwA0-323x8Exuug
    Uyms4e7Uo8PUWg04Q>
X-ME-Received: <xmr:K_k2Z_J62h7qgvvnlFKQRjmIipmljGCe8GhRnnCHYymiCt75AmTyt4Wdp7BCw8R9SW3wUofNeVXjYAMl-BXI9tl9CoM8FMIXwWPQpxeWMmFIA6jkfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K_k2ZzExd-XSElby-JgUAN1nGzHaR6XeMrSNY-qg3AwneLQK52pq-A>
    <xmx:K_k2ZzW8Yd1huSnifVq5OP9KKWTaATcN-0GlVJPiaVPy_F6O3RC9AA>
    <xmx:K_k2Z-NcdwmjK9DOl1R97wA6Zz0tB2NbMR6xTz6R8ozbUC658rnH4Q>
    <xmx:K_k2Zy0QKDMXqafBJCxGx31EvyOqJAbuvspDXn1UKBEcD8T3I6iN0Q>
    <xmx:K_k2Z5yXqBiZoZMSDkmd_zDjL_sIQEGLP9gqaAs3GvqFdfA1o0hDyW_u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:32:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca700648 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:32:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:32:42 +0100
Subject: [PATCH v3 2/4] cmake: use SH_EXE to execute clar scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-clar-build-improvements-v3-2-29672bf65ec6@pks.im>
References: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
In-Reply-To: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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

While at it, wrap the overly long lines in the CMake build instructions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index da99dc3087a218d30e0fd1044567d7148d0d80a9..2db80b7cc3c6aba840f18ffdc78d2cda1877d8cd 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1005,10 +1005,13 @@ parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
 list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 list(TRANSFORM clar_test_SUITES APPEND ".c")
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
-	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
-	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
+	COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh
+		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+		${clar_test_SUITES}
+	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh
+		${clar_test_SUITES})
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
+	COMMAND ${SH_EXE} "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
 		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
 		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
 	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"

-- 
2.47.0.251.gb31fb630c0.dirty

