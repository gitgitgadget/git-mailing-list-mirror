Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD71FBEA6
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736402289; cv=none; b=qK2hBCB+W1jM6EYQLwLR1FZI03GOkfMe83EQ14Jtz2sY1o9Dp24fWuzRI1IxnmZ//U2tMyjO013qvdDadbwNC6hb2UCGhwH1FhLD6dVveZQjZd4GN+ZHdkvTNCk88sEWPQDXgMgCQRxI1sxJoYZ2wY4LYILMs+TwmnLQfC8kwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736402289; c=relaxed/simple;
	bh=wfdJ6gEqlQ8UidvSLLYU0goh8Rs15QJ3fmpRqe/JDIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdtvBK8PGT+LMLO0bNOtvdPeoMUWatw8YxvokYcyVmw1CLZ6IzEsKAPVdbQN+eTETBmEpHDixbZuN2nFXGNNYCiCO8DaDctgzxYfLFFU8hcQKcRK41P17iyliZ6ynXq6aoDm+/aMysp18NZG7u3fUuIqfePp/aKn6eTktz9L0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e1S83YfS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nvnunzeA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e1S83YfS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvnunzeA"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94DC72540161;
	Thu,  9 Jan 2025 00:58:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Jan 2025 00:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736402284; x=1736488684; bh=1CazECn/Qg
	LLI/3i49afXAms9aEsFNVIfPugyMqKd4M=; b=e1S83YfSkFJgBRVmv0fbPwNEgN
	8gb/b9yJBNIt484Hc0wp8mAobJo61kfHxCBJRdXT758QHVzmQNsrbBi4hIv5Iz5b
	94TVt4dfFexbZw/lDCvIYy2hr8ohsZAqwwPwVMQgieVGyC368TEFTnMlIwIdSpsP
	uzZbqNeWx5RexRdj1AOLyTqvkj6D1eq3cPTNhfsXd33x9wI07lTRGKTKUk/8+f9Q
	pCw7o+8fcEH/frp9mUtGNBHXBS6yEOP3gRzIvXp/CvjwxkXmJF20++3VTlBF6enH
	GKW1eb4smQg4TNhxnIuKZ02Kd71FI2V92Ho3/I6WudUmyR05Sg48UTD3pjhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736402284; x=1736488684; bh=1CazECn/QgLLI/3i49afXAms9aEsFNVIfPu
	gyMqKd4M=; b=nvnunzeAucX6TG7P0oMuwJLaEUwxVvkPeX44ApaVPboZs5mEGyY
	1c5rUskkArzDqkwgDasxIsm+SPXPkFK2S7r+aiKs2C34gmlqLmJumIF3Oe8NTfBD
	f80DCE3C6KVL650gfMMLXRyFFyxrMSH01cZhtVzf6wFnsA8J67cxAUXLo+bMbYWx
	JY2cqbrSMjEsE3FkP3cDTbQBtsr91RGW5uuPml/hZpuYsG5acSV7xJ2GA/X0YLA9
	9ohOG/iPeFnFvodprFUhow9lYGwHY59iNh4Ok6MrVS9zSkfn0aNziWv74VyK3c6T
	mkAoPMm/QkT1sQpyXMmkEAdbDN6MCrk7BdA==
X-ME-Sender: <xms:bGV_Z-k0YD50fItD63xaFsbLX2CkW--xZVtEkdzFiq21e4eVX5_B2A>
    <xme:bGV_Z135QRu-MQ1xPZEiovdeZJn4gY2Tkl_1dkR9OYz9xES8rtqkitAZTvkjRCh3h
    NcSvVSLx03DpogsSA>
