Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36236192B68
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593694; cv=none; b=a9B57hY97XEVzR/ryVJEPu8pjAo2ArzCfYbk+JD8u+ZV/s/Y5CSfXvjagX30RJbdcsu/4BSwzb67izJolQv92mS8eREr34ou5hNgqvAI7YgatuPTA2uuJkVm5XoNnssa15KW2iL+P4twaq+iLuDw0SYAxuvelm2cwxTJXz1+Gs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593694; c=relaxed/simple;
	bh=/6VYDsCZN6DDLVoB37ERCmNUgWnbe9KAqul3VW8vF/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNxBEea91Lny2oTuUPIWt0LqQNBP0CAYkOaVrFOgvu8xJNWt/d0Fm/wJ7rn1gDqKDU+Kx8gduxBnWGiLD7jAuOaiVjTCW+z2N+bCizuc1LN5uQVq3QkQ77hN3wwKRwoGEr1EcldeE63IBBqdWV5mZY/G51oxKtvPFbC5ai8yLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD3Cacry; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD3Cacry"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35e5c6600f0so3044829f8f.3
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717593691; x=1718198491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyy5+hId2jEnBINSb33cj4w++tO0mLR1XJNcIhQMV+o=;
        b=VD3CacryeC2TJG0XZbCxtvGaYbp2B8f1j21Y/hSQIFWn0o/dKZFuXfyj804/E631xg
         kW4ClAGi5/+ve9DQ50oKUXflIljEDm0Hh6czDQwFD14q14A9CosX8qocrm1/RPGAoVMO
         AkdTHw0qcUp2BdgeTEvp4v0Ya7NYEKxii9S+VMYrs35lFn9yvar1NCrdrwWCdvzz2WKE
         hbiwZbhq6a4qT2uBuBTIaKJ52B3QbSOjRKf/2llMDZ8lhGtt/Ex45q8kf7Qj+p7+J7qT
         f/ArFiBAgMkQy73R8VSU/odZiH/oxRSbbAmPspj5uTB6jnkepAVnayEfH6xRds9tnk6p
         GG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593691; x=1718198491;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pyy5+hId2jEnBINSb33cj4w++tO0mLR1XJNcIhQMV+o=;
        b=S1bRoXzfxZUjbR4RkpdnMiiP4npfFRVYK8gqu4W/yYd8MaSWcNcaMrxegtbBMIfSci
         BXSClfGtFOZdWnBSILCwBIGYQ5gO8D2NhUh/vdke9ulupW3g7JecesM1gXUBnRYSPqbd
         zJvMmUoZarvQ9RbMI8gkG0egNjvpZZx2HNt9vATSoGcrfVYEkuyHYnVRpNeHrGEth++Z
         gltujWpgDN6QhvnO9F15fYbE5q4XR54qvk9/iXDfJZf/NAAj6n3RXtXOhKmzbL178eGy
         zJdsxRvnt4/QNk7vys4fZQv716l6GcjeX5vAjWe5BrrgK9mgskDN6MWlxRIvINd+AOlw
         oyxg==
X-Forwarded-Encrypted: i=1; AJvYcCVTVc9Tkg3n5wFv/f84bAar9c6MyKgjZ5PMiIY/EN7AQeXU0oKDW7NKsLfvEy3QKiuQLQ9ogo3kGT6HACrUGuO9WPWc
X-Gm-Message-State: AOJu0YyFtIPELqPhvNvhUxgdsIxCb/t5Dv7MHUiix2AQmDLesGXDlMNj
	afcolOsVwu3jErZ2bNUg2xywTgz9smRt6JHADATi5NH7X6qiy2No
X-Google-Smtp-Source: AGHT+IH0eqngsEQJvkt6xtEgi/GyTKw/CAoQzlwEnIVjiJmPgM+FHLajZrElJXwnp2hDGZWSDmp2CA==
X-Received: by 2002:a5d:4d10:0:b0:354:fb50:c1ef with SMTP id ffacd0b85a97d-35e8ef86739mr1851531f8f.68.1717593691391;
        Wed, 05 Jun 2024 06:21:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1? ([2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04caea8sm14554438f8f.28.2024.06.05.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 06:21:31 -0700 (PDT)
Message-ID: <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
Date: Wed, 5 Jun 2024 14:21:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240605090935.GF2345232@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2024 10:09, Jeff King wrote:
> On Tue, Jun 04, 2024 at 08:32:04AM -0700, Junio C Hamano wrote:
> 
> Given that the main use case for "|" is for human viewing through a
> pager, I think the colorful, filtered version meant for users is the
> best default. And then the "bare" version can come from an alternate
> command or a knob.

I think that's a very good point. It is hard to see what "|" can be used 
for other than viewing the hunk as (a) git does not read the output so 
it cannot be used to filter or edit the hunk that is applied and (b) we 
pass an isolated hunk so the post-image offset in the hunk header is 
likely to be wrong and there is no indication as to which file it comes 
from so the program being run cannot apply the hunk itself. Having the 
escape codes does make it harder to filter the hunk. For example to just 
look at the post-image as one needs to do something like

	grep '^[^-+ @]*[+ @]'

instead of just using '^[+ @]' as the pattern but the bonus is that the 
output is colored.

> Just to note some prior art, mutt's "<pipe-message>" faces a similar
> problem. You might want the raw message (if you're going to poke at
> headers, MIME parts, etc yourself) or you may want a decoded one (if you
> just care about body text and don't want to deal with base64, qp, etc,
> yourself). They provide a stateful config knob, but then you end up with
> horrible macros that toggle the knob, like:
> 
>    :set pipe_decode=yes<enter><pipe-message>my-script<enter>:set pipe_decode=no<enter>
> 
> I think having two separate commands for the two modes would be less
> confusing.

That does sound simpler

Best Wishes

Phillip

