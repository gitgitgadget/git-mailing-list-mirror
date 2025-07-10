Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A352F2374
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189782; cv=none; b=lka46VfcP3xBY+DF046ooegym7EBEgAyuLEQKvFztMbftHKtIDq/2Her73yZZw+OgDZoAdtr7gKfrzPZcnKeOA2DCxl4Kz2FJOfJBFt/akLBiz5EJT/I+8Ed2ZfoDdc7+iOIxHR4GGcqqduGBeehyRAidCmAWlYZGWFSedm2uxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189782; c=relaxed/simple;
	bh=p6FdQAYWHgsijHVlqVtZwhPEoiihWQt5kV7OZoaIctE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhCXG2Kb31NqjmD89K6RacLmZZ8+RsX7mXJ2t38rIGkS86HWWZ7LkB+qns3ITtThtVpa9uop1RFxHjLW+F2xe7Q1HUH34cA33NQ+KIpE1CTeX11bjwQ3fDTamEcG1ErjqKVKiplwLLdd4Mi07wEE0Ays08EGuD7EzcXAi+mgJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gCq0hcLi; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gCq0hcLi"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81826d5b72so1360799276.3
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752189780; x=1752794580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqMOaIscugpvTvSBvXMGgvfs979lMqMr1W2zJPrWeiA=;
        b=gCq0hcLimKBCanjNs1LrtQ/yPZw4ClNuwJRHdG9SYU1pjC3LuUCHVHOccWoaPTlWHw
         1viQquB2pZp/+Qqv8HdIM+mN1PP5nehu41FBQOr4GbuUWE+hdmWAk2ampIp2v2irM6Kz
         2Gelbp+r3mQair2U4+y2gHPBtNgqZl2cjh3Kl5dBjki1CRkp2k2hASUg6tdmVTlCOEQ7
         IIp80nkuLG4G8aZkTJZN2D57mAIRUo2AIG+YfJhd+hZeqi1i9P+d3Z+bu4kfgfvwPavQ
         pUUeaghtqoB6SxG/BojKUn2iF7SQ13+dJczBHjYiVv2E/jSdaZaKQFgAROt3VzMDk/xu
         RuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189780; x=1752794580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqMOaIscugpvTvSBvXMGgvfs979lMqMr1W2zJPrWeiA=;
        b=hUc+qfW74txa8aehLNRKdO0BJLyc9ceR5eu2Rz/TJjVBxs2bpSa4cD6p3GIeY2Z0/J
         egPdpjLKZ5TQRb/6bZfq+lpZjlWFfFfV/fYj/lliiH2c+gNoUc+IAitQmMciE/gZ4Yh0
         tw26TUdl2DVk8N7COaXu0gT8ZAP8D48U9EypKHUP0oJI+CLxVfVvh4tJHtXmU1ziRsyx
         EUIyjBkZt0tGw18ijT6BDrM8GuSKNMomrMdZfCJOKjm95Qh8E/z6DPmnGC/w4sWRjoRw
         U29stE6wPayQ2DYJytMnW5WEnEfytEUgy/qqACQOQsqas5SSUB6S57GpkkHHla1g8P/+
         f+dw==
X-Gm-Message-State: AOJu0YzOQ12aeN0aLKRTiFAybJ0fyOIdiVvQ0jTaOqnMyGt/cEZXaq00
	8yvG9AxfhRL7E8pKNamM9T0j8riAeU+Xr8PaOI7ADHpSRnqmz8qFb5+wk0LUYxgErMU=
