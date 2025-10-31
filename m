Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECA2F60B2
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930154; cv=none; b=BICyIlvFKUV66aOIb0Kj5Kc/qgO8q/xf1ddv2nvHiPLf4ToxnHdXENTALYe4alZRqi3Wy064wbUSboEtIPOhHeS6Y7b0JK5oYM0OcHMC7YCvpTxg0izZUCG/ezOPLr21x4p4BFu4FOKKKtoPt2rn80yIN8yl1bIsd6o7HNTFYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930154; c=relaxed/simple;
	bh=LI5HT+x1LSldHj6LgQXqgnOG9UZoqVioVw08fVBdwr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQF6bQfKhvjptP1M1gpc5kmg6JWt0LwU4FBnP5tO7ztVzXNh2B4Uxg0UytBQS7S6BA5g/lpMWX0My1ZsfbnxE3u8PQbODKcb8sdSg36mXKVD2TAFY10i7rPa/65v69GA1y4ahSN6Ol2NRKN82hEtaWUHHzRKtwy1nPYhvwxkD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH8ns0ij; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH8ns0ij"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d3ed0c9f49so779478fac.3
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761930152; x=1762534952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHPGH0Aj9LroqzArR8tpdS9tOlV3IVBAvhrrhx7GPIE=;
        b=BH8ns0ijhsEQNvEkiIl079tJDRXrLK/EL6/91WcDnmRCURgIlr1xVmEfWOmf0j0jsq
         go+s9IFWEo3TvU1+EyePvWuIS6BBbxZX55R9SxnKyEJy7NI+Itv2V5SwibY4BICRwh9y
         pph0SJng8kBTbr1vEtUUvwSqpEIL2XxRfGRmMsdAoNhllk365YMgSNTywU0r1OvWeY+X
         P5iGyGD6fePmDu6mtquLUBanS8x+YQUo0mKRfUGwjbAuQVHPXd3g87CtNDi0ivS7T+sJ
         lzijtICdSsHdVchGn1U2KW7evll1oE5OkegK3TABBiLa1wft7DOby2JVKjcm3rZEtoIy
         v2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930152; x=1762534952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHPGH0Aj9LroqzArR8tpdS9tOlV3IVBAvhrrhx7GPIE=;
        b=pkMV3m822PV2D38ULT7ZEH7RSrj5oiTCCxxh77uAHu2ZGijKTLwhIOfdQ1YmKTyRli
         BSUfBPi2ce9cDd4wWLGKSvNbld5IkDBKeOiL6NonyRwpYftGzVQRJmipQ6XOJsHOrYip
         ln8uqhjipxXhH8El/H9lh3WR+iCUmtRjNZujNSPmnlGYWXYQrvf3bck3kubwj8Yqm5Ph
         t7HidumB1GTzINwMeaYwvyIMVhf4R4kJ/S2Tg6jNivxgoj6PkcuvG5j1ebQiqB8sWeFa
         lejW+/U/qmDU5/vbxc4MwRSwakWsCuS5iBkrwT7eUuxVPZje6aRB5kbsXGxoGkFBLSs6
         eL2g==
X-Gm-Message-State: AOJu0YydcoKywiEEKATKHOK4HF/oUrONIAgUEVQOujb9hUHdQLaOHSJR
	Tb6Ku9Pobrr/SBCLzW3HQbUPLx21z+n4hS3+ymaJVDN0XMQw9jKPexvNtaZEeg==
X-Gm-Gg: ASbGncuaI5eJcrPPYyasJP54+L1PE+WB5BXhuHy20CpmVNdyBNGiZTM8VGJJoKim+1D
	6JTjsBNBVYOd9NfY5qz6DYGiDROFhVMvy25jX8s1A3hw5hitXClZ8UlMjbL2PVSKylYYolTPTuI
	dqeF4XqOFnd72gqtt5DHXR2E57c3TdAguqD2BSUgw5OMG3+P20ikL541BNKS5U+p9JzRiRTsydm
	wde4hixBLz3bxouLTq3jTktTkastguYsmxOxwVEgPH1HWJ9ZLJNFGPB0k4JBGJWsRy3P0QQGbF0
	YrrfBeGOjNlPzCQ3vkXBj1GDDiaZjN2uvtb837nSqYSp/BHcsJ1IXE8E4F32GN1Lvp2Wamo4qFH
	zzfujNpAnH9EZwTsE538OHxa7jKvmPjnEMVwCJXxI6RwopahIYHz6srw/AYKgR/W+29CGZQ==
