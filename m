Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D528DF4D
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789946; cv=none; b=P4TCeqqBg2KeTEDc4kT4VdHc5ppAKxRSEjBM1/G0qzf69VeVbpzARQGQYiZ4PeNCkdPeUY5uO6AFXW9+HVqNc5cokKM04PWdWyjqaFB3XiionGJvsRKSVoWkJszOouDtB9bu5k955lZfe11MEcPqRp8im6godu1xXQwM97aLQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789946; c=relaxed/simple;
	bh=vLbPQOgrAWo4OABH5KpP3c2tLzNvgLWfIbH9Dg+UMBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3Nntq7u4JPRfQfK2VB+lC0pFL6hbJtCOtdNWguJmzWtWUo52E2xMNpGBe93Lj3rZvX5bBYKaL7qnsSnonSCv5gkjCr4pZxNwzQE69OS9Vr4N8MU6QmajFbuBZDJhb69B00w9tmQi2MLqZM3ndz9jOFl2MPSV05Yx3LwqaWa2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qHZM8FtV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mQFRRrNo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qHZM8FtV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQFRRrNo"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F24E1140193;
	Fri,  9 May 2025 07:25:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 09 May 2025 07:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746789944; x=1746876344; bh=jpA/FMQumo
	eUKg+t52+WhBJhEL36qVoxj775J31wahk=; b=qHZM8FtV+ybIs0IEU8Z2wXr9uh
	bs4dWUBuBNh1oQeLOWcH6l5dDw0YdE2DlRjWO6pBLJHnX/tcGzcJ0Ns92XtEpLQT
	vwfhu0QQOJHNdf9TuFwG8lAPxU2vlWLVQuRrPU72iP/lFAf3zNVCCm6niCmXE+dc
	ipUsiBlwRVoYESk49tI2OGyILHzGMqT+DeK/Wt0vJ8uMbWhQ+GKJhnZbAlCCUqpa
	P+6gz2pjXmnkkw7UIL18juKkGYljKssjgDOrtbryVZcRBrJkA56Nzp/5Cgrg7cAY
	c1Ad3CL3y3kaEsyvQwUtCv7HzYi1wehyZsYy3N93pTR3nvC3zpGWm1Jv+Zww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746789944; x=1746876344; bh=jpA/FMQumoeUKg+t52+WhBJhEL36qVoxj77
	5J31wahk=; b=mQFRRrNoKp3PqoJYwPr4jEmiQfqTZoVwtH8SB33XwxZJjv9+G7d
	0RMn02UCIvp6QTSV3avQvAt54EHYeO6tdNr3pHJqIDWa6A83Q06JeaQAFV+8hFab
	/zPSw9Rkt4YiqBWDPGuoID2S5SqCkjAGykeTEEaD2Tls5xZ2pRlGoxxF2bLhuEZJ
	+QyhEdmXsKNC/yWAS3ZtYP5OnaJX8cbqji7Yi5uuVWi2jwQhX5KuTglhZO8jeD10
	Zrf66l3VWU3brapTczTNFqz2yEffBnLc/Wax390zMvx+62Ft2tlFor2HryH6GB7R
	IFd/UKRy5LJ5KJTIQMoV95+aCicrPQJvA+Q==
X-ME-Sender: <xms:OOYdaHFyZ_rTHDT9v87ptr-HSssZQPLtmAlWXfmN1NjxVV2P3SFcMg>
    <xme:OOYdaEVc_1S6vqO9sx1hZ-BPOoPK362bEYqH5i5LcLMlpOGDrmUFfSx7Y_Z3KTZr4
    U-yOYxh3HyYxjw_Bw>
X-ME-Received: <xmr:OOYdaJKfnHoCFTcXKed72CqmfJVrubkK063Q4jWCZiVaJRMlMoqkrxrqEdFGbgClfSOI6jIdw8wpul0zMIZA0dV8rEHXo5shuzpoFvRH5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OOYdaFGJiOdv5AmRGB3NSiF-A16OSIkiBPrYcFazKy8EPvnnuVUrOw>
    <xmx:OOYdaNUBcVHQj6Rp8VN4nRsqa14oi-Ox2gGTsN25yDB811bCE2Y7Ug>
    <xmx:OOYdaAPCBRx4c_92dNJvJui1JSKfBjNSrZa-q0p7ywbcNhvwOw5SOA>
    <xmx:OOYdaM3eIwJe-3Yfkc9bIY1LelB3crHs8NPqDJ9_TqLtfK1GBPeB4w>
    <xmx:OOYdaEDwmdfrAtTE5TWk-3Ni9MsfWxOs_-IL-15JGJUEvfWI4kWbWTo->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 07:25:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ed57c11 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 11:25:43 +0000 (UTC)
