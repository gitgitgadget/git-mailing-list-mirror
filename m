Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641B22318
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777853; cv=none; b=IPdJTL2ZRJrRf4llqvuWNQckqA9cTjimGBB53pU8rcCiyoU8ZoErosOsWFfonky9c3EM/qcR3A954hOsn8tpMqTAVo+VfRqbetM5FexOmDSGTZ7uqpSL2fv8rExY+BGnUGLtLtn8nuFPvIpH25BxLcHhoAWdksmvvnvQvaX0HIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777853; c=relaxed/simple;
	bh=2lkkOHNtTxRdzmw+lTY3dRFLUJJO1IRXtbEDXoj/MHs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LDIk9zr4Z4AixizOyQRSMORPwrqrruyYuahD+bzTcGlxHepYmrSruPHqDGmPjsh6eZfS7gzTxLhZbFi10JXwgzEtfFrcJG/UwrJURmma8mHetrx/g0OH/Ec+OMgBoJ6Zk8fKw4g0CppB70COhumO20KoaV6j0nesQzKoIDm8nFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WqdStpI/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrCNDswd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WqdStpI/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrCNDswd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB779254010C;
	Mon, 13 Jan 2025 09:17:29 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 09:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736777849;
	 x=1736864249; bh=+CPJcm7zzwj/008GG5MaZ4NFHZXI5/CXvZTki5h+0ac=; b=
	WqdStpI/L737399dT9nPKOm3YI1tr9OY5sbI2W0SAteJRwiVvVWg6vgsNLtiMLhY
	jWDS+vqYyCG07jDo6fd2AeyMU4NzVNCfIpeZGKKccixPyJS9q+f+F4oOq3tHnxwy
	2GFvNrO53cowMWEnlJdXSJ0Qmuj5+H19W0KfE9Rn/P0B2pp45WD5M0GCGpfiABys
	PFH3JwP/ns+tjFaB6okIepexmdexj0r3oNHwKAsigHYAIx8iYvBRx8dcBIuP+WSI
	Re7yijePcwBgnoCGhLlLbUtSbJulOTjygQ8MZN0iIFKW/CdC3EKT0tEi31HIzeC6
	x55EzDZpAfMBWfQB0DKjqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736777849; x=1736864249; bh=+
	CPJcm7zzwj/008GG5MaZ4NFHZXI5/CXvZTki5h+0ac=; b=UrCNDswdHIptQwEEy
	LGHeBaVwLoBOr8+V7JM6ostDdGxrW3ftplASraHbHgner1uGDXduJ3X+7TRCkMy+
	HuDvrzsgell3VAOkIPZSJtzcFc1a36Jw49zyx0I2Xc9pMBDXHSBy3blkUGU1AT/9
	ws3zrEfcAkHqogOvzOYTHQWAxvCvp0UjZvvTSxeEMvon5YpmsJT1ed/BAVqaZnTY
	g+0cxG5hd/AjSXaIWK3Zm98Ts6VdDewcxI+30TtFF/6NWxrHPnEOgcgdvsocjEmW
	VNWrnAFv/h8LbXy9ybz6Ni1CPoD6CQLLfULIZmZwGaqz9u2fFoLWnW4h/bxJgY8S
	RXqsw==
X-ME-Sender: <xms:eSCFZ8WT9Sqjth1_BWpitemhs9MN8w_YQohRK11kwyOEYv-KHaKL3g0>
    <xme:eSCFZwkF5USp3kgAQEy13_gFeMnWTrU4HuARGxgxwtG4gScTshwTQtrgPOhtBEZI5
    k6ppwlgLiL9zPRvaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpefftdffhfefffejfeffteetvdettdevfeetheegtdehtdeiudefffduleffle
    eljeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgigphigpgihuseihrghh
    ohhordgtrg
X-ME-Proxy: <xmx:eSCFZwaTtYEc4zjcyEKHjD2Uuzh34i5o3tccLY9OoNieeLQ87qoCZQ>
    <xmx:eSCFZ7Vp0l4e7t4eIp4tD6PVbRrLlYnKIi177_b_DBgbg3iwYqRZvg>
    <xmx:eSCFZ2lkrw84soEibH09Sppn2O8-sN_tcgu2mwj_47Snyg0sJ8Is-w>
    <xmx:eSCFZwezlmHZwy9cYPCa24iDTVDo93g2ge6v8Ut36Q5ayzJfEZZgdw>
    <xmx:eSCFZ7w18WsPzMybHg5XQ9bziM7u-NIFdihhU07voNbstzjJNOhoRbas>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50CE6780069; Mon, 13 Jan 2025 09:17:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jan 2025 15:17:08 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <efb8b6d1-c06a-4f73-89bb-6d164ab03cfa@app.fastmail.com>
In-Reply-To: <20250113134632.21592-1-alex_y_xu@yahoo.ca>
References: <20250113134632.21592-1-alex_y_xu.ref@yahoo.ca>
 <20250113134632.21592-1-alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] meson: move config-list from libgit to builtin
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jan 13, 2025, at 14:46, Alex Xu (Hello71) wrote:
> config-list is used by builtin/help.c, not libgit. this matches Makefile
> dependencies
>
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 0064eb64f5..ef3604a17f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -614,7 +614,7 @@ libgit_sources += custom_target(
>    env: script_environment,
>  )
> 
> -libgit_sources += custom_target(
> +builtin_sources += custom_target(

Looks like the same change is in another patch from today

https://lore.kernel.org/git/20250113-b4-pks-meson-additions-v1-3-97f6a93f691d@pks.im/

-- 
Kristoffer Haugsbakk

