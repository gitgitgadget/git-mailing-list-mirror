Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7611256C6C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405634; cv=none; b=HSUblYADDgn6OcPd4u5bmeNUuIcrceA0ASpzUYNF0hYMJqvuFYUcGAC+ySQIWV1w1+deluKpSbbFZ77ciATSN8JjQOXI24CCi9hjdGeUX5b7KHU5X9v71JLa5s8ako2n8upfM19B6qbsN9cE2FJuCOySctKT/VFrCYujAGDyku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405634; c=relaxed/simple;
	bh=AraM7w2GEJj4IUD/JJ1Xj5Tb9yfEDdLOD0ZzHLy4p+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWGEyIRwvXBnwMCapsRj3SVwjxDFGVvZsM4k7d2zBGI0GQFVokJGDUu0j4vJMAaV+4K4TzTd79IVhggYFoF/bQPcBHjg1Sra6VncZTqyNmL+ZIi+Y9ZnbgDDpjSzuH7YB2+/eaTr2t5hM+TmkK6BOn1HVPKMQ10eXYb6DMAwIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ekDiiTRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n37gkKww; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ekDiiTRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n37gkKww"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E6F061D00139;
	Thu,  2 Oct 2025 07:47:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 07:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759405631; x=1759492031; bh=OO0b75CBFF
	GkmqicMtJcm2kK+X0JPBD6b9Jt2Bc9zuI=; b=ekDiiTRqFkH5y7b5xDMChCuzyc
	771bqZmWRa0VBt7keBblh5pgswnVA2l9GIvVUblc2DicacbXNzAudQIbdlB0MfBU
	0xmvl5WwSb1ZNLgJbwrTNZmlsjEsGIHOoaREyzWUty5wGqq+JcfltHDmZPT0clyz
	NeZwJZ7JV58PYMaUwa/8HAA8QZkXGZyZwLOYausZ/ziTBxLJhCXkNKp/CPDsbomT
	joNlP0mw5XnO6T/rKKoINsEdYIssTIRL/UndMUDV4/eQoFDHkjT/Xzk6ATk1jCJ2
	DeRBasdPwI3MxIYGOaC7OYpFsQ+3JtHqbtsKq6ROsxklnQB36Khv+KxN/Izg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759405631; x=1759492031; bh=OO0b75CBFFGkmqicMtJcm2kK+X0JPBD6b9J
	t2Bc9zuI=; b=n37gkKwwVeXifoUopO9QkH0J3KQksxFi6HTiaQcohro0hd57WjB
	5J6msgDv8A/+NGnj+JgXR6ZiSyuPALD6RYUyENCuZ92bXqXgmPH8qBkDdChLQeK3
	llX3yU+iR53qs34gdSp+xBwycWGeOiGhkVRHxp9aFwOQm0shivrE8eJ0U8nWeh4V
	+MBPU+4CbrNccMhYPKnlCaCo8de7YBFp/3wy10CMRplXTQJCmR8oV1Irw9d27W7k
	6FkY4GE8h9SusbQGkbwD9aFWKX0HuE1ofOz6vx10YeqnnsyIbbGYj7nQjA6lA4bD
	H0x2dYvej7Cal4BabRp5VzBpr2lV1ZxVy5g==
X-ME-Sender: <xms:PmbeaC6LQjOZAUFljpXbAA2HURPq-Ks11-o1Fcf25HjIe-RKu3ubyg>
    <xme:PmbeaPnXOcYbpqUpARGuV8ahU_f28QGw680sLpSd5_Jh729tTzg32LAZ9izDSt5fP
    tot9U0lYRslP2o_hXRXBTxPQiTu7XhoQ-H_XzBSp2ay6PDXmuFBMyM>
