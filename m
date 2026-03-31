Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690F3D6CC4
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957447; cv=none; b=gpUL2McPp2CyfjBp1iFLxgvARt0GMSbyxXV9og/JRR7bfqRFehi+3uKpIeCQMkcYfXeGLTUz1VpAgsjPuJTTsMBYGpuLfpAaKuMX+r0Le3Lqye6Jqacp7y6eMekxhLEqvVThazPgFX+FuBMrg6HmuQN+iXaJQDd+I4Uq62JJ5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957447; c=relaxed/simple;
	bh=8E5D9+MUYa8SrMOyJQA3/v6P1g5CXP8M1G0XYnpFCE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9SeXYD0KN+jH2HDURdmfREoJlvVJeNpRyXS4/IVnQ8oB1hozgFaYfEHajd19Oe08vzjRpgDQctso9jxHKxWviePA4MSNJ4XrhjtGm/lA2+uRYCO+p/wDCYQrdAoR3A5ysWgZv013XIo2NsfXlBwJm+ArCNwLRuRU8p+dEIfQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tfo40zyZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8d1CnL5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tfo40zyZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8d1CnL5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 37DFAEC0235;
	Tue, 31 Mar 2026 07:44:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 07:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774957445; x=1775043845; bh=gxKr7SUV8s
	IPmcTF+56GW9iyawyoPMdDai1NADqq9VU=; b=tfo40zyZHzae8SDcla+slWrQGb
	USbHLNiPNp0NnwNUaWqoKmU9JHosmeP2YZAu/dqM1yOb+fS6Ikh3s9MO0JFFHTpG
	o09dw/0XcNkqDf8iwQybnKE6yBS25rInW6dUCmooMFlbQc1oWiCZDGpracX/3Ql0
	VG729ZCj9BuHDYPn4czOMpinMZH58p82DYj6SafTU0CqfRK/yfAlODPEGa6SE/Xo
	3TXayQ4DJFcMNUHRsEBrqhQb1YBdTe656hPEoxJiRAE8zXXlnIbKkkVXSlQ4A0/y
	n8J0v0tvHNcDSZlNdHbaMeVUWQoN7849JgGPNndTKifDVJganC5WlM4Uiwpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774957445; x=1775043845; bh=gxKr7SUV8sIPmcTF+56GW9iyawyoPMdDai1
	NADqq9VU=; b=E8d1CnL5lQnt1OzocX7hVQGiHTN4ZK5nWuSwBmd/Gm6BF0loXkS
	jDQXqZFH+0PTdBvNWjfHRUuozH+CbtAOrBVyIwgiLqmIDHOFYt12kWGIORX5eAg1
	35Vfb0kOjoJdllSKh6fDNHWaKA1VBCXh32cKYuJWTJlURPF1QMXZNTI2frNdVQlu
	H5ZgZL82AAu5EyNBgpoZQypHkDkhY1x8bDfh5QSKc1v6xFfJYp596aRqxcfFj1Xo
	DNUACBmtiPkZmxsHHuhkZsq1sQ/Kr0JlnyRmobfHTFg86OtTaB8VTpdT2JGbNX5g
	PIxdr5II0o5Glnb70MzsvheyqaV61zfclSA==
X-ME-Sender: <xms:hbPLaamLPoWkiAvmDV4b_2IOjnpG4j9vuNyG3W4Rym_wbTzHD4xXDw>
    <xme:hbPLaZREuezPMllLQhHHITA7veyHVXOnZnYESdk298IlnquR6ENUiSvbzPcELLJSk
    ppV-SWzpQGIA8uuqvf_c9rVGxj7bnaJnkT43OiYSU-F-NVeswSQjg>
X-ME-Received: <xmr:hbPLaWAzbQPFXTYjIEjCUyBMq-bA1OBbgU5B1RXthDRkKRvHsMvMykCAWwwWcsQls_K1CgCq8Zglyz5jDduCrUcTtvMyQ5YC9q19NMCulgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvd
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgue
    egudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hbPLaYSj8RbVhZb6aCgEz6ZAxL4kIIs38nBiZmAKU8a1KP5_i8AUhg>
    <xmx:hbPLacqy3H3GaLTVLuYakDvkk4jSd5a-2923Z9JzFPjmV_g4Nc30LQ>
    <xmx:hbPLaSwdY-g0HCQ6wLmfdFg9TXP4esKrP4n2WMdhlY5UGUs9019CZA>
    <xmx:hbPLaZL9y3gZCgPv7FHQMLo4r6j5ZI3Bvuy2WREHAC3Lnsp3S6p2IA>
    <xmx:hbPLaWCdd-4Feo-KbmihcmccBQxX7TzUBKBRVd3L7UG1EcW0diEwetPO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 07:44:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e5a2aaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 11:44:02 +0000 (UTC)
Date: Tue, 31 Mar 2026 13:43:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 01/11] test-lib: catch misspelt 'test_expect_successo'
Message-ID: <acuzfzqIT7849jyX@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-2-gitster@pobox.com>
 <20260326040828.GA686242@coredump.intra.peff.net>
 <xmqq8qbesm1r.fsf@gitster.g>
 <20260326172920.GA2447148@coredump.intra.peff.net>
 <acY3haGPHPLSfalj@pks.im>
 <xmqqldfdjg5t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldfdjg5t.fsf@gitster.g>

On Fri, Mar 27, 2026 at 11:11:58AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Let me know in case you get worn out by this though and then I'm happy
> > to take over. I like to have a numb task every now and then where I
> > don't have to think much, and this here very much is such a task :)
> 
> I've stopped merging mine to 'seen', as I did not mean to carry it
> all the way to the end anyway (I do not have time to wait for the
> tests to the set of tests I run regularly with cvs, svn, and p4
> added), so it's yours if you want it ;-)

I'll pick it up, thanks! Let's see what I'm getting myself into.

Patrick
