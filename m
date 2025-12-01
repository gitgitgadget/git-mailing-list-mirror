Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C832D0C61
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593902; cv=none; b=P2w0s9opo1bjlhF4q+lwYIcg+0zogFJxM6R/ZBuoNEhn3JiwQy7d9xFvCedHUVPdm8JNGSipsaCreRHJ+7jKWke73YYUBKXzhrdvaC9wMsgwEMp8ex/zj/a2F4DujrGsHB/jrucj3f/7vc8ob/Tyfe7Z54QMrG9Dz3rPKUI4dUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593902; c=relaxed/simple;
	bh=h6jrtzJkkmuZXfepTqTj/OpVOhY28pZ/0fziKUTL8tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKHQnbd+UZ692XPPQVU03pMQCh1moSq3qWx0iO/QWIPiNPkE5bBby1bwGMk/Qhrhb5r5pN4np4EfdDQbfxP+8TxaBIt2STvlwM/lOB7pI0CFv6kakyu+k3i1EElfxvNat5L17yKq3h+x4tbTzfJ8YypFzcn/QqtK74VK8L3iA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tR2SVV1O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFypHS4A; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tR2SVV1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFypHS4A"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 52141EC040D;
	Mon,  1 Dec 2025 07:58:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 01 Dec 2025 07:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764593898; x=1764680298; bh=j4Z6kuD79/
	lPwQQr3y9OuYRkPhMNLK5VIsPb6yPk4is=; b=tR2SVV1OgYS3impKZPPQqChHIh
	jKvChygeK589EIcwql7bcH7r3EPjPTvhXnHhQ0askTVIjXWWQOXRmNuRE6uLWumj
	olB/MYriVLkLBY14Rok3AKvaJlk6W0EJlXbdI0Zw1/JOB6bVbvgi3l+i+BrJubk1
	Kq6N9Vt+qaYFTRD6DqWqoq9NjIJOSzwVBm3kQx6Mnv4A4P1KaieFARUzlEzlUWAL
	znMQp2zDKj2PV7T2hN2v3YXOOMgEHbiIRObv+IzW+6uIydOdaWjNCAKFRbFBIz9q
	8ykQQwnGCae5vxuapGIgCklYlX2ZO+3/kwFroOPtKnToiv1p43jSARU70Qhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764593898; x=1764680298; bh=j4Z6kuD79/lPwQQr3y9OuYRkPhMNLK5VIsP
	b6yPk4is=; b=eFypHS4AnpeDyPg1KzdEXDgFF49QGJfpVUSZrMpokWXuCpnU0Zv
	m5xy/2AKC9eoftIihsX0F0tWb6WPMjP42UpGyeM3Tet64AuFusFVvdTrK+pvjtUK
	dZSCK+GvT5V1grwgOAINQAgoCVQR+ybsm4GqbAl1sQ4EQVdBpCSma35lEV6DlN3P
	IAFoLb5MWS9vD1EV8gyzttw8OC2V7XLQrGVnfmT9qHFe9kmAgkIzSIgmKRJjAxH0
	tLuND5FyTpT4da16a6I5bUDx4rx0jR9M+FQrKuvhW9ckAe+hSU9OriwrZEbRccMH
	dGa6Jy8cIIV8+SrIz/iMY0iGeBJ8fH8sCCQ==
X-ME-Sender: <xms:6ZAtaQUFhQvp3QalUGQy_WNm5yBFpaAeCYqtVWGcqce5OSfQ3kf2NQ>
    <xme:6ZAtaYTiMlg9CUxBjulWj8yvMCZvxZmveIl4wFf8TWaz0uDToaliOUO1dCcowQdyK
    1q1Xj5AxAQxStJyylSSezxJIPdBFjAPAQNWAxd-u_l6epwyYmhD_w>
X-ME-Received: <xmr:6ZAtaeNkoNeuNpXMXu5pFjZSLUWP2zitMHjHujxO0YVOihJcSgVAPrzSpD7RXA2rMBVLmO5rM_06R-wOoUHSSuPNq9auTbBskkMEazEH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeguvggsohhhmhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6ZAtaWRWIKl_S-zQ_bIw_X1p5XFqcW4sQXqClutxRuEQoH6quj2pgA>
    <xmx:6ZAtachvCNPsZuV8kbNF-ixBONiMuAzrYLERcNtmCFsrED014JNEhw>
    <xmx:6ZAtaf9mlXq54J33m5PKcS2V0mVPsdlDkbDhiQhov5uV_9V41q0FZw>
    <xmx:6ZAtaTFrQo8KbTBwK0GaUdGFEbNM7wbRwGf5A_OzjQshXNW7ZBWlww>
    <xmx:6pAtaVFqgQA2TwsqxCjW3j4eoICJt131Jz-tSb8WIxB_ttRPIiRfANoo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 07:58:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce77e640 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 12:58:14 +0000 (UTC)
Date: Mon, 1 Dec 2025 13:58:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com,
	sunshine@sunshineco.com, David Bohman <debohman@gmail.com>
Subject: Re: [PATCH v8 2/3] fetch: fix non-conflicting tags not being
 committed
Message-ID: <aS2Q4-U5kgJ2nNVv@pks.im>
References: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
 <20251121-fix-tags-not-fetching-v8-2-23b53a8a8334@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-fix-tags-not-fetching-v8-2-23b53a8a8334@gmail.com>

On Fri, Nov 21, 2025 at 12:13:46PM +0100, Karthik Nayak wrote:
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index b7059cccaa..4b113d7c27 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1577,6 +1578,67 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
[snip]
> +test_expect_success "backfill tags when providing a refspec" '
> +	test_when_finished rm -rf source target &&
> +
> +	git init source &&
> +	git -C source commit --allow-empty --message common &&
> +	git clone file://"$(pwd)"/source target &&
> +	(
> +	    cd source &&
> +	    test_commit history &&
> +	    test_commit fetch-me
> +	) &&
> +
> +	# The "history" tag is backfilled eventhough we requested

Tiny nit, not worth a reroll: s/eventhough/even though/. Other than that
this patch looks good to me.

Patrick
