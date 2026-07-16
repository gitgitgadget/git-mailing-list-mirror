Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04F2FFFB5
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230557; cv=none; b=Rg+TxLNdKELcWJfryPoxIsHHmiwIJDaCwuL61l7aEUc++Q9lkG+oircnoqjaK+RyBP6h54m/axmNcaXVt16l3jhvWy2dNornaiGn58UH5+rPgvCxgkt8Gi9OumzaUCm6FdXWUKJjpG3f1XxbRrzzUT5k6Kltw541pVBN3O5Mhj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230557; c=relaxed/simple;
	bh=sT0LcYcEpeXvIFckqqLOlRFeASXnoRIdozRaPGfCFUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj5EHLjs/Hz6z4LHop3tiTGL5ey+0OwJTy2X1F+lT2YB/vEJpIyPgsaCJvWSXUILd1Qm/O2MIXRBDKLDFYF3D/6poAu4KFpMC7vsl3/SLHtmggWquEh54X70X9kUWJOOj3opFOs3DAfAZeQDC0QDgmTwbc0Ab9UjVyCd/INLTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ST7ExO1F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3BrglYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST7ExO1F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3BrglYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784230554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iuCrzX1JBcnU7x37u5l2XjtD8UIP2PystMQpvNhnRT0=;
	b=ST7ExO1FFvkO5iJaT9U4dlxFxdu1geZJa9tW0JAEqWnvq4GnWbh3mNHLElxls8CntYUcE9
	yNIvUVYNrM1NGwGm+vXGrbnXaRPXns+nWMbXZUD8jbOWN2CHimzAKaC/TMMk2zOSyryMvW
	nc4r0poT8GI0KeQ4o3Sb2PUReC36Geg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Im5CfvDiO-WdrRoFxXrpMg-1; Thu, 16 Jul 2026 15:35:52 -0400
X-MC-Unique: Im5CfvDiO-WdrRoFxXrpMg-1
X-Mimecast-MFC-AGG-ID: Im5CfvDiO-WdrRoFxXrpMg_1784230552
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso44088081cf.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784230552; x=1784835352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iuCrzX1JBcnU7x37u5l2XjtD8UIP2PystMQpvNhnRT0=;
        b=P3BrglYU9x7bxpMDEcuB3XOhz+ymmixs9uVH3LVZtq/LKaPOVaWdQKrJ5oGYWFMwmb
         3OHH2k152lsrwrjy8ecjpapQ63WWck3NmFW2sBP5gPmVonDpvpcCZNWn3FoUgF7tAMAc
         Aj5t1g6BbGtJyY5owYPCVpolvpxd7JlrZm+wyMo9Niaxv6CTMwnUjkZ7fPrNbFcZ62Tm
         JgnXVvLZJYdbOPMOx8Yb121cbOfvvqeJYKQZEM8gZSPnTBolvW+sr5keOQpI+2M76ITG
         sDvJCYy5XGeAQE4KVYmXc6cc36GjuqmuVYLvqXvnavv1HiVWEgV/RNjSlhS1Ns3D19DL
         IsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230552; x=1784835352;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuCrzX1JBcnU7x37u5l2XjtD8UIP2PystMQpvNhnRT0=;
        b=s2jEdMPTN3xLF1F4KzAKDuN7JpxK11IUQUw9sTmhfQU+2c9WjEDOJ0ePZY0Xk0xD+4
         Py5xx+ffSMgQIAEiBmJhPC2uMZVWpiVyjnZuceVBZTjWuY76sG7RKPCIz17T9g0CLlEE
         sxpnE4EEXShte1xDAma9oluUy5MXVCjPRVJn6qS0cceQgSHgbveNLq1t8nRJilnsjE5o
         OSSYnhA2M8/id5jCQzQKAg4mOd+GsXOIjAkZ3O4GegmDMlrcmNgh46woAa3T9D67ac1i
         T2dHArV26jhmD8NyLXDNGKIGlsAXwmr7HfJTdFedChMpdqi7UhrlbIwc1sxsQsM4/iiE
         Vk7w==
X-Gm-Message-State: AOJu0YyhHrY1D4T7ak1ykV3yevM2Ys+P0GrWct51CRF6DTevu7gjTSNF
	GhEs7fdzd+R5TdzeugNsKOBq4iI6+s/oJwOW4MpoQmbG4QdaOLy+RFfD5AFW5wyTnlixMJzDsZ2
	9qOge1DMU0VLv1sobprHmd9KFz/SlTLVgv5wd7nA4nlqoaX5jBzs9JQ==
X-Gm-Gg: AfdE7ckZWJ97s4nVoiRDGlnHoGgIisdpuk60Unpp/cJ3D2gOCbYTLYS8XHlpq6P+p1/
	w10M+Vd4L315XJqaQ61eJYqr2kRh+77d+aJFOq7gclksELcSQglqq6TkhLV/JfB4XUMHMfbGLvf
	xb2iz28y9wI2jCgs8LyKzxk2m+EN9IeRdU/B75zV10vUDTOH8c5NR6k9HQI2WQbBN79M9fT/CEb
	RQ/7ZPfqeXYyp9TL5WWH0DWq62erUjh8zPkPeNXnUTQiLapA3kRGFsbCNpo4KiFKdkBwCeLnFQi
	+REekwXmUcapDanmZ700u6BjyiWQnAwZgS0eCp2B/2EXiEdAlSaQDHIL91M0q9nh+sqYvz88CfB
	r
