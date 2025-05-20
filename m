Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EC25E80B
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767985; cv=none; b=HAYLKz12Y+4e3v1OINuRiuGSfzaciQrUkz8+EghcNenDtrDYW4Y9HO413e2HTzwsYRV74K+WmYbJRxLuLKbR6DsIoHhuwBAEWM3zIYk6yHQMbs0zYMnZkvxffrXb5E5PyTyLFaWRsanF6AV9WcqUQNRd1/H4QNC32x7ALBjoaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767985; c=relaxed/simple;
	bh=I5KMOSktnfvnkbxJEp+P5/r4UAebGIM/IBiet2BVEFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bwQcBqfByTbLfIbSbqzc3IZN7ty1f4/TTSUpdrpeITTCFuOISHyHlPXXerL7LMXyqWxKt+8rU2J14UpvA0fyNWqTG/oTFfeFAhXJXHMpOcCbORLqEXDIXqV6VevJj98ouNu7hjLO944xMKBO2J49hQZaQrDhj40bezN2pwNsWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bQEaY8nF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efJJeYGc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bQEaY8nF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efJJeYGc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DC84111400C6;
	Tue, 20 May 2025 15:06:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 20 May 2025 15:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747767979;
	 x=1747854379; bh=g58KrY34y2+S1OqB7mKiAtORbMhXGOi5NeTyXAtaGC8=; b=
	bQEaY8nFz1FAKmmRpr+yiiCnGzL1ZwGIlfJYKx93jD2T0jVwkGRPGIjJZIdSnKTo
	UIwAtORhDXBH0twz7t0y0O1y8qrS/VWrypck0O8eDBivP0sNXU6bAR3gJSZXRJTe
	fuRCABo1EV72v4N4sXd2MSh38pVVOMpreScJOpwa76uZNKglDOKZYdlx68ngLd1c
	DZSDOcEMxJRK5m1gO3Z7YfyTLDf7SnW/7lofLDucVMRdbXzirisPOWsW3d1FgDHQ
	rOyd799NNa00mZrdqf8brOKSrsC9KKouJRx3DMwkcwKATmXiHybsSKQHdQTP6an6
	PkNU9nxrjBs9B7//AUjVeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747767979; x=
	1747854379; bh=g58KrY34y2+S1OqB7mKiAtORbMhXGOi5NeTyXAtaGC8=; b=e
	fJJeYGcZI6Db7XPa0ucOxP++bxEcrnhdwYeL3NM1g28pawf50yMfQAQHzG4wT9kM
	GWr8LRPLfzPmWRE7THrQkQIUXKSHX1lU1f6gDyTVEocMCPfrxA52EDAvt09aRGtV
	U1O8WnMX5ZDoQ8IRLx+nX/UUp0Sl8uHIMF1r/SsXHC/fGq1m0sLG/5sOdVz//4Th
	9aDZsepgqj5z0ofXIjFjkcbpNeYlCaGsY4uWtsOcem/CeoGxtw6OVHIYmt9GZY1j
	h6HJN2SOGpL8zoKhDndvYDmBkGj2JTGGGXTxVFQhWSPn+TulbCQSBLFT/hDvOhWr
	IXpZ7GMOtbd4hS4Nqmj/Q==
X-ME-Sender: <xms:q9IsaHu56smRi5B4Ohi7iCN7j5j4SukhVDtMQkkMKQjlbgaIzmRREw>
    <xme:q9IsaIeX78qZOvy0yw93HisR65ap1ywU7cT06kwkBpuModhaN3ajr8OkeuZnN7_y7
    XmHqZa7qvxkJLhU_A>
X-ME-Received: <xmr:q9IsaKwm-2OPbj1Nww8RXREFuuf9h_7AbFLRcaALzKXBZf6Zka33OGOWgy2RLCwh1OkWEpVt7BKvSh6DTrMtPoXwHRk-PDCJnNk7GBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomhep
    lfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqne
    cuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedv
    keehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepugihrhho
    nhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:q9IsaGNrIUo7Xg64Pqqp7cPhT82-zI5T5R1w0lW924x-lSgHGHDd-g>
    <xmx:q9IsaH9vPaygOSh_Lcclzm3XEub9bOM1zZkIoGlvqlLFY2nqZIgTWQ>
    <xmx:q9IsaGUvT_RnG3XEXI0vuR63msL_d29UbebK3NQVu9CrPUDtWonijw>
    <xmx:q9IsaId9BeRiDE96T3fq768s8CnNuwmQ3THYie669uy2bZ9gQrC8Tg>
    <xmx:q9IsaMj9PyfSfC2XOoN-InEkK5Bq_zvU-gMpAgiItrbBKfSU0yIcQB3s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 15:06:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 1/6] doc: stripspace: mention where the default comes from
In-Reply-To: <630ef019786bdb0c7538cc9794a7ba53a0ac77d8.1747763769.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 20 May 2025
	19:57:19 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<630ef019786bdb0c7538cc9794a7ba53a0ac77d8.1747763769.git.code@khaugsbakk.name>
Date: Tue, 20 May 2025 12:06:17 -0700
Message-ID: <xmqqjz6bhzkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Also quote `#` in line with the modern formatting convention.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     “modern formatting convention”
>     
>     It looks like characters are quoted with backticks in the commits I’ve
>     seen by Jean-Noël Avila lately.
>
>  Documentation/git-stripspace.adoc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-stripspace.adoc b/Documentation/git-stripspace.adoc
> index a293327581a..1132a4cf9a9 100644
> --- a/Documentation/git-stripspace.adoc
> +++ b/Documentation/git-stripspace.adoc
> @@ -37,7 +37,8 @@ OPTIONS
>  -------
>  -s::
>  --strip-comments::
> -	Skip and remove all lines starting with a comment character (default '#').
> +	Skip and remove all lines starting with a comment character (default `#`).
> +	See `core.commentChar` in linkgit:git-config[1].

I've seen this kind of thing treat the configuration as the first
level default, with the hardcoded value as a fallback, i.e. spelling
it more like this:

    ... a comment character.  Defaults to `core.commentChar`, which
    in turn defaults to `#`.

The way you phrased is syntactically easier to parse, but to some
readers, the readon why they are encouraged to learn about the
`core.commentChar` configuration may not be immediately obvious, so
I dunno.

Thanks.
