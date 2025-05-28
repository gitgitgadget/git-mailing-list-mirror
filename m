Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148E283CB0
	for <git@vger.kernel.org>; Wed, 28 May 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433224; cv=none; b=r0lw2dglO0DZHYbNTbLJOot9fXtik1bSnqXFS5iZYLHxuqmG1jMXzGyVpO5mPDNlNMnmAtUf1f7ry9jU0uiL7suY4ZsjLtV/dRv7Nm3Ebke2vOXgrA8X0RFV2yhC0omOK0RDkmO3xOwxaNffWZkA+Urxv11Lnd6vzoPwNFVRnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433224; c=relaxed/simple;
	bh=YN4bw13F4sY9TWKXQ75jCi0DRTpqzGUWLXMQoMkSdG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgXdFRl6b/AwIqqvf5gWL74etrnsvm8FA9s5Pb5GFPEwzecvxxe/dSMYRsMnDwZ2O4jiJ5iSv9HqTqgLLKDZ24wY/EhFvOldsoM++epNMBlcdgsngPRZzkOXQKoXJ6xzPld4uYDirz1m/mFR2DS3LRYfQQp5iTY/gO/o2wM31Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Glx+97ot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4Rb5KF2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Glx+97ot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4Rb5KF2"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D756C2540126;
	Wed, 28 May 2025 07:53:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 28 May 2025 07:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748433220; x=1748519620; bh=bkBxJJVvFO
	5qmiDO4vNbeGd0z4TlMboGItfSZGQwt1k=; b=Glx+97otsKFWXpKmblB9gdTdYL
	Hi5jSYqhUu7swVgkN+ZftBYjdLkVaynkg/ick+O5Hdx60qChDt69y5OmrNABuemq
	yUHUpC+veO7XBIk/oJ43lnfuVeKpDCiTxh4lHH8ce4VSOgcHxMXhOLpD7clPWch7
	GaiAXQlbuIANi9/sZzWnPYO5pVpvewPTe76bebzoZHFuv3T0rduX7TfRI815iTkG
	Aev9vYZV8dFyaksFyNA4Lc8U8r1VPwTTktw6h/cmARG+YuRNhfEEOT/njpB2H+GH
	AODs+0VTh4VMufim8T0eTYsnjecguKiCRe4WtnRm8iTohCVu27lQwl1jCdBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748433220; x=1748519620; bh=bkBxJJVvFO5qmiDO4vNbeGd0z4TlMboGItf
	SZGQwt1k=; b=q4Rb5KF2YWrttqw9jLtn/EerX7jkJulJ/mQqMyUCA7TWw4ai902
	x/7+WxQf9B+Xwf2RvtfZPN26HpAZ7nWs5zl2bYlDoobkkT6XNhYki1oKqDYBuQA3
	nVCJ+zxWUtF3qUtlFvckbHIcyuCwKr7oHPPcPjzOxoWvHgDNdeHe82XjkhA1LR5Z
	KAZKC8lkC4BBXmz4/PSF/ZR7cu6euizxJhIZKLYlE6wyEZkf3FyjnckO/GaQ1Dl8
	SRTUyIhCvBUtqFzzR894Ki8LPJy0oi0L1o6wrIOiuOQ75o+e6xbUZDn583g84Ifl
	oOPwrztVpZxaBnrHN/YyHgvABeReQy9T4oA==
X-ME-Sender: <xms:RPk2aHUov9Yn25BlROc6vZyiYbYdb7xIDHrbOHgUXmD4LkivubqQGw>
    <xme:RPk2aPlzjzc6M3cdX5Wk0BOcSQg-z39ViprDrNDXFT4YIwpapp84CgFmwSa0Uxgp9
    ecUv5mU5FVduNWToA>
