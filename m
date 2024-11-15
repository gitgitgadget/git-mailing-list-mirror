Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD3188CD8
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655983; cv=none; b=DtL5FaqQzLWL0X0Pfgs5eRlMDcq3rZkpA8zKJ3BCHNSTV868WiApUD0UKLgivN4UDWnYbY08ipeQElmRIZRU3uBNLmR7NcJkLehzlyjWXPjcJ6oENCv2Ccgw7pC7JEPjPBydcuh3QHnPIyuoOl0V6hvaKTgrIarV7PCACXuP96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655983; c=relaxed/simple;
	bh=2mZAGm4JoENRDIuMBEfeH1qVSkNBq4X0vLvGdPIu210=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efEeRr8dLn/vRBVKk/bcJlp5wbzYp0U8A+q0mlylTuARMSAnt0zIUY6r+2tfOwhT/j5l/ikL6399faFhzHlXjE+fa3UpPZayVLVp4Cl3PhoerCB6nMNkCbHrqahTo6NuS+cf2V4Jb+AlVKY7wda5Dz7yAzmanzHk+2xPDCv3fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iECrwQkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QaKVHpux; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iECrwQkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QaKVHpux"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C066611401B3;
	Fri, 15 Nov 2024 02:33:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 15 Nov 2024 02:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655980;
	 x=1731742380; bh=+48lsCJLmvrReUdMRGy//XXBjy0Xo235FVVVuY1vgxw=; b=
	iECrwQkWEzrYN1AfXBTgwA8kY4/72dmIXWEn8OwcQkPGXC47ie1V/EEcTi8XfcQ6
	fiXklDLbiNE54u2D+in9t760TnzMeJsr98bAtIY4JqNvKUSsub9x1l7dlPlrVsnZ
	MbqI5zLf+AueMns3+6oa8Au9OiCS4d1ajWxMdAjk+0hJYdwijInczIP62Z/7Jr7X
	8Q8HlaNAlq/EahRprcxtA2OI3RICGyRqkdHUF+LFMx65/uqU1rG/UxuHnjAvH2ij
	EQUqYUf08sq/i1+jAMoMktbUxfTfKL7mySrct087cufMDj9xf3C7my/CZk9Ftn3a
	qP5j9K1V8vQZalJ7ATfBfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655980; x=
	1731742380; bh=+48lsCJLmvrReUdMRGy//XXBjy0Xo235FVVVuY1vgxw=; b=Q
	aKVHpuxIMrs/x2ZiBu9suiFwJrHPNhpJYBMQY+XTOTaHRaNcrfeMG0oJdkPDT1n9
	fd02k3H1ptELQyyrxphus0q2ggVdEL9GOgdqXgqr67JngqB27tUnFh8CW3wHH+5e
	P4uZm7ugi8KGqsNn7SqAf9SmVopgyxBGL9trLqYZwdYci1+SFys/rKSFTl+Uc/0P
	gmsdYZMX118lLogt0LJZVBP43yfmp/Wh39uSybnENO4JWtE+flJqCztQzGXatgbO
	ZWEoGEbDOKWXhq1cy4oNADMZ7BeOgWlBg1AiK09gKSt24Da1fgxkvZTt9fBU0nBy
	Pl1FAhZ3SLsuEeQzShBLA==
X-ME-Sender: <xms:LPk2Z7OP8a_eK1g088xq7DsrcK7H4gOIGXuLH0tDH4SZ0yKoNjB7ew>
    <xme:LPk2Z18d7-uhwS_Tg6FAFXCjljYXijs9jAp-nab2MFbU6LEMAtmzNihmiX88cjkJV
    xwnYTvyMGU1aWNt1Q>
X-ME-Received: <xmr:LPk2Z6QzJ7azMJYZI0LjI1Dy0_VoVzwN31xKSHiVf0mJBBoqTGnKcBaNUZaQ2AS2grH2v0ynqTvoCSpcNqdC4Uw3lstVQoz3GPCel2bxoLr14a778A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:LPk2Z_vAKd9pD_qxygoQ0U4mAce4QYqY_sWEj3ZVHv6BWkIgNz4sOg>
    <xmx:LPk2Zzdx0FWOAAO-nTDO2pbfS11nJXAlzR11f8MhSwUKMrfmn7TDoA>
    <xmx:LPk2Z706EmFs9mJ586iij-G5q4gTtLmGWARftUGNA_OQuSnFxWl78A>
    <xmx:LPk2Z_9hYjTQth5DWUp6aDfG-VT8B4lm2aHEuxITmRDDAWrncLRaZQ>
    <xmx:LPk2Z66RWLtkymFW6BIOezywGNQ9Yf4iXNbsrf925rkOw1SWCZ4DNFvg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:32:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 681685a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:32:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:32:43 +0100
Subject: [PATCH v3 3/4] cmake: use verbatim arguments when invoking clar
 commands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-clar-build-improvements-v3-3-29672bf65ec6@pks.im>
References: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
In-Reply-To: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
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
2.47.0.251.gb31fb630c0.dirty

