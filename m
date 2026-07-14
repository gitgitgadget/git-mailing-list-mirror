Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612B359A90
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999900; cv=none; b=r1J2VavcUloBypjXjzBO4BNVuWf8KcS00zVyC7+hfBULP1iDpZg1mQDQjyi2Ja1i51R/dxJzmN1NoKhHOQ/hXO6NLuoh3B2xjDcZBpU30+oo/Pgiwxbf3WK2zFh7cPLv86xDF892X6K+9QMqaS/61EV2H6VI7+6h0joo70TbBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999900; c=relaxed/simple;
	bh=EfQPaVU/EhEZTXvpalc4CSan9zIPmB2gRgAFKkdt6PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZjBUDaM/as6VCmd4Bz4JIJQYTfr2i0n/5Ti9uHuYpiTKMS9C3A0IBIJJTvZqXNdnAJUVmtR1VGaChC+9DwODr5p2oL7cbY3yAtJXcrkZPlKK7sSgZupfAnRVq8mUmDrzkvAdVCDPu27SSRrz3Q//PWQ7EAGs9J0beNoBjg1lQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=GTQc3ITP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="GTQc3ITP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2cce930cso4569431cf.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783999896; x=1784604696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6zv2ZGc4FiOyVmBu5qz5EepZnK1zD5Rrhg+dVgoEQX0=;
        b=GTQc3ITP8D6VcOP4G8ppo/ZkfzWG8J/rWdSe+KgvHC5kpLDL91hLaPE8dGRK/Lumz9
         6cB44njC26uMik2gDQf63dgqJzeDM45SCV/688fXo9i/oiTSy1PbqdJiQXw6OCA8aZ7/
         RBI8dT2wZxUCOmDEuUS2bEk+KRMWQmFB59UD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783999896; x=1784604696;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zv2ZGc4FiOyVmBu5qz5EepZnK1zD5Rrhg+dVgoEQX0=;
        b=LJGiDe+NW+B6d/ZyU/eJHD9IY8o7r+V5zHsq0v3MbrgXY2hvuNUaxMxMqKDmBCU3dr
         RmNh2k/dzntt1zCZv36Xdw+MB5wLqBfXstb2RzHSxkIa36qsqnNiR4rXfHJiCDStv/7Y
         FQeHJqkCV1kiL05rG/KBUVjj88n5rHbxEEvLN+kIx86TvQv6gwAxrgODIsR77lykyPOI
         7jv2Ynz+YxNrokPovHNJQhJSWlzJ80WWItn0Tw2YZTgwXNiw3pZuuOu5cN7046vOwvqe
         ur6XEjLBwCD4XrF4g0CL5wrrvvP7G0lhZM+rVNFFH3hctw0YN5o95D7J4jct2JP0mbue
         dHBA==
X-Forwarded-Encrypted: i=1; AHgh+RpsBdH5zMlDbUKaiNDRxpEOoM8fnQBn1Wg0KCnXL5QiFjk58w0UaDOyE2c3z5s/TB7xuko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOq1nlCs9uR8hTXwzMrUxIemQ+1j+MGRXGOhU8a/a5dHCUwtsM
	LGh8PY5iNyQO0pbYfOS6Ox0Mh4N2m81+dOuvWuuaMIkogrP3IpYuKUJSNK4KG1TFrBY=
X-Gm-Gg: AfdE7clAeafmFcOoBL6JoeZiJFL7QSgmHhUi5+wz6Ixj3y5aCcYwhzfHWEtNa3G5dOb
	E1o/OmqB0zQtUB4m3aWoofoi3YITSvpGlbGehBDFSOGtldNDm9V2kiLyfABs45xtNCkpt1IYaTB
	69kgzmvPiAXsGhE2IRtQAjWUD0aZPxuIlUNmU362VJZQJ00Ohk0DVavtNSFWLtbtxiuw9ulvoL0
	7bsjnv4ZQP7a1/44gGF1UR+6Lnximyf1qjlBcfF3J33SxpHkvAiCYZ8E3zFBtxJdti9QuBA9JLg
	UsOhJlPQwQJCtjnooid70j4OQyVVeAYTy9tguV+3aXCD8PkJvbEBVwl9sFzFQ1b+ZLhqzlc8pru
	zUsIyayhSTejCVqtzQXq/MBrIcL0Gt9Od6nWELpIQ6V/r9dZHs+Mzh4ZMrgyTI7oTImPIRIqH87
	X1sxBfE8qmpOa5yMMLAenH89pd
