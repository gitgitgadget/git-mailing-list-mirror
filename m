Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6A16DC01
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683047; cv=none; b=m3j3NpU43msJn/fZ7Q/kboOKdYWRXObZH9xJG5wPC2pXIQ+y8w0E0DLE3LNcgXYXL/BPZC7zOmvdqwLg0rnpIE93EVakiXrg1vxDkMWtJNmnGJ3qxv3isMIdKOP8hQGMvPlAzTm2rlM3j2J1jAEthqJkZVQBVwiCUnq8nlvdFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683047; c=relaxed/simple;
	bh=QGhWo/h2KSFBD8L+4DMFMUHawrggMKIQXpq3FS23LFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPE5Bs5mJ5MCwlRx84u35FCHfCw3tn0uKt+qpQEqQuxxrHcBGXrau4r8jIUhayftAeNqJnoQM+6Z3iqkmimNcJiM4X4J1R2kIm4a8ANQEz86Ec5Hi7pKqG/lQoyemvk1xxFU+Rxxor6gK372g5SgGFALAy/Ugf/1FqsCxwJ9k6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RCJJj7mR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aR0OAiCM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RCJJj7mR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aR0OAiCM"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BDA51380439;
	Mon, 30 Sep 2024 03:57:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 03:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683045; x=1727769445; bh=bvC14T8wWp
	WGXPRCnD8WUi1FEx7mLAKikYLNVxicLtE=; b=RCJJj7mRMjbQpZD96HBeWWbxrV
	zzclfAQ91euflDO7trCuH/p6Tr2QPkuF5BLjZsv+fUBE788V8BzVamAjBAvfJiNL
	qNgrTPVs4U0Y4eO8a4c9TPySThFLDaDqaPe3/ZvwOXrxw/rEihoR+hgo4+sWfsw8
	0U5u0n5Qgs08Stig1uZ6Zqpuzev8aCQRbQANzLqXd3eHUV8whIllGYJ+MAGuxEcS
	PXfW3DI2Pu+Z+2BItpa+fhBf6lIb7vdbaAAACUhVqcAoe8ouaBuTFmZbLa1W0HM/
	UVuhptn+4iY7qNAaAOnFix+cRf2+/dhLEr/oT4Dc69DJb0A3ciPTB6x20Sag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683045; x=1727769445; bh=bvC14T8wWpWGXPRCnD8WUi1FEx7m
	LAKikYLNVxicLtE=; b=aR0OAiCMQD4aoq3biaq4e0pSaARu/k6f9pWjcbygTpT7
	G2Icnk4k0DhRhUEd2GsTymiLnl055pR2ZbW9csHoROOrpCHHTzbickUt2f4+hKFq
	NLMEMgJ+3blyi7ZmqqD2HphD3v9UFg656GOjvj6/N3wwk7HhbxG5Fi28RwjSpMs/
	YxzbVoBJ+SmDh3KBLI+90pzsg7IM3wZ4F0fZzOdLM1Rza3ALgj6gsMkTyZOh73RD
	wKI4X/2uWFAGLymIj4TJnIeirpukkxx3BrAaTJ+5P+E8R5WE3I+HYRCb8WKiEPpK
	SBHfQzF7lqSq4hUkomA89Xm9cK1Wos7yc9pQC3qKdg==
X-ME-Sender: <xms:5Fn6Zl8iKBtTVfcMuAlDIL488BcNPhmR-vuQho-owo2b5goru7kwEQ>
    <xme:5Fn6ZpsYgvhDHmUETo7Hljis7K3ZCkd8SczKN1fVPxaE3a77CNy3X4Hpoe6UX6IBn
    tIxfsQ1MPcPc-p68A>
