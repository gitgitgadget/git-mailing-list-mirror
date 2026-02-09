Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39D37F8AD
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660433; cv=none; b=T/PYdiUgT/FY15uuik7DQfwRsyyE1UEOhGonsGEDdL32O9TI3fb2SApoINQOpj04WAKNTH0ZcaMuSoIrbNfDEnIS946OWDntgC5qn12wTcz96T9P4Xm5KNHoQ+HhwCsezVTeLzT6RC8nQpbH6Tl+htJcOQZ7GUVu2PpjQ0HBQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660433; c=relaxed/simple;
	bh=s+WYZo714Rnlv48UtjZf/jC4jTotJHihdwLmJt4Oe9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I39m/s2K/d9kl3Ihbr/AIKrgjDnoubFPwcGEIGxItdM4WDhB9qv57r61CvZCZZrsNoeaWfWtlGFfixwY+4lvadpumeMRytZ6kOJRtNHPBxXHMSi2iD+QM9ejIanqdjm8+WB3k47TrvArZ7pm0scdQAHZ3EAS63C8EuZmjmPwRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUJov6FD; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUJov6FD"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f194e9a98so1393331b6e.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770660432; x=1771265232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8baVbVrWy5IQM19U8HUJGcKlimCpIUPKD0yY5yeA40=;
        b=UUJov6FDB3yLQpBGVAJI0YdVO3Pgx2LZ5Il+c+x7Usq4pxwJHNWBvDvcIPuFtYIKdi
         VioHdfYHKLfs1mPbe9yyB/rLuOkkdUolp2Cq5C2Bt/DU0Odvg9WnF5EOkhicm7Xwhgcs
         3MmiqzU3Ujk3KwqCFqqQnzhB86/EcBR5ozGAN+QpNQCL/akMaftJaxF3N7aAdOwPPCN/
         H/30Yqu8qgT1fd1IcPhO85Pk64HIkr5LlL4XFHTqzczc2ZthaDZiyrdLDaesFdossaMD
         iMsUtWU8PSeElhhxvGjAwPTDUN8yN3Kw1mx6wEQyS3/PO4ZiJeOTJB9/TYsmg+OAMNOo
         8fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770660432; x=1771265232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8baVbVrWy5IQM19U8HUJGcKlimCpIUPKD0yY5yeA40=;
        b=ZizqpGgdrG88QUcnsJ0/hUTjpZUhY2tumI2swcMMcHDEo6vDPD/FIQlTvQLcdvQPXj
         hWXStO4s6r0sF+2vK7dYhLW49LThwzTz0IMRYS9xhdrCm7ehoUpXHPPdUvDDJnXuFaeb
         N4Vv3R3AyRDHTtKuiTL1lpf93wRGRj2KXnNDToXSc7ZLYjg0YRzABnmuI33GIDL6DZY2
         fAF9+HLL1QhUjAAZtn0LG4M7DHKBuFSSpu36sSnxeUAgpNHrXxksUJxU2SbbTjhyIe82
         fKvTlD1zEvD/5wZrBEbm0BgYo/bSBMxCurjnl0CmIAlqk3+hLNSWbVHkLlRZ3nXBQyFO
         WAGw==
X-Gm-Message-State: AOJu0Yye4j1nteQbIuVnpfnXMySHcjJCYqmOH6EVK2mSHXovSHvCovmw
	to3tfWNU7AEX+V5R9G19ro9oHhz6dmX6tdxuFVo2EIIBItKVh37BsLmbmrrAxg==
X-Gm-Gg: AZuq6aIa0jPwi6UDZlKYzOfFKlFRPsBJoLnbIpM6bdSq5z17mQaZLbr7sCFXzuGOcsY
	FvZosLYltD7NCw3hWZwXi9uxUrNp5s6ZbSiZY03KgvZDwdaLAVIIMN1v5qWNRSz51pJ234SCKky
	augXdShWQPiP5HWoEuPYnY0zjOdpcmehF0aQYD34KtlPPjfk42GMpgsIM2wNHGcaz/JACqEJ9kN
	cvljOBaoNyOv8oo7UcYx5ciwd2YwWBhEFyilvhfaEyYI5FwE7z+4KdnAbJl3KWF7xrdMTo6iiVF
	9HTwX3nJwbJnos7MP3RgklpLxutunYA4YZPl+nK/lEl962EN7YO1ANP2USXn8arQ63aMBCe9G63
	Jo9GlSGS+kGBpBUpi1Nu3zR15YvsPPkfFoOm6pz+0FtFYFXsPbO2RImFpRgLjo7a4tjWYiA5HYY
	YPwANW
