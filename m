Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99133711D
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631317; cv=none; b=HZKH3q/t7CJWgV47udRGOhFh9z9cflJF8gcbr1y4GMqnuv/TN5P6fgZn1a6CTCpSXX8CIhTm4wz9IpNGqHL9IlzfmF+xO6swHOYtvP5d+F/UZkGBXyZDlL0jcRTcVgY1H3ScMxWFyxfmVxQD6HtmyO0/1MyAldEqk3V3OiUoTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631317; c=relaxed/simple;
	bh=SDHHzK5u1nQ3pEFYALlKdqhoO4pNlSbbxKDaTx1D65A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALk3aqEPjsyXyEur4eSV2BfwQctdgMLaDM+ae/g562rwzYVBKp9n6iEVbNYGGpjv7PauI8cp2GyaTO0SgASiwULe9V0AKvI/vWjqqs3/Glymq0zBSX22J5wKaUPPmoCdVhpBayfGKZ9zhlOgAlZREpdHn+urMd2v6BpmtlETbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4VXQWfA; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4VXQWfA"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a3776acb16so200523eaf.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783631315; x=1784236115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k4l8++5O7TWv9Dqkaljiod3XR6GOsUUchjrDrGNC1hQ=;
        b=o4VXQWfALxLq3S/mMcOM1HcSJlCe0JUScQlwzScqxRl2FlvMjaWuBBPyFloMa3Sese
         uXD0Uu3zMgo6tNhMYYhZWRIp8R8Vnq7TFuzoz3njdWB+2OiqTVjdW2WXncTMBxQ3d3H8
         YHml6NyL8Yq3+WZVhEW2LI0uCEi0/GIv7O5jRpVNndD2SlF/20140gay5Qu23aPiTspP
         zUMQJybNK4wkOfhJ1okg6zfMgFcsmQIJIUko9KoNxbx+KSmmuAHELuNzFkuJkDI66Tap
         gr97sCd5Lfkc2XJWo6Rq9OarDni/Y255Y/wJYj7hBnKP5Qs9m2y5MJItxTFNJyQjq0k3
         xucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631315; x=1784236115;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4l8++5O7TWv9Dqkaljiod3XR6GOsUUchjrDrGNC1hQ=;
        b=fcMPloGiSaEC+UF0vjLyMBLVnfNqgeTidIJI60muquysqOPLgzHOUUREY2Jd/EpuK1
         xJofapeF7aj9tXr++o5tLmvkLoiUWAh7dHr4Q6JFi3J0w9OBJPY3+Jm6aHhii2LAzRY1
         znUiz2wscdQfca9zL6EceFlFpYpIUiYExfunK3SkY7ee2MR8C0d3WRyyhlLtUnuKWgLo
         kk/7VdtzSloQMcDOQIiH86AJCr9YED+M1ZE3QKtAncz99uU4QuixBbuQ0ir+93g1iGqM
         rsLfXSnyBaqojoS0KnRczOWQiDojYpES9yQWtZCz/QhlivmgP08i1I2KMwQWZFWc9eJi
         Rqiw==
X-Gm-Message-State: AOJu0Yynp155uvhahc0bEoUpHtrHOD9GBHkGeMH9uDXEmViSPMUaMwcP
	1sG8WywEaKcKWcvb6vwd5HqKbtgwhP8ohQzdJW/aIhVdP5C5h3bUZqywQuiXpQ==
X-Gm-Gg: AfdE7ckTE9d4SpPIBhUFXL0xGEyGRSYbhqw9YV3ZtkV5BkEkLQADdal7eeVGNE3PI2k
	SwOUo+7HKfs6zQFXdNqubaCUAJ1SYdnk6Kignqz++zlUB/G4UWDZPaZ+KjmCdhd6+Habo5ad1tH
	UeUhmcIVQFh/GtQXFAEwrZeSbb0qiw1XxvwZm6dEBjPHyOvtfkVzE83OQ5Dv/wzMzWPyOSlgkml
	9hEVb+4J0RbjP4LmCl5T4v7BY4rEZYBkbyLOBn6AZENfp6Q3cviKWuuDBuJT28nB7E0yYejvLh7
	msbCvM8V62zmvSZfLCZ2hUVJV4BtmHL5bonlPEyS/oXBHiE1Xx9+SqXQTy5lPnAztjSyz3jHuv/
	i+JyagYHWBLSACk77XAx6HyVy+3q7iYtCLxSYLpFpSoOBgI6G9lahyas78m1jWoMxmfdrxKCSgc
	5SQfwtnA==
X-Received: by 2002:a05:6820:1345:b0:6a1:5ca0:d529 with SMTP id 006d021491bc7-6a36d89a7f0mr7518763eaf.25.1783631315200;
        Thu, 09 Jul 2026 14:08:35 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a37b58f98csm2543691eaf.13.2026.07.09.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:08:34 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:08:31 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] pack-bitmap: iterate object sources when opening
 bitmaps
Message-ID: <alADU8qRZcPB0Zcv@denethor>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-4-82fe014b12b3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-4-82fe014b12b3@pks.im>

