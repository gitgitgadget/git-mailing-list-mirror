Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172F4C92
	for <git@vger.kernel.org>; Thu, 29 May 2025 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551868; cv=none; b=OmBgIDmIYbsesgPYrm5X0IRdFox43I1gw64LfeUurDEnokiIwGL8gbK9B6q0I5fKvJ7FYZzATe0gNSpywBX7VkfseFizBU2D5NuB5EmheJRJGGSQHY7/2I0IwIxNBE9i+PBQIJz2fGoicmQkPWA+C4PlNe32EFsr9n38a3zWUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551868; c=relaxed/simple;
	bh=jClExOt4+EWDyNOTs1suTlM0H3z32QJLSsA/MT9jwLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cukgzu0e0k3JCEU5KIAJ4/tro7wH1iFTJCiNIuyG9dAtq3J0ot0X2zXxK7Hxcdi4wscc0Icpjy3oZkVnS/WkTP62MRxaIfbdcWZA6AKi3oaATVWODIldAm+jhVQ46vQOdgg3RpfP5LkrrqTtrq4pZXtfjRemgTgsHFtCwrQ/0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sHhvRcVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZXdgobs; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sHhvRcVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZXdgobs"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4212A11401AF;
	Thu, 29 May 2025 16:51:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 29 May 2025 16:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748551865; x=1748638265; bh=5MYIaGlb5A
	yXoKf5NfqXZCwVjae2vbwaP1Eyl2kePV4=; b=sHhvRcVvKBZvOmdghM7zN/5axS
	uiOd2KLaj48rGZkVWpW3gGQ9hYRqtAgW5Vk1v6bKKNB3jpflM2PTobqw+DkUdzRD
	5rkLCW/3tOaMRfzatyUSV1dc2LbG01k7zptWsR3L9KFkd6/htjaUZk/kLkVKYlEq
	B9t8HyX6yMQLQA/PV3y66+5dB8Um7qBQ+CIw1QzxOxmlncncgmiRxiE9qm1x1Bha
	gq1+1WB+XJaOXgoTDw6kLK+WaTL5k2ETVlVUcomzlO2a+r+q+kriTJUJdzB3lxmQ
	5dG+3l/QIh6kwfnNcGMwZySv/Ur1eX2WfuvY38L0FI5dxjgo3sCburtcL4bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748551865; x=1748638265; bh=5MYIaGlb5AyXoKf5NfqXZCwVjae2vbwaP1E
	yl2kePV4=; b=bZXdgobsKlZX5yfsNVjqXnD+UTSwwF/8KZPuFvEwfkz6tssNsrW
	prE82AlxA5XuWxC4bWWEDuvnUrRdO7tWTJvCe/NZcJb1HBnKNYQZJlQdleH/JKPh
	CGBVQXTKsQLKcCMxY2q+DJYiStXd9pbNwLCSfzcLoi6ENZjmb18aQp9OBIvtJeG4
	/BZ85rBjdIzRXjgHqe5VfN79AZJoFmTHkSPZgRsYvOvrpMbRpY+G2yIh115RofUC
	RNuTuhbkunCpJKnekXNjUgfnKy+UQTdijtbMAPvr71KLPYK5d3LM13ubpFCiE4xO
	5bYWozL7Y2AS2BZmuVjGr8/EukzA4Ud948Q==
X-ME-Sender: <xms:ucg4aH35vwyPB1CFbZBHU4SBL5YjGQEwW43CCDbLlhcMV5PCyhspyg>
    <xme:ucg4aGGkFZUZ1FrLdoJC6Ov_BcmSoj1wOIHfZTi1N1uwv14Lb7YCTpRKt5Hzr0mCh
    7f99WRiv3djpJNdmg>
X-ME-Received: <xmr:ucg4aH57sorbEctaJq5rFUSnZ-KuxmjuCDx-6cx_gxAh6Ho7oJDdybUV33gGv0ZG-R60vs66fW2hveKSd3z0JjVx5nsIWW-_Iei1zII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvjedugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:ucg4aM00_cmH8BIr0Pgc5zPbH6O4SjDzeiNmcYfo8sww3EfEQRcH6w>
    <xmx:ucg4aKFtfy1SVhEz1VDYvCbBMRxMJZmbq6LrPZ5H2bEWkz16H29P0w>
    <xmx:ucg4aN_vEgs5glF8FYBV4hPCuu_oPCnDilLjoZ3pHMOVcd_pADxQlQ>
    <xmx:ucg4aHkNxLBdWNBZNKBEsrrpj7v9pVNvxMYoWGobO3yEHGZ7HTTs3Q>
    <xmx:ucg4aKQLWsdab0vzaxS5U2bcN2NvqbN0Etxj7CuNkOuKehn73z0EOQ8K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 16:51:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 1/4] midx: access pack names through
 `nth_midxed_pack_name()`
In-Reply-To: <d3508d3cfbddb512dbca4c2177731fffb5827084.1748473122.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 28 May 2025 18:59:00 -0400")
References: <cover.1748198489.git.me@ttaylorr.com>
	<cover.1748473122.git.me@ttaylorr.com>
	<d3508d3cfbddb512dbca4c2177731fffb5827084.1748473122.git.me@ttaylorr.com>
Date: Thu, 29 May 2025 13:51:03 -0700
Message-ID: <xmqqmsavjg3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Accessing a MIDX's 'pack_names' array is somewhat error-prone when
> dealing with incremental MIDX chains, where the (global) pack_int_id for
> some pack may differ from the containing layer's index for that pack.
>
> Introduce `nth_midxed_pack_name()` in an effort to reduce a common
> source of errors by discouraging external callers from accessing a
> layer's `pack_names` array directly.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c                    | 7 +++++++
>  midx.h                    | 2 ++
>  pack-bitmap.c             | 4 ++--
>  t/helper/test-read-midx.c | 7 ++++---
>  4 files changed, 15 insertions(+), 5 deletions(-)

One thing I forgot to ask.  Should we expect that

	$ git grep -E -e '(\.|->)pack_names\['

to give hits only from the implementation of nth_midxed_pack_name()?

> +const char *nth_midxed_pack_name(struct multi_pack_index *m,
> +				 uint32_t pack_int_id)
> +{
> +	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
> +	return m->pack_names[local_pack_int_id];
> +}
