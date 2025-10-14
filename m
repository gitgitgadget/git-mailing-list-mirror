Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477842DC320
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433562; cv=none; b=mOPipBhWPRS2m1JYUjEOP1Bo1YlbRyifQkwJWkXsQyzdqYRGGKKDwZ0QenqOGDMMSyJlQY4BpA0v+0b5DTZGzZTFbrK8inZoF6kFq0GGIHBkbIsrkB+e3EJjzv7xXptsUtppp15VDXJQj/Hx6V1hvY0wXMCwM+7aJbdkjNYlpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433562; c=relaxed/simple;
	bh=N2khuelPbS5yZjfGD536/4tvEl6YlXkOlJdy9cvwkJA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j6YDhdOEmFcSw8FZq6rRZHs7YHqEmidu6vcDdr/qBIv8i/z961YUk2DU8TuQiFxK+TOIL/KavQIDy+Wap8E5QuNnoxowcx7YM6tcyT9AzI4b0HlZSmZ3tz5wQpwD7OHfsKxVxPp6ZTv9UxDMO13aJNb9m3TuFqdv8nvD6P55vcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=EzHY5QaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sqYlTH1K; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="EzHY5QaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sqYlTH1K"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 01898EC01D8;
	Tue, 14 Oct 2025 05:19:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 05:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760433558;
	 x=1760519958; bh=gDwHqSsNPOBGJFf9cdtQoaSUejdJ+iZHQyC3VDpuWtw=; b=
	EzHY5QaOH6YTm9zDEakHqePzi3sOGVojRz8XCMyrtV93rn7xQJGuYs2AZycyhs/K
	JadekllFT0j6Z5Pr73FJ+gu9TbZcIpdvdM1r1sTA4Bl7cfpglIn6BXCWRgsuv0+b
	xcEeAcRoLI4t1eoHkhTJ3XZH7nZUh9mS2Y24Ok+zDcMfUJPtulh4iFyY8p8zrtrY
	dNW5arZQyPnxyC3toza3vKfhLE+NH2Pn+ResrDVpgrBFnffoMPPdmN76eFMrwtA8
	GfOVQSU2BVw3Bk596ClpdfpM8WBVCMMzG6Yr5lD+Whb9ghhb5wq7UPJhETdCDjxi
	zUgr3CznDXqCRwJbsEwV8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760433558; x=
	1760519958; bh=gDwHqSsNPOBGJFf9cdtQoaSUejdJ+iZHQyC3VDpuWtw=; b=s
	qYlTH1KXS+gK7845uXBxFGJz14L/+I+JwMmSOMocKdzQGoE3ZoEdOCfcq3NCubM/
	PvoanEgsnwpGyKFunz1LDEkqy54hPWkReJSaYacq/amwngTnxxwqSHHgYojvsdp9
	zl9xGekzKAoWAi/Wq/1F71tr5UJuctsswskBY89IGMY36FB9g0qYN6KQd4WpCiAi
	/1Ee1I9MnzjFvK5Oj5qaLtNDLAEUhFy9F8l37DHM34Y9tTTvbQD9roEBBOvY6FZ9
	dOFio+uBsVkNGNmXv2pNSU/B/T4/3MJqaiO8GhD4I/v4kfpII0laoJcJO85XFkI/
	2AAKlMai91xZi0MKYurfQ==
X-ME-Sender: <xms:lhXuaNdpf7QakuyE26OdHMH5dPSIn2bA7fyRJFv2iP72SD57d_YyfA>
    <xme:lhXuaGAOGjNJ4JF7V_YXnl-FFEUSNYxMoCX1IUNa4-cLTn_OQ58Tto-lO06vBPu0W
    cWDYawjDxzm0qwkm18IjYDQyJoDj2C7tdOcwTbDJI33-emxKoyBvkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epfeeiieeggedtfeekjefgvdetjeffhfevuedutdetvdejgfegveffhfelgedvvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lhXuaPL5a_b_Y9X308nLE0lmiTKBf42x6JkRMrOg3vP92c1chSSuHw>
    <xmx:lhXuaMdHjhlNYVoORAW1BKIP-tN4Yrc0c7hVpGpsQ9f_PDW1lEqZQg>
    <xmx:lhXuaO8o-9mKvsNVvDxpsXLyhGfvK0cXWhOZLCPXzMV9d5QJzat4vA>
    <xmx:lhXuaJpGOwSNDcpes49h03kLcNBfd3y1FTOxdADzvGdc85M6sMQG-Q>
    <xmx:lhXuaNTaJ_QHLsCEwby6wUQ6bdT9wfyW3Wmkp9pHHPWySQO-Br4goQ3u>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA4F7780076; Tue, 14 Oct 2025 05:19:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Tue, 14 Oct 2025 05:18:58 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <46c6ca15-c1d2-4dd9-a6d3-2538f482b475@app.fastmail.com>
In-Reply-To: <aO3jbnXRI67JsAx7@pks.im>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <aOjzQ7-88m5e_YJl@pks.im> <xmqq8qhe5040.fsf@gitster.g>
 <aO3jbnXRI67JsAx7@pks.im>
Subject: Re: [PATCH v2] doc: add a explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Oct 14, 2025, at 1:45 AM, Patrick Steinhardt wrote:
> On Mon, Oct 13, 2025 at 07:48:15AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Wed, Oct 08, 2025 at 01:53:41PM +0000, Julia Evans via GitGitGad=
get wrote:
>> > [snip]
>> > Not quite true. Pseudo refs are outside the hierarchy and are in fa=
ct
>> > treated differently. But root refs are treated the same as any other
>> > reference.
>> >
>> >     References are stored in a hierarchy. While most references are
>> >     stored in the "refs/" hierarchy, some references with special
>> >     meaning like for example "HEAD" are stored directly in the root=
 of
>> >     the hierarchy.
>> >
>> > I don't really think we should get into root refs vs pseudo refs he=
re,
>> > so maybe this is sufficient?
>>=20
>> I do not think "root ref" (or pseudo for that matter) is a concept
>> that has no use in this context.  If this is really about data
>> model, where you find refs (or what the "pathname looking" thing
>> exactly look like that names your refs) should be immaterial.  It
>> does help to know that HEAD is just a ref.  It also would help to
>> know there are symbolic refs that point at other refs, which is much
>> more relevant to the data model.
>
> Yeah, I don't necessarily think that we need to mention root refs here.
> But what I think we need to avoid is the following sentence, as it is
> misleading:
>
>     References are stored in a hierarchy, and Git handles references
>     differently based on where they are in the hierarchy.
>

Why do you say that it=E2=80=99s misleading? (what do you think it=E2=80=
=99s implying that is not true?)

What i=E2=80=99m trying to communicate is that branches, tags, etc are t=
reated differently from each other and that Git knows how to handle them=
 based on where they are in the hierarchy.

> Pseudo refs are stored outside of the hierarchy and are indeed handled
> differently. But root refs are stored outside of the hierarchy and are
> treated the same as any other ref, even though they of course have
> special meaning to some commands.
>
> So maybe something like this would be preferable:
>
>     References are stored in a hierarchy. References that sit at the
>     root of the hierarchy often have special meaning to Git commands,
>     like for example "HEAD" or "REBASE_HEAD".
>
> It hints at the fact that these references are special, but not in how
> they are handled but rather in what they mean. It doesn't go into our
> two pseudo refs at all, but given that there's only FETCH_HEAD and
> MERGE_HEAD I don't think we should explain them. The water is getting
> somewhat murky around pseudorefs anyway, so it probably only causes mo=
re
> confusion.
> Patrick
