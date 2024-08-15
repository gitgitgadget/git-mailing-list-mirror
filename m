Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FF405C9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754191; cv=none; b=jv9PYmcsP8VugSWVD1KcUwD5oN4IR4ejg/wYDzcoiLepw7DdFbqQuHPSE1hJCscI60Uef06IMpr9iCxqHICbK4T0pbjrkSnJS2gCXsEBiVXXKSynVSj7/0qJuhqTso48QA8fqdDTw5KF/y+5nf6ZYMdepjWsZMuosTap9JpunOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754191; c=relaxed/simple;
	bh=+gCxJkgRQ3cdsZsoihjW7iM+6ST99OrN70itPbTNcQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJZOaeXJ8MCOADHhGAr6bSxi+oG6aElbRlLIThJdYpsr9s1UQ+8BNkJuuGl9swqqJQNH6Xe0eocsyAK10aVfGCBtzkahYcTYu5GDNYTlhzGl2XgEobk7xZK1prvFMSyWMlR6aLsCICFMVN6XO1Sycoa+1gp+ZIb7DeQDlNk1GUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpzVnRej; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpzVnRej"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db18102406so738962b6e.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723754189; x=1724358989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HGD7SjstGy8OzMbt2LYL0XMM02FbSpAe+dlpk7r3nY=;
        b=DpzVnRejKIF92etuLLo6WLf7fLBPDHeBYQATJp85AOPyN+YbX8in+UaCfRIvgHMZQm
         w61DnJPpqCim8/6kJA1Xt50Wd5tNvXv9O4QRRSDs4s1dFsQvwDdMhLkZi4dIGdnG1yP+
         6D7YBs983mE43/N5Nmsyk8plIoxKHwmf+r+zSCzwxDgzCJx+tPFsVCEUuMtQQqyO6icc
         ZLbexeJSalUAvBd5ox/oHjMGtP3cSTSGmu/x6odbTo9e6gCBWVGIBQxqbcttiZZi7KCo
         F8rLaPqfLOP2iyoTWeQoTFyfawtyteUC5e9858tygU/aDes3mPz/DFdPnQXjsTBi0oSq
         8j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723754189; x=1724358989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HGD7SjstGy8OzMbt2LYL0XMM02FbSpAe+dlpk7r3nY=;
        b=eP8lUE0ExDOPfc3vp0tQ5ANudOTwpD9mc48n086AA0QCw03y60iXyAysmrggLG4kZ4
         b0+I/ScohhLI7nW73XgIOol+edsiute+SW/CfA0TLVx6d6tRBrTXVPxDp2N8Ls6UgXr3
         IDXAILDj9ui3o+0ZK1hEcyUX5oNdFUmjbxOArMwphEoVzZscH1F2UxaGYP2XiPEQLyy+
         Wb16wyrN4oZr0uriHh+48YU4KSpgddlVIVr2hQ/RJ7miqGLODgiW0BJibCvTJcgiHI2R
         lNlgQeAwJ3tqzpIZVnhFomSPk0E2DJMBHfmSbLn+NuSwJzzB9zHAPekxUBHDIqCjFk94
         1JMg==
X-Gm-Message-State: AOJu0Yx8WgOq3AnCicvpd56+ti1DUO45BmRHXIpN5kbk/+BYXm307ptx
	lfCmNgvvb8zm13oYJXL1QgSrFixz2SB9i6Voe1/SN3pRrhy6WQvfCVfbgw==
X-Google-Smtp-Source: AGHT+IFrpUAc4jafjDXTH5W08s4pX82sFFY3J0XvRkysVpLRP8yhUNbz96XCt5BsMrsf7QMx2Pworg==
X-Received: by 2002:a05:6808:1404:b0:3d9:2373:e75d with SMTP id 5614622812f47-3dd3add3e9bmr585706b6e.35.1723754189018;
        Thu, 15 Aug 2024 13:36:29 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33f09cb7sm402437b6e.57.2024.08.15.13.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 13:36:28 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:35:38 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/5] t0001: exercise initialization with ref formats more
 thoroughly
Message-ID: <vivxxi4dylb74fmplbcizsslldsracntksmvw6m4m2yqgf3zp4@itwngidkrswy>
References: <cover.1723708417.git.ps@pks.im>
 <0d3844db32237983a1d85ced1a3b1b25fcd1d6eb.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3844db32237983a1d85ced1a3b1b25fcd1d6eb.1723708417.git.ps@pks.im>

On 24/08/15 09:59AM, Patrick Steinhardt wrote:
> While our object format tests for git-init(1) exercise tests with all
> known formats in t0001, the tests for the ref format don't. This leads
> to some missing test coverage for interesting cases, like whether or not
> a non-default ref storage format causes us to bump the repository format
> version. We also don't test for the precedence of the `--ref-format=`
> and the `GIT_DEFAULT_REF_FORMAT=` environment variable.

Makes sense to plug these test gaps.

> Extend the test suite to cover more scenarios related to the ref format.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0001-init.sh | 48 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 49e9bf77c6..2093f5c1ee 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -558,15 +558,6 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
>  	grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ}" err
>  '
>  
> -test_expect_success DEFAULT_REPO_FORMAT 'init with GIT_DEFAULT_REF_FORMAT=files' '
> -	test_when_finished "rm -rf refformat" &&
> -	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
> -	echo 0 >expect &&
> -	git -C refformat config core.repositoryformatversion >actual &&
> -	test_cmp expect actual &&
> -	test_must_fail git -C refformat config extensions.refstorage
> -'
> -
>  test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
>  	test_when_finished "rm -rf refformat" &&
>  	cat >expect <<-EOF &&
> @@ -576,15 +567,46 @@ test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
>  	test_cmp expect err
>  '
>  
> -test_expect_success 'init with --ref-format=files' '
> +backends="files reftable"
> +for format in $backends
> +do
> +	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_FORMAT=$format" '

The `DEFAULT_REPO_FORMAT` prereq is needed here because a non-default
repo format also changes the repository format version.

> +		test_when_finished "rm -rf refformat" &&
> +		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
> +
> +		if test $format = files
> +		then
> +			test_must_fail git -C refformat config extensions.refstorage &&
> +			echo 0 >expect
> +		else
> +			git -C refformat config extensions.refstorage &&
> +			echo 1 >expect
> +		fi &&
> +		git -C refformat config core.repositoryformatversion >actual &&
> +		test_cmp expect actual &&
> +
> +		echo $format >expect &&
> +		git -C refformat rev-parse --show-ref-format >actual &&
> +		test_cmp expect actual
> +	'
> +
> +	test_expect_success "init with --ref-format=$format" '
> +		test_when_finished "rm -rf refformat" &&
> +		git init --ref-format=$format refformat &&
> +		echo $format >expect &&
> +		git -C refformat rev-parse --show-ref-format >actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
> +test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
>  	test_when_finished "rm -rf refformat" &&
> -	git init --ref-format=files refformat &&
> -	echo files >expect &&
> +	GIT_DEFAULT_REF_FORMAT=files git init --ref-format=reftable refformat &&
> +	echo reftable >expect &&
>  	git -C refformat rev-parse --show-ref-format >actual &&
>  	test_cmp expect actual
>  '

Nice that we now validate that the `--ref-format` option takes
precedence over the `GIT_DEFAULT_REF_FORMAT` environment variable.

-Justin
