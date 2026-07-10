Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17743C10B5
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667336; cv=none; b=UlARFwmO5AVMmFveiRCMd2SrEAS687XYdowzvOwLnJucx+5hqbu+MaVJPcuwbIuSE3YxT9bQxUw//PtA8HksY+zwrBDnj1ecc026Gk3KS7aBPmfLIfCoUJaGJlbWB6fgBoECoMqFc63LSEhA4T+8k/ntchiN2I9Q45U3mzKZVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667336; c=relaxed/simple;
	bh=hf5QOstjyYb+fFrMQRYXNR2HtPWHG1MtIdkJUeSL+aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUGlLrWyDFo+Qphb+6vYZXKW5aeLko2vClKCUDRsijRYb6wNL+x3SHZywMbRGumyxGSJ6JCrv5BtiX7cZN+19Wd7/IsNalaX6IPV2r80g1Q4BLoanC30+qzdCtdv0JyEe30TmFFaQok2A3tju/lXa7XR/mPYBeHeKq1HQTrLJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iSueJY0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kop1Hmp4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iSueJY0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kop1Hmp4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EDAA0EC0125;
	Fri, 10 Jul 2026 03:08:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jul 2026 03:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783667333; x=1783753733; bh=O0mIMcxBbJ
	gCzmxn6HHtNxpG5N0AOmv+xEAmg4JXu3w=; b=iSueJY0zoy/Ex2+FC7siSsImlf
	oZUkdJ6DaU8ig3WUuuFQQZFct67Iw+LABL1oWzUt+Ph2sMcG8aSMFjJQIpMszBZE
	t9ZfUKUEXIQHCSKM4SQBPbC+4Gp+LbpW0EW36wWnjD1F+HIU0yrMce+LjjF13d/E
	ZGur2cFjIixuYFZPpIa1aYWg2Q0Enl/wyYc8E5e41QC5BHJBnFwclRqTnp+JHA6h
	J2wU+cqnvLYBLP4JJsWjlFpKWg2GAjEwgLFYqfsh9ZRmy3nAZbTwjeWgAlv3UMpg
	FeHpDuzbTMAA67xeWOM6VVqJGN/5Pd0KvQQxzWGpXCS6jH/M7Qb2/wjRO0cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783667333; x=1783753733; bh=O0mIMcxBbJgCzmxn6HHtNxpG5N0AOmv+xEA
	mg4JXu3w=; b=kop1Hmp4ytBsLzQCfgM49fHZypdEvrOL7+oKhR2nnD/88cnKfeU
	KLIhRu02iMkV+eJ87BRTAOTH250lItpiTdqXMS/0JOxyPkU64BuxUfFT5CtNl/Zv
	EphTAgmARAiP55qk2vlizSVUyoM67+M52ClKZPEFovWHHAGbfGaQ06BgV5DLGQW4
	5LKs0JiQzq0Y5QnPSo3gFHTuJk5u7z7Qy/PhmAWuSXZfZi3UPSVlLy5J7JUOIJKn
	QA+7pAvqYBvHa5KZYXbq7obb3qZeVNXXQHGNVjLNKCcyaCVRj26WOz4q8iF19QHs
	5k/rh+XddNo5cEpyUZU0J+BYKqNWo9tQ9Gg==
X-ME-Sender: <xms:hZpQag9_GZBNF5DpQh_65svm4eDzW_nlVju_G9izXzGuHJabcpNVaA>
    <xme:hZpQausyaj9VQea0i_soLInUj349xCcVy8GJWCCfHlQ4thfsLtdqkjf9fql-RHN0J
    jCZoz2u6IuU2c0ReDoOzJjgQFLBysAi985rPMwFgUUfXcXwtOUm>
