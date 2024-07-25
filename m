Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0E198A10
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900710; cv=none; b=LQy1KBY5RoSdBp67XGLTgoe3xkQ65U7iu4cFgcjXbf5hooqtVXYBirBmTvsaRzrzOaAHcf4nQCyAawAJWpKHvqc0BgE5TOLHL5TVqVfDiOTgmsECTKDdzkG03f9zFNL1NuBbM1EUNekJeVAPq8uBT/esnjQOFC3CnaAQ3BJ+ReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900710; c=relaxed/simple;
	bh=e7nXx/fx/ji+rKSbEZNLVYSjuwZfFtHmMQ1kP1JdR7I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fiz59Gpqn5VJr92tPG923qtOlUnixpEWFUvXZo3W2SlnJTdOTp79RJO3lrjtNPj4rmvziiZLz0zZ+wLPIlpcwnBGWvgruSp0JCKI9bryun+udHlBaQguEvaZYRn2KbQXRemxNxbGdIJujVsXybsFtUHrQ9abgMzX1zhhV7tVnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4q7H18P; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4q7H18P"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36865a516f1so540349f8f.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900707; x=1722505507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZrsraHkHx2bTr+pCPdwwHIX6Q+LTbC0VkO5w0E//Ns=;
        b=O4q7H18PoLi/bTjxSdRScUMlTU1sEU6Yahqk0Pli/9s8yXY3qjDiDCITzJ+NSjVMcO
         y7Vyw5SsxjR8eZFGlOiRccXssSqzSclY9Z2kh1Dwy6inYuyMn58IgVerhTzia9mSpMf8
         KfB1IyFhk0hcZ9RKTUqxiLBtmPU69jh2i7CtY2f4fulhz9jSEJ2CoHgx4kZZYcZX1jpz
         Ngc1XDSRIuvP+5H4AFs35zfyi+piDD4WghUidmlAv2dSkp/CA6K2K+H7YkR5wO7omiIf
         3C1QSjZmcY7/CgQ6H335IIN391EA4yhoxowMyYiQwtfGhChJuD7bVdhEmsKwPj93VoyW
         0R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900707; x=1722505507;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZrsraHkHx2bTr+pCPdwwHIX6Q+LTbC0VkO5w0E//Ns=;
        b=Ymq/X4UeHwVXUZfyHY36/fzZDgIKUXe2N7jFGDD02HnSLfff1H9qz7VABY8Zx45p1E
         B+wKC47TDqiqavUOESEvi0RMywHqhIC6RAlVWeeeUG8wxz8kFWnIPUjwGjGOC7IjxIxB
         vDFjuHQ5tesu7Qzuj+2T2+lq9Q8ttPI20sHHpmVyr94U5RymK3V0wiKB/iBtinXLDyPr
         VlaTxuwIuh2NetSXYJ17TWotELjn4PitbS0CE+BogxitdMpdcBAV5RnY0l+vL27YrCKy
         ps7jk7qiF4Ml+td3JZpdER9sdRzdyEDUqoVzVEzeENXRwA3QDQ7DAiw7RhvMNmX0f6Wh
         wTug==
X-Gm-Message-State: AOJu0YwukKqvjyVQt1nadyNORQmiJUwhh9iLiOPc2d/nf/pnOIRbLwJc
	MpGnZhZfCphslqvIN6I3tzw71qoMVg5ZWx6bsix2CsHUky/dJTzP
X-Google-Smtp-Source: AGHT+IHpzNeWMMv38AGwh2T+sJbXDZRz5nFvptxVFx5DMbesYYIHY7pP5/8cna5m2PU50OcXv7YI/w==
X-Received: by 2002:a5d:588a:0:b0:367:9903:a91 with SMTP id ffacd0b85a97d-36b363ad791mr1430810f8f.11.1721900707048;
        Thu, 25 Jul 2024 02:45:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d? ([2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857c78sm1546377f8f.87.2024.07.25.02.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:45:06 -0700 (PDT)
Message-ID: <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
Date: Thu, 25 Jul 2024 10:45:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/2] add-p P fixups
Reply-To: phillip.wood@dunelm.org.uk
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
Content-Language: en-US
In-Reply-To: <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 24/07/2024 17:12, Rubén Justo wrote:
> On Wed, Jul 24, 2024 at 04:21:53PM +0100, phillip.wood123@gmail.com wrote:
> 
> That was my initial thought [*1*] when the problem with "dash
> 0.5.10.2-6" appeared.
> 
> Junio proposed [*2*] documenting the changes to address it as a separate
> patch, and I think it makes sense and it is valuable to capture the
> situation this way in the history.

We normally avoid merging commits that are known to break our ci. We can 
add a comment about the dash problem to the commit message when this 
fixup is squashed. Also the problem is now documented in 
Documentation/CodingGuidelines which is more likely to be read by other 
contributors.

> Regarding the bisectability, I don't understand what stops from being
> bisectable.  Except in a scenario with a shell like "dash 0.5.10.2-6"
> there won't be any problem.

But we know that shell is in use in a popular Linux distribution so it 
is a problem for those users.

Best Wishes

Phillip

> And in one with it, which should be
> uncommon, the situation is well explained.
> 
> So, I dunno.
> 
>     1.- 2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com
> 
>     2.- xmqq7cdd9l0m.fsf@gitster.g