X-ME-Received: <xmr:5Fn6ZjAUxMFNGQxAeXxZkEM5qV7HRA9q5JoGWYuCSn3mJLE6JUSKaaex3L1Z95pb1BdAFriRiXLBWFTSKf26FeTmvGfhZ8il5f7B4ChXas76wCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeegkeeiieefheeiueffvefghfejtdektddvgeeltefg
    vedvtddtieeuffefteffveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtqd
    hlfhhsrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:5Fn6Zpckwyuwt9JG0ZVOkWN33OzJEWVYT1m58DF_855qExuXultz-Q>
    <xmx:5Fn6ZqMCbt58apNlNHWREp2krLPtj31ogN50zzCLfq-z0BDcto6Jtg>
    <xmx:5Fn6ZrktYNTWe3A76YJNsacKzoI3E5nNCTFJ58rR5TVxpicul19BXA>
    <xmx:5Fn6Zks_Md2HAQ-6FgWN0r1MKvkJhJfiLzF31EldsAEM0coSiCkbVQ>
    <xmx:5Vn6ZrhoYBiyi50p7KhwKhh1lPAvd2X7O4-8ej2ju0QuR8ocLwlWq5Li>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 03:57:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id acc12e3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 07:56:37 +0000 (UTC)
Date: Mon, 30 Sep 2024 09:57:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
Message-ID: <ZvpZv_fed_su4w2-@pks.im>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <xmqqikuijni0.fsf@gitster.g>
 <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
 <xmqq34lkg1ck.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34lkg1ck.fsf@gitster.g>

On Fri, Sep 27, 2024 at 03:48:11PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> > By the way there was an unconference breakout session on day 2 of the
> > Git Merge called "Git LFS Can we do better?" where this was discussed
> > with a number of people. Scott Chacon took some notes:
> >
> > https://github.com/git/git-merge/blob/main/breakouts/git-lfs.md
> 
> Thanks for a link.
> 
> > It was in parallel with the Contributor Summit, so few contributors
> > participated in this session (maybe only Michael Haggerty, John Cai
> > and me). But the impression of GitLab people there, including me, was
> > that folks in general would be happy to have an alternative to Git LFS
> > based on this.
> 
> I am not sure what "based on this" is really about, though.
> 
> This series adds a feature to redirect requests to one server to
> another, but does it really have much to solve the problem LFS wants
> to solve?  I would imagine that you would want to be able to manage
> larger objects separately to avoid affecting the performance and
> convenience when handling smaller objects, and to serve these larger
> objects from a dedicated server.  You certainly can filter the
> larger blobs away with blob size filter, but when you really need
> these larger blobs, it is unclear how the new capability helps, as
> you cannot really tell what the criteria the serving side that gave
> you the "promisor-remote" capability wants you to use to sift your
> requests between the original server and the new promisor.  Wouldn't
> your requests _all_ be redirected to a single place, the promisor
> remote you learned via the capability?
> 
> Coming up with a better alternative to LFS is certainly good, and it
> is worthwhile addtion to the system.  I just do not see how the
> topic of this series helps further that goal.

I guess it helps to address part of the problem. I'm not sure whether my
understanding is aligned with Chris' intention, but I could certainly
see that at some point in time we start to advertise promisor remote
URLs that use different transport helpers to fetch objects. This would
allow hosting providers to offload objects to e.g. blob storage or
somesuch thing and the client would know how to fetch them.

But there are still a couple of pieces missing in the bigger puzzle:

  - How would a client know to omit certain objects? Right now it only
    knows that there are promisor remotes, but it doesn't know that it
    e.g. should omit every blob larger than X megabytes. The answer
    could of course be that the client should just know to do a partial
    clone by themselves.

  - Storing those large objects locally is still expensive. We had
    discussions in the past where such objects could be stored
    uncompressed to stop wasting compute here. At GitLab, we're thinking
    about the ability to use rolling hash functions to chunk such big
    objects into smaller parts to also allow for somewhat efficient
    deduplication. We're also thinking about how to make the overall ODB
    pluggable such that we can eventually make it more scalable in this
    context. But that's of course thinking into the future quite a bit.

  - Local repositories would likely want to prune large objects that
    have not been accessed for a while to eventually regain some storage
    space.

I think chipping away the problems one by one is fine. But it would be
nice to draw something like a "big picture" of where we eventually want
to end up at and how all the parts connect with each other to form a
viable native replacement for Git LFS.

Also Cc'ing brian, who likely has a thing or two to say about this :)

Patrick
