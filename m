Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D886266560
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736885; cv=none; b=VzZeueOpx/k78sdrBuHGofhffEe/BosYET0ONDMzr7WMXg5UIc9HfpMmEgGKcSPTX8vPGjwJi55LLw2CBgp6yMztHGNiDPNcqG0qWSlHXGRoMz6WLFDkMHVb+T30xdWk9U4wWGubmD30aKDCS+ss7S2v0hM5CVyu9aHPk0vc+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736885; c=relaxed/simple;
	bh=eyLDXDjdgVkmM07Z3Pi9l1MSy40zEaUCF3jnK3EPng4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9q4qviJW1jyKmANoaH/UK+/CAi1YLsDyF0fFWzUFnB6RkaWbzYhiW+Ao+WuReOyjjYncLqxr85+K4gC+f6GALpn8m6geZVDWiLp+zqrXhFoZJhbPfcR1wwtXSyNHSAIcNoZd123f2cFWDU3KGCvz4NCK9ECMLbdr1MxtIP+TgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LaVN8xez; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z110F0Tv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LaVN8xez";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z110F0Tv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6ECAF11400D7;
	Fri, 28 Feb 2025 05:01:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 05:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736882; x=1740823282; bh=iv28EE1hV7
	uNqfDeG6eQWvv9aVSrUAartKFNHqDxMjA=; b=LaVN8xez3JXD6ahgF6wfSPJner
	EzLYPVXd/FdxFLTKEAo6eHosX8YJC/p0ZqUy2mv5dpYB5myb+Y+/MLGf1TAYnMSX
	u9zFcCB+gX6A9pn7qn1XJBk/zT2J90rj33C7x5R+GFtwcTs+yUmJ0AU67l6pY6Uf
	9w8O9nKJX2D+0ikcog2OsVUpUEgtoJBhJawKCeC8idrkcoz0GN/1AKqGoCEJ/9Ff
	qpbMXpRGVuXewspHvHODCQhMvNlA1xXUYXxAuVLrlpoXDjQFF/7p1Q7KOiR1ngLc
	xJ7JJA2dtDYGKDrh7OvziYFZG7TxAleCdWNzuHlxGVpfrqAfy4duxF/ruSpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736882; x=1740823282; bh=iv28EE1hV7uNqfDeG6eQWvv9aVSrUAartKF
	NHqDxMjA=; b=Z110F0TvsjP20GEIPWsHsyHSfqf0bupOSBNBr8p7JXuqW8gMBwe
	VNz21It/J0G3FVuQ1wFY0n4k6BXhcYsR7CSPX8YBzGE+QFyIzX2LChJPdj4X2hlH
	0hWB7oaQ7d0oOfVxgQN6VWSCO92PqGHsjXRy2YKd9XMpoO7HCy5+HXJuAOWGsT/j
	1TMcJ0eFzUdFjfzs9wEG0JWbPn2IZ3btTNI21DrnWJsfYT5q6VOGgmDLl26kbWGP
	L+W2KM2mqKsodXmhHR9LRd4JkGfv+AAkXAMYmqH3wU+Tn+SQrKcnfHS3raGaJfJI
	9rmYHwJmeNc4vq1Gn5kiX2o38/CJxWrtc0A==
X-ME-Sender: <xms:conBZyi5ri2jfM6Y4Is5k7Zzizy9DL_CPKWMiq6Z8y0VIXHu2FkVag>
    <xme:conBZzDilBaKxeI5y94Bm5fwV_WFfsy2vC0BtVTYlw4gZUj5LArTNCdqRpO-crLdH
    T3VzNm4qFdACuBt5w>
X-ME-Received: <xmr:conBZ6HGO3xuw1NDjF5_wAqd4IiSB4y3P0q2QHkIt3KhABWf09ABwitoULs2thFLsa0EPxYPbmywHGE8UR1YPZX-JKyBQc1vV45Bz60lUk9lzgeZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:conBZ7SkN5khT-TqkSJs72kPShKc8QtJnDZicdXBGD69UAIZXB_Gtw>
    <xmx:conBZ_yc3mS8yCJjF0jlGXxaabyj89ThMfPchiUxkqrdDpbzApA8aw>
    <xmx:conBZ57bCbV9PFvU55ov7m6ZSx9i7OBRIshSc_ShfhwqhZ8I5eLGKA>
    <xmx:conBZ8wHyNwxb-xLSiYXsMpFi_voNVjk5hY1MdtPM-Y9etL95u71dQ>
    <xmx:conBZ6o3cOo7jA68kZlbRoNZ6gv__GLizI1dRISan_Ggcbc1GUCgul6_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fddab1aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:20 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/13] pack-bitmap.c: teach `bitmap_for_commit()`
 about incremental MIDXs
Message-ID: <Z8GJb4y7yui7rvxZ@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <16259667fb4d7534458bb458afd6cefe032c3b6f.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16259667fb4d7534458bb458afd6cefe032c3b6f.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:29PM -0500, Taylor Blau wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 41675a69f68..e3fdcf8a01a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -946,18 +946,21 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
>  				      struct commit *commit)
>  {
> -	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
> -					   commit->object.oid);
> +	khiter_t hash_pos;
> +	if (!bitmap_git)
> +		return NULL;
> +
> +	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
>  	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
>  		struct stored_bitmap *bitmap = NULL;
>  		if (!bitmap_git->table_lookup)
> -			return NULL;
> +			return bitmap_for_commit(bitmap_git->base, commit);
>  
>  		/* this is a fairly hot codepath - no trace2_region please */
>  		/* NEEDSWORK: cache misses aren't recorded */
>  		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
>  		if (!bitmap)
> -			return NULL;
> +			return bitmap_for_commit(bitmap_git->base, commit);
>  		return lookup_stored_bitmap(bitmap);
>  	}
>  	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));

One of the things that worries me a bit is that by recursing, we
essentially are bound in the depth of MIDX layers as we may otherwise
bust the stack. Not that I expect us to typically have thousands of
layers, but if there ever was a bug this may fail in bad ways.

I already asked this for a previous commit, but what is the current
state regarding compaction of the layers? Do we need to be worried about
this or do we already know to keep things limited in general?

Patrick
