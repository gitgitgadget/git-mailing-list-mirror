Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D015B99E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313517; cv=none; b=KWuwKPSAJOIlLr65D/4LllrZZ8p/KeuX17V18vGFwiqrXXIS3/pbyDbAQXNs0/HCwX4rqwn/L6Gdegyq93Jdmn6RuKw23qIo19H8y4u/yGj49WiaKGEc43LRg3i6X3PlgW3MNscMbLsD2oIsKeet50ZYd0g+YaKzLagvokSsnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313517; c=relaxed/simple;
	bh=kVKYRU6OSYi7/V6dZB8BwOgekT3Ltxg8G3HkLeh2nmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxgRmRFeibj8FxgetRKE3YJKx0/eQatLP5aWSz4Csn+n7LOH5OagADjhpr215QHqNBFQnLolNxwF9noQtlOI+OQ3FQ2udp120HTbG4v87/fNBKunuFYY8oHwfQLelYPgYcd+bIFHTOB0XIpu+xrs34Ksc3k6MG0uRyXwrkwzpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GX1puw5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoUNmJva; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GX1puw5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoUNmJva"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E5A5013805F7;
	Mon, 11 Nov 2024 03:25:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 03:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731313514;
	 x=1731399914; bh=HCpP0MbZBfjNIZ6BBYvww9NQPeiT33tR6Th6vxNF4Io=; b=
	GX1puw5ucXxYWD4T6HdNSOIlbN9TgntNFSF1qz797V6ymLaeigdQ/bcM94QHUiUH
	RjGm5lhJgnZrSFBjfQ4ddE0gbPS2Wvg1rW4GNoGYVy2WP30CoAo7vE0sZpbEV5YG
	wth9dE7LkDrEW5E8U5xBWzwv/O6zz+x1Bp41a9uRp1XSTx7mz73596Dsx6XZX7LH
	KOQkkCft1vFJXzlpzIY8HT/JVkFubSB1Y//8YxbTdFoJdAUyTTeDIWkbGQEUJAr5
	c/9hvWMdd5ahgAToXzh7H9uH1dCnzSHCQvcZKYpG7j4dw586WfzbRF228RANwW1y
	uao8KlhDf0OP19IsmDOOQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731313514; x=
	1731399914; bh=HCpP0MbZBfjNIZ6BBYvww9NQPeiT33tR6Th6vxNF4Io=; b=B
	oUNmJvaKhx3nKxTw7Pga0st0CTXPk+CAK5v/CpZCRiolp+DJj6j568z0ISByTcva
	SNqaELyWFVU35HL75WAd3pDcLaBbcONqNo1BPW7KA4wQAlubX/F2PPTLj8mku2Jn
	RgdsXhI3sf3CIdBpKW+UFljAWe0tCQhR/ut2ecWlNgLTnxW7rN9bao3Aqnzaomhf
	MvBnde0Lp/TK/w9wemxbTUZ+FhD6ukzytHcG4wN+geNI1SG86gQEK7CcX5IQIHq0
	ygDO5yE+oVcf9TT2SdvIQyoEVsWZB8xt7YJDFj2u/BqQMMJHXLuoLoDcDsGg09C4
	DkkaQnRKtFVg6Imcz4LSw==
X-ME-Sender: <xms:ar8xZ2EXkZs-RsWGGWTk7pNStf0HIdgNP1ZDt6DNXno_mzb3il6Yig>
    <xme:ar8xZ3U2KovkLf2uHloQFgBty-ZFt-XbEpsq4L_UMqCtjyQdg00oE33ABjDsHBUX1
    _-RfGx8_Fv6_LodJw>
X-ME-Received: <xmr:ar8xZwKmIs-Yrrnh1nKTDcBoRN-C-X9Ltz2J_SAVR72vVOnfHpN6uaekSa-3s4ELkW-jHnoTKc5uHGr1_502nXsBnKeAUUXdExmTutfcJzUsTNsq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:ar8xZwHnoV1OW7cGPC8Unz0QpzEQxc6P4BDfMWTqirN84in9eVz5Vw>
    <xmx:ar8xZ8UFqmLeWIPU2SBjmNpw0w8h1c4p45quKmwDit0M-74qDHfDxQ>
    <xmx:ar8xZzMPFmxVMEgN4cCq0Jb5c9QAsrTWRTWmHrKDA78aO0e5ZC70ew>
    <xmx:ar8xZz3crYb-gwu15MFwl-PNC22Ro6lLDqedw5c1i5B7KG0F8UalOA>
    <xmx:ar8xZ6zV9WS-aOm0LCMAae9FuQjz0GJnJdoDk9Qs1Pqbo3i5lHJInh_p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 03:25:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c4568e93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 08:24:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 09:24:59 +0100
Subject: [PATCH v2 3/4] cmake: use verbatim arguments when invoking clar
 commands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-pks-clar-build-improvements-v2-3-d4794d8d1b30@pks.im>
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
In-Reply-To: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Pass the VERBATIM option to `add_custom_command()`. Like this, all
arguments to the commands will be escaped properly for the build tool so
that the invoked command receives each argument unchanged.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2db80b7cc3c6aba840f18ffdc78d2cda1877d8cd..8c71f5a1d0290c9204e094fb266f10c7b70af9fb 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1009,13 +1009,15 @@ add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
 		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
 		${clar_test_SUITES}
 	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh
-		${clar_test_SUITES})
+		${clar_test_SUITES}
+	VERBATIM)
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
 	COMMAND ${SH_EXE} "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
 		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
 		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
 	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
-		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
+		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+	VERBATIM)
 
 add_library(unit-tests-lib ${clar_test_SUITES}
 	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"

-- 
2.47.0.229.g8f8d6eee53.dirty

