Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFD14D6F6
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654367; cv=none; b=KjMtUXEcLGDaf1pL/FNg4w77m0TsWnG/HkrXFX+6JBPFVAuT+bgJ/bnwmio+1K9Ejitrfl2P/jZCHuwLcj79QUB0NuJ93j0PU3oYHdpP8FkhdzrrxWhOLNcvUzvVeUzWmPrAtuEnNR+jn/yID1fiKi0bBBGIcUCjEOvSBcWTYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654367; c=relaxed/simple;
	bh=ErHz2TUkOxjGB/ghwcgpWHik1CR8xgY33DTH4ErGQJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUva8i4AVgYqlFxWAjh6n/3Q3iwBMXADft+8P4+207LQqfYdX7vRDUKxWnjOy7QK6lZA92wvndi99O4sjNp1MpVeVs91Ekkth8gueAfhV5rttrFhbcZHsS/q+7ZN3WNWXMn4+515WsZF+eZBf3Nar8e82eq4OnBBZ/aQ/vmc2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VUeU4a5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWkavULB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VUeU4a5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWkavULB"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CA9811401C3;
	Thu, 23 Jan 2025 12:46:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 23 Jan 2025 12:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737654360; x=1737740760; bh=qHNEVooiNT
	fg49sUXBOzk7tZ48Xg7AIIlyLAPNmux1w=; b=VUeU4a5bbGfkmSEki0+uHcye1h
	YvU465WM8v8VN6/iqYLYW8k+//vlNKfkg2wzXim4eXKqZSa7AD8bTf8z8eRgRrmk
	9EkD4gGLemmTq8aLRe0QRLJFVyRzxieJZlztHK+diM84spMFWuRhVeXebpgnrPPx
	UCnzdzrPmy2Xvz55nd1Ea+Oe5svIFVKHZbaJjqkp19RBUegEeRpjLRk8XVF0sYdQ
	XxtRXfpvLePQH/j7EtV3Zu5Jo3NOLKBYwcK0Ycr1PMkeD3u+ndi3rHQxW0WktaQT
	s0LB0ClYarbyCC0ikK5lvZgRBXkgRW2t2KU0ZVdhLscWQg+6+/jsQCE0CFdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737654360; x=1737740760; bh=qHNEVooiNTfg49sUXBOzk7tZ48Xg7AIIlyL
	APNmux1w=; b=VWkavULBbecQXFLHptoJM2TF2pKoO1L6pvwLR9ZMSro6eaP3vvZ
	XT1MfzFGoe+0W/hi7QdJ4qJzzJTsfMbdOMNVZpjSZ2r050hkmxCJnKZUJwpMh4cX
	AO/i0RmNHceUkbsJEbUeKgFmem3jI9mYD8jIeZVcBmZSc54FrLISoPKnS4GNLY9g
	qwLohmZxjLlhziCvT13Gu4qjFP2rGhoNj4P3TGMM9oJ7bdBtnv/CcPz2Nx7VEYaG
	dTP4YY14DEy/EXhqyo220br0MPNd5GGiUkaZiUhsZ+UcGFtBu3CLUwIZfDoEZYyU
	Jg8zb1oTKtlmy+tezOmjRVWn1NuAjW1Siww==
X-ME-Sender: <xms:WICSZwvSJuNMVe8fNSq7I82IRlVUUtYpVIgLgYrZyBWqZGVs8uKJ0Q>
    <xme:WICSZ9dsVwxRbtpRTOI4b08bnv3B9tz3sfyFQYgx-KRZElreXIqpPPImIMSZOxeHq
    zJQNpCXojwFDCM9AA>
X-ME-Received: <xmr:WICSZ7zZloyKf_ew3JYbVOIlIL1nhCwyDOtdWe3N2qN9VIa_igRggBffWEALZPjt6_zBC5ViJqo7MfQtYURnqpHnivXQmLazssLMCssxvv6Li0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:WICSZzMJDWpnQc10eOcdZxv3IErVAYneKvAo5TScJnUn8aoMNaL8FQ>
    <xmx:WICSZw-BGM_jTAY__KHBDJIUyreb-bTya8x4jWlIXHlkPJGN9lHGOw>
    <xmx:WICSZ7UJHa7RVW5BmUfQzJjHgfLcRSWFo4fpKxDMZzQvd1UrnTxalg>
    <xmx:WICSZ5dRj5TwpcDFJOMmaYOGf1WdCudRXhgjGu4f6CHjzxswUQ074g>
    <xmx:WICSZ_YQlzJISQPc9vKa9HUPFH3TEGdJ35S0gOn-4tjISafzsYnx_CAL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 12:45:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43805807 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Jan 2025 17:45:55 +0000 (UTC)
Date: Thu, 23 Jan 2025 18:45:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
Message-ID: <Z5KAUo4FeG2M1mIa@pks.im>
References: <xmqqwmetgdgm.fsf@gitster.g>
 <CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
 <CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
 <xmqqldv1tpgp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldv1tpgp.fsf@gitster.g>

On Thu, Jan 23, 2025 at 09:22:30AM -0800, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >>> * kn/reflog-migration-fix (2025-01-15) 1 commit
> >>>   (merged to 'next' on 2025-01-16 at ae8f9ce9a0)
> >>>  + reftable: write correct max_update_index to header
> >>>  (this branch is used by kn/reflog-migration-fix-followup.)
> >>> ...
> >> This seems to be breaking on 'next'.
> > ...
> > reproduces the issue. I haven't found the root cause yet, but will
> > mostly call it a day and get back to this tomorrow.
> 
> We have a handful of topics related to refs subsystem in flight,
> and I am a bit lost here.
> 
> (1) kn/reflog-migration-fix (the above) was done as a "fix" for the
>     issue reported by brian in
>     https://lore.kernel.org/all/Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net/ 
> 
> (2) You mention that (1) is broken in the message I am responding
>     to.  There is no known fix yet, so (1) needs to wait in 'next'
>     until it gets fixed.
> 
> (3) kn/reflog-migration-fix-followup is a code clean-up for (1); it
>     has to wait for (2) as well.
> 
> (4) kn/reflog-symref-fix is a fix for a different bug the commit
>     that introduced the bug (1) addresses.  It can proceed
>     independently from the other topics.
> 
> (5) ps/reflog-migration-with-logall-fix is another fix for a
>    different bug introduced by the same series whose bugs are
>    addressed by (1) and (4).  It can proceed independently from the
>    other topics.
> 
> The above is my current understanding; did I miss any other relevant
> topics that are related to these efforts, and/or did I misunderstand
> the dependencies among them?
> 
> If I am not misunderstanding the current status of these topics,
> I'll be marking (4) and (5) for 'next'; I am undecided for (3).

Karthik has meanwhile sent a v2 [1] of the broken patch in (1) that
fixes the issue discovered in (2). Given that (1) has already been in
next, (2) probably needs to be rerolled to be a patch on top of what we
already have in next.

Other than that yes, I think (4) and (5) can be merged independently of
(1) to (3).

Patrick

[1]: <20250123135613.748916-1-karthik.188@gmail.com>
