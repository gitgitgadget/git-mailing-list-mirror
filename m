Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B21F9415
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126071; cv=none; b=NjNL5JhReiJnn1W9nEtrh1c74oCodv1wRvcfWEvSs3cY3tRZQt4gb9Stz8R2ptbizVxPPEFovxwQ9JMByWok4hA61TJYL9TQn+M3GC5EbNvXXdbJ3aQlaMMoDEJVnvyAa7PujXwRwFc+/RNJfmThIkLMOx8LtPxbctiILdjum6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126071; c=relaxed/simple;
	bh=mFOtulo729SVLXZNz+kHZLsyHKAk1MnasmbiJGXgk5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVsYfDoJT2vVx406i2QL4jghI+fDj2Olvf4XOGgYfGxlo4zcpeVQeQs77uqKSNCyzQQCcI7Plw/aYSei/+D2U/KZnGA6SNvNP51idkkOwDj2Is5cIVNS9MDce/IVrR01PRFFT3GmTR1SxO0C3Rskpbb14IJOJ8DczEDeLHH6/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bwzrwZok; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpDjL1C9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bwzrwZok";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpDjL1C9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 87A331380693;
	Mon,  2 Dec 2024 02:54:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Dec 2024 02:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733126067;
	 x=1733212467; bh=ChxMdsuBo3hdC+JISiWnjqbnlsrqLIp+NFokrZCtQeY=; b=
	bwzrwZokWCG+rFiLwus5bZndABGjYsQPsbflMBLUIYJw76POX9Blh25/kzaQHa3Z
	qDVJrlQLNmNxcmwj9RkEtWEvuZTi8rku7BJOqhE2pJRY2NKspFE+0ZyAGGsMjdqe
	RTdFeyOcebLlCLD06jLPNRpXdTUQTSe1H2kSe3rkU8l+ndRNHxRUtFN8Bfbdoa07
	gHJoglp51TWQFUq/prTJLXu4l6ylBenOTLSqWCJ0tRf5d328AikJEecahjMqBT2/
	5XIGQv2SKErmVWGMcBF7Fzlp8JdrhlFZFobx7uH6ylw0Ff98jl+oNW5JwB4y7nKp
	tjaNu7qyo5TSUJOBg0dOOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733126067; x=
	1733212467; bh=ChxMdsuBo3hdC+JISiWnjqbnlsrqLIp+NFokrZCtQeY=; b=d
	pDjL1C9SIpwihk2tm9fS1CkYbu6HqaHODygjovSFsVVpyiG9JgUFx3Mb5woVZ5ua
	5pUWf6x56+n99EBp7+jRahQJxAxeMDSO3gGt6q/FtHmhg+Yoay702mwrFVxqxlNO
	zJ7otYo7Yf1SXq4hlxsb81O1oarZpQLTrTBeh12fmFiGLuf2MKdb6EgnofBd0dki
	vjwTnuSZRZv9LPLg83iLNc5MnWsmvh6s8eUd3eu44HEkEvyCPfnCnoQA5VKHOrFo
	bQ7XutD9keMgT5Xs37WZRNLNERriHU47AYoljSJSQ5zy/8A3UFVa2KxUKv93mlgN
	0l2xjAJ6BU8+Y+N/B0Djg==
X-ME-Sender: <xms:s2dNZ5Y5XNjBoTVJNo19xajFNQ_mDRy5fUljEtFzcxBuoRMwofIrDA>
    <xme:s2dNZwZlP22Fhjouy1K9UxcfDtJqN0dpWL_8JiRKyiJlpuJzYul5vfedezVO8XCws
    ZgUIturcXizTEyqLg>