X-Received: by 2002:a05:622a:2d5:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-51cbf0dff29mr114337391cf.11.1783999896054;
        Mon, 13 Jul 2026 20:31:36 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm151617506d6.30.2026.07.13.20.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:31:35 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:31:31 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson <krka@spotify.com>,
	'@com-79390.smtp.subspace.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all
 chain layers
Message-ID: <alWtk5eQqS9JTzDr@com-79390>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
 <ak0D44nhSH/98WYD@nand.local>
 <CAL71e4OuU1+KHd0TrcxDX2dyoWEJXmi86m8u+E7vtxhcSF6M1Q@mail.gmail.com>
 <alFuxPQQcFxseAzh@com-79390>
 <alSCv5I94qjbSucQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alSCv5I94qjbSucQ@pks.im>

On Mon, Jul 13, 2026 at 08:16:31AM +0200, Patrick Steinhardt wrote:
> On Fri, Jul 10, 2026 at 03:14:28PM -0700, Taylor Blau wrote:
> > On Tue, Jul 07, 2026 at 04:57:13PM +0200, Kristofer Karlsson wrote:
> > > (b) Move topo_levels to struct object_database. Since
> > > fill_commit_graph_info() can already reach the odb via
> > > g->odb_source->odb, no signature changes are needed.
> > > The write side becomes a single assignment:
> > >
> > >     ctx.r->objects->topo_levels = &topo_levels;
> > >
> > > and cleanup becomes:
> > >
> > >     ctx.r->objects->topo_levels = NULL;
> > >
> > > No chain walk needed and the diff is fairly small.
> > > I am not sure about the semantics of it though -- should the odb
> > > have a reference to topo_levels?
> >
> > This seems to be the most promising approach, though I'd be curious what
> > Patrick's thoughts are. The commit-slab API is really a property of the
> > object database, but we treat these as a global as I do not recall them
> > yet being touched by the ODB refactoring effort.
>
> I was investigating several times whether we can remove them from global
> scope and move them into the object database indeed. The answer is that
> it's somewhat complicated because we reuse the slab for multiple
> different things, and detangling that has proven to be a bit of a mess.

It's an interesting question, and I think worth discussing, though note
that I would also like to ensure that we resolve this in the short-term
to prevent any future regression while the pluggable ODB refactor
continues on.

> The other question here is whether commit graphs really are a property
> of the object database itself, or whether they are rather a property of
> a given backend. Sure, we can only have a single commit graph at any
> point in time, so they feel like they are at the object database level.
> But is the current implementation of a commit graph really the best for
> all potential backends out there?
>
> If you take for example a distributed backend to store objects, then you
> probably don't want to have a single local commit graph that is stored
> in ".git/objects/info". Furthermore, the current format may not even be
> the best one to store the cached information, either.

I think I agree here in part, though I think there is some subtlety that
is specific to commit-graphs.

If I understand your argument correctly, I think that I am on-board with
it if you substitute "commit-graph" with "MIDX" or "reachability
bitmaps", as those are optimizations over a specific representation of
the object store.

The commit-graph is somewhat of an oddity in that regard. While it is
partially an optimization in the representation format, it is also a
data-structure which is useful independent of the underlying storage. On
the former, I absolutely agree with what you're saying: having a
row-oriented layout to optimize commit traversals may not be necessary
in a different implementation of the object store which has efficient
enough access to the commit objects so as to make the row-oriented
layout unnecessary.

However, it is a useful question to ask "what is the generation number
of this commit?" independently of whether we store the commit objects
themselves in the existing ODB, in a generic blob storage system, or
something else entirely.

Thanks,
Taylor
