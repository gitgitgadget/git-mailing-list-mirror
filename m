Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491B291C3F
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886538; cv=none; b=KftK73wIXQDdJCswPH1oHQWCbrVFXA8aje7Gh0Ac6Q0HC6SgOReCqWm0K1lp8RiuNdHPfu8quiH0MW7UDqXzj9EG5M2qlJM5GXR5IwBxOH5ug/1Jf17nUI37r6RecZCtINK7fMYZo6H1M9JkumcJhBOs4p3RVvW+XOTu1CD/yHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886538; c=relaxed/simple;
	bh=KaRCT2DzWsbpWEjPTUQ8IBq9dr6I0PfvJNwTSrbLD/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0d00Z/L84OS9mLg2l2vrJXUMSCX2r4hFNdHxK6OA/nd6S917X2wvkkoXDSJxgHiXZ+MpmAVt7tVvO3+UbZmvl/KgfVnpIr5d59rs4m4EohHX1HOW1ckSelndoxOGs9pUCgGUyIJ2eZM4XJFOvze5ka8Scoof29KESjL2CCToaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oSylRj1/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHiIKA0d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oSylRj1/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHiIKA0d"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE2531400A7E;
	Mon,  7 Jul 2025 07:08:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 07 Jul 2025 07:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751886534;
	 x=1751972934; bh=eOsCKCmCJFGGlhAT2aMoN6UmYIPWWYsDixu/IsqwMtw=; b=
	oSylRj1/1qXV0boESQit1ALAG3jLPIqwCi+rgUdkpreq4k2Hp7oEGeuSkq+aBD4q
	qAH5Gsyxg2KHDBysA/OrR3DASHeMkkcvUceKPGBFChga3Fzih7AlfArHskGAvhkN
	cuRSWaYAkDqJJtrUjTDKV9e9dibPd5KXoQr0cQxI1jAy9YW23gCVRo9pIxdAY678
	4fWSD/W7J1sl6hMQOxX8wlCo+nFqO54uCMu04RuCvsfsrHSZr4m9u2i4KvwA7Nba
	MpXDOCiS2KwILR3NaePpkeGTvMNWO2k7OgIPaLCRC6ehYPIfyVivMVD+DuCenKxt
	zZBZGWi9F6xxqy2yO5n01w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751886534; x=
	1751972934; bh=eOsCKCmCJFGGlhAT2aMoN6UmYIPWWYsDixu/IsqwMtw=; b=Y
	HiIKA0dzgZcPLU1ZtDqLoR7cy8kZGiII7q4bNkKwbx3rjIHH2eq4s3frbXSlPBAk
	DNptwemxhkGcBXwGUDVT8RkHIiANQ9/Nn4JRAu7K6x+ozZGKMUkHITbcBG3/ghSG
	7U/RScIcclYtdTyaEkB452PZjP5DGUSeldEMAxv75KhlBVD6y+Ows2CdvYGr4NiR
	+bN6O8gpYnUsZDb07PhzcgAxD1x+AFTqTmrayk1rDYAV9evioVFQepboRL4njnvV
	cSYOdAnI/YLtkudaoPIP1ZTakJJxDxabczJjxzSQTfwX49c5jixwtYudcxbyR4OC
	oxWrFyddCsYaj5HWBXtmg==
X-ME-Sender: <xms:xqpraMk93GDbVsawY0Dma79SLIlvrwd3NGjFj8Xw8_6wjarn9Ob9ag>
    <xme:xqpraPHsEpXceT6wzlPloYxkodRFtCaU_ReGC3wPdsadgS1LCCUajkOlJ0wl0GDvO
    8YwV_m0HhFG5FnGJg>
X-ME-Received: <xmr:xqpraEHs5c7bsAXokyox2mvlt0I8fJzfeVCGUM3Q5MK50JO29WI045vw3grOYnibnXM-jO5ES5YR6oZaz3IKtYwKvqHySWcK9IIkjoyy0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xqpraEN5dT6Q6uAzqXBT8Dtz5M888HGP09MyRW2wMAvb4sBujQh_nA>
    <xmx:xqpraLFUTBFLsTTiairYHGeiihtfkXlquLDR3E9bObowr41zw-ideg>
    <xmx:xqpraDMflvAA0p_sIFfUgDbbmBRMjnAbvVhMKqRI9O49wP5mSVI7Fg>
    <xmx:xqpraE_bJbAkoCzVu5dvhNvXN6F43onOmbX_bGBw2Fvnwc3gFsC2Wg>
    <xmx:xqpraLuYRVwOhAIYZ7A7N7h9WjrVg823yEaq-y4NbDf6xwIWPOP3aIrZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 07:08:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c96f343c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 11:08:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Jul 2025 13:08:33 +0200
Subject: [PATCH 1/2] t4150: fix warning printed by awk due to escaped '\@'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-b4-pks-t-perlless-fixes-v1-1-92b2de1c3dd0@pks.im>
References: <20250707-b4-pks-t-perlless-fixes-v1-0-92b2de1c3dd0@pks.im>
In-Reply-To: <20250707-b4-pks-t-perlless-fixes-v1-0-92b2de1c3dd0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 6aec8d38fdd (t: refactor tests depending on Perl to print data,
2025-04-03) we have changed one of the tests in t4150 to use awk(1)
instead of Perl. The test works, but at least gawk(1) prints a warning
now:

    awk: cmd. line:3: warning: escape sequence `\@' treated as plain `@'

Fix this by removing the backslash.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4150-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2ae93d3c967..699a81ab5cc 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1086,7 +1086,7 @@ test_expect_success 'am works with multi-line in-body headers' '
 	# bump from, date, and subject down to in-body header
 	awk "
 		/^From:/{
-			print \"From: x <x\@example.com>\";
+			print \"From: x <x@example.com>\";
 			print \"Date: Sat, 1 Jan 2000 00:00:00 +0000\";
 			print \"Subject: x\n\";
 		}; 1

-- 
2.50.0.195.g74e6fc65d0.dirty

