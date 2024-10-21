Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F241EABC2
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508208; cv=none; b=OFZ0QicpSEASqkfWW53RnI/HFrcuvESdTpniPRASxeqFXoQBPGhHobIoDKoe4fEt6vSDrq71Y7b85fSLPGQb9hvV3QQ/fUPbEhKRdkteU2RNTXsPI0xWbsq8mGgXlVYmWM2Ri97aV9c92qSQTa6A70ozjInyGRTj5YJuSGKo+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508208; c=relaxed/simple;
	bh=Kl0AJ4n9zhg/y++ngEQ4g9zCh71eOBfwRGehyqJxUVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLJaxy6ckRtvsamTSnC1zcN0ONy9OLb1b03lnAj6nDDxFJrDBe2ij8TdtRBu1t5c3azBk/0zqgP/cgfk4mqRVFIbVX/45hV6ld8j7I2PBiJAqHc+CfoNKbT7cLRHcK9Hd/IHDzw8V43NWgMFLul/4HuJH9j8lEjKQwL05lLEL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NXikoP3p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bt09MRJR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NXikoP3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bt09MRJR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 734D713805CA;
	Mon, 21 Oct 2024 06:56:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 21 Oct 2024 06:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729508205; x=1729594605; bh=zYLO5UFxdR
	kmyC0RNarrzCBBDTJNtE+GRF9vYzMzkMA=; b=NXikoP3p6bZcNkFB7tpBt6BbiQ
	BMLrzC5YhlMXyhIkzV3LddRJ3M4KFSmKJW5MnVKcgEiClSOksQO2B3YzhIb9AHh+
	UvFWNVQacfVuNZWNxFLRfkRbA4sFVOgSST80oKLQ0PC4KglHH7r53OzMwHaj335Y
	gEua2g32wHfkg0w/2mL/POtnq+B1vVzP/8SCwNXxVjjuWwIvKDsHPxJcC5ngKX5o
	460kdXqLVM2ncxkk5EiBPGjqtYc4rvYQ2R2l7rPY/ZBvw7zubCztQoR+k1HlEEvE
	s+1L3ZkcCRVlsWs9v8NKrLhoOl1lGMyWmBjjSpunsWwmhTNE5y9jCb8SopaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729508205; x=1729594605; bh=zYLO5UFxdRkmyC0RNarrzCBBDTJN
	tE+GRF9vYzMzkMA=; b=Bt09MRJRS+1C1lQMQkl0fO37c/lGsPcmkHZywDuIbPat
	3yfhEXD4APvJ8GgWUWfkXIrAnhGg9XOfVCK9ul7dVAl8lu4mm7tgzuQgbpe7m54R
	M8K8yylyuTJPo0okWK6mvLo2Ic/5GXQQWgqjufkQi7pP+7SfV2NRjrCnYAc90p0b
	CVOgA3kgILfwKV2Oc+FA892U9AR/oSDPacWpo/91npe786KwD2Di7sxreXCF0IRW
	QOYROrp2r7XZ/szdsInpNrCnw3ZaefLHwTfN3RVHRKQn8lU6ezYoLl6SQ+3D0GPl
	AEVp8ip6ranLV2C17dx1x3tGRk3J11Wh/XN4+cKEWA==
X-ME-Sender: <xms:bTMWZ_yxwAyWzvnAz9i7MYWyTbvJhSofWNY3Jpj2cYGtLMIkldeyeQ>
    <xme:bTMWZ3RMOnJEWWKz2w1Bt6auM7BeMWnpsYo4Woh5oYmqfLs4XnEm0mmnerqgChWt8
    g8JvQSvEmY9TgrBKQ>
X-ME-Received: <xmr:bTMWZ5Ud0w3D2TV_W_pVOXvMLfkRVOEmV5QnH3Ag6OxGj78l5alA1bla_oYzPoa1auwkkNJ80zhimU3-yGc4ud_bxh6AnzJNo2NjQ5BK0Za->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggrgh
    grshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghsvgguvghnohesmhhi
    thdrvgguuhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    gsohhnvghtsehgrhgvnhhosghlvgdrtghnrhhsrdhfrhdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:bTMWZ5jitk-EcqOALpEPihAO4c6j5GBaiVeWZ_GV7R-ZFu5Vryb33A>
    <xmx:bTMWZxDP1jAfUdL4kug2BZpBbI1UVjRIpRc30SH4MQyxYMdco1TFyg>
    <xmx:bTMWZyImJQ1MgkU8-dM5M_FlfjJTf-CoVzSdNYFS2hF4k6rVvxY_DQ>
    <xmx:bTMWZwBaCQ-W45ujumyS5dLmwsyNDbCA57UNZ92mM_kElZE71e-HLA>
    <xmx:bTMWZ15Fz3el8EOyqoFErpDovMNu2ivIccl08sObrnmE79gFvb-Ts3Cc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 06:56:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd78467a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 10:55:16 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:56:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 4/5] cmake: fix compilation of clar-based unit tests
Message-ID: <a30017a4d8998e85915d959c16f181a8d4e813f2.1729506329.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729506329.git.ps@pks.im>

The compilation of clar-based unit tests is broken because we do not
add the binary directory into which we generate the "clar-decls.h" and
"clar.suite" files as include directories. Instead, we accidentally set
up the source directory as include directory.

Fix this by including the binary directory instead of the source
directory. Furthermore, set up the include directories as PUBLIC instead
of PRIVATE such that they propagate from "unit-tests.lib" to the
"unit-tests" executable, which needs to include the same directory.

Reported-by: Ed Reel <edreel@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 62af7b33d2f..093852ad9d6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1042,7 +1042,7 @@ file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar
 list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 list(TRANSFORM clar_test_SUITES APPEND ".c")
 add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
-target_include_directories(unit-tests-lib PRIVATE "${CMAKE_SOURCE_DIR}/t/unit-tests")
+target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
 add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
 target_link_libraries(unit-tests unit-tests-lib common-main)
 set_target_properties(unit-tests
-- 
2.47.0.72.gef8ce8f3d4.dirty

