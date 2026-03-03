Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C3480DE0
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550544; cv=none; b=rZ8D3keCCQZeguYN/gtREmhGmzO2M9b/W+a7dnoUTmbrq0BBeFql7i52FqCQIpBIk8Yvnd5XP0VldZVwxplyERpNz1SNbCel8BspyFo1cp1ctigraQViemN7v2UCYH9BpnHCanxt30FPpVfOTOTAhH+cz2yHWP1ZePZGv7nO0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550544; c=relaxed/simple;
	bh=l0uR5s+QUSnA9LUnGHRVXKaOcKJDMZT/h4AGYjhVxGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6HpbzoluFOyTcv/WRzdlTtWBwWVip/rxKcl85ESpYAeq9WLdtYoxL1QjPldvxrR57TroIRpwLi4kX/FtBnRiOLBnh/fx1xUy3u4cyNQQegzEwXsL+Oijsx+v5PP+aQN0L2WnmwPVJ2tg1O23CypG8UeKc42lukG26c3XISWFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RZtesY8A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHVPLpN5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RZtesY8A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHVPLpN5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8AD8514000B3;
	Tue,  3 Mar 2026 10:09:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Mar 2026 10:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550542;
	 x=1772636942; bh=6MCt5L/qXohhXzQ6ZNDxccN39Inq63dK/jsgwFp9W2A=; b=
	RZtesY8ABPzJ7vCUrjLs/t7/pP6MzOBXG5QkbrWsHgiVvCR+3ImMizAUSigons5M
	vseGr5tb6VVHvlXphXeoZfL45aHYxOjxswik7ueQaOGz9HIzTLW+IUK4REvd0tSp
	dwikyWKlwqak+mukEZfJRZkblKSnQVNFQg7KoCs78V1UF8/nbgMnR86DgFwgKwS/
	77hEGkr2xxPpJTVwdLd2nPJPHU9hEE4JxU0dpO+nJ6P6xejPoaJofLzZBHp7sPqh
	HyJ+OgAQA/icHRonBqzfds0PXiJx2ZN8+brOGUgIIqReiEB1KN4+sf69BFDuemNE
	7RzrMTLkYLP8xKU2+OYIbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550542; x=
	1772636942; bh=6MCt5L/qXohhXzQ6ZNDxccN39Inq63dK/jsgwFp9W2A=; b=C
	HVPLpN5fvLWZt1LlgZ5WfABf+oKD0AobglBew8XbR0LX6PXoRTnLdyFWC5N4jviy
	+DvZvNrj8GqwrWEpM+jmjyboOpv+fDwl7pCyclxiS6uG960UUjtAoi7OpXZNq49I
	fJK3bF9jQI17qHgyCRA/cbxQ3ROln9BEF+YY0TgE0B29Q4uf+gRc7JE9CHN2CP2A
	WZ3/IC9e3CVaLBDXtz7nW8t7TUmnFPkSs9cxuykiRQLAuhAO8Rf82S5cnElf+N3d
	ludssHhyFNAo3BGpRPexbROGZP4Sbsbb0aj5bnyINw1M+AjuHSrJQT6qPMj2Vg/5
	R3F7RvL8zzFe94vxLUoJQ==
X-ME-Sender: <xms:jvmmaR6MTDKViJokgio4nH73MyaVZ2fWH98MMMRR3NrTE4GzAHri-Q>
    <xme:jvmmacd4Zkti2NOb-g7u6-6OY6aDAn0llgMBJKmnKJeFfhaHkqmdVq-cI3h2WHHIN
    Pc6GUJDFBJfD4dzoZm1nycwbIGuNyQZXXHG8LPpNyRH-JQvZsPP1w>
X-ME-Received: <xmr:jvmmae6kR6NQEXXnVb7j1C3f4J5KTPofvZmWH7D_7VUJi4OEwqHFPaa3SCs3s6Ze1EwacDOkHKIYco_jG6n-bMUERRB4Xa-EXiCuen934Mvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeevffeftefhtedvveeitddvvdegfeehvdeggfeulefffeejvddtjeelfeffhfffteen
    ucffohhmrghinhepvgigrghmphhlvgdrtghomhdpghhithhhuhgsrdgtohhmpdgtohhrph
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtoheprghlrghnsegsrhgrihhthhifrghithgvrdguvghv
X-ME-Proxy: <xmx:jvmmabvhy5p53w_xRbe2-8K5f9LEv493qN3mBKl39jdhrHkrprUpCg>
    <xmx:jvmmaWh-TqoU5UJ5CFtHAWBWVUZ5LFbai_1X3d1qdw1FfrkuLs3alw>
    <xmx:jvmmaeqdtzSO50uqJSkIL0bVgi_CyojfUdBZUSq1gO1KZG9ZOClYHQ>
    <xmx:jvmmabtzL3iZKBCvyxjuOCB5iga6OC5C-hH107u9xh9A-6nmeCCslw>
    <xmx:jvmmaabnN8yl9eZ-2xh7sImHk6oHQehh44PL6u_xfF_F8_UOa5m9k40I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:09:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6daf4c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:08:59 +0000 (UTC)
