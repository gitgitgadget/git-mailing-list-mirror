Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109F2868B5
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789944; cv=none; b=aDzt2mLpHvyi4D+FQ33XqSBm0EtRiu2V9mI1vE5gaGigGpkeJKrEAjtFClDd5jlIFikjXWRxGK9iLWgE1n7BFX3r2G/EZzSsHxAPMQ5BE74c2P9gN8xu02MQ1UW+uNdU5NXgSr9k7k3yHUCu9Beid7CU7MUMjk7SUG/39n13Ork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789944; c=relaxed/simple;
	bh=I0JgWn86HpNIyB/g+/uSYE6tGxKayyET0dz98JjE/Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfmZSH2f/NVMnsOhXZGD0atv8cDMqHSMoYFg1FzzFIr6OSKQZ6fUMDvek3h7VVZreKTuQFgCMfYU5GqdRCERBkklVpnTONvwc+cSyM06dh32cySQEDPcQVJ1ANJZ8iEmvv/nDFbbzOtisFPw6PQlWZs0iTp7hurBg8rSixfkDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aGMbfma/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTry0bQz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aGMbfma/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTry0bQz"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3BAE41380229;
	Fri,  9 May 2025 07:25:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 09 May 2025 07:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746789941; x=1746876341; bh=S0XyGHmDAF
	uvYNrTfgmgYIdxj4E145a7GC0p2WFv1N8=; b=aGMbfma/HiUHsYbYd+i4E6Qn9Y
	la8DPFYon3Nwtyhq3i+1ub4txfVZzG1traL9viTdXcsnyhF5pOSUSKJ2VEubL/Wg
	XUxu9lpW2PERnZ56oQ4+DCccYcJa8MRa0yWdDHIXDMAkhLZVTNUDIquH0TpgwgvW
	c/quY4HOIHkk57I89jDKK9nUYP5ghYmIAudO9iGpbBpaEAVoQTAe9JlRwfKTeLuD
	m3JypcBB94pxYS5sAyMqzA0b0kPGScVqhGtOhiBYQoQCF9pbkFyKq+P0V85TBY60
	0yhl5NpGqAhIc2tRuUtjjRcBzMaTrk4oG3KPDt3qYeOfeYVhwZE1Cit/0xYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746789941; x=1746876341; bh=S0XyGHmDAFuvYNrTfgmgYIdxj4E145a7GC0
	p2WFv1N8=; b=ZTry0bQzmsLUy8o1+F4+pPewlbdqr6k2gtfJlPfOszS2npIUitR
	HbTX4UMyDG0dydtc2dQETRe4SXrgRW6ozKvOeiA8Bj8ED1TnAEpZ859TBu3rMeft
	+eA8J1XacQgrn26sZ3fXaZPQrx3If0MznIPnMTdsP2Bsr9nNAti2zq9bUGET5fvO
	C/jkRbW0in6lt+iZgeGVFhoWGWLWevrBlsIvENEzd3X+9fkQO+/0eJejg9y+Z8wB
	xPsnn+sxtI3zwKTWKKaH6l2ka8641vhFZWQsRiivoqOU4QrDDM3bjqPYNNiKomcW
	sS2mpBoegBTANAVlySgTeZQD+Bjl8USxXiQ==
X-ME-Sender: <xms:NeYdaAzUIUDVoxIBsk4q6WOsNbqhEBdZqnzGEC92GKTsemC7M0nXiw>
    <xme:NeYdaEQt8N3jT6D2axF_SJaC240_X4e8b9YxpUVxaEe_ugC1vTF1QbNKw32jCigZi
    6w_WTSXSrvoxZ8xww>
X-ME-Received: <xmr:NeYdaCW2_vHypL49ack5YV2m41uVRZv50yHVFuAjgrsn26cI95qkdwxaHX3hy4kb2mImon-bJ6UoswZ4s-zY5E-xJDRQhRwO59vStUd-wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NeYdaOg3GCarW65cTn68xv20LtjYYPLaUpuxd90eWTckLumx6g4DNQ>
    <xmx:NeYdaCACrvAGNkyx6XIRmFr6RYLxcIuE4cVe9zdBBe5I_bT8A0wCJw>
    <xmx:NeYdaPJDZgan6TiCvuti-mydzna2VifXdeJwFOAGwN28kVt4hnnw4g>
    <xmx:NeYdaJDrS4ztTPoFcjvs0QhoORkbQcJGXsQkOMSY4bPMjHGC5vzrZQ>
    <xmx:NeYdaJcKpUhD6e-JUxrqRDnwVkt_v_Q2SpnfYil0tHn5A8EUzT9zWQtX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 07:25:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2b64e71 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 11:25:39 +0000 (UTC)
