Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D651419A9
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471455; cv=none; b=ox3KPgWTCbwBSSSiVzTGlu7gjUtJRZKo+ffuK6TC5UV+Ky3hFcf/E3dSYDcfQmKnlrGfT3u9x0R6tcMjSxq8i5/aKBwWRTvWTnjXIbUwwRKoxhGtSRRgbb+XxmHfg2k4cFDPKFpR0UU7fnvHxadRGkO65TcRM1Pddv9TAKFFgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471455; c=relaxed/simple;
	bh=QobPBXbr8zgua0rsDmz1gX3aDbVGQ+RN3g/BL5q8bYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MY/FNLgHinaswqkxQqlZTE0G38m9pFUs3/OEyO8lJmmoUVlgNSSFHNNple4jRlnEO92tbC7yxeaTARBO7rX2Fqm113p+qjNdVedBm/87I6LdGUGNa3US6dc5OYEDQBJm5ujKKneXn91UaFwwdTyd7LEJdldvWtps4s/hdFD1yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l1t1ft5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hY+Zn0kK; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l1t1ft5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hY+Zn0kK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 68ADD1140187;
	Thu, 13 Feb 2025 13:30:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 13 Feb 2025 13:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739471452; x=1739557852; bh=KrA/18TiD1
	2KQejvrLMQ/HQnAfYsq03nK+QjKWki02E=; b=l1t1ft5Mn6qK01ALu3cnABn2mL
	haVpVw4d8hojGMLHQK4AlV2/9kdwo8/0ej802+6o+P1S1LDDLRk/V1Rzmg5icoox
	vDg9cCWaLNIHz/cP3pfnxE1l0bNPSsGM50ZdDCdxkwMIDAoz8DJMcqoASMrr710t
	N/KpcUfjcp+hW55GFIsb7ehNiwBDZScObZJIgwvaOAJfBctjMdmuqoc+vm0CIbqi
	qcZv88uzhGd8PYgksJBZc8sunxdMVX2McgWSEyPv1Kl7ihVmuMg+9lKSFQNKZOWH
	Dl5LAfWoF6qFkVk7TrXGsyFhZsO0rZUWku53GUHvFcK7/cq6ypH62DI+MaoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739471452; x=1739557852; bh=KrA/18TiD12KQejvrLMQ/HQnAfYsq03nK+Q
	jKWki02E=; b=hY+Zn0kKlxjJans+ZOQJqgfLDYHKWad9zT5uASlocY44pm+A3ZP
	yomuiR+MSa584F/S4p5ZY4JnFeAjQU8SiNBPKXY8Uu1sFfYzmNY/PiPW2yaC3O82
	V8WaWe7n9e7bIGchhuZMJHdQWTFE2+u1Btd0VHPQJsOFGbqrNdBUOkeGdc4nJldV
	uI/NY48tYQwmX5kgvZBGUSpKN+JhAxqkqQcpb/hjD06dDgay5zdFITOjeXYo8R1+
	s+tEQUo3oCAzoDmjlcMLrDOYb6V0IphzivgQEbxWT5TGqC3I+onHvB6kcR+uFt93
	wp24xDaHtXIlntA2uEJXdCmnmBrTk7B9Arg==
X-ME-Sender: <xms:XDquZyCmgkKLyYxxYuf0jzkdxznEpoQvfZKT24cZf8De7DvWb2fIXQ>
    <xme:XDquZ8iXV-AaCVTHq3KaVA-6pl4SapbJBZZup6VVPv1xpU6KmBe0zJguFKKfgDH64
    qyC-dC1X77D7yBt9Q>
X-ME-Received: <xmr:XDquZ1moaYvdi2WmnxHyTuTfLd_wmAjhOAPP1U7ahnojzS-JiSPJdZ9I6_Ahc7PCa9nq6GKZctpqV4G82uxAhkJCKWYO5l43SRKrdCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XDquZwwQLO5Y0TTxY4l3KMCRY4R2RI3XJxNr0YbuELhSngTobp8zqw>
    <xmx:XDquZ3RhgW5A66IsekqTlfOEnnk_75neukc_5tR2dyJY5v5DCxyG8g>
    <xmx:XDquZ7ZSezo-elyjjOM9SqnoKkb34Ad9UEDnfIaUAHGJS6MzGSPuyA>
    <xmx:XDquZwRNNzkydW_aDHJJTajzUGajz6GNSYU-7wcqpDh0KUzrRuXPow>
    <xmx:XDquZ1P4e6v5adsfZ_ELSubC0DcfEGOvO2aqn8TvksVQwY_9psXlpui8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 13:30:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for
 get_unmerged
In-Reply-To: <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
	(Elijah Newren's message of "Thu, 13 Feb 2025 09:11:33 -0800")
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
	<20250213090040.16133-1-meetsoni3017@gmail.com>
	<20250213090040.16133-3-meetsoni3017@gmail.com>
	<CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
Date: Thu, 13 Feb 2025 10:30:50 -0800
Message-ID: <xmqqwmdtofxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> (As a side note, due to the specialized structure of the input, I
> suspect this code could be modified to run in O(n), i.e. we could skip
> the string_list_lookup and the string_list_sort and the
> string_list_remove_duplicates...

Are you talking about the input being already sorted so we can just
walk the multiple input and merge them into a single stream?  In the
cost analysis you did earlier in the message I am responding to,
being able to go down to O(n) sounds really like a great thing ;-)

> But, it'd make the code trickier, so
> it'd need to be carefully commented, the change would need to be
> justified, and it'd need to be carefully tested.  

... and measured.

> Even if we weren't
> planning to delete this entire file, I suspect it's not possible to
> find a case justifying such a change without optimizing several other
> things in merge-recursive first, but optimizing those things probably
> results in a significant rewrite...which we've already done with
> merge-ort.)

Sounds like unless the performance issues are shared between the
two, it may not be worth to spend too much brain cycles only on the
"recursive" one?

Thanks.
