Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA82FD7B9
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546090; cv=none; b=DO51NWzMC5LG8jpnU1/6fMWsikVtuZGmc7tk3De0gTPcsOEagIPYh43Lo2334UUd20VpjoHH5CxUQGUnoCFzg0AzjUjVZ59NeXzVdWFjzFHRJic3/bBI4QLeyFxjVENbuChZbcaCxS2xrmuABbqDfrfP4ykT4vSF0NV58A/eGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546090; c=relaxed/simple;
	bh=9X8wOXe2se1CrIMXecZwYGBerGj6EsXpNPeRIM6hSrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxjguozRGNEz8oR0PHX8SyILm/qy27ld9SFwkslcXLDDsdkgelb2Z83P9fhuB6idFR5Q0V6jMbuz8/uhZlST8IPuudbo9hNgH+iH53UZlaVtPtGKjiqkN4jiqhqS1OUbzqbi+8O1LQzXCPu6wCygaEpYzEyroq85Z6nHgQZMyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PmrG4s9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHIEX2ux; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PmrG4s9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHIEX2ux"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C1B697A0059;
	Mon, 22 Sep 2025 09:01:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Sep 2025 09:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758546087;
	 x=1758632487; bh=k2Wm9y3FBvBp0FHN6YGUDi5f4gTVjEM1EEzWTqlk/ok=; b=
	PmrG4s9wE3accSyb5xwSRcf5tS++f05xPeIynau1dkqJWH4miU9zf27J0wxqZzaN
	nfJTyn3e8PQouJfxjgFJGXX4XnImV65uzRr5qXfcK8o90QPuDbom0n4xIlM+imWl
	0Wk4+98RwzLjYoRO/i9w2Kgsmsov3JKtLsJrZnLsiG2AXyHpUR1QrtcBUTN002Lf
	qxiTHDbc9CYY6ZtxbgIGbKm4Wziweuu7bE/YdMLUNA/puKref/bE+OaqFlv6yx4B
	mULVRu71Ki51S6KRopPzKx4/I2xdigX9SG0Q081BWIsZ8I8oWxP6dAzM+djZ4/4i
	PSAlAbLcGzzsaw3Uj4Mnmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758546087; x=
	1758632487; bh=k2Wm9y3FBvBp0FHN6YGUDi5f4gTVjEM1EEzWTqlk/ok=; b=N
	HIEX2uxqqQW87npylhwOkT7IYOzk9MtFKhRKT5OjcghBq9K1xx3TjIMl/6smSLa4
	kYg6Qok4XrMY8T0GwOHqUPmOWLL3Yk6bG32q+S7guuYz74kOaosXZ7h83KQkCQyP
	/7oTU2/5OtXVs01JaABmo9V/XjD+g7r6by7AfRb7Up3f1Bp+OoVvptx6vX457bjm
	qc+CnDVNO2QZiYD60203L5EZkRm+ygDdXvQ+HoW2LaBvNf90zz8tE5sSPH7jerE2
	BdjIEOCz6PpoRbYYP08l9gPbrifTvA9kMBJomVUb3DDuex33jjUiVO2tYeqXcXFX
	r7pf35sucLJU0hCGJ3M6A==
X-ME-Sender: <xms:p0jRaMATrlbnKMj1fv-0N-fYR93m2fZhkSS4f5-kfDt9lzxA1b9HDw>
    <xme:p0jRaBzxWjd23hqtwMJFfDNAs9znkrhZ8GUeu3EMncxBH8cuBwTx4ynagy-H7gqVI
    opvOeAxGegfcldB6A>
X-ME-Received: <xmr:p0jRaJBU8rwDPP2GUrN-IPC6pdKtIfiYL0N_9XjVWdhZu1yT7VD91ZRW1AR89MwqMGryavjXTPwgjhuxd_eqyWf1DLyNbstmlXFuXd3Xhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivg
    hlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:p0jRaObcSGoYvD8L4Wspep61YhUEKcJ8N1TSwRNE1PN_bzBncazccw>
    <xmx:p0jRaBgzFto7cVU5Os70krcM6ymqxXm2woNTL6_ni6eCvP9hjOoo9A>
    <xmx:p0jRaA5bTiVofTPqiiHZamFNN9uOQuLtai8FpZnFQh6ezjZJzcCEqQ>
    <xmx:p0jRaI4ZQsDZdoIJoeKZAK2u5XYBbYlTOXVA6Ihz6rO24L150uorAg>
    <xmx:p0jRaAvdmvd5SJOTM4IYZ7xrXHojFieKl2q2B65yUCO7IstPc5n9aDc3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:01:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2af79459 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:01:26 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:01:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
Message-ID: <aNFIozagGc0MoseL@pks.im>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
 <aMpODEpyaaVhFMO0@pks.im>
 <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>

On Fri, Sep 19, 2025 at 02:57:58PM -0600, Ezekiel Newren wrote:
> On Tue, Sep 16, 2025 at 11:58 PM Patrick Steinhardt <ps@pks.im> wrote:
> > Given that this isn't yet ready and given that this patch series is way
> > bigger than the one I have in flight that focusses on introducing the
> > policy [1]: how about we first merge that one down and then rebase your
> > patches on top of it to iterate? It would reduce the scope of your patch
> > series and allow us to make smaller steps towards our goal.
> >
> > To be clear: I very much think that most of the steps here are quite
> > sensible. We definitely want to introduce cbindgen, we obviously need to
> > introduce support on Windows, and I guess having multiple different
> > workspaces is also something that could provide benefit.
> >
> > But there is no reason to have that all at once, so hence my suggestion
> > to build out the infra one step at a time.
> >
> > What do you think?
> 
> I think I made a big mistake of not making it clear that I intended v2
> as more of an RFC. My worry (that I expressed very poorly or not at
> all) is how hard will it be to apply my patches on top of your
> foundation? I don't know if minor or major changes to your current
> path would be needed, so I proposed a different way to Introduce Rust
> while trying to incorporate work from others.

Ah, fair enough. Thanks for clarifying your intentions!

I don't think there'd have to be major changes to the current version
of my patch series. The idea of that patch series is very much getting
buy-in regarding our roadmap and focus less on the actual build infra.
So the changes introduced are mostly an MVC, and I very much think that
we'll have to iterate quite a bit on it, but that's intended.

I think that a lot of the steps you outline below are logical next steps
to get there. If I can change anything to make these next steps easier
for you I'm happy to do so. But I also don't think it's too bad if we
have to change the current infra quite significantly to get there.

> I wanted feedback on:
>   * Cleaning up Rust type name collisions
>     * People don't like it, so I'll drop that

I don't have a strong opinion on this. If it creates issues I personally
don't mind fixing it.

>   * Have Makefile produce libgit.a correctly.
>     * I think this is a good idea, but it doesn't belong in this patch series.
>   * Adding Rust unit test which required fixing Make and adding
> build-helper to reduce boilerplate code
>     * I think this is a good idea, but should be added later.
>   * Introduce cbindgen to avoid desync errors between Rust and C.
>     * LIke other points above; This should be added later.

Agreed, these all make sense to me.

>   * What should we call the crate that will be the new home for .c and
> .h files in the root of Git?

We could call this something like "libgit-ffi", but I don't care too
much.

Thanks!

Patrick
