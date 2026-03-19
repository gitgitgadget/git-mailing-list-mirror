Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36D391E67
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942299; cv=none; b=ESmvMluBoIv4X2ouauBWNSO93nakeshZemp46/HS5Eab4R92AUHJ3PIDT8Pbo+suVvzCINdkLH2leAmMFpGCtAXbW8/lEknVtZnOh7gf56LEKTUoy/wBkz8GayWpdFjXM6G4SjthimIjI+9tForF0/LXB3SuCoCgufYM9IV3JGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942299; c=relaxed/simple;
	bh=EFE/Z3mayEedlL1eM2S6TYL4buuQ/lQ86vpMm0R5o50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jo1s7rpOPliztqYvZAtk/V13gztqeXkJzKcZx9hjUYVrro6HuZIyvcaTfgwhrxqZD74Z+dY5z+A8T9c7BkaVyyB1kb/QAcNy0r4rQvHJ4h+jdcHN1rMTpJQtXEiW5JySXP2bDHcUy+F9uzTU7BTkcUAV8c7sdAp6HwAkl0k12nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BTPBlT2V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vLzSZ/oP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTPBlT2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vLzSZ/oP"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD7AB7A00D9;
	Thu, 19 Mar 2026 13:44:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 19 Mar 2026 13:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773942294;
	 x=1774028694; bh=tFad/KhDqFx8HbRRNsG4fXbw1HC6F1JZzXgUt33EWoI=; b=
	BTPBlT2Vq5+vRsIZ0SxRmf+m8ErYAROpPfjALxJEEKqcYUWvIqRNqFsgDDekKUdn
	GCWB4MwfXwZVW3oGM5IifyDubU5rbnH4jvxqt8YH978nc/BAQ29wGVScvIC0rtAQ
	9ry/OICQtgbmoyHGpc5ScN8nojRkl7XMh4AF1FsA91VtAq/ROvKsrglcSMR8wJJN
	e8DH58LlnWforTqxeAKCAWXQW1dpzUK0C9bNJziP7ocDe6Pi2qpJQRZzuKlVY+N4
	3IplJUB4gZEJKq7N5Q1jT0mlZr5B3f5r8g5pvk9SnrJsvyy0AXoSTAztVwSN1FHe
	331pQz1lxjjcFseop8m66w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773942294; x=
	1774028694; bh=tFad/KhDqFx8HbRRNsG4fXbw1HC6F1JZzXgUt33EWoI=; b=v
	LzSZ/oP5IP3A2aVPN4jLCeDGDC2750hMRik1389aI6gwoJYP1xOpsT0bOLi2bgcO
	gPCHPctMHVtpmGZxw14yzzDa0kjopPVClrRSvhUW0xD1IXQAQY1ppMsf3JpTe1PH
	1w78Tpnuc30KRwQ0QTFCMmqEuWSPixTINKtjRQWddjcB6FV/hb7gg1VK/7wkXBlM
	iRANisbK+WNMCLYAEiEknrn625FtcVn1bnUcuxnbNEHajiDYdfiEHzB3f2nVIPL6
	VJwNDIIdrq7AlzXfk69BuHwq90Zy2ddsJfmG2H2f3m2K6fFCfZUQpsZjHfUFa/5w
	uoNTpYmc3bZIEHTLdFfVA==
X-ME-Sender: <xms:Fja8aTm6b355uCBNBxo_6A8q_aZScXfUZTEvuGPHDVYQE0riU8HdBA>
    <xme:Fja8adtmmmzPmQ9pvF2BabrOt1k2_v4vry49K6wBjZArJ3rzfA0x1xAbiccv4eqK9
    7ABS7Gsf9pgKCsQfFebReV-Q8O7Y5tSuVTU24Oc03VJBrPVmZiXVDk>
X-ME-Received: <xmr:Fja8aR8gHVX9O5FSgHZN7Ux-LkFvvW5YN7MILHw2b1Ow3fRNjs4T9rGN8xaVD7KYcu2isoWTm83IpPTDfgg4-m-saCM75ZA5pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Fja8aXOxd2zjWoVh62GMlok4ZUz0NREHVxx3EzTv2z_oIwNwffeZTw>
    <xmx:Fja8afGcfT1N4QHpZO_y1DGSJaWQF1z3mT3IAHYJ2ZMWWlBAFKr1OA>
    <xmx:Fja8aVSypLmzflti_q-qOEH7AQ1xgMxrhRJ3o_5QL1-yoIQEv81QEQ>
    <xmx:Fja8acutAJdyL9o0_x06fYVs6WXbe_Nn0viJ1BB8x9Div-0nV2UyyQ>
    <xmx:Fja8aboE5bIM5O5jwKW7RDGtYJGiPygjL06W_-fmIXrdQrryvVDf4C5k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 13:44:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] commit-reach: simplify cleanup of remaining bitmaps
 in ahead_behind()
In-Reply-To: <21adf042-2bd1-4022-8822-9ed4985122a4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 19 Mar 2026 17:24:40 +0100")
References: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
	<21adf042-2bd1-4022-8822-9ed4985122a4@web.de>
Date: Thu, 19 Mar 2026 10:44:52 -0700
Message-ID: <xmqqjyv7lnmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Don't bother extracting the last few remaining prio_queue items in
> order when we only want to free their associated bitmaps; just iterate
> over the item array.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  commit-reach.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Quite obvious and straightforward.  Will queue.  Thanks.

>
> diff --git a/commit-reach.c b/commit-reach.c
> index 9604bbdcce..d3a9b3ed6f 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -1117,10 +1117,8 @@ void ahead_behind(struct repository *r,
>  
>  	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
>  	repo_clear_commit_marks(r, PARENT2 | STALE);
> -	while (prio_queue_peek(&queue)) {
> -		struct commit *c = prio_queue_get(&queue);
> -		free_bit_array(c);
> -	}
> +	for (size_t i = 0; i < queue.nr; i++)
> +		free_bit_array(queue.array[i].data);
>  	clear_bit_arrays(&bit_arrays);
>  	clear_prio_queue(&queue);
>  }
