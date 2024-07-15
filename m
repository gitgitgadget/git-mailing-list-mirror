Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D4433B3
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052800; cv=none; b=NAsfZzCptc7EtvLIgDHOrBEhleuTlTDaczumluot1Een6HCHP1xViQgrnz2zSsz4VxrN6Egln5ZUcq7Dqeaf3bISaylQGi/7+5Bl50G26HVUWLNKsdgAfhC0EoDDehTkkS/VGf9B73wNmyzrwOp9xcA1kAgtYFMKOC9nBVH8cDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052800; c=relaxed/simple;
	bh=wkqC2ABuO88SntrD+HDgXlMPyYhdWELWznPyxM6v7U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAcDgxyExT/94Oidc3rMeR3LhK9yq3feuRbl+g9AcVTywiej6tnGLbWBum1tp0M65ATPFwMEgqOsm0Lz6V/gSWBrP0ngRYcQvTyirkXGlmlNYhzZo2L03J0w8vwMY85lHEeseXfrTlDDlSoBAwMOEiK8wP85ZL0U+ATGX0ySr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aht9rN3T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aht9rN3T"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3678f36f154so2597480f8f.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721052797; x=1721657597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rK4V8Pg7kO6VS8PHjz8IsYcZvghdEwrgGbVTb69QRhk=;
        b=Aht9rN3TpnHgCwLW7mFn3RkQDI7+k/whINnotHVUULj2CqH6cvaKxeUzxbcCIWgDwG
         B4SB46mbK5CJ4wvC5o7LTZCoW5IGOJum4dF6rkqgUFWcEqTJYkZasPsRkZqmdsP5l/Oi
         cOAIz3fj+oF4DM8jk+rJCzV855eV4LfUdAiqg6SSRM4F1jXdmAvW0ZrzruDYzBVcJBfl
         jINm5iZPlDiqar3dWiFhegOpMbO/zz/AtzqBnOfIWxbQxvL6FdOJ3fR4rlENa687oNwN
         QqSz5F8VI6Ib2jQp8NTw1l87drwgPKSXL7JQOyYMsb171s2SMPA7znIpSa5fk9Taq/oA
         4V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052797; x=1721657597;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK4V8Pg7kO6VS8PHjz8IsYcZvghdEwrgGbVTb69QRhk=;
        b=lD0HMTteeWK/35oYHAdaySLA4qVR+W8nfg1eSWC9tOPVIjIXRCWCOcxi57RsEch75y
         pUbFSbXmyfIGtPWthjDbupixL8ojFbKN5ENWc3tNhQZWVv9HFxe7AxDAbJYSWW3u9IqM
         1fvJMlPmKa7piK2Lc6nULEgHY2iWuxJF26+HK0rMyaTMOOff7aJoiG05jnMqvF59oTfx
         aXRoP+ma8gny02+Lx/TLnfaHYYdzfVh1xP4dgykRGGCHzUf7aeQvEWjfGR1gBzagKroN
         GjzjWmKilbI3hAT51zxcXH9VmhbjGhOd5haAwXfP3c4GNMR3z7RB5qrw9aSQTj2bAkVI
         55dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWncJY/Gkc1RPqNlDFMviY4etxvXc7NZAuq0qfmuOL6v1SADsl3OgW/R9Zx55Eeo0hqY0xyC41HSZ2gy3fbXcC1+pBm
X-Gm-Message-State: AOJu0Ywi8LuDm2MSuwoCBNwrBTcygLV0c8wMq/KzEREPJgeNYXzjatkT
	bCFnMe40+RpZnVkK1f7LnonEQ07EjE/6SiUTrC/2qo4z4vZL9d/V
X-Google-Smtp-Source: AGHT+IEFprTltRtjR67QEVvjKIkbAGLke33FTW2A0Aj9jWbyKozbzgNUdwS6H0FfpjVUZMrKiRLIXQ==
X-Received: by 2002:a5d:64a6:0:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-367cea46b24mr17528210f8f.1.1721052796357;
        Mon, 15 Jul 2024 07:13:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3c38sm6558699f8f.8.2024.07.15.07.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 07:13:15 -0700 (PDT)
Message-ID: <384f0147-d611-493b-a3d4-d83c65bd1114@gmail.com>
Date: Mon, 15 Jul 2024 15:13:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/4] pager: introduce wait_for_pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <f48ac176-9938-4677-a956-350fb50dbc0f@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <f48ac176-9938-4677-a956-350fb50dbc0f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 14/07/2024 17:04, Rubén Justo wrote:
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

Do you have any comments on my thoughts in 
<8434fafe-f545-49bc-8cc1-d4e8fb634bec@gmail.com> ?

Best Wishes

Phillip

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   pager.c | 43 +++++++++++++++++++++++++++++++++++++------
>   pager.h |  1 +
>   2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/pager.c b/pager.c
> index 251adfc2ad..bea4345f6f 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -14,7 +14,7 @@ int pager_use_color = 1;
>   
>   static struct child_process pager_process;
>   static char *pager_program;
> -static int close_fd2;
> +static int old_fd1 = -1, old_fd2 = -1;
>   
>   /* Is the value coming back from term_columns() just a guess? */
>   static int term_columns_guessed;
> @@ -24,11 +24,11 @@ static void close_pager_fds(void)
>   {
>   	/* signal EOF to pager */
>   	close(1);
> -	if (close_fd2)
> +	if (old_fd2 != -1)
>   		close(2);
>   }
>   
> -static void wait_for_pager_atexit(void)
> +static void finish_pager(void)
>   {
>   	fflush(stdout);
>   	fflush(stderr);
> @@ -36,8 +36,34 @@ static void wait_for_pager_atexit(void)
>   	finish_command(&pager_process);
>   }
>   
> +static void wait_for_pager_atexit(void)
> +{
> +	if (old_fd1 == -1)
> +		return;
> +
> +	finish_pager();
> +}
> +
> +void wait_for_pager(void)
> +{
> +	finish_pager();
> +	sigchain_pop_common();
> +	unsetenv("GIT_PAGER_IN_USE");
> +	dup2(old_fd1, 1);
> +	close(old_fd1);
> +	old_fd1 = -1;
> +	if (old_fd2 != -1) {
> +		dup2(old_fd2, 2);
> +		close(old_fd2);
> +		old_fd2 = -1;
> +	}
> +}
> +
>   static void wait_for_pager_signal(int signo)
>   {
> +	if (old_fd1 == -1)
> +		return;
> +
>   	close_pager_fds();
>   	finish_command_in_signal(&pager_process);
>   	sigchain_pop(signo);
> @@ -113,6 +139,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
>   
>   void setup_pager(void)
>   {
> +	static int once = 0;
>   	const char *pager = git_pager(isatty(1));
>   
>   	if (!pager)
> @@ -142,16 +169,20 @@ void setup_pager(void)
>   		die("unable to execute pager '%s'", pager);
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
>   	sigchain_push_common(wait_for_pager_signal);
> -	atexit(wait_for_pager_atexit);
> +
> +	if (!once) {
> +		once++;
> +		atexit(wait_for_pager_atexit);
> +	}
>   }
>   
>   int pager_in_use(void)
> diff --git a/pager.h b/pager.h
> index b77433026d..103ecac476 100644
> --- a/pager.h
> +++ b/pager.h
> @@ -5,6 +5,7 @@ struct child_process;
>   
>   const char *git_pager(int stdout_is_tty);
>   void setup_pager(void);
> +void wait_for_pager(void);
>   int pager_in_use(void);
>   int term_columns(void);
>   void term_clear_line(void);
