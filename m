Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0737C0E5
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898424; cv=none; b=qThT1LFAl2ZD3EfGplv7sbF8WxBZU6UXmfHzeToyZvasoUM3EjX30I8wqetT8Allg3U92pJaRqVUuQSvpxe66MnsIu8zbPxIg77wurs0oN04wW0J48XafHMNe8zeKRAv06vLf/6b0vcaCCiSYWweyrlX1dVoW1STg6d+k0q4K9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898424; c=relaxed/simple;
	bh=ZTJ5uVMB5tUOJTfCv/vZIOydimgAE/bnEuUKdZEvUl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEr9g6wxSEpPvG/aVBBeqeEVmMN1Ol9YSBm5CjJOsGE4mN2dAoA+0e+LXrOH5hYlt2v6GI3kA0GWaEb4luQIFAPiDNCZ2maZbNXxoS8nlQGtsm/iSi0ImUri/5uUYMfdA2PVrBlpDpDJMSPuX0XBH3Tbjx/46G9w02drqtB9844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LYbImJUl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUieinBp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LYbImJUl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUieinBp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1478D140022A;
	Thu, 19 Mar 2026 01:33:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 01:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898422;
	 x=1773984822; bh=4LEPWQtf17EtKp1zNQpjEGhWXWK0ltZjIOmQLQgTysU=; b=
	LYbImJUlf1thv8ZjgAsd1d/R74qL8pbT1DFHcUbIt/2aYncQJ0fuI2aN/5M75fIf
	eLOuuYwkAVDHE+KvrSHe8rRvAApBM4KpqWEtkDmyJaEzRC65mshPzpUYebdo/INU
	Zu+aAYjjJnEfWYpoyBmGbYRClxmIyxapwVT2S5RfovZtd8ppomdkM5uebIK4tHbf
	KxvBGS5no1C2cbcEeXLuJFaQV5CxWXD0tV6lGAQ2cSIAOH/pKrx9UrEzW5lE7V4s
	+awQLnK8beYB4Fh3am3T9lsY7AmSyVu+T6jAztB8C3U5zAwxgA4N9jqrqL34A+UU
	cTsLLWd11RoOfACfEPVWQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898422; x=
	1773984822; bh=4LEPWQtf17EtKp1zNQpjEGhWXWK0ltZjIOmQLQgTysU=; b=O
	UieinBpE5huMXPKufbhXPUhJBN5/A+7bCVD69BK3nlLdDqIMkX1pMIMiBSIKZ/8F
	PkCrw1w4J4d2UNllcQ5Nz6/alpGaHWKfJHDDvqbCkWGok4FpQyt3AX9P9vF4LA01
	0lduGCwPQmExd1Nqzb+UobpatjKhzh5ir++LJ/3cnZ9oyHZdVIQzSymINyk990go
	H2k7zzCT7f/GsIbAGkPX+fd5JcTMpeMIpIfInE11LmcdsddrftlqrT9DYYr4Fbm2
	iarjSj41Uu6uhYRAKSlbSLZXuu7+wRrbXGvzjW2uJ7/P70xEr57w47VGR8eTEojr
	AUhyczwBm0C/zYeYNWNJw==
X-ME-Sender: <xms:tYq7aXHLDat9jbOKQucYmRm0epP0O0tG8W9ff7u61T4suKdB6Hw4Fw>
    <xme:tYq7aV1PdEnSBPh316z30veU5IXxVfPb9nRazi0LpL9bklnr1zrAWJq7bpbYefZAP
    MWStbyPA_GVsEBLzM5vS6_2dqKpHQkrMifwj5ePtfhGTl_QtftO3g>
X-ME-Received: <xmr:tYq7aZMVpcrHC_FWk3hoxKsisb8UJ9GrYCsbS--CMQBjgFUzU4-Vq7DN1kS64VVWheQtLZ-i2GSGNbq6TvHaLgCGygzHREI5XgrCsLzgVE0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgusegu
    uhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:toq7aU6bLPuH2EndpbK_QWL_frh8DQmSgdcZClilVnYfJL162I5fFg>
    <xmx:toq7aT18pyu826seKxv-W7a8OfYAI82t2qiOD50LPexMwj5LmUt5rg>
    <xmx:toq7aVz1m3XypbAi82G6-7xU7j6S5fVyXx_ErNuLg_x09Qzv8KEkQw>
    <xmx:toq7adt6a3OOWPg8oS5B3LyK7ZPLar1w6dtjljx8sXlkpQv_Pl_HIw>
    <xmx:toq7aVJq56_F-bR0O_lCXlxs0QpT1lLIfnjeMMC-mP1W3g1YQZipW9CK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3310575 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 06:33:25 +0100
Subject: [PATCH v3 6/8] git-compat-util.h: move warning infra to prepare
 for PCHs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-6-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

The "git-compat-util.h" header is supposed to be the first header
included by every code compilation unit. As such, a subsequent commit
will start to precompile this header to speed up compilation of Git.

This will cause an issue though with the way that we have set up the
"-Wsign-compare" warnings. It is expected that any compilation unit that
fails with that compiler warning sets `DISABLE_SIGN_COMPARE_WARNINGS`
before including "git-compat-util.h". If so, we'll disable the warning
right away via a compiler pragma.

But with precompiled headers we do not know ahead of time whether the
code unit wants to disable those warnings, and thus we'll have to
precompile the header without defining `DISABLE_SIGN_COMPARE_WARNINGS`.
But as the pragma statement is wrapped by our include guards, the second
include of that file will not have the desired effect of disabling the
warnings anymore.

We could fix this issue by declaring a new macro that compilation units
are expected to invoke after having included the file. In retrospect,
that would have been the better way to handle this as it allows for
more flexibility: we could for example toggle the warning for specific
code blocks, only. But changing this now would require a bunch of
changes, and the churn feels excessive for what we gain.

Instead, prepare for the precompiled headers by moving the code outside
of the include guards.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bebcf9f698..4b4ea2498f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -34,10 +34,6 @@ struct strbuf;
 #  define DISABLE_WARNING(warning)
 #endif
 
-#ifdef DISABLE_SIGN_COMPARE_WARNINGS
-DISABLE_WARNING(-Wsign-compare)
-#endif
-
 #undef FLEX_ARRAY
 #define FLEX_ARRAY /* empty - weather balloon to require C99 FAM */
 
@@ -1099,3 +1095,7 @@ extern int not_supposed_to_survive;
 #endif /* CHECK_ASSERTION_SIDE_EFFECTS */
 
 #endif
+
+#ifdef DISABLE_SIGN_COMPARE_WARNINGS
+DISABLE_WARNING(-Wsign-compare)
+#endif

-- 
2.53.0.959.g497ff81fa9.dirty

