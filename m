Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5A3BADAA
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352211; cv=none; b=HUlCazoWyejGgNrxv6MByoDl0YGNQGRtln1Yp0ARXK+cRPuSjfzSQi+Ql0OAxJ1y84u48kaZmzgel7HH05AB4gCGMu0/267/j0E7qVXf99wPMcM1rHNtT+bsrD1l5vxiJZAnfR8kso9rQHZPNQVqYWzSkA6FaaCgjYkMhUMNMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352211; c=relaxed/simple;
	bh=0jRNbfekCw7/8lk5khPujQeZ97ptpmfwzLM8N1kYvj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYrZdIt8Brv1uV27aD0jzZp+/BVWp03xDJzF1fMNbOgN+Rt30QDUGYx29UUv9CPyvS07aMDaMRIff4AcWed3jFdrNAq1zRyOwS1B1FnsPabpnkZ/mlARCpkdMHhF4T8ghvr/6naceGa1Vv1CN7tTTqTHviZXIt4vPvu08gqpOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YpGrTrk6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HrgH8d3P; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YpGrTrk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HrgH8d3P"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94640140017D
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 01:50:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 07 Oct 2026 01:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791352208; x=1791438608; bh=dnFXAWPvjY
	ZUPGWQ9rw2egPsizMFO15jj2A+vFRLWMQ=; b=YpGrTrk6vvkyGHF3vsnmo8KdyK
	mXfVhkaEMqTKDRPfV+leqc/4Eyipvy5Vh9ZrBllxKe0mBSwKHNhaVc+cmbq9Txb6
	mg1Nmmx8T/njZIVLYxEJDkZ0gomOnJDP6+kwtebZDEBamuhBgAhMKZeBC7NSFKLU
	IhcDjgyrWaJtGInvZb1deAS4JtU1tkh678pjoOD4o06rwZyzE8cYLrBqBiGJol8A
	dW+PdUbJPCaK5XO2k0r480dR4AatM/gfIW7O65muqev4PjvxOdW86NBdj9EblJBS
	13YqpC4jU95ibDrjnA8KZyf1krRQSGMJpCSaepfcKNpS9ULxv8q2b/1Y2RcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791352208; x=1791438608; bh=dnFXAWPvjYZUPGWQ9rw2egPsizMFO15jj2A
	+vFRLWMQ=; b=HrgH8d3P2zeFsNzgW/xns9V75siXwB1QY1Nex28RZlalHZAAcGc
	SnV8NucY4pxzDCaH7UbFhiHFplcyIXacI/eaovKUzJSJdZ9EpyKB+TI+0S3j1I0o
	5CGgg8xANIBSZEkFLrx3syMxJJ2M1jLAuR6p1i1vRVpQod3nTwV14AXEo/wV34sl
	M+RiAtOWxNAYMvuCGFISXZi1bQxdFxv8OieO5tZuWwjw/8z0yL9ZaBmz4/ydkSkj
	P+qT21v4A54AmZg8iGscJZEJCN0qDmkG1+ZrglW00Pn0MBpQPas/9Be4K0IYz0EM
	nkvqzLOnSa94IjZPdzS6QZUYZgcvf3pwNww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791352208; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jLjkYOuY8iincUduCNgpDgQnNtaKyODqdHw1hb6mGy0koAR
	DZIKC4+AasloNodUJxCvb6lwQYLZJnVD94RNH5flw9E6eQahFoVqpVjz65PC5fG5
	QWicfhNeQoNuFTWDcV0ywktRxmNOZi/N2+kc7b661rXH/C191AauHyUpK/0IQNho
	HwEn4TGKPatiEdECgknntuZQ1N3q1YHrx8t8hgVMbdePpo3NrimHewEdf+NlQ+5j
	wdPFlbKlfb//IxzCvouapDH5o7Lz3ENZ48HHlpFOjRrd7zJKLbHVdgp/+1kpNJU7
	sZg+3OwqcSOO55/Y3yuiJICKlJh6Q4TouWEtYlw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a/ncKgMiGBGIl7facpEsxD9QZ/uEfZ4B01H4b023Mt8=:0jRNbfekCw7/8lk5khPujQeZ97ptpmfwzLM8N1kYvj8=;
X-ME-Sender: <xms:kN3FaiTz7yHf8XHbUXL_MzCU8-7P_-wNr7TNoEnpeB7UYq1Z0QajLQ>
    <xme:kN3Fatx9YD3nF_hByPFFI9xVAwRG9MbyoWpSCPkRElERAxQZul39yx3d50VOfO3PL
    ddYmD9BZGzHReSWawbmgONR1cfhfRVlunjckNcptYM22RtZsyubbw>
X-ME-Received: <xmr:kN3Fatc0QtbR9HZcAmDJAGsI2NLMLPUZC_h5--nAWln10FHN-EcVeQ>
X-ME-Proxy-Cause: dmFkZTFbs5/svFoUPgMppV60mlQLiRkpZpISHdwm25rOflmNiWtibARM10lEvMZ7bJRXQK
    mOLZ7ogGFfbNaefjs6PqX3YH2EjkW680wb35jPoMe3JDmbVcf/V6wX5IhBQ07/T1n70W4H
    hVIzc5U5JPZY4XCj0s04N/QOgDNGOpsrtLqJpFohTfT4GAU/qPHf0T/vyLctpc/TCsBcBQ
    0sjvCE+c8RS9Ve/rhPjUa19mlszrKIieZ9W3mT9psxHb88zak7VchY/UNpjejT8tRykvJw
    LaSyI1NX0fs7rbIVcFPFAlX8BX9hd/mW+oxyQyzmD9ysSETJkYFKdwvTsKeATWNztYReUW
    kKYJQQIlSYuwrrWlaOYlQNJYOHky+HSzA/odDB/HKS6XYBK85kScsM6JbMC42Q69JBjxUa
    finOm2ZYt9Y+0MFb+In+FzcpmVnf3gHpjEocbUrctFDtvbA9CiZIylq9O5+Vaa8l12ZWIm
    Ld6PqRZpk8Bt2osuVd5pQj2Jq+86m7wAoLUNCKikhWnaWZU0Rq0Yeb+Pa5BQuxRJQqRFbe
    Uzi1+/gIkbvCzNSs+WYo8XYMtTnx74RPms8dbECNaXBb1SIMCwtwN34jTn+hCg38riP4gt
    raN826ophG0sZU97QJrViLeJN0TkpuxfJbKtQCPPJXCXGGg81cXqjEljdDMg
