Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7577494
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552423; cv=none; b=jq3HDHkqcXHLmLWlWTlEary61LFGPnhhqXnXNwmX+RBqev9fvWnAxFpG9fosJ1xCvVSXBmz63mLAfuGspI3MWeDmE4EsXXBLHnpKjpQ2iwhFPrevpnUzDZfwpn6j1gSFoVcT8v4lVcKJ2G6InNn/y6vMPHLX6j36ZLk3OjL9nvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552423; c=relaxed/simple;
	bh=moaylAbfbPmy4ul+prmmtTy3LyPN1fL3zX1LLmHLCuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qe/sjGpIhclZEuXsgKDFG5Upl/ikEynmRsb00ytEb0QwzHhVZQwI36zo1E0ZO9pVLdljdEegNKlks4FRMoqUQvMzOCURZq6NGr/WK/F5+lYMhotuWtaWjl0ipj1SyXfBmtqiYm59/0sUgHjlT0/+UhqAxeomWm/dkT6VWdRgNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgExLHoC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgExLHoC"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a4b48d7a19so2201104a91.1
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713552421; x=1714157221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1/j7gNdC7d5vQvfJo80iF5LlQmxrdZgDvHoBFO6DIo=;
        b=qgExLHoCkKvuwi6TKJwFZj+4IM2Z9J4RZGi6gXExDNcK/UqIrQyQct/KiHwO1KnXlF
         cA1HDMm27a9zg9PyY95cBhKRcS1IuTw6+fyO/t8FO27lk2+TfhKkYQP5ItVq6+4lHCeb
         O90xZhRDxIhd+Uhj7kPiMNjooFgpPUI3x19OXFVXWcaqWCXRzD9NkburGG5GAvJIA6sg
         7rL1m2nghCBPWc6cJ4m2RQprEO4a7U/kkK5fbuyKhlTPGMeRao7h9cXps5PUoXCB89Gr
         o7IPc2B3jG3aOxnQPaH7NNB5+uPs852pMo+2f4HSsYWltKEI+EHzVFzdPzNwyV/aIspX
         zfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552421; x=1714157221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1/j7gNdC7d5vQvfJo80iF5LlQmxrdZgDvHoBFO6DIo=;
        b=PXGBdf/DKFMlPtEFbnmV4Gt3lCimkZJzgVoDrDdxITZfu8zzJYr18OpjR/ToLrmuXd
         +ddl9EIjPBjD4GuxmIfTjrEqJN/Y9dk7Vl2grEafXsFJ9lgtxAlQboi1aLtUYhhZKBwA
         Lkf9CK+E5FBhbHrPB2Jv+XhmnWjstBlpitHmLSRtx5Yp5NTz//R/CPOy8beCdEKdZ1Q/
         0ZeSpzX1Rjl/OePcJ4d9WrNgoeufMLHhe9RhAUrNEdyn1hC2TuOXdeNTHkKMHxIgqD08
         uvzRVGLg1lFhK8vEE24ioE7ZymvxX2IIEZ4R/kY0kSgELfAuFkQfbUOJ19GlI646Ri8b
         L+SA==
X-Forwarded-Encrypted: i=1; AJvYcCXAPTy9ZQ0GcNXKW5xPZQ9YOcclPw96sSgQsLkD/gAUdn6lV7rX8Nj1ziP4sK+5Z+EUmGT1LuCHXHDIdiAqS1Qr0ssK
X-Gm-Message-State: AOJu0YyYPjL3qYbN8JZN/lLl/rg658A8CYhRSb3J175KRMIWHL4+JMOM
	AoDFagRkD1D8/rPMfF3FjmeyWsm/rzRF6qNkJO1Trs+iwby1+5rJgGPBUqRbpdRPkV0pNR5JSsE
	AxA==
X-Google-Smtp-Source: AGHT+IFiEF+SVrpB+Z1bVAM+BjnvX22WvyGW+QXcLGM3qgFdarXgZrsd3h241P5uzJjYfeiik/AnouN/ocE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:8a:b0:2ab:b450:ea9 with SMTP id
 bb10-20020a17090b008a00b002abb4500ea9mr34197pjb.4.1713552421267; Fri, 19 Apr
 2024 11:47:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 11:46:59 -0700
In-Reply-To: <e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
 <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com> <e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
Message-ID: <owlya5lp5gws.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/8] trailer: add unit tests for trailer iterator
From: Linus Arver <linusa@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
> 
> [...]
> 
> +		{
> +			"with non-trailer lines (only 1) in trailer block, but no Git-generated trailers",
> +			"subject: foo bar\n"
> +			"\n"
> +			/*
> +			 * This block has only 1 non-trailer out of 10 (IOW, 90%
> +			 * trailers) but is not considered a trailer because the

s/a trailer/a trailer block

> +			 * 25% threshold only applies to cases where there was a
> +			 * Git-generated trailer (see git_generated_prefixes[]
> +			 * in trailer.c).
> +			 */
> +			"Reviewed-by: x\n"
> +			"Reviewed-by: x\n"
> +			"Reviewed-by: x\n"
> +			"Helped-by: x\n"
> +			"Helped-by: x\n"
> +			"Helped-by: x\n"
> +			"Acked-by: x\n"
> +			"Acked-by: x\n"
> +			"Acked-by: x\n"
> +			"not a trailer line\n",
> +			0
> +		},
