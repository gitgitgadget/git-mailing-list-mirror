Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7C7BAEC
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735579898; cv=none; b=VkRtFczHrFHHDuCgXzGJWF/b2+Q8VW+r6zXenqkEPj1gCVqmd+K1R2RONldzJnWALvvTD0WVo8ZawQSspnoCaJeBafoZ1wMjqMzraizHKlIaSV2k3OVBNyTxJIwvWXIOS1Wo4/Xz96vSf9ys1hsIqqG7rBfSPWYNRVl+/g4aHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735579898; c=relaxed/simple;
	bh=1OSBne3mSYTBnhMkT4K1s3k7dsWQ7oLG5SDNEFos2Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsiydN7t0l8jiASVtXGDOrOhYMXAyfFiiHua5cPRu8QzPue/hPBf+lzxHy4jL0LXRjv6vKHgIPxPo80T8EnAgZX6b6YyHtqJgK8lJ+vJHPeb4tGemK+uGxEi1mFXqkLNHCyfhd+KXtBzC5mgVfPATFPU+dBVIe2q0Pmg5BcPyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=sHx1A5uT; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sHx1A5uT"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e4a6b978283so11998765276.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1735579895; x=1736184695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3UaTwa06ILhN2K2jJa+5KxjtcKDQxIZcFjt+ah/nBJc=;
        b=sHx1A5uTIZVnOuM1/rhEdwhk8/OZuRH4rhBBi3Um/HnDBkMWzo7UZlQ2x6RzKshMT2
         mq/4xe1VjHfIJZ5032OdiOF2emgkAnMWvIjTxdEu4gAAyL9ekNdQj3eLmdL0NhkktXh0
         qKv/KEhmBp+QHpYzFbJBMhFpwKgywcklk/vucQh+NqC1FrEDg6Yx9Jly6MySK+zQ0JVJ
         ZtctHKIORjUovdVtb+X9ecMVNSLHBaLepUJC3zKXMr8410eYTjJEF4/kxbtvHHp70255
         yPPUCToGmBMkklRkZAzuSHJNOl6pgLpn9jGiaYZvVcCHNX7tg77sOtuxnSvWfWFmnBAe
         iYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735579895; x=1736184695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UaTwa06ILhN2K2jJa+5KxjtcKDQxIZcFjt+ah/nBJc=;
        b=wZfprxOCr+cdtH6ovCm5DV7WPAda88jI+/Mu+DqSeTNZfM6JtQ0dTxpX9gPfIhWZf1
         J4DUj0nfnp0AEkq1KPGBvRy1JcPsZuAEXd/5RQ6hl9TYKozZgJO9WmbmUc6h10lW20eZ
         xMGImpApIIhZFXkJXhsRauD1+qbTwbzaDJKTGIE0MRHbU9KG7027m9cufmuW/gD/WWav
         PlxNa+d/7UP5TjDZcXCctyxNAVFCH2o9+Zp+RAV/U+/YsJNHLUcON9ALIQ+XqgmaX+5r
         X/Z6nQfcfov4/0HGVnoupTcuisg7117w3j4Mam2uBYftaf3s63FKG4jSWqaml5H1Dr/D
         hCXw==
X-Gm-Message-State: AOJu0YyNWSzA+vcERCtfmFBfJVTHdIDdPdSo0xZxDiZtrI40hdjPuQ/I
	t5EHOveIYs2KB4MWw3XJDSEF4d2pGK24xa0YvvUBvUw2d+5tHkl8PYFtdiwwPaY=
X-Gm-Gg: ASbGnctW6OSu3s3Ien5ZqyYzgxPw0spjm9mjkMA5D1MP5zJ0QYEOF/Rqg0jfvAV/njM
	ctmP+gVULY4so4LarmzJP10R/bJCT4FY1GjyryRnwDv0/4au5QQ9WdhgC1BjUlKzK3jLIx0MkuF
	7QxelyB+vm2xDMzX0uaws2GgObAnhdCINn5HUru4Zvh9AgBrzs/ONExv1oFddJbri9yPj8W3oBB
	GviYi2ByJ4ubX8VBYGcC3WjVr1Ohsg+nHuLuIqMYyYBEFd7uvdjCyV5sOQ0BDBOkty4wPuGjcvu
	Mxz2QYJAZoWQjpOOfyU4O3TJWCU9
X-Google-Smtp-Source: AGHT+IHO5pD6UxNAdfHx/N0+1ZwOTPjdy9ZtWjudZwnvFXxeA9E34ygEn/pHbU3BtgwiGjv+DbePsg==
X-Received: by 2002:a05:690c:6b87:b0:6ee:55c7:6128 with SMTP id 00721157ae682-6f3f7e1ca9dmr235853247b3.5.1735579895604;
        Mon, 30 Dec 2024 09:31:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ee173sm56893247b3.90.2024.12.30.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 09:31:35 -0800 (PST)
Date: Mon, 30 Dec 2024 12:31:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] ci: exercise unsafe OpenSSL backend
Message-ID: <Z3LY9gLVdQQWk0Zc@nand.local>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
 <20241230-pks-meson-sha1-unsafe-v1-3-efb276e171f5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-3-efb276e171f5@pks.im>

On Mon, Dec 30, 2024 at 03:24:03PM +0100, Patrick Steinhardt wrote:
> In the preceding commit we have fixed a segfault when using an unsafe
> SHA1 backend that is different from the safe one. This segfault only
> went by unnoticed because we never set up an unsafe backend in our CI
> systems. Fix this ommission by setting `OPENSSL_SHA1_UNSAFE` in our
> TEST-vars job.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/run-build-and-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index c4a41bba0b84df57f6e60aeac2de29dbc0e27dc1..76667a1277720d74e09e8da227b5e0832003e0e2 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -17,6 +17,7 @@ linux-gcc)
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  	;;
>  linux-TEST-vars)
> +	export OPENSSL_SHA1_UNSAFE=YesPlease
>  	export GIT_TEST_SPLIT_INDEX=yes
>  	export GIT_TEST_MERGE_ALGORITHM=recursive
>  	export GIT_TEST_FULL_IN_PACK_ARRAY=true

I think that this is a great idea, thanks for adding it!

Thanks,
Taylor
