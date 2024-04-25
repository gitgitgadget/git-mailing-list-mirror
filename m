Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82114BF9B
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083019; cv=none; b=NqDaz9+NbjjLJRSDPS7GmjrmEqa3oLTE5Gs8bTxRvvf1djLm5t36b+GRJtGis3VKgbwgCGNj3xaDDdtfsyfjKFvXNRVbZmGYHGiYrgr8Uz3wcktyDhBNcgPheaqQjxeCIku3MD4c2prWrgTjnWcPrOPrsfs+bBUNdbsqjO5uRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083019; c=relaxed/simple;
	bh=r28nH9Vwxa6KrGDNNjKE+oxKA0jMSLTEVXPvcDAV7Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W64k1DFu03iqnb0S3/nEMw3lKJ9ZRkPX3mtmZVFSMKmjS0tt0cVbeA4hI4LiXKX0AvfgvX/39SKDKK6u1w30z07iZpwR/Tzs1CfXguLAcYVdtf22nEbb36C0Yv7zMDQfy3epo9yEdmQH/X0IkVs3K7VUFy0M955Jd9RSiMYr9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV7nE2OL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV7nE2OL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4187c47405aso10490665e9.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714083016; x=1714687816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZObP6Espj1Q1C8ROafLtM3xw5TYkr6rQxtnQBYsyrQ=;
        b=cV7nE2OLQZMuSvM+GxQSg20vUZg2P+mtHSd9KIP1KUxmgnpBpka34ZFw74Igw0qVIA
         +zJQqYCimdumazcq3KUYMadRk3nASuTEdjZfRPfQtBsGVU3E4caI+fixHe7ucs+iRCgf
         TKWN1YtncBsa81seUU3NIe0vHGsamYE2/BpuletvygD30vqrjT1pdt0Pxn5s2y+XrgN9
         +dYhSAJ364L3TOCCdzO6/7r12h0ZbTZ5hC/LdSSa5MN4G6xOoaA0fOfDumCFmgeP8Qlx
         eZ3b87Z9RTd/CCDUyJsRZnAzkGDs1Eo58okPKPcl39CIdwelWT2+Rcatcpe01Zqm9ga+
         nvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714083016; x=1714687816;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZObP6Espj1Q1C8ROafLtM3xw5TYkr6rQxtnQBYsyrQ=;
        b=ZQeYDhTqidBYgrx2Uw34moeT01WCpZtqGUQMd3VM+SEvBR8gL2PAubbRQcn8HY+Xh5
         Y0xG5IpZTxay+Vss14fRZNIoxgYP/r0m8Oq0jS6wADROJdBdqU1YXrKWes0AZ6SZl006
         FR8mWldxay4C6XKpJ9Zer38UJigDz0aCFNd0zfA9neoMioP9EcpqxO8gtiLjtlRcuwKp
         uGs9ShI/kam4x9PYZi1UzusDz8ha+jM41XcdiQQzvf3DDTmCO8arphi06BPa1JrzprGP
         v8/hE4jOhWjY+d9/T2tDVI+/kNJ++0HGCTbPtHwdFr/+nOqV7B75aq1FSoAT6y13czek
         KOFA==
X-Forwarded-Encrypted: i=1; AJvYcCUkSDYwxRMhGMTjnqlF2i/MAWfcFtaQF+sHFmSVdg6Ww8b8xuDJdMTj+sws60Dnzkc/CM4NsJVDjVczOiyHThw3yG5r
X-Gm-Message-State: AOJu0YzkNp12kHw/YMdB0qxjB323JcJ11ZJc8IOIejU+0kYR5k93yqZL
	2d9WagctyseytKl7YOzKrN4ii7Y61IAlDXeBbP+Z2VIYyFtUj5SLYOgbJw==
X-Google-Smtp-Source: AGHT+IFYBrFCdZmcTiZe7IcQ9qnLlT2lzeMshDvV9DeXf4cmJB8RMDWGWJGOUv7gfw9184z3Q9NkFg==
X-Received: by 2002:a05:600c:1990:b0:41b:6753:30be with SMTP id t16-20020a05600c199000b0041b675330bemr486977wmq.38.1714083016317;
        Thu, 25 Apr 2024 15:10:16 -0700 (PDT)