X-ME-Proxy: <xmx:kN3FapLytwXerGjU8I6P8ANfKx6wMIOSQvFQ1gnEoSO2GiLtdNZQFg>
    <xmx:kN3FauHxn9d5CqFemCmUNkZf0Aud54uQZTyqRApek13BSPBAGgKqBA>
    <xmx:kN3FajoObjkSgp0DfU05aQf_GpylbRCpQGsT7mgkLz7NTVcnRv0etA>
    <xmx:kN3FanTdsJnz937jrFicrUfP4EFxO4l1WaVxuTbsYYi3oPvM-vazIw>
    <xmx:kN3FamCAuvJ7qHHSg-a89y5sgo_vUoIt3bmY248HyP2lPo6SHwf4ouic>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 01:50:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5cd0bdc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 05:50:06 +0000 (UTC)
Date: Wed, 7 Oct 2026 07:50:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/13] odb/source-files: move alternates into the backend
Message-ID: <asXdi77RtGD0F8SM@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
 <20261002-pks-odb-move-alternates-v1-12-8a63507b88c4@pks.im>
 <CAOLa=ZT8wHAkCHiRqG1Op3YuBR6M6X+f0Wtu2Q+TR2GTcC8q0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT8wHAkCHiRqG1Op3YuBR6M6X+f0Wtu2Q+TR2GTcC8q0g@mail.gmail.com>

On Tue, Oct 06, 2026 at 01:51:33PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Originally, when designing pluggable object databases the goal was that
> > the object database can have multiple sources, and every source attached
> > to it could use a different backend. This would have allowed for quite a
> > lot of flexibility, as you could trivially mix and match different kinds
> > of object storages in whatever way you like.
> >
> > But while well-intentioned, this design led to a bunch of conceptual
> > problems:
> >
> >   - We're now trying to read objects in source order, whereas we
> >     previously tried to read objects via packfiles before trying to read
> >     them via loose objects. This led to a performance regression when
> >     using alternates or when using a quarantine directory.
> 
> Could the design be instead to use a mapping function which allows us to
> map objects to sources, based on some characteristics of the object?

You could, but it adds complexity that only needs to exist because of
the needs of the "files" backend. Ideally though, we'd not be leaking
internal implementation details of specific backends into callers and
have the interfaces be as agnoics as possible.

> >   - Some data structures are supposed to only ever exist once, like for
> >     example bitmaps and commit graphs. At the same time, those data
> >     structures also span across the union of all objects, so they may
> >     cross sources.
> 
> This is not really a problem for having multiple sources though.

Not necessarily, but it makes it extremely awkward. The sources now need
to reach into the other sources and be aware of them, and that is a huge
design smell. I've tried multiple times to squeeze these data structures
into the design, but everything single time the result was atrocious.

[snip]
> > In short, there are a bunch of conceptual mismatches when we have
> > alternates and pluggable object databases coexist. So while the original
> > idea was nice, it does not result in a system that is easy to reason
> > about.
> >
> > Correct course by moving alternates into the "files" source itself so
> > that it becomes an implementation detail thereof so that we can avoid
> > all of these shortcomings. While it's unfortunate that we cannot easily
> > mix and match sources now, that ability doesn't go away. It's still very
> > much feasible to introduce a new backend that allows for exactly that
> > use case, and such a backend may also be a lot more flexible as we can
> > now add new logic to determine which objects should be stored where. So
> > the original motivation for having per-source backends can still be
> > realized with the new architecture.
> >
> 
> Okay, this makes sense, so the new source could be merged source of some
> sorts, with internal logic which it uses to map to different sources.
> Nice.

Yes, exactly. And such a design would also have three important benefits:

  - We can start from scratch and be sure that such a filtering system
    is well defined instead of trying to shoehorn this into the object
    database somehow.

  - The design can be a lot more flexible because we start from scratch,
    and it can easily have configuration to fine-tune things.

  - The logic to handle this would be entirely self-contained in such a
    backend, and its design details would not have to leak into callers.

The only downside is that we'd have to have another backend specific to
such a thing. But I'd rather have a backend specifically designed for
this that is entirely self-contained compared to having to support such
a feature with code cluttered around our object subsystems.

It took me a while to realize this myself though.

> > diff --git a/midx.c b/midx.c
> > index c0f82c4163..8638ddf0be 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -829,21 +829,15 @@ void clear_incremental_midx_files_ext(struct odb_source_packed *source, const ch
> >
> >  void clear_midx_file(struct repository *r)
> >  {
> > -	struct odb_source_files *files;
> > +	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
> 
> We remove the the previous `if(r->objects)` check here, is that okay?

Yes, it is. There's only a single caller, and that caller
unconditionally dereferences `r->objects` already. And we also
dereference that pointer a bit further down in this same function here.
So the check was giving a false sense of security anyway, and we're
basically just moving up the unconditional dereference of the pointer
now.

Thanks!

Patrick
