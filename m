Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7310E3
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682548; cv=none; b=KKiDGGJfpvycL5VkrRtsX9TwOcEl7+HL5oOCcvw2Ney8JJc16BfAuXqeDdNfV8Vu8eBm5iM7QDMLbLYzY2XcpvALiTFrf5JGzaX6VNZqxcp1THGAG9muSwk/FEtxrS/KZgVydXYEzCeqU5VfVSEgAAcd3drjnuK18JY+gt83fZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682548; c=relaxed/simple;
	bh=6LQWCQ99XySpqbhr5tZGpCNn+GQkyXMo63OKmDSsbWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIxFFWeCzrSAYrNN/9/JDXPFDdOVQfsfL5kwXAckBnyZDIZjJbdVhY3G5IPhB5jTID1M5zdxDvele6PDv4TX8LBYHIms/ioGIMVQ1M3wkW3CC421W9yrNXnp2cmDrK+Eme0+SdQuAYf3WomwFKoX/mFq3dCb+K3Of+VI4rksZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=acprJoZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBJvmqeP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="acprJoZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBJvmqeP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F9207A00D7;
	Mon, 28 Jul 2025 02:02:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 28 Jul 2025 02:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753682543; x=1753768943; bh=6LQWCQ99Xy
	Spqbhr5tZGpCNn+GQkyXMo63OKmDSsbWU=; b=acprJoZ17g7m8koOTZ2VVvRc3i
	Sxx5tXkSet0lQLbgpIPftgFeXOm+abWehzsCdOIHN3vZwV5BxLPwI67ylPR2KpiC
	+Daht2xC7Hn49iINW9Mw1Z7P2DZ+ldzL8u+cdpGw+2xqF93M1Pky3Gubp0uOejEB
	zLYlJCEoh6Uj+SWv0/P7hJ4n8ruDpUxbuIEt26eyz9n09cT83AGbo6oyvk9s+qn4
	lwsoUZToXbqoOnX41P6fQXSEHUFcyHoxz+7aUkQVFPhThEcrGbbdHDtYPYg9tA8C
	FLvGf3WfvNqDKwCGhZPJDNL63Y8gqjnT6oRquKqyCbzjpVH6nHITIohKvtSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753682543; x=1753768943; bh=6LQWCQ99XySpqbhr5tZGpCNn+GQkyXMo63O
	KmDSsbWU=; b=FBJvmqePM/oPjtsCLw3uiH8kEOrjVehObscRn9AYe3PKGDQZkVR
	TJkNV9XVsLZH6zzUKxudr7ljwvISUZmohukr78KBN2gTKz7z9Ny9Wh3L+a5ozcLX
	rTbDfdlP/deaDNCni1FILdmYfLXg+rc9mER7gjPaXkGiyjNpF2eb0HpYthz9hsNY
	jqw+IXafu2T1HllmPtNbuX8iarRd9cDDkdxeb+GlpPCmZQ4gWXJtyCLxAdXFLg5r
	+BFK7osx1GjYk6o3PzI5RbO9bAf9cSWWpQUy7hDHFCRzS+D7Uf2yj48NZmI4jIKd
	MJjGExLw74KFmF9ut8QolnkKg5i/IlEAxdg==
X-ME-Sender: <xms:bxKHaLFMpIMaGQsB4QJYk2-8ZWZGHoilte4myNRcOhBw_-StwjBLqw>
    <xme:bxKHaLm1hQ_9S52LON4baD8XNCDZiUpH033ljYffQhooOkSV2PiOUVAqO0U0jK9Hh
    p1U1VxefrghSMiVrA>
X-ME-Received: <xmr:bxKHaGkZiZrYg0urFIYeLJWfkE6SPb_E1Gz5KiAcUrZUUcG_SN6APzP8-ZsOmCbyafLG85pRNhs3RZVJ371IMF26pOR38_X8NRdRL5zX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephh
    grnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhm
X-ME-Proxy: <xmx:bxKHaEujYd47RZTPqUQiCgQ1FTJL0DbgB_bCf4XHLfJzvWMV3S4CRA>
    <xmx:bxKHaBlq_QVLuHr-x0cKFIDUNqfmC0yWWKuOM0Bf-v_V8NQzmWfXQg>
    <xmx:bxKHaHusFyX3RH-i8S0niZHnlTIJdW5xH-4AsazgoynmZ7c45vpOTg>
    <xmx:bxKHaPeynR6vSJIBQXvmBHvpzvZtQfuG-1qOMln7LeJN-c0TYyysxg>
    <xmx:bxKHaIvygzb6ZEBQQA6EqJT5bD_KJiVPpd7kQbcWkhOwJyZ98F74KY6U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 02:02:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 151cf2cb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 06:02:20 +0000 (UTC)
Date: Mon, 28 Jul 2025 08:02:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] blame: remove parameter detailed in get_commit_info()
Message-ID: <aIcSYs7LxkJeRA-9@pks.im>
References: <20250728035548.94277-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728035548.94277-1-hanyang.tony@bytedance.com>

On Mon, Jul 28, 2025 at 11:55:48AM +0800, Han Young wrote:
> The get_commit_info() function accepts a parameter that can be used to
> stop the commit parsing early.
> However, none of the callers use this feature, and testing proved that
> the performance gain of stopping parsing early is negligible.

Funny enough it doesn't seem like the `detailed` field was ever used.
`get_commit_info()` was introduced all the way back in cee7f245dca
(git-pickaxe: blame rewritten., 2006-10-19), and even back then all
callers passed `1` as the `detailed` parameter.

So this patch looks obviously correct to me, thanks!

Patrick
