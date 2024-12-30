Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287751A83E2
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568655; cv=none; b=CVdJW2tYNbi91/6tWtkv1KhhjTve8HPCcxrCox+aSRdjAh4iggD7yRe768WGlYm6/8o0ZgqBe82KFCrQMAmFpNWjOGIHowiTneJMDs49wMefbk823nokq9yAVWUVSfItoBn+MNFmsUNY4ipF01JdoQKEovUM6SUkGzL8EVNAML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568655; c=relaxed/simple;
	bh=WAN+UWQzu0fCPb8+jC5YoJ5laYQNy7ycRMBjwaXmGMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHLJNAnCIbihOP6q7Bgl6F/0tb9Y9cnuW+o7rrqrdMhRQfE8XatA8KBxg3b8DUTsoB9kVUV4q3QKDL4F8th38V40xhUeoEHmwI7ly45EwcXEiM9Xp/XMwt6sdYJotROd9OBGPDl0ZrOkWL7GHXg1YJY9uSmcK02ecBAeKv5/bzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CsYoGqj0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXpM+pfY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CsYoGqj0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXpM+pfY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D999C11401AA;
	Mon, 30 Dec 2024 09:24:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 30 Dec 2024 09:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568652;
	 x=1735655052; bh=RMm0GdWELMDeFfoUmkH99rOXjzON529bNbj3pR53lKo=; b=
	CsYoGqj0VaVr6wS6gey02qSoDEzAO4wWnUgTuZ1tYf2cqCogXF+3bAmJvpn0JJPx
	3+bss0fp96r9VeShm5kaexqPLNmDyxbX7VQP0cr6EpKfZTgkIrGlxiOIPtKuM3LT
	TNmBiq2zVjJ/K7G+KwivOYToIDZTh8lPz4O3yayto2A8p9hifiwa3N5DnHgN2VVu
	swMw3tY3whjotmCNZ/buUZ+/C9PymK0wk5fCeQe8Rr0qY7ke10S8G5nKFpgWPwuO
	KuxdVay/r7OeabJu4qyWtyMuf4WY3vCZctCrFNWLncN5QELgkRfoxT82mfeBgFv/
	/yr/HpkMB2svjSTAQtrkBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568652; x=
	1735655052; bh=RMm0GdWELMDeFfoUmkH99rOXjzON529bNbj3pR53lKo=; b=T
	XpM+pfYvNL/nN49vV/A7yXjTqmO8jocjcCLKEBKYiCwFTjYvGB1a6eIEQues4EZ3
	w99dUecyg0pRpatwrqYQ+0iP+Bvg69GR0kACDLLHb12ZZqggQLlFagBFU4LhG/Mu
	7KmkwNrZ23IvxJx7XsrEcliNIIm//aa8+Sem81u1NMO35wfwD8KjDwRCVLhOfgWG
	LnbiZVOkhejRreCCRstZpMufgeV3TlwHw3qabxZ9m4/fghxiNfH46vlUyjR50hw4
	ZDhILsH3ygzIrakEGkz0XLCC58CcJO2u9Rt2+sF5tnv3iAXer0etnsjnmSwlXzYr
	NsK5G6feeeLAFljGVb5/g==
X-ME-Sender: <xms:DK1yZ-1DHhTKBC4rmQ60OkToRRPsrNGTizkTWLa4al6DsK6ugfuXQw>
    <xme:DK1yZxH2Wy6Xcur7eOkWGf6A1LXtyAn4_dyeh7i2wCB2Clm1Vi0MUEfZICkEnKDDF
    xt1sWyHFOAnWALDaA>
X-ME-Received: <xmr:DK1yZ25jR-nbOT5KqcwSaNOTrJOHvN4dzvcMki2iEg-IiD3t26Dd_3AdaHqlR4Wq2B8t0mBDtZ3KYf8gDiwMSL1m6coqGsmGupat2GaMuMtrhvVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:DK1yZ_2VBcmXYMzsK9gcBTHrf51HoPU2mziDCupSMzzQHpVjiV36RA>
    <xmx:DK1yZxHvoYPXOTmWBjWj-9L2abEJfAHyBylT1R0cJMj_RMq51-X7ow>
    <xmx:DK1yZ4-sTiuHcK0r1EpeTY4teMRA85uGqjvnyNgqR0UJr85sPFanHg>
    <xmx:DK1yZ2mE-adrCoTlNtmokdlkUDHlDhbZAaCm-ZrmxneLlE198stg3Q>
    <xmx:DK1yZxB1pBn7nZ6lQj_dThK3Z36UV-sIlHI9GTsw5ZIpQF_6GO3GDY3W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 708be0c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:03 +0100
Subject: [PATCH 03/10] ci: exercise unsafe OpenSSL backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-3-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In the preceding commit we have fixed a segfault when using an unsafe
SHA1 backend that is different from the safe one. This segfault only
went by unnoticed because we never set up an unsafe backend in our CI
systems. Fix this ommission by setting `OPENSSL_SHA1_UNSAFE` in our
TEST-vars job.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index c4a41bba0b84df57f6e60aeac2de29dbc0e27dc1..76667a1277720d74e09e8da227b5e0832003e0e2 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -17,6 +17,7 @@ linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	;;
 linux-TEST-vars)
+	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_MERGE_ALGORITHM=recursive
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

