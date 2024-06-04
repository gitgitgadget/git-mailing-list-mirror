Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1E7FBDD
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495241; cv=none; b=iABovVkRAc/9nuVoORkgBZtLgBRYi/LGhY4FFpm1Wg1LJYlFioihOp70Hzeua6LiNTmLbU1BzQbrlZ/t7dBGo6Nrnuxpd5vqBGNjsCEBTsIXfdpn2KcSiwzItAFNABrxgGDex+YiUoWuXoAe01O7pkP9KegxU2NfMnxSaKjzjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495241; c=relaxed/simple;
	bh=1XpvkMqP7Qdkltb5YRWLtIlWvIpPHhuuenYqMjO+tuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNBCeRuH3q5R/y+4EvdjyZti7Gh54lNAiO4HYXfVVNYqzbwTJemvc9iCk8PEJedPfKQrYX6cFcKUIDPyakp2p7gd5126xL7ALqNEurAmMuCmyAH7dHuhJID435o0Wyz2myO56IlPQevVHe0H82bpSM8Aesqp0UqZqgo+Tt8pa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MInHXmAx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MInHXmAx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35b447d78f1so3234445f8f.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717495238; x=1718100038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WPEiWrRx1HhfWjOd/D75Yp52q9/DisF7FV84g3G+Ya4=;
        b=MInHXmAx7RU9ViKnRYahIOGyr+Jr5I8kbvqz3E8296rXWjZMT56xFNso8VwoE2LKKU
         KQ3RfSkOhzxjL5mKPHlAEpyOmv132Ps0jnkIXSvgU4kNYrO8iyILMjYIwbZf6GK/7XO7
         8sdTfils7iTXF2ZW13fAloXO4V+VoVR3C2fz8TFMZIhg5re9b9BxHY2vh3Kd2DZX/gxt
         gAVyOXz7opicgoBSW6B/XWPmbeuA9hWzd/LePJTN6jg2PGYBmWu7JswIyAm781RlBEEE
         8BQSwsm8eXkUZbvZD/amIYVX3yOjsPu+7cKAmNFcGk1PldxzXh3XN8qncyI2Cf6XD6Pw
         ZR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495238; x=1718100038;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPEiWrRx1HhfWjOd/D75Yp52q9/DisF7FV84g3G+Ya4=;
        b=jqbjgW1W6XTFZ6lLNcVtqeHtwX61UuXUjrr/RKvbWBHXUfOeC3xwaFWdse13vJ3UM9
         /+fYi2OykbwabJkfhzN65KoXKXnne9zGKDfICeLrCK3b4RRGlhBZif3+jCZKY6r0NpB1
         +t2GrNIs+gUX4L1DIpvIcIjS4T10/67NTxpj7GHnfkUaeDTegKDU+42/kgkEiQxr8FIx
         sL6L2BLAlFj6wvnumZLcP1I1hrxCEjCWSXWLbVlqd12pIdzo5slrLoE32TaaO9lOtGiG
         p6vTVkTUQ13h44ZeULbYCX1rzjn9WZVaLcFEHijgF9LrBC5k7lIVK2P/7P+VBSLFh0Fb
         zHuA==
X-Forwarded-Encrypted: i=1; AJvYcCUwfWdVepF0cSmPrafQq5Gsgx4sl+0dVUmvl3xwx0UX45zoKtLSFK4uC34MM8b8uCgD+kQ7EKLIa43bkIfLhqWugpSp
X-Gm-Message-State: AOJu0YwgcqtLle4Arlk/D0mDSCGN+VuHqLTpAfJd173o3AUTsNUvbUca
	hkZy7y8+P+JpifFT9tovplp6VAaEqTuQr7wMcYnGaoGSgJ4NYDtU
