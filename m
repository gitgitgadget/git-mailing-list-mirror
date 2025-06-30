Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315682253AB
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274018; cv=none; b=usR9YkDuWA+g9YW2opLfxmXEB8bwS8s7rY01go94n109siYGBiB8LrBSiKtjMs+BxyZMXmR18LsPkMoes6pwWlUeNywcfZMPgNK2XvIKlsIa7V2fP5VMjWmQEo4Tu1GVYYVTsL5UrtzwRpGtcJA+bXINXPWZaf7+AacFCCG/JmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274018; c=relaxed/simple;
	bh=e0DpOrPGDNZfdFSIrPQ5QVPojnQS85xsqlyPS/sOfyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClBe4ijJ8VCK5ZTn3df1V0iVFb24p7+1HG5lln6mxt8ptojsnyUA+3auiVBWSTYXwlmhyiWThI30xXal3Wq8EL9j7V3dl0+dze9Rn+kRg6IsYvkd4EFr1L6MpLQnmRcsk0Vg6iEBwpXWVQaTSWe/5vj5EMY9sX0rW9/+NP8O2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw9t6THH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw9t6THH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so1101134f8f.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751274014; x=1751878814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XeURetw7l1Zc6+5NRFjjmBNH4BpKsyqQg1WKcOLKYFQ=;
        b=bw9t6THH9S4gKobDC1FpoUEPJrUeXkMbPiI96zDxCs3ELtZsRCfg46fEmmTkieCs76
         1qhdB36lKTOM0EHBFL7R6MQ0++IqW3qz34ZuTIQovG/rPfoLQB+a8JxkgnocMpKfJte8
         Fo/pgs/eljk0eMD6GrF6pQ4tm39054ruw/7vSErdN2icPXm7BfkKNGGW7wmPy5Me2mfj
         sAX+J7rjctE2HQlnpTyDAuDudP6JpJxEZB5uSHaUjP1cEVE/OVPU4LdTNp5yh2l7LfEQ
         5o8tR1h593ejFioVDDir9rZjPV2hR9e2N8q3//OzhLJIn62PUdmh++FgZVIL5A7IL835
         A09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274014; x=1751878814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeURetw7l1Zc6+5NRFjjmBNH4BpKsyqQg1WKcOLKYFQ=;
        b=PklMp+mZubWEr3ucRz4oO8rDX3tdF3cV6ho5BJ7WAeTE3yi/ZV001yvTZ+QUuKfsiq
         jdRx2vZMil01gY8Ssp3Q4XVUcq+X9U5RiEeHCh7IrwtLH5B9sI82vjJbqbcMixqE14mw
         OwyYRcBvf8/qhBD6CC80hO2OX3rumHXJ/R9z58MPPYQM6c/L+1llm4vDypX91kOQv1hN
         pK/prPT7yECtNEV/u3xTleykSJfbD3nytws8OJy6wW7CD2Lrq3mFsppuz+HKe4J5WPgN
         vX+t9w3FwAvSBVRlIWv5wmFbII1oBUXExwYHeuEy6KRHWob/L9r1E+NOUA7kPOtT6Uoe
         RmmA==
X-Forwarded-Encrypted: i=1; AJvYcCWc2xlIB8BzbSnojAe304zC/4KjZD9B0l78fHzgctV7yHuID7XiZZvXNHK8RjnFTb40QBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TKLko1byok1tfu+lQfMWyIvIM59rqutk1KkhbYNfzHNMLGZP
	d5qqL9UzDe3kpNid+M57Xv0Bn9vCFKH3gt+mb8qL3il09hYjMkllRW9FKkTMdQ==
X-Gm-Gg: ASbGncv2EehtMPjEMU+wqFsnrwxQg0NVyQOOgF5Mf7GGrWrN40t4xA2RfCGT2GxQ2o2
	XE0JpSAfGJSP0YEElD2vWcCr2FnQsddyOMZcobcU2BsMSBkyRqBJE2moWwjcuhA4ZdmuIl0+8gz
	aWMIkQDTP4c+CYgAN3CPmTqJDfdWiPWENQtqeeHKgQH6FasO2ulbuh4mO1smXiWRimFCfg4sT5w
	pcvvzir26FMMfvjiuxV/CTQshD5i/DzO7AjAGwwfBfAiPcfyx3fG8zTyKGEaIZTL4EJjIdaKV8R
	akEkGmnTUyM6alAcDdowGyc5yKe8iH12ab/L3RTBrYfHrVnLRibiKqVES0eJu2MWbVvsB6Ulzhs
	+IRCsKM1yTPUvNZOKNLcmMcGf1v1lXJ9YYfHJ0A==
X-Google-Smtp-Source: AGHT+IEtvT1F4bn25L8oI17FPURSOq5RsGeAyHtVMK/mukZt2n3rixlucYZGH9WG3VGrgon4GOLSBw==
X-Received: by 2002:a05:6000:42c7:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a8f50cc97cmr8707943f8f.21.1751274014208;
        Mon, 30 Jun 2025 02:00:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6d50sm160413775e9.30.2025.06.30.02.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 02:00:13 -0700 (PDT)
Message-ID: <16612f65-80ff-4162-a1df-31c2777eb848@gmail.com>
Date: Mon, 30 Jun 2025 10:00:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] daemon: handle EINTR failures from waitpid()
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: "Stephen R . van den Berg" <srb@cuci.nl>,
 Erik Faye-Lund <kusmabite@gmail.com>
References: <20250630041303.93370-1-carenas@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250630041303.93370-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

On 30/06/2025 05:13, Carlo Marcelo Arenas Belón wrote:
> Since 695605b508 (git-daemon: Simplify dead-children reaping logic,
> 2008-08-14), the logic to check for zombie children was moved out of
> the SIGCHLD signal handler, but adding checks for a failed waitpid()
> were missed, with the possibility that a badly timed signal could
> prevent the promptly reaping of those defunct processes.
> 
> After the refactoring of 30e1560230 (daemon: use run-command api for
> async serving, 2010-11-04), that reproduced that bug, a single
> process could be skipped from reaping, so prevent that by adding the
> missing error handling, and while at it make sure that ECHILD (or
> other errors) are correctly reported as a BUG().

I agree with you analysis, I've left a couple of comments on the fix. I 
noticed this when I was reading the code to see how well it handled 
EINTR and decided it wasn't worth worrying about as we still collect the 
child the next time we call check_dead_children() but there is no harm 
in checking for EINTR here. It might be worth noting in the commit 
message that the linux man page for waitpid() explicitly says that EINTR 
cannot happen when WNOHANG is given though. I wonder if that is the case 
on other platforms as well because the calling thread is not suspended 
and EINTR is usually associated with calls that block.

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   daemon.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/daemon.c b/daemon.c
> index d1be61fd57..16ae66a2da 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -864,8 +864,11 @@ static void check_dead_children(void)
>   			live_children--;
>   			child_process_clear(&blanket->cld);
>   			free(blanket);
> -		} else
> +		} else if (!pid)

Our style guidelines say that if one clause of an if statement needs 
braces then all the clauses should be braced.

>   			cradle = &blanket->next;
> +		else if (errno != EINTR)
> +			BUG("invalid child '%" PRIuMAX "'",
> +			    (uintmax_t)blanket->cld.pid);

POSIX says pid_t is signed so I'm not sure about the unsigned cast here. 
Do any of the platforms we support have a pid_t that is wider than a 
long integer? I wondered if we should be logging an error instead of 
calling BUG() but I think any error other that EINTR indicates a 
programming error so BUG() seems appropriate.

Thanks

Phillip