X-ME-Received: <xmr:hZpQajrG41iuEa7NSwt6Ea_d_kf7Jjvungg5VZNKJJAMhR4bzbU-oK9jb3BN7Dd51amcvkOian5I-ftCwHlk_yoIQ3ohNTwa8UU8bUrYUQbKiQ>
X-ME-Proxy-Cause: dmFkZTEGzWF0KumW2c+ke85oX0TErXRs9sqhW8ursPvJjv+whhfnVn3GAZczbwBG6Ays9X
    YucgkxvtFpJhiMajQeeOC1jFUVacskPLHdU0EI7R1tXz/jLkBV51LNuJfguqn8i/GsZ6JN
    SvmM5YX3du48dcK6cntyvi4AWMrXgRJpom6tv8SJKB1LaP1bk7n+CwOo2A+lP7/ZepUtef
    P0BnMVuyZQjp32LQ4EXVJTeniQF37BY8sYdAqNfdWDRt/GAdBpKT6b6GeIRhXS61bedCS8
    /lcvPzebmnYRGnYpXNfbRglNbhO+0bz9Tnv0NKfEKgiwEUNWpv9IfOLtxF6Scrqvm5iGBR
    llHj2GHnmeP4OvpMSLV2kddhdagZyZgDjx/xj3eF7ufCtglj4lYp2SHZJ7YFhaNDIXkxR9
    l28P1G/YoQNegqQiBEG8wSnGvviEzpmEVNQAxZjOtvKXLXVZGG7s4c0c5xM/QiKsuccJ1i
    M8wO4iJjumxdgFTBdbhSCG4WtU7+jIGtfhlcswf54MtsP7LDuvNbCNE3XfsiAIcngxNGty
    XfjqyZStSUB9bB607D56qH7Xlg2JqxD4fUZQwi/xPFzRm/2QtnkltXRxzfNnyPUk79Jbu1
    wF7OhBWUcSEzzG69TPVXS0k6cMfYNuzXaGqGDcRhUyoJcjYiuh1S/Qiax5Pw
X-ME-Proxy: <xmx:hZpQarnLZa5g77BAqqYpPSdSHsczynWAHycbNaMDWX2qfww9CNoS4A>
    <xmx:hZpQanxxstzg1l9A0vd7tlD1hL3QRpsNiutNpu1P2jqoSJpGC1LeaQ>
    <xmx:hZpQajml1w1iV-C1aO91dzaUmZsoPyR92dLB0v6iD44cbmAOSsOQ0w>
    <xmx:hZpQagdCYz1o41cM3y2y7FBIJnX4KVf20ODjT4MsbfyB5jpQbgHFog>
    <xmx:hZpQavuSbSAlbRkOtV96ZtRy72SJyYkgJqVDnKMDiW8TiOLUuC6uQYke>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 03:08:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f337db70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 07:08:52 +0000 (UTC)
Date: Fri, 10 Jul 2026 09:08:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] pack-bitmap: iterate object sources when opening
 bitmaps
Message-ID: <alCaggWOOoDMgI09@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-4-82fe014b12b3@pks.im>
 <alADU8qRZcPB0Zcv@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alADU8qRZcPB0Zcv@denethor>

On Thu, Jul 09, 2026 at 04:08:31PM -0500, Justin Tobler wrote:
> On 26/07/09 10:35AM, Patrick Steinhardt wrote:
> > When opening a bitmap for a repository we perform two steps:
> > 
> >   - We first look for a multi-pack index bitmap in any of the object
> >     sources connected to the repository.
> > 
> >   - We then look for a packfile bitmap in any of the packfiles of any of
> >     the object sources.
> 
> So IIUC, we generally stop searching for a bitmap once we find one.

Except that we continue searching so that we can print a warning, but
later results are simply being ignored.

> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index eda38a5433..0e3e18a557 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -680,60 +680,53 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
> >  	return 0;
> >  }
> >  
> > -static int open_pack_bitmap(struct repository *r,
> > -			    struct bitmap_index *bitmap_git)
> > +static int open_bitmap_for_source(struct odb_source_packed *source,
> > +				  struct bitmap_index *bitmap_git)
> >  {
> > -	struct packed_git *p;
> > +	struct multi_pack_index *midx = get_multi_pack_index(source);
> > +	struct packfile_list_entry *e;
> >  	int ret = -1;
> >  
> > -	repo_for_each_pack(r, p) {
> > -		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
> > -			ret = 0;
> > -			/*
> > -			 * The only reason to keep looking is to report
> > -			 * duplicates.
> > -			 */
> > -			if (!trace2_is_enabled())
> > -				break;
> > -		}
> > +	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
> > +		ret = 0;
> 
> Ok, open_midx_bitmap_1() returns 0 if it find a MIDX and -1 otherwise.
> Probably just a matter of preference, but I think writing out like below
> is a little bit easier on the eyes:
> 
>   if (midx)
>     ret = open_midx_bitmap_1(bitmap_git, midx);
> 
> it might just be that I find the return values a bit confusing though.
> Maybe we could instead use `found` like a bit later in this patch.

That's fair, and the result would be both easier to reason about and
more consistent indeed. I'll adapt this accordingly.

Patrick
