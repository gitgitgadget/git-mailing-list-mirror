Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDD24677B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693948; cv=none; b=lCX4pQgLAZLGAOD94QyUVBQ8jE2pbBGJr/ZAfJFgdgN2+HD8Jg7KBX3xK7rYBDwSUWAYvSF7jsvw01Qg9dQkCFTzSjipSefvVfn2eRvS4nnGsEAxZiKj3aRDc2MHGBBp6dAI7MTOIp6jXv8jT+iyEfbZbsyOHGhylcsfBOuu5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693948; c=relaxed/simple;
	bh=4Xo4wcyQXs0Nl1kcFrc7Lx5naZeMjg6FDy9zjB3jTUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na8pl2Ru0MKjvWunpm32qUhpc9KQ4utYHsiBEVq5VqiqByBhA8aKHsWmrtVbgKqEdt/0BzC0HNFiaHQAP+864va5V28kjWuxFRLTP/1Taz9PwZf2jCk2SqHZfZnBGHVnc440ubcdYRretNn2Io5J0o3SZBZhx9pu8JsnkYQgi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JxKBEHPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gXLpaGWW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JxKBEHPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gXLpaGWW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5EF97A00D8;
	Fri, 10 Jul 2026 10:32:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jul 2026 10:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783693945; x=1783780345; bh=f3yTbOxol0
	1DnoC9V+jiokEk5/v+h+yU8LVIiLOJqjk=; b=JxKBEHPEwDmlXu0ANU1x31pZrW
	4s7B4gfVJTyy2onv95pUnGVWU9aUZW2TjCBYK/vl6qK1Jm0/6Tfy64SymQfAhcYi
	OMqcMWrS6SwgZfZLSu46acR8aguQZRAYBPK43poby6UNo2jC1I88sZVKsoWtW7hK
	WmjIBl+cQ3sKb/wyqH6SIHOmTmJt2uRIiwS3UBkehE08VdDcRTbuu+RShy20lc/c
	bkx4j6z6uepFFvN6eEToiB5HYomL02as1XGZU6s9LyarhDHvUOylHlvxBkuu50Ag
	mVH4HgeIPlfw81MGBdJ2pKP+exsDgpj6nI8UjdUU0BuWtub1ILW4v/5lIWdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783693945; x=1783780345; bh=f3yTbOxol01DnoC9V+jiokEk5/v+h+yU8LV
	IiLOJqjk=; b=gXLpaGWWE1glGvNM976jl56w/WnPmf4luEK2Pl0ub7JjihcTMgx
	tq4vneAWGdF52eaQk9Z27U6gphs6kYq3g2gAvIEOeDaAId4vn3wOCMtuHKrgblz3
	WZ2dtUA94xZRAAF+YZFuCEsvfHKGYsZAwbIKS8k51bSFR9c5wsk5/ZZfndMk0J0D
	GqS3usET7unFi62Xefeu+K3xEAedugVLd5IOk0687Td743ph9wv75263SKzdIJib
	fMljKrVmedvsik5EDGRgYTIJFSQwkTqijcG/rnetVAp6UQ88W/SHXRDT/jlfwW+G
	MpMbytx4FlWGkuLT9lDvESZLX+QFGzjlPjA==
X-ME-Sender: <xms:eQJRalE-r-l9qAhCMbu3ZxMjTIw5vYPetusH49j8UrOcBJ1gLllVKw>
    <xme:eQJRahxGGFT84Z3DA7yu6GS3DesFUsBBqcIFUC5Jqe2Us_I6Xieq_6a_Pao4mDkKH
    3Ntqhhzz6Ie2emlAuuAfGi3WmxpECIaSh3Ag3JFiw0mda3HFwPKEg>
X-ME-Received: <xmr:eQJRakgKobvn43hsYd2nFOD8LK-806ohsPQ5qn6N4x4gMIipM5Q2Pdc7GCkg7OexA_IpLaeOytlWDC4BStvAXcCyWqzfyu79SDP7p-rEyxJddA>
X-ME-Proxy-Cause: dmFkZTFCTSInU9TjQkwY+oTjXSNvmBnuk27x+aCgrwPH99kDaxTqfj7ZX5LGs1ExbItQtp
    2pGjufr1YL29kfGKGiYg8JVotijWxN7QHWUg7cxHj4jyAX8kOuq2U9MPLpIXO/Fy4f5nQX
    A4eN52w+nMP7E0gkcmYtbtuXOprBXTdzbfCHu0WVEZelVfgaye7dmC7qQ62JXINszrU04k
    mKSTlG9t3nEO5QY2bH00UEQyStaIVlxVuQuT0T5Aa/J8ioWHZFIWInWd+BqijhGkic5NVx
    3bHq5QbPgN5sQfTMilfNm8m5lhjUEJPvTRjUzgbicUqC+QCrSOum+2nCM8BKotoeqGeKe5
    EJD6ydxUj1qx9U4AEHd0ZOhUlReFyX1SXBuzY8+1GeeWc4PIg/l97x6rxJCbsUS1J47hgl
    fUs/s10XQlAB1BAGLVTJKlaXcLk3Ql4VqvPECzLfFXS1/YiOA33NZo0KH/pq1v6HFvEPMD
    4pgagjrN9SsWKPDEO4n7417xrLK8gMDUhQF9PSF1Kqheka1TeFHW2ab/Mze2BcN5fkLU5g
    8UGKYB0c3ovvuLDDIIs2I4U+/5tZ52OTRaQLXAoGjZLUYyaJq5HXdmZd3PUG/mrORZmXXp
    EaIiI9BgzKV4+0KfKIiW5/glq+g17B1TYr0BPNMQmKMQouppA3OEommSlXNw
