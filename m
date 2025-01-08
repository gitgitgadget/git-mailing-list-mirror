Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A051A2396
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319107; cv=none; b=esRja+OKYLdvJSg3i2k4kveN4MiHD/cVDslt9ZBFa6dcnS9f1FNzDViJNb6I9EhBwVEeMdG69e7Ol8uEpU2cbiSU94Eay83nFHgnfn70s/XcGsPsuh52JDmUmiCYzq6y+YRwqFZ4Sw6n1Eoma9wdrZbTmJoTXOHIIuLsXQpH0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319107; c=relaxed/simple;
	bh=gukt6EXJUboHHJ3AHihpErJw3zZ5w4NRcV8gn1WkasU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI8njfERVqZtzTPZv/O9+gmpltP80DS/mCkw+Jyx90HXtoEyUmyEjkIYqqMIfb9TdsF3o7QXLrDLy5Pck8ed3kBcFmnt3HlYpG+ohC9OwqPpxg3GB7ge4zJ2GwqH/vlw23/QXoqsXMZuaVYxqvzhYUnW/NFl+eVBfu0stW/gziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sTeSwO+o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBOX70IC; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sTeSwO+o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBOX70IC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E8A89114010C;
	Wed,  8 Jan 2025 01:51:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jan 2025 01:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736319104; x=1736405504; bh=qI2t1Yqxqg
	3x04D4BKP3EAFVQaXu7zwbqT+nJQn70pA=; b=sTeSwO+o/cc54Y1LLA0LjIIfRw
	pannsVyZ1aq7eFlXXYMZlbHoVl6zqLIs2uqOAkTOOV2nVO7IX4u5zCv8Go6xQ6ws
	fAqeFszaeygM4WlNQuqYf0NuZpJ6G4FdWTNeBJiYsD3cGVc8ajluxqopxBED+2tG
	bvFOHl8BJGYwGF3iSoL8zcyWCaFUzU+HQddjLISx/U+W+1S3M+HozzQZdkObvlHH
	qUFg7+uOwm1zwsbjECLvF4QfDqcUMzzGGXp3JMJi4NcBdRgFZh3S3nVUAZreDym1
	7QY2bbn3yMQcI93rY5kGB1r+vRiqMLoP3hzaAcjg3LfWfDl/9umFIthJt9lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736319104; x=1736405504; bh=qI2t1Yqxqg3x04D4BKP3EAFVQaXu7zwbqT+
	nJQn70pA=; b=hBOX70ICGPT57Jbg5YU8FgmfqC6jqpX1eUQFmlFk0gYUuTUoPrY
	5oD0AP9O0mlAUxmxVOO1wcr+wDabfug8vcu/Fdw0j17ZxzP8HGIkFsJsy7kbGInC
	6AXo8wy3pQeJwjZ7fO0NpM6nyhD6H/gOSXk4iKdhVHOW9hhTgajLWMWdbcJhzSmG
	oUE8I81Fbx8ektf9x0UMMa9lF2Ly9mmCvMDUwE/T0uF64gq7JYgNjkKtvkt2BUx3
	Uy+Onl5JKVj8SXJEz0nIk39sVAMOi95DQVNigysHII5L692sDNiz8jXGpqxh8l32
	4tdMbx3lggg46sJ2Ke4uF5tfEuQ5fMvgnXQ==
X-ME-Sender: <xms:gCB-Z40Wuw9M8st4hSbWEfkBoVChBWLk3x3Drjj7AIv7gLmLyyh9aQ>
    <xme:gCB-ZzFk3SDMKIdjCa0Tz4KySQK_Db25vjUN6ezD5GCTq18yOTFTvwDk0y1FwZZzP
    m_GCHZRYpVrfzUMsQ>
X-ME-Received: <xmr:gCB-Zw4H1LjGhgHbPqIWcX9xc16zEhC8ROTI1mMTSEw9yq2KTzg7tVj9vsY9gnJc2VOhXxCG6DSPkemZqlnoFhhsLsYWKpK3baNMr3ZYn_TlQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrih
    gughgvrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gCB-Zx0BaRra6WbI19ejOX36Jx4K3f7LdMYWGzDuCqJQaI6byU5m_Q>
    <xmx:gCB-Z7FLtf6bYaq6jhs2pEMiom15oinvKx26KrhMKx1-8-qhY7ljEg>
    <xmx:gCB-Z6_cRBsV27NqqM90zLG68wblABi9y6jh_c2uDtEvdcijf199Qw>
    <xmx:gCB-ZwnCiCDG0T5YAILlLkp3W73cGCFTYbknwwQ8jO-mwpXTFLbOqg>
    <xmx:gCB-ZzCJ5MQ6ekON2hzoZsDSwLqYr1sDLuACt7uS0Gn7s2WTWlgzN2Bv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 01:51:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd5eb221 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 06:51:41 +0000 (UTC)
Date: Wed, 8 Jan 2025 07:51:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
Message-ID: <Z34gfa-_dSbWD19h@pks.im>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
 <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
 <xmqqzfk2qr62.fsf@gitster.g>
 <xmqqv7uqqqu9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7uqqqu9.fsf@gitster.g>

On Tue, Jan 07, 2025 at 01:03:26PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Yet a platform replaces it with a function that returns an error or
> > aborts?  What kind of nonsense is that?  Do we really need to cater
> > to such an insanity?
> >
> > Use of git_rand() here goes backwards against the more recent trend
> > in reftable/ directory to wean the code off of the rest of Git by
> > getting rid of unnecessary dependency, doesn't it?

It certainly does, yes, but unifying those two callsites to do the same
is also something I do in a patch series that gets rid of the last deps
on the Git codebase. This then allows me to move `git_rand()` into
"reftable/system.h" and make it a shim provided by the respective code
base that it's part of. So it's not a step backwards.

> > I think [PATCH 1/2] makes sense regardless, though.  But shouldn't
> > we be pushing back this step, with "fix your rand(3)"?
> >
> > Thanks.
> 
> Ah, I misread the patch.  It has two hunks, and what I said applies
> to the earlier one, but the later one is already contaminated with
> git_rand(), and that is what is failing, i.e. it is not a nonsense
> platform replacing rand() with something that can fail.
> 
> It may still make sense to drop the first hunk, and consider how to
> proceed when you further want to reduce the unnecessary dependencies
> for external users of the reftable library, though.  Are there
> correctness implications if git_rand() in format_name() yields non
> random results (like, always using "rnd = 0" instead of calling
> git_rand())?  I seriously hope not.  And if there is no correctness
> implications, perhaps we can replace it with rand() or even constant
> "0"?

No, there aren't any implications on correctness in that case. Sure, the
randomized delays not being randomized can lead to more contention. But
even when the randomized suffix for tables is deterministic we wouldn't
have an issue as the files are still distinguished by their update
indices.

Patrick
