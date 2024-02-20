Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A177A04
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453552; cv=none; b=pWNd2ciDIJmyTNcUJjNIhNfZ5EKEd0ir6VcbhNysFq+Lv1UnRxzDRne3jc/Nbmt6sYhn2CeVcZvXLR3WEvLggA45C1OI7WxkWDlE+vBBDITBLRaScF6ZVU0S8s4xYM7LWWPgdjKC2RHy0Yskqqzc+Ev8aLpFqINIcXMTCP6NEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453552; c=relaxed/simple;
	bh=zH9GC+x6gVk8CCxQ6pijDkTOXzPwSFVLx6uh+kSKecc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogrQ5Mjn1hdw/tXF6zr8NpqDWce4nxF0lFMcCKk+Dl8GpSE2a238AHHjczt1p5V6jOodofyKw5IQuVaDN/mWYOLTUunWy0/wvps7F3iRdnBxavNTADTwuSNyhnJjgfSX/5MJwJuSsLzCL96bk5ivsOyvupU+vnf4p20A9b/NwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbNvhX9+; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbNvhX9+"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddca59e336so3068223a34.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453550; x=1709058350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GoOzJuDgWbFFfZgoBE58cJebZ+9lF4EYvLnuUDgqGZY=;
        b=UbNvhX9+aTTFGkiXPyN5VqcUBjYQNv50pe0i3CstcANgm23pm9xnG9YMDPG9jD2JVH
         mc6h/d73ob7WdtZjLuq6J9aH/HJ8S+J3xvnmwwm/yjXvkuaVqhejFpdJL9xtbA5GCNRO
         3QpZyHmmkSqtZ7ssj76YvB8SShz69yMH6n0VNTCHqHcIzdZsjCRaOvf7dU/dKNOddnpm
         MM19OTaMRedMR5sy7hI88YMpujHMpy4R/c8pimEZpTgU/K7kG30F0L5kGeLYH31PgHqA
         Hm5jnCYrkdVPYt0CQHdw97pxV4TV4j3uWtYL4+5pYWmtAAXk93tOujDlnDOiX7lA2gEU
         R1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453550; x=1709058350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoOzJuDgWbFFfZgoBE58cJebZ+9lF4EYvLnuUDgqGZY=;
        b=ntvHCTXZAnOTejK4UsMZWSD484XsUsvIXuVq7Vd2IC8HdX79fH1kGXiMG/hxl3GCBI
         UZpdJGWtdIeh8Uf+zo/ha2DCRYB54UI9HFSIEY0QlxOBSMHIdif1VbC1wg9yMOxJyZOR
         n0sbHMfKGfo6xuzIulDlY+0tWyinCwGM9/Q0Uoxhf2HrZv+TIOx0d//FcSbLtzWhSm2j
         sD/UOMJgsoVXneZKmNniYf1k6sPzJyPsbr5y5NVvqgIU3QGeSSRJebYJYD1M5XE7tfzd
         QcI5rZyPnAcjZHteo1vobJMj2LS76DqVK0k5CDa1rSNlaBBl3L1nqvo0j5KCYNRRx7aJ
         kQMw==
X-Gm-Message-State: AOJu0Yy/qJ/549IqKESQ4isdkgN5Umd3huXMdjwCsjGmG2GhVQc6hJTE
	l9cKkLkMN7lozZLsgiqKUt0n5pzC+ftjCK+pNCI3ufFY+GIOil8CMFjMwb0s
X-Google-Smtp-Source: AGHT+IEsmbrNoF2AI6Q8iFL36GFaGNcirn3CL2bZ+lKmBbxSzZkozFGHG6m6mkYorbJkz1upAi1Q/A==
X-Received: by 2002:a9d:61cf:0:b0:6e2:e184:4a64 with SMTP id h15-20020a9d61cf000000b006e2e1844a64mr8103529otk.9.1708453549897;
        Tue, 20 Feb 2024 10:25:49 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id k13-20020a9d760d000000b006e2d55cae76sm1327478otl.13.2024.02.20.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:25:49 -0800 (PST)
Date: Tue, 20 Feb 2024 12:25:10 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/12] reftable/merged: advance subiter on subsequent
 iteration