X-ME-Received: <xmr:s2dNZ7-_qcV2-yfgHxh-1t-eOw9ujXHdkgnMu3ypuTF-5mAG-XikNkt8uYLDu2-OSRQi5FFXKFp4b_83Cs_MMshMiakkWhxchhycgUhbXGitOj9pbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    ht
X-ME-Proxy: <xmx:s2dNZ3qqg1Z4sEi42RDs0kXrErf0x4ITxUPQJelyOTCstHvPntdB4g>
    <xmx:s2dNZ0r29FE0QPkBPWJLOOmrfubmfqw0Od2LAeaDnVhMqZeQatcCsA>
    <xmx:s2dNZ9T1sbO8jfxYsqHtPAgG0uQUWbwjzVOfzbTrFAGqOgZA9C0ilw>
    <xmx:s2dNZ8q0r08WYPlbB4VkWNVLbx7wkL0cS60Cx0N-UFm4QRiOHWdaqw>
    <xmx:s2dNZ73CCAFa9V6ooYz1QG6lL1CDnGZQq8umEjWso7q8q0TtjJbZp0aV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:54:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58aa2dfb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 07:53:11 +0000 (UTC)
Date: Mon, 2 Dec 2024 08:54:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] global: fix unsigned integer promotions in ternary
 statements
Message-ID: <Z01npcGDwV4TBCeS@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-6-fc406b984bc9@pks.im>
 <20241201215911.GD145938@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241201215911.GD145938@coredump.intra.peff.net>

On Sun, Dec 01, 2024 at 04:59:11PM -0500, Jeff King wrote:
> On Fri, Nov 29, 2024 at 02:13:27PM +0100, Patrick Steinhardt wrote:
> 
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index f0d209791e44025b1965cd447cf4fc1e2ca5f009..6c6b0c7ef1a4d992064c7664bbf1229ef0286b97 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -470,7 +470,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
> >  
> >  	for (cnt = 0; cnt < ent->num_lines; cnt++) {
> >  		char ch;
> > -		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
> > +		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
> > +			cast_size_t_to_int(the_hash_algo->hexsz) : abbrev;
> 
> Hmm. I'm surprised that -Wsign-compare would trigger here. We are not
> comparing, but assigning. I'd have thought the actual error is the
> truncation from the size_t the_hash_algo->hexsz down to "length".
> 
> But the actual error from gcc is:
> 
>   builtin/blame.c:472:87: error: operand of ‘?:’ changes signedness from ‘int’ to ‘size_t’ {aka ‘long unsigned int’} due to unsignedness of other operand [-Werror=sign-compare]
>     472 |                 int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
>         |                                                                                       ^~~~~~
> 
> So that makes sense that "abbrev" is promoted to unsigned to match the
> other side, though I still think it's a little weird this comes via
> -Wsign-compare.

Agreed, I was caught by surprise, as well. Doubly so because Clang does
not throw these into the same bag.

> Another solution would be to change "abbrev" into a size_t. But then
> we'd still have truncation assigning to "length", unless we also make
> that a size_t. But wouldn't that be the more natural type? We pass it to
> memset() later.
> 
> We also subtract from it (without checking that it doesn't become
> negative!), and use it with a printf("%.*s").

This is fine in practice because `abbrev` will never be smaller than
`MINIMUM_ABBREV` here, which is 4. So given that we only subtract at
most 3 from the value the end result would be a positive integer.

But you're right, this feels fragile overall.

> The latter does want an
> int because of the lousy historical interface. IMHO we are probably
> better off using fwrite() or strbuf_add() instead of "%.*s" specifiers.
> In this case, I think it's just:
> 
>   fwrite(hex, 1, length, stdout);
> 
> (that assumes "length" is clamped to the hex size; I think it is here
> but I also would not be opposed to a helper function that checks it
> against the string length).
> 
> 
> So I don't think what you've written above is _wrong_. But I think that
> ultimately the right type here probably is size_t, and I worry that
> sprinkling casts around makes it harder to see that. It converts what
> would be a compile-time complaint (the truncation and sign conversion)
> into a run-time one (that in this case I suspect can't be triggered, but
> as a general rule may be something that _can_ be a problem but which our
> tests are unlikely to actually poke at). I dunno.
> 
> I didn't dig carefully into the other ones, but I suspect they may be
> similar. E.g.:

Will adapt. For the first iteration I was admittedly a bit lazy for some
of the cases because I first wanted to check whether this will get
acceptance in the first place. I'll explode these out into separate
commits.

Patrick
