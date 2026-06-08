Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB33C9ED5
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927644; cv=none; b=HBs6ePOYrb2uA6iujWXg3h7+BEcrnSsqYi8cku6mfvmGJapPMLvQxsnYeTfxzfC26nkCyih0gArOb3UHAHA62PRKyhmC9+44liBTATWCrpOnu7+bnxW8MmECUfI0Q8Pb4JMEdqcDH2B95Ivgvzwps9ZBbpjln7k3kPhVlPYxAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927644; c=relaxed/simple;
	bh=LyujBoGuAqkpYAk0qomItLJ5myBgD3fNoXFfY7G5ul8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JnkEsOUeBH0hqx9APYRYxhPQaUb0d2F31auHKg/AWdPGVMVZAwmQOchg2k9tbBjllSn6/Difyvm/iz260BGy3ZOebndE83rKWTuqtsj73IToPA+NDPAk2jQ9engLnMNppZx4tZWOKwO6y26rxqfECZOAjkL+AxNggBzl1Ey/y0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L6cmsMsN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UYzQPloM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L6cmsMsN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UYzQPloM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FA721400164;
	Mon,  8 Jun 2026 10:07:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 10:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780927642; x=1781014042; bh=oIQMSYJ9NH
	K6phhpIK4hL8sbh4do74LaU/DcxbMp3bU=; b=L6cmsMsNYeNJAKkyaIhzXvIb/L
	817mYSwE2su516ic767pouH/hVlWlpmkn31p0RKX1JTeXMEXx/U5KYz+YxWuv4JT
	j69YERlWSnfU4yGfgBt34u1hypQ9GtD8r4ZYWRNkKzmKbaDghFtyZKffEC++107L
	+ivuY8mQo+sCaXVr7YA2CDt5vIwEWmlO2gtC7/23jwjauTDwBOn+dZj6a4qOWKpF
	gllFiE5KotDS17YGLG6vgcopPh/I/IHCGfoFJlwXZ0C/aKUorXKaADYhlxJfEIE4
	BkbesJKlnMdbZV8fBDL67+H37L3ETWMiBKQgak3VPlJekJyQDPxU7KdueXXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780927642; x=1781014042; bh=oIQMSYJ9NHK6phhpIK4hL8sbh4do74LaU/D
	cxbMp3bU=; b=UYzQPloMvIQ37sV9ENZTXK5wrDU45yHigZc3qT4bjm28OhXY9fw
	fkCQBowLtBY/9B8n6foXxSrbS2ILGPwcfgtE0rfmdnWyfkiBMAKbJL4ZVrBFhflR
	+Dy6x0rjDrJ0FN0Q1UyF59KO9LC53sDjYt4luwR/5RIBuLIhpPVIQMtVmAZ/BULl
	DLXLasjw0e1nxtOxQOMh7Cch1tJs7D2xnWxDMTeK0cfwpIacsrc4ExgYPc++vbTO
	27ujhyuaiY/lI1e1FyI5iCn4+IoJcaRSkFZeGAuatOgjdVVRI18kq/A7q1lj1fWY
	jk42b3l0Zaoq3Ny6bKYNSqnepXD2HLcHEMA==
X-ME-Sender: <xms:mswmarFFjR3ebOiBDM6HzBeosbH3Iyl0jHwlk4A7Drm1bmUvZ8MVOg>
    <xme:mswmavOYHFowtMXapitqS9Gj5evgR4l2JFdEHTQZKKZj6gIngXWVq5XFCC94HOL1q
    JH5F3mNBYLeCyDbU-sLQRz6Wgb4NVNjGAeiy5W1a-mvnzgk8xYq>