Message-ID: <ns2yw3icnl3udejbgsv4ojwgzbe7eg57bvsm53kciuemlvmgbr@mpjtogpzdavi>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1707895758.git.ps@pks.im>
 <38d45995662ba92f4b985b82deac298446274511.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38d45995662ba92f4b985b82deac298446274511.1707895758.git.ps@pks.im>

On 24/02/14 08:45AM, Patrick Steinhardt wrote:
> When advancing the merged iterator, we pop the top-most entry from its

s/top-most/topmost

> priority queue and then advance the sub-iterator that the entry belongs
> to, adding the result as a new entry. This is quite sensible in the case
> where the merged iterator is used to actual iterate through records. But

s/actual/actually

> the merged iterator is also used when we look up a single record, only,
> so advancing the sub-iterator is wasted effort because we would never
> even look at the result.
> 
> Instead of immediately advancing the sub-iterator, we can also defer
> this to the next iteration of the merged iterator by storing the
> intent-to-advance. This results in a small speedup when reading many
> records. The following benchmark creates 10000 refs, which will also end
> up with many ref lookups:
> 
>     Benchmark 1: update-ref: create many refs (revision = HEAD~)
>       Time (mean ± σ):     337.2 ms ±   7.3 ms    [User: 200.1 ms, System: 136.9 ms]
>       Range (min … max):   329.3 ms … 373.2 ms    100 runs
> 
>     Benchmark 2: update-ref: create many refs (revision = HEAD)
>       Time (mean ± σ):     332.5 ms ±   5.9 ms    [User: 197.2 ms, System: 135.1 ms]
>       Range (min … max):   327.6 ms … 359.8 ms    100 runs
> 
>     Summary
>       update-ref: create many refs (revision = HEAD) ran
>         1.01 ± 0.03 times faster than update-ref: create many refs (revision = HEAD~)
> 
> While this speedup alone isn't really worth it, this refactoring will
> also allow two additional optimizations in subsequent patches. First, it
> will allow us to special-case when there is only a single sub-iter left
> to circumvent the priority queue altogether. And second, it makes it
> easier to avoid copying records to the caller.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/merged.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/reftable/merged.c b/reftable/merged.c
> index 12ebd732e8..9b1ccfff00 100644
> --- a/reftable/merged.c
> +++ b/reftable/merged.c
> @@ -19,11 +19,12 @@ license that can be found in the LICENSE file or at
>  
>  struct merged_iter {
>  	struct reftable_iterator *stack;
> +	struct merged_iter_pqueue pq;
>  	uint32_t hash_id;
>  	size_t stack_len;
>  	uint8_t typ;
>  	int suppress_deletions;
> -	struct merged_iter_pqueue pq;
> +	ssize_t advance_index;
>  };
>  
>  static int merged_iter_init(struct merged_iter *mi)
> @@ -96,13 +97,17 @@ static int merged_iter_next_entry(struct merged_iter *mi,
>  	struct pq_entry entry = { 0 };
>  	int err = 0;
>  
> +	if (mi->advance_index >= 0) {
> +		err = merged_iter_advance_subiter(mi, mi->advance_index);
> +		if (err < 0)
> +			return err;
> +		mi->advance_index = -1;
> +	}
> +

Without additional context, it isn't immediately clear to me why the
sub-iterator is condionally advanced at the beginning. Maybe a comment
could be added to explain as done in the commit message to help with
clarity?

>  	if (merged_iter_pqueue_is_empty(mi->pq))
>  		return 1;
>  
>  	entry = merged_iter_pqueue_remove(&mi->pq);
> -	err = merged_iter_advance_subiter(mi, entry.index);
> -	if (err < 0)
> -		return err;
>  
>  	/*
>  	  One can also use reftable as datacenter-local storage, where the ref
> @@ -116,14 +121,6 @@ static int merged_iter_next_entry(struct merged_iter *mi,
>  		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
>  		int cmp;
>  
> -		/*
> -		 * When the next entry comes from the same queue as the current
> -		 * entry then it must by definition be larger. This avoids a
> -		 * comparison in the most common case.
> -		 */
> -		if (top.index == entry.index)
> -			break;
> -

I'm not quite sure I follow by the above check is removed as part of
this change. Would you mind clarifying?

-Justin