X-ME-Received: <xmr:PmbeaLQF-q5aitOV5qG8gdC_oSjc-ZxCgs3-dzpPmd_CYdhhoXODtJqV0IgaqX8N_1RvKnYZsZcyYd3mGg90d2QUhTGKkRCC4ywlH0rxzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehsihhgmhgrqdhsthgrrhdrihhopdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghnhihouhhnghesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PmbeaGGVcV8GzaUHMbbw46KqYPa_tv7wpmUfMmyUWxbH-Xp3jyMw9A>
    <xmx:PmbeaIGPc-n1Y97fFXj8mpZTuCz-S8eifEtke7LMksCsJPnThOJP8Q>
    <xmx:PmbeaMQePvHF6I2aXQ1dihBrRd1KcFfAdn51IWG-XFo_uQKSRo_51g>
    <xmx:PmbeaBKoz-mdA5In4JXEzl4viW3XOhaZD2GZBvGfu5nsIExYTuA9uw>
    <xmx:P2beaGUrGaMuti08Ob-0GfLGyk-UvM156snzeEAQsq-tKmTVROT8Saag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:47:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c57e0f53 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:47:08 +0000 (UTC)
Date: Thu, 2 Oct 2025 13:47:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org,
	Han Young <hanyoung@protonmail.com>, Sigma <git@sigma-star.io>
Subject: Re: [PATCH 1/1] files-backend: check symref name before update
Message-ID: <aN5mOTbGBcr355E6@pks.im>
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
 <20251001150805.9652-2-hanyang.tony@bytedance.com>
 <xmqqv7ky1l70.fsf@gitster.g>
 <CAOLa=ZTnHQbg9ocdA1omqER6CJH-w30G14-F2JAQMtueXENWew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTnHQbg9ocdA1omqER6CJH-w30G14-F2JAQMtueXENWew@mail.gmail.com>

On Thu, Oct 02, 2025 at 02:54:54AM -0700, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Han Young <hanyang.tony@bytedance.com> writes:
> >
> >> From: Han Young <hanyoung@protonmail.com>
> >>
> >> In the ref files backend, the symbolic reference name is not checked
> >> before an update. This could cause reference and lock files to be created
> >> outside the refs/ directory. Validate the reference before adding it to
> >> the ref update transaction.
> >>
> >> Reported-by: Sigma <git@sigma-star.io>
> >> Signed-off-by: Han Young <hanyoung@protonmail.com>
> >> ---
> >>  refs/files-backend.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/refs/files-backend.c b/refs/files-backend.c
> >> index bc3347d18..d47a8c392 100644
> >> --- a/refs/files-backend.c
> >> +++ b/refs/files-backend.c
> >> @@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
> >>  	struct ref_update *new_update;
> >>  	unsigned int new_flags;
> >>
> >> +	/*
> >> +	 * Check the referent is valid before adding it to the transaction.
> >> +	 */
> >> +	if (!refname_is_safe(referent)) {
> >
> > Shouldn't this new condition share the logic with what is done by
> > fsck?  IOW, after doing this
> >
> >   $ echo ref: refs/../HEAD > .git/HEAD
> >
> > "git fsck" or "git refs verify" should barf (if not, we should make
> > them barf), and this code should use the same logic to notice that
> > the target of the symbolic ref is bogus.
> >
> 
> Good point. I see that 'git fsck' does complain about this:
> 
>   $ git fsck
>   Checking ref database: 100% (1/1), done.
>   Checking object directories: 100% (256/256), done.
>   error: invalid HEAD
>   dangling commit ccd1771e44a18887197d3ee26ca37c2e892b9fb6
>   dangling commit f99d68ea2c378218e2360dee4e24115c404f6a66
> 
> However 'git refs verify' doesn't...
> 
>   $ git refs verify --verbose
>   Checking references consistency
>   Checking refs/heads/master
>   Checking packed-refs file .git/packed-refs
> 
> Okay, so this seems like because fsck also parses all references to mark
> reachability and also parses 'HEAD' via `refs_resolve_ref_unsafe()`
> which fails.
> 
> This symref checks and checking root refs is definitely something we
> should consider adding to 'git refs verify'.

Agreed! Overall, the goal is that all logic to verify references should
be contained in `git refs verify`, so that git-fsck(1) only needs to
shell out to that command to perform the full check.

So if this logic isn't yet part of `git refs verify`, we should migrate
it over.

Patrick
