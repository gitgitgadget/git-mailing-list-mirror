Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A791297A4F
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727799; cv=none; b=kilTzUrD/2LaK3bvj1ZRzZ40xrwPXs73vM9VnGVFgxcOI0Zn89iv20bz7duICNoR9ccpiiOw0zcz7gkUndK9D6yDqN6gUa3Eh1OsfzTqDwcZecqirjH3CzFyn/p3raHrsAqUoymCh28owL+HHGtcqjBjLJntsnNsm93jt3JwgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727799; c=relaxed/simple;
	bh=xAjYtwd/O0hOvZhHzRf4Y+aR6ix7zWWtZA+wZ7KKhiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KDxKtnSo9xBy455fJ9Iux0b0KJnkPg+0NgpSsBJBfBk9t6LKBBmSPpM3AfCsFekvOGoaKo7Fz0VqzgEesf1K1IQiG/cy6OuFm0ApR9OjHERkUhQCg2wmkPpyfuD1kesUyfa12e3ySl12XQxj9cWD3oHoQovixnVMLZOGqVukU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JA4rGNcC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r0oZ/1rd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JA4rGNcC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r0oZ/1rd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7347B11400CD;
	Tue, 15 Apr 2025 10:36:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 10:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744727796; x=1744814196; bh=/DrWW0xc34
	0+Pf2a14O5Q0HhzokJhd9RdFLPa/8lgBI=; b=JA4rGNcCWgTE3mrcoGnyw0wJZR
	iFDGGsO7uTjY9IGQ0Tc7K1yEW6VKm+EghyRARErYcin4QzjzoPuHg9yjkrWHUijZ
	gJUAA0QFBvsGijNdTQAwBLPTbdON1LfNOoLPP2iNjCiJ+rF+h5+9bJZNghznyA50
	OOaBZe25bOH228CTGLh0XSLeNo2+CWOzr6k8Jqb1C3KFafHr5IjaUeZfqHBVNaV6
	q8hsisDT21Eq9FBXzBnEQDLmV8tCbWiuHyvA6WKtOyQO4uGnsiY8t3b5+8C7gjPO
	Lz1THKaXbNRy6DFPAv+2G9ZMTpKLt8iaqbHnJ3SNL4uNJBPV7fgei8KLEzlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744727796; x=1744814196; bh=/DrWW0xc340+Pf2a14O5Q0HhzokJhd9RdFL
	Pa/8lgBI=; b=r0oZ/1rdC5Nsvd+lg4FKYhY+QZj/fVDCKNBl0Q+bvvj5ijkfFs3
	x4qAtMiZynpWqP4C7Y8YgL1kHbVVFo82modHcDEQB1TJ3Nsh0ASpZT5BEWY/H5A0
	gWe41Ggju2ryfzaSaHRe9uLEBvEdtEItCg48tTqE/bfH2SXZ63ADMerDNjclV/A4
	gkHB1ah+q8aIv8dcK4vE68XenIxCfSuwl597H+E6G7wvc8zTyF+xX8w6Ke9jVNWc
	K65EAfj104gAroPzuaxicFFF7zl5EJxPDjlhEVfYpQjp483ZBMQwjwcoEvCri8Ti
	awioTi13PSyhVk3qSWK+h0nLPQK5m+OztdQ==
X-ME-Sender: <xms:827-Z4aYEsxAGv33kEX_VJpxywoqX2ks5C2SNe-UfY0M_mvi7iwTtA>
    <xme:827-ZzZxcbBuAPNTeGr18b6WMizlriaxolxyZRo8-kcg43m5MYpibOo2Oh3OhJ-G3
    Po0IYOwFVWsLsv57g>
X-ME-Received: <xmr:827-Zy8QLDWAEHemuQdo94enPU77MP0bjMgTNAdzAJAyUJcrXw3Zxtlsx-MaDfsQfzeHNS8_YEqBMaiKPrqph2-rhj-VGIj9nROT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:827-ZyqKhCwbeCRXK0AWFuXmlcqzo-h8aRAvOkUsi8NA1GkoxamxIQ>
    <xmx:827-ZzpUjA_P5uT2P90F3tIrRxxrYRRP-t5AqJPjRwWl-JpHHcHM1A>
    <xmx:827-ZwSVyiTrfBAGrMj0ocfpSRXCLROropNY7BwTgva4eqbet5e5Eg>
    <xmx:827-ZzqccPY69T9wXjaQmw3m1QrA_8-U9xZmtMq85ilvZQ0pxXlQhA>
    <xmx:9G7-Zy40xTWProBnVVt7oA5xAN1RjCqQrhkoQkHYMg0G6AoSnBaNrpGd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 10:36:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] meson: wire up support for benchmarks
In-Reply-To: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im> (Patrick
	Steinhardt's message of "Mon, 14 Apr 2025 08:51:10 +0200")
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
	<20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
Date: Tue, 15 Apr 2025 07:36:33 -0700
Message-ID: <xmqqplhdo5ji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this small patch series implements support for running our benchmarks in
> "t/perf" via Meson. The series does not aim to replace "t/perf/run",
> which is more fully-featured and allows running benchmarks against
> multiple different trees. Instead, this series only allows running the
> benchmarks against the current tree. Users are thus expected to continue
> using "t/perf/run" for more advanced usecases.
>
> Changes in v2:
>   - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
>   - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im
>
> Thanks!


The previous iteration of this series has been kept out of 'seen'
for some time and I didn't recall why I did so.  With this iteration
merged, all GitHub Actions CI tasks with "meson" in the name are
failing, so does "documentation" jobs (which recently acquired
"let's make sure meson-based build does the docs fine" substep).

Can you help seeing where the merge went wrong (yes, I am suspecting
that there is some stupid merge mistake there)?

Thanks.
