Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648EA3BB132
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387981; cv=none; b=OXTSiWAVyKZ9tl3iORmIBd2Aco1HxsPWz3O1+iSindVYDAs/KDXJaqCufZnOJ4i+vBisxVA5Q1aart/xDUZ1sbkLPce2X9rMA1yM1nmV909m04xFwiToRpKz/1mQxr8MCZ4GegOjXXxfBsgvvIWQGvg4E+9WCGXf6iUBWSf5Kzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387981; c=relaxed/simple;
	bh=IcTa5jtqbhzCGQyndF6e8XdZkDsg3bXTfUPLUBfMPn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaKsQUHd9k0C0zZsndyOTO9x45mK5MKmNKUrEiT7WDBXF1BDkHZIwzVp7yfHhICafAdBour0Zy0RyK+eUfcaePAGnZtr3xAnYTq3x8VuVRUUitvIwVK79elAbaJiiHmIA69iE+Fz+UncwOZsabwN+iY54GFukAutLdDj3MkyO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L4wifhtc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHyfGKDz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L4wifhtc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHyfGKDz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 74DB41D000C4;
	Tue,  2 Jun 2026 04:12:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 04:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780387979; x=1780474379; bh=05DuKKUd26
	p6TvorG/n6bbT3PDWP7usA+HdGdp9haX8=; b=L4wifhtcVrQ11OUN7JDtfEKBXK
	gzQmFQgPnFfy4SWBY0WWG0RpTaCmM6rZV+3iUHAvVhg+IpS5i2t+f+cFukmbVTCt
	RHQTZ5v8LZYs9YhuuG24jWOxoXZMNq9Xo4T9QbuMrh19yBAi46UbDbBIbBqXdojx
	XQ/ct36fc/d+cBPSPgeLPe/5kl1SbSNiTimkSUeoz5RbB3dVechLkAuNJ1CZOy7U
	DStNNtyvht4/TmyDpnxOtWaFBVNX4ua46DaPZFJOo3WdsdSRisq6E3x2yyYX67mu
	ia2gzG83UkFBcRzv94zYn3n5MJBhFVcGxnGwGgimAIrQagaPfXdo2kgdUWLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780387979; x=1780474379; bh=05DuKKUd26p6TvorG/n6bbT3PDWP7usA+Hd
	Gdp9haX8=; b=CHyfGKDzkwtaHJzDyzsVwlnU+e9SCEIEzXuV46u35+WIV0fYnaZ
	H582OeIiN894fZ8uSQoM1RRWEtA8LyPurRZvn63bxulPsNqDUSbEtN8BlPLhVEd8
	wiBTDTaKvMYpJ3TjCLWvOqGtqCW8KhEIw4qlWNXwSOzO7wNhLkEFVZPrsLghOKg7
	wWXWKZxkxJec6O4w4VqBCEGyZdvCgeHA+x8DzyZ3SI2UX8IjtY4GbRKIVa1Ks3zK
	UB99ux6Dr9C/F2pe+9rIMpMtMVOv2nmLEUJZsaDm4wpmoVi5ufCR/MgDIu1p2M4Z
	kLubVRo0c0kCGzokPZVwdqrmUbjttVcIXPQ==
X-ME-Sender: <xms:i5AealPYfJqRo3vbFDpf-RsDRIkgrV5lKfg0ZF2xbBsVrZ5vruLZVQ>
    <xme:i5AeanCob-bMjHWLSc1rYwBQFvRkjB8JJn24dU2tZeoR7jZqRiLM0lneGwfvXgHiD
    rSSGK0sHFPzVgr1CROueoYr-7x8K_QkkythTqo_C6m1LiafqefNww>
