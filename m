Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B111922CD
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162763; cv=none; b=pr8Il4vdBU3bItM6TSMrOYoyjdm1viY8ymXKPnH66cUjQGTRdaUdEqvRoeiKMIsMN3rpGJBhL4C85lubPvNyw/bHW9SFuibRzFe5M1Ts//GVi64t/PMfVuinKjf/Cv4nL/NyOs5qou2fhKjlogcsq8PcUUDAvhmzUX3WUEsEn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162763; c=relaxed/simple;
	bh=bclwHcx7huN5h1iyclJy2PECO3tLbMMKUAsR0KtdcLI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eastRCUIJhYeN+knh+4DG6ppE9k+biz6qi7N6UfEg9uXwYn/fxg/9L6bDzv0mAee6C36avP/1jlm3lYvJsiP5LYFHL/ElbFkzoGBePRpzHwQYB1bsH4q+w93DO3e6Y0Gzs1E539VdE7oTn5NiT0qD5FOmBoAe5KTxpufTHhDuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MMN61gml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIU6I9Eu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MMN61gml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIU6I9Eu"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id DFADF138FC5F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:06:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Aug 2024 10:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162761; x=1724249161; bh=doiCI79cEh
	SpG7JmnFypy0mdIJQscTnHKAcvZ+VcjRg=; b=MMN61gmlUYi5HBERM7uoTT8raB
	zKUZJ6jR6qZUJMUi4WMhSSxgoSIllv+ev/QAXYUCzy4An4Dxuc6ax2lku+EwqWKQ
	NBHp3aA6zvC8mq3vLYJqDbXtQYCBmR0TMIUbSoCRsuaRLCJu9yK8dZ2fBRW3Ymdd
	B0iAz+JtgWR6maVtDaWJY9l0tBguTOO2vWvTPhVm4tpb1PIWIzMK3vFRqNim9Ksa
	wvIetb5fQLF+7QlbP2zBxL96fw+fbUCrLUh8bT6Gj1mREcrrgZ+A6/LHN+01B+AJ
	lic+U45BSZwo3yaniOrezeoAxP/nZp+FuPDCmX3toB5r32iZ+2wn5i+q96+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162761; x=1724249161; bh=doiCI79cEhSpG7JmnFypy0mdIJQs
	cTnHKAcvZ+VcjRg=; b=kIU6I9Eu2HkZJgYjaywWiiweRr68Gay3YVsLYmkX/Nk2
	CiEefaVDuZhQ/lSPRIs+c/VoPI3RDykZ3Oi0iSPS4WaR5kifUMRAl6+pHlE2uSLU
	4WV53tO+0FfhyjfOdtbmf431OhvfBY6kh0JGPa9fn1Uoi/WKwx68A2vjQB06OBQR
	ViOUq0yNtwwiK5KMe8soc2kamOdI4VxYcACgYMQtk8XkArEoykG/HOCKtJfHt00g
	mwG0/DG6T3XGRFJTkZEwh06fOvUkIqKiHEjyw2NHVPiI51supFGU3vko+zxgbJdN
	QUj7WOrYP1FtusLVfMsHvcJyffZzQ5l1X8CqRn+5wg==
X-ME-Sender: <xms:yaLEZo-jD4musP35uErA2Vk48OpQK8peTxPpjnVdYJx4h7tJ-8U2QQ>
    <xme:yaLEZgs6ZXpOKnShstJJrfwqd5PhrfuG4ZyN-XqYQSlF0xGsvMGPnXQzeY44X13yt
    Mza-Jv0wkxDEHq0hQ>
X-ME-Received: <xmr:yaLEZuDwwxLfey_EZDHDAHooRg3wGU61S470TdmzKPSyDmuQvmrd-LJhqMEw4A5DqkoJPoyOSlOruYZ6h23ZUpIclO9yrNUaZ9rhqgHQ_C60VY3A3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yaLEZoc7Ops8wtK6lMCKlR7_BU3cp2KYIKFZqMTtmO-cndp0JPmIJg>
    <xmx:yaLEZtNm_pcOka03eq0P8DSt9WAxGycYtWXHWb7rRyd6jXCAjsNmDA>
    <xmx:yaLEZin2HY1cq8OojG1xVx6FRbiMSGpZvSjEGyyFmWMlkliAuNN1aw>
    <xmx:yaLEZvs2VO91TGX9zxeKVzk7AcN14EvPSS7AdapOE1mvLCzq52cSZA>
    <xmx:yaLEZr2QVLzYWo7Qr-50dXiJr9rQpeayc70ZGyzKBpClr2R7pvquUZA8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:06:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9bfcdff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:30 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/20] transport: fix leaking arguments when fetching from
 bundle
Message-ID: <b72f7d1ee394291a018061c91222ea17a99c2e53.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

In `fetch_refs_from_bundle()` we assemble a vector of arguments to pass
to `unbundle()`, but never free it. Fix this leak.

This memory leak gets hit in t5510, but fixing it isn't sufficient to
make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport.c b/transport.c
index f0672fdc505..da639d3bff0 100644
--- a/transport.c
+++ b/transport.c
@@ -189,6 +189,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
 		       &extra_index_pack_args,
 		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
 	transport->hash_algo = data->header.hash_algo;
+
+	strvec_clear(&extra_index_pack_args);
 	return ret;
 }
 
-- 
2.46.0.164.g477ce5ccd6.dirty