X-Google-Smtp-Source: AGHT+IFPXxNSkIgliNo8dOA1R4skcSHvVzuY0M4rOenGrSc4iBMzP+gIObfVNNeBmWoFT1D+JBWBOA==
X-Received: by 2002:a05:6871:4e42:b0:315:c0bc:4bb8 with SMTP id 586e51a60fabf-3daca006117mr2316393fac.2.1761930151677;
        Fri, 31 Oct 2025 10:02:31 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3db403914fbsm735296fac.5.2025.10.31.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:02:31 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:02:25 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] reftable/stack: add function to check if
 optimization is required
Message-ID: <tdgxvocyp2armupgbti2wnbjphdvidooddbdyrynmdokjgqr3o@tzrbu5lcgipt>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>

On 25/10/31 03:22PM, Karthik Nayak wrote:
> The reftable backend, performs auto-compaction as part of its regular
> flow, which is required to keep the number of tables part of a stack at
> bay. This allows it to stay optimized.
> 
> Compaction can also be triggered voluntarily by the user via the 'git
> pack-refs' or the 'git refs optimize' command. However, currently there
> is no way for the user to check if optimization is required without
> actually performing it.
> 
> Add and expose `reftable_stack_compaction_required()` which will allow
> users to check if the reftable backend can be optimized.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  reftable/reftable-stack.h       |  5 +++++
>  reftable/stack.c                | 25 +++++++++++++++++++++++++
>  t/unit-tests/u-reftable-stack.c | 12 ++++++++++--
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index d70fcb705d..a875149439 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -123,6 +123,11 @@ struct reftable_log_expiry_config {
>  int reftable_stack_compact_all(struct reftable_stack *st,
>  			       struct reftable_log_expiry_config *config);
>  
> +/* Check if compaction is required. */
> +int reftable_stack_compaction_required(struct reftable_stack *st,
> +				       bool use_heuristics,
> +				       bool *required);
> +
>  /* heuristically compact unbalanced table stack. */
>  int reftable_stack_auto_compact(struct reftable_stack *st);
>  
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 49387f9344..18fa41cd5c 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1647,6 +1647,31 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
>  	return 0;
>  }
>  
> +int reftable_stack_compaction_required(struct reftable_stack *st,
> +				       bool use_heuristics,
> +				       bool *required)
> +{
> +	struct segment seg;
> +	int err = 0;
> +
> +	if (st->merged->tables_len < 2) {
> +		*required = false;
> +		return 0;
> +	}

Both `reftable_stack_auto_compact()` and `suggest_compaction_segement()`
already check if the stack has less than two tables. I wonder if we can
avoid having multiple of these checks by instead having a single one at
the start of `stack_segements_for_compaction()`?

> +	if (!use_heuristics) {
> +		*required = true;
> +		return 0;
> +	}

Is there a reason we would want to skip validating the geometric
sequence and just assume it compaction is required?

> +
> +	err = stack_segments_for_compaction(st, &seg);
> +	if (err)
> +		return err;
> +
> +	*required = segment_size(&seg) > 0;

As mentioned on the previous patch, I wonder if we could just return the
number of tables in the compaction segment as part of
`stack_segments_for_compaction()`. A negative value could indicate an
error. All other values would reflect the number of tables to be
compacted.

This way callers interested in whether compaction should be performed
could just do: stack_segments_for_compaction > 0. We could maybe avoid
having a separate function like we do here and just expose
`stack_segments_for_compaction()`.

-Justin