Date: Fri, 9 May 2025 13:25:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/17] object-store: carve out the object database
 subsystem
Message-ID: <aB3mMtoxCcaOFn0W@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com>

On Tue, May 06, 2025 at 09:40:16PM -0400, Derrick Stolee wrote:
> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> 
> > this patch series refactors the object store subsystem to become more
> > self-contained by getting rid of `the_repository`. Instead of passing in
> > the repository explicitly, we start to pass in the object store itself,
> > which is in contrast to many other refactorings we did, but in line with
> > what we did for the ref store, as well.
> > 
> > This series also starts to properly scope functions to the carved out
> > object database subsystem, which requires a bit of shuffling. This
> > allows us to have a short-and-sweet `odb_` prefix for functions and
> > prepares us for a future with pluggable object backends.
> > 
> > The series is structured as follows:
> > 
> >    - Patches 1 to 3 rename `struct object_store` and `struct
> >      object_directory` as well as the code files.
> 
> Patches 1 and 2 involve renaming some core structures, and I had
> some questions around these names (since we hope to be stuck with
> the new names for a long time). I was thinking out loud on a per-
> patch basis, but now want to collect my thoughts around these:
> 
>  * raw_object_store currently describes the abstraction that contains
>    all objects that can be accessed within the repository. This may
>    include multiple alternates. Patch 1 renames this to
>    'object_database'.
> 
>  * object_directory currently describes a single directory that
>    has the same structure as $GIT_DIR/objects/ but may be an alternate
>    or a submodule object directory. Patch 2 renames this to
>    'odb_backend'.
> 
> My concerns around this are basically around not liking "backend" for
> this purpose. When I think of a backend, I'm thinking about the
> implementation details (like the refs backend being files or reftable)
> and not multiple distinct locations that have their own objects.

That is very much the intent eventually. Right now the backend is always
the one that uses loose objects and packfiles. But eventually, the goal
is to introduce different backends.

But regardless of that, ...

> In this sense, I'm partial to being brief for the most-common structure
> that will be passed around and then more descriptive about the smaller
> pieces:
> 
>  * 'struct raw_object_store' could be renamed to 'struct odb' to match
>    its use in all of the new odb_*() methods. This represents the
>    "object database abstraction" and consumers don't care if this is
>    one or many object directories in a trench coat.

    NB: I think having a long name here is nicer, even if it's
    abbreviated in the functions. But that's mostly my own preference, I
    don't care too much. I'll keep this as-is in the next iteration, but
    if you feel strongly I'm certainly happy to rename it to `struct
    odb`. Just give me a ping and I'll do so.

>  * 'struct object_directory' could be renamed to 'struct odb_shard' or
>    'struct odb_slice' or similar. I may even recommend 'odb_partition'
>    though that does imply some disjointness that is not guaranteed (an
>    object can exist in multiple parts).
> 
>  * In the event that we create multiple implementations for storing
>    objects, then a 'struct odb_shard' could point to a backend to help
>    find the appropriate methods for interacting with its storage.

... I have decided to rename this to `odb_alternate`. I don't think
"shard" works well, as shard is an extremely generic term that doesn't
really convey much meaning.

On the other hand, I think that `odb_alternate` is quite a good fit. We
already use it all over the place to mean almost exactly what we are
after here. And it doesn't seem far-fetched to have an
`odb_packed_alternate`, `odb_loose_alternate` and `odb_redis_alternate`
for different backends.

The only stretch is that the primary object directory is now the primary
alternate. I think that this is acceptable though'

>  * "alternate refs" are locked in as names based on the following
>    config key names:
> 
>    - core.alternateRefsCommand
>    - core.alternateRefsPrefix
> 
>    These user-facing names should not change. This may be valuable to
>    make sure that the 'odb_shard's still have a state of "I'm an
>    alternate" or "I'm the base read/write shard for this repo".

Agreed.

> >    - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.
> 
> These are carefully done. Thanks. I only have a few nitpicks here
> and there.
> 
> >    - Patches 13 to 17 adjust the name of remaining functions so that they
> >      can be clearly attributed to the ODB. I'm happy to kick these
> >      patches out of this series and resend them at a later point in case
> >      they create too much turmoil.
> 
> I like that these are present, especially because you included
> compatibility macros for in-flight topics.
> 
> I do mention that the rename of the object-store.[c|h] files may be
> unnecessary, or perhaps could be delayed until this series is merged
> and the collateral is calmed.
> 
> ---
> 
> This was clearly a lot of work to put together. Thanks for working
> hard to thoughtfully rename things while refactoring to reduce our
> dependence on global state.

Well. Frankly, the hard work is only just starting. Next step: push down
`struct packed_git` from `struct object_database` to `odb_alternate`.
I'm scared what I'll find there.

Patrick