X-ME-Received: <xmr:i5AeaqcVrGlWn7tkgbyo_QGCjalNT3Lr5GYk5_W_XtD3N1qImpUW0MJh9ETZkbPa6Lv7TLYxqjWdiAXDuXzxkCF_ENyhN-K_NwnLl6ClDQ>
X-ME-Proxy-Cause: dmFkZTGt0XPjTuqoPZWBQgh9VuLimH8xqhWuIn+cpIh1V3MWq6Z2KpmWKwOdbQMlGwSO8T
    BS7G2m3qFHy00eczmnzrqDXcLnGYDt7Si4vnlCntxt6iQCaE9D6+PqVsPMNiGFX7nbamiS
    gWyOSJGUSWVbsYEYWZn5nyf1P79c4Ed3NgYjA1xdS3Hb+go6TxT91zO41DtMhqvWr5LQ2o
    m9Pee2Z6jiBlJwZjJg/qb+BoqkPYfhruScJBHGJ4TUPS1EZMX5YDUez2eezqeijwPwTZpu
    EU+CvBCfvKuD1TJcjwN1KGD25L+ugukNPkgcYEHebNy3OkOW4U/Kk/0AWfm28eApdkFjqY
    KQhMg8PpvoJTPJt+7h0OUqm+1IBpgtT1vk1/d8JeQt2gawE1oTYf6JeE56lj6mGV/Tzy6M
    uV6hzpFpzvjgs5Dw8ADwn48hX4ywfOaWr28w3YIIGo72rc1rv7YATARTZVxnsfEtMMgxf2
    fOjmuf9EKzsz+kdvvIB6sfoGbpJXYLjTqxEGe1JLzilXZGR/x2xPZ/nWcjygXyDTx/lUy3
    nXtnB4ZDm1EDcIPzK8TE1o22RCtMjJxXa1yNHOAdCnIYyaviINw+dX0MVhX1jy3HLTvP30
    s1iuN3m1HIgTUh3nrvHIc2nhmKQ4gkCAwdf73wnGZLzX1ojEgyF8rRCgt+Fg
X-ME-Proxy: <xmx:i5AeauNfltZxL1JUvFTVFdm7a1PN8sx-4BedmSmhyczb1sM4wtF1ug>
    <xmx:i5AeaiJUr9_DStllunfoUcMWWf3VOHgga1iz9E5lfm3SFouWWhO0gQ>
    <xmx:i5AeamJcTa-IgRRvJtRHsPOLhDNruq2drb9W-PjLqRc1ROb3SLyQew>
    <xmx:i5Aeak6yC86NHH7xOMmeXZqWUdbNIfjlDFOMQrSW6Lz39qWCkdsEkA>
    <xmx:i5Aeartdw9jd8IvyvN1GKJms1-y9Fhnr33EAK489DzNfcAnL8-sO5Ayu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 04:12:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f40301d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 08:12:54 +0000 (UTC)
Date: Tue, 2 Jun 2026 10:12:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org,
	phillip.wood123@gmail.com, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com,
	me@ttaylorr.com
Subject: Re: [PATCH v4 3/8] environment: move `zlib_compression_level` into
 `struct repo_config_values`
Message-ID: <ah6QgwfK_TykIiBp@pks.im>
References: <20260423160832.114816-1-belkid98@gmail.com>
 <20260601154211.82370-1-belkid98@gmail.com>
 <20260601154211.82370-4-belkid98@gmail.com>
 <xmqqpl29ztx7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl29ztx7.fsf@gitster.g>

On Tue, Jun 02, 2026 at 09:07:32AM +0900, Junio C Hamano wrote:
> Olamide Caleb Bello <belkid98@gmail.com> writes:
> 
> > @@ -906,6 +906,7 @@ static int start_loose_object_common(struct odb_source *source,
> >  	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
> >  	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
> >  	int fd;
> > +	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
> Would source->odb->repo have properly initialized repo_config_values
> structure at this point?  Shouldn't we be using it for this call,
> instead of the_repository?

I think as an intermediate step it's okay-ish to use `the_repository`,
as it doesn't make the status quo any worse. But ideally, we'd have a
follow-up patch series that converts "object-file.c" to drop the
dependency on `the_repository` completely, which will be easier after
this patch series here has landed as there will only be a handful more
config options to migrate:

  - `pack_compression_level` and `zlib_compression_level` get migrated
    in this series.

  - `object_creation_mode` still needs migration.

  - `pack_size_limit_cfg` still needs migration.

Other than that we really only need to use the correct repo in a small
set of functions.

Overall, I think it's sensible to always use `the_repository` at the
callsites in a patch series like this so that it's obvious that there is
no change in behaviour. So every patch series that gets rid of global
state in a subsystem X will basically bubble up the global state into
the next-higher level, and it's then the duty of the next patch series
to address that next-higher level.

The only exception of course is subsystems that already got rid of
`the_repository` -- we really shouldn't reintroduce the use there.

Patrick
