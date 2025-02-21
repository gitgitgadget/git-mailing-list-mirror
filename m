Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF981DC9B0
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158971; cv=none; b=NrC9YBQC0HbZWpcpra8spPjvBEio1xnsLLFn0Q5cj5cts1J8D9pjrCsc5UCmgg9KnVrvhaCd9aXwygY1BdP++wparxD/VlqxoCPlK8Fd29kIV1iS+AthqiWj8HOC/GvBfBB514pBDKOSebhg8hk68I3ea5JkkmDcwu6iM+rSuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158971; c=relaxed/simple;
	bh=VgtsbzgZrDGto/frf0v+p0uRgtRdvP/NpFc9NXIA8GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jsxu2hVBocYtu7H5H8bJT21IphBsnZnVq4gONOQGVeJtgJ/BRhhQpibTn1lDZ6DMqE9+l03+KsJuaM/jJDDBXD9JT9zOaIni4nQKXY0VuYul6EgeIP6Gnn1dowUrCnm2ZfAFAvy7qa5HSErOB9yOGHK1MsmDnVxQmUb/OhiGwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4Tw72W0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+pRKU7C; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4Tw72W0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+pRKU7C"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1FDD254016A;
	Fri, 21 Feb 2025 12:29:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 21 Feb 2025 12:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740158967;
	 x=1740245367; bh=UG6A9f5TdPwgWI/Xl1VeUr0M3RAtdgelGaEFDpBTLzs=; b=
	X4Tw72W00hBo3zh4rqAmVuvTM2ljJ9YZMjXClbVeK+pdvpKfUR73D9czcWjo8cSd
	rZvIVBejo/PjId7ykJ8980i9HOWkT2fT+o2pS3ySvh7WqsjgeYvDZVglf7BdsECu
	k7Wad88BfZ+c2JYOpJSstCSTQPYwFhSeFSLNPzCpWQoy2hqXrDWzbFzOiBfF6acm
	G1UfFVeKDRXkfhVnttNOO91rbLTjuJPU26YAkvItjG713Dm6yUSpEdzt3Y+Q3tpp
	qQO23hguI64j7d+T+tvcTTwFHxXR1lBVms3EZLjvg2F4MFYXtIv7rDZ3s0KqfV8P
	M409+YZDPyRdAzk8BG929Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740158967; x=
	1740245367; bh=UG6A9f5TdPwgWI/Xl1VeUr0M3RAtdgelGaEFDpBTLzs=; b=c
	+pRKU7C7N+QGMwmnJtxMIeRbyauZnKQMaSOUPl4X3hLXMcx4QRiPA2lPqN4ZfOeW
	zCiWOd+4I0vnOq2Ir9qBDDM3m8iA1T07rePX8tncYk5OhUl8BKJ5My5JO+koNeGX
	Y+B8n1ieB1cPXLteA7mUZ9iq90vemvk7QBy3r/3AzQYcNxg+aOfbNp7rpvRrE0ax
	zrvWySJlpk0Ik5rzojq+Zqkhe7fpklEum6VsfGECMNmpRsi2lXB5eZCewzMKBKOg
	hPoBvkLTBL3D6b47UdSJjNlrpmZlzAp7jT3DhqkHUFrOwJWdVm/76EqmNRwYamkC
	x0c7MUEpLsf7eqp+klMgg==
X-ME-Sender: <xms:97e4Z-l6CRpmmpYOoKWZMFYkWyERL-8HRKr9tzH2q5MBMsisMuRjTQ>
    <xme:97e4Z13HOD8M35arbVEexhII36RmBB7VLTPDWSFjFvmk_wQDVuw1oI19RphWlX-d1
    A3LaGFy8_BfX4_YHA>
X-ME-Received: <xmr:97e4Z8rIZlWkok2zuNs3-DJyNMXUl5lbDPVHPxMf9439KqB2QPO3-teR0rVYlZXNceQqugyMDVbEHMf5O_EIX5ZmoLgFqkcezvpsf88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdrkhhlvghinh
    gvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:97e4ZylmREA0LNYKcrNsQmRTpF1eZ01bm9REQHvu9xc78DnmE8RH8Q>
    <xmx:97e4Z80Z-Mgc4_RS5Gwlkp7Tl7nSpfg9-g88hk99J2U3uXGCFLHR9A>
    <xmx:97e4Z5vGs4ieP7b-v005LoldfslOwbpT4zKvg-uoOiQ0rTs2EwdmpA>
    <xmx:97e4Z4VjfKxA3gRO4RTQPk7GfrlAn0JtsbPgz79CZnvkuz6nGVWuOQ>
    <xmx:97e4Zw9PqCrCUUqbHbv99t4tAJ5BpTAH7i9cGFoDdm5oT-jsM_ydcsKw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 12:29:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: first bisection step takes quite a while
In-Reply-To: <4hx5uvjy7mzntb5zp6o4dg3ut44i46bthyfuera3lnbpbcvrey@kbo3ejype7ae>
	("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Fri, 21 Feb 2025
 10:28:24 +0100")
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
	<CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
	<xmqqikp4ctoh.fsf@gitster.g> <xmqqa5agcbx6.fsf@gitster.g>
	<4hx5uvjy7mzntb5zp6o4dg3ut44i46bthyfuera3lnbpbcvrey@kbo3ejype7ae>
Date: Fri, 21 Feb 2025 09:29:25 -0800
Message-ID: <xmqqo6yvb40a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Uwe Kleine-König <u.kleine-koenig@baylibre.com> writes:

> Hello Junio,
>
> On Thu, Feb 20, 2025 at 05:40:53PM -0800, Junio C Hamano wrote:
>> Comments?
>
> It's long time ago that I looked into the git source code and I guess
> many things have changed since then.

;-)  Apparently not much has changed around this area.  I was amazed
how things haven't changed around the code since I wrote it in 2007
with "the clever trick" to improve what Linus called "truly stupid"
algorithm.  No, I didn't improve the stupid algorithm.  The clever
trick was to reduce the need to call it.

> Anyhow, here comes my thought about how finding a bisection point could
> work.
>
> Pick the middle commit of `git rev-list --topo-order $bad ^$allgood`.
> Lets assume this are 10000 commits. Check the weight of commit[5000].
> Depending on how much the weight is off from 5000 make a bigger or a
> smaller step up or down to find the next commit to check. So a scaled
> bisection on the topo-order commit list. I think that doesn't
> necessarily finds a best bisection point, but I havn't thought about
> that a lot.

Since the name of the game is to find "a" good enough point in the
earlier part of a huge bisection session, that certainly is good way
to think about the problem space.  The commit[] array you have may
not be a linear single-strand-of-pearls history, and a naïve
bisection would not work well in such a case, so we have to be a bit
more careful here.

The code I touched in the illustration needs to either find a merge
commit that is really good enough and leave early, or if there is no
such merge commit, compute how many other commits in the range each
and every merge commit in the range that can be the ancestor of 
the best non-merge commit on a single-strand-of-pearls history.

Thanks.

