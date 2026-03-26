Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216303EF650
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545537; cv=none; b=SX8Za4i3pgJeO4AHc5GZ4pNRPTuchaJ5zCQ/fsZ5EKqh5SQcZuOW2TPMNzUkSvTkvsChNhjDVGtjDPMeGtEIX78HpfxIaRU0uh6hsWZsaziB3cuCJvha7BRwBulMEx/eEBnm1MddFud4eBY70EUH1KWjCs2FcXqR1YahVGd5D5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545537; c=relaxed/simple;
	bh=hH+CNvOpnLgewAbVeIrA/9ip2cWeff56zX73FTc7Fgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VQqlyQDVqb1xFvQbY54LDmY19fBtbO6L31tekNJMyitwwQ4EX/A08SXE1fTcnc0bhkIyES+6BWrRZifjeP1djkXzl5moXMttrFk7VJUBV6VQiAUdAJllxteUJezSwEWRlh3afOJKVbGAXS32E30MTLGBKhY4+wqGW69eA6xvv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gOcsdhEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJcg45q2; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gOcsdhEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJcg45q2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38F8B7A004F;
	Thu, 26 Mar 2026 13:18:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 13:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774545534; x=1774631934; bh=yDA3R8e6pp
	JQDx6i7ArEnIJUrm1JQpVJz+XfTudBpMA=; b=gOcsdhEADV1ZyYzEUgqGjLo+2r
	8QD38Oi7jhcRCj6OoSeLE8M92jn/1P1l53vseSof43lNlKNuTUBuK0uPVumyCcW2
	X/ROaVdswcbHYoaP3WdlHmqw5l527WwNzDQJoh7vMXyO3yCLr10N5AE9zVOY1Y69
	tsfy6IDUMl7UiGKQiJaM44OyKTsY+6xxwwVUcIWoBNpCtdoTvzAqkpLPVcFGnU17
	dVkjak5cQ2ECXNz13jDmtFTN6EIbE8Is/8z3PqqzH+NRy+SnlE80bsf4m0Jtplnp
	ZxZyPSNKCm86ESBLjok2EiY8KlGO3LF5oJrASa1EhUZUYoscW/56t7O6ZKSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774545534; x=1774631934; bh=yDA3R8e6ppJQDx6i7ArEnIJUrm1JQpVJz+X
	fTudBpMA=; b=iJcg45q2W/BdtbRy43aS/T9Bs0HtVwmXleLPikAD/IsjXjWwEIx
	KrXA0rkZ409oPFClV94PeOZSpDbYH7CxGQ5ndaJVoRxdB0WoAAXmEMzqyqUnvycj
	6olNqKomxPoAzGNG7PPcXuIOA6Plg73sVSYO9qfEPdH+5Eh8SYpFpu+2nOuDaM02
	ysUDhWvvj/wf43wH35lB8dnXJxHic3RcKsugkLfx38mjcLbzMnT9GC4V4mFU4FNv
	pEgBZT1ghplBDp5yaeASpjWqpk21ZP0Py0BL682etwjlU7HFLEV9l/MIFR13vao0
	mqDhtz5Qn89KKgL8bmvR0RjKFjsO3p2+0DA==
X-ME-Sender: <xms:fWrFaTdVIDi0eaD_dHSlX9yJh7fZOkYn06HGTniGZuPCjMdKYeOdUw>
    <xme:fWrFaQqq2eRqnxSrOxgTOpEQhOZWWCJH5r6-wUYpD_vP4_aQcfxl7ZxiJXD63Gxgl
    kVLXpNcFUXMe-MB0xTtg8ooDwL4ceqU1Hdjl5DWbMcB7WbowlkBNeI>
X-ME-Received: <xmr:fWrFaZ5qKKF4OHtARwoAdxaXVTEKdZrs0_mGy4key0atZlAIY6VxEFuxJBLJCvxNMWKirtGsbqxTXpqa1mIDUyopzPeTDGHwDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehg
    rhhusghigidrvghupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fWrFaerccSQscmjPn7m87M0PqDL0WvxQTLtj86OfuiuRbu8M25rVHg>
    <xmx:fWrFaTjHDs9fHyrsxRk5WDYKzWEKguNwCjlVFViHiwMQ_clKvmDXdA>
    <xmx:fWrFaQKkeLLLNls47vKayms53k0O9HjO-0tWUSiwEYabVlOLRYesrw>
    <xmx:fWrFabCqYryThvZtKpWdWlnc3-1oOGc-hmQoXBLMAEZD_umofo86wg>
    <xmx:fmrFaZZOwGT61d7YMZmofHH2rsrFqdeKC55o9MmEtZLnKh4-N967l--f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 13:18:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] do not discard const: keep signature
In-Reply-To: <9a90f93111ec54e5eb9675cb84ac1d70ad95e118.1774537954.git.git@grubix.eu>
	(Michael J. Gruber's message of "Thu, 26 Mar 2026 16:22:51 +0100")
References: <cover.1774537954.git.git@grubix.eu>
	<9a90f93111ec54e5eb9675cb84ac1d70ad95e118.1774537954.git.git@grubix.eu>
Date: Thu, 26 Mar 2026 10:18:52 -0700
Message-ID: <xmqqbjgaqzk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael J Gruber <git@grubix.eu> writes:

> Here, while we do not mutate the struct itself, many other signatures
> expect a non-const argument - possibly unnecessarily - so we opt to keep
> the original signature by casting to non-const.
> ---

Sorry, but I do not understand the above description, or the code
change.  Doesn't bsearch() returns non-const "void *" pointer?

Ah, the constness of the return value in C23 depends on the
constness of pm->commits[] array, which inherits its constness from
the constness of parameter pm to the function, and you cast the
value we are going to return explicitly to a non-const pointer.

OK.  In the context of "C23 constness" patch series, that may be
obvious to you, but I suspect a future reader who finds this single
commit from the output of "git blame" or something would be puzzled
unless we say this is about adjusting to C23 that makes bsearch() a
qualifier-preserving function somewhere in the log message.


>  pseudo-merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index a2d5bd85f9..ac81792e65 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -644,7 +644,7 @@ static struct pseudo_merge_commit *find_pseudo_merge(const struct pseudo_merge_m
>  	if (!pm->commits_nr)
>  		return NULL;
>  
> -	return bsearch(&pos, pm->commits, pm->commits_nr,
> +	return (struct pseudo_merge_commit *) bsearch(&pos, pm->commits, pm->commits_nr,
>  		       PSEUDO_MERGE_COMMIT_RAWSZ, pseudo_merge_commit_cmp);
>  }