Received: from gmail.com (244.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.244])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041638a085d3sm32382475wmq.15.2024.04.25.15.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 15:10:15 -0700 (PDT)
Message-ID: <5854e33c-b84e-47a3-94c6-c5fe8c9a4c98@gmail.com>
Date: Fri, 26 Apr 2024 00:09:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <20240425014432.GA1768914@coredump.intra.peff.net>
 <CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
 <xmqqedatfay3.fsf@gitster.g> <xmqqv845dug2.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqv845dug2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Apr 25, 2024 at 02:05:33PM -0700, Junio C Hamano wrote:

I am assuming that this change will precede my series.

I leave some nits below.

> diff --git c/add-patch.c w/add-patch.c
> index 7be142d448..c28ad380ed 100644
> --- c/add-patch.c
> +++ w/add-patch.c
> @@ -293,10 +293,10 @@ static void err(struct add_p_state *s, const char *fmt, ...)
>  	va_list args;
>  
>  	va_start(args, fmt);
> -	fputs(s->s.error_color, stderr);
> -	vfprintf(stderr, fmt, args);
> -	fputs(s->s.reset_color, stderr);
> -	fputc('\n', stderr);
> +	fputs(s->s.error_color, stdout);
> +	vfprintf(stdout, fmt, args);
> +	fputs(s->s.reset_color, stdout);
> +	fputc('\n', stdout);

If we're going to use stdout, perhaps we can be less explicit?

diff --git a/add-patch.c b/add-patch.c
index 447e8166d2..a204224dae 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -293,10 +293,10 @@ static void err(struct add_p_state *s, const char *fmt, ...)
        va_list args;

        va_start(args, fmt);
-       fputs(s->s.error_color, stderr);
-       vfprintf(stderr, fmt, args);
-       fputs(s->s.reset_color, stderr);
-       fputc('\n', stderr);
+       puts(s->s.error_color);
+       vprintf(fmt, args);
+       puts(s->s.reset_color);
+       putchar('\n');
        va_end(args);
 }

> @@ -1780,9 +1780,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  			break;
>  
>  	if (s.file_diff_nr == 0)
> -		fprintf(stderr, _("No changes.\n"));
> +		err(&s, _("No changes."));

Nice.

>  	else if (binary_count == s.file_diff_nr)
> -		fprintf(stderr, _("Only binary files changed.\n"));
> +		err(&s, _("Only binary files changed."));

Nice.

> diff --git c/t/t3701-add-interactive.sh w/t/t3701-add-interactive.sh
> index 482d5c117e..a315ec99a3 100755
> --- c/t/t3701-add-interactive.sh
> +++ w/t/t3701-add-interactive.sh
> @@ -43,17 +43,17 @@ force_color () {
>  }
>  
>  test_expect_success 'warn about add.interactive.useBuiltin' '
> -	cat >expect <<-\EOF &&
> +	cat >expect.error <<-\EOF &&

This expect.error is what we are going to test with the output on
stderr ... 

>  	warning: the add.interactive.useBuiltin setting has been removed!
>  	See its entry in '\''git help config'\'' for details.
> -	No changes.

however, this line no longer goes to stderr.  OK.

>  	EOF
>  
>  	for v in = =true =false
>  	do
> -		git -c "add.interactive.useBuiltin$v" add -p >out 2>actual &&
> -		test_must_be_empty out &&
> -		test_cmp expect actual || return 1
> +		git -c "add.interactive.useBuiltin$v" add -p >actual 2>error &&
> +		echo "No changes." >expect &&

Why not prepare this file above, out of the loop?

> +		test_cmp expect actual &&
> +		test_cmp expect.error error || return 1
>  	done
>  '
>  
> @@ -348,13 +348,13 @@ test_expect_success 'different prompts for mode change/deleted' '
>  
>  test_expect_success 'correct message when there is nothing to do' '
>  	git reset --hard &&
> -	git add -p 2>err &&
> -	test_grep "No changes" err &&
> +	git add -p >out &&
> +	test_grep "No changes" out &&
>  	printf "\\0123" >binary &&
>  	git add binary &&
>  	printf "\\0abc" >binary &&
> -	git add -p 2>err &&
> -	test_grep "Only binary files changed" err
> +	git add -p >out &&
> +	test_grep "Only binary files changed" out
>  '
>  
>  test_expect_success 'setup again' '
