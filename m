Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA41D1502
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319187; cv=none; b=c+1X4iVXQvcnZ6i8STVTNUdN247jglK8p6nuYRqTLlQunvoknOlfD0Xu6f7aBtd/zfFYyiEmr4q0cUCHVDCtdqtr4saihLag36UJelaqoxqnVJo7AiEpuBTUZkKN80VnJqlv5gtz97pdS2Bf7ns0tsx2vXUZhArnxYBBqJyK9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319187; c=relaxed/simple;
	bh=++SGlEPV5tzGD7+MM4mnBdPWxYpBa5VuZ93fskBlCH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtbfTe72K/RNkajdpCjpS8D7gvwtLKUeO02ElDQKHSErbLN0ym9x5lwfaQCSHCCDquNB6P2Db12VirsqHEzZnNRazSrxuLeMm+Tk9dWqZgsO4CnMryXydi2hOQ6hZgIxdYGk9mCEkQ4pF2X/526+IpVH2/BybsGJpNO2ioe/cBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oAYq/5UY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oAYq/5UY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ea07d119b7so1726447b3.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730319184; x=1730923984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySrsx7li+HZned+07BebG2s+NhIhsp3quV1WvkyeLls=;
        b=oAYq/5UYg61Rwh4GD7z0I6SOavOg48PCaebyPP8kPSStul74fLwe+f4Q+BbvDp5/xU
         6aLXbryBU6enduvkoqillLnpa5Ssf8of5WmkCzWNCv2gnApyKRSab+RHz/aWtxo86Bn+
         tBoXVJTRPjWfMtroSXCJIQiqsQ2uBJsPRC7gNJbmkgjfkOF511Do1kTUzqN8Deiwn/EB
         4qDq1g23kAfxwfWQw/1p3WRzuxywCplI+bCcICUb2MgmwZogZER357uyD8ehSZK2O14v
         6YOiohYEhT7GGoszvvsCheZK0GfJLF0cb7b1oQIYyyZqeOziyHTAf8D/LMgt8COx/dVq
         MfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319184; x=1730923984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySrsx7li+HZned+07BebG2s+NhIhsp3quV1WvkyeLls=;
        b=M1wnDJQFjPy/N7NesYej13PUVGgaHnUDYxFFulFolGavpqsCTx1aYzMAdNrT2mtJMX
         bLFIbNozqSQxJDRQSZTWFGc+dApyWAe/I3kDos+gttyNY0pTcsDlW2nVctq6S7VlwXkd
         X/9Xr761WXSp3VgPyWIhTxg+I9nBKJ8DNtIx3Aifvdf4jbWMl0chdD0CEieaPCx116U8
         NV3R+rdupaffewP403L5dQeruMN2FH0Y8pzJikRN8F2ELL1pHa+Gr28I1byIX8b4JnoB
         dDvMRcpJCrYXaMXjKQiqrKMVdPgQXw2Wa/33rkz+zF0dRrer1dZzDvsz19f4TDkUt2fg
         sF2g==
X-Gm-Message-State: AOJu0YzVC+4uIye8tWFnxlh1AgtgyXunZCPKHB25zwpzmucPoCQ8N/Os
	/Jlf/23OvXqE+9KETKNrjwav0agSFL8KpAOZsED7XqwSQFV/tZLHN65S1apiYuI=
X-Google-Smtp-Source: AGHT+IHWAUbiKDbCBMzDtgO6NIKN4dqXk7YSyd/hV/QLa4Ey919FrXXjpirs/X7qpZda9Dk/mhwU9A==
X-Received: by 2002:a05:690c:dc6:b0:6ea:21e6:c899 with SMTP id 00721157ae682-6ea3b87e19fmr59599467b3.3.1730319183827;
        Wed, 30 Oct 2024 13:13:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6baffccsm26324927b3.3.2024.10.30.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:13:03 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:13:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 9/9] midx: add repository to `multi_pack_index` struct
Message-ID: <ZyKTTYGPDQ0SWJCZ@nand.local>
References: <cover.1730297934.git.karthik.188@gmail.com>
 <c0b386412d5c464aa838dbe7c7679d4c8618a2c7.1730297934.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0b386412d5c464aa838dbe7c7679d4c8618a2c7.1730297934.git.karthik.188@gmail.com>

On Wed, Oct 30, 2024 at 03:32:34PM +0100, Karthik Nayak wrote:
> The `multi_pack_index` struct represents the MIDX for a repository.
> Here, we add a pointer to the repository in this struct, allowing direct
> use of the repository variable without relying on the global
> `the_repository` struct.
>
> With this addition, we can determine the repository associated with a
> `bitmap_index` struct. A `bitmap_index` points to either a `packed_git`
> or a `multi_pack_index`, both of which have direct repository
> references. To support this, we introduce a static helper function,
> `bitmap_repo`, in `pack-bitmap.c`, which retrieves a repository given a
> `bitmap_index`.
>
> With this, we clear up all usages of `the_repository` within
> `pack-bitmap.c` and also remove the `USE_THE_REPOSITORY_VARIABLE`
> definition. Bringing us another step closer to remove all global
> variable usage.
>
> Although this change also opens up the potential to clean up `midx.c`,
> doing so would require additional refactoring to pass the repository
> struct to functions where the MIDX struct is created: a task better
> suited for future patches.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  midx.c        |  1 +
>  midx.h        |  3 ++
>  pack-bitmap.c | 97 +++++++++++++++++++++++++++++++--------------------
>  3 files changed, 64 insertions(+), 37 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 8edb75f51d..7a34473010 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -131,6 +131,7 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
>  	m->data = midx_map;
>  	m->data_len = midx_size;
>  	m->local = local;
> +	m->r = the_repository;

Same note here about calling this 'r' rather than 'repo'.

I do wonder if it creates any awkwardness to have the_repository
assigned here unconditionally when we do specify the object_dir. I think
it's OK so long as we don't start replacing 'm->object_dir' with
'm->repo->objects->odb->path'.

> @@ -1980,18 +1997,23 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>  	if (!use_boundary_traversal)
>  		object_array_clear(&revs->pending);
>
> +	repo = bitmap_repo(bitmap_git);
> +
>  	if (haves) {
> -		if (use_boundary_traversal) {
> -			trace2_region_enter("pack-bitmap", "haves/boundary", the_repository);
> +		if (use_boundary_traversal)
> +		{
> +			trace2_region_enter("pack-bitmap", "haves/boundary", repo);
>  			haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
> -			trace2_region_leave("pack-bitmap", "haves/boundary", the_repository);
> -		} else {
> -			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
> +			trace2_region_leave("pack-bitmap", "haves/boundary", repo);
> +		}
> +		else
> +		{
> +			trace2_region_enter("pack-bitmap", "haves/classic", repo);
>  			revs->ignore_missing_links = 1;
>  			haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
>  			reset_revision_walk();
>  			revs->ignore_missing_links = 0;
> -			trace2_region_leave("pack-bitmap", "haves/classic", the_repository);
> +			trace2_region_leave("pack-bitmap", "haves/classic", repo);
>  		}

Odd braces?

Thanks,
Taylor