X-Gm-Gg: ASbGncslz7DDy388sB8iPFsySB9RRE5c+pfGaXH6lRqRHfPydBrgKthQ2+IBvSHEUoj
	L8n6uyRnPr625zqLcFt8DB5KNWp2CHKZ5xlZmfidTwyvkQntSE6BVYRapA4Tm1UCiuhQkKVokSk
	IAkQObQhhUNJ6qREXCq+nz5mHFMaMYJJMzmAitdq0VVCsmaB3z8ZKNxEkrhWcePdrH6rpP5nY5/
	v+O9ir1tyzkn/O/uMZpjjF5svyeFFr9fNCD+nFdBZddTZWr+DLz1OQfepXtUeRGtG5cpMK+OfR5
	nj2iiSWwQ2T6SrLMm/RhNtaFT1Ap53lEmIILORPoHuqnuhbwulwCswWmNvGfBI2nPgiKIwFJfaD
	7TT+O2JfKJVeTc8nhHXviv6vLJW4IaheSsnmWZV1jQmcHChgi+0In12BMHxEDu/dMuBeDCA==
X-Google-Smtp-Source: AGHT+IGF1WIsgsYm9h7slki5bi1UYh/MVSScfbgwR9X1bzRLW1Ox+2ka2DkZyEowFJjneu4en3kS5A==
X-Received: by 2002:a05:6902:1895:b0:e84:2cec:1c9e with SMTP id 3f1490d57ef6-e8b85caaademr1170065276.49.1752189779660;
        Thu, 10 Jul 2025 16:22:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8b7ae26ec8sm733330276.8.2025.07.10.16.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:22:59 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:22:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] midx: stop using linked list when closing MIDX
Message-ID: <aHBLUg7Y1cgf8i7k@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-3-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-3-f31150d21331@pks.im>

On Wed, Jul 09, 2025 at 09:54:51AM +0200, Patrick Steinhardt wrote:
> When calling `close_midx()` we not only close the multi-pack index for
> one object source, but instead we iterate through the whole linked list
> of MIDXs to close all of them. This linked list is about to go away in
> favor of using the new per-source pointer to its respective MIDX.
>
> Refactor the function to iterate through sources instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c     | 11 ++++++-----
>  packfile.c | 10 +++++-----
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index a91231bfcdf..416b3e8b54f 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -401,7 +401,6 @@ void close_midx(struct multi_pack_index *m)
>  	if (!m)
>  		return;
>
> -	close_midx(m->next);

OK, so previously this recursive call to "close_midx()" would have freed
up the `m->next` MIDX...

>  	close_midx(m->base_midx);
>
>  	munmap((unsigned char *)m->data, m->data_len);
> @@ -835,11 +834,13 @@ void clear_midx_file(struct repository *r)
>
>  	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
>
> -	if (r->objects && r->objects->multi_pack_index) {
> -		close_midx(r->objects->multi_pack_index);
> -		r->objects->multi_pack_index = NULL;
> -		for (struct odb_source *source = r->objects->sources; source; source = source->next)
> +	if (r->objects) {
> +		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +			if (source->multi_pack_index)
> +				close_midx(source->multi_pack_index);
>  			source->multi_pack_index = NULL;

...and then this line would NULL the now-free()'d memory out.

But instead we are directly iterating through the sources and both
closing and NULL-ing out their respective MIDXs (if any).

As an aside: I know we do the C99-style for loop with declarations in
many places, but in this instance it seems to have produced an awfully
long line. I wonder if in this instance it would be better to write:

    struct odb_source *source;
    for (source = r->objects->sources; source; source = source->next) {
        /* ... */
    }

That's still a little lengthy, but it's fewer than 80 characters ;-).


> +		}
> +		r->objects->multi_pack_index = NULL;

Presumably this pointer will go away at some point in the future as
well?

>  	}
>
>  	if (remove_path(midx.buf))
> diff --git a/packfile.c b/packfile.c
> index b43dd2fe6cb..546c161d0c1 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -369,12 +369,12 @@ void close_object_store(struct object_database *o)
>  		else
>  			close_pack(p);
>
> -	if (o->multi_pack_index) {
> -		close_midx(o->multi_pack_index);
> -		o->multi_pack_index = NULL;
> -		for (struct odb_source *source = o->sources; source; source = source->next)
> -			source->multi_pack_index = NULL;
> +	for (struct odb_source *source = o->sources; source; source = source->next) {

Same comment here as well.

Thanks,
Taylor
