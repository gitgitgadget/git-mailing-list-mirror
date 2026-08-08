Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0DE2D8379
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206091; cv=none; b=Yl8UfQoxDBwD88zLwvm3KSGgVFmdqq9wfA1hzVTzTYXfWYlDqgWFvl4xnAGq0aOchwLksYapB8qTCct5KPncA4MjTDIvOPu7doh69gRFkQjv0xVVjpG4JhEGbTox0aKmsgsJySEtUdffs45/x6Mg1r6lyRD/IiGLdUwxT0uhkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206091; c=relaxed/simple;
	bh=GMiJtcK57PBFkxVG6RuiFWVpsnt0JRLX+nd0EdFVKpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=raR2uReLrjreuM2NvZJDTMiFaAMrnh6/MMNXqpRmtz6amFMiaSMt8U7O2JGJyU/JoDQF3a3AYX5CAtDMRskv3GkhIjt+6JtT3Zg4OUJkgkzVTfATFgt5azxwBKvDBSco8ZYmoA4OhW3UARsLp+mNdychAmxFRkvKw3qhMNoAqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hPcwb878; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2pPdWNB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hPcwb878";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2pPdWNB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2A6C7A0064;
	Sat,  8 Aug 2026 12:21:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 08 Aug 2026 12:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786206088; x=1786292488; bh=GMiJtcK57P
	BFkxVG6RuiFWVpsnt0JRLX+nd0EdFVKpY=; b=hPcwb87872CdIGr7a4wheOwGIk
	xHymXR4sIcbABgl6FCi7AJAoW/mCn9c/H+W/u26s708Px+dzVSm+eYYAvlHriaEf
	QQx4VSbzl8rWs8PHkpj5VBvr5cjn/lE3dNilDu5Fsw9Sn7q3IGvZXg4vRI/sslcu
	uSMJkR+EVnt7WAI2/6JDw52Svom5zMfvHPLudkzmtvlTj11pb1tNhm/X43ToEpWg
	UOz0ETWyiqUgsxa6p1nq0UpJgGm0MaoT9M3CJ8nOaOlOHFtVr9W0VLsoO2YgCGjn
	yN8+fzUm5+LRGWnbDppspJdZ3n2PZey7roh1/INO60ZHkanzoAnCaD6VK3sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786206088; x=1786292488; bh=GMiJtcK57PBFkxVG6RuiFWVpsnt0JRLX+nd
	0EdFVKpY=; b=Q2pPdWNBR2EeOuPpk7ajXylAWfjh7X+bYvY2v6FtV5i++em7yhS
	B72gVyoAjXVunPl4dCLRxpNPECDODbcMy9M6XE9CaWUUELOR0LrUEhoK/kNtI1v3
	s86XP1ONyshZmzGOWCTVBY/NB8omVvON1bw0PG1XFhQFyRGcMRpwVJR1ENA821oW
	WLDIRy22scBIw4V9fFKRxS0anz9SP9SQKg9gsCJnFtzr0IqNhcgdROtoLi6JAEeF
	UmOaXdeBrWLeK2XfSPsje04OZrEPZFHM284gTFkvw2v5LGyojR/vNSrkaE9UmIst
	MYyQzu4lkHlW0/HULdshMqrasbYeuGfBIJg==
X-ME-Sender: <xms:iFd3amxsqetAfvTMcB_2aQqJmPDKIuHSbdPtesLsukfW9-Br84CUOQ>
    <xme:iFd3akg26ijxhO4GlgN8O5GO9gDZJlzWK0xyTM5V_sPfp4RtHwiv1g0W990SG217t
    9JSgK0ZavjVoGtXGvhvesurbFURTt_NdiqZP6kYpoOKyRpmd9gj7Gs>
X-ME-Received: <xmr:iFd3aqmoIT5Q-luzQ3FhJAnvay6GJW_DDLkVGiWwUhfdVSk64Sg02ivccApo6omo0BWtvmdn9E-ef7VySBjqPlrzh-UOnhsbjw>
X-ME-Proxy-Cause: dmFkZTFi64WnGPkNZjBgSFQKL0eptdVGXBvYEg7LXi3bTeOVlg7mzDFSbmPUihfZzsGEtc
    cfXqgxis3VAJs+s6py6X4mZruYArXsC+PxRZ0Zcd9XZUkNGBwkvOSl4zADJsub3KPPdoVb
    869mpfy+RLMrvpDtKEVWOoR7p/e4S+I31D73DL/IaQaEx/a7SmOeY2rkQ1Pf3W2ITcpMva
    zDeZ0de0pwmn0V2itWXPGH1bDxAFGmemX+ae0qQ3j4TKpKL7qCX/MAXBLjXg62TkbH7axS
    wVYo4auP7Ado665qCB/GQ0hRf1UsPBZWJV5CeaRkefjznt2/hDEH6Tq+hMrmGZG6Tg/nbe
    jOsH6JAmwyJs34umJI7Kzw+x3Tro0D3+NXj6RDGIKzbwXR0Lsv3L6GfHxMLFpbzm7oTYJX
    Ls3HMXxLsRYCHkNESA0xSG7VNu/aQi/0UDtlzSz8+mWtNl4yXK0rGdNB7Qsve5iFrLfHT4
    gWJtOXAuCwBqYUIFzVLxFBSp9zWqbsyPShrytCAM6Hlp9n+jXKfgvwHGHLdfzXIOK8i582
    3UpGMCoUJ0G1m+mFcp0p9hi+tm4BqTCTSBCNrNx04k2igqrCMxD26iQS5Ejgud5wykiQaM
    Ki0r9BxlBQtF/hLe5Lq7klhZ7agGbrgqwWon1vz1u9vteBbNyXOuRDLUNBvQ
X-ME-Proxy: <xmx:iFd3aigUWEqfJ0zBNV08G5Wb_BIr2FLBTLc5qOT_ON2uRUJDuhAC-w>
    <xmx:iFd3am1ZMVZFrLpMtfTX-KnTt2V-tW9MIzP8ppqIGFwh0dDbHCFKKw>
    <xmx:iFd3ajJhJFJnpn5cDj2QHXbyh1OrXvr-f-ovv3UE3qlk_AiszQ-_0g>
    <xmx:iFd3auypwhI7Tx4_mgLU7N5ByPNLGQGjirulu_UioSPcsQ8Up1FEvQ>
    <xmx:iFd3amkaQldugBJsxozgTQNQ-dVb5Oy4NkTY6awHb9pM_zMd-QqK0ORP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 12:21:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org,
  chandrapratap3519@gmail.com,  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v6 06/10] transport: drop remote object-info fields
 from transport struct
In-Reply-To: <20260808-objecttype-support-v6-6-e5cdaf27a49c@gmail.com> (Pablo
	Sabater's message of "Sat, 08 Aug 2026 02:02:21 +0200")
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
	<20260808-objecttype-support-v6-6-e5cdaf27a49c@gmail.com>
Date: Sat, 08 Aug 2026 09:21:26 -0700
Message-ID: <xmqqmruwbn21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Rather than take these as function parameters, we take only the
> transport object, and expect the caller to have placed the other two
> into special fields in the transport struct. But this doesn't make much
> sense. The set of oids and results are really only valid for one
> request. There is no reason the transport would need to hang on to them
> outside of the single function call.

Thanks for injecting some sanity into the mix.

With this fixed, are we happy with the entire series by now?

Thanks.
