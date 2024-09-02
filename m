Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B620124A
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284500; cv=none; b=EeshmmG9mcc1U1ox1NkYBr/qOkbYRHDxtUz+diYmNxMWTFRg+7ynC3/A/oapCohuaugf8HqZcw4ZoIkWKD0Zg1GyxXAYW51vQq+quU4M4K9MRjtQtTr+WwmmNC79feo+HWYyvOYP0FQxHXQX62TJDM0jGQjRrtJJDnORV4rOYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284500; c=relaxed/simple;
	bh=elWLTZQGxU7YOmhYaNV7rdy1SQWDbThOBIY3P/yyAR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxDzCJbPmgEw2FPUkNpB45FnnrR2lMplvC3kEGDYflTY+hYluHynWkXYHGtVMgC8wi2ogF22xe0HeCeBMdoM0cdcyZXjx5CH2t+sZCSnYSLq9HmNnKBmhV4STf70oXf201iI9ggFBrb9WVDarHb9/ERawBIxLtvv6bx3+jMi+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TmmCYIO0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7fbAZg4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TmmCYIO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7fbAZg4"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B8067138015C;
	Mon,  2 Sep 2024 09:41:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Sep 2024 09:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725284497; x=1725370897; bh=+xgKUR039D
	Sx63B3TQC+5tF50aMhDb6X4lj4doyllWA=; b=TmmCYIO0M+9Cbde3Zy2nDPwXbJ
	fLH82qxXfsayKjv2eQ8rR2sNOBZCPeNlmbGY0Qofb40/dej8tSDEaumgO7638gRN
	iWlGpHd0Mxggx6DJINEkeDyHARXJgZDhZCMK63g3/XLZjjM1ZP/7EJEY66e7oawb
	nqpIpIon3V/ZGOtiOXygYN2PnIrMTfTclrGF5mMtLVFqg9hMRdlQGS9R6IES/NRL
	Z886hctZGJ8Q1W5cXa+ZTUdAydlpbepUdt+BjK0h5/Gaa1W2NITR0xSYJPP6+4sz
	O6EctFalXsVZWgl8ofzyH5fKzbjOFzJL8ki/3iTlda9ZCuAIaINatDYZznuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725284497; x=1725370897; bh=+xgKUR039DSx63B3TQC+5tF50aMh
	Db6X4lj4doyllWA=; b=g7fbAZg4lwq6maPpZfI+zsgdpoLMEf7l8YQ1h30GyuKM
	cEx7fmXI2vkG4vpu8EcbEPB4/gkoTh/hTX/UOzeMRUy/8+X3iCcYJKJz+Wz31598
	7NgppCNAQITvKjV/rgwuXVQ+HA22ETbG8kfaoFrVKNGvNJ1XaBNStAHr4p2fF1WI
	i+jcVb45hu7QKo+f6zDThZUJUeVa6wWG1sd92YHObS7iJWZRb1uNMIb6QedT8Mmu
	nVEebOd4X470S/4C7AP2qYVXBzGzjiK9VtArVl0uZ2pYVwuzfLDe3A3SucXA5hjh
	OezsUrftBf9RnTN1IaBDEdnvMvj5ZkJFxi02ULzQ7Q==
X-ME-Sender: <xms:kcDVZopvU78TNUdzZjbSICDSr_EdAur4J5ELT1s9vxSK0XJfU7CGhQ>
    <xme:kcDVZuqV6jOfrPf3njKev52gOn0a9vtRyqULFwCjy8dVM5JQhyWJMu32UMOm_IlsB
    uJiuPi3fQIqFI4Mgw>
X-ME-Received: <xmr:kcDVZtNoqvSl7CN0PkOi1lJUJBardkyDdFd76f0NM4pGwrBJJwGXgaNB8cW9GvqUD8GUDFjbcuXpzPQu2T1pvzoYXAGv-eQL3E_Ul7d49YqwFA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:kcDVZv6fIyhmCOvOR9_Y2mtVe-taHubmID36KT05hum1H2_154Zx2A>
    <xmx:kcDVZn4XVReZMtoy62J6r1PEP4h-il1MWWUB68W1tHyOHRimvMfnyw>
    <xmx:kcDVZvjQZM-jS5nZL6MWfFyui01cK7vT-mzfOA7p4qIK5JqMKGQzIA>
    <xmx:kcDVZh5b6QgAF-NsfP3-oQfAsQ3hqNbhe_TVjaIc_CTWe6cIAa-jMA>
    <xmx:kcDVZkvLAzHTCILkv2-viKyeO9OUcP2MHMTT898L0G8Nm5aSeskXW2nY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 09:41:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8097abea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:41:31 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:41:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] csum-file.c: use fast SHA-1 implementation when
 available
Message-ID: <ZtXAi9KYOKejJmOS@tanuki>
References: <cover.1725206584.git.me@ttaylorr.com>
 <e8f5cbd280cc07f68014bd4024d55a740374b349.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f5cbd280cc07f68014bd4024d55a740374b349.1725206584.git.me@ttaylorr.com>

On Sun, Sep 01, 2024 at 12:03:32PM -0400, Taylor Blau wrote:
> Update hashwrite() and friends to use the fast_-variants of hashing
> functions, calling for e.g., "the_hash_algo->fast_update_fn()" instead
> of "the_hash_algo->update_fn()".
> 
> These callers only use the_hash_algo to produce a checksum, which we
> depend on for data integrity, but not for cryptographic purposes, so
> these callers are safe to use the fast (and potentially non-collision
> detecting) SHA-1 implementation.
> 
> To time this, I took a freshly packed copy of linux.git, and ran the
> following with and without the OPENSSL_SHA1_FAST=1 build-knob. Both
> versions were compiled with -O3:
> 
>     $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in
>     $ valgrind --tool=callgrind ~/src/git/git-pack-objects \
>         --revs --stdout --all-progress --use-bitmap-index <in >/dev/null
> 
> Without OPENSSL_SHA1_FAST=1 (that is, using the collision-detecting
> SHA-1 implementation for both cryptographic and non-cryptographic
> purposes), we spend a significant amount of our instruction count in
> hashwrite():
> 
>     $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
>     159,998,868,413 (79.42%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
> 
> , and the resulting "clone" takes 19.219 seconds of wall clock time,
> 18.94 seconds of user time and 0.28 seconds of system time.
> 
> Compiling with OPENSSL_SHA1_FAST=1, we spend ~60% fewer instructions in
> hashwrite():
> 
>     $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
>      59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
> 
> , and generate the resulting "clone" much faster, in only 11.597 seconds
> of wall time, 11.37 seconds of user time, and 0.23 seconds of system
> time, for a ~40% speed-up.

Neat. I knew that SHA1DC was slower, but I certainly didn't expect it to
make such a huge difference.

I of course wish that we just moved on and switched the default to
SHA256, which should provide similar speedups. But that of course
wouldn't help all the projects out there that will use SHA1 for the next
couple decades.

One thing I'm missing is an analysis of users of "csum-file.c" so that
we can assess whether it is safe to switch over this subsystem to use
the fast variant. As far as I can see it's used for packfiles, commit
graphs, the index, packfile reverse indices, MIDXs. None of them strike
me as particularly critical, also because almost all of them would be
created locally by the user anyway.

The only exception are of course packfiles, which get generated by the
remote. Is it possible to generate packfiles with colliding trailer
hashes? And if so, how would the client behave if it was served a
packfile with such a collision?

Patrick
