Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83B269CE6
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884031; cv=none; b=s1QSNaaCa5on219luVtc6NynVCC++kqy5pJSiHjdQTUbdiwQbTJld2s7oq8oxzwLlupiVxkhznVg1kvxvOXmZw4yDIRhthK6sKIfM+DDlyMMnxv9UvLlGjivYfJHFtE/v2vrkxTWjwPWFzW/ZoosEzfpU4yJ1wVi5S/epTCEBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884031; c=relaxed/simple;
	bh=zNL0wdf3UGPPZGB5FzvuE11zClp7z6IGN7yhjM7T5iE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=erX/ron+K8S2e6fZvywl2hy19q71ow7xNBC6kb6WKhxj0dqEt1PNA9+eTaNWI/0I3M8S9aPOOaZGD1K+MivywXCgYnWM/6cuHJCGePwiZIK2ryCChBkIGzagPgB7MppqCVZ+NBzJC4Rporp9unRYmkPDrfWCFcyPefcn4+yRrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zAcUnetS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X86dFqqM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zAcUnetS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X86dFqqM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C13C01383175;
	Thu, 13 Mar 2025 12:40:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 13 Mar 2025 12:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741884027; x=1741970427; bh=qx3vCD4pcc
	9khiyWHwG01tQckMVrtMgK1HZZzrQQAOI=; b=zAcUnetS4VJeve5CCjbUP1QHwl
	AnT0ov66wBzSF4HNgPpV/F5MxahysXQmXeftlxpHUNp0aHQrOnJArt6HEfxI9omC
	iBKbKWAJ6EzxFX6CX4YgUIuGWoO231HT4xQhjSFGl9zfJP5YEMQjiO2tpLFKTkQN
	klkySEwFEaVcI1oy2f5Bu5oQgEtj69FltqN6sEDcP831cYszUwChX4vFLC7pZebW
	KANSpibJQh9DPRWZQgx7/4HwJBLdNPEVFbX641vI4G55Xo0v+j/EQpOQ8rqM+11s
	lXwYzdsF4eDflcWRjoHRQcIcqTVsGCeRNCRCNSLvs+cut6YjOXLBCvRNVpMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741884027; x=1741970427; bh=qx3vCD4pcc9khiyWHwG01tQckMVrtMgK1HZ
	ZzrQQAOI=; b=X86dFqqMCr6LMG8jWLeB3pPwDgFvYSxH/eneUJ09SXqJUau5WPC
	mqbcPjjTM8slfvFWx6PHWLslyx0DXLahGFGcFYn2LZw6F6OYnSlAuC6c6or4xOO6
	eahwaSgqRkFDQcJbQ4PEhz2RPfqw2ncSXuSbETpM2J1a+PyEmh6plrOiKoKvB0wk
	z5tMvjxc067IEwXiLRXa5PaSuBfNa/XOHGyq+X6moG2m/Ek9MU+3sUdoxJe8jTUG
	A6OpPnZDsyx49bWXqVrnCKaV/c0b+0mzeEEecNZNOi18aUFwTNfhlgIqGJPh9jG5
	E015lu0nvYOTTQgLi+6kfiSZRefnk+DSXgQ==
X-ME-Sender: <xms:ewrTZ645QOcVirJhDT1TPWRO_dUkV3TwAmr3daz_-3RnV4QtSmFmFQ>
    <xme:ewrTZz7_iIIPFjf8PfXz53vYzNcV75crWq06wdNWWxnhwLxGcsBLo4Ubl7zj58WoZ
    DkQ2edZqmrXOd1oTQ>