Date: Tue, 3 Mar 2026 16:08:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Alan Braithwaite <alan@braithwaite.dev>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alan Braithwaite <gitgitgadget@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, jonathantanmy@google.com,
	me@ttaylorr.com
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Message-ID: <aab5iICOAMrH2aQZ@pks.im>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <aaV6PLJCrpb2mQnq@pks.im>
 <xmqq342i12ky.fsf@gitster.g>
 <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
 <aaaACBJVAZPypVtn@pks.im>
 <d4e2aa7e-6c6e-43a5-96ad-848d9447d194@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4e2aa7e-6c6e-43a5-96ad-848d9447d194@app.fastmail.com>

On Tue, Mar 03, 2026 at 06:00:29AM -0800, Alan Braithwaite wrote:
> Patrick wrote:
> > No, you're right about this one, and I think this is a
> > sensible thing to want. But what I'd like to see is a bit
> > more nuance, I guess:
> >
> >   - It should be possible to specify the configuration per
> >     URL. If you know that git.example.com knows object
> >     filters you may want to turn them on for that domain
> >     specifically. So the mechanism would work similar to
> >     "url.<base>.insteadOf" or "http.<url>.*" settings.
> >
> >   - The infrastructure shouldn't cast any specific filter
> >     into stone. Instead, it should be possible to specify a
> >     default filter.
> 
> Thanks, this is great feedback. I took a look at the existing
> URL-based config patterns and I think the http.<url>.* model
> is the right one to follow, since it already uses the
> urlmatch_config_entry() infrastructure with proper URL
> normalization, host globs, and longest-match specificity.
> 
> Here's what I'm thinking for a v2. I'd like to get feedback
> on the design before implementing:
> 
> The config would use a new section that supports both a global
> default and per-URL overrides, following the same pattern as
> http.sslVerify vs http.<url>.sslVerify:
> 
>     # Global default — applies to all clones/fetches
>     [fetch]
>         partialCloneFilter = blob:limit=1m
> 
>     # Per-URL override — more specific match wins
>     [fetch "https://github.com/"]
>         partialCloneFilter = blob:limit=5m
> 
>     [fetch "https://internal.corp.com/"]
>         partialCloneFilter = blob:none
> 
> Design points:
> 
>   - Accepts any filter spec, not just blob:limit. This
>     addresses your point about not casting a specific filter
>     into stone.
> 
>   - Uses fetch.<url>.partialCloneFilter, following the
>     http.<url>.* precedent. The urlmatch.c infrastructure
>     handles URL normalization, host globs (*.example.com),
>     default port stripping, and path-based specificity
>     ordering — so no new matching logic would be needed.
> 
>   - A bare fetch.partialCloneFilter (no URL) acts as the
>     global default, the same way http.sslVerify is the
>     global default that http.<url>.sslVerify can override.
> 
>   - Only applies to initial clone and to fetches where no
>     existing remote.<name>.partialCloneFilter is set. Existing
>     repos continue using their per-remote config.
> 
>   - Explicit --filter on the command line still takes
>     precedence over everything.
> 
>   - If the server does not support object filtering, the
>     setting is silently ignored (existing behavior).
> 
> I chose fetch.* rather than clone.* so that both git-clone
> and git-fetch can use the same config. In practice this
> mainly matters for the initial clone, since once the promisor
> remote is registered, subsequent fetches inherit the filter
> from remote.<name>.partialCloneFilter anyway.

I think using something like "clone.<url>.defaultObjectFilter" would be
a more sensible design. The idea is that we'd only honor this filter on
the initial clone to basically be equivalent to `git clone --filter=`. I
don't think any subsequent fetches should be impacted at all, as turning
a full clone into a partial clone would need more consideration.

Patrick
