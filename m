Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D2179AA
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790232; cv=none; b=l87knA/xk7Qv3Q3K8nCu8SBZycaZcqrQdtM6jo6wpO1Ed5v8oiitmkRUcV1Mv6LCbeDT2HGuqyQ31XJd51wgwZgpYyvzYcRxnWRTUzkftFYnDPmbmblp/X3rygLQ9Eht3cj3S39N5d5+jWDKrmpCFCUS5cQflvlvdMO8T2Qve8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790232; c=relaxed/simple;
	bh=83tsMCen12cON9Gv/ibZBQ7lpT5WxojOrs/Runp8C4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAYgKtpfo6ZJm9+onYvL9QTDMwHs5HlQMDIn5m5kZSfp+R7pTiR73SnUHGYAcLiKbyilsekX3wCvl8T+4cBa2PtwfoKcbk7EfSAyp1GZFr7zKB7M2qMSrlyUozMDJUp2B778cdAUgOn8S4WEdMPXUhKK++V/cvMjsYdkHPI8XLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmqjTbQc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmqjTbQc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266fd39527so14656905e9.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720790229; x=1721395029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7tCDximaoasVi3Cy79bhsiCle4InRVGCtezwl++wXg=;
        b=BmqjTbQchg66mPaopAbsK+hFYGyUK8D12RWCKhWW+dsXdlVbP0dVqiZ2sFWG8Py5Wr
         kgs4BctU6lgTkOAz9XgHkTfd/5CFEZ+a3nFEKuxrg6hPd/CnfEgnerWfOr/+E1r+KmXl
         Fv6qxV4//9ASYgIDdumCblb8lRnFTVLlqUEjMIwg2to31nYihxRisjqNpCQ/yQDMGEKt
         GJsnFPpyBXzhnGXibaIk/6sONb1hDSvAVSPuG1qRdgzx3OYSZj/DEWU1BNpPgdhsu3ij
         BXxF0ll+2PahCU8qOZDLt6J5bQpapdySYIc0UrdYv4JkI0UbvEDdQFlRuNcH60d/LRei
         Nbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720790229; x=1721395029;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7tCDximaoasVi3Cy79bhsiCle4InRVGCtezwl++wXg=;
        b=vt3V6IIqp6mQZU6wO7utq0nPaB4mZHtGM7lhXO2b1sDDQgw0GRr9l7eVOLvK5JyRnO
         rDeYlmx39cAYUWx45Ggsp9PY18RAF2/JHZXXNcF7MqxBbqI+UZFAo3b/8730vFGahp0o
         /sx58KPDVFp2WXjBsVrUo1LW+C0TUK1W/mrRbcxHbjlRlHq+OhmIEPDgVZnEwCp4RImx
         dtQhvbj4ShHyzPZdTXQsBTwBDaTeCXleQ1q2sC43YmpUdIOKsWUL2Jnr9WwDUynvb6Jd
         Tzk4eE+3hLW/A6k02KxLQoGzxuxdZFLNhpmlN7YRip1HaNrZisWZgScFa+XM0eX+AkQA
         OHMA==
X-Forwarded-Encrypted: i=1; AJvYcCVk8g3byMepom39ahbsQmAz/mwkGORw3RKlOKYdv6AAHPAyu7q6KL3JroBd4axkPK995+PyMHQUH+okbWnXma38sRIl
X-Gm-Message-State: AOJu0Yw5Q4veureLmcc5sKfA4eqc07S0Jn6shzWdV91O1HVESUINaqza
	8WI5H1UaAaM81t/I4X5d4uMT78FenEoj/pv/sD9K19cT7xszZqmZ
X-Google-Smtp-Source: AGHT+IFgkLw4xibpWuJKA2Ip1E+2if50qxkUMktB5LeMMCOBdmKgJJVqbEYyZsjPOUSxiDfGU7HAFw==
X-Received: by 2002:a05:600c:2284:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-426707f81a5mr72872205e9.26.1720790229280;
        Fri, 12 Jul 2024 06:17:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4279f2d73bdsm23778375e9.43.2024.07.12.06.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:17:08 -0700 (PDT)
Message-ID: <8434fafe-f545-49bc-8cc1-d4e8fb634bec@gmail.com>
Date: Fri, 12 Jul 2024 14:17:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] pager: introduce wait_for_pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <4b5d0e7c-9492-4495-9bc1-40ebea850fde@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4b5d0e7c-9492-4495-9bc1-40ebea850fde@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 12/07/2024 02:00, Rubén Justo wrote:
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

This looks good and addresses my previous comments about leaking file 
descriptors and restoring signal dispositions. A couple of thoughts 
occurred to me as I was reading it again:

  - We ignore any errors when duplicating fds,
    "git grep '[^a-z_]dup2\{0,1\}(' shows that's not unusual in our
    code base, though if we cannot redirect the output to the pager or
    restore stdout when the pager exits that's a problem for "git add -p"

  - We should perhaps be marking old_fd[12] with O_CLOEXEC to stop them
    being passed to the pager.

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