X-Received: by 2002:a05:6808:c1a8:b0:45e:f91f:6529 with SMTP id 5614622812f47-462fcb7c8f0mr6742878b6e.65.1770660432377;
        Mon, 09 Feb 2026 10:07:12 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb5455dsm6724545b6e.17.2026.02.09.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:07:11 -0800 (PST)
Date: Mon, 9 Feb 2026 12:07:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci: don't skip smallest test slice in GitLab
Message-ID: <aYofxzIvnhv3arR8@denethor>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
 <20260209-b4-pks-ci-meson-improvements-v1-2-38444dec4874@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-2-38444dec4874@pks.im>

On 26/02/09 05:56PM, Patrick Steinhardt wrote:
> The "ci/run-test-slice.sh" script can be used to slice up all of our
> tests into N pieces and then run each of them on a separate CI job.
> This is used by both GitLab and GitHub CI to speed up Windows tests,
> which would otherwise be painfully slow.
> 
> The infra itself is fueled by `test-tool path-utils slice-tests`. This
> tool receives as input an "offset" and a "stride" that can be combined
> to slice up tests. This framing can be misleading though: you are
> expected to pass a zero-based index as "offset", and the complete number
> of slices to the "stride". The latter makes sense, but it is somewhat
> surprising that the offset needs to be zero-based. And this is in fact
> biting us: while GitHub passes zero-based indices, GitLab passes
> `$CI_NODE_INDEX`, which is a one-based indice.
> 
> Ideally, we should have verification that the parameters make sense.
> And naturally, one would for example expect that it's an error to call
> the binary with an offset larger than the stride. But with the current
> framing as "offset" it's not even wrong to do so, as it is of course
> well-defined to start at a larger offset than the stride.

It was also suprising for me to see that the "offset" could be set to a
value higher than the stride. I can't see any reason that we would want
this to be the case.

> This means that we get this wrong on GitLab's CI, as we pass a one based
> index there, and this causes us to skip one of the tests. Interestingly,
> it's not the lexicographically first test that we skip. Instead, as we
> sort tests by size before slicing them, we skip the _smallest_ test.
> 
> Reframe the problem to instead talk about "slice number" and "total
> number of slices". For all of our use cases this is semantically
> equivalent, but it allows us to perform some verifications:
> 
>   - The total number of slices must be greater than 1.
> 
>   - The selected slice must be between 1 <= nr <= slices_total.

This seems reasonable to me.

> As the indices are now one-based it means that GitLab's CI is fixed.
> The GitHub workflow is updated accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml |  2 +-
>  t/helper/test-path-utils.c | 18 ++++++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index f2e93f5461..2b175dc5c6 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -150,7 +150,7 @@ jobs:
>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
>      - name: test
>        shell: bash
> -      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
> +      run: . /etc/profile && ci/run-test-slice.sh ${{ matrix.nr + 1 }} 10

Here the GitHub CI is updated to be one-based indexed. The GitLab CI is
already set up that way.

>      - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>        shell: bash
> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
> index f5f33751da..874542ec34 100644
> --- a/t/helper/test-path-utils.c
> +++ b/t/helper/test-path-utils.c
> @@ -477,14 +477,20 @@ int cmd__path_utils(int argc, const char **argv)
>  
>  	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
>  		int res = 0;
> -		long offset, stride, i;
> +		long slice, slices_total, i;
>  		struct string_list list = STRING_LIST_INIT_NODUP;
>  		struct stat st;
>  
> -		offset = strtol(argv[2], NULL, 10);
> -		stride = strtol(argv[3], NULL, 10);
> -		if (stride < 1)
> -			stride = 1;
> +		slices_total = strtol(argv[3], NULL, 10);
> +		if (slices_total < 1)
> +			die("there must be at least one slice, got '%s'",
> +			    argv[3]);

Here we validate the slices count is greater than one.

> +
> +		slice = strtol(argv[2], NULL, 10);
> +		if (1 > slice || slice > slices_total)
> +			die("slice must be in the range 1 <= slice <= %ld, got '%s'",
> +			    slices_total, argv[2]);

Here we validate the provided slice index is in the correct range.

> +
>  		for (i = 4; i < argc; i++)
>  			if (stat(argv[i], &st))
>  				res = error_errno("Cannot stat '%s'", argv[i]);
> @@ -492,7 +498,7 @@ int cmd__path_utils(int argc, const char **argv)
>  				string_list_append(&list, argv[i])->util =
>  					(void *)(intptr_t)st.st_size;
>  		QSORT(list.items, list.nr, cmp_by_st_size);
> -		for (i = offset; i < list.nr; i+= stride)
> +		for (i = slice - 1; i < list.nr; i+= slices_total)
>  			printf("%s\n", list.items[i].string);
>  
>  		return !!res;

This patch looks good.

-Justin
