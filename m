Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67714883F
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336990; cv=none; b=EJwRDVCNRO5OuYuVZ7glrl9uR/dK1ckyvi/a/6cJDsGMeEV/EVV/Ehu6hP6jCjvCPSFpEP9LrJ6Tg6eZO9CAE/dBoJguwROVMQj5lhrsFNphzk7ysXjDNac2g+1TKLdWtAk0WlYathBvu0jlTi+vhmxqnfBOA0Q74DOhRfv9coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336990; c=relaxed/simple;
	bh=fqbbUHEC7OqrED/NGRZAzc4OvsWrxwrDPUw2LdvKlSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCzHQsGQE4SJTEU/mLEGFtQ67HMWFynQKSaR3t7nwGfQjQGtKx3ipuY/6dF6KV9bBALaRyG3YJ/9rvx5wnHRCtf55mLoZxffIGGOFB0bpUn31POftm+XpkWHkF4lJEZSM8IXpSpC3zPPvNKUp4vw1xhzq7luiiPXd7cBNHzIga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oc+xbuKn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDC8FJJu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oc+xbuKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDC8FJJu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E8431380220;
	Tue, 22 Apr 2025 11:49:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 11:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745336987; x=1745423387; bh=4aAlCpXG8c
	G8m7D2LFgJH9RUErmlxxQOmsQW6OHNL9g=; b=Oc+xbuKn5cJ/Ho8MucTEalJPpp
	albWm/iHnygau6IOvjH2dT4i20ugghJ8i/Mj0dhsFLGIH9iJfweRJ7+3FN96s/sE
	M1VfCKzsPzaM1JfcVrKd4kNGEqbY25oiEJpeiA0zEumCqsMH6QH2GP5qT1RjYO/k
	aLcAAed6jSHn026X04ITgyn8QB9tnnGx5VyhFnsMPdZUahZxY/MMLmuUfYy2x8Nx
	zFT3VeL/BIQGmOI7XdYmnyYLbCdzp/wtr+KaKYQRKZwKkxnQFTOkZ1lIGYGcjznX
	QTFAJWZiRRqGXn4g3OZdib2PaklzyEw3YIImUIBeIqLu8rQnB3VluOyKRJDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745336987; x=1745423387; bh=4aAlCpXG8cG8m7D2LFgJH9RUErmlxxQOmsQ
	W6OHNL9g=; b=eDC8FJJuCjlGcWIEYvkeiJk3qzWtQE4Oy1Wrgm8NzNeGlvPUQLT
	lYVd9hJBt8klrB4HutDNvYPYAEhONzBUQmHHFhlobyaVYWMCYHM8kJHAAESmmFRe
	JfcFtHh4jeXu8AufstRJs4mVgeYtYA63bwarKD8dtoYUWd7DAOZljENLyuqyiAEl
	udIEbLwMpUOJ+IKM/DKHbM4Wa81jciLKzuxiLjhVyTm1fJMvJjs/dIUaKdP2Xb9+
	ouyBlhlnLrLcUMCG/K248HwJYBZymNSJJcIzSM48/XW6wkT7ZZJ0vCv1lvLoPib8
	PTGOEMzddc7zB1JPKAjQZ7EOcA4IEXVOtew==
X-ME-Sender: <xms:mroHaOO7kExJTuY5FRgRlcPE1ql8x0O24Aml-SGvy7_S6vTHVLZNIw>
    <xme:mroHaM8NqPkQbFx2scQGqJuBbh81EleQDxqiG4B9RERYeeiZMN2vVAyFvtWa6mZza
    dMasWpXyV3Mfs4lcQ>
X-ME-Received: <xmr:mroHaFQzKn0z3Oi9hD4HPgDcpRIZE0QPmdKH3Z4sDlRU074PGYsOl6DV0VEK_BB2xu-gedxYIYUht4x5AWz4cD07lVIB5kFMlrhL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplhgv
    vhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtghomhdprhgtphht
    thhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mroHaOu-aKP5bO-Y9o4OzDD_IexfNrQBmhuWjT9vrpptxo-5hs7hKg>
    <xmx:mroHaGcwCLYFUUyvjFtFrbZ4vGOA6eZ0dX-efm2fl7Fn0wG5J_r7Kw>
    <xmx:mroHaC3C007R57uP-nLLQ2C95yD2J5LpSB9z3Og5TaAiDD3x6sob6Q>
    <xmx:mroHaK-st0qzkbExFPjBT9gEna1ILOM-Yxxi56IXdRusPi0WNYj0tg>
    <xmx:m7oHaOEOdNMaNHoOWonXn7_H9eTpquySD-X9ms0k8V2uHRZ9jAJAqMP6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 11:49:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Git mailing list
 <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>,
    "Martin von Zweigbergk" <martinvonz@google.com>,
    Nico Williams <nico@cryptonector.com>,
    Edwin Kempin <ekempin@google.com>,
    "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] p5332: drop "+" from --stdin-packs input
In-Reply-To: <20250422111632.GA1855088@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 22 Apr 2025 07:16:32 -0400")
References: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com>
	<20250422111632.GA1855088@coredump.intra.peff.net>
Date: Tue, 22 Apr 2025 08:49:45 -0700
Message-ID: <xmqqv7qw42na.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>
> -- >8 --
> Subject: [PATCH] p5332: drop "+" from --stdin-packs input
>
> This perf script creates a midx by running "git multi-pack-index write"
> with the "--stdin-packs" option. We feed that stdin by running "find" on
> .git/objects/pack, using sed to strip off everything but the basename.
>
> But that sed invocation also does something peculiar: it adds a "+" to
> the start of each pack name. This causes the multi-pack-index command to
> barf. The modified name does not match any pack it knows about, so it
> ends up with an empty list of packs to put in the midx. And thus nothing
> matches the --preferred-pack option we pass, which causes it die().
>
> The fix is to remove the extra "+" (which also lets us simplify the sed
> invocation a bit, as it is now just stripping the leading directories).
>
> But that leaves the mystery of why it was ever there in the first place.
> The answer is that an earlier iteration of the patch series had a
> concept of "disjoint" packs in the midx. And one of its patches here:
>
>   https://lore.kernel.org/git/c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com/
>
> taught read_packs_from_stdin() to treat a leading "+" as marking a
> disjoint pack. But in the second version of the series, which was
> ultimately merged, that disjoint concept went away, and the code to
> parse "+" did likewise. The regular regression tests were adjusted to
> match, but this case in t/perf was forgotten.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/perf/p5332-multi-pack-reuse.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  I wonder if we had some tools and mechanisms people were
discussing to track changes on changsets, such a mishap could have
been caught more easily.  [jc: random folks from that discussion
CC'ed, just in case they are interested].

>
> diff --git a/t/perf/p5332-multi-pack-reuse.sh b/t/perf/p5332-multi-pack-reuse.sh
> index d1c89a8b7d..0a2525db44 100755
> --- a/t/perf/p5332-multi-pack-reuse.sh
> +++ b/t/perf/p5332-multi-pack-reuse.sh
> @@ -58,7 +58,7 @@ do
>  	'
>  
>  	test_expect_success "setup bitmaps for $nr_packs-pack scenario" '
> -		find $packdir -type f -name "*.idx" | sed -e "s/.*\/\(.*\)$/+\1/g" |
> +		find $packdir -type f -name "*.idx" | sed -e "s/.*\///" |
>  		git multi-pack-index write --stdin-packs --bitmap \
>  			--preferred-pack="$(find_pack $(git rev-parse HEAD))"
>  	'
