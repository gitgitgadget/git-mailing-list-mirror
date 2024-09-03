Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB11A3040
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354886; cv=none; b=Znq5c4PqavMfCWQ2WcLVfu9s7//zxYmt0ez+vg6QC2OZH6lMW+sd44JgmzCPvQ37Ob7yFYl1EaeDI7JGgYhqy8EO7yJkG+8phqGQYpFfgUM3i/R36lgbJuvQEirx3Muve1+q3ocmV+IgoWKylu9KK2ZbwNqVs6OX3U/FMp/aHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354886; c=relaxed/simple;
	bh=FXXuxYSoXXTmOqCu9/JOoPLs0iWFrFY9QF3f1J0O1fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMEqD0+A3Gkk0wn3UbxgcNcM5kEt5GYfSnKezulgXGiPSQAT22jRLIgWnkrRXZ2CB2GVBXj6dpzWwoPHzpRLO3B8hM7W+456SUe0NKj1Eb/AE03Lzg1nfmV1F/IeCLAqfhIt1wvM3YmC9LHbO6M8tdkkWbjYi5kMOtCLP6BIpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=liQGfK6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DG/LexWS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="liQGfK6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DG/LexWS"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 317AA138039B;
	Tue,  3 Sep 2024 05:14:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Sep 2024 05:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354884; x=1725441284; bh=ouoo1eOQI2
	+EdVuymWTaQ7zhb6dQtN6siuE9pR2GCGY=; b=liQGfK6+ErFnMwjQW8/Ukp+8Wa
	o/1oRVeWwysem7qv+CeVavHp/X13y2dTyZuSMarj3+K5m8lR/C9ual3Qx/kZlTGP
	ofR0U9xDMwBYCM65SY+tNNGAYDUPkZz/6UCfcKyPjfk0+D+aU4J9yZWXHn8bUIqB
	/nseJDMJJJV8GPxGSZZFyDsAF5lVilFEdirziJKyo03Z9Ek9iB3FZoEkkcUhIwy0
	wF4htBhK9685bxe7RQSKGXTFDXcE/EHq+avVl2JnoHoFNqIGrf0VIKzq30egWksZ
	6kNvCF1ur4l8FQNKRRGH6CloYi8aJTiKF4DxfDpNvkROudQQs2vSXsKRO4dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354884; x=1725441284; bh=ouoo1eOQI2+EdVuymWTaQ7zhb6dQ
	tN6siuE9pR2GCGY=; b=DG/LexWSmI8aRkuDRtdzMs50mi/U1JttzytKOtXv45KW
	RBKXcFpM/+bcF92cN+UFE/yYSNFmV/PeAFQoz5D/h55LmOakb4glp/4hTd2sVYlq
	XzIxFYEMcLIp68/iBqrG+RJgrv7Bo+7kNi+bBP5myONNWJXCnCZE75Jm/GwIPzB6
	yRjCTGc+fXjyS06b8zmQYLYNJXYATaEKvvsPs3pehPi9gaU2+DDoVcOeCrd7bgsB
	i0d9m7jy0ApfiCIgORbGbgQdNPDdjhtBLbsjGdbp4M/LpzzZKDEPoYTAco2mCFCc
	GRq3KsXpyBQ85YkSCL9uvbLhXxM62jo9VX73oXDsnA==
X-ME-Sender: <xms:hNPWZt0-1QrFVGdmB039rjU6gbUfn_Z7nV6Em8V9rzA_hTm3UEuSqw>
    <xme:hNPWZkFu-BTdrx6KEdVJXjWWRPPisffhCVL-EEuHOBlra4HCnYO-bdePdk7Q107Hm
    2hDH7SIWQwektsKDQ>
X-ME-Received: <xmr:hNPWZt6vIRoWCMvAacHlcUhtd_gfSMCEarV2Ha1Kcxx4SeHiFaBbMoDGsO3kvKm1Vvdu7eC20ygKhCrIPj0CTqz4vYqFcvaNk6IwNXevSGzU2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvg
X-ME-Proxy: <xmx:hNPWZq3B5E3VhSo-Rsw_mYmlwfW079ZKHNZXDsuZFR4m3TPGgfKccQ>
    <xmx:hNPWZgGpJ35MEAD46H-VKC6MRQwoGKZYEVPOGlx3u5KwkzuX0h7WjQ>
    <xmx:hNPWZr93jIQrKQiEliCRNyJ9T5wzfeNul5bAMjp4voARqD0X_QZeLw>
    <xmx:hNPWZtknFhzTuQMaW2JmjkRB1Cix2CQWPctD47PtGQZkQ5un4SxrGQ>
    <xmx:hNPWZrCnEVAtmx7iP5DGgmrCxp6zn-Y7QEPOFjP6e8j01ZfN7U2hr2DO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38e0b857 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:35 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 03/14] t/clar: fix compatibility with NonStop
Message-ID: <f24401f0a87059f4ff0c15ca0cfae4a899299b44.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

The NonStop platform does not have `mkdtemp()` available, which we rely
on in `build_sandbox_path()`. Fix this issue by using `mktemp()` and
`mkdir()` instead on this platform.

This has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/96

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index 7c177f35258..e25057b7c49 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -120,6 +120,12 @@ static int build_sandbox_path(void)
 	if (_mktemp(_clar_path) == NULL)
 		return -1;
 
+	if (mkdir(_clar_path, 0700) != 0)
+		return -1;
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) == NULL)
+		return -1;
+
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
 #elif defined(_WIN32)
-- 
2.46.0.421.g159f2d50e7.dirty

