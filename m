Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5F27587E
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154448; cv=none; b=O7R7i53f+AS1Gr50QMdWUxEbKE54nPgb5KCf7LO+KDgaqk8s2kUgi8EUHY3LYS3jOp2LnOR2UdQ/zNfY4+E33BPn6mvHGnKuj3Jyed8fS/Vv0IOGi+gH4f5k0f1CGI5UORL47CActj5t9NT/L7GYboRF68z4WNWX1kYLVN8aKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154448; c=relaxed/simple;
	bh=jPi2zAILAy+idmwR3XNPqe1UGiIHhLyx8OcM1Ur0rRM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HGl2ggK9grN48p1DVS9JWCSgbujp9o6MM7vgfpZ6A4ICTDcZe++DfliZltxiVd19SNFgZmBiobNFfAztWUguIgv+OJLvBy4jMoE7wpPVhh6b7cINNFCF2oSvOS0SmPFPawdeRr3ZriZndeBU/3+ZtieLLJizwI+eIq0jCsiFVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhEfwmzv; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhEfwmzv"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbc3056afso998327f8f.2
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766154445; x=1766759245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oByltxcBsNPtvIkfle3QXsFQpb/izb38eBsHMAlbOlU=;
        b=nhEfwmzv2MWiYCLe3lB7V5LTqKovsUxpIJtT526r4XauQ68Nj/8eNAmKqMm9qhjL6I
         93o8oshZBQwgoq42pfsJhX4at5jxtYg9p/XHRfkVyuUud6ma7EqArdFoZocnvcqJWb0/
         GpkWbuJQo3NrumaYOiAtSxsriVT0+dRiH40I0vNds4fWyiiBbzYRi44nIZ/zssc4fKwr
         +YpUW6OJIn2+Sv3HKRACQeYOASWibTjVKJdMO1FepQtfIbums0Fcu67S+qtCqlulfANi
         CuHVo00FHTI296D0Np7xWtpXq7NM72jgIELAIjDGKR1qh8z3QY16/vlFZUa47ZZLWg6E
         lXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154445; x=1766759245;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oByltxcBsNPtvIkfle3QXsFQpb/izb38eBsHMAlbOlU=;
        b=VA6Qb6B6BxqrL1ME+C24qGb9BuQtBPtLIaSRx13As/8tgXS02kFtoEtU5RZX4eMbBn
         ut4cQOT6Rd0Bhsvog9Yu57aEsuKy8PqvLYAWhF5Tdz2Bi5wVeCHQHBCjOP5mv4MbCS/2
         S/paNSRc84jQodJze7Flu1+qcPIQTWPhk2BvTh9oZ5stkVd4s7ClHQbCLfUUbaMpHa0Y
         h56GByNCs/rnAYWVBCUAfvE+RKeqagkKxomrFSmZSBpwPod91CYhRYrUt0HX5jBFlbP4
         4EiMz5yia7TVTJ7R9j9wXS1/uD237Jq7KOHYHI4LBzdpiLHhCKHOcs/dIXWRG028CWS+
         uz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxJCdVzXyTzKLDpAR+vdHWpRTOkcQQYPXliSJl9hXUUI6rpieM/aVu+SxZSHgDCTmFAEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUoXVaw5lq5UjiLsqNEDsI605ykpSHyeJNn/r98VamxErxCaj
	slDDVdvvNYvX3wheiehA7wQsHBpFs7wm1IGTprg3DDGXmK3mQg2bq+p5
X-Gm-Gg: AY/fxX6sX2tFLKtUBIM2Is73TclQ4cnQk7jRZzyFNaCFGKmF8FRx3qgq87iha09bulF
	UEfvqsMD81Hb12gjRcM9/E2W0Iles7yj6Cu6koJ49VMLrHUAJiAMmlE6SaZ+18rJsTGqYclciUF
	PuQRREhmM1ZVJL7NOZnrxIHMztgtEQPeqGvSiXNUNbMFDQ9MzWEbx9o+rNSnRn/kbibdYHEPTW0
	kcB3FQQ/Ti7O5pDRr9UFPb88BKThPXJG2+Ea9++zfCVB0t0uTbORtPzynzUoUZ5h15blVb4o1ZH
	p76WksTRnr6vUttSDwlzoqkiXHoUv8pGxOrsq6T9fQXkVUE99blTNkxffLAioOGWWLyoRZ1PNsr
	JH2qqJEA1CRK7RIKgMxaiy5/lf7mubwRfsR9AuTQjoV2SPr2Fwt2u4r1K3e5Zp5TJhOIWbH5AcV
	rWRPnX3FqsinVbY9F4GWjJpZCaWqXUJMFDKTSMKWkHb601/cdj9unCrqJeUnpYG6Q7CA==
X-Google-Smtp-Source: AGHT+IHc0zP7w5+Ois451Ka2q6+Vc6mkDhv3JwdTyAQOepjMthpIh0JV3OvE5JDEHZ0ydAaSs39LOQ==
X-Received: by 2002:a05:6000:4008:b0:431:2cb:d335 with SMTP id ffacd0b85a97d-4324e4fab82mr2929853f8f.34.1766154445150;
        Fri, 19 Dec 2025 06:27:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2267fsm5134636f8f.12.2025.12.19.06.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 06:27:24 -0800 (PST)
Message-ID: <f141e335-9729-4f09-86b2-12a39f24837a@gmail.com>
Date: Fri, 19 Dec 2025 14:27:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: add --no-indicators option
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: collin.funk1@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 phillip.wood@dunelm.org.uk
References: <035238d7-f98a-4072-a363-9a57650abb95@gmail.com>
 <20251219114602.96489-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20251219114602.96489-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2025 11:46, Harald Nordgren wrote:
> Hi Phillip!
> 
> Yeah, getting rid of the extra space in the beginning would be preferable,
> I can take a look at that assuming that this has any chance of getting merged.

I can't say whether any given patch will be merged or not. All I can say 
is that if there is support for an idea on the mailing list and someone 
submits a sensible implementation then it is likely to be merged. If 
people on the mailing list are generally unconvinced something is a good 
idea then it is unlikely to be merged.

If you want to restore some lines from a previous version of the file 
then it would be worth trying out "git restore -p" as Ben suggested. If 
there is some other use for this then it would be helpful to understand 
a bit more about it. I'm struggling to see why it would be useful to be 
able to copy and paste a mixture of insertions and deletions without the 
'+' and '-' indicators. There was some discussion a while ago about 
being able to view just the new version of the file[1] would it make 
sense to just show the old or new version when the indicators are omitted?

Thanks

Phillip

[1] 
https://lore.kernel.org/git/CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com

> Harald
> 

