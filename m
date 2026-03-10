Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACD3B6BF3
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144974; cv=none; b=tPPkgsmAq0qyN5eT53VabFwtR/YjtvYoU++1j8QIvH6wskPsDTKRCEm5FcqbTm3YipVlBfoEN9GxROg/nw7Kverq0CebhYFKFV5mtmJYvg7+VEegeFlScnWpe5o8d9E1DHXOu95GS9k15Uu/dXPa12oIJE0J0gT1fHYkpKj4YGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144974; c=relaxed/simple;
	bh=tW4XC0w5Gx5gldXwlofnOBdb+XVkS8pRME9vch6eg2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urD3f5o4pJBtCbGPMQpKCnS/Fk1UsAZ1+l7S4/HydQCCdOAOYvpUkGCDi17b+OULSXnYX8wxDTQS9bYEu8vG4LEXHMdVs2tZVHFudJlDYp09qhSpA5gYVfx8rrEEU6aEmMn5VPg915Sua0Txifd0VgSpFCcUXfm42muDmXW1VOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KU9w6xUm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMUFfjHI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KU9w6xUm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMUFfjHI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE0331400040;
	Tue, 10 Mar 2026 08:16:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 10 Mar 2026 08:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773144972;
	 x=1773231372; bh=jm185cluP6nXFka/iXJW74jrS9ACjaGSajSpomTTrwY=; b=
	KU9w6xUmUkLTZAPiA3Jr6w0FYCioCs06uLiENFrYFJ4vJkrDRcsdLYtGNWxYIPVS
	zHYHAMSMCZdWXxPQHZd0oOK2GTkrkPTnUEo3jjfK04QcSrPqjr1sQTDj7hud6AJK
	TyWX/o2yixB5oNR711FpR2n2x97keoJYtU2pyxcZtGmbsdPslNQUoVwkRxJysqkj
	eE4tm0SfgqSKK68aE3UKdyJhnYEnaUF3r1ynBe7HYyzDZujSowHtLO149eqq5K10
	i3bmMkpvrcIf9GAfN/o6NZlz4yyl6uA5mEy2e9/K0lnzOGftDj0B/D2FzKM2ir4G
	KIbnyGtua49biX2qZyreFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773144972; x=
	1773231372; bh=jm185cluP6nXFka/iXJW74jrS9ACjaGSajSpomTTrwY=; b=H
	MUFfjHI9tNVoc4G6gbUCmTaEWHw3a729dL/CErw1RAJIZ3ZImKr+0HuvxhR1bMvb
	PYtgeU2CJIbfpY1Ek9f+1RpNOY2hGigJ+OLeDZpKBKup44b3GbmR32MF4Qx3BSlL
	hlA2C7JEkCsn2OcvB1FiTWCVDRfKoqLaevPB6mUP0O0157anAbse+FutNJQBAz90
	7DSip6+N1goliOmP2js2Xd20bx4I1sRYO9M5fJ2Ov3yyrQuUetTfIsr04GSSY0yK
	k8f6V8+dMTSf1YJXjhJd03MPyif+/gUf/xbEszaoH89M2fG7Nulde6cIJxtXKLoV
	IgpWvwr0OkyhtJ4frdGRg==
X-ME-Sender: <xms:jAuwaUiHO73Kcej-ixU_Gcp-Sr0vS1sOS_IcLRZ6yYOXbYVHzbjpew>
    <xme:jAuwaTDp1gzh2OIMIwBvHcI1IoJ3R5J_RgHXsHkOPEMDbJiJEGOph8F00cpPx7FO9
    w0PmkvwqNfKXSaA2dAb23e5uB_dMEwNk1wYJWEpVMdUbxC4uHLhpw>
X-ME-Received: <xmr:jAuwaZtfi1minXRygR9_TFl0QEyqctWmz1sg1PaO5uYHLYbsOW-PbdLiKgZA2r7C9-wQLlRR4Ta2IC-b3wJP4cxDQblB2pZ1e-tElYFt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekro
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepudetheffgeeutdefvefgteehhfegveffff
    dtveeiffejleeuteekteeujeegkeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jAuwaQZA-wwbCMFK5fO7sROy9z-yeGQrGTYYm1Cuk55n0nIKJZHPjA>
    <xmx:jAuwaUUkzmW3BjPSIpGLI0VZ1uvv0KxYryST7SeA4xsKzcF8wrIErg>
    <xmx:jAuwac5aj3AiXa2qnupMMG4id9rc1A5sHwBPsjVM4ZTOy41E6hhm2w>
    <xmx:jAuwaXhwG-4q4uXGoxK-W4fYLGLELfJol2Yjoayh7lUP9s06MQLcjQ>
    <xmx:jAuwaX7ZjbVu73VdRk8d07IDtkCjT5sN9kFHqJVn2xjNV-9SNa6fh9AC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:16:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea711a59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:16:11 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:16:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] history: initialize rev_info in cmd_history_reword()
Message-ID: <abALiEDdNXCTzVux@pks.im>
References: <b0b8633f-be95-48eb-8244-d0e3f1a7be72@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0b8633f-be95-48eb-8244-d0e3f1a7be72@web.de>

On Sun, Mar 08, 2026 at 10:57:02AM +0100, René Scharfe wrote:
> git history reword expects a single valid revision argument and errors
> out if it doesn't get it.  In that case the struct rev_info passed to
> release_revisions() for cleanup is still uninitialized, which can result
> in attempts to free(3) random pointers.  Avoid that by initializing the
> structure.

This looks obviously correct to me. Thanks!

Patrick