X-ME-Proxy: <xmx:eQJRakyU-GXqne3L45npCnMWYnLT3poV4iOlxJ47Xq28EqBiz2PMqQ>
    <xmx:eQJRavLnhMgtMjYfCI92kD2lYhoik7LyDYP3zqQ7DK2OIr2QHcBobg>
    <xmx:eQJRajSvo4JevKl6qWPbLlVz5zFfHdAMmDKMAZo6_eraPiaCFbm38Q>
    <xmx:eQJRavpa3bi-IdbSswMY3a4_E_7OJFM74VpVE946dkegqU3g1zfT8w>
    <xmx:eQJRanCL2sM30CoERTZcvvtO6EpL7Ie_g4dgotAY_00U7OBdBY8lk4yU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 10:32:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 905328db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 14:32:21 +0000 (UTC)
Date: Fri, 10 Jul 2026 16:32:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3 2/2] reftable: fix quadratic behavior in the presence
 of tombstones
Message-ID: <alECc90WZ9RPqMaA@pks.im>
References: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
 <pull.2166.v3.git.1783679767.gitgitgadget@gmail.com>
 <4fdcec84406431d56b7a7e593fd8e843c3b1ad52.1783679767.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdcec84406431d56b7a7e593fd8e843c3b1ad52.1783679767.git.gitgitgadget@gmail.com>

On Fri, Jul 10, 2026 at 10:36:07AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> When many tombstones are present in a reftable, operations that need
> to look up or iterate over refs exhibit quadratic behavior.  With
> 8000 refs deleted and re-created, update-ref takes ~15s, quadrupling
> for each doubling of input size.
> 
> The root cause is the merged iterator's suppress_deletions flag.
> When set, merged_iter_next_void() silently consumes tombstone records
> in a tight internal loop before returning to the caller.  This
> prevents higher-level code from checking iteration bounds (such as
> prefix or refname comparisons) until after all tombstones have been
> scanned.
> 
> This affects any code path that seeks into a range containing
> tombstones, including:
> 
>  - refs_verify_refnames_available() seeks to "refs/tags/foo-1/" to
>    check for D/F conflicts and must scan through all subsequent
>    tombstones before the caller can see that they are past the prefix
>    of interest.
> 
>  - reftable_backend_read_ref() seeks to a specific refname and must
>    scan through all subsequent tombstones before returning "not
>    found", because the merged iterator skips the matching tombstone
>    and searches for the next live record.
> 
> Fix this by making suppress_deletions configurable via
> reftable_stack_options instead of unconditionally enabling it.  Git
> no longer sets the flag, so tombstones are now returned to callers in
> the reftable backend, which skip them after their existing bounds
> checks.  This allows iteration to terminate as soon as a tombstone
> past the relevant bound is encountered.
> 
> Downstream users of the reftable library (e.g. libgit2) can still
> enable suppress_deletions through the stack options to retain the
> previous behavior.
> 
> This also requires adding deletion checks to the log iteration paths,
> since suppress_deletions applied to both ref and log iterators.

Nit: s/applied/applies/

> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index 11f9963f4f..5d22d84e80 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -42,6 +42,8 @@ struct reftable_stack_options {
>  	 */
>  	void (*on_reload)(void *payload);
>  	void *on_reload_payload;
> +
> +	int suppress_deletions;
>  };

A comment would've been nice, but I don't think this warrants a reroll.

> diff --git a/reftable/stack.c b/reftable/stack.c
> index ab12926708..caaedf24d6 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -337,7 +337,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
>  	/* Update the stack to point to the new tables. */
>  	if (st->merged)
>  		reftable_merged_table_free(st->merged);
> -	new_merged->suppress_deletions = 1;
> +	new_merged->suppress_deletions = st->opts.suppress_deletions;
>  	st->merged = new_merged;

Yup, this looks good to me.

Thanks!

Patrick
