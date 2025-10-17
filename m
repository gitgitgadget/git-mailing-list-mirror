Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB6284883
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734727; cv=none; b=euObHYLHwxP/WuenyTlprzVOcuIVUUibnRMzX1HNKmaHB+Jk2PRM+MPCPaTim0yx+3+hjP4NLhuWMZB/wVoO227x8dvaybuV0T56KWHxP7UvnYz6Vla44k/BnWJzjtXTq5485CuJ/Y6Mza+p7MjLmBJNUpr4axoMA2DJR6WgTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734727; c=relaxed/simple;
	bh=Qe4v3qXRiEQvMOjSZrp3R3OiiOVn8sB1gU2hlyy8jEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5caU91/1YZ2n0X2D5A9B2RqJ7AKhUPxjfxJXgitNZGX76qGNQ/wDa7OF2Za4kNh5HoZh67sfi4ae2/dAMCS3TnJ0Ozz6kprOECPRRFhuPInukdDF4UsRMF3B5qy7QptL42dHi7hBcGCUsoJSqzttEftojjnuyxKA4cZhPf9ZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nZ+8J5Rh; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nZ+8J5Rh"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-91f6ccdbfc8so113721939f.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760734725; x=1761339525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ6zpiEG4QK8iLz1I//9l6urVs9vzPPd8pcgkeXt1WU=;
        b=nZ+8J5RhJqYx1iW1DOhG8m8NdgCej01M/vcWXJA8rR0KfGxG0FdUtxsX1pp731NvOL
         qcOpjB8WgtPz/2t9/jZXwDYdPDp20ncF7OpzwG4r3yYgty8pabMZsjFKRRkMLEFHTYCc
         qXe86YqLvhx4FU8meHAGkb9UNd4GOrCjxucywzYXauc64M3udn+Dm5xSGwPv1Sf8+fD9
         UQzBPcWFCUvEBDDimHHNeaYNS+PgIh2EpZFa+MvMunan/XToyaEbSx/Vvd/+0t7ciCnX
         MhogWIe/PTuYwBjYiPJ3n4Bcs81bOat1hLUMHN6jBoiKHZimsYvboEtQBaeUPfXJuUah
         XR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734725; x=1761339525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ6zpiEG4QK8iLz1I//9l6urVs9vzPPd8pcgkeXt1WU=;
        b=uqY0m+QKqNu1zbpEv8M0YuvRwsAif8PAkAL3PgE22lhfhhzQa0gF0RyVY6F1dBDKLs
         3N3IGlHJCSBFa3MNaIGZU0SSE8MRsEpMJq6HTuxvGa+jq+5KBgHNu8qNWxlXrPCe2d11
         rCbPhQqqpRR24wyIKaF2ZD61qdLixsk7dOyZuhzXJ+E0mGE3Y5cmsurdSWA/ERBP+zRG
         dbsBbsgWwElxYwd6bVCoSvtAgVCP7PgZZ0wQGBnh8dszUcEvbkYwbeDouUK+VMFVTpeK
         nOK/oB4r/p7BcFMjHVMqlBqH1LYfqpETPHTZdBLGrCWnyZadsa2S9wS4ppAJ90hyyKd4
         XeXw==
X-Gm-Message-State: AOJu0YxEPybcCaUpXb94yvru9fHW3jWoZxYbn/FXZdyqQLs/1gymbgDL
	EgvtgHEKTkjyIJLnUKKApCAjZWFlpRzyispU57n1YVvpI5YjGAsztfsH1oh0NuvNUWo=
X-Gm-Gg: ASbGncvn0DF3RkgPSbGmJucCcjF261JrLUk6qGy0G8ksSM16zJ4uwxYd00hZz0MLe4/
	C7nV6AFLTtP5/1o+AFZv++xZVwn6F8YTRGYMyy4Z8XfUkQL30aa2wgU8ps4i8PLUCjNxS+SQSGz
	BELX1lzweoxny6n0Azfh55Zj21KYwBwyT+P+m3mNr/79eBGruyXaCe/Ge97IakLjOmQMYQiUg7x
	uWx3ej6TsGWw6U52u5GG9UP241kXQVmMWpBtzLsQot1mp9MXADxsdNpDd693CM1PhIiXWpVLwQM
	4RdSh4z+fWp6mFJJuSkPYTfn7jWx5HWF5zE8kYdSAnX5dXWtFjHRN8Wcra1p2MRSHM7oSd8rPes
	z5VBRSvEBzHkZ/sr3dRppbuiybgl59uSCqA4dQqVUf+rgU4pYBAQLJG1yZRW6a8wwaAub9sRYtI
	cKPA5nmkQ67XN3ZtbFpU87P4QGE2TxmXq6J2Z3Zj2X68iXEiyn4Yp8uQslOJ6ntt//EuqfICoqe
	BWD3eo=
X-Google-Smtp-Source: AGHT+IFYs3csfKRIlTzLBRFGgWGQn3nM+CiyAu/kN8GWvbPkOLI2QbsFJqGDKiRJceH73LdYIgQNfQ==
X-Received: by 2002:a05:6e02:1a66:b0:426:c373:25f5 with SMTP id e9e14a558f8ab-430c527dc0bmr73481305ab.17.1760734725002;
        Fri, 17 Oct 2025 13:58:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-5a8a9768b98sm243408173.46.2025.10.17.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:58:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:58:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/8] builtin/gc: remove global `repack` variable
Message-ID: <aPKuA37Y0Yzl4bpn@nand.local>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-1-18943d474203@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-1-18943d474203@pks.im>

On Thu, Oct 16, 2025 at 09:26:32AM +0200, Patrick Steinhardt wrote:
> @@ -1269,6 +1272,19 @@ static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
>  	return run_command(&child);
>  }
>
> +static int gc_condition(struct gc_config *cfg)
> +{
> +	/*
> +	 * Note that it's fine to drop the repack arguments here, as we execute
> +	 * git-gc(1) as a separate child process anyway. So it knows to compute
> +	 * these arguments again.
> +	 */
> +	struct strvec repack_args = STRVEC_INIT;
> +	int ret = need_to_gc(cfg, &repack_args);
> +	strvec_clear(&repack_args);
> +	return ret;
> +}
> +

Thanks for calling this one out in the patch message. I think had I not
read that I would have been confused why we were putting contents into
the strvec here just to throw it away, but the explanation you wrote
above makes it clear :-).

The rest of the patch looks great to me.

Thanks,
Taylor
