Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C0390997
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490216; cv=none; b=kDtNUKJrvUoH0wXzcQlmt2wCaPxSeLczyFqG7zkpe/bdR0S9g/afAbMVgyWXXSMAF4eWc/uVkLY5Ylw8MsYig6tJmsy+grMGdaCL5tsJtuGbOSVn0b1qX+wisPSG7YBh/JzlV83wCoPm8/EkmdLnCaMueX8gIAWjpvCEDLeJgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490216; c=relaxed/simple;
	bh=Tf4w64ZVfOs0zSp3YN5lechBGrzNDXpEc25C+gcc0dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mLKsL7dXxWcNn4F3DDyTzV1bxudXWCnNHh95YKmXsWnTLoFIO7PeinrDMZ37/pP0N2/SfyC1xbx8PT9NXWxYV1S2saYCtP0AWbp/2xaA58FdEHtbp64WN6tw4L+v65awUHyWOdFoSMTpYNu2sYCLC3Gt1gy0/Pmq6I0VpeFMi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gqyRN8rS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tprGO96h; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gqyRN8rS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tprGO96h"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD9961400169;
	Mon,  2 Mar 2026 17:23:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 02 Mar 2026 17:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772490214; x=1772576614; bh=maljyzGIkS
	JlPzsZgEkJWlokHnIVJwi/Y/Ojj6pQiO0=; b=gqyRN8rSSID7O1n4KV1m/rhMW1
	zYhkGoJfHk73D0GCp7TQldH47qe35eETMfOwHgq127IVDqcZyuaA3UttKV0Z7o2j
	37cpzhY38FiZfGS1TxmGm3L7ucQO6a9+Ipo8gI1pgS6mpWJkhDfIQ0Shww3YJe7j
	s16a02AOPDKVdmmczjkEQABNed5uX9CIIvI7MCYJghv0I1X0CSKho7AcZ9B8+R/f
	3cxeulAjcXupSreUYkD1XjDyyDWhdddejtahoID9MDqQCIK/w9qBIC+RSYTrp6UM
	YbLEH6aGa4NlasGYzKongqxz/Mke1ghkB47cSVI6w3jN4/5KO9vBh6Lqqg8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772490214; x=1772576614; bh=maljyzGIkSJlPzsZgEkJWlokHnIVJwi/Y/O
	jj6pQiO0=; b=tprGO96hwIfQaxUJZlZ/e0vi+2zBXvT8ue0OrrmzIqOQto0RHmO
	bLZ2N61pVUpMWsxB7GwgdoByoK1dOdoYRtwc/gAndc00gyRqPghhWKbSN/H5KvA4
	Wl7OYz7Y69/xgDwxudKRXC9mDIE0TDh3dHQThXamhMSuWhdAGsQkfUmFqzpZJRsY
	fbh+vk6RPU5qBg0ygNnvyD8DgFY944/774qxTzc78sSb2GTH0TZArZlPcR4UCXo2
	2oP/firlIq8xuKTUkgpWMkJ88KP+AH+LyOlSCJY+m/IzUhMb1EAtpZrIpRdZ5PUZ
	6rSstg9T4vWT8qdYv7e1gUweYfRBeIdSv0w==
X-ME-Sender: <xms:5g2maY_eqqbqHKii7Rk0j2EiVZmceLTedjzWCysqWalLq6LmkrIwzw>
    <xme:5g2maXv9twsHo8NAqfUnYex30dUiN2nL2BwsgLoHskcZ0PLImGqROOYbL02zY72u7
    EVHX-elt4SuePu3hyKpi-_GYe6qRtHKFuWDJWvI-Ft66SDv1Axhcg>
X-ME-Received: <xmr:5g2maTB9YRAjtbeO9u2gCwDPHxivzZJ26_N3f7gebJ-h4MhdLz6rTqwfsVDygTnQ2sFg71OwUlOg_HzJ3h4urHslj_2KNSsd5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5g2maXV7W3GoqYK3jczjJ4NbB-Dsja-wzKNYj7tA8b4kIh359d7fUg>
    <xmx:5g2maZDk-2fmVCQ63WAIU3-wcQYq2hgp1in3kX0At1U2BwoCP6zKpQ>
    <xmx:5g2maS__73hrphHdeYlXj7FTkROlznQv6blhy-WUZd5m1UVZslz6WQ>
    <xmx:5g2maYH0sqZX6fxSu1sj_qrpFZTCJNs8D8wQ9Ad222qlB2COu1s1tA>
    <xmx:5g2maWj_oglg4zcEUiIh1AZ6EGKx6qkpsqPYRxFMAUztaa5uu7i4Y9Uk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:23:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 1/5] oidmap: make entry cleanup explicit in oidmap_clear
In-Reply-To: <20260302200018.75731-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 2 Mar 2026 21:00:13 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-2-kuforiji98@gmail.com>
Date: Mon, 02 Mar 2026 14:23:32 -0800
Message-ID: <xmqqfr6hyior.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

>  void oidmap_clear(struct oidmap *map, int free_entries)
>  {
> -	if (!map)
> +	oidmap_clear_with_free(map,
> +		free_entries ? free : NULL);
> +}
> +
> +void oidmap_clear_with_free(struct oidmap *map,
> +			    oidmap_free_fn free_fn)

Made me briefly wonder if passing "void free(void *)" or NULL as
oidmap_free_fn would be flagged by the compilers as suspicious, but 
"typedef void (*oidmap_free_fn)(void *);" is obviously compatible
with both, so it is good.

> +{
> +	struct hashmap_iter iter;
> +	struct hashmap_entry *e;
> +
> +	if (!map || !map->map.cmpfn)
>  		return;

The first half prepares our oidmap_clear() to be fed a NULL map, but
what about the new condition?  Where did it come from?  What makes
it suddenly necessary that in order to "clear" an oidmap you already
have to have defined cmpfn?

> -	/* TODO: make oidmap itself not depend on struct layouts */
> -	hashmap_clear_(&map->map, free_entries ? 0 : -1);

This is now achieved by the use of container_of(), right?  Nice.

> +	hashmap_iter_init(&map->map, &iter);
> +	while ((e = hashmap_iter_next(&iter))) {
> +		struct oidmap_entry *entry =
> +			container_of(e, struct oidmap_entry, internal_entry);
> +		if (free_fn)
> +			free_fn(entry);
> +	}
> +
> +	hashmap_clear(&map->map);
>  }
