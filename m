Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F92DC333
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849586; cv=none; b=rXbPTow7M+liQ20eG49KXyBpfvjMo6/7QYynP64gJVWQBU7iVLW5H3ZfWUOnuRgz7wP1ThFLZOZJ9DZfH5mCBFRW0piGXPqsvk5yk+DZAqGeNpeCBMVDGeHlRr8DD+KjP9ZR/rspcNSy24oXT7+phFW3ETViP+wkDLfSdE5D22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849586; c=relaxed/simple;
	bh=SUJlNy/8BkE/BYgRhy8x2v/FrtCnTTe8LYGr7mj5LMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L/lVJyAiyQdO6PD6Ti+vUz/xw878Dh+ru3b7laDeyktKj2/YZ6iPIJLfehMGJbrIu4e4CB4DdxN63Tt90JLYW52cWK27Wztdj6Gakd37lxzR4Ucpci+eLztPdFCtuXEa3QCMD5Qlv+l47hNw41OqmgJ9EJK8p+jQ26gicDYbGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QQgDFEWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E66VNlj5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QQgDFEWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E66VNlj5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C8C57A026A;
	Mon, 19 Jan 2026 14:06:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 19 Jan 2026 14:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768849583; x=1768935983; bh=Wg2kyJEAic
	xsZHCwqrlnBAMPRSmS6IFrEDT+CtK/mUQ=; b=QQgDFEWijMskeh5S9KWRz4J4fN
	iKsE1dRr51y4m8TpDIlbrcscYfM+NuA83Y9udCoSfsQ1o+3w6Ec2vbgfgQPDWxdH
	A9p0c2DJ6SVAfVW7rFt46huOEby+QYopyeuY+SjYY96ph9gW24iFe3BbiGFt4YG/
	mD+AuULUYq2DAYmhZEqxwyMnqHhRtxlSK+Pqtlvnm5zw0q+7T/YCTGkq/gpO8IiM
	5oYYZ0q3gRzRpOKvCmDkk8DgA9H+ipA532R0lvD1IazLwOtYrmO7u2DEzqE4OXZT
	2EbTZySiia8BN82fsdfU4cMnCnDnJcimy8GxSMGld+FfB/CuKH6dInggO7Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768849583; x=1768935983; bh=Wg2kyJEAicxsZHCwqrlnBAMPRSmS6IFrEDT
	+CtK/mUQ=; b=E66VNlj5LBuzyFhEU0NKNtDR9N2z622o6L1nGnq+QknCFCv0D20
	b/Ak48gfiPxGfSYiTbklr2+FANir99hGG/xo0Ay3u9mCufS9O7ZVAI5RC7gxHNNU
	O0WuJZUlELuj5tbmL9Gb815KvIXEIXae8LHzHkgLbN9J967a78fhpr4mgzLkNFTe
	53INwNnvf4qUTxdpfZjjshabnQ8uyDTkU6VdCNM1hgTkyZCmJiYJJC/uRl6yXEeW
	jhZj5HYoXgH09xIPQnvXxt2gObdv3biqqpsilU/rPDgKdGUdu4URNNakjDUq0PYs
	8kTlm4tEo10PdzyW5yfDI55O5q8ah4Hzv5w==
X-ME-Sender: <xms:r4BuaUqmf5T6RL_ABsTdRREKX5KfGFnZ5myAK13L5IZZZiSR0tbH2A>
    <xme:r4BuaeWKaVk2CCH9Er7BNNOpG7URlwh3B8LHC1GoM2XZcOZIljiAZtiSoW9qRgUEm
    _yJxVY3oHIpjRwQEd3MdAYsGtfBpCiQGK3l5VhrbSt2Wt4SIwoXAbs>
X-ME-Received: <xmr:r4BuaTA8mc5TJeRCUdQsEnztUZnVhokhBZz1M7yz60dnKlja4fq8Zh3CG5vp1Il_iqrGqV-roWtVHy1IgeEx6bhcbPSePruaTYcvEIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r4BuaS0wf6N872SG0AWWqjzUIWOGLKwfpeoY8GQ30O_NAW53oxc2vQ>
    <xmx:r4BuaV3AYbh7pgoXYIFrYHjcBqfbIrrXoqLwkvGh3bg7KcVxc49kPQ>
    <xmx:r4BuaXCUXt-hVYFQEu5WYn2Vv4Ynp5baiZxD5JifKIHkMb6nSXvVvg>
    <xmx:r4BuaU5K6hkRM7934xowtSOjZBq7F6_mtFcUdSY1TyC-dXRXKWUIGg>
    <xmx:r4BuaaZheLHWo9JB-A4TIMhGR871FVUUwkDTW5EXHHwsTvPjAwUTKOb7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 14:06:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: amisha <amishhhaaaa@gmail.com>,  git@vger.kernel.org,  stolee@gmail.com,
  newren@gmail.com
Subject: Re: [PATCH] sparse-checkout: optimize string_list construction
In-Reply-To: <20260119053251.GA1991605@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 19 Jan 2026 00:32:51 -0500")
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
	<20260116165003.95314-1-amishhhaaaa@gmail.com>
	<xmqqqzrp74q3.fsf@gitster.g>
	<20260119053251.GA1991605@coredump.intra.peff.net>
Date: Mon, 19 Jan 2026 11:06:21 -0800
Message-ID: <xmqqy0lt4e36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Jan 16, 2026 at 11:11:16AM -0800, Junio C Hamano wrote:
>
>> > Improve O(n^2) complexity to O(n log n) while building a sorted
>> > 'string_list' by constructing it unsorted then sorting it
>> > followed by removing duplicates.
>> 
>> By the way, do we have t/perf/ that substanticates the performance
>> claim here (in other words, how much improvement are we expecting in
>> practice)?
>
> IMHO it is not that big a deal to demonstrate the perf improvement in
> the test suite.
> ... a one-off hyperfine output in the commit message would be
> enough.

Thanks, I agree with this conclusion; I didn't expect a huge
difference from this change unless N is meaningfully large anyway.

