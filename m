Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F031EF38E
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522157; cv=none; b=jXGwew+4oVowogeDeR7+WymD18FxB/qlFccYQz9/wSsBKX60J9MxEuHz/+OW5w8M4x3UUtXJ0E+NzBRN3xWth2iUyKoaBPNEBOQvZzA3Qb8Puf0ZswOAi8Poatcba0U0u1ncY2FsYa3nSFjPeSFU7Lh2sA0ROmEWry7GclGairw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522157; c=relaxed/simple;
	bh=W+cqG6WofB+fWRue65AsJhYhaX8srBRwax+hDPSlFGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgTK5j+lRa0Hz9hkwAMo11HKn3Cogbh6SLKIRQQpTyPKh+pN3HMkGIVFn5mCgxaPepHaE+pNb5bph3a4AbBNp3tLeIE93RHkHWCQaH9/tJM+PMtX6x5ifSfg77ShV+od16Y73vv2rW67PkVZwiH8tILCRvYoRE/H5Ao3Piou/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KmZ++MMl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NxrcXeW6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KmZ++MMl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NxrcXeW6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84C307A01F0;
	Thu,  3 Jul 2025 01:55:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 03 Jul 2025 01:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751522154; x=1751608554; bh=Rdgk4yKnSA
	FT5DYTFS8m9XsNzJrKHjqL9RoNMQlQljU=; b=KmZ++MMlWF0bn4yL5CuoRAiLvl
	Wy4IlsbrBttqIe58HiN7d4IhiIDCzj6eOESw/zIG2tA2Kbtm7aJW8L5KBbIl5d08
	plI9TLfTwDGG25S3ZcEAZs7xPwz1ziPxwrOW/2eICOm47E1sHNYSzx5bNvqz/SOG
	TXLx+2bykPWQ8p+xgitvnHBMKPiQdE7p7hefY9+U2jt0Uhk7BubxZTIpSxaGJ3Tg
	INAncHU8H37/0MxabfJnZekvCi+1y/WQsw88wgKdpagT1CZU4wEvfmZakHGnavpp
	4X0hjxkOniCn6zLpV316uHwvIIkckkeB0sHnu9UiV2Bw7lOXhT0cuotqtymQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751522154; x=1751608554; bh=Rdgk4yKnSAFT5DYTFS8m9XsNzJrKHjqL9Ro
	NMQlQljU=; b=NxrcXeW6/NSrqWPpfdcxtUHgm65kQ7eXrITmj9HqZAofmx23NT1
	b7WC36Pe+ZQqZjWlN51yHphLfOREInN/fJeg1IUxm9rRq7BbzmmoEFKX43uJzIV0
	gS3bcL17nTgQEQQASU4DkDZVcJUlbluX4hT7h1WAmjGsNbTsu9VUwYkfFIH7E1Wv
	Bzq8ZiUxd73Hkpwvg4DWfUlf44/9AVAucXG1zx4/LLfzfCZwdEzmOfu0gdfd0nA6
	ReA8q+yYFnfhDLWYFLKFGmIsExZrr+7wyHytzwWbIvDWh1jh4gbe+lTcCEZol+v5
	yZFRTYxKIxzgeCutmF6rcZNRrKTTJb2WYMA==
X-ME-Sender: <xms:ahtmaMJHJTsqGQ6TVML6XFEvbkTXt9mLQyxpx3hG4xL_jbvLkseeFw>
    <xme:ahtmaML1JVhgdLXW9Mw4-5AvoUaNTZT09RKOdTqYbERXlKqRRHgjZo2_ZdrgXyd-3
    W4fG2Fe1KGBizuZ3A>
X-ME-Received: <xmr:ahtmaMtHLmW328NPdJ8FGAcIujVPhutm17_OqEi9i8TiFQhl7GI3uF--MU-B9D-Ye5I5nSa_owk6KfMDiBueWhCHcHCR7sLhCxrECoqBrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ahtmaJZfPCfBcdivDthdzyX9f8IIMMDRGH_IWddKtqFyhj7VyJRYOA>
    <xmx:ahtmaDY7IWElIp8cMlKjn3e1fIxvOhBXZvU73dojSHoYqC8VxTQ_dA>
    <xmx:ahtmaFBWByF-UiolrGTORPPuvMGY-QTij02pY-MF4AyFpWQVkziw2g>
    <xmx:ahtmaJYxCQy5IwhMCX9wguS5sgpuTeYsoX5xVyDCZrGRq2ZaqTcj6w>
    <xmx:ahtmaK1JVhwKQLwb3f9n4aoBUrf8YazF2z5jj7jVpKBlQQ-kSP7YgQO3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 01:55:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08210c8a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 05:55:52 +0000 (UTC)
Date: Thu, 3 Jul 2025 07:55:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] for-each-ref: introduce a '--skip-until' option
Message-ID: <aGYbZcXP2voT2IYE@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250701-306-git-for-each-ref-pagination-v1-4-4f0ae7c0688f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-4-4f0ae7c0688f@gmail.com>

On Tue, Jul 01, 2025 at 05:03:30PM +0200, Karthik Nayak wrote:
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index 5ef89fc0fe..4bf7c66b8c 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -14,7 +14,7 @@ SYNOPSIS
>  		   [--points-at=<object>]
>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>  		   [--contains[=<object>]] [--no-contains[=<object>]]
> -		   [--exclude=<pattern> ...]
> +		   [--exclude=<pattern> ...] [--skip-until=<pattern>]
>  
>  DESCRIPTION
>  -----------
> @@ -108,6 +108,10 @@ TAB %(refname)`.
>  --include-root-refs::
>  	List root refs (HEAD and pseudorefs) apart from regular refs.
>  
> +--skip-until::
> +    Skip references up to the specified pattern. Cannot be used with
> +    general pattern matching.
> +
>  FIELD NAMES
>  -----------
>  

Is it "up to and including the specified pattern" or "up to but
excluding the specified pattern"? It would help to make it very explicit
whether the pattern itself would be yielded or not.

> diff --git a/ref-filter.c b/ref-filter.c
> index 7a274633cf..9d0255d5db 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2714,20 +2716,28 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>  		 * so just return everything and let the caller
>  		 * sort it out.
>  		 */
> -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
> -						"", NULL, cb, cb_data);
> +		goto non_prefix_iter;
>  	}
>  
>  	if (!filter->name_patterns[0]) {
>  		/* no patterns; we have to look at everything */
> -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
> -						 "", filter->exclude.v, cb, cb_data);
> +		goto non_prefix_iter;
>  	}
>  
>  	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
>  						 NULL, filter->name_patterns,
>  						 filter->exclude.v,
>  						 cb, cb_data);
> +
> +non_prefix_iter:
> +	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
> +				       NULL, 0, flags);
> +	if (filter->seek)
> +		ret = ref_iterator_seek(iter, filter->seek, 0);

Hm, this interface is somewhat weird now, as we have a split in what the
prefix-string meeks when creating the iterator and seeking it. I think
we should align those two functions.

> +	if (ret)
> +		return ret;
> +
> +	return do_for_each_ref_iterator(iter, cb, cb_data);
>  }
>  
>  /*
> @@ -3200,6 +3210,8 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
>  	if (!filter->kind)
>  		die("filter_refs: invalid type");
>  	else {

The `if` branch now needs to be updated to have curly braces, as well.

Patrick
