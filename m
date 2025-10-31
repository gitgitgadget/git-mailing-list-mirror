Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A325B2F4
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927783; cv=none; b=Nu5lNHKm+/psA7VCde2lddL2WNhiGUHyVCnsmAvGkCg3vYwpLKtMt6Vg5sb6ILAtY6yPZZ2Or6ac/orzeCacQhaxLkoM/inGXp7ifCQsV8DXEGo5gAKYXOq3XxihYmgl79apT85vg6XzkzD/5Gd2ItWd7X+uRYOnPzgNE2lvjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927783; c=relaxed/simple;
	bh=7tXHR9VGfYGIH4gzmercx+YasONaBVjmJYJK+PfC/0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaS0QUcS6i0yG8NfMArHuUKTocnUX2QlKEnQRdM/dswwXilEItUdm2EclXZWVt4iesq80+fQiGbKPcjD9n2ugYNs0NVbrjZk+aMXC0Lj9kPdDcnWLVRXQwrCaRZw1VYQeKEwTJ1gZyHSuCI12vQYu0EkO03WgJQ6VrmAxDbnhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAB5H3aP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAB5H3aP"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c2816c0495so1587378a34.3
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761927779; x=1762532579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDcTnnaIhDARTbAGXMaJGE6o/UcKZBa2U31nUdcB6Ig=;
        b=TAB5H3aPhtCv6LssRUsIGW4h4JCAmbivZi5aWDgtaUl4oRhaGcLgZqWR5dQz7Nch6B
         KAB50INmKDTmDDLmY9kW0FwgCLivCPR/fryzinHDknH7LdLbCYdOMnccAlq2yupYYUBm
         E7mn3zyY1QmjHulNDrsTtGFDUgmVabFdI8Hds5/PVFgcswlUUQKin+dWNpCpsqoIk9Uz
         vU//ALu6kX9JSX38HxOzNH4TNvFNmwcUSnWgnEbGbholLgGciVOldGYsDo/b3F84mR77
         kO28r5XYfTrb8ji5kcVdEop+y1Cj5AGhmZPejKKtGQAOE+6PpDUZay4C3ESrpEkkKNWc
         OBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927779; x=1762532579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDcTnnaIhDARTbAGXMaJGE6o/UcKZBa2U31nUdcB6Ig=;
        b=YMRgoF/czkF5QK48hqUxyDsfezznzLDziHOlJ4EgvAJpxlafD/XewzhkkHWDTnvgV1
         jktuEJ7SBPLXyWfD7Nx/0rNk41hNzH/es8qhQQ5femgeMB7y9Ygs+0Nr/1b4JtSeb6PV
         umG+IeopjZVeSR0e5CWJn+eBV8oIghyFiK85W+zVza4AbCVYpaJz9mSagfORkRtbtxy4
         7dXuaeXiXrZ1062ZYxF5m7bDR6PvyQZOwF6e9mIyR5IGIsuyzYuDZt7KDhPRxFPCNpod
         aYFYuWoynNiNuM8jp8M8ZRRkRYuYycv7glpuAIaxXr7fLtV1s1+07qFPW6yARJlZbj6g
         9dLg==
X-Gm-Message-State: AOJu0YzObndKSd1n8ZUulrFkYZ3xs3emCXmF/pC2X1Ce+hUC25FtjbwJ
	F1Xy+iKaq4CKJV9EHZbtF+xTPJqPg1HNT6N35yk1Jwm8loZM7C6onDYA1WLOyw==
X-Gm-Gg: ASbGnctumoMJeXgBc24VMbqu6XLbvDeVhB8BpfdTUK6zDAB7ZFTWPg4BlOeR4DZeknU
	KVjfcrYyLAy1qpALA+8AxySCDfzGViB0FHCoEjr6aQ1ZzhpBlZR231ufcW7vBhsxnZLorUDnMkf
	S8PYmXLr37hjayEhCcrA7/uCOcGJ42cVVR2qWW6+wTrewrtsOKD706+qgYMUl4ZTkNDakr2eNPi
	YfUyWWvkuDCuC/84iPAxZj5gqu5PfM7mvSg1yvF4/ucvLb7591+RMTxlSwmkNaIzxnbE6yPBdnX
	QcTCZskz13V8tKr4NxeizgzE+hGGg0gY1lm9tBd8WJB6k+Fwb2jqVNBrUth+TbDVHXs3oIOE8tg
	fYNaOYeuutcOHYsnVQMxYtaw1mMeRmzNYZR3EZKXM7D39VDJKsw9D69OYJTLWr9H8InUSYzkDG+
	eFtXSE
