Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD936CE0C
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718664; cv=none; b=ru7qTNu7PO6AvT5j4obZEJyQQ7bbtj3gIsyABx6MSF5hZXMYtErdbmWgQge2c81lsTwhNkF+NncLfuArHT6rSET/xhFbvRg2cZSFi+KBP6o5ZhvdvZAtkCzUHrsrt8Xa+4yCcvz50VIVvESOdSzTNVJQPHV6jH4oi7Uuz5XgSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718664; c=relaxed/simple;
	bh=blP8nsTkE078e1rIAQpfE9aJq2F5tMrJJmFlLFd9VWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR8Zf+nzYJGrbAywV1C78IQzg2dLI4+WaoEVQjU8jKqaQvkEgRBU5PBgaoBj+HT15pOUer0KNRMsnXmBIsbbFX+WxAAfGDKYC0eliCbUF1MTF6WK5wkKon4/ezyC/iJyG8UWf008ZZYN5hrrYneaWD0XnoH46PnIl2+3PrrImpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3zl6MOR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3zl6MOR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-242d3be6484so2745ad.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755718663; x=1756323463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwluMFxuEC4DlV9GyQCjapNPDPV4YkzO+GkPJEGzW+E=;
        b=w3zl6MORDq1RZykYbhcerNTcM3ptDiOJxaJkhTxmO5q3xkq6NZJyAzSoSwCF9pQ5k/
         EYkjXa2j9no8l3Q37/en0AGiPhfbOBDQwcJXDQlYr5UPQ6vsuOaN3IlrVgk4uB1K8eAw
         G0iC7c4ppeUMBWlHQnq7/zZpP9N05fOMybqQpnXD+HTfbZ+XjEo6K0W0oPzpBH12QhVV
         6EFxuHRduXjnwWAqCX1oOc+CL9e93/33+9v/HXo8dJTMjH/ADpi5onpdiUA4zURUnLc7
         5yEjQ0xdr8luam7/sWTerULmJmphEiM7np//FREinNBsred5hw8hOyno5HKSBEQHyZSF
         eCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755718663; x=1756323463;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwluMFxuEC4DlV9GyQCjapNPDPV4YkzO+GkPJEGzW+E=;
        b=P0MlsKxkfsqrBNnjbkt0WP+Ier9Do3OXAi57HzR68Z3riYZQ4aJLO01gd5LxoRsyu8
         ulmYuPExmXZIWzSt6sQn4SX1zjR4Tf4LSxx517YKl9Y5zR3rF9+kJH88izDqiiaGPNm7
         3F6zAnsx50UYW+Ryi+bA1AuQATVxdilKHT19T0A7xK93TcK6LqXdlumSCfSnbgDUEfwz
         DQWK7+kBIqLlNThVAnZayQySd45KnwKdDFiBhGooGb7w+fGmc/s8CpNlqjLRVQ0uzANB
         bQ9tjGRpS4dfNfvlXL6IXfNCedmaU4SaqmIrWg+1k8Ih2d6mPzS3K2R9KVkwDV1hytIC
         PZ5Q==
X-Gm-Message-State: AOJu0Yw0szF4RrCoMZXLewVrMoax4FVT4lCl1sYNy9aXDWhUvqGj1XeQ
	kGk6QT4F97nmSgeh+3NIfF4nGzDF3vK/++H/M6g9hluy+rNFhLxV6o76ThOtdN55kg==
X-Gm-Gg: ASbGnctLprqbmzHMu1488JkPhHlpfCJx2TVxtxsLrAmd9VDK4fTbJ/L6KqEvbiAyQ7W
	YWWIDcemCL5ve4QhcpoaAAIzHZg4+ZlcWgrwt1s3U4s5sQm/pG8wLmry3ZmzW1Z+Rnn91CRiIjq
	3I1uRtD7tWuBYGnDA988UOXvqG56YfvSZVmvvIcsbOgEk+MjrOBzu88mNhRZJSDFX1at8VGHvCt
	OoRou/YIltZvJx+ufDo30YrbaNwzkkoZh0xK/53gx+EMnii4AVQ13hqpf6vJi1MxbYzqY+aHB/y
	cf1eDRGHArzao4jRT+DseQ68cQL/JbuptZUF9npA5fpV/YiW/b1iIrN3LgcZ41vsFrSQx9D4xEr
	vJuPfdfAt02jmiPU1/BBtvt3ik00=
X-Google-Smtp-Source: AGHT+IEPdOTpr8aRyUDAahCbEir9jZNeMY1WukLyl5CNEqvgqYNjy5UQ7Q3nvoj8PRkuB/WqvTlQJQ==
X-Received: by 2002:a17:903:238e:b0:234:afcf:d9e8 with SMTP id d9443c01a7336-245fdcc1b9dmr799315ad.7.1755718662460;
        Wed, 20 Aug 2025 12:37:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:23b5:65e6:69f5:ee81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed5406e4sm33757565ad.165.2025.08.20.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:37:41 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:37:36 -0700
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>, 
	Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
Message-ID: <l4bmyst4qtew7kv7sdgzw5hibwor34zrh3c4jib7i6vlsniey6@jtku24uffrmo>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>, 
	Brandon Williams <bmwill@google.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816213642.3517822-4-adrian.ratiu@collabora.com>

On 2025.08.17 00:36, Adrian Ratiu wrote:
[snip]
> diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
> new file mode 100644
> index 0000000000..fb5cb8eea4
> --- /dev/null
> +++ b/t/lib-verify-submodule-gitdir-path.sh
> @@ -0,0 +1,15 @@
> +# Helper to verify if repo $1 contains a submodule named $2 with gitdir in path $3

This comment is a bit inaccurate, right? If I'm reading correctly, we
only verify that the submodule's gitdir actually exists in the "legacy"
.git/modules/$path case. If we don't see anything there, we fall through
to .git/submodules/$encoded_path, but we never verify it actually
exists.


> +
> +verify_submodule_gitdir_path() {
> +	repo="$1" &&
> +	name="$2" &&
> +	path="$3" &&
> +	(
> +		cd "$repo" &&
> +		cat >expect <<-EOF &&
> +			$(git rev-parse --git-common-dir)/$path
> +		EOF
> +		git submodule--helper gitdir "$name" >actual &&
> +		test_cmp expect actual
> +	)
> +}
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 178c386212..f4d4fb8397 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
>  
>  test_expect_success 'setup - enable local submodules' '
>  	git config --global protocol.file.allow always
> @@ -1505,4 +1506,18 @@ test_expect_success 'submodule add fails when name is reused' '
>  	)
>  '
>  
> +test_expect_success 'submodule helper gitdir config overrides' '
> +	verify_submodule_gitdir_path test-submodule child submodules/child &&
> +	(
> +		cd test-submodule &&
> +		git config submodule.child.gitdirpath ".git/submodules/custom-child"
> +	) &&
> +	verify_submodule_gitdir_path test-submodule child submodules/custom-child &&
> +	(
> +		cd test-submodule &&
> +		git config --unset submodule.child.gitdirpath
> +	) &&
> +	verify_submodule_gitdir_path test-submodule child submodules/child
> +'
> +
>  test_done
> -- 
> 2.50.1.679.gbf363a8fbb.dirty
> 
> 
