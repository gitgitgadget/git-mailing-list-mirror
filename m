Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA401F4706
	for <git@vger.kernel.org>; Wed, 14 May 2025 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197108; cv=none; b=JzsKBP4hURSX75Flx4sFUnlXVPTHBR4cKfIN00cA34QiUNPDg6oGG9rXmP8uWvdECo+Ym71PbQp2zYXbVNyhGzLcWdxfrPd+wJHT0sGmhNgmqMVNPqDWl9ACOvUVvqt93KDROKNkPfdWhxv4KDy6kZC08NFNDtV8t11PydLorng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197108; c=relaxed/simple;
	bh=iV7BGzQv1OWjfWf+V3Xoc+9zB7nWUi/KmhnRBECCRAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIQdjyyptnWghg/IM98COWPNM54XmE/piDei3zPubaNFdQfnCHgrhbb2E6WVKSAtC8o7w8Hlu0VavIGEui6JUc5pdprsf0+UFXnzVr1fbsJo3npDUSRO+WHLIqFnjzzN/Bpg0pZFviMmjUZvMVaBCMF9zFYMItLgvwS0IQ3YxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=izMlYKaB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8IwSH03; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="izMlYKaB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8IwSH03"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BC443138013C;
	Wed, 14 May 2025 00:31:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 May 2025 00:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747197105; x=1747283505; bh=bUM1Oj2x5p
	NNxGou1GZpMwHER4jaUY7Ga/X/buXNHmQ=; b=izMlYKaByJtrIO+1tQI0WZwy6p
	AwmNCFO0DM2PvZcotVl5EjJ4lGgShrwGM2NDsdWp89pTB+dV3Ccsraz+TUqP0OXt
	V6tZPGJJOHRlgDjdw9G7Gfnu5VHrRzca9JMwBNVOMw3WXCp4LF/Brxl9YeA5ACoa
	DddB7yoNqC6zvF5hxdIWosEW4yyjwd4Hbelb96nvZ2jMDNkB/k9tNb8bcU08J2y7
	gdP6vhPnWDevqrEs9bPY90f5poviDXFih4t7ZHuDdOcEQYDWNv4aGIvad8mjm+T+
	inBScfzH/3ZpYDKDUoaWAFDsRWfbqTiBx0VQcj0i5GKKcw5SIkpaUsoinKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747197105; x=1747283505; bh=bUM1Oj2x5pNNxGou1GZpMwHER4jaUY7Ga/X
	/buXNHmQ=; b=a8IwSH03y0P4oNO5Xar/xH8PDtbF41mMMSJMv5PZb7z3ubtIoy1
	tYO70ANp8EwD9vUCnxwqAV9iSJKQwrw8c9HxbgQuGYJubEmZR1I/xWkLrhPpbTQy
	lZqQvk42sMkM+Z3szyZy+RkmhLTtRqgsFGEnYtnKnmy/GFAGMh9iDEPS65MW/PWM
	IdVt+v7Cu+MMFW2jYtbhAkuVUZTSoU1y3ixs5EoF0B0mxzYhhtgPypPFYeyNj/yJ
	C0wHop9ORhw7pG9tO7lW9738eYHd4LrPgbftQyvNcAld9KJ3sIwxejMNk5ZY/Cn6
	VNLZpQbpoO8kW1hVvaMIr38mWFuG/UJtdog==
X-ME-Sender: <xms:sRwkaDmhAFgs_sENpGp3xrEzAHNkxAjBlyQHYCt1Wt710NfrwqLPOw>
    <xme:sRwkaG33n19ibiD4ktAgsYGM0JccaG4rnKUMpz5f0DEUpBH64x7CSGcPhKoyT6uQ1
    Rm06C26UztoVqEe0g>
X-ME-Received: <xmr:sRwkaJqfRAUdDCqnc2xOSTcw9LwFIrQF9lbx_mU7sbJ7bJPR9wSy6fLE30Snuzsn5mizo1KKMIBKym8nitlat5FbUiLeLC888C21dDV_4H0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeitdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hm
X-ME-Proxy: <xmx:sRwkaLm8d9h-4SUpt7FUKuUzsZaUjUXunpqvCq7MtVt72B_hySj5Bw>
    <xmx:sRwkaB1VWWP0L_wO3JovuawQ2m_CMb7XiJRqg8WNUTg6ErZYgcLsUg>
    <xmx:sRwkaKvnI63iQlLxYMB8_xTYeNN2wj5aHZWGw8-D0RzfYbJwob4jEA>
    <xmx:sRwkaFXXrkjsv6eWFP08yIzGcJ6Fte6Pol3lU7Tz_qdWAOWDYafTaw>
    <xmx:sRwkaMZJe8qtn8BKa5xpU4gPAsRbjUbbr-Qh5OOGT6vVNEFV4ugw-jOT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 00:31:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4a2c83e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 04:31:44 +0000 (UTC)
Date: Wed, 14 May 2025 06:31:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/17] object-store: rename files to "odb.{c,h}"
Message-ID: <aCQcrmAxMhN8WLL3@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
 <20250509-pks-object-store-wo-the-repository-v2-3-103f59bf8e28@pks.im>
 <878qn0jonh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qn0jonh.fsf@iotcl.com>

On Tue, May 13, 2025 at 09:28:50PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In the preceding commits we have renamed the structures contained in
> > "object-store.h" to `struct object_database` and `struct odb_backend`.
> > As such, the code files "object-store.{c,h}" are confusingly named now.
> > Rename them to "odb.{c,h}" accordingly.
> 
> Do we have plans to extract the object database subsystem into a
> subdirectory? With us adding multiple backends in the future, I can
> image us having a dozen files at some point. So since we're renaming,
> shall we prepare for that at once? Or will `odb.h` always be the root-level
> entry point for the object database, and only live backends live in
> `odb/` for example?

Yes, my plan was to create "odb/alternate.h" in one of the next steps
and then also host alternative formats in that directory, similar to how
we do it with the "refs/" subsystem. But "odb.{c,h}" are files that I
rather want to keep in the root directory, similar again to "refs.h".
Most users shouldn't even need to be aware of anything in "odb/" and
should only need to use "odb.h", so everything in that subdirectory can
be considered as low-level implementation details.

Patrick
