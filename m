Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04941586CB
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565611; cv=none; b=OyjYER+rfwOD4YuvP8VW0arsDyYt/zx3DnG9RMVdzDRw20Ad9g29Bw4U1S+/ISt3l0GjJzZW9QT58kfLQTkkWaBPcOF+zpqejMr1WDWbX5Mq/ox7AknWHmk6mkHmME2RuhfcntZHPzUIq5pW83O50JkCskIuq3tXr5/X/ibuh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565611; c=relaxed/simple;
	bh=MxNqiEg6Gg8CZm3w5VKNiV2TDQTz493MpzhkhompUN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt4F9JwecE1PTct0PKNinlt+vKbiwTXSIErKUwRNawrvEdih92dkHsG7WZjjhWBvqXRmWdeqr6eqjUq68+CPGlwfwYm4S5EarynhnmwIkg2zGA5kmpKWydfA6O0BG0QHUnaAhaeVODqPwuBWof6+zwKT0TUtOEs2iNsthO6LdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UwrdMYK+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XajTtGZf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UwrdMYK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XajTtGZf"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9769114008F;
	Tue, 17 Sep 2024 05:33:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 17 Sep 2024 05:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726565608; x=1726652008; bh=Y2anVDfbmN
	MRXWvVvfNK4h3ENJR2KVrCXWJ8r8/tKEQ=; b=UwrdMYK+NqoYr5nlqVWvU1SAjV
	SKHfUgUW22tnYuPcu1Fq6gdSkCW60HMVton0djDvmheYco3JqtK9QKXnxs9MqOBf
	scXvl3DYzXiwNS1jXv885bCDN2VgwXXVFqEDxDOiu97JCbROcWuOiRT7WKH2OfjC
	jN6sIiqMaNgkvCzyh5s7H8sylkKOpxWezLo8EIpHtMDjEO5BkqfqOm6fjj1xyd9L
	KtXBj+tJpTIpPRejsT/22rgbNYURpe0U9kyyJ6H1kpidFmJOT+CkJSu8xtN6V/OQ
	NXt8L5rkho+nl+M9pfJ2o7sK+/9bqv3fXQHQgTgZNq0aA66ylT1M8heZ/Gag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726565608; x=1726652008; bh=Y2anVDfbmNMRXWvVvfNK4h3ENJR2
	KVrCXWJ8r8/tKEQ=; b=XajTtGZfM/r4C50BsSLtWF2Re4n8ZDQVoDbkDFbpigPX
	MwB0z0TT17ZsGzu4xSs12KtUbCMNxypkvEc9e2yQY9jOy3SpzhsbjgIFv9cG6Q7X
	DBz/A3+lIy5qNb89P0b3SwTxVdRdqTvDGFqx3M1Sjp5AMB83G6RXQPTNeHKQnTy/
	hKaetebjN8HGpZvAEDmxJrgeZbVUKJaD4fOYIjhCjLcvVrZvBvPJ+DZtLFGJ7csk
	owz60iB0q44qd7BU5tFhs+Ix2Xn39UlA6vIapHFB2aMlGE4QvRjhDOj1ZFqLPjmf
	wmdefqi0fdTVk6xz8JWyX8roEw8Amk0YKb/IailWeQ==
X-ME-Sender: <xms:6EzpZt7wzfSKCkOfaBoQ1PeUVO221VzHToDIOollJ_17kSPP4HUqFg>
    <xme:6EzpZq4etRohUDUWDb55Ts6JUKNrvTwdLKDV1YYHSYXzU7LySU9Dmx2T509i6C0MI
    WzSZ5jTwz64F-yUug>
X-ME-Received: <xmr:6EzpZke8djyEkWb2eIbxWhCcV3OxHdkKliC--CgWB4FFrPw1WOeLR5QEqNit_58m5_GLANYLNFQz0AfFTHbod5E6FAV--gHMdeWd1YRlHGpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6EzpZmJgDdTfbIcxXCKV7fdke7KrLCI-yHScaApbP4v6TyhtuFMqvg>
    <xmx:6EzpZhLa5WBMS4L2kdtLr49yUYsarbb4AAQB3fKgt48i1Z11N_-JTw>
    <xmx:6EzpZvyhSOmPrcXEgUCYRm4_3XsEZINasZOIiN-zXstmLllNAhIAMA>
    <xmx:6EzpZtLxYuSJ6UYd--TAHp0Y8h85zVM-behKrSGi2ydicwkBWp6vHg>
    <xmx:6EzpZh3LDAKagfIXz9sNg7Ha5zee_XrAHSEwmGwBuKVSu4Q6iqX9WEA5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 05:33:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1b4ee9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 09:33:07 +0000 (UTC)
Date: Tue, 17 Sep 2024 11:33:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/6] refs: properly apply exclude patterns to
 namespaced refs
Message-ID: <ZulM4BU7zSn_NHMl@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>
 <ZulIB7k18+4CzwZb@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZulIB7k18+4CzwZb@nand.local>

On Tue, Sep 17, 2024 at 05:12:39AM -0400, Taylor Blau wrote:
> On Mon, Sep 16, 2024 at 10:50:03AM +0200, Patrick Steinhardt wrote:
> > diff --git a/refs.c b/refs.c
> > index ceb72d4bd74..b3a367ea12c 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1517,6 +1517,19 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
> >  	return hide_refs->v;
> >  }
> >
> > +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> > +					     const char *namespace,
> > +					     struct strvec *out)
> > +{
> > +	if (!namespace || !*namespace || !exclude_patterns || !*exclude_patterns)
> > +		return exclude_patterns;
> > +
> > +	for (size_t i = 0; exclude_patterns[i]; i++)
> > +		strvec_pushf(out, "%s%s", namespace, exclude_patterns[i]);
> > +
> > +	return out->v;
> > +}
> > +
> 
> Is it safe to concatenate each exclude pattern with the specified
> namespace? If I'm reading this correctly, I think we silently do the
> wrong thing for exclude patterns that start with '^'.
> 
> I guess we reject such patterns in the hidden_refs_to_excludes()
> function, but perhaps we wouldn't have to if this function stripped
> those prefixes for us when the caller does or doesn't specify exclude
> patterns with a '^'?

Yeah, as you mention, `hidden_refs_to_excludes()` drops excludes
completely in case there's any pattern starting with '^' or '!'. So the
current assumption should be safe because we don't use excludes in this
scenario at all.

I also agree that we should eventually think about allowing '^'-scoped
references. We can handle them correctly, but it requires a bit more
thought wire that up. So I'd prefer to keep that out of this series, as
it is basically a new feature.

Patrick
