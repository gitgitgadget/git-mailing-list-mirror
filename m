Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD262931C8
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109152; cv=none; b=p1cNeWxeCE+TdzlwpBB33LAP2Ss4zxVRGeYUhasORRHLwbs8CR3E5mVqHmF9BHr3mU6o6imeVVjHNLJiKewIVZYnrn1I5XF7ZX5CEh6H2lVyGg3noyx3J858TxeUmFe4IJO0n1+zxPqjd1dRm52D8HzFDZUETLz2X4t4x85Ba28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109152; c=relaxed/simple;
	bh=v+CYxJ2qutBMtkj8lwMi92uLk+4y5PUIIpC+253e+rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGEWaJrdzoz4j+s8zulRXX5gtVC+aWz1ClTJi8S4fUKBkPs6XIBMd/DlYg6Y3Urk1RPabsW+Q9luwoilxICEKp4eqit0m0RUVXGpryQNmHkUCOsL3Qsu362zGzq5fq7gXzBQleQ5awp/8ABm5prpvMnlLTJ+F9Va0BPvJrBkGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1xfJiaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6CN0XJY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1xfJiaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6CN0XJY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B02427A0139;
	Wed, 15 Jul 2026 05:52:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jul 2026 05:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784109150;
	 x=1784195550; bh=v+CYxJ2qutBMtkj8lwMi92uLk+4y5PUIIpC+253e+rk=; b=
	Y1xfJiaMdZBFkDFF+FRZdRgh4bBTUliwDJyJkkojPwYKPnNK0K7kqU/AUYInKzkH
	xJNqqYv1WwBY3S5gF6Q8/L8ieXN5wxvhfEuPMXNWVViehgOdpueLShmkCz5vNXTD
	G0RezCQoHdFtx68umdiQ1Q3vvSeYSpdF9KUEwIx+m8F+1oCiWx3ShBsifSZ9uqAB
	jNeiCXG9GMoHRQqwdVSAW+AlqcMyVSJT2cCCVQBNGo7NVuyC1D7zOwnMl48QVsVA
	X3j7N10Hw0OmUXMhY+B6NrYIxtpGqmjrLn9tVm4Ywv93F+P8OxqvroAUD6iLN2ju
	qPLsGeVcKpng4oReO3ULMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784109150; x=
	1784195550; bh=v+CYxJ2qutBMtkj8lwMi92uLk+4y5PUIIpC+253e+rk=; b=M
	6CN0XJYhamG+yeYi5v1GKvw3b99dBuiOwrBqb1A95yFMncMsqLhteq5JyqxrvM16
	cXRQaipRP3pA3XD1tt2JUckkEJJSXc5LuFTvUScsKuJmj53K8xLxamzWh11rzzDJ
	IhD/zpi0cSC+rm7ejm3q9aFebf5eRNtxQVjpP4hpQF0oC/FHyUBiinpDsHSSThgY
	FOnV1VJg4gZoQfvCCiXkQHY6m+wNRod6h1GjPdNvqUNPpDiYYJhlM4oD0FCMefR5
	lszgeTbp5yQycIabUT7AS27OjTUs6bGfCw5i4ONrzWj/OOexWUuPgFMApJLOHUrO
	nz5oKLQkHTy02J4ZGVZBQ==
X-ME-Sender: <xms:XlhXagkExzahlbXDgofLsGaKnhl-afubGTn44yO8o0ow4veC5ogg0w>
    <xme:XlhXal1tPH-cyI4bK2dyXFCBOWA3urDGDLrO8keXgWUm0AGhHuZ3Gihny3ScG3HCU
    _xqW9mg3AMhk4hozTIwl4WlEDTPRbGEW98OkEiLqMuyNTQp_SekG2E>
X-ME-Received: <xmr:XlhXasQUASNffVKtFQcitX6baWAdh-Bf3xSdTYc4U-lS4LtxtZJ6dxZ9TWeIuEDDR4YqCQS8e2sSL1PheRg7-SCTowj3myiBQcsBo50DnGk>
X-ME-Proxy-Cause: dmFkZTEoVe5xU2vXSaVceyM1x2urqYo29JXeiCsvKgxPeAdRonQC6Ilv+UXOzYKmFgLweL
    +YH+wwUeZOECvL4MDtyuZRtVAiZN+btTM6nG3OAlf3Pxo5RGPtilsWVqJKAcETr5w/JP1L
    kU0CFD+5wyCgtosKDccFRpM6n6K4tEFF0ov6K+79PEgheLalgyPskSuz44mDcdkfVB8ZtL
    61nvhZ1b+MbUe8yKW9hktxrVmrMxhAjoxpBbUHgvxm7Ygnu0bGwtgdcqGmOAi9yF7c2P+e
    EzIw3ITFoMfG2D0TBx4Ee34/cc6Wpon/9SFC6eOPP72H53ENe23rg5cHwZ4fDpJANyGIsv
    O9BfCQonDSa0VvdLTygtsg52blho5qtg736Dj9/7ciNzgTi59V6B2X+vnhctBXsbUUFQd2
    eu/Q82s+LPw/W41mQwAAC1GJEliMXYD3joaEESQq/UCKUtrtMGSpj+tFiATnKNJQdrxmDS
    mUQkvcsDHux8xFJ6UTN2b6pvs9hfH2XHeWgY4tXRuW4MNL1g5eFxBxYVSKFx1YbGb2BfB/
    8UA+APL/xpMuK6XTc59wIK5cCjw8iIArxIOIFeksG/NP4bBR9VU7Q5c/kKeISFdLb3FRkD
    4ZMWhImJmUl5tStI40WvGFJyiOPr2d4STP9Xw7s90bhTngS8FVh8zSo906UA
X-ME-Proxy: <xmx:XlhXans4qCR5XDXPWUQOnM3e4CLV0LY9ZFUX_llIam1sgidNcn_MZg>
    <xmx:XlhXahYMiWP_ZJ0yo0YvTFagxbnTVVendrWf6XgX0n4AIwxtVYJZ3g>
    <xmx:XlhXasvUFVgWDDV2bb5I2biPh5ATNAnxDfQ7BqofrEwtmTV4JeIDeQ>
    <xmx:XlhXajGvMi8jlrpp0ZP4789x_INwlbl12CWsNwUjDarwrfFc1C19Vg>
    <xmx:XlhXar_KQ6Nsym65Kbid8L0NRQ3sQx2JTpqem51GdPUr95DGdrRjTY3C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:52:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba317be5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 09:52:29 +0000 (UTC)
Date: Wed, 15 Jul 2026 11:52:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] use
 repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos
Message-ID: <aldYW4TPUqgDMRcf@pks.im>
References: <20260714175956.54601-1-l.s.r@web.de>
 <20260714175956.54601-6-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714175956.54601-6-l.s.r@web.de>

On Tue, Jul 14, 2026 at 07:59:56PM +0200, René Scharfe wrote:
> Apply the config setting core.sharedRepository from the repository at
> hand instead of from the_repository.

We only do this for a subset of callsites, apparently. How did you
select which subsystems to convert and which not to? To make this
explicit: I don't mind a partial migration, but I think the commit
message should briefly explain the reasoning behind it.

Also, as you don't get rid of the old functions that still implicitly
depend on `the_repository`, I think we should have an additional commit
on top that guards all functions that have this implicit dependency with
`USE_THE_REPOSITORY_VARIABLE`. This ensures that we cannot accidentally
call such functions from other subsystems that already got rid of the
global dependency.

Thanks!

Patrick
