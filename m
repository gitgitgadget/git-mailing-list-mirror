Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C71B423C
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752338; cv=none; b=s5k5DSXAy9hkALx5B2Xg9myMX25npTvv+EuwgxMR/VQ6U3EiPTk/GgxSZ9nbW1mGjAgPJuGtLh6pkCihR86XCxLyigcy9/qQbcl6mC5B9zW9drJU8qCJ7vbgcj/K+eZXLyhotvX/LtBgZg0cy4uTzv/17yBvYWCdxt1/ugV+aQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752338; c=relaxed/simple;
	bh=wZDno6jEY/z7jN/yoqgUwZpxQSMO3ne2+02kQsb0BHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KbjCfgJ/PLGS6JMhWTIVjElfb1XlZQAxqT+anObEyvLOhUIBoWo/TWRkA7Mwm0Zpg9+XVZB5BNtG+/xPfw1py6FMerxVTiw58o62cggYpsOeMTsMHdfCLuykV2WjJpiTCpUTPCvHFdDTczJaBB3wQOnLyaq2z2eTExwP1oABBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gIupFJf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQ8cXPYn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gIupFJf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQ8cXPYn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3782814000DF;
	Wed, 24 Sep 2025 18:18:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 18:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758752335; x=1758838735; bh=L6ftJV/3Rh
	9zVIq2/+gncuUwtSgyeBO8v0jPVT3s8Vk=; b=gIupFJf8wlNFFo9bst1F8uRlSP
	h/IMRF+RXz7JVla4X6vSH1pHK8zGwPwj7BkPfRWPV0bMkjj3WLm+4P2FgojOxRUN
	/0gUID4MRvc/PLYI1iHUYkkMHdPsGsFHuwBiK7KVZp3KTw/VVzoQQcKKzpNBEu7f
	+hgQ1bFq/p8kP0+/kpOi1wAAur2dhU373C5vYOWNVZleM61vjOhOV97SOsafZvc+
	rU45XqHU9c0dLme3sHoMx6h8W6aLxl4GvSLwFPAQHc04GJarydrQ3t2AL5HdCAOS
	rNYU8sR9QHTyURU9P37UGlmzIRG/3G/5Y8SIpyzIQlIqtx6nLBCCk1pkUC/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758752335; x=1758838735; bh=L6ftJV/3Rh9zVIq2/+gncuUwtSgyeBO8v0j
	PVT3s8Vk=; b=DQ8cXPYnBB7XnkStjkp7CeuSvffoK1Hdrx5uojshg39DpC7KNOe
	rcyuD8UKVuaKLYPwyK+v0L7o4mOks1/r7Zg5w2ZKfTHmn37aLzP/9OWjAGzbuJlN
	mXiqaW4Y5YDax7OHzV7TqXB0WE7xaSPBHnuKuj1H8t8jlyRASv6gn9mvdclN3lZv
	vTo2Npl/MVqpFq3nrBgOKFdRuqIBWyt0WtqumvI70LpmC5oVmhnDiIrGIi0qwYe/
	qh6DlU9V5dmtoVBWoPEZNURTh/axDmjje1MHOvvjOBj3n7NWHvdftSEbI7dvOD6j
	HjoL9dQrUEil8nd+Fh3CcEGh6BlGh5q6MLg==
X-ME-Sender: <xms:Tm7UaB6Lqt9ryczSyLjLpo9gNhsaX9ICcvW_qnyAQ7d4bjPZTshE6g>
    <xme:Tm7UaF7wcBv5W87caapV-MCnGyLp4sMb_G5r2jKxGjpX0c8Zcnh5EmC6W_ulUdL2r
    CQsqj3-3WUMA6n-hc2DCp8W6mJEOKOzeWI-9bujkWzEHaQwiaRp>
