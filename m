Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C14C92
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715835; cv=none; b=bKD+WT+YADnQKa9YrMR+9lVFExqLej/pU0VJIrkyCCr2mKQ4JygesYLoLQhKywPN5LOdfMtWcETpJGTgbwIa5X8t78duaR356RcYwbnj+eYJj54WVUQjK7mh5HDDbVVrR7zV/YFrmSCWSr6IPLeyTGySDCs4WGoPxX+NtUHd6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715835; c=relaxed/simple;
	bh=i1zKhrp1On6vWzidARinNhG4CRhNGNE/6Vnk/feQZLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IB3CinuZmSoKlmHHFQlCcKFflL9s+y7fn3vnJiISkkNk/+YYDpdMPlFz0q2HgMI17LcmqcdOwENSbsEnDL5E7RFp/Wzm0LxkaAKJ7ZfI17NYnmAXqhNPU8jtmVsMlDBmA1tdbwnwNruIE/Vi8PzWcstJnLxaUsEy5e5oQKdX6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZxwfwo8; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZxwfwo8"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b79e7112398so188350366b.3
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 08:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715831; x=1768320631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ctVBX6oGR6U5CDFEJrUEXBpQkvaYYC/w4IY5+Bv/7IA=;
        b=AZxwfwo8sb8K1m4Ozxe7xCCK585NNz9O2de8E6HBzsV0a9Xte9Ug3R02h9YwEPD7Cn
         TB9q1wYRYYolghyTGiG1//LspukmAImfXQ+iuRzR4+vpaAURo9gda6CmSLXIIsi6gVzi
         nxrPY0N2tQiePySnQctG+HSeEfmjNKjyaA9CoPyFpKEuOuRkcajZdBzaQf4tZvNglX3X
         l4RlfwSZexxqlFNdITENM4sdpRFq5gqItEcYOuuolEIKNH4ldP+3KSMlDsE32j1AA/3I
         JFYUaZormO3YFu0pomAk2EmbcCTLGslhDxn/bdTzaBS+K+FDdd0tIOdgwm0xIv1cbYi8
         6vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715831; x=1768320631;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctVBX6oGR6U5CDFEJrUEXBpQkvaYYC/w4IY5+Bv/7IA=;
        b=AMGh0ndKkgXsklVe3LDP8e83mCHwv+8xzZ/9Qkf6DlekNFeiE3QYeyOjg7dpHBdOAj
         6GDy9/mFLNTDu5H2sqfl0cWwOnPxfZYgu6dY1GHW4xOjXiw50T1FF2KkOlTHdw4GxmUP
         0FfBJsX/B71ZW/N9X7/nBY5jnf3lwJ2xv2pbpj/VnTyyiw96wh8vAfqsAQUi6I7qQuc7
         3V+oEiZb9ZASc5+JTxZOxD2aNKWjKi9SmwOn8UA575PUaMst+st/mEPsmRcldM+2ObsK
         uUZXJsdqARBpGL5IfkLxBLK9LFoppVUSNi4mQokfRU+8vMpU6WJHETKAo0nrCeQvdMdP
         ireA==
X-Forwarded-Encrypted: i=1; AJvYcCUFhFUBpI7m6guBPWTai4Gc+jZlGJrhZ12utgzTDog0qk6mwwgsWaLkYiv5f21QcZfL270=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZUhIQUyZoll/+CRem5cm/Z8HnI2OuIIgzUvEUmaDlGQ6UX6r
	qWGhYYN5CeNsJMuznBQeAl2j3OMV+kKNZ18B77ctTgN8holdRCKuXqmi
X-Gm-Gg: AY/fxX7HqDJjRFL0g6TNMkE6Ecg0iQuMFiyZLOx9fvSv8XUCki01+RqZzWELPqpNw6F
	Z7e1UoM2RIR1sBevJe30UeqaCKeJAL/ooGtz+NjLVq5PpolcU5P5VMAOC8J7qLW96egdZTyhIYY
	a1ewZxdJiL+WHANrCYH2IpQ91R9u6j2ySfcKPPVp1ylfq+R7l0Twd16F7z71Tkknr4hITVd08S7
	KEwepJ/Wp1PUiPnB8zrShf0g1dz5BtvLIwekKr05CSqsQ27D42VEFP10eMrBfUqiHNWD7/7eVwU
	kBiCqVQBpfLB+lLZXeDKNnv+IlmzzqDnZsHxz+ERfadmEB5KNZdaXTdCWmNA9KRAwzk0UUo7uMn
	66KS0d1ZWbWCpBVXheHTNn6fYZlY78ZsGGiORDLR2S5kCcxdGdcmSA6LDiXfGwN1uxaCnIiv5Xx
	390XuHQ7Uh7V+voV94Cvkl/EC3vJ2tcEE0hA7R9byYIYfe0erFWS8zYnDpjtb/x4Vl/A==
X-Google-Smtp-Source: AGHT+IGeUD81BlGk2MkbQdTuR0iStH6dVV0Yt6v35ZUXgXt4fjShDquTSiUpFfR83aPd+AMfhoT5Kg==
X-Received: by 2002:a17:907:3daa:b0:b79:fe3a:6d3 with SMTP id a640c23a62f3a-b8426bee22fmr363809066b.37.1767715831035;
        Tue, 06 Jan 2026 08:10:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a22ff58sm259305366b.6.2026.01.06.08.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 08:10:30 -0800 (PST)