X-ME-Received: <xmr:RPk2aDZvMlk8noGgp4o2f04nfrYeHw7foLxULrD_6qop5onkv4GKGHOLRmjZ-Zj_O71JOk9S9Zjq5M2Zk0EOxSolPqy7oNJm0Ybwd0b25Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeduleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:RPk2aCVKD-na8i-zl5fzoM0Vbq5qiyJ0jTpyKiMgJbxtptABaz5sOQ>
    <xmx:RPk2aBmUf6RHM2M1t_EdEF3R_y3SG55hTkDOhE58bmbq7JAOtxV9vw>
    <xmx:RPk2aPcgU18CVgFYMBKVlf2sMBYY32Vc5ZqeJpQOiQ9Fw8IvG3Lm8A>
    <xmx:RPk2aLGEVE4qs0WwPA-IbXuj3FGqETyMX8YUi8yXsvVd_NXrHsvMcw>
    <xmx:RPk2aHSvxuJQC3KtJfIXrzUrj2ajhl7az4k2sZXezjWmNKwpXMB0TFyX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 07:53:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a86ab23 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 11:53:37 +0000 (UTC)
Date: Wed, 28 May 2025 13:53:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
Message-ID: <aDb5QP3l8PaFNwCB@pks.im>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <80699bb3ee35f8c4728e7efe8dc53d17134a5fe5.1748198489.git.me@ttaylorr.com>
 <aDQXEz-RtrcUAwic@pks.im>
 <aDZyXlPojqxxxjl6@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDZyXlPojqxxxjl6@nand.local>

On Tue, May 27, 2025 at 10:18:06PM -0400, Taylor Blau wrote:
> On Mon, May 26, 2025 at 09:24:03AM +0200, Patrick Steinhardt wrote:
> > On Sun, May 25, 2025 at 02:42:03PM -0400, Taylor Blau wrote:
> > > diff --git a/midx.c b/midx.c
> > > index fbce88bd46..f7f509cf46 100644
> > > --- a/midx.c
> > > +++ b/midx.c
> > > @@ -449,50 +449,48 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
> > >  	return pack_int_id - m->num_packs_in_base;
> > >  }
> > >
> > > -int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
> > > -		      uint32_t pack_int_id)
> > > +struct packed_git *prepare_midx_pack(struct repository *r,
> > > +				     struct multi_pack_index *m,
> > > +				     uint32_t pack_int_id)
> > >  {
> > > -	struct strbuf pack_name = STRBUF_INIT;
> > > -	struct strbuf key = STRBUF_INIT;
> > > -	struct packed_git *p;
> > > +	uint32_t pack_pos = midx_for_pack(&m, pack_int_id);
> > >
> > > -	pack_int_id = midx_for_pack(&m, pack_int_id);
> > > +	if (!m->packs[pack_pos]) {
> > > +		struct strbuf pack_name = STRBUF_INIT;
> > > +		struct strbuf key = STRBUF_INIT;
> > > +		struct packed_git *p;
> > >
> > > -	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
> > > -		return 1;
> >
> > Ah, so this series builds on top of my patch that introduces the
> > negative lookup cache? That wasn't quite clear to me and makes it a bit
> > hard to iterate on my patch now.
> 
> Eek, sorry for the confusion. I mentioned it in the beginning of my
> cover letter as well as the (less visible) "base-commit" identifier. Is
> there another spot where I could have highlighted the dependency more
> clearly?

Oh, it was right at the top of that mail. Maybe the square brackets have
made me skip it? No idea. In any case it was present, I just happened to
read over it.

> > Could I suggest that you maybe include that patch as part of this
> > series so that those can be iterated on in tandem?
> 
> I could, however your branch is already tentatively marked for 'next',
> and Junio applied this topic to a branch based on yours as I had
> suggested. So we could change it, but I think it would be more of a
> hassle for Junio, so I'd rather avoid doing so.
> 
> Are there changes that you want to make on top of your patch?

The only change was that I wanted to add is the `(void *)(intptr_t)-1`
part with a macro, as proposed by Peff. You know, it should be trivial
to adapt to that change, so I'll just send out a new version now, which
should then probably be merged down to `next` soonish anyway.

Patrick
