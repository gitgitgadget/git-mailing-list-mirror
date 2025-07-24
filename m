Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D881E5B6F
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378083; cv=none; b=DAqIZ7opDePdtTe+94oR6zjmhR6TECQz2S87r/PqiQbz5b73xwdeNNGrAjZvFYEOexcCZhC+9K7N6HwKFviYsbGRFVNSi2BiFe7In0dl4OdNV2YoYChC8KqHzG49urwClp2JtfhakYdV5NxNvwVzTNreawtxb4qIUARlF5UD8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378083; c=relaxed/simple;
	bh=BTCaxJnzgHe/ii3bRXfzl+I9DIouw+5i1x7rKy31PhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+TDLMVRiEykTdlB74ZMF7LVfdcGuacs2/BjVIrFjy1n+M3/s3r+sb6+3sB5YjV5xxrPxK0G1/zIERqMDQQfC0wJpC8raGnrwfaHPJ/8nFec0djWzaznVF4lBWTZVfAg4mnkjzuwTn3mj9o3GSogCNpyJ1HEebZFnTrl86mb+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pqb9K1X1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SaFJI5at; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pqb9K1X1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SaFJI5at"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 743157A00AA;
	Thu, 24 Jul 2025 13:28:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Jul 2025 13:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753378080; x=1753464480; bh=e+xeIO56ky
	BF/kZEAnhSU5XUQhQFoJ0j/W0NY3LmPAM=; b=Pqb9K1X1WlIoqTNIdqeNawZyqa
	fP9DmAvFvRpEATX0W2DFSK8/R57iFpbmrp+NHD5lAdgWSWzzFKOuKReBGK3uIFXx
	/hepxUo/5KOrjJ4kQtxs0rsDQLTboBKftb+VytZEEwQAts2CJHpEWM9G8ncaQjSP
	0RCGLfAK0kpwfkMi3kKOL3S15+vo0vf3alvYhgg4HBtGP1fwe0hkrgn53TGcKajx
	E5mEFsSiZvZ1Xvlm5iNV+R1phPTY0l12FfX2aw4tcRs5L/iNJfJIVg0fMFwxxl3K
	7bX5eRlvu3l4DWqcJ3STcEOmbRKujXvByRv+qkH9h+IWHXi2qnfGWYUPrHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753378080; x=1753464480; bh=e+xeIO56kyBF/kZEAnhSU5XUQhQFoJ0j/W0
	NY3LmPAM=; b=SaFJI5atYkqhhIZ93GdiWuRF7YLdMXRzKfK3+4EhFyS0Ek3usk8
	omR5DxINhXmMJGe911NxDKTw1ZysXQ+yrvf6A2ix42tIeIK3uMEvX7hs24blm1VY
	Q5T6y8bDfVWTEKXi2uTXL9/syWhscwWQKU+Br11QUgPCv+rp43oBKXM/6ug7oikv
	IyySZlkEG38ifnmseqtgHjI+qFPQhfpC2+x56Ka320iFIBPsp5Z/dsVr7uZOg6iT
	GXZRJam7QVKk1SZShKo3+wO7zHSFJ7qNQFYounPqD1Loup0HFq01wsHP3v09cJqD
	95afwbBxSaDJNNeWuZtL/5Z6kIrOLxIOaIg==
X-ME-Sender: <xms:IG2CaNaaX_qBI-tH2uC58Ov-h96cZrw0YWqlv900-J1KJwjVCy04KQ>
    <xme:IG2CaHo5lwU1ytkxSAGdtbZH8lVH6ScQegZIGi9PyTE_ZEixhWF8cNoDOM_hlWQiz
    4nVDF6NAYjV0zt_gA>
X-ME-Received: <xmr:IG2CaJaYSfD3BLYC8z5Wvs2eHQrebQL_sAPTyhdOxLDCr13OiAT0uHLRdwAkMFnWeKiMgejE5g8G0qdCWkBVvgDEofiuLq5LZCosfxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IG2CaHQ3Fpe9yseAR8FzpM5-5URl0D7Ut_JjFMK4bDkobRPg1M7o8w>
    <xmx:IG2CaI5VyQtKewBQ8_GRPKLVpUhDzG3MT3lshs7tfpLid75KQSg5mg>
    <xmx:IG2CaEwLUliQCiMrknp9rF_0WIvRn3sX8Kyy6_TryPq8gYran0EZvw>
    <xmx:IG2CaPTXUwaY5fDqf1FoMhr76Z0Ay_Z9alrGJsm59f_WOkwkGkkXTg>
    <xmx:IG2CaLXxkvGP6hBdxZYSOwiqo0chVH-wkccnM-60HDDtjy1siWFaQYmW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 13:27:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] for-each-ref: fix documentation argument ordering
In-Reply-To: <20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com> (Karthik
	Nayak's message of "Thu, 24 Jul 2025 10:14:43 +0200")
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
	<20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com>
Date: Thu, 24 Jul 2025 10:27:58 -0700
Message-ID: <xmqqy0sdh529.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Improve the 'git-for-each-ref(1)' documentation with two corrections:
>
> 1. Add parentheses around `--exclude=<pattern>` to indicate this option
>    can be repeated as a complete unit.
>
> 2. Move `--stdin | <pattern> ...` to the end, after all flags, since
>    `<pattern>` is a positional argument that should appear last in the
>    argument list.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.adoc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index ae61ba642a..a170de4209 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -10,11 +10,11 @@ SYNOPSIS
>  [verse]
>  'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [(--sort=<key>)...] [--format=<format>]
> -		   [--include-root-refs] [ --stdin | <pattern>... ]
> -		   [--points-at=<object>]
> +		   [--include-root-refs] [--points-at=<object>]
>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>  		   [--contains[=<object>]] [--no-contains[=<object>]]
> -		   [--exclude=<pattern> ...] [--start-after=<marker>]
> +		   [(--exclude=<pattern>)...] [--start-after=<marker>]
> +           [ --stdin | <pattern>... ]

Shouldn't the last line align with the others?
