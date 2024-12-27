Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F11F12E8
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735295661; cv=none; b=dcZ6KZWHJQDUbNwA4Aq3RizH32B0/pdLi/qhbUUJRnJ+z/WD0Kef5MV0I8oBen+QJhZ/lPsm/DWyUyE7k/5mWnH59q6tLvyYYs7xH2wG7NgCMDXLPXkuAf1vNK6VCIqr6UdCt1vcnSFApcrtozseHViScxqoz2aUozaFutD36XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735295661; c=relaxed/simple;
	bh=T7Ccxcg+dca3w//U6d8jk053522zSCwmYnhuSccrUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPGyz7ICx5c0vIUOErrXLnKskf7BuhmDZqRqCwk77r/t2WP+TdwfqyziA1+gtI1+ap8RyrSJbKXlUtKjWuziwUPEJl2KwWVIu7M1eTe6UmuI8uSlRvTXs47mXiIRcu4lLiaBWyN5FNndqbmYQ9Kwn20DP2rt3eW9NlbPYIq2U+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Km+Ev07j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EoEZq5y4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Km+Ev07j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EoEZq5y4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E7A111400D8;
	Fri, 27 Dec 2024 05:34:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 27 Dec 2024 05:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735295658;
	 x=1735382058; bh=MWnXC/gHFaeGp4sqvO2t8xvkeNu5P1nddbue7O0OsGE=; b=
	Km+Ev07jD9H3cW4L7siMRO18spnwjjSxwlQ+PQFnQD+NAYPt/dRBfOdOSQv6ZAS3
	r+fAmWRIdcnv9vj5Rc+qBfflPe+RARlVoFJLNbnXN7KK43XnUrPU2hfYeqIcEu3H
	Mm4GmD6i9tMny45IQO12ZfqdIRjWlhnDEeSVbp/HA+hAfGGiEEw+KXDiTWW0yE1P
	/G9yEcbDO5K0vEFxjDwUoRYl+EzdeZ3rKfS7XyqaF7i5qRKjatQqyENFZhZI/hkz
	YPYaBO4G2og/zBmbVKKJEnuaf5VLCP9evXsJYGw3iA+NH6w28ZuClVPMhko+Keqw
	oWvyiVoXkeS5LxXlDTm/yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735295658; x=
	1735382058; bh=MWnXC/gHFaeGp4sqvO2t8xvkeNu5P1nddbue7O0OsGE=; b=E
	oEZq5y4tJ/optvQ3uHeE3n2lnl91A7IYo5OQBSPznHNZ2Pg3M6agQtj3DIK9k9by
	DJuhNiTt8BSNjCrqaK2HrHbDmXYL/a6RWD6WcUphfj4CTMbGm5hWAfcn5HwLCr82
	CQN5kA2Dfcnj4OVTcDkXQbl7joLUUNl4OxzcGpswjqHcpOSZZbQKWcNKMBbL4ZzP
	qnlSqcQd9xf8Qh3A/1llPV0ihHtk9msmZ832+JiaIW38j8D9X4tDvLXwVcVsAWir
	mMBIwg26luXUcwjPJA9ZacizGl3fMndMdPiZUdJLrD19nvqJ6pdnhqeD795VuWPp
	1yUACUANzZOF8Xi6oXJ2w==
X-ME-Sender: <xms:qoJuZw55cC_Yffr4nWu2jw4omFcKkpRWbCdFcdB_DdkHcMzFHZSCMQ>
    <xme:qoJuZx47hEQ2YSjSTUsjJZV6nZV4Sc5MtZuvGwGuNWSmhDF7AQiAKYgAx10xPK3rH
    fuDlS8TLDS9EGcZng>
