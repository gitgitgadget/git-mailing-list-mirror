Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675D3F9C5
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307865; cv=none; b=tCd0HO6oxlPoUQLrKYTnXaq3u0Jx91ClZ8TkCgw9a6sCneHbz9bSxsJgTF2d0T6J5yN7ejLY42hVt0jHBJqtquO7/V0HtAbX6FVKRzvTS5n+1+LW4UzyLLnUtw9vX3X8fEUXnFrKjxMS+vYuCrrWiGxJRoMeP9k/rKDuhWf0kqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307865; c=relaxed/simple;
	bh=jp982Vwe5A7X4BoJwxcdED2ux1TCjHOl0Fq7TkDa3to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW8CX7dgzbik5ongtPvS/XPRViqJ4D3y4gcDI8Um2aOUBqSCI9fb8Pth8mirC1pX96cVj5xRSw/XKe7fOr+5vVeIJK5wtBHzq/hytxCvnDZ3uvCAlhvyMeWS4mZqpevAvA1/6qOE18ka9chKScmrQ0uec1+2BAtFv4LK3L8nIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qDnGT0qS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xxSLUGec; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qDnGT0qS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xxSLUGec"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A60A8254017C;
	Fri, 27 Dec 2024 08:57:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 08:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735307861; x=1735394261; bh=+QpO6XP2cw
	KQHxlgIQiQuMD4QKKxAHthJP4ZDv2Wv0o=; b=qDnGT0qSB/NEjADOrPmYIIW6sl
	QtCdrJtzARI1mVU0wq3C8BQ6pzlzx0xJAv5MkDsycwzxUuULt09fTjRyZdobDPpj
	L8g0Tbhts75Y9ztAX9tUtBcSfg/jHyjiTZxvZ+gzxW3mrZlkJ801gM/sLeG/oOCU
	Rsnbg2471YU/thSqsLkTJWAHsftc+mB3pgyopEAesisdPmGYpBAuzzDMCpwO/Wje
	U+TkRBwOvdKU86YTMh8Djf9LpkVsNpWrccBmATvyJLuZt+YTRlfnuDQW0LphkfCB
	i7a9RV1cHVUniPxFrUgbTgevxzBzQR7/9NnolGhTAiUqyR+px8/cafN/id0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735307861; x=1735394261; bh=+QpO6XP2cwKQHxlgIQiQuMD4QKKxAHthJP4
	ZDv2Wv0o=; b=xxSLUGecK7aKIt1k6/Z0Uv49mfGOkZiuCHm5AqL0nfUslAKwTtH
	dg54SU+ozGQKPO4WoH1Ej5eOZ3Aa/POmqv0R6H1hxlzuYKvrAaY1KKhrYVlUXgQI
	fTLH1pyFYGmQn/iPZPTHALNL+mb7UyW7DIsoO/UmdxjitvBrsOgIP30D/4mVQwvR
	4Hd0vg8W1UCossVBoobAaFNRHQlU6wBAh6xen6iNApYhgLIyLWmWIS2U2y8QTpW/
	/cJHHnpPbRYHIfVFnKzLejukNkDz77ZR1wIHp5AWuXAobMONSqhJgnYnzgJr5wr5
	KAYR7bBMrNJdE5dq9dtZaxDyHLLWBukZgVw==
X-ME-Sender: <xms:VbJuZ9Y5txXviWw_eECZmLcvEeumTGCex1IX5HL9A9-8ijgduqNebA>
    <xme:VbJuZ0YAOApT2X05nDHTtD_bHTvwZGOWRz95inWzSJsYV778_ghyaTslVVggcGexP
    wLuWi5tA3hl7wd1fA>
X-ME-Received: <xmr:VbJuZ_9Z_5WLrP9pQHVFXAU2wm-ZhXWEwzCvb4hoodaGZJ0LdkQZLS_oeuRC5QbEKmKl8gf6dQy3mTB7BRCqVYYOiEjeSJNRtcGTzHCZGYWdNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VbJuZ7rXi6YHVKC9rjygoIU9UlQ9gBlDWn6FDFMve7CaOkwVvm1itg>
    <xmx:VbJuZ4q6F_Xq3bbTIeHv2CGIEh6VTchTG__b_a1-_eez2PtlmdedWg>
    <xmx:VbJuZxQF0dAugWWU8aMdxqdmqzRxfYaG7v_ZpbM79nz30A56flCNWg>
    <xmx:VbJuZwqznCzO0GqQNV9E2jQfXBNZVhqUsHZvJVvxd4JgE71APL6n5Q>
    <xmx:VbJuZzV5pcqenHDsXaDxZ6LG2Y4Qp3ER0kEz9JXeKAVCVFP0fWjeffJ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 08:57:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f79fe6a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:55:33 +0000 (UTC)
Date: Fri, 27 Dec 2024 14:57:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] builtin/log: fix remaining -Wsign-compare warnings
Message-ID: <Z26yPlLMlxyecZVk@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-7-07c59c2aa632@pks.im>
 <Z26p9GJbmyUd6bG-@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z26p9GJbmyUd6bG-@ArchLinux>

On Fri, Dec 27, 2024 at 09:21:56PM +0800, shejialuo wrote:
> On Fri, Dec 27, 2024 at 11:46:27AM +0100, Patrick Steinhardt wrote:
> > @@ -717,14 +715,14 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
> >  	unsigned long size;
> >  	enum object_type type;
> >  	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
> > -	int offset = 0;
> > +	unsigned long offset = 0;
> 
> Why here we use `unsigned long`, is this a special situation where we
> cannot use `size_t`?

Mostly because other variables already use `unsigned long` here,
including `repo_read_object_file()`. So given that our object layer
doesn't support `size_t` it wouldn't make sense to use it for the
offset, either.

> >  
> >  	if (!buf)
> >  		return error(_("could not read object %s"), oid_to_hex(oid));
> >  
> >  	assert(type == OBJ_TAG);
> >  	while (offset < size && buf[offset] != '\n') {
> > -		int new_offset = offset + 1;
> > +		unsigned long new_offset = offset + 1;
> >  		const char *ident;
> >  		while (new_offset < size && buf[new_offset++] != '\n')
> >  			; /* do nothing */
> 
> > @@ -2183,7 +2182,7 @@ int cmd_format_patch(int argc,
> >  		fmt_patch_suffix = cfg.fmt_patch_suffix;
> >  
> >  	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
> > -	if (cfg.log.fmt_patch_name_max <= strlen("0000-") + strlen(fmt_patch_suffix))
> > +	if (cfg.log.fmt_patch_name_max <= cast_size_t_to_int(strlen("0000-") + strlen(fmt_patch_suffix)))
> 
> A design question, why we don't change the type of
> `cfg.log.fmt_patch_name_max` to be `size_t`?

The whole infra around this uses `int`s, too, so changing this variable
here alone wouldn't suffice. We'd also have to adapt option handling,
config handling, `struct rev_info::patch_name_max` and other bits and
pieces. So in the end the size of required changes would likely balloon
and thus I decided to not go down this rabbit hole.

Patrick
