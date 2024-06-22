Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACABD14B082
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040142; cv=none; b=obMB5oI4Vy4xsbvhLgkF95zke+x1Ojo2Rm+/kHKxpj4eKEQOLh0bviEjXsrnGabSqY+tOlPWYwmJjt81t0D0zBWsU83hZ6Ww4EANySMdAktcKfqV3qDIQlhfKCCKgHHFEtd1a0dXirxLK+770a6kkbXV2bLZ625E9EPmcoiuAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040142; c=relaxed/simple;
	bh=RNRZZ8h9NzhD4GMp9Qu0m2fjDiLDeVaxLaiVzOreLHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVJeU93UYu1+Eas4qB0N5Gh/NF794ZanIB1N1qX8qisjJXIvvLiB8XRLga62szqLMavMu5jA8kpLcYD4pJ1iIb/NqRBNdvl/GnaXeTPYWkMiyzNCnqrbPOFU8awkY3xQzTg6EBQZXoTI7IPN2Z/TV/8p0KVwegExGfXD+awaT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4W5lh51lQGz5wF3
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 09:08:53 +0200 (CEST)
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4W5lgv0lz0zRnmN;
	Sat, 22 Jun 2024 09:08:43 +0200 (CEST)
Message-ID: <f031c152-1b97-4598-92f3-a72aefd701a4@kdbg.org>
Date: Sat, 22 Jun 2024 09:08:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pager: die when paging to non-existing command
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Dragan Simic <dsimic@manjaro.org>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <0df06a80-723f-4ad7-9f2e-74c8fb5b8283@gmail.com>
 <6850f558-ad20-403a-ae1e-5b9826c53790@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <6850f558-ad20-403a-ae1e-5b9826c53790@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 22.06.24 um 01:31 schrieb Rubén Justo:
> Let's make the error clear by aborting the process and return an error
> so that the user can easily correct their mistake.
> 
> This will be the result of the change:
> 
>     $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
>     error: cannot run non-existent: No such file or directory
>     fatal: unable to start the pager: 'non-existent'
>     0

Not a big deal, but the error message cited here does not match the
actual new text:

>  	if (start_command(&pager_process))
> -		return;
> +		die("unable to execute pager '%s'", pager);

-- Hannes

