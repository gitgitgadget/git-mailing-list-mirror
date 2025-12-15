Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC8320A0D
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765775671; cv=none; b=cXBEWWMNXo60RU34j3AQNO40QVIdBlfeFWhFoTExNMGJNqkyXubjFgj6Nqv2ChGiVqXhTY0kRuM83fbJTjPDZSsq8tmwyY/L/ieUhsbAB/3FXMY5cTmypS5Pqd/4DVHBgY+/jD02jZqmuy4NdqTCxyiRVnlYkzTnYyb6DExuBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765775671; c=relaxed/simple;
	bh=QDTvvfYptKV/qeGFvzL15XsmmOKMyIoEU3r1VXsTZRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afeyr5RbZrjB3e/1pMzVVRbBkeH1KhR1piOByrq7w/8jz6uyBMWA8X6Qmm3iOg1DjPkorGBGdVwSw1J8Kf5czjdEoTfTWuhIE7i4f02Zfcq8Q5UZ/AaE42ppglwj+3bajU+QW9tdVUJUNbDo3vwoBjEbNE/kDsCD9W4M5FgQQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fogTP2qk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/afnoVi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fogTP2qk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/afnoVi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 67738EC00C0;
	Mon, 15 Dec 2025 00:14:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Dec 2025 00:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765775667; x=1765862067; bh=B3cB9pxCKP
	OFNyj6aQYTG+KVqFFzEI2JjjQFQoJxWrA=; b=fogTP2qkt7jd9PEuFnSw8W/TkN
	37hc2iC9NWJ8J7zlPPV4xR+U71uHUP55dBrqSPX1c4R2KZwYjg6GpLNNaof8enVi
	Aq9LQBD5FLxA6Mle4lEFuf53A1Epm1p7cEKd3PDJIdcPLPRtOUedrcRwhkHCRzKD
	eO7aBhIySnltgt3SnWmt56dKwYrml6FFMdPzEfI0SLixspsIeTGK8U9Z9H9YEqe2
	Rirz3PlVJDaRTlvqjdPfh6BcjsiJ/AC3pB1Konw9bT4+YkqY7LZ8pd4WX1bTQsgs
	c4E01n4Kjzlug02rLXFyF2Sz5ij19x2GiGKUehrf25WGYWW8rAxIbex1q9bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765775667; x=1765862067; bh=B3cB9pxCKPOFNyj6aQYTG+KVqFFzEI2JjjQ
	FQoJxWrA=; b=G/afnoViCUSCLYDx2KfU/VGXni7CdOB7CXgwIoJaiIiOKSqmWmT
	MNwQR0oi+mphW1Vme405DOBs5PD8QicfV2M2a8WQP2ri0urZUojQqkieg64CnwZG
	ExXZ9O+YIss6KWJN4Wc56sdhmiF+itY5Q5xrHfaBhjkrp4C352nETRxb6HVpuRyu
	GrlO2SRkNVfMxSwsUEho+0BugzDcebOz+oDd39t2dhp9VWIz1+owuXweXkdpYg57
	mllW7VGEIrmwda/2b9z0eHN1BJIb31YV8ybIjole/WBa1brCpQGOsyxQmRkqOC+W
	QOquSi7O5w1+Q5mEYYAH4ESbJdMK2IQClpA==
X-ME-Sender: <xms:Mpk_afAw8wAPwS-8pEv_8NLCz2WlzCz33N3HO2kFJ8mlTLX3PN2kHQ>
    <xme:Mpk_ac9tldSAsZ6RoXBI16I_D6vLTlPBhnkkWY63ALVCGeA1OPEoSXfHJhC34pX9N
    7x1BTvTcrolC-xWxK8CTvKhR592ai-TsrMLZ-FBukDfABxyMRAm>
X-ME-Received: <xmr:Mpk_aX_DmbXWJu1fMlVHkARCPe1fgjWounAsvRuWSS1XQAWYb4lVCmYQd9AL8s4Ta9XkWN404wZEd3o2JhgXbRNfOd19q36mAKRurNBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:Mpk_abfa-rtWp7-1RKiF6LilcG81VWAkUmpbr469rQqSZzF1QwEmww>
    <xmx:Mpk_aYEFZSdnIBbhnuOYXrZ9vZUJdL5MkwTE0s61BT2AceSDYaDVVA>
    <xmx:Mpk_aRe_coTSGE_ByaobO1Oe85njjly2_HTyR33EQXys4FKs0H3xCQ>
    <xmx:Mpk_aaEQkQWaqS-NeX2As3Y5sdMrp8L_SRwEKJsTzEkH3ysSrbqZ0g>
    <xmx:M5k_aflVkQo30uHcDCrxmWvcfqYP9qCQQHPERZbE4rHxeZ3hrlp9hheD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 00:14:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74a6ee73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Dec 2025 05:14:24 +0000 (UTC)
Date: Mon, 15 Dec 2025 06:14:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 1/2] coccicheck: emit the contents of cocci patch
Message-ID: <aT-ZLICiwcX_eAgn@pks.im>
References: <20251213014628.3380826-1-gitster@pobox.com>
 <20251213014628.3380826-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213014628.3380826-2-gitster@pobox.com>

On Sat, Dec 13, 2025 at 10:46:27AM +0900, Junio C Hamano wrote:
> Telling the user "you got some error messages" without showing what
> the errors are is almost useless in CI environment, as the errors
> cannot be examined without downloading build artifacts.
> 
> Arrange it to spew out the output when it fails.

Oh yes, please. I recently had CI fail and wanted to do a similar change
already, but you beat me to it. Thanks!

Patrick
