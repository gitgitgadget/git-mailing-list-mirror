Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBE15252D
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938612; cv=none; b=UX8O4YWbDJr8V7OXgaSpfrOXzktduzb0VbMdnlWXCuCymlB9o0RE2riQvPl3CYeh2+83M63kK+JGbvFk2EQEPkdQ8hCbrr67zF9h3ZLtZih/AyTbRQHOXnDpScR6xhT0GeO1cF6Kv5ljehe506YPkXSDENUkKyP6E1fOucccBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938612; c=relaxed/simple;
	bh=9WZQ3JXbGT2WD4r4XGIrGY+WLZHlxFAqSVwbRNDa1jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj4eWIUXaB/u3HOAGMteOTf/+C810hOlDRWMtWHtm0GFgksFf1lI9ZmKn893GMM7FJ4A4b5bWLEsCr/0fyq5G3TokqxU1R4AwwKuQWMbdgReZFpQXVzZe8nARMU77D18Qvyo+RLDa8inDREMsb0Rpr9iH+wSbyNJ+3cH70lDZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kVJynFU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kVJynFU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c8ac50b79so326795ad.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938610; x=1729543410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw9pgodNng/NQwatzw4sH1dACOsOQY/IU7uDtsWmzzU=;
        b=4kVJynFU/MtUrrQr+pfbwNYeOYaylL3WgbNMapl/CaaqrdrJPTThoCwQoKZhnh168D
         ljDuWy9D/VMZ742cNXAW+pB/j7wHVufRCWrEmttDQxiQZmUETUKI5dqapRT6n+jSn7U4
         c9+1hHyqvQXY2vJLWXlgRFt6HsQQP4LDzeTuoSFfsDOP1uCzkdw1YSmjlVs9wLRSvUyr
         TL4rLuyXt/qBtyQMfo6jBWm3tcZoMaImIm9fvXMvrijg7dE6OgU9wm1OsHjb81zY2vPd
         bJ14CgNQ+HUtn1YQl7kcVzlBcG1ebiQ+wgs/AS1WK42er5o8/1uK36Pd6aggM0D9FxUm
         DiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938610; x=1729543410;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uw9pgodNng/NQwatzw4sH1dACOsOQY/IU7uDtsWmzzU=;
        b=jH9KEZnHURVK404q3kvddq8uWmBOHWdn3RotL7arABXbpg7jRTRLotTVOC54MbehQe
         OLi2ovaTQRW5tP2spV+05X4YoYeYikJbgrnsoV2Aq89ZmFS8S11YbLvi54y78d84BPtE
         N8qC2hK22NmPZoq8eGzrfqZzaEwWb0Xyv094JkNupWJ5Fhxd2RoX05O7oz4MaQWv5zzy
         O/Goj7F1JNjVtYJDuUH4n0UYJMiIzD/YZAhuB77tkFkR9oeVQaXi6pgJPxHZrFea4uF4
         C+SE4//SBTCwFEhbOuzRglrxl+QXNpUpwqQu/Zk+OU57Hryhhse/4pe2sl3jKrUluvlW
         yJmQ==
X-Gm-Message-State: AOJu0YxxLaPsKJYu5i/7qm0R4f9El9+5S9kWZI0Qik07Pq8EGNAvOHf2
	5Sq949Zv1RQHZAmHN0h83aNwY5l7n9s7whO1/8+vzTIvTg30A5jRwZCHXwMUajhFAYDj+2z8G4i
	6VA==
X-Google-Smtp-Source: AGHT+IF/8TpYcYkCE+Qrc8wqiaFdtW6ccVEz0K16Ewnc9JDLK2hlBLhyNKgk5DV6Cyq0rW7R8so53Q==
X-Received: by 2002:a17:902:d50c:b0:200:97b5:dc2b with SMTP id d9443c01a7336-20cc02b2fc4mr3853535ad.15.1728938609262;
        Mon, 14 Oct 2024 13:43:29 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e664fb7b9sm2581919b3a.84.2024.10.14.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:43:28 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:43:24 -0700
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: eric.sesterhenn@x41-dsec.de, jarlob@gmail.com
Subject: Re: [PATCH 1/3] fuzz: port fuzz-credential-from-url-gently from
 OSS-Fuzz
Message-ID: <dulefctj55gna2kkxohggxwhhgot2sp73flbnx2rf2bucq6ewj@tpvobir5g63n>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	eric.sesterhenn@x41-dsec.de, jarlob@gmail.com
References: <cover.1728594659.git.steadmon@google.com>
 <625b8d607ed2c95e396e7794616d9f290f23d15c.1728594659.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625b8d607ed2c95e396e7794616d9f290f23d15c.1728594659.git.steadmon@google.com>

On 2024.10.10 14:11, Josh Steadmon wrote:
> diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal-fuzzers.sh
> index af8065f349..d9d3ad23c7 100755
> --- a/ci/run-build-and-minimal-fuzzers.sh
> +++ b/ci/run-build-and-minimal-fuzzers.sh
> @@ -13,8 +13,17 @@ group "Build fuzzers" make \
>  	LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
>  	fuzz-all
>  
> -for fuzzer in commit-graph config date pack-headers pack-idx ; do
> +fuzzers="
> +commit-graph \
> +config \
> +credential-from-url-gently \
> +date \
> +pack-headers \
> +pack-idx \
> +"
> +
> +for fuzzer in $fuzzers ; do
>  	begin_group "fuzz-$fuzzer"
> -	./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
> +	echo ./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
>  	end_group "fuzz-$fuzzer"
>  done

I'm not sure how this "echo" got into the diff here, but I've removed it
in V2.