X-Google-Smtp-Source: AGHT+IHaszX9WWWs9m9bkWWtjRc6+vgjm5UNvHiBUf/MGbDbC/2NpiThnKkv1sqQgXoGc21o6Bo2pQ==
X-Received: by 2002:a05:6000:458f:b0:34d:9c3d:cc16 with SMTP id ffacd0b85a97d-35e7c55a1e6mr1979453f8f.19.1717495238228;
        Tue, 04 Jun 2024 03:00:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1? ([2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd066eb35sm11000251f8f.115.2024.06.04.03.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 03:00:37 -0700 (PDT)
Message-ID: <3f085795-79bd-4a56-9df8-659e32179925@gmail.com>
Date: Tue, 4 Jun 2024 11:00:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/6] pager: introduce wait_for_pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <76c725b4-1bc4-4916-81d8-98cad8fc4ca0@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <76c725b4-1bc4-4916-81d8-98cad8fc4ca0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 03/06/2024 21:38, Rubén Justo wrote:
> Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
> 2006-02-28) we have the machinery to send our output to a pager.
> 
> That machinery, once set up, does not allow us to regain the original
> stdio streams.
> 
> In the interactive commands (i.e.: add -p) we want to use the pager for
> some output, while maintaining the interaction with the user.
> 
> Modify the pager machinery so that we can use setup_pager and, once
> we've finished sending the desired output for the pager, wait for the
> pager termination using a new function wait_for_pager.   Make this
> function reset the pager machinery before returning.

This makes sense, I've left a few comments below

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---

>   static void wait_for_pager_atexit(void)
>   {
> +	if (old_fd1 == -1)
> +		return;
> +

This is good - we'll return early if we've already cleaned up the pager.

>   	fflush(stdout);
>   	fflush(stderr);
>   	close_pager_fds();
>   	finish_command(&pager_process);
>   }
>   
> +void wait_for_pager(void)
> +{
> +	if (old_fd1 == -1)
> +		return;

Isn't it a bug to call this with old_fd1 == -1 or have I missed something?

> +	wait_for_pager_atexit();
> +	unsetenv("GIT_PAGER_IN_USE");
> +	dup2(old_fd1, 1);
> +	old_fd1 = -1;
> +	if (old_fd2 != -1) {
> +		dup2(old_fd2, 2);
> +		old_fd2 = -1;

We're leaking old_fd1 and old_fd2 here. wait_for_pager_atexit() flushes 
stdout and stderr so this switching of fds should play nicely with code 
that uses stdio.

> @@ -113,6 +134,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
>   
>   void setup_pager(void)
>   {
> +	static int once = 0;
>   	const char *pager = git_pager(isatty(1));
>   
>   	if (!pager)
> @@ -142,16 +164,18 @@ void setup_pager(void)
>   		return;
>   
>   	/* original process continues, but writes to the pipe */
> +	old_fd1 = dup(1);
>   	dup2(pager_process.in, 1);
>   	if (isatty(2)) {
> -		close_fd2 = 1;
> +		old_fd2 = dup(2);
>   		dup2(pager_process.in, 2);
>   	}
>   	close(pager_process.in);
>   
> -	/* this makes sure that the parent terminates after the pager */
> -	sigchain_push_common(wait_for_pager_signal);
> -	atexit(wait_for_pager_atexit);
> +	if (!once++) {

We only need to increment "once" when we enter this block, not every 
time the code is run.

> +		sigchain_push_common(wait_for_pager_signal);

I think we should be calling this each time we setup the pager and pop 
it in wait_for_pager(). Imagine a caller sets up a signal handler before 
calling setup_pager() and wants to pop it after the pager has finished

	sigchain_push(...)
	setup_pager(...)
	do_something()
	wait_for_pager()
	sigchain_pop(...)

With the changes here it will pop the signal handler added by 
setup_pager() rather than the one it is expecting.

> +		atexit(wait_for_pager_atexit);

It is a bit of a shame we have to leave this function active when the 
pager has finished. We could add a wrapper around atexit() that allows 
us to pop functions we no-longer want to call but I don't think it is 
worth the effort here. wait_for_pager_atexit() is careful to return 
early if it is not needed.


Best Wishes

Phillip