X-ME-Received: <xmr:ewrTZ5e5LrKCWKNk7kRQJdWQPeQ8yAHA8AWXXDjkDeJwM1EooTp7XBoXnQbPEWbYUbANwcGisZNY5WaioLficwLpGY0CmqSZWSxYR3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:ewrTZ3IbuiaDWNuDQD1frbmdDnlZdcrURNNtWN2d6kwSC886OTl-4Q>
    <xmx:ewrTZ-LfQRc7tjZq2Pn0cqSPe24PuFUjtH9Oki3l25XdgMxsh5vMUA>
    <xmx:ewrTZ4z7b_cSK7ztYpBmF97XBGlaBE9r-YFoVCCtkFlVlMcLFb_SAw>
    <xmx:ewrTZyJ0W7Yp0ggtZk8JrgsnpuZKrADTiM5EeS5oq0x-jzMjrpVk1A>
    <xmx:ewrTZwDBNArxUueif5Ql5nrKLQL-RSSVqmDOl4DopJqSgTDa66i7aMSl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 12:40:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <CAP8UFD0QqUG5Gu-XxKi58sEA7VfSJk4gy9hb_93dCw+2QMABYA@mail.gmail.com>
	(Christian Couder's message of "Thu, 13 Mar 2025 11:39:58 +0100")
References: <20250311152413.1059343-1-christian.couder@gmail.com>
	<20250312114628.2744747-1-christian.couder@gmail.com>
	<xmqqecz2yyg2.fsf@gitster.g>
	<CAP8UFD0QqUG5Gu-XxKi58sEA7VfSJk4gy9hb_93dCw+2QMABYA@mail.gmail.com>
Date: Thu, 13 Mar 2025 09:40:25 -0700
Message-ID: <xmqqfrjgq3ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It could happen that the server, the client and the common promisor
> remote are all on the same filesystem. Then it would make sense for
> both the server and the client to rely on just the remote name,
> without any URL configured, to access the promisor remote. So if we
> want things to work in this case, then I think the server should
> advertise the remote name in the "url=" field.

Meaning the server and all the clients share the short-and-sweet
string that is suitable as a remote nickname (i.e. something you the
client driver would type to "git fetch" command) as a pathname that
is relative to the current working directory, and because the server
and these clients must refer to the same repository using this
mechanism, this in turn means that the server and all the clients
share the same current working directory?

It may be possible, but would that make _any_ practical sense?  I
doubt it.  I would understand perfectly well that the local single
machine situation as a good justification to use file:// URL in such
a setting, but not for the r->name fallback.

>> What other uses do the name/url vectors prepared by
>> promisor_info_vecs() have?  Is it that we use them only to advertise
>> with this code, and then match with what they advertise?
>
> Yes, I think so.
> ...
> Other call sites don't use promisor_info_vecs(). It was introduced by
> the lop patch series which doesn't change how other code gets the
> remote names and URLs.

Then it should be simpler to remove r->name entries at the source in
that function, than having to filter it from the strvec whenever the
strvec elements are used.

>> ... would it be so different to pass an empty string as to pass a
>> misspelt URL received from the other end?  Wouldn't the end result
>> the same (i.e., we thought we had a URL usable as a promisor remote,
>> but it turns out that we cannot reach it)?
>
> Perhaps but I think it would be weird if URLs are matching when they
> are empty on both sides. I think it makes more sense and is more
> helpful to warn with a clear error message and just reject the remote
> if any of the URL is empty.

Smells like over-engineering for nonexisting case to me.

>> The 'i' was obtained by calling remote_nick_find(), which uses
>> strcasecmp() to find named remote (which I doubt it is a sensible
>> design by the way).  This code should be consistent with whatever
>> comparison used there.
>
> I think comparing remote names case insensitively is fair. It's likely
> to just make things a bit easier for users.

Meaning it makes it impossible to have two remotes with nicknames
that are different in case?

Because the "[remote "nick"] fetch = ..." configuration variables
have the nickname in the second part, the nicknames are case
insensitive, unlike the first and the third component (i.e.
"remote.origin.fetch" and "Remote.origin.FETCH" are the same thing,
but "remote.Origin.fetch" and "remote.origin.fetch" are different).