X-ME-Received: <xmr:Tm7UaNfZnK83EoguGNdvDdAbSYsAML0ChOyRvQFM4CLj4qJyMrPqK5W3jhnJE4V16vILdMPZarq1pLLgAJ3j_cTmBHFVbc3nZRuL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtg
    homhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Tm7UaJD4087cu8e78bWbBDmqgHTzedJBseTsyKUtL2vcRUGo3XBK0A>
    <xmx:Tm7UaA9rkzNLhEPqo1steIopFx0CIjdwOzga8FNdtalV9ub1QES09Q>
    <xmx:Tm7UaEJdXmop34KwEeUvGhXufX10b_pUaLWGMB1Sskij6C9CC6Bjmw>
    <xmx:Tm7UaJgUus6ndKODb-Gy1few-lWNkWrsV5aZJNs3Rml0086cRBP4rw>
    <xmx:T27UaJpOc1KAUEKfzFLdHe-5MOPHmkZKXQQsLHrW5Y4Hvj-3Pv_e-NNm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 18:18:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
In-Reply-To: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
	(Jacob Keller's message of "Wed, 24 Sep 2025 13:57:15 -0700")
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
Date: Wed, 24 Sep 2025 15:18:53 -0700
Message-ID: <xmqqa52jjxyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/diff-no-index.c b/diff-no-index.c
> index 88ae4cee56ba..c70f82b80559 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> ...
> @@ -346,7 +355,8 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
>  		  int implicit_no_index, int argc, const char **argv)
>  {
>  	struct pathspec pathspec, *ps = NULL;
> -	int i, no_index, skip1 = 0, skip2 = 0;
> +	struct strbuf ps_match1 = STRBUF_INIT, ps_match2 = STRBUF_INIT;
> +	int i, no_index;
>  	int ret = 1;
>  	const char *paths[2];
>  	char *to_free[ARRAY_SIZE(paths)] = { 0 };
> @@ -387,11 +397,6 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
>  			       NULL, &argv[2]);
>  		if (pathspec.nr)
>  			ps = &pathspec;
> -
> -		skip1 = strlen(paths[0]);
> -		skip1 += paths[0][skip1] == '/' ? 0 : 1;
> -		skip2 = strlen(paths[1]);
> -		skip2 += paths[1][skip2] == '/' ? 0 : 1;
>  	} else if (argc > 2) {
>  		warning(_("Limiting comparison with pathspecs is only "
>  			  "supported if both paths are directories."));
> @@ -415,7 +420,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
>  	revs->diffopt.flags.exit_with_status = 1;
>  
>  	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0, ps,
> -		       skip1, skip2))
> +		       &ps_match1, &ps_match2))

Inside queue_diff() that makes recursive calls to itself, lenthens
these strbuf to hold longer paths while using setlen when it wants
to trim the tail end of the paths.

So it is likely that ps_match.buf would never become NUL even when
ps_match.len goes down to 0 after the recursion and queue_diff()
uses setlen to trim the string back to what was originally in there.

Hence, I think the clean-up code of this function this goto ...

>  		goto out;

... jumps to would need

	strbuf_release(&ps_match1);
	strbuf_release(&ps_match2);

added after that "out:" label?

If we run this test with leak sanitizer, wouldn't it find leak in
these (I haven't tried it myself---I just am speculating)?

> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 01db9243abfe..e0ea437685b0 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -322,6 +322,22 @@ test_expect_success 'diff --no-index with pathspec' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'diff --no-index first path ending in slash with pathspec' '
> +	test_expect_code 1 git diff --name-status --no-index a/ b 1 >actual &&
> +	cat >expect <<-EOF &&
> +	D	a/1
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --no-index second path ending in slash with pathspec' '
> +	test_expect_code 1 git diff --name-status --no-index a b/ 1 >actual &&
> +	cat >expect <<-EOF &&
> +	D	a/1
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'diff --no-index with pathspec no matches' '
>  	test_expect_code 0 git diff --name-status --no-index a b missing
>  '
