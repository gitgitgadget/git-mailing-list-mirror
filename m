Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A70184521
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541153; cv=none; b=SPds2Y+zyAeCZceT+xvvW7VZfJKydphd+d4r1pkM73HEZg4ZG0OMrFwP++3AYnO8FXCFXxqvvhteV44yIHDPnLXUFjVOrdapNuqxUqlZH3bC1zreM5g5NjddVOmsS1A6g3MuAN8CJ9qZ1ybIvWbuvIaqLk/ck5XDGbYp1KVajbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541153; c=relaxed/simple;
	bh=EdxWo7+Pif/UghWXlwtyNdzG0xjO7edarz9oy29Eybk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc0PgifyuErNSyZsTIjOpbPk0OyZrq5C5VX5F+qCFjEV/6CxyiBDIkoRNUBc/MY1+9kjyq3Be1ATZTotqmmEr9KbrFJBYZImP3jpqMYJImgeXJ3mo75cwfr+CXRhcuXTxhkA3tsXpXF8XWU8uqH7avSbDA+mtXu0f6dhWU9nujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HwvgUQU4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KFkUdm0l; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HwvgUQU4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KFkUdm0l"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 07448138FD04;
	Tue, 13 Aug 2024 05:25:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 13 Aug 2024 05:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541151; x=1723627551; bh=2vX4W9RBwk
	K4UzxQUHzG8mxvBKynJaUMrvXtR0gOYW8=; b=HwvgUQU4juOHCQpzXqIUYseE8M
	e12yabvLSb6jz1VX1UDhvcnwuYSYFMESwhdg2cTuRIqxa0RSksNXwj7eomjDKNiu
	Z4J21aKCiffCZmBzYukAX7hDNPzl4ycfpxV6XwhLl3kLKdeutmwPj/WLceGHyW8E
	LU3AFa5fq6Y5MU3FsQE8ZG2Z0QhluQP592/tv+7zYNmWn01AfZSmKHSvYDiqXKJB
	X3sbbxLHadqHB2Bvhk8IsBc9Hz5F9MvT840Zn/TLajM0ZpdF+4aRbA0H1OdFmxUm
	z/znFH/6/nheKUzgVnwz6Yh/zQ8X5evIt1nflQl4rA/iYkYWF5+DjMJUZ/iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541151; x=1723627551; bh=2vX4W9RBwkK4UzxQUHzG8mxvBKyn
	JaUMrvXtR0gOYW8=; b=KFkUdm0l8VOkYvVumH3mWMPdeKG45iskYnT7hBuZUpVR
	QKvQulizPRzRpTjZq7HtMpxgUbzf6pj6HhvcfCok1Kd5A3l5dB/izBYXZ8BhgalY
	3JXr6Gys1KlesqPOVmYKRweJGiEI0BMYok5woNSQRHjut9EJ/b93onP1/buE37R8
	eKoCOhGYl7gdvS+GT5ZA3MtBiW6/taVUpm4MemwZ+dHjXJHuC8RXyymU4sfdH2A9
	aMp+zGwx1knnF4CRVoG7g2J+b5tW4qOnu99rC8ROv2rC5YGZWuBH2tvNaRV/73zO
	HyVx1FxxUELFAQz+byT9MGydkCK0OU5sydHVrayKPw==
X-ME-Sender: <xms:nia7Zl8W8XCBPhditP9lc4QemLIs3Ygoq7_tuIKNiLRkvQUFohltpg>
    <xme:nia7Zpv8SfrFPoM0CxQ9uI7g9csQ7nEJPH0BGcJJKOWFvruQG1nmBUzFuZ6f-pfMw
    30E82-06s9bYpcirA>
X-ME-Received: <xmr:nia7ZjAouEoHIzYhnMSNw7eN8l77_JndHByUfyyiXlFTbHZNvgb2JBNV4ETUkZjqKoSZtie02KReb8EMfprC1-BYLPg1mAacUD4xE9bQOtMLpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nia7ZpeopzWWVNZ3KBXKQqbpoTkvs0cc6uibz-FzvsKYGM9pAoWTOg>
    <xmx:nia7ZqM2UhNneG2Qzy_1iB6p1al8_7Mou5jHxu3ArZHNyShAJYtdrA>
    <xmx:nia7ZrlRQlCy0OhiwZmgTTPhDRPagsk38u23xCqvNyeP3puH4BxoNQ>
    <xmx:nia7ZkuT0vgqwEO3O8XKjfYyt1mdiN4dLMCHLCxDW0gcKT16P_CZVw>
    <xmx:nya7ZjZV4mzh6WvgTnO6u-_h9i-3VddVREg7VpBKf7QQpFrmjN1Rioru>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:25:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1731e474 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:25:33 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:25:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 18/20] config: don't depend on `the_repository` with
 branch conditions
Message-ID: <ZrsmmYWtJuJWGMW0@tanuki>
References: <cover.1723013714.git.ps@pks.im>
 <d8530a300b4cf0f854f2b0d03c79876c11d81116.1723013714.git.ps@pks.im>
 <unahz22fciepxsgt74jdk63i3yminzjwsdqee3ti5mrii2cz3s@jf6ussbyx637>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <unahz22fciepxsgt74jdk63i3yminzjwsdqee3ti5mrii2cz3s@jf6ussbyx637>

On Fri, Aug 09, 2024 at 03:47:50PM -0500, Justin Tobler wrote:
> On 24/08/07 08:58AM, Patrick Steinhardt wrote:
> > When computing branch "includeIf" conditions we use `the_repository` to
> > obtain the main ref store. We really shouldn't depend on this global
> > repository though, but should instead use the repository that is being
> > passed to us via `struct config_include_data`. Otherwise, when parsing
> > configuration of e.g. submodules, we may end up evaluating the condition
> > the via the wrong refdb.
> > 
> > Fix this.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  config.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/config.c b/config.c
> > index 831c9eacb0..08437f75e5 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -300,13 +300,14 @@ static int include_by_gitdir(const struct key_value_info *kvi,
> >  	return ret;
> >  }
> >  
> > -static int include_by_branch(const char *cond, size_t cond_len)
> > +static int include_by_branch(struct config_include_data *data,
> > +			     const char *cond, size_t cond_len)
> >  {
> >  	int flags;
> >  	int ret;
> >  	struct strbuf pattern = STRBUF_INIT;
> > -	const char *refname = !the_repository->gitdir ?
> > -		NULL : refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> > +	const char *refname = (!data->repo || !data->repo->gitdir) ?
> > +		NULL : refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
> >  					       "HEAD", 0, NULL, &flags);
> >  	const char *shortname;
> 
> This works the same so long as `config_include_data` always has its
> repository set. I wonder if for `!data->repo` we should instead signal a
> BUG? Otherwise we would silently return NULL in such cases. Maybe that
> would be the desired behavior though?

It is expected that the repository may not be set, namely when reading
configuration via `read_early_config()` and `read_very_early_config()`.
We wouldn't want to hit the refdb there, so that is fine.

We also have `read_protected_config()`, which requires a bit more
thought. It does respect includes, so you may think we want to read the
refdb there. But protected config is defined as having system, global or
command scope, which to me means that we shouldn't end up reading config
data from the current repository. So not hitting the refdb there also
seems like the right thing to do.

Patrick