X-ME-Received: <xmr:qoJuZ_d3cnTMp5jP1R-e49XTUWQw0Opxg3JYV0ruRGNe8pD_tLIWRynTkiY2EQTlcUBm5TiKvLcJ-5Co04Ml2-SpBd3Of8GhYGUIyyv8BDCTEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:qoJuZ1JqHHs9TlJpck6lkfJ3-WY_mVsjCwInYUjXYojxFNJDjlcz1w>
    <xmx:qoJuZ0K1ek4lxFSNVXrG3OuR9s6P84ynASnqpZ2YV0jTLuptYjIcCQ>
    <xmx:qoJuZ2wV136xUxrXBuNgp5oQigudZtfHeN83mm5eOWaxBqgOfWn2xg>
    <xmx:qoJuZ4K4ABkEjJSoY6AslhLUMEK1MxFlyL0hgvEloW9sO3BxIF9iTg>
    <xmx:qoJuZ7VoukEBciY5g_irDxIWzXLA95MeJtVE-Zbx0wwq4OrUCR5kCVhd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:34:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01b0a1ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:32:14 +0000 (UTC)
Date: Fri, 27 Dec 2024 11:33:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] reftable: fix allocation count on realloc error
Message-ID: <Z26ClnvVH1cg3CGQ@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <33bbacc7-1727-4efd-9cbf-3c9abfa94d8c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33bbacc7-1727-4efd-9cbf-3c9abfa94d8c@web.de>

On Wed, Dec 25, 2024 at 07:38:35PM +0100, René Scharfe wrote:
> When realloc(3) fails, it returns NULL and keeps the original allocation
> intact.  REFTABLE_ALLOC_GROW overwrites both the original pointer and
> the allocation count variable in that case, simultaneously leaking the
> original allocation and misrepresenting the number of storable items.
> 
> parse_names() avoids the leak by keeping the original pointer if
> reallocation fails, but still increase the allocation count in such a
> case as if it succeeded.  That's OK, because the error handling code
> just frees everything and doesn't look at names_cap anymore.
> 
> reftable_buf_add() does the same, but here it is a problem as it leaves
> the reftable_buf in a broken state, with ->alloc being roughly twice as
> big as the actually allocated memory, allowing out-of-bounds writes in
> subsequent calls.
> 
> Reimplement REFTABLE_ALLOC_GROW to avoid leaks, keep allocation counts
> in sync and still signal failures to callers while avoiding code
> duplication in callers.  Make it an expression that evaluates to 0 if no
> reallocation is needed or it succeeded and 1 on failure while keeping
> the original pointer and allocation counter values.
> 
> Adjust REFTABLE_ALLOC_GROW_OR_NULL to the new calling convention for
> REFTABLE_ALLOC_GROW, but keep its support for non-size_t alloc variables
> for now.

Okay, this change goes into the direction I was wondering about with the
preceding commit, good.

> diff --git a/reftable/basics.h b/reftable/basics.h
> index 259f4c274c..fa5d75868b 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -120,22 +120,35 @@ char *reftable_strdup(const char *str);
>  #define REFTABLE_ALLOC_ARRAY(x, alloc) (x) = reftable_malloc(st_mult(sizeof(*(x)), (alloc)))
>  #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
>  #define REFTABLE_REALLOC_ARRAY(x, alloc) (x) = reftable_realloc((x), st_mult(sizeof(*(x)), (alloc)))
> -#define REFTABLE_ALLOC_GROW(x, nr, alloc) \
> -	do { \
> -		if ((nr) > alloc) { \
> -			alloc = 2 * (alloc) + 1; \
> -			if (alloc < (nr)) \
> -				alloc = (nr); \
> -			REFTABLE_REALLOC_ARRAY(x, alloc); \
> -		} \
> -	} while (0)
> +
> +static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
> +					size_t *allocp)
> +{
> +	void *new_p;
> +	size_t alloc = *allocp * 2 + 1;
> +	if (alloc < nelem)
> +		alloc = nelem;
> +	new_p = reftable_realloc(p, st_mult(elsize, alloc));
> +	if (!new_p)
> +		return p;
> +	*allocp = alloc;
> +	return new_p;
> +}
> +
> +#define REFTABLE_ALLOC_GROW(x, nr, alloc) ( \
> +	(nr) > (alloc) && ( \
> +		(x) = reftable_alloc_grow((x), (nr), sizeof(*(x)), &(alloc)), \
> +		(nr) > (alloc) \
> +	) \
> +)

Do we even need this macro? I don't really think it serves much of a
purpose anymore.

Patrick