X-Received: by 2002:a05:622a:241:b0:51c:17cd:1fe8 with SMTP id d75a77b69052e-520bc41ed11mr11579041cf.33.1784230552042;
        Thu, 16 Jul 2026 12:35:52 -0700 (PDT)
X-Received: by 2002:a05:622a:241:b0:51c:17cd:1fe8 with SMTP id d75a77b69052e-520bc41ed11mr11578551cf.33.1784230551339;
        Thu, 16 Jul 2026 12:35:51 -0700 (PDT)
Received: from localhost ([2607:f2c0:b108:7100:7e55:563f:1c7f:5ae5])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8ffd50e082csm244573306d6.5.2026.07.16.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:35:50 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:35:50 -0400
From: Peter Colberg <pcolberg@redhat.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] revision: fix --no-walk path filtering regression
Message-ID: <alkylqTvbci7AKLe@earendel>
References: <pull.2181.git.1784198879711.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2181.git.1784198879711.gitgitgadget@gmail.com>

Hi Kristofer,

On Thu, Jul 16, 2026 at 10:47:58AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Since dd4bc01c0a (revision: use priority queue for non-limited
> streaming walks, 2026-05-27), "git rev-list --no-walk <commit>
> -- <path>" ignores the path arguments and outputs all commits
> regardless of whether they touch the given paths.
> 
> That commit introduced a REV_WALK_NO_WALK enum value to separate
> --no-walk from the streaming walk in get_revision_1(). The new
> case skips process_parents(), which is correct for not enqueuing
> parents, but also skips try_to_simplify_commit() which
> process_parents() calls to evaluate whether each commit touches
> the given paths.
> 
> Add a call to try_to_simplify_commit() for the
> REV_WALK_NO_WALK case, folding it into the existing
> REV_WALK_REFLOG case which already does the same.
> 
> Add tests for --no-walk path filtering to t6017. The
> "single commit, match" test is defensive and passes without
> the fix, while the other two fail without it.
> 
> Reported-by: Peter Colberg <pcolberg@redhat.com>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>

Thank you very much for the fix, which passes as well for my use case.

Peter

> ---
>     revision: fix --no-walk path filtering regression
>     
>     Fix for a regression reported by Peter Colberg [1] where git rev-list
>     --no-walk <commit> -- <path> ignores path arguments since dd4bc01c0a.
>     
>     Verified against linux.git with the exact example from the report:
>     
>     git rev-list --topo-order v7.0..v7.1 -- drivers/gpu/drm/ |
>     git rev-list --stdin --no-walk=unsorted -- ':!drivers/gpu/drm/'
>     
>     
>     Without fix: 2026 commits (all pass through unfiltered) With fix: 146
>     commits (correctly filtered)
>     
>     [1]
>     https://lore.kernel.org/git/CAL71e4NjDTHbKR8z7pSrPpzDrX19JOTR04sArm7P=m5ivqkskA@mail.gmail.com/T/#u
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2181%2Fspkrka%2Fkk%2Fno-walk-pathspec-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2181/spkrka/kk/no-walk-pathspec-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2181
> 
>  revision.c                |  2 +-
>  t/t6017-rev-list-stdin.sh | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/revision.c b/revision.c
> index ccbe2e03d1..e990e3f96b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -4419,6 +4419,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  
>  		switch (mode) {
>  		case REV_WALK_REFLOG:
> +		case REV_WALK_NO_WALK:
>  			try_to_simplify_commit(revs, commit);
>  			break;
>  		case REV_WALK_TOPO:
> @@ -4432,7 +4433,6 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  					    oid_to_hex(&commit->object.oid));
>  			}
>  			break;
> -		case REV_WALK_NO_WALK:
>  		case REV_WALK_LIMITED:
>  			break;
>  		}
> diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
> index 4821b90e74..32284f1831 100755
> --- a/t/t6017-rev-list-stdin.sh
> +++ b/t/t6017-rev-list-stdin.sh
> @@ -148,4 +148,22 @@ test_expect_success '--not via stdin does not influence revisions from command l
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--no-walk filters by path (single commit, match)' '
> +	git rev-parse side-1 >expect &&
> +	git rev-list --no-walk side-1 -- file-1 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--no-walk filters by path (single commit, no match)' '
> +	git rev-list --no-walk side-2 -- file-1 >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success '--no-walk with pathspec exclusion' '
> +	git rev-parse side-3 side-2 >expect &&
> +	git rev-parse side-1 side-2 side-3 >input &&
> +	git rev-list --stdin --no-walk -- ":!file-1" <input >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> 
> base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
> -- 
> gitgitgadget
> 