Date: Fri, 9 May 2025 13:25:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/17] object-store: carve out the object database
 subsystem
Message-ID: <aB3mNiiAGE2KHbGY@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com>
 <xmqqa57oe4mj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa57oe4mj.fsf@gitster.g>

On Wed, May 07, 2025 at 10:02:12AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > Patches 1 and 2 involve renaming some core structures, and I had
> > some questions around these names (since we hope to be stuck with
> > the new names for a long time). I was thinking out loud on a per-
> > patch basis, but now want to collect my thoughts around these:
> >
> >  * raw_object_store currently describes the abstraction that contains
> >    all objects that can be accessed within the repository. This may
> >    include multiple alternates. Patch 1 renames this to
> >    'object_database'.
> >
> >  * object_directory currently describes a single directory that
> >    has the same structure as $GIT_DIR/objects/ but may be an alternate
> >    or a submodule object directory. Patch 2 renames this to
> >    'odb_backend'.
> >
> > My concerns around this are basically around not liking "backend" for
> > this purpose. When I think of a backend, I'm thinking about the
> > implementation details (like the refs backend being files or reftable)
> > and not multiple distinct locations that have their own objects.
> 
> Yup, odb_backend_files (aot odb_backend_redis) or something?

Yeah, that was my vision indeed. I think it works equally well though in
case we name this `odb_alternate`. The benefit of the "alternate"
terminology is that we already use it and it's almost a perfect fit, and
it gives the reader a hint that we may have multiple alternates. On the
other hand, `odb_backend` sounds as if there would only be a single
backend for a `struct object_database`.

So Stolee caused me to reconsider and favor `odb_alternate`. But in the
end I guess that both names would work alright.

> >  * 'struct object_directory' could be renamed to 'struct odb_shard' or
> >    'struct odb_slice' or similar. I may even recommend 'odb_partition'
> >    though that does imply some disjointness that is not guaranteed (an
> >    object can exist in multiple parts).
> >
> >  * In the event that we create multiple implementations for storing
> >    objects, then a 'struct odb_shard' could point to a backend to help
> >    find the appropriate methods for interacting with its storage.
> 
> Hmph, I do not have strong opinions, but I consider it an
> implementation detail of one particular backend, namely, the
> filesystem based backend, that it can link together multiple
> object_directory instances and present them as if they form a single
> object database, just like all files within a single object_directory
> form an illusion of a single object database (aka key-value store) even
> though some objects are stored in individual loose object files while
> many others are packed in a single packfile.
> 
> I did not expect you would want to go to the world where a single
> "shard" consists of an object_directory backed by the filesystem and
> some other more database-y backend.  It is an interesting idea, but
> we'd need to worry about many things we do not have to worry about
> right now.  E.g. what do the precedence rules among different
> components within a single "shard" look like?  How do we express "in
> this repository, local filesystem-backed piece is consulted first,
> and then check this piece backed by low-cost but high-latency
> storage backend"?

Well, in fact I want to design this from the start so that you can mix
and match different backends. I think it falls out naturally from the
design if an alternate can be backed by anything, and it has a lot of
very interesting features.

Furthermore, it would cause a bunch of problems if we _didn't_ allow for
this, at least for hosting providers:

  - Migrations would now need to be atomic across fork networks where
    all forks need to be migrated at once so that we don't mix backends.

  - Migrations in general would be a pain if we had to do an atomic
    migration even for a single object directory. With mixed backends we
    can already make a partially-migrated backend available while the
    old backend is still in use.

  - High-latency storage backends may work well for binary files, but
    not for smallish text files. 

This all of course still needs to be hashed out. I do want to send an
RFC document to the mailing list soonish, probably in the first half of
the Git 2.51 release cycle, so that we can discuss where to go.

> > I do mention that the rename of the object-store.[c|h] files may be
> > unnecessary, or perhaps could be delayed until this series is merged
> > and the collateral is calmed.
> 
> Right now, merge-fix needed against all other topics in flight look
> like this, in order to merge it to 'seen'.

Okay. In that case I'll keep that patch for now.

Patrick