Message-ID: <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
Date: Tue, 6 Jan 2026 16:10:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC PATCH v6] add -p: show user's hunk decision when selecting
 hunks
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <aVz5kf6eLsMZ6WQQ@Adekunles-MacBook-Air.local>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aVz5kf6eLsMZ6WQQ@Adekunles-MacBook-Air.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abraham

On 06/01/2026 12:01, Abraham Samuel Adekunle wrote:
> When a user is interactively deciding which hunks to use or skip for
> staging, unstaging, stashing etc, there is no way to know the
> decision previously chosen for a hunk when navigating through the
> previous and next hunks using K/J respectively.
> 
> Improve the UI to explicitly show if a user has previously decided to
> use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> This will improve clarity and aid the navigation process for the
> user.

I like the idea of telling the user if the hunk is currently selected 
but say "(previous decision: use)" makes the prompt rather long (some of 
the prompts in the tests below are 80 characters long). I wonder if we 
can find a more compact notation. "(currently selected)" is a bit 
shorter and takes us under 80 characters but is still longer than I'd 
like - maybe someone reading this will have a better suggestion.

> diff --git a/add-patch.c b/add-patch.c
> index 173a53241e..a383ea7f45 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -42,10 +42,10 @@ static struct patch_mode patch_mode_add = {
>   	.apply_args = { "--cached", NULL },
>   	.apply_check_args = { "--cached", NULL },
>   	.prompt_mode = {
> -		N_("Stage mode change [y,n,q,a,d%s,?]? "),
> -		N_("Stage deletion [y,n,q,a,d%s,?]? "),
> -		N_("Stage addition [y,n,q,a,d%s,?]? "),
> -		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
> +		N_("Stage mode change%s[y,n,q,a,d%s,?]? "),
> +		N_("Stage deletion%s[y,n,q,a,d%s,?]? "),
> +		N_("Stage addition%s[y,n,q,a,d%s,?]? "),
> +		N_("Stage this hunk%s[y,n,q,a,d%s,?]? ")

I'd find these strings easier to read if we kept the space and just 
passed an empty string when the hunk is undecided.

> @@ -1564,8 +1565,14 @@ static int patch_update_file(struct add_p_state *s,
>   			      (uintmax_t)(file_diff->hunk_nr
>   						? file_diff->hunk_nr
>   						: 1));
> +		if (file_diff->hunk_nr && hunk->use != UNDECIDED_HUNK) {

Why do we need to check hunk_nr here?

Thanks

Phillip

> +			if (hunk->use == USE_HUNK)
> +				hunk_use_decision = _(" (previous decision: use) ");
> +			else
> +				hunk_use_decision = _(" (previous decision: skip) ");
> +		}
>   		printf(_(s->mode->prompt_mode[prompt_mode_type]),
> -		       s->buf.buf);
> +			hunk_use_decision, s->buf.buf);
>   		if (*s->s.reset_color_interactive)
>   			fputs(s->s.reset_color_interactive, stdout);
>   		fflush(stdout);
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 4285314f35..cc3986a9d7 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -527,7 +527,7 @@ test_expect_success 'goto hunk 1 with "g 1"' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
>   	EOF
>   	test_write_lines s y g 1 | git add -p >actual &&
>   	tail -n 7 <actual >actual.trimmed &&
> @@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
>   	EOF
>   	test_write_lines s y g1 | git add -p >actual &&
>   	tail -n 4 <actual >actual.trimmed &&
> @@ -554,7 +554,7 @@ test_expect_success 'navigate to hunk via regex /pattern' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
>   	EOF
>   	test_write_lines s y /1,2 | git add -p >actual &&
>   	tail -n 5 <actual >actual.trimmed &&
> @@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
>   	EOF
>   	test_write_lines s y / 1,2 | git add -p >actual &&
>   	tail -n 4 <actual >actual.trimmed &&
> @@ -579,11 +579,11 @@ test_expect_success 'print again the hunk' '
>   	tr _ " " >expect <<-EOF &&
>   	+15
>   	 20
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
> +	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
>   	 10
>   	+15
>   	 20
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
>   	EOF
>   	test_write_lines s y g 1 p | git add -p >actual &&
>   	tail -n 7 <actual >actual.trimmed &&
> @@ -595,11 +595,11 @@ test_expect_success TTY 'print again the hunk (PAGER)' '
>   	cat >expect <<-EOF &&
>   	<GREEN>+<RESET><GREEN>15<RESET>
>   	 20<RESET>
> -	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
>   	PAGER  10<RESET>
>   	PAGER <GREEN>+<RESET><GREEN>15<RESET>
>   	PAGER  20<RESET>
> -	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
>   	EOF
>   	test_write_lines s y g 1 P |
>   	(
> @@ -810,7 +810,7 @@ test_expect_success 'colors can be overridden' '
>   	<BOLD>-old<RESET>
>   	<BLUE>+new<RESET>
>   	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
> +	<YELLOW>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
>   	EOF
>   	test_cmp expect actual
>   '