On 26/07/09 10:35AM, Patrick Steinhardt wrote:
> When opening a bitmap for a repository we perform two steps:
> 
>   - We first look for a multi-pack index bitmap in any of the object
>     sources connected to the repository.
> 
>   - We then look for a packfile bitmap in any of the packfiles of any of
>     the object sources.

So IIUC, we generally stop searching for a bitmap once we find one.

> Both of these steps thus iterate through object sources themselves, one
> via `odb_prepare_alternates()` and one via `repo_for_each_pack()`. This
> layout makes it hard to introduce a way to open the bitmap of one
> specific object source, which is functionality that we'll require in a
> subsequent commit.
> 
> Reverse the loop so that we instead loop through all sources in the
> outer loop, and then for each source we try to load its bitmap via
> either the multi-pack index or via a packfile.

Conceptually, I think this is a lot easier to follow too which is nice.

> Note that this changes the precedence of bitmaps in one specific edge
> case: when an earlier object source only has a packfile bitmap, but a
> later source has a multi-pack index bitmap, we now pick the packfile
> bitmap of the earlier source. Previously, a multi-pack index bitmap from
> any source would have taken precedence over all packfile bitmaps. Given
> that object sources are ordered such that the local source comes first,
> this arguably is an improvement, as we now prefer local bitmaps over
> bitmaps in alternates. Furthermore, we already warn about repositories
> that have multiple bitmaps, so this setup is broken and thus arguably
> not worth worrying about too much.

I agree that the change in bitmap precedent is probably not a big deal.
Having multiple bitmaps in a repository is already something we warn
against so I think this should be fine.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-bitmap.c | 65 ++++++++++++++++++++++++++---------------------------------
>  1 file changed, 29 insertions(+), 36 deletions(-)
> 
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index eda38a5433..0e3e18a557 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -680,60 +680,53 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
>  	return 0;
>  }
>  
> -static int open_pack_bitmap(struct repository *r,
> -			    struct bitmap_index *bitmap_git)
> +static int open_bitmap_for_source(struct odb_source_packed *source,
> +				  struct bitmap_index *bitmap_git)
>  {
> -	struct packed_git *p;
> +	struct multi_pack_index *midx = get_multi_pack_index(source);
> +	struct packfile_list_entry *e;
>  	int ret = -1;
>  
> -	repo_for_each_pack(r, p) {
> -		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
> -			ret = 0;
> -			/*
> -			 * The only reason to keep looking is to report
> -			 * duplicates.
> -			 */
> -			if (!trace2_is_enabled())
> -				break;
> -		}
> +	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
> +		ret = 0;

Ok, open_midx_bitmap_1() returns 0 if it find a MIDX and -1 otherwise.
Probably just a matter of preference, but I think writing out like below
is a little bit easier on the eyes:

  if (midx)
    ret = open_midx_bitmap_1(bitmap_git, midx);

it might just be that I find the return values a bit confusing though.
Maybe we could instead use `found` like a bit later in this patch.

> +
> +	for (e = packfile_store_get_packs(source); e; e = e->next) {
> +		/*
> +		 * When tracing is enabled we want to keep looking to report
> +		 * duplicates even if we have already found a bitmap.
> +		 */
> +		if (!ret && !trace2_is_enabled())
> +			break;

So if have already found a bitmap from the MIDX and tracing is not
enabled, we don't continue searching for bitmaps in this source. 

> +
> +		if (open_pack_bitmap_1(bitmap_git, e->pack))
> +			continue;
> +		ret = 0;
>  	}
>  
>  	return ret;
>  }
>  
> -static int open_midx_bitmap(struct repository *r,
> -			    struct bitmap_index *bitmap_git)
> +static int open_bitmap(struct repository *r,
> +		       struct bitmap_index *bitmap_git)
>  {
>  	struct odb_source *source;
> -	int ret = -1;
> +	int found = 0;
>  
>  	assert(!bitmap_git->map);
>  
>  	odb_prepare_alternates(r->objects);
>  	for (source = r->objects->sources; source; source = source->next) {
>  		struct odb_source_files *files = odb_source_files_downcast(source);
> -		struct multi_pack_index *midx = get_multi_pack_index(files->packed);
> -		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
> -			ret = 0;
> -	}
> -	return ret;
> -}
> -
> -static int open_bitmap(struct repository *r,
> -		       struct bitmap_index *bitmap_git)
> -{
> -	int found;
>  
> -	assert(!bitmap_git->map);
> +		found |= !open_bitmap_for_source(files->packed, bitmap_git);
>  
> -	found = !open_midx_bitmap(r, bitmap_git);
> -
> -	/*
> -	 * these will all be skipped if we opened a midx bitmap; but run it
> -	 * anyway if tracing is enabled to report the duplicates
> -	 */
> -	if (!found || trace2_is_enabled())
> -		found |= !open_pack_bitmap(r, bitmap_git);
> +		/*
> +		 * The only reason to keep looking after having found a bitmap
> +		 * is to report duplicates.
> +		 */
> +		if (found && !trace2_is_enabled())
> +			break;
> +	}

Ok, we only advance to the next source if tracing is enabled to print
warnings for multiple bitmaps. Makes sense.

Overall I quite like the direction of this patch.

-Justin
