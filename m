Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F311339B1
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804447; cv=none; b=JizIGEky5/wUr5PB7Ts+f7MEU0mNeIHYx1i1ZnE8rz4HDf+qQ1ynZH8uTceLwpuFMkWsqTrbzw7HGO/B4uvmjrcMgGQ2CgqJBVhT4u8zgJq7CJUcyGtYs8LcWDgiCuTey0fTnNSpM5V6cSdPddiqnXx58QwhcQTZYzd5y9N7YZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804447; c=relaxed/simple;
	bh=aV1N4TGrk73Xu4JfQRonxOp56vqc1S4EMBotRwZ0Vzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it/GyBubHOV/pZBL6mTas7OcDQRXurmiehZvXHwEkDWBmxXs/3daWPpFDHvZx7W75QrvnSQa4amLke4M8LFnlrCRayRBnA/2C8Dwhfuuh7u/2kU+lN4UfAjeErC6mcBAJ98JevMg4uAJB43jwr/JCNf+UZXWIrv0E6rqWE2hPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UoGnSAO/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zCqwC3Gu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UoGnSAO/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zCqwC3Gu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6AE5140061D;
	Mon, 19 Jan 2026 01:34:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 01:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768804443; x=1768890843; bh=gOVOI7VSep
	vsB22g+ZGWqjLR3W6peq98j62LU7Upl4o=; b=UoGnSAO/vVR3oX89HBDeELtmA3
	t2cgBNNbpuxnBvO7vi19MuDtkCY8ESlg2Ma8FVnVhzeRQPqyu99jIfkKwZfKf9LA
	XGv0o3TVBC61uWQxQwXwk3UgCp/BrggsIeESc02jzmGmiG7Km73oU9OwHMVy8+NK
	C7gz4qmsVULK+w09Shxv6ZuMSMa1qMsa9HfsjzzvfWM9QM308eIm9hRdRL5tRJzy
	DOJQjkz30urhovuSZHLTyJhI4trwfw6Igpgdsq0e5aBlxul11qWSG/gYH7y/Cvuu
	3fLgyAdGqOx/zHfF4bEhUS9azkEKt/vRSkXb9Ut4SIg2QQJ4UldNDhPXMOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768804443; x=1768890843; bh=gOVOI7VSepvsB22g+ZGWqjLR3W6peq98j62
	LU7Upl4o=; b=zCqwC3GuXalUB6i4Dbp1HhtpDT2EqCYQgc5YR65ErzsG1fV2p5R
	xtH3rgdojCVvXyTY1g2szzfwSqBzIu0QqO9HwywLjaZcyxeskWXpKdQMBO8QGopv
	hf4L5/ZuhUrLybg8HffXDOGjRRfxT8lmJzB8ZCE7akL+iGDdKbz1PUomO9SiBJ6E
	0pnt6E5dOV1mloC+hEikTEAjVymi3QaN8hd2nYre02xpQF0uuHWtuRRSmELXxaao
	4HnVyejk4kwyTEH9x1sp9WW6Ajt/cTZozv3hGkK8mLmrqL06ex1bZda2TBJFL9EG
	5aqAvNrcF52l9et2SoKt/kdkWIvV2FJ9mEA==
X-ME-Sender: <xms:W9BtabyZMLlR3vHDZnvYXxsIUpeTNuXz7GPN3uSaEUJEWeaRiRy2gg>
    <xme:W9BtaatU8vZeI__euI8a_FUdLXkFY-UfD3Eidd3St7KLP8ejET3NcAPymu8IEWw8q
    uXb3Mg9EAdhegFcoUMb5ikEBiy7a7wSJXBO2zyUdhc3KFwNc6EDVg>
X-ME-Received: <xmr:W9BtaSu3YWnKnkdVDIJmZg_AK-J7mrG8SagyhODjBZmfkGupRSZ4Mn3baTnz1C3TOw0pIVIu1oiXC7v5Ez9uUzhGUGHtFR4R9-D5R1-7eLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:W9BtafMimrfMxZAIcu8GZoIoonThw8OtBmtpRXRnFn54wG10kCbqCA>
    <xmx:W9BtaQ2vbATrkfQxtZU27q5hCQMedqr9GKOwLYRD98-tVSvptDqKJg>
    <xmx:W9BtabO3GThy4DNfDC8Wccsr7PEmZLXz6PbJ_IrtlZ_GtbHys1Zrxw>
    <xmx:W9BtaQ0T1f7lA-u9kdaeoOe4zj1ygfJllHGd0MQ9kcnyq8B4AX2tfg>
    <xmx:W9BtadYgF6Xd3ewnUcoh0dxsgQPyxAoL4xf2lJZ5debZP-CVHbm7W7OC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 01:34:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df22ca6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 06:34:01 +0000 (UTC)
Date: Mon, 19 Jan 2026 07:33:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/4] remote: return non-const pointer from error_buf()
Message-ID: <aW3QVkpPPHjKVNLC@pks.im>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
 <20260119051945.GA1991523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119051945.GA1991523@coredump.intra.peff.net>

On Mon, Jan 19, 2026 at 12:19:45AM -0500, Jeff King wrote:
> We have an error_buf() helper that functions a bit like our error()
> helper, but returns NULL instead of -1. Its return type is "const char
> *", but this is overly restrictive. If we use the helper in a function
> that returns non-const "char *", the compiler will complain about
> the implicit cast from const to non-const.
> 
> Meanwhile, the const in the helper is doing nothing useful, as it only
> ever returns NULL. Let's drop the const, which will let us use it in
> both types of function.

This function signature is indeed quite misleading, and I'd argue that
it continues to be so even after the change. I guess the intent is to
make it a bit easier to print an error in functions that return a
string.

I'm not really a huge fan of this, but it's not a fault of this patch
series, so let's read on.

Patrick
