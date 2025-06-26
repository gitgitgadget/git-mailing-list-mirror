Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B042F22
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943827; cv=none; b=j60YjT4cNXW/TPLLG90NYKc/2dTXnj4LsDI4ccwWDmDW1SgwwygIFKTiiDqbhm8WJJU1yJv2P5exJQH/XR+3SsA+r4KYDCenHceGFuRsoPkM/EmbTswNN+INDc8UcqQkK8zxc8sFRpSdrvoxd5NjwB4550V016Ds3dnN9bxE9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943827; c=relaxed/simple;
	bh=L5wvvcoLXgc2V+OUgLjtGM5e8lAyo+8EKXz+TtSu8qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLI2EOm/C1zrsRjhsNje5koczFRJ8cyUEnhkSOMBhL6pC0FDbzqABmUDJRUHdJZUCOzo1qPabsFSj3q3QeQW8Za3YWlviuP56uilRUVcexVVov0ply6Oe/zRE5LcErDqnMxo2Qjr10ComIb1UcLGwMbjg88wgNkUgQcBfUUzbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCaage3Z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCaage3Z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so769239f8f.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750943824; x=1751548624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiN82wz3hxjmskpHCjyE0LlYK2S5II2P0ILRx0M2J+8=;
        b=kCaage3ZY9glVh6xOK2dt32S4YXIKPDlcA4EqeKULl1ycRqBNpS2J69xTE2xVZ+o89
         xJpjh/cnxCRNBR+nY97wvcz3vhhTsJQ2Qklg0Iqnu2aXpbUeFkwzkFz6ybnZOcwU1Z7V
         hwlkyLqeTjH5q6HYdbVO+E6doI2PWrzBp2bz7ldUPgr20YnSywD5eoGV9XHtStUg0bOP
         4qUeEZH7hKNtYVTkIRTzU6PWtilSIW0skZrQtfy1DuJYXZlgq0nV1W2xiEaScxFM0Iy4
         lSxU7hkiFkCliFbnU6psrsj8RT+xbTtw4xP6WZwhHsSOdBQp14gFTHAAXo/lD0QPvYjx
         J4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943824; x=1751548624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiN82wz3hxjmskpHCjyE0LlYK2S5II2P0ILRx0M2J+8=;
        b=DEs/VZKePCzZ/8SM6PI5vbzgobqto7a2Oo+Cuy2oWw3CpECI/nKs4c95gTOpYIF3JF
         yP3GPhMWxGKa3a/dvEneWBt8T5puNAdj3dz2NprOKs9n2kh+lz2NMsiM+EUj39W3Gw5E
         lKeLskkNoxrL4F+gwj3L8LbtVSepnf2sWkiQAiZPSllRbKWBTdCsX3KiQYyscCFNrmwR
         VHNb3WRjiy1QxmIIEQZCK377G4UFMw50jRnog8UkpqPO1VqUnrkdirWVPpC0Z4LUwZhS
         m4xUoOsarUXCuc4kNbB+9qZyf1P8nTV3YKguYwE3QGLOM/I+Oky4EVUSHpvnDWjrH8Mq
         6teQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ppq/X/Go8pz5Uot9jTtqJ/z7WNkW1hYl3B1rWcnjwSOkt65IGVgwH39dk8RSSNb74wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuefYgaYWIrrI0sL/1ntBzsqXN79DrbJ8uXsPO6AEd5ZhgzXdL
	Y3keJJEiX6h2U+vG2RFncqnJ5mzgCc1/xw6p5qDUqyfvaG68+ARiDT11
X-Gm-Gg: ASbGncvBO4XgRsW8ZHzLH21Wd3lW3spGmLsZ/SQSrHoc7pqJqPamMe4g84Y9/zlYkCw
	Wfw9p+riZQvrbDi6u8uBqjmq8ixA7SOsJpdgFeCbM18in/o4w9lQ6iWzL6IaHmOJpEAH53Vi28J
	cQzN1VJsU/SltbO4Ei1OKRPs0kpTPeFeO15sl1758yEHJuwEHL2ojHUC9bDbt+aXYnRhgGM+TOK
	rVgbBWyFtn3pHsnMjafcPVcG+k3gPYufcW6Q2LHUaOJRRs0pTczIDThlxV6inVYiPjh9yi117Ze
	azBqzAQzQfuZwRVlUC/cbYfPHtdV3EN31VgAfGdnCrVl+j/8zIrX/vFNYl572UtgYoIP7TLxh8a
	UaqmhNL3Y6BV6eB2/17+HWGwPMdh1dmk0ARoBiLNvTyRl
X-Google-Smtp-Source: AGHT+IF6d08gnTv4v0rNB0/wUsdSwggsoLro6bAGKYHo4NgEods6JrvCVLBjeGEzZ9lgV4rjczBoYA==
X-Received: by 2002:a05:6000:2dc7:b0:39f:175b:a68d with SMTP id ffacd0b85a97d-3a6ed5b8c1fmr5925834f8f.11.1750943823573;
        Thu, 26 Jun 2025 06:17:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5? ([2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8051153sm7160369f8f.7.2025.06.26.06.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:17:03 -0700 (PDT)
Message-ID: <3e03fe38-5bb5-43da-b80e-fb8ffc1b4837@gmail.com>
Date: Thu, 26 Jun 2025 14:17:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] daemon: remove unnecesary restriction for listener fd
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
References: <20250626095139.70751-1-carenas@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250626095139.70751-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

On 26/06/2025 10:51, Carlo Marcelo Arenas Belón wrote:
> Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
> 2005-07-23), any file descriptor assigned to a listening socket was
> validated to be within the range to be used in an FDSET later.
> 
> 6573faff34 (NO_IPV6 support for git daemon, 2005-09-28), moves to
> use poll() instead of select(), that doesn't have that restriction,
> so remove the original check.

Nice find, this patch looks good to me.

Thanks

Phillip

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   daemon.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index d1be61fd57..99741f0b45 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -990,11 +990,6 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
>   		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>   		if (sockfd < 0)
>   			continue;
> -		if (sockfd >= FD_SETSIZE) {
> -			logerror("Socket descriptor too large");
> -			close(sockfd);
> -			continue;
> -		}
>   
>   #ifdef IPV6_V6ONLY
>   		if (ai->ai_family == AF_INET6) {

