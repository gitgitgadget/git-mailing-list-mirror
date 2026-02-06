Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0462DEA6E
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393335; cv=none; b=uZMVI1GianRaxk+8+InxAaaEGnKvKvXv2so0jLo9wE1cAWyWiwzP+HO/hgA3MhQ2H40bPKmNmCaw4aHjJdwWo6UUtgZFv1QzvUEHq9ArnQqAlEHu2dqHHF9+MyVsFQCHFqdFoRFtGHRttxjbR/OSKNQShlxyHWuBcLFO0MQkkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393335; c=relaxed/simple;
	bh=vnDQ/kBbDgApbTHO39Xgqib3AQtuyRoSY2jXTpwPvp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBRtYhsSV5UPS+mbe1WdsDq25KDZDzHwkge6UFoEKL96YdziLbtyPCnFy5vkqioqwCmIIWXvx2LTRi2acIjE71kn+3ha1Tjz1lxQPcnLP13/JV1V17/qkyHhG6iAAHDnN9ff16FLxOxCFCfoez0Za05sob/4XpyBEmo9J5HCU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZtqhVADg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTEPgOXn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZtqhVADg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTEPgOXn"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3B207A00BE;
	Fri,  6 Feb 2026 10:55:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 06 Feb 2026 10:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770393334; x=1770479734; bh=XrOhKcibf4
	fEJC1Hwa1nCl5KE1NC1s3c9ZMaq8BrIuo=; b=ZtqhVADg9NEo5QF+GmMQcZsmz5
	E/HsmBTV2pNRPxa48WN1b7PiJgA40cY4AannNSEn180MIaprCYFP3Jp0dPiRr9ab
	3cCZd3ngHTvorYivRSIddYXFFFpRruxxoFU7p8hZ9sZcox8QZrQncQDqFGRzUgj9
	C8GG5nkwhMIKTmD9jkIbyjoowvO6atGVBdRRiiTAi6FYRUzQfxuhTSBihLKcdV17
	fTBa+zi1vqQg5sGCC2pYJ8ePbJ69XcKowoPofyWQui2sD7a8f9JpPfvPTon/lBMI
	f14AfOawxFAo+/XJxSC5OdjuEuTW3MbYKJNVpxPmtRIbJpDFL9gf35fivedw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770393334; x=1770479734; bh=XrOhKcibf4fEJC1Hwa1nCl5KE1NC1s3c9ZM
	aq8BrIuo=; b=vTEPgOXnW1uAlI2RQf7mG8059ZWaXlkcYAu4SO8EoE1nBBD/Q8a
	unq/7Aq1w3xLbi1QnS0YqfqOeyw4fTfmzksd1MczNp0rt9BRtA/ZTkxgvsXF5SBu
	2yHLvVOCzRapxP7nOZ8qMgTjUhZCAOKXJNkVsr/OSDqNhPNnK4KeiyAQQTgMSsO0
	jSt2PHObTgFcqIs7ckz4NAPCj/MNPzBJscWu4131wFbnhqVOh8ysNWyJHvWa8FTl
	hZ3zElvAp3yrCcUag11a74LhYd0kFtPyCKe8eY/4jjOp3pA0MoicV3vw7BRsnILs
	CL6wehoBtSsdJbHOSHhLCSenUklZzyeUtLA==
X-ME-Sender: <xms:9g6GaWyVeLqIh1FSBXi9BSlzsfl5RBECya-d9pn1jHttK5RPsiC1Xw>
    <xme:9g6GaZRnVYbTS0XVBMabq14_TAWTJdK0R3QqYC_oJV4B0uqnu1yvBlsfk0ixyW_km
    N1u2FuZ5orF1944SuYM69jaEWV4xbWgGAuCg_35AXMN77NelesJqw>
X-ME-Received: <xmr:9g6GadUfxi_A8J1qiiQ0EEU6Nd-bGgVbyNFBKkmyvalyqIRBDN_XWM4c6eKqT3gfgzHDL1UFIj78nce5-oKiDgjOt9P9qyYajg-jhHEKQwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhm
X-ME-Proxy: <xmx:9g6Gabb5cD8Kqu5uiy06psvwS7Ouh_N33uVPTs8fyfWYMpS2m5BOqA>
    <xmx:9g6GaT0MfTinWbDA1itNk3QJY6uNjFLLnQIJXh6IkXcMRUgiap8PvQ>
    <xmx:9g6GadhRD-OjuGlxfI0To0zTHt0aZtnqx3ZX_vYawk8pKz0hfFZdPA>
    <xmx:9g6GaXb8GLxI8Ye8atLLYDNxe-2_SbkH34IF05dEM5iGsq7KhLmsgw>
    <xmx:9g6GacFZhoD0YX706Hfzy0Q734kGz8lLRqk1d1yRetMHZTcS39-T-40J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 10:55:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4cd9520e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 15:55:31 +0000 (UTC)
Date: Fri, 6 Feb 2026 16:55:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v6 4/4] last-modified: verify revision argument is a
 commit-ish
Message-ID: <aYYO8Ph5yTE1ip-q@pks.im>
References: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
 <20260130-toon-last-modified-tree-v6-4-db827e5df985@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130-toon-last-modified-tree-v6-4-db827e5df985@iotcl.com>

On Fri, Jan 30, 2026 at 03:26:38PM +0100, Toon Claes wrote:
> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> index d1aad12319..ec5bdc6aa0 100755
> --- a/t/t8020-last-modified.sh
> +++ b/t/t8020-last-modified.sh
> @@ -30,7 +31,7 @@ check_last_modified() {
>  
>  	cat >expect &&
>  	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
> -	git name-rev --annotate-stdin --name-only --tags \
> +	git name-rev --annotate-stdin --name-only --tags --exclude=t2 \
>  		<tmp.1 >tmp.2 &&
>  	tr '\t' ' ' <tmp.2 >actual &&
>  	test_cmp expect actual

It's quite curious that we need to explicitly exclude t2 here to get a
deterministic result. But both of the results are correct, and in fact
I've seen it once before that we got different results on different
platforms.

Sooo... weird, but I'd say we can live with this weirdness. Doubly so
because it's not the fault of this patch series.

Patrick