X-ME-Received: <xmr:bGV_Z8oSPWC66Om_6hI9bjRSC2EQvN4YgbF9uGatWFAyu7ePwl9HhyBX2IBri2DTa-VMbkTfz5pWYYxaDaCeukU2FeTCNM1J7j3REG6a7ravkrNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejvedugefgff
    ffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bGV_Zyno_Zt5RXuxJSA7JjV8VsPM76iXSNXqM6Sy1RQhOxEG_MJuaA>
    <xmx:bGV_Z81zwFltoRpLxrcD--61izbRxXvimOSi92Z5_ZtdV66RDKPRbg>
    <xmx:bGV_Z5sY3iY_TfGyp72SrDypBWkuwHeG8ANKtAnMzOE44QQbuzTp_w>
    <xmx:bGV_Z4VNLaKN6VUGv_S76xfeBLZEb3H3CMcEPis2XI2ndgoSuaziiQ>
    <xmx:bGV_Z5zW-KwYG9jXi8IMVugLclIkjHd_po1BxFWIqCqgrUk08aCvA-Z8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 00:58:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1c82d89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 05:58:00 +0000 (UTC)
Date: Thu, 9 Jan 2025 06:57:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
Message-ID: <Z39lZ1E6zm88PgCf@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
 <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
 <Z3LNVzw9UlS7SWqe@nand.local>
 <Z3fhK1ACzJfVehM2@pks.im>
 <Z3wsZjAqbfI/EdVe@nand.local>
 <Z30YvHKjA_b6_xwt@pks.im>
 <Z37QS/MnGUZ7zcrR@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z37QS/MnGUZ7zcrR@nand.local>

On Wed, Jan 08, 2025 at 02:21:47PM -0500, Taylor Blau wrote:
> On Tue, Jan 07, 2025 at 01:06:20PM +0100, Patrick Steinhardt wrote:
> > > > > I think we should perhaps combine forces here. My ideal end-state is to
> > > > > have the unsafe_hash_algo() stuff land from my earlier series, then have
> > > > > these two fixes (adjusted to the new world order as above), and finally
> > > > > the Meson fixes after that.
> > > > >
> > > > > Does that seem like a plan to you? If so, I can put everything together
> > > > > and send it out (if you're OK with me forging your s-o-b).
> > > >
> > > > I think the ideal state would be if the hashing function used was stored
> > > > as part of `struct git_hash_ctx`. So the flow basically becomes for
> > > > example:
> > > >
> > > >     ```
> > > >     struct git_hash_ctx ctx;
> > > >     struct object_id oid;
> > > >
> > > >     git_hash_sha1_init(&ctx);
> > > >     git_hash_update(&ctx, data);
> > > >     git_hash_final_oid(&oid, &ctx);
> > > >     ```
> > > >
> > > > Note how the intermediate calls don't need to know which hash function
> > > > you used to initialize the `struct git_hash_ctx` -- the structure itself
> > > > should remember what it has been initilized with and do the right thing.
> > >
> > > I'm not sure I'm following you here. In the stream_blob() function
> > > within fast-import, the problem isn't that we're switching hash
> > > functions mid-stream, but that we're initializing the hashfile_context
> > > structure with the wrong hash function to begin with.
> >
> > True, but it would have been a non-issue if the hash context itself knew
> > which hash function to use for updates. Sure, we would've used the slow
> > variant of SHA1 instead of the fast-but-unsafe one. But that feels like
> > the lesser evil compared to crashing.
> 
> For posterity, Patrick and I used some of our monthly meeting this morning to
> spend some time together pairing on this idea.
> 
> It ended up being a dead-end, since this approach only protects you
> against changing the hash function mid-stream, and not using the
> incorrect context type from the union.
> 
> That was along the lines of what I was originally thinking, and so I
> resurrected my series to introduce 'unsafe_hash_algo()' here:
> 
>     https://lore.kernel.org/git/cover.1736363652.git.me@ttaylorr.com/
> 
> I got the impression that Patrick and I are on the same page there as
> that being a good path forward, but I'll let him chime in in case I
> misunderstood anything.

No misunderstanding, we're both on the same page. Thanks!

Patrick
