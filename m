Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35B2652A4
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566159; cv=none; b=X0bB+P8znxVM+cLTp6b4p87I4UNJO04+m5mFB9mHoLGoFFrFuU2CSvaS/Bq7d8PbLiiPniwx26zREK6n8/JQdDLdxWBwQj9vQYY8sVupHqFOC476kjRfXKl6ZOWXTRLaCkEQ/12HdJknE50HyZVTx0hUwyPfqUwSqMYTvrCrcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566159; c=relaxed/simple;
	bh=8po8B95VtAmVLk5r7L8boi4VeYBCSUS5p3heVQyZVeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldV4tFcwop5Be/PosD1tfJ7XlTOaxVBvN2WyVCnF9v/8AdE+xOKkvoM9rn8icojZ+HfMKnfXEbsncKWnB1YpdtJPTJuYJmKtmHuJ5MnPj/6OzMh4vww2WVKONIrg5JiFimg6xFhTfJfWvukZ0oeRUdsg/jaYLBZDORIInqpocM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkxwwopD; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkxwwopD"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7b4f7a855baso57393a34.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566157; x=1761170957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtmPmRP9I/IkOfOWAGW+nuI2kwMf1QWlGFTCxjKlQxQ=;
        b=fkxwwopDLdZaz2/m1ckZbtPEiQ8bS7dWDIcaDV1yIj6uUhjCMmW3lW5XB3mldf0TtP
         ObXzPdTwBXTDeXIkOsXpl3oyvr6LC+lKchTJMqnZ2F2crcbzPxWLqS4YN4r5cDpqZPFF
         RQLhOWZ2pxWXK+sV2GbtQZX0TVdTS1US/ySGHzjuNoheHKki89IkHlhgI30hc7Gxl7LT
         EXDJ1Bd78fpTKFu5pu51ytEkmuoySSEWZ9x80cECqEEkD1WB1ag4Zh7oSe5DJC7UMkcR
         2cxudCpN20ljD9tFvUhnYCpGkR/SQU0orcTRB4lO3YXxQvZWVGMODi1G/BQroKUZH1U8
         ozXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566157; x=1761170957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtmPmRP9I/IkOfOWAGW+nuI2kwMf1QWlGFTCxjKlQxQ=;
        b=i4EjRGRWEe0Ejjxbs9larN0odWcma0qaEBQR0RPQ5V1w/TrX4QD1wPwHA+l+LMxBF0
         e8ju3ICYhk0vbqY/k+Eo9Yk1PyjKlHWXs8tDr1M095jXl83DLtLe5nnn7p47pA5KvRtC
         SLNBXIu8JjQkCjnQzkHjJtAAcM3dGx8Qi8oz3MTxukMn+wA17JfQV2NimSDbl28ag732
         81jvEC3TxxSI9fkpANbEH2NZK9iZmreLN91CWgWXYwHCJkRywAd2A9z33eeWSd6ClVhU
         prEDPkxSdXNKVsr5/iS7CtecvrGAt+YWHzyAWCE9++Nw0pTRuLn2Jr/4aAPMe672iuIL
         fD2A==
X-Gm-Message-State: AOJu0YxT95lK4sN0xaOUWR6VptW+iQ3guuKOkJtxLEpnGufMssAKMDb2
	q5uBsWOCNR70sH8dA8XojjO/7g0t+AFf/qAuHlP3JjTHt0Ukk16jUy2x
X-Gm-Gg: ASbGncs7GcgCPQdy3EF93IR8BL1zpNEQ5QlUWAsSL0VMqF/5kuz2tBAr6Bot1jt028P
	ihXf/jXqnjUwhmcdgrShYxjKlyJG+lrRzsl+QEmnXECyc9h5iSRNjUnRkRROUxEWOwSfaH/JMhX
	5d9N8rMXcxpaPCuDUH75htOJZZ+ZEGiNDHJQNQf51Ss2EnkYtd3Ag2epwvGXJvfFhEZOlD/sJLy
	hQjH6VZG/AE2AJZmvPCOvljfs4s37LTrCqNR0P90PIAFEHL5aTVp5lH29eKfzg7R4FvGuxBwkE9
	LrCyHKzeMCnKYEEfDIqf209gmVd9aF2rAgpu9qBgwY1Z+SDroY4Gtg9XV/WJQ73XmleqGhrZ6qy
	WPtlTkxiD25QAQCUFAj1qh0WBteinG2GMTN+8vChHMBPR+hvnw9diR5DEIqCYLAH4wH6hSw==
X-Google-Smtp-Source: AGHT+IEzXNI23P4OJuDlpTxDLQjW5VzEJYM0IQ1MUO21spZ2yFJtWZgW6ROZHRTbO0dD+96b8Bebvg==
X-Received: by 2002:a05:6830:d10:b0:746:d4cf:b480 with SMTP id 46e09a7af769-7c0df6a582emr19379186a34.6.1760566156796;
        Wed, 15 Oct 2025 15:09:16 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c0f90fb4a0sm5712997a34.17.2025.10.15.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:09:16 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:09:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/4] refs: cleanup code around optimization
Message-ID: <wlq4kncpjgbsnc6bjhusgu32d3apagcykax2tquotdanyfejcy@2k4tlhv35fxy>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-2-550fdd8a3b41@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-refs-code-cleanup-v1-2-550fdd8a3b41@gmail.com>

On 25/10/15 11:25PM, Karthik Nayak wrote:
> The previous commit moved all backends to only use/support the

s/commit,/commit/

> 'optimize' function within the `ref_store` structure. With this, cleanup
> all references to the 'pack_refs' field of the structure and code around
> it.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c               | 6 ------
>  refs.h               | 8 +-------
>  refs/refs-internal.h | 3 ---
>  3 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index a41a94ae55..b9a4a60646 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2313,12 +2313,6 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>  	refs->gitdir = xstrdup(path);
>  }
>  
> -/* backend functions */
> -int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
> -{
> -	return refs->be->pack_refs(refs, opts);
> -}

Ah ok, so we are removing `refs_pack_refs()` here in this patch. Maybe
we can just squash this change into the previous patch. Probably not a
big deal either way.

The other cleanups in this patch look good.

-Justin
