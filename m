Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012C3451B5
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514874; cv=none; b=uXwzmWmMJIQXN/IrTR8gbZFvB7HX7WPPvkuKHDI9pegO54xQFwQG+XX8H7XqubIskMBzo5MT5SyYjYL7mkraXp/XOCJU4VbLa4WG24QBHjXpneR69mPvUDoitmhhglcTBWfrTdzW3FkMZgd+836ekHYJ1ESqubBKlkcPdBGxIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514874; c=relaxed/simple;
	bh=rkBThndB3kqTv6yfOMJcq+cfSKKcBW4SGWdSpL7ILc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYcZr3I09FJ9xadzzEJ76gF1uZcCRhHA1oHScWQL+YzLc4mkLRH3MbY12+kvjPQVOgZN6axKCoGzjC7NPx/J2cQUX7qB2bgu3S24xIaKzP3bacfNPls0pu+a0LwWTciUipud6OIC2HhBh+z+1u3fzDw2/q5+9RVhJFKmBjxGKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lqGW5ym3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBopwtg7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lqGW5ym3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBopwtg7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5420814000CB;
	Thu, 19 Feb 2026 10:27:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 10:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771514872; x=1771601272; bh=bxpo7ZgVW0
	pdR7UwIInJmOwYP2u4C4z7H+4iP229ACU=; b=lqGW5ym3z4a2ej4ufMNgCTj0ez
	TWG7PHYVU1cL2G/HBuZBCpZKJ75v3F58lF6sxqVWC9R0DdL2ohfMnLHQcrBYgbw1
	ofed6k2y+pRdWZUhqRba7JxQm0OLgvqKhR6ORJW4hTnibKs5yJRlqCvlgjolPY/w
	rJC4YKygO/EbGXHulSaprg4306kCOe/X1OuzzGl+g22eogtH5RP/R7aET7ZZXFPj
	XddVJYv9P/BVneEGpnwzY2pGYWv9ek/dOlBOQtEsk1T5QY1j4KMGWoiLZVAG5UK/
	SEjA/tn6hU2KDpq2gxep57sL5QK4faXVYU6UQYOOZaV8qaep4kCSKxzrE15A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771514872; x=1771601272; bh=bxpo7ZgVW0pdR7UwIInJmOwYP2u4C4z7H+4
	iP229ACU=; b=KBopwtg7mdCLjyh0hyL5kOdk4otB17Cr+7oaRcHR1vtm2ZaldBe
	gUpPRoCpHwmReGKDaQb9D+nkGMhCo3Kl8E1exp8UwoOS42pnTcdwuUapkYxpZlXk
	jt995dpFZa6yJ6/SRIngt1n8cryuFL0wP/DrMMaGDh35g7+OvicE8iFcP6e0xNnc
	kLyBxp4ac6qzBpInV7aCaGI8pz12NmPQ9XY6QZEfilFnf3hsmdOE/xKkboYN7/Yy
	PzcXIdHmWzhptHvxJdV2rFPEx50g0A4wwsBJ8ZDYW/qzI59OVkXMWCa9JHSMH0Qs
	GRyeI36qqzs2KBfYfyf68kDb3975GclrfLA==
X-ME-Sender: <xms:-CuXadvcmG4Gxz5RbKtqelLUgDSX0M9ZDaZoh6rZw6m_uXdLdAeMQQ>
    <xme:-CuXad7COKPXOVT-PTeMAsk17K8jf6_PVIzkILrQ21OwWhf0667TXYj_hRE8155eO
    qT0sTL2vS9FMr5YTkv95jBeDAae9_YjlkvZBhWu6wUH1BdIqR0z824>
X-ME-Received: <xmr:-CuXaeJ0ZNvYxgn03z05Afgrwak_V_IW87vIVNei-ZjkcN_9BIIrHJ_n-ckMPbTi5e0hrHXyVxhh6UPxufcIZSOOOTtE4KI-mbbOPBZkRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:-CuXad5T60-5f0hDT5JNpKsK7c42ueO91d1rkDXGTB9gHbwjZMKwDw>
    <xmx:-CuXaRyllbPqCv6p3LBKtfsc5FiDAXt_g8DKs0-uF-VuuowDDbrjmQ>
    <xmx:-CuXaRb2b3FN64VaEdIrX1k7AHb-fvYIBAcxYsnr3se3X3vWGnZPig>
    <xmx:-CuXaTSV3kHaOS2g1pII-ubfuXvvimw5SdmjAAu-y1bO-cC8M67gRg>
    <xmx:-CuXaQUZwcZ4gm5zMLsatZWAAnPpBnGMHIivGKo478p1X9tAsFuUGSw0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 10:27:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3631bd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 15:27:50 +0000 (UTC)
Date: Thu, 19 Feb 2026 16:27:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] replay: prevent the_repository from coming back
Message-ID: <aZcr89rBhJZ4F8XN@pks.im>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <d75a71aef97701e476dc8e9c662620e20cc5b17b.1771406115.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75a71aef97701e476dc8e9c662620e20cc5b17b.1771406115.git.gitgitgadget@gmail.com>

On Wed, Feb 18, 2026 at 09:15:15AM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/replay.c b/replay.c
> index f97d652f33..a962f53d03 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -11,6 +11,8 @@
>  #include "strmap.h"
>  #include "tree.h"
>  
> +#define the_repository DO_NOT_USE_THE_REPOSITORY

Same remark here: might make sense to add a comment here to explain
what's going on.

Other than that the series is a welcome cleanup, thanks!

Patrick