X-ME-Received: <xmr:mswmalcErmzwHHEPu5dMHivlQlFCjRwohdawIGKMBYJYCOdOXoUow_jtF3YkGgNpp6J3cfy63nV2Eni_m1pMC1BKc2DpNWa0uSbH>
X-ME-Proxy-Cause: dmFkZTEIk1IbmREeeP/C/WNb4qz/YjhARUXimX4KOVaWAwyuLbhprHsdGY2ZTQjYJF/r6c
    Lv3u3EpWIYsTy9GsSCzuD1wGQq9hmC4N8POy0//yi63L2Q8//H6bxbYCrMS5B2/DdOwPkv
    c3Kc+ST1lSuWHbKCu0fkAfgsySnHPP4o1CouDawX9DXdmdVrVvSqPjjSDZYhqF6OhC5xgd
    CigAlRc9MRmYPXFaDKJYQUEwfM8G0xaqdhD1I+OkftA0YPmLbGIW+IgkePRIKWZNRz8y6G
    f7+WyqV5dSOVoeWlxq2aYgnjb2TLfco09XCaUBwCkmC4VyPG3HL/RKC5KJ/uYcSKeXuMH+
    qqzB+1JPP8RWVdpGO1vs/2QaHTqNn+4M6EWpCD9W9pC0J3pEV5MFldVs+0n3pMmDXW4ldw
    upHYyuAuyW78naH1OCjadwu7C7jtPfvQ1GX/4brQhBqabbFBtdTqgKztheg4eZPAYNK0fD
    uI5mW35VGAvB0lULKRgDmY44ymSPDdDGAUYCdcikEWTaMIiemm5pBYtGcpW9UIo8a/DxIr
    ociUPe5RaJoIF3RrKCAN91Vd74luhwsSPjf71I/g3CGvuVAza/wcC45ko3Owd1YYdg4hnV
    JGXKhYGN/RU/2/83V5mt3cmZ8Vx2nFnYbhy62EG762JpqO4VFKQMRYZkBXAA
X-ME-Proxy: <xmx:mswmakst05V7udL0W2JKI4HRH98RMutZgeR-c6IpncV0prNOGXUV7Q>
    <xmx:mswmauln1YWmfLq9cH5Wrv24Slq19aSLzt_3QhfS3rf-jF7ovS8p2A>
    <xmx:mswmauztAJTJ2z7Oy00IF0Pt2ZBLlzGwmUO3SkNJJ7hUqllMsvKW_Q>
    <xmx:mswmaoOd8C0bIJ5aIM6_REwMTaeFd9wrVHArKa2F2YgdnLpzcnpNrg>
    <xmx:mswmaiQlTCqOXu0l-WUVN5s30AePvjuigWitoc57IVH0p7ahFTzKwjnm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 10:07:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
In-Reply-To: <CAL71e4MbC+tdTuN6p1HiHtE1XYuS1gBM-KSejFZJ1wbftxNveg@mail.gmail.com>
	(Kristofer Karlsson's message of "Sat, 6 Jun 2026 19:24:07 +0200")
References: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
	<xmqqqzmjbpfp.fsf@gitster.g>
	<CAL71e4MbC+tdTuN6p1HiHtE1XYuS1gBM-KSejFZJ1wbftxNveg@mail.gmail.com>
Date: Mon, 08 Jun 2026 07:07:20 -0700
Message-ID: <xmqqldcpxh0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> Agreed, that's the right fix. I looked for existing ways of marking
> fields as private, internal or hidden but the only thing I found was
> the convention of using a code comment: /* for internal use only */
>
> I will apply a rename and submit a v2. Perhaps something like
> nr_internal to make it look less like a public API.


I think we often use trailing underscore (e.g., "n_") to mark
variables for "not to be used casually, there are better ways to
access this information", which pre-ANSI C people probably used
leading underscore (e.g. "_n") for.

This is often used in callback functions where the types of their
formal parameters are specified by the API and use of them with
casting at every use site is awkward.  For example, qsort() and
friends often take a pointer to the location that stores the value
to be compared, but it is awkward, so we do cast just once upfront
like so:

static int compare_callback(const void *a_, const void *b_)
{
	const a_type a = *((const a_type *)a_);
	const a_type b = *((const a_type *)b_);

        ... use values 'a' and 'b', without having to cast a_ or b_ ...

	return a - b;
}

I think the technique/convention can be used in a similar way for
"this is hidden and unless you can tell if you should be using it
directly, you probably shouldn't" kind of structure members.

So, nr_internal is perfectly fine, but if you find it too long, nr_
is probably just as good.
