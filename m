Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8913AD09
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948544; cv=none; b=IaxyEijo6VqvscttFXdQfGedT9rYdywvqsucy4Ds1/rtNMcWOVdbDo3rgVkgHTXHBvO1eW2+lW7AFuP65kverRrpP5GO33VdT8pxwUlr4XpOqNFj1a2/pbyDvTb/ZesKHzSHpJJZ4/rPweokKfk9dgxGxguWGgGp1f90sRKo9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948544; c=relaxed/simple;
	bh=vvs3K081nmk2rxEgRgZs9J19ghrJsfD2HGNHqT1Aow0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba6yQanqjWTrbTz+QsXhJ/ZwoaUMQK8WU0qjEn2Lwa/LsZEE9OZPFjxL0MiOX/xZxiv4PdkZK2tiCMBdCEws56ZKbBinj1U69qLNo3G6YNzk066rIZKVlbnJGw+ryhPTmfrFTPXeI26owjxf00eR3/c6lfHip0BG/EW8G5OrLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LryoOIN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfSt+lvh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LryoOIN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfSt+lvh"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8015911402FF;
	Tue, 10 Sep 2024 02:09:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 10 Sep 2024 02:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725948540; x=1726034940; bh=nLRUNxEviC
	eWOJ83JsxEh4DeH7i255myVpSzdFzppaM=; b=LryoOIN8WN8z8XSgSqtfd6eLtu
	S30BCDl1Y0qxD4rdwZoKzoCwK0E5fQfEeSfn5Z2/QIOhA8Wja+HvtMUZBTAvvCo+
	25RUK23Mac5JafscRph7FtS7xd6cCQQ5Q6ynIzMm+tcvRG8BnaD/raKlAV0QqiDM
	My60z/4XBlCdILksvzlafQj+ZWJB6iXB65xw7axSIJ3ikLeo0J/ZdJtZm+VrhpAe
	s1h2E4tKAqohkvM4eTtXh6Er4SZc1DTh7Ic43hE76ckf6gmjfoqokEvz/HeYMH6L
	WVG0Rj4cI+v7hDTfqn6dQ+lzugmcHiX8QAD9dKLCov1AAod2kd6frm6S1e7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725948540; x=1726034940; bh=nLRUNxEviCeWOJ83JsxEh4DeH7i2
	55myVpSzdFzppaM=; b=gfSt+lvhPzWXzUc8H5sTru+ggpBG7GDyT/javqETe9Dz
	0qVHVuDBgzL28zWoZmGpwGl7Wh2VOsCaFjTKUYv1azXLc8rHWgQkqq56yBDG0ON5
	FzuIIkCR874clmGjgBTLRRnjDcEE5Ddx+bilqqLBdzBkb1z+jeie6tSpaSJi1nJl
	fMUZ1Cq6qWggQ7NpwVRvzsXUCIeW6P+BqMrk2JwOXdrMQuwC+vBNWPJdaxbuiEGC
	WYjmYtmzrQkmmfxZc0W6L1kYu3QPbrod2dAQrQ3H37XZhulO1nuDKm20xli4oZya
	EAVq70VoB6C0jG6D8LS1aXJnWsznEQIiN4nvHSkqDA==
X-ME-Sender: <xms:fOLfZg-kPG8XAVnTHGdiQ5_1lrqLM1XEklzB3z0nqCU1AWjWcXRHdw>
    <xme:fOLfZotwAWD_lCQXek5_spSju2Xjt9VoB9RLWXeeA5l_gn4j0UFMjzZhKYQPt4EMi
    PsBz2vVntcMwaNWJQ>
X-ME-Received: <xmr:fOLfZmAlPm0URLOjw4G-vf9Me_0eh7-u8LeQdgpgNeALvHQ268Jz3t3PCzQZ5oE-LA0w34UuxTlGMT2uTwbIxLMZ4PQyFPwt3q33mZKEB-XQXN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsghrohhokhgvsegr
    lhgthhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:fOLfZgeWbVLTLREg0hbqzMC1tjmu_Yv01uQJc1pwvjd1LIWHYe963A>
    <xmx:fOLfZlPvKirccrNsHnb1UW2t2hwaPLF0zOKsRRhl41KT4VDX4KKw1g>
    <xmx:fOLfZqkUt6JuFFY0XZuNAcqcYQLsr3olVTgS7lPG5aW-l0g4KDQG4g>
    <xmx:fOLfZnsz7dCk8juCugG_tDnZu_87IZUe9L2L_YU8MsrQCVziCekRdw>
    <xmx:fOLfZmoGhIjKppdm2bhJy38KG_i7q7nzUos6t0DAEReHZZA-kVAS6qM1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:08:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b2e204e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:08:53 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:08:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 3/9] ref-filter: strip signature when parsing tag trailers
Message-ID: <Zt_id3Fm6IXMhODF@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231445.GC921834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909231445.GC921834@coredump.intra.peff.net>

On Mon, Sep 09, 2024 at 07:14:45PM -0400, Jeff King wrote:
> The implementation here is pretty simple: we just make a NUL-terminated
> copy of the non-signature part of the tag (which we've already parsed)
> and pass it to the trailer API. There are some alternatives I rejected,
> at least for now:
> 
>   - the trailer code already understands skipping past some cruft at the
>     end of a commit, such as patch dividers. see find_end_of_log_message().

s/./,

>     We could teach it to do the same for signatures. But since this is
>     the only context where we'd want that feature, and since we've already
>     parsed the object into subject/body/signature here, it seemed easier
>     to just pass in the truncated message.
> 
>   - it would be nice if we could just pass in a pointer/len pair to the

s/it/It

> diff --git a/ref-filter.c b/ref-filter.c
> index 0f5513ba7e..e39f505a81 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2008,9 +2008,17 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
>  			v->s = strbuf_detach(&s, NULL);
>  		} else if (atom->u.contents.option == C_TRAILERS) {
>  			struct strbuf s = STRBUF_INIT;
> +			const char *msg;
> +			char *to_free = NULL;
> +
> +			if (siglen)
> +				msg = to_free = xmemdupz(subpos, sigpos - subpos);
> +			else
> +				msg = subpos;
>  
>  			/* Format the trailer info according to the trailer_opts given */
> -			format_trailers_from_commit(&atom->u.contents.trailer_opts, subpos, &s);
> +			format_trailers_from_commit(&atom->u.contents.trailer_opts, msg, &s);
> +			free(to_free);
>  
>  			v->s = strbuf_detach(&s, NULL);
>  		} else if (atom->u.contents.option == C_BARE)

I've been surprised that we use `subpos` as the starting point here,
which includes the whole message including its subject. I would have
thought that it was sufficient to only pass the message body as input,
which saves allocating some bytes. At least `trailer_info_get()` does
not seem to care about the subject at all.

In any case this would be a micro-optimization anyway, it just left me
scratching my head for a second or two.

Patrick
