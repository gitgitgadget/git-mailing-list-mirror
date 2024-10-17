Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B161791ED
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195851; cv=none; b=Kz9UKzKLsO6A62h9TXfhmgNOcCluWcaweFdLTuvf3fI2WskJ40O4pU+W1gpSLPOet2xuh9MTPS4Ki+m0Ix1+MWw9KtleJQAaC4bG6NEZri/kSz89ljQdeH19ViVNdWsOtk+2ErghsOI3it+eXQvCVGGY/SVUMKyDmX3Os6VWLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195851; c=relaxed/simple;
	bh=RutGLJ/UoFTwDc4MUrIjkl9XIXyHZ5BPow9DasDEotY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxJpXR6od7V9+9n3iSEOMEtpMqDS0Gte+F6FkfLi4l0LBPzD/iDYLC8O/fB0DTZiSJw8CN/UaEkQX9kNuXNdC28r2YcVT4okG3k/6Fu8vLU5ubRQSqsKYEQh9J8Q1adOIPB71gGmJ0DDU8rYiBsqMdgbzYq3JPDjZDN5LaGObok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vkHGVRff; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vkHGVRff"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e5a5a59094so12993727b3.3
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729195845; x=1729800645; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ttzj2BGn0sh11SJXKAbJ5JxiNQ2rOhCBxqBpoCxZr+Q=;
        b=vkHGVRffJSgkvkeANIP72W4qQ18L6p4z/VCGPTQqLl4iwUnuHtRPZi8vqj4WCzK6Yx
         RkWf4KuXLvJ6oohqozb05SNpkHZHn8mYV16JtGDJe1IGgUiO1MocltZdhnoW+RJpSnPY
         4e6mmADBENpJP+KJ+cBRZlX9Rk8IRSTrymVE/dgwAQPzKbVQIiaDgvSUUcJTOv8hYFzF
         mz2t2BF/8y96l23yl4DU8xv1LU4Kx/L4p98qvBJckqHU/zyD23DjUyaAYSJqEFaVCDqM
         ThIbcUKHhLYyhUEOna06ITvONnAIKVlBAUGb+yfIEdoR7ZDpnfnJreM8uoM1ExTcyZtC
         EPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195845; x=1729800645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttzj2BGn0sh11SJXKAbJ5JxiNQ2rOhCBxqBpoCxZr+Q=;
        b=gLeW7xCu4mRWtNs4ioZxwgHdIwDxiyPqI/fC9SdENAXm7OfX0P0UYGgAtKWXsZdwCz
         w2emZGo2rxHj+BTbWddJK3nNpP/djDNOFFYPQIkFGPOdkC7lpULkNqdyhv/O0ORH1YuY
         T7tN+vNFAQizcS3Xxwt3hHxMOlNmjP6COQGxQjyKtFagWXOl0d1VbjUtrrauQETCurs/
         XLNYniJCazOZQzLM2qSLbu1yv9EH9wXJKhhUMDa7/t72B9k8MRFxur6RWqdzBRpbC08F
         JrLmzgraszDyj7vaak9FHMKln+AQ6zlJLmXG6QN8nqf5Hg3QfP0AxaHDA1vMiPDKqQy6
         3b2g==
X-Gm-Message-State: AOJu0YyTyOQCO7Yuq9m+HT0wqBDKfWiCkG8RuYuVEmiPBzr3wR6Hyc/O
	+2O5CEBBJ7SrIG06nkoN/KYPG+gkQ/cvnKpJZyII/h0zimRskDlwHnDmdcmdRcc3FKnmygvFhKm
	z
X-Google-Smtp-Source: AGHT+IFgw0etyOZP5pC0aesZN/vkGAvtCvnaZUvmG0ETNvjjHwu/ff0txTU1905uT53+rHbDMJRDMQ==
X-Received: by 2002:a05:690c:386:b0:6e3:1ce7:addd with SMTP id 00721157ae682-6e5bfc5d04fmr2070997b3.37.1729195844867;
        Thu, 17 Oct 2024 13:10:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c00e3eebsm183137b3.52.2024.10.17.13.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:10:44 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:10:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] builtin/shortlog: explicitly set hash algo when there
 is no repo
Message-ID: <ZxFvQsV7FHel/pZe@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241017093528.18157-1-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017093528.18157-1-wolf@oriole.systems>

On Thu, Oct 17, 2024 at 11:35:28AM +0200, Wolfgang Müller wrote:
>  builtin/shortlog.c  | 12 ++++++++++++
>  t/t4201-shortlog.sh |  4 ++++
>  2 files changed, 16 insertions(+)

This version looks great. Thanks, Wolfgang -- let's start merging this
one down.

Thanks,
Taylor
