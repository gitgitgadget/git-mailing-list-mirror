Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3D18A6BA
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272908; cv=none; b=FLdFbbBgfItT86TU5X9rGuJuyi1MUAHYZJvo9b4aiRgIxU+80E69JQXTXqYZO2mYGlppRDihre6Je06DKGhRJ+FJmvmM3aIU8mTGz5E0oAidhIilKc8kmGPjk6aXk3SVhlD5N/6Bmu5QzTVvulpwZcjXQxjrcRPXT2+ZldtmA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272908; c=relaxed/simple;
	bh=SD9Sjh+87ykaLKtuXq9JcnutDUJ2T3HKzBznl26obkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZA+fB5rJq8NFN+uRqGKpVISeDmqKFJUbxpcDGj9QahTHVnh5w2oNSJxro0D00d0g7KUs0K1k+hNTaexh7/1+yq40ZI4rV6O3g8wMWjLdsFgSjezpBzzpokjhh2/Q8fuS809glbTMssoadAmSPN5Gsp5mavSn/1CGQorButqkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GgI66qyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=swmUOmu+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GgI66qyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="swmUOmu+"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67ABF25401E9;
	Thu,  6 Mar 2025 09:55:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 06 Mar 2025 09:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741272905; x=1741359305; bh=IEm0Hmcw78
	cz3p9ceEQ0Ws7mQ/gYHzz+OJE+F1TzOuU=; b=GgI66qyudVKMdXGCIJN17Asthc
	VeeKZqQzDhNerfGEa83jqsMOfKGHYykRtcgiwjr10lhytp/gom052hiXhqYugpYB
	aVwe9aWKXwvqBitXiL1q7P1Tw/9Hp8uqllrmsIp/wHzvc/QvuDIyfkneEQ8gTVQX
	Z4W/bIVlk3bFXXImQ3eo63UIWwHDTtuOsy1QDcWQxAVKI45vJLidRNdFdmsMOshp
	2J/D5RPStlF1VkoRzNBvz3ZU84iPlS9I8QlwQKGmpcb1CAcMA6q7HnLZgbYlHWg4
	F3n3Qn4nyBlOqUgAdprpO/Y6OsL42YaGhEh4ue7GtNYKmg5yyAWW8hA/ZVZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741272905; x=1741359305; bh=IEm0Hmcw78cz3p9ceEQ0Ws7mQ/gYHzz+OJE
	+F1TzOuU=; b=swmUOmu+NFrrQicejObsiPboL4qFuRaXV4mZWeDom/TbV2qD6Ag
	TlNvHMowuvS/47C4KQE32oQVWV5lQ013dWtbE6u1NbFVx6mfAs9vqiy5hrCYhS4D
	jaGCcPmDkdWKPnMYiwjBHXNJYO1k0kUhnMqX7hEBfVpfFcbdjWaqa3oG5Fo5cKam
	feT+Cu0r9r+rIp5c7V3HHZAZ/j+jy4cW+k/M16UNeEIxp5I3oEU/mX2mLUkjyPxd
	eDOIocLt05FbdOpYUz4He2g+zP8IbehlbzcZyooo2Occ4n/Qd1ZWx+myzbcjgKPT
	FTvAU3Xiue+BDNbujJ1P6M4NlbjQpbBz7AA==
X-ME-Sender: <xms:SbfJZ5IhtIGtpAUHa2aY5JYmN6sHlZCFqc6tzl2LUCz4DjqhgMPFow>
    <xme:SbfJZ1KTaebLZShAk2-ewGt9Cpb1tXQd3GOIoI-lL7jaQDOlUPQ8rSQdtpIpdp7IN
    ZBXPKmGApBUD4hCqA>
X-ME-Received: <xmr:SbfJZxu-R9iHD9jtEK0dxOVwd-5rJkDCKHi60fgy8Xu0yexK8yjkvukYOBbUouUskDOJ1rqJdHjbGOwfqPn5XikuFMf9X6MIKV4uQZ-ty4QKLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SbfJZ6afH3vsgp0wS2BUvaAfE02SqLcY8gh7UexSH55rYfhoa38_bw>
    <xmx:SbfJZwbiMTNPn7tD0DDn-rSP41uEgFcdkyDv3wvQmPy5_h0RBUfl1Q>
    <xmx:SbfJZ-A8va9V7Z0qUGewrM3yuYhbOr83_LQCwzq-wB-NqyAa1IIGgQ>
    <xmx:SbfJZ-a8Yanlgn-Pe8o-U3T46W5HdcZpBE_grUqrjBsM1_DnKWdc5A>
    <xmx:SbfJZ_npeLZMU9AUvJKZ__Oi6aVhhdDp0E-jXmvJclYMoc2DA9TtfhWX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 09:55:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5604411e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 14:55:03 +0000 (UTC)
Date: Thu, 6 Mar 2025 15:55:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/12] object: stop depending on `the_repository`
Message-ID: <Z8m3R0KvU2crX35c@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-2-c5dd43f2476e@pks.im>
 <CAOLa=ZQOoif7zFY30dF+SewKZw1Y8wTOq=npMpUzsJxtr_0mww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQOoif7zFY30dF+SewKZw1Y8wTOq=npMpUzsJxtr_0mww@mail.gmail.com>

On Thu, Mar 06, 2025 at 03:07:20AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/object.h b/object.h
> > index 17f32f1103e..0a5293e9911 100644
> > --- a/object.h
> > +++ b/object.h
> > @@ -336,7 +338,7 @@ void object_array_remove_duplicates(struct object_array *array);
> >   */
> >  void object_array_clear(struct object_array *array);
> >
> > -void clear_object_flags(unsigned flags);
> > +void clear_object_flags(struct repository *repo, unsigned flags);
> >
> 
> Could you explain the reasoning behind only renaming the first two
> functions with 'repo_'?

Hm, good callout, and I can't really explain it because it's rather
arbitrary. I'll drop the rename.

Patrick