X-Google-Smtp-Source: AGHT+IF1uUEaHmTZ+S2QL46btEuGLfPs7qgo97fo+ROvjsHYrtjHGDLAergAO+MQ7lq5C+E+wRJaeg==
X-Received: by 2002:a05:6830:2119:b0:78d:a443:8c93 with SMTP id 46e09a7af769-7c6966f198fmr2419130a34.6.1761927779398;
        Fri, 31 Oct 2025 09:22:59 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c699c1fbdasm657656a34.9.2025.10.31.09.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 09:22:59 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:22:56 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] reftable/stack: return stack segments directly
Message-ID: <7gjrsjgi32akawqwcamzil2rblqelfvgmrxmgef5ssrslntmc6@43cra6zhledc>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-1-a03d53e28d0e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-1-a03d53e28d0e@gmail.com>

On 25/10/31 03:22PM, Karthik Nayak wrote:
> The `stack_table_sizes_for_compaction()` function returns individual
> sizes of each reftable table. This function is only called by
> `reftable_stack_auto_compact()` to decide which tables need to be
> compacted, if any.

`stack_table_sizes_for_compaction()` provides the sizes of tables which
gets used by `suggest_compaction_segment()` to figure out the range of
tables that need to be compacted in order to restore the geometric
sequence. `reftable_stack_auto_compact()` coordinates invoking these two
functions and actually performs the compaction via
`stack_compact_range()`.

> Modify the function to directly return the segments, which avoids the
> extra step of receiving the sizes only to pass it to
> `suggest_compaction_segment()`.

Ok, so we want `suggest_compaction_segment()` to be invoked by
`stack_table_sizes_for_compaction()` instead of
`reftable_stack_auto_compact()`. So we are not really avoiding this
step, but just changing where it occurs.

> A future commit will also add functionality for checking whether
> auto-compaction is necessary without performing it. This change allows
> code re-usability in that context.

Makes sense.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  reftable/stack.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 65d89820bd..49387f9344 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1626,7 +1626,8 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
>  	return seg;
>  }
>  
> -static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
> +static int stack_segments_for_compaction(struct reftable_stack *st,
> +					 struct segment *seg)

`stack_segements_for_compaction()` now handles both getting the table
sizes and getting the segment range for compaction.

>  {
>  	int version = (st->opts.hash_id == REFTABLE_HASH_SHA1) ? 1 : 2;
>  	int overhead = header_size(version) - 1;
> @@ -1634,29 +1635,29 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
>  
>  	REFTABLE_CALLOC_ARRAY(sizes, st->merged->tables_len);
>  	if (!sizes)
> -		return NULL;
> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
>  
>  	for (size_t i = 0; i < st->merged->tables_len; i++)
>  		sizes[i] = st->tables[i]->size - overhead;
>  
> -	return sizes;
> +	*seg = suggest_compaction_segment(sizes, st->merged->tables_len,
> +					  st->opts.auto_compaction_factor);
> +	reftable_free(sizes);
> +
> +	return 0;
>  }
>  
>  int reftable_stack_auto_compact(struct reftable_stack *st)
>  {
>  	struct segment seg;
> -	uint64_t *sizes;
> +	int err;
>  
>  	if (st->merged->tables_len < 2)
>  		return 0;
>  
> -	sizes = stack_table_sizes_for_compaction(st);
> -	if (!sizes)
> -		return REFTABLE_OUT_OF_MEMORY_ERROR;
> -
> -	seg = suggest_compaction_segment(sizes, st->merged->tables_len,
> -					 st->opts.auto_compaction_factor);
> -	reftable_free(sizes);
> +	err = stack_segments_for_compaction(st, &seg);
> +	if (err)
> +		return err;

Looks good.

>  
>  	if (segment_size(&seg) > 0)
>  		return stack_compact_range(st, seg.start, seg.end - 1,

Do we expect the errors returned by `stack_segments_for_compaction()` to
always be negative? If so, I wonder if we should also have it return the
number of tables in the segment. That way it could also handle the
followup `segment_size()`.

-Justin
