Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492C3A3827
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146519; cv=none; b=gqO/8DpebHd8z9gGh+iTA1UZDLammIOJnF5MUnh0tjEQERc6bfg51Os7/CLc3w7FSKcsYXGY7Pa+VTHRPo+LAKLFdBqVqxD7tqxe9VL59CeeC9n8mbVzHmOGwb5byyZHH7fYdxPT3dEJZzA0WjCfxEhYdQleKcvgyM84I3MFBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146519; c=relaxed/simple;
	bh=OmRJX1MlC9+9amw7z64W5Zd5OnzozTweegSHGQGPnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2DenpHzY5FTUhw80Sx+TpZ68vEm7E9SF759sB9SZIY5yYBzyz6ecaq6aa/eTiNJBQFTcWiFdKwFdq60F40Sg6JruTXxuGR0d6YI2il/RNFeewvVPaYZWQJqkqeSab+WDjFttzIcKCQ1QnM/TvuLGO6Hdmi1JXJGkuDpFpayOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dclM/OJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpJxtAyK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dclM/OJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpJxtAyK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A96AEC08E0;
	Tue, 10 Mar 2026 08:41:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 10 Mar 2026 08:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773146517; x=1773232917; bh=pjYaN5MAfz
	y3dP0BZh83kKzurihB5vOHl2C/qalA9lE=; b=dclM/OJ/8/anJ+M+Owzh1hE4E7
	YPmIDC6KTNUe4SFPCqMrdWon1thYPi4jA1qLuM5BsOqgP9s/Kh0StrPa0atFIOxM
	FKth1v2ptnTtgHUUkX5v1avdtbW0WJOmu1SttkJkIMD5CUyeERELorGAtirjBTOd
	OeedO+2sShy7Wdaah1/F4HiJ8i4dg0EjsTq4/2IHBL78OiQuAZTdyC5W1pqq9Sg1
	2LZOjbFtgZT9JOCZx1zFXuAztN19W7riLQffje1FGsCdkFkJOLIT7342TIg8es9o
	06LBggb1H3JC+2uZih3AjZToIsSyUb5dQ1PUv6Sb7zWi867Jo4FWtsQPtSEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773146517; x=1773232917; bh=pjYaN5MAfzy3dP0BZh83kKzurihB5vOHl2C
	/qalA9lE=; b=rpJxtAyKqTA1W6BX3V7jvwMpIvUKnlq2rl6CPo2PbtcyfaqhikC
	P/lJdjDUgiiVp2PPlTJFjxjiJUJOeiDpMwKu40rOseFpY+TvoDLj0hWK1m9IqTNQ
	EjUZh/SCQcVOsZHETHhZBj4EVrAwanIgQVRy+wVqQdY+9pcSyp8VnbXqXPN/2I0W
	2a2MkoBhoMgKEuN6aBgL4gDGOSNG8kPY9RUSuWdS28yBqgU6uhdasscEB1v2kss2
	1XIfYNfLHA7UksKeDvJdAQV34uADog6Y6W7dOTfts/3olDIO9jJaMe86OnXMlr/r
	+XCeD3cRgAOCxBqy4z1hah7BJqoQ5vrb0Pg==
X-ME-Sender: <xms:lRGwafCDPbbL8eAm6wAWHfZnUBUNtfSE2-AiDAfTbaeV1Fd5fScqHA>
    <xme:lRGwaciNKQFGKzgTWogui_--uNUtqLGQr4_GqcTKd2_Aeokho5Yx_86xdhDBTwuL8
    L6nhUdsuze_f9ZTIick1fI8-D2HGxpYrWD73seLoYJfSAu09dLx5w>
X-ME-Received: <xmr:lRGwafkbXWbgGp8Z6EVgXqWj5PhJZq6O4dvtwGjGXw12pw1GwrbBwMuJuGdfcRXBJ8lWS0cphdoS4L2gNfq26gAkI-uCs80Lran2P3u1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhp
    rghgvgdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhshhhrihhmrghlihesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:lRGwaQqtcs0AEoJgWLmPpyl-KtBtDvhpXbgwzUOBjU_i5q32ZIu7YQ>
    <xmx:lRGwaQHfw1-jYJsDXyzQ7VQNf71thorLAuF2dx2VNu9ZJms6LuF8hQ>
    <xmx:lRGwaUwnQ4KbCaR7FwPOkg1_U_a2gby5QS2fmPqIZgBDMdByDnzTHQ>
    <xmx:lRGwadoW4XUpFQKfKZL28Dlf4UJoMYR8cJdoyzY8DLSwahDmXuB40w>
    <xmx:lRGwaa2L2aQ-pabaJEQBx0OvXIen7qlDgLc9MLG-9SwQqtNT0oa9TWU2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:41:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 031e8c8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:41:54 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:41:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jonatan@jontes.page
Subject: Re: [PATCH] builtin/help.c: move strbuf out of help loops
Message-ID: <abARj_VI9n2nB_xT@pks.im>
References: <20260310070328.29836-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310070328.29836-1-r.siddharth.shrimali@gmail.com>

On Tue, Mar 10, 2026 at 12:33:28PM +0530, Siddharth Shrimali wrote:
> In list_config_help(), a strbuf was being initialized and released
> inside two separate loops. This caused unnecessary memory allocation
> and deallocation on every iteration.
> 
> Move the strbuf declaration to the top of the function and use
> strbuf_reset() inside the loops to reuse the same buffer. Similarly
> release() the buffer at the end of the function to free the memory.
> This improves performance by avoiding repeated heap pressure by reducing
> the number of allocations.
> 
> This also fixes a minor memory leak when the SHOW_CONFIG_HUMAN case
> triggers a continue.
> 
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  builtin/help.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/help.c b/builtin/help.c
> index 86a3d03a9b..07398b430e 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -134,10 +134,10 @@ static void list_config_help(enum show_config_type type)
>  	struct string_list keys = STRING_LIST_INIT_DUP;
>  	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
>  	struct string_list_item *item;
> +	struct strbuf sb = STRBUF_INIT;
>  
>  	for (p = config_name_list; *p; p++) {
>  		const char *var = *p;
> -		struct strbuf sb = STRBUF_INIT;
>  
>  		for (e = slot_expansions; e->prefix; e++) {
>  

What's missing from the context here is that the next line already knows
to `strbuf_reset()`. You could do a trick and drop the empty newline
here while at it, as that would then make the reset call visible.

> @@ -149,7 +149,6 @@ static void list_config_help(enum show_config_type type)
>  				break;
>  			}
>  		}
> -		strbuf_release(&sb);
>  		if (!e->prefix)
>  			string_list_append(&keys, var);
>  	}
> @@ -161,10 +160,10 @@ static void list_config_help(enum show_config_type type)
>  
>  	string_list_sort(&keys);
>  	for (size_t i = 0; i < keys.nr; i++) {
> +		strbuf_reset(&sb);

Our coding style says that statements should come after variable
declarations.

Other than that this patch looks good to me, thanks!

Patrick
