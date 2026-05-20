Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E48C1F
	for <git@vger.kernel.org>; Wed, 20 May 2026 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235441; cv=none; b=EYPxCR71OGLBdo+OCczI+D3k43CYpOYiA5DARZ18YrWVSEGB6xHb8+VV/jssIXUhqU4nSifRc3W7t6+MjSRiZMqfelavjJ3hRRo4LCs6q89/Htavy8rYEV4z1Zn+L+qU/eO14o99JAcFuqKU42Eg6plMwoVtKtvXmctAvoTY+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235441; c=relaxed/simple;
	bh=ZmJoGGioFkGE8w9robAO8/9IA5jD/0doLakJ5ANz01g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R3zlGYvYAlgvL/Q2UE7AEI4bzgC9R+6o9Q32OCy/sE4a+5X+5Za3C4GZCxmN2PTFmvcYBaQVrAxxcMRA5IspXtja7aL4lLA64N763GMVqW+fYD8Jlxpn8dhmOAX6Uga0pikIIvS/RKsPCf3UpdahrZj86HN4DCWGC8NowvyFXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p3SSCub4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJ6bLF7Y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p3SSCub4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJ6bLF7Y"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 79FD51D00117;
	Tue, 19 May 2026 20:03:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 20:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779235438; x=1779321838; bh=nqBHbpiYSN
	MmSgcy6VhN+EC/CfznCokiToZxZIlYLxo=; b=p3SSCub4X5bNejBLx4VSjX6cw7
	pduyPYHBKXAT7lV3tGl4zYxt5KqAKU9UrWSjtODKKKysuG/xLJTFPb+kOgtQqGqm
	a9lOV3qilTqkh4zIozhd3ohmHqK8IzgVcO88pD++cl3PIezpgjZld8lBaPzIwJIf
	HZ0Z4fXxCgZbTiMYEXqxTqqv86mKr3GZLQDiefelHo9VeVW2WO0ACxaaPzFKDFNu
	A/KRWMgFblS4fudCxFdGrDm0U+iv7aSELZuUU0rZ8BRvYJXF28lxgkGFh+vJhkxJ
	LNhcU+FfUgI5HFjwMt2mcQb1skVfuK2wHOFGEWXMg1Rq4Uw0kkETJXYHy4Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779235438; x=1779321838; bh=nqBHbpiYSNMmSgcy6VhN+EC/CfznCokiToZ
	xZIlYLxo=; b=CJ6bLF7YYki1oKpWfp0it+bXPqJTukw1EQEWMbcgvj62n+0h/s7
	CjBFthq8n+olyGyljm0XycEkz3GoHabnvHcnahKNRITu4E/qh5HPW5F2BjdYBc+5
	5zl4uYB3TClaq7yntOuN5PWIhp0z3w9se5Den/geuVUb4FXHqmxwXFwPiTnjTgy9
	7zW3zBO2jBjXaYD+rv4/rD4XNOX3efsr9i6qRviOmZoGLTcBX8S+i6RM+54ZzYDM
	CghbxRjCsb/I8bWyAOP/oUvyfOnVhJ+Cr0xN9l2I5Dc+WH+06HjcHMd8Y+PbeYQm
	YC3RDZbzC0ov6TMgOLbbEqLwrufiSHaiFEQ==
X-ME-Sender: <xms:bvoMaq32oAgzn_u9xOOq-9kDEIlx6oOTQGIj3-DjasOgwGjxpITUbg>
    <xme:bvoMavV5crZeSY1r1g-UbjQnSvrAJQnuh21FflgJVkhbsUIjRHIB6v8ZqgYe2tjNF
    2upR0jR442fNmF_OPu1Ez1SM0SAz4T8TDsF_Iph3CgjgKppVydxOQ>
X-ME-Received: <xmr:bvoMalLnb1fx5iQct5kVByPe-Py8Vcj8XatRJNO3duILPHGmwL9BJmXRfIVmklvLO9-oLOpmoXYlOO7JfidsIrDPQ1MS221I1MfKm8cFSYSq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhdrrhgrmhgrnhdrphgrnhhtsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bvoMah2YwK4rEC6nP0k5CP6gjmHSufxul-YBzAearO5rMvzqHm3N5w>
    <xmx:bvoMar6mGxl_2Gw_SlBFtiQiy3N9OkwrHihbeHgZw62Pm7dfJb8CSw>
    <xmx:bvoMaq8SClbRViWmKFgwFe6LslWL3i4iEVPEwfPzsdfOqYsW9CjAUw>
    <xmx:bvoMaiWKQR5G3URwDw1O7i41ZtbOnBIpyYaR1iaCB79a1fAL5BceJw>
    <xmx:bvoMauG8yFTnth9B2NWxC5pkgGHmTiTFqRNWIMwBRUyIPgrCzSi65NfZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 20:03:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 7/9] notes: support an external command to display notes
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
	<9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
Date: Wed, 20 May 2026 09:03:54 +0900
In-Reply-To: <9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
	(Siddh Raman Pant's message of "Tue, 19 May 2026 22:00:36 +0530")
Message-ID: <87fr3nq74l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:

> This problem excaberates on scale.
>
> One solution to this is a realtime fetch or faster updation via
> external means, but unfortunately we lose the coherence in the
> display of information, and the user would end up reinventing
> git log.
>
> So let's add support for an external command to display the notes.

It is unclear how we would arrive at "So let's" from the previous
paragraph.  It is not limited to notes but multiple people updating
the same thing racing against each other happens all the time in the
main part of the history, no?  Isn't a better solution for such
racing situation usually based on a better merge support, I have to
wonder?

> We split the addition of documentation and tests from this commit for
> easier review. The new help text added in Documentation/ in the next
> commit should make the usage clear.

It is unclear why a large body of code that is not documented or
whose uses are not illustrated by examples found in the test scripts
is easier to review, though.
