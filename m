Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2B15B96E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313517; cv=none; b=oBkEQfxBFqsBa9cK6/tlIuDvprNQ3RlhOXCld2o9a0bAvM1RY5WCBOPqMjGDvDodTScoNY18x9RjxK8e6uSaOPw0tfkLWwZtOqHbTfKeSE+0os6n/Mpft8Y3lXYQZJXIzS2dINgNrYYVxuLpiBB2TARig3y77aK8vwhe1LKbVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313517; c=relaxed/simple;
	bh=kd6ltjmgpO3Qf68IbmeI+KwV2WTqpZK9n0f9PgiQtdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Me6nGe7XgiA9uOzZm7ndU8Mvgj5hlvivIu/1UMZplU3HBAP1ZM9jSR2JkmJJP48NV30s4BCqfVyG3bYZnKW1EuMiTvZdqnjf3mo/eyf33Ugi0tuX2DjEXpO+LAMxabHxp+IXWLCAdKZRD5b2MPtYD0RxHuPJgeGQbCaYCfORga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R2ASmQNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gX95CzM/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R2ASmQNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gX95CzM/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82A411140102;
	Mon, 11 Nov 2024 03:25:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 11 Nov 2024 03:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731313514;
	 x=1731399914; bh=AYeZgubIEeaKJ+0342Ls5pOVn9OIUWOdfg7ZZIqpORo=; b=
	R2ASmQNu2bR5fcNY3tBijEEVIEwK9lufV5JFitBPYgv1JcSt5yM8OsHXqstIAvEn
	COaRL+lmkPihhMCvI3KqPwgi+ay1NayPF3l63602Fw14EG/3mjV5vvuURSkuJowf
	Gvap4L89DCJZcA+3EFbaYKkiJCJSpqyIZ4HSKzoUTLimVAFrD/KOhUrw0cn08BYj
	i0xbTITBqQVbIWWBgKdt0Sc6W3v5UEEg0Redp5O9qSNbfdVYSyzp6mdR5qHn6Be4
	IOpzMJse653G7FHI/WbfASe6F9InkSox7f0TZCiNoU5xxvY6YRx5ZP3yXsFMTOTv
	pGRtNuh4uVUMzmh2rKkrHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731313514; x=
	1731399914; bh=AYeZgubIEeaKJ+0342Ls5pOVn9OIUWOdfg7ZZIqpORo=; b=g
	X95CzM/xpLPnxiuhO4rqVwVe6VzuLzbOllP2cAiIBlDA4b4JXGe172nLQCK7xCRo
	XCLsB8AhELkMymCBBgMx4wuZQN7nCwjUZveQGV3H0cY+GbWBvmkDRMmCWuZLYYbK
	9b/GL0aS1rD+kP2knYiQxDivO84NJhdTFJ2Qr+GM4ycZm4sEAxAT/LWCImcoHxU9
	nRn6lSKsMyYU4yEaj1bTXolp7SOU+qvsfbzXw4CgS4elYyknPd3eiEV02p3sYGQ4
	szB7VU8JGqidNu23VjF66D4o2psObNMTQ6ofq2XhI3dq1Bzo2w1ESGBgvm8wDLke
	n5gonkmrX96DXmtl2N3fw==
X-ME-Sender: <xms:ar8xZ12rkI0vhcCbdeitEkAGy5wVmTD2E-7RVx1lMLx7kPyomBkzlQ>
    <xme:ar8xZ8GgQChTgy26UKhcJAK74tfh2XUCmjWjZeKe6XGnUTtrNHJu8jzsJqy8EPdMq
    uCYyoRqoK-wp7w61A>
X-ME-Received: <xmr:ar8xZ14wPrtfSxNVJQ2VPI6i1SitnOD_2qA55zK45BcBFkBjn_q8JrDVC5dO87zlLbckhzb5SIdxAFRNSyZ4DeDlPb2HqizEcNUnJqPFs-Z-gCik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ar8xZy14evgiXTOp7xisdaJ7uakCPDxqcurk1aOTaKe9zYnpDOrn9A>
    <xmx:ar8xZ4Fd3d8k1vIrTiRWm5cFKIxSWxMFmQwdoOyb620dWquffZDamA>
    <xmx:ar8xZz9SFcWEGkoUnNhBQ0ZfO3YTt0hq4YoL0Tpi809WBxjIEKfQQA>
    <xmx:ar8xZ1kwqvjAb25pDvPhHerrlA9mATIZML7UQpfnDFxOWnBsJREb9A>
    <xmx:ar8xZ0gRxlrpiKT_FaekEAmEZDpgQp5LonB6aYHJygCn8_x0eNnZBbZJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 03:25:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91a32038 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 08:24:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 09:24:58 +0100
Subject: [PATCH v2 2/4] cmake: use SH_EXE to execute clar scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-pks-clar-build-improvements-v2-2-d4794d8d1b30@pks.im>
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
In-Reply-To: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
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
2.47.0.229.g8f8d6eee53.dirty

