Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215E27AC28
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033982; cv=none; b=H083fJjx7ly8/rl43RyYwkMXVvFsmQCLsnwuzkpOycs5goCq6s/+dyfIT/haFAC3/XAlpq2uOoRd26uB6wMcMx9mFuKlHNqyluQmyMEO7UMrJJ5M6RDikBsVNOk9hQzkXKln6VLs5764SMPedGDsV8FRdV/LJH5PfzFOEq6B+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033982; c=relaxed/simple;
	bh=sa3wEbUIaBq/k2UUZrKUPRQfU+2ywF0KVBlBDg+ePjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVVIa6HgGatrljL2+8vXyAvD4e4gakAKxC6KpnYVG5hP3go/sIDVgFIh10r0ru5q19SnyuWLQAYHYDlprYdASPMlqD8zux2Ijz1VjNyWTTTy+bnR0vVyN0nfAOs2lU516btIvYYh1Wzb+f1oyBnwWgG0539rlwZ1ekGHYIf5vdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jnpZMOPx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1k2FHz0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jnpZMOPx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1k2FHz0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F59AEC008A;
	Tue, 21 Oct 2025 04:06:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 04:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761033980; x=1761120380; bh=L57ckDWLgT
	l48KReGQcxD5GJ2d3ATjDh2Z/0a/cv8go=; b=jnpZMOPxPMRLW+YQTHrHXmex24
	9R3lNvjnr6b1Q8quXp1xKHQzQNSMS417qyJ3Gdfosr8eJBxEF0rfuLwmvd6ZGbgV
	JT/hKBcNSTbBcq7lJe2m5oEuOClqav2KIUsGQe7szQRA23TGFf2YmsyxheOjEngV
	VspbVs876yF5jHGsINyZyjZPRWEzS5ewEl2eOdUhNy7ST9ZBZc0hNrJMppuQjPoU
	eWB7WHPJxl1vp1MrcIx/6duQOXVcTLLn4/JYdbplgT+ek4DT+JM41apnZLJFpiwC
	+R61G1cnfGxvx9VGtZM+OpG9Nyxs3bcdJCza+QczJJBgPf8XA370dhCRrTEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761033980; x=1761120380; bh=L57ckDWLgTl48KReGQcxD5GJ2d3ATjDh2Z/
	0a/cv8go=; b=I1k2FHz0ijbbAOcp0HdKU0WlLpeTHShycD2xYcK83BedNICfgEX
	6IoKdJWLmd3XeTSIwsMQbmn2YRLitCOlSRyAY64gOjHhvECDUNvS61lkaUbxc4xZ
	hngDBrVOoBfuHsN4jjVNVazWNYkWLrVPAxj+rl2w87TlcWqSx9rlCj27U+ztS6V7
	sETDRYhLL9XmvvlyKlIV2cy4VblZ/BzBfzGiKDMi59Y02Lv4ZX9bakQWjDllfreV
	syas30iBe8QdaHqr4MUhAMPuJWlI4q4jg3EWdtdJK3d2qhPNty1JLbQUS1lZxQUi
	izr7l+WQG8w0vn5GCYcgWKLnHiXUFslgpwQ==
X-ME-Sender: <xms:_D73aINFsmKf_lpmE4VPy5P2oW3BUXHY07kfxaM41o05fNKtgomwNQ>
    <xme:_D73aHJbkaGkFX53P9s0uiMety4lmgVJOfcb_069wVPzaw1_jM0FNpzOE6QEvEFUd
    l-XSK91e1BZQWdxpxKR7U8IW-4V8riUSSC9eLIzahZ45A8jZrAK>
X-ME-Received: <xmr:_D73aK0dnxXfGg7gO50UBE-7WTL3B5JQ__acSZWzlgi8lZgXrBHLmduKyiWdNx3iP-nHUa4_IEWqIBZgR6Qg3GXNkVirHeFlRw0R38tUEhCWww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghp
    thhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:_D73aLWWXe1ms1cGbxf5PVPfhfeda18z4fh9UjnD2cQk2AqeMVDPpQ>
    <xmx:_D73aMMMagK9RPs4IAp0rJnAe7Q-goHzZDBgo90-VhpmVBB7R5OvcA>
    <xmx:_D73aO1zRyPfpRx_Iopnui5YzKuA_tHIM0PRpSNa6LCpB6Apd23GFQ>
    <xmx:_D73aARl2msHG4io7ktQGf-6lMCYpghkiSePeKi44G0YCJR625YrqA>
    <xmx:_D73aBPkYnQW5SXU5YQgQIT6b3EcE1qCOWbL3C_YXwb4KNs5-bCot-Pf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:06:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63897a8f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:06:18 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:06:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org,
	Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/5] submodule: add gitdir path config override
Message-ID: <aPc-98ps84R45MBF@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-3-adrian.ratiu@collabora.com>
 <xmqqcy70q8n7.fsf@gitster.g>
 <xmqqzfa2lnxi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfa2lnxi.fsf@gitster.g>

On Tue, Oct 07, 2025 at 08:41:13AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> >
> > [jc: brandon removed from CC list as the address would bounce]
> >
> >> This adds the ability to override gitdir paths via config files
> >> (not .gitmodules) such that the encoding scheme (or plain text
> >> name if the encoding extension is disabled) can be changed via
> >> config entries.
> >>
> >> These entries are not added by default for all submodules: they
> >> should be used on an as-needed basis.
> >>
> >> A new test and a helper are added. The helper will also be used
> >> in further tests exercising gitdir encoding functionality.
> >
> > What is the use case of this?  The only reasonable use case I can
> > see is to set this to all the existing submodules when you are
> > switching the extension on before adding a new submodule, in which
> > case the old ones will keep using unencoded names, while the new
> > ones will use encoded ones.
> 
> Two things.
> 
>  * I no longer mind this setting existing, but I think it should not
>    be a mere "override", but the authoritative source of truth for
>    all submodules (see my other response on 0/5).

I think making this the authoritative source of truth for all submodules
in the case where the new extension is enabled does make a ton of sense.
It makes things way easier for us to reason about:

  - If the extension is set, we know to always use whatever is in the
    gitconfig.

  - If any submodule path is missing we know that we are in a broken
    repository and can abort accordingly with directions for how to fix
    things.

  - If we need to enable the extension we can trivially migrate all
    existing submodules by just writing their gitdir configuration.

  - We can change the exact encoding going forward, as the extension now
    only indicates whether or not submodule gitdirs are tracked via the
    configuration or encoded "live".

I think especially the last point is a big win, as we are not stuck with
the current encoding schema in case it proves insufficient.

Patrick
