Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD54EB5C
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7WFgTQc"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ba52d0f9feso138837b6e.0
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703116522; x=1703721322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gazDmenXabRydTLzmcOcgMGqwAspDqgQqCHnFefRR3c=;
        b=f7WFgTQcD/2SY0w2KhD8OoHOERtAkbJ/AnOfT5ANcq+mZ95UU3k2jJJ/b/eJ2VazfE
         Fgha2q9JGN7oUtepI2cIgPpLYVYioQ2VlsdKv0acsBXOqFYX9NdLLuXxb7uhuh6Rvw3o
         QgTK4M+N1ANyBpUzKtGhSaNQQpECH9CJsf+js4hmtSVNGbiwmUbBrOKJy+NBg3OxQHum
         0dQOyfhixyCIdpMSJlpLEjN0vu/F+N9MZVAjpbeYtTq1cy6SD8vPvBQVcun8r4vhy9Ea
         D78CzbK36aTYjkjQ4V0xRan2eL546FtryyXe9j+tqchaWOttj/DD5cZlCGgVpC6pfLxL
         LtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116522; x=1703721322;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gazDmenXabRydTLzmcOcgMGqwAspDqgQqCHnFefRR3c=;
        b=aVgMPMNiH7j1bYCqJZKpeqNOowNOYIGYpCLdQsRxDxj8Ha++uohNvc3wh7xG/jcBfZ
         6DMmoU4S9wY/X7rPvyYQ5/s4+uH2I1MCq5KQnYFV+vrD024lUGqKNjcvvgL6hvqidPnJ
         iOBdrp0sHpw2lnOqOl4cPFpm8tBGZ0mRuak4gRexTLEgFPiJWvFnYLH+Y0Oqozi6Ex7P
         mPQTjOJ5fgM4tf54d/SgzXitiHrxrQ0d1C5/TgOQpkV5s8TYTyqoP/49yLnhzGB4MWUX
         a804IT2Cjq4tlxEkT6vjHph2EQl+RZ6WnW3GEBGqtgW5jPdtKLGyTzFOf0Jg26wfU0rv
         8+hA==
X-Gm-Message-State: AOJu0Ywp2bBzYsg1SqGjLu9AXlfhf3KazI/0f097mKSqjUwLQO0uqu1D
	iu9EeL/Gox/7PB8Io/04MLl1TA==
X-Google-Smtp-Source: AGHT+IGfG1Rbd9b3S2fZcNuCUTXXqkVv/vsBgWmmMeuxf4Qy5mwzOwxT2tXCTVC6arDWYfnI3aQYzg==
X-Received: by 2002:a05:6808:23cf:b0:3b9:dc58:169e with SMTP id bq15-20020a05680823cf00b003b9dc58169emr24125495oib.48.1703116521801;
        Wed, 20 Dec 2023 15:55:21 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:995b:d30b:e50:a6db])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b006d638fd230bsm332131pfh.93.2023.12.20.15.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:21 -0800 (PST)
Date: Wed, 20 Dec 2023 15:55:16 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
Message-ID: <ZYN-5H-2NNoRRpf-@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
References: <xmqqbkakqx6s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbkakqx6s.fsf@gitster.g>

On 2023.12.20 15:19, Junio C Hamano wrote:
> 93851746 (parse-options: decouple "--end-of-options" and "--",
> 2023-12-06) updated the world order to make callers of parse-options
> that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
> do with "--end-of-options" they may see after parse_options() returns.
> 
> This unfortunately broke "sparse-checkout set/add", and from this
> invocation,
> 
>   "git sparse-checkout [add|set] --[no-]cone --end-of-options pattern..."
> 
> we now see "--end-of-options" listed in .git/info/sparse-checkout as if
> it is one of the path patterns.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/sparse-checkout.c          | 9 +++++++++
>  t/t1090-sparse-checkout-scope.sh   | 8 ++++++++
>  t/t1091-sparse-checkout-builtin.sh | 2 +-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
> index 80227f3df1..226a458b10 100644
> --- c/builtin/sparse-checkout.c
> +++ w/builtin/sparse-checkout.c
> @@ -776,6 +776,10 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
>  			     builtin_sparse_checkout_add_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN_OPT);
>  
> +	if (argc && !strcmp(*argv, "--end-of-options")) {
> +		argc--;
> +		argv++;
> +	}
>  	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
>  
>  	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
> @@ -823,6 +827,11 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  			     builtin_sparse_checkout_set_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN_OPT);
>  
> +	if (argc && !strcmp(*argv, "--end-of-options")) {
> +		argc--;
> +		argv++;
> +	}
> +
>  	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
>  		return 1;
>  
> diff --git c/t/t1090-sparse-checkout-scope.sh w/t/t1090-sparse-checkout-scope.sh
> index 3a14218b24..5b96716235 100755
> --- c/t/t1090-sparse-checkout-scope.sh
> +++ w/t/t1090-sparse-checkout-scope.sh
> @@ -57,6 +57,14 @@ test_expect_success 'return to full checkout of main' '
>  test_expect_success 'skip-worktree on files outside sparse patterns' '
>  	git sparse-checkout disable &&
>  	git sparse-checkout set --no-cone "a*" &&
> +	cat .git/info/sparse-checkout >wo-eoo &&
> +
> +	git sparse-checkout disable &&
> +	git sparse-checkout set --no-cone --end-of-options "a*" &&
> +	cat .git/info/sparse-checkout >w-eoo &&
> +
> +	test_cmp wo-eoo w-eoo &&
> +
>  	git checkout-index --all --ignore-skip-worktree-bits &&
>  
>  	git ls-files -t >output &&
> diff --git c/t/t1091-sparse-checkout-builtin.sh w/t/t1091-sparse-checkout-builtin.sh
> index f67611da28..e33a6ed1b4 100755
> --- c/t/t1091-sparse-checkout-builtin.sh
> +++ w/t/t1091-sparse-checkout-builtin.sh
> @@ -334,7 +334,7 @@ test_expect_success 'cone mode: set with nested folders' '
>  
>  test_expect_success 'cone mode: add independent path' '
>  	git -C repo sparse-checkout set deep/deeper1 &&
> -	git -C repo sparse-checkout add folder1 &&
> +	git -C repo sparse-checkout add --end-of-options folder1 &&
>  	cat >expect <<-\EOF &&
>  	/*
>  	!/*/

I can confirm that this fixes an issue noticed by sparse-checkout users
at $DAYJOB. Looks good to me. Thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>
