Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1ED21B9F5
	for <git@vger.kernel.org>; Fri,  9 May 2025 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755728; cv=none; b=GV6RgCo6uFO50KPsv+jma/QTsT3/ponsEpfYESoWNRgb5ZxyZXn1ysVjydQr0qfXrWpwmv6udWgj9zdvedtSxcu2al/RGWBQbOVJLCW2ADi77t6tyJ5qsxh/FAU37gfCGqo0kQXKVEY46JO4u7wMEEgn3Fj/musivvkyXU70nDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755728; c=relaxed/simple;
	bh=3Z9mta+FQMYTqDmMuB6TpWerV7Ae2NUpesE/vvVbJiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lxl/+wBxErIpxoh/W5Po0ZgucOCN1qrF2SKAE2jL634xz00AKCuBqSTT4GEZk+TznLJbwOx+y+t5ZGcL8gZuG8o1V7dwjZgn5bbDvYxjuc95yWMF2VZ7g0VOYV+p9Y/JGtqVKhqhF3RCeUcENwrKuFVtAoJNj+p7+TYO1/LrlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/OtKLk3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mbFBzjSp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/OtKLk3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mbFBzjSp"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3E601140153;
	Thu,  8 May 2025 21:55:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 08 May 2025 21:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746755724; x=1746842124; bh=n66q+2ElqX
	QrdPtR+lqHke9CUL7D5MdJMdSXUTsxCi8=; b=c/OtKLk3gxbDQNmNLZQE9OUXxd
	hfmePe1gi7CuJKQr0o0624vAxyzDTPfA9Bz8auPpASIUGUi6Vik/wBLhr7fqPtOJ
	8s2+b1KxWqHost+Lophp2npLNKLJInaxP0TxR3UzZll8pn69EeUM6wso1QdJhDM2
	B4v/tRBjQtjF7Ipaubnr0GbO24qXOy3W9fduOLfJ1MTnJ5tyY8MEiJzpkMxRoAL3
	r44IdeRiCx7YzvJpJygDYeEqsyl/QciC8QiKN9DV7esGEg0Kdb0ml8Nip5JiPlJR
	uE/oBbKpRiIiDfMeR7GPh47BgNYJa9v30HUWt/OXp3mQidX73vrsc/sLKE1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746755724; x=1746842124; bh=n66q+2ElqXQrdPtR+lqHke9CUL7D5MdJMdS
	XUTsxCi8=; b=mbFBzjSpPqVRbqiznBYsxhcKBecJtA+FZmMhPpVWFczs/aUSK0P
	r7fcR59gMaEDhMFoPtvV8aEaLe5Ev2CuZDW1hw4fCcW+VEWYQPvshVlaRS7emf9n
	rUHAgWuqdyhBTQCumxyT9jUwmDx1r4ii04peslPSYoe8Iqo0diUlmR7dBAbWqNPR
	T8kdSwsnwCZ+5WaPJxul+U7znTwcMmsLRebBX9mDweQWwIWoCFteewM3Pl2t4qLy
	5DxOiuXGYcjN1uT0F6jbNHGeHXIUZs6Qi+Yhbd+F/TKtXvRpFJZsy+qnfmYK/yWG
	3leP7X+uzAtzMiUyLTWJyeYWdbOOz1wID8w==
X-ME-Sender: <xms:jGAdaAsjnqh5XPgbHVJrm5AfOFFUiRd9AyHn7O3rx8bFUSE7sLJCjw>
    <xme:jGAdaNfp6v5Ji-zpjeZY7z-mFrbnJ3BRw868Tld7DQHdllE74fgtw6kl0jVkw2H48
    sGnESSVAaxt1Sqw3g>
X-ME-Received: <xmr:jGAdaLwSsZNm10xIQ3dPW-9SEynzyOSyyG1UACMoNhF_ahBXPndXrKKK3cZ84ER6OBDrclZ0fe81QU35ro2tb4XFGES0XMBA84CF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:jGAdaDNObYua2JDXpIl2du7yEE5FWP1ZBqSr-hT5RMHqgHSgqvzr4g>
    <xmx:jGAdaA_iEx-g1RPG0l4whWxurcle8OPbrElAnf8MTRDo4G4wYVyo6A>
    <xmx:jGAdaLVWSwHZRdSBLu8DJuh7mcaze8jwgRA7xaFTWwDHIWnRJfUOsg>
    <xmx:jGAdaJcadJQRfMLdeG7A1HYLaI3DXrFgFdM8FyJ0OX1byLJR2AtqWw>
    <xmx:jGAdaDT-JYf-k2690u3h3hV5mI6UF1twwULKYKXGGVHQvY6em1ZYHpbU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 21:55:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 1/4] object-name: make get_oid quietly return an error
In-Reply-To: <20250508234458.3665894-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 8 May 2025 23:44:54 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-2-sandals@crustytoothpaste.net>
Date: Thu, 08 May 2025 18:55:23 -0700
Message-ID: <xmqq4ixu4kfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/object-name.c b/object-name.c
> index 2c751a5352..3138103343 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1081,13 +1081,17 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  				 * still fill in the oid with the "old" value,
>  				 * which we can use.
>  				 */
> -			} else {
> +			} else if (!(flags & GET_OID_GENTLY)) {
>  				if (flags & GET_OID_QUIETLY) {
>  					exit(128);
>  				}
>  				die(_("log for '%.*s' only has %d entries"),
>  				    len, str, co_cnt);
>  			}
> +			if (flags & GET_OID_GENTLY) {
> +				free(real_ref);
> +				return -1;
> +			}
>  		}
>  	}
>  

Almost everybody else in this function hits "return -1" after
detecting that it cannot yield a valid object name, and this change
makes the oddball case do the same.

Ideally in a distant past, we might want to remove this _GENTLY
flag, together with the code path that is not so gentle, and adjust
the callers that depend on the current behaviour (which I somehow
doubt--- they need to be prepared to deal with the error return from
other parts of the same function already).  We might need to make it
possible for callers to tell which error condition we got (e.g., did
the input give it a non-existing ref?  did reflog walk run out?),
but these (including to the change to just lose "die" and always go
the GENTLY code path) are totally outside the scope of this series.

Thanks.


