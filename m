Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341B17C9AF
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857135; cv=none; b=s8/pSP7BWTFM93OopcoXsclo72DzTCcdIcRa/p1WqN4gAMBJ6AeveiWdwsoXuBPldm4i8I45LbtH0pfLBCG3ZlMDMAVW1o84g7XM3pOK1RSRI/aIMZZi9kkk1+Yc2FTROnry/2qrEhQbEsugGbzV1G7Wo4Qu0P7ssJkU7BiCZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857135; c=relaxed/simple;
	bh=4LD49u5giNbB7xT55MQc2fzFxZfa84BZkef4KX7EBoA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TEkxR5/QI/0+11tobj9mslvATt/LVhn+qoexS2mrvj0s+2X0ZVlbVbsW80YhfxkKX2YYdGwN5rZaBt/0X2/VDulalMmQdrSeKyzzslRLhYIajo7D+GtUuL8Eg2HsolS0htsN2m/152fAQ6ueK8aj2DlHQoUL+XWxCmWi/gUyyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwD3F/YU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwD3F/YU"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so1334705a12.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724857132; x=1725461932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BP7jqJR9DYSb5soyA1mBcS6/5iqDbxV8cAY2QSPnrnk=;
        b=hwD3F/YUtS9zcF9oJSZn9PZF9mmhYeSfvwlScvzEYUnCvq6+XZe0x1KNl39wHkY24H
         D3JH2ow8Md7IpkHdPVp6Bx9azChaZJEdNIv554YbzlQ4AHR7SLWlk4BtNCArw8ivUjeq
         lNuCaCw06YTmYnWCgbw7DdirgpDM0P5R5wnz221BFonE/ay0OGB/yXQigcq3uxiYSVVt
         yLoBQp1bxF4B9CEJbJ2l8tx98rVFVcLxPejdGWDS++3RRYU3Zm21Pvwsy5wyOECu9Epf
         XHJAx/qK+nYl5G9rfNeUelX6VhZC0t/xLob1neN/I06q3dzk76FZyyPLH5MV7/v18IsM
         BPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857132; x=1725461932;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP7jqJR9DYSb5soyA1mBcS6/5iqDbxV8cAY2QSPnrnk=;
        b=uNatq9WN8L+IyD9XRUF5o88lOvIs7a8b2Hwdype9hiXvrWKYUv8i3EZFyQvjWHUhyD
         Uul9Ot1WP45jpNtGRiZWNiykzroJjSNagMxdSDM6YXVvAVJ4f/VgJWcHIYRYD78s0O6u
         B/1VY6UVpya7JgVz4jjQr48YiwSjWSPJcWAEoSq8sknPTfe5nU98fjjHdBKu8XnGuv07
         Ul6xobTppwyEkC6GTtEsei6Wb0EcMmD+Vg+Lqe8JmRF21UnqO1VbKgbl/n67mf+iFyib
         l1TAeslH+AZnCV9w5ISLW+OYJUHu862xw7FhiApIoxWn+IiS8WJtBvhRWyvLdQr1ljR2
         u3CA==
X-Gm-Message-State: AOJu0YwdgEVaJiAK72A910e8uTEC+YnoXyzew9bRHQTL93E33hW0qRjq
	i0kVtZRyqjTyuSOjYdAfBJ/hcx0SeBDeZgcTb9G0nlYOwMWsB71/
X-Google-Smtp-Source: AGHT+IG1eXWvwqCUWYvBQVksUpylnwsK5RPdjyrnAb3Ueo7ErD9zsHAUOWD8bOKnCnfOAURc1E0Ewg==
X-Received: by 2002:a17:906:f59c:b0:a77:c051:36a9 with SMTP id a640c23a62f3a-a870a99dbc0mr264803266b.9.1724857131325;
        Wed, 28 Aug 2024 07:58:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e548963asm255693466b.44.2024.08.28.07.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:58:50 -0700 (PDT)
Message-ID: <13c94c27-0975-46dc-b94e-72fd3972ef16@gmail.com>
Date: Wed, 28 Aug 2024 15:58:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 00/13] Introduce clar testing framework
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1724159966.git.ps@pks.im>
 <e9c015a6-7fc2-4783-9ef6-05359adf46cc@gmail.com> <Zs8uDnUAFFKF4DTF@tanuki>
Content-Language: en-US
In-Reply-To: <Zs8uDnUAFFKF4DTF@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 28/08/2024 15:03, Patrick Steinhardt wrote:
> On Wed, Aug 28, 2024 at 02:18:49PM +0100, Phillip Wood wrote:
>> On 20/08/2024 15:02, Patrick Steinhardt wrote:
>>> Hi,
>>>
>>> this is another version of my patch series that introduces the clar
>>> testing framework for our C unit tests.
>>
>> I've left some comments on the code, most of them are points I made in the
>> last round that received no response. My main concern is that the assertions
>> offered by clar are not as convinent as the check_* macros.
> 
> Did you have a look at my reply at <ZsSTOczuGhT5zwoV@tanuki>, where I
> responded to these concerns?

Oh sorry I'd completely missed that mail (it came in while I was off 
line and I failed to notice it).

> In summary: I'm aware that this is still a rough edge. I'd be happy to
> follow up on this and improve usability of the assertions, but doing it
> likely is a bit more involved, mostly because I want to upstream all
> changes in this context. So I'd rather want to land a basic version
> first, and then I'd iterate and improve asserts.

That sounds reasonable

>> What's the plan for converting our current tests if this gets merged? If we
>> were to add wrappers that provide check_int() etc. that would greatly
>> simplify the conversion. I think it would offer a more ergonomic api for
>> writing new tests than the verbose and non-typesafe cl_assert_equal_i() and
>> friends.
> 
> My plan would first be to let things cook for a bit while I sort out the
> rough spots upstream. Once done and once we are sufficiently sure that
> this is the direction to go I'm happy to do the conversion myself.
> 
> Whether we want to have wrappers... I dunno, I don't think the names are
> all that bad. They have a clear namespace and say rather directly what
> they are doing, which I value more than briefness (to a certain extent,
> of course).

One could argue the check_* are namespaced by "check". I find writing 
unit tests in C is pretty tedious and having to type cl_assert_equal_? 
just adds to that.

> The type safety is another topic though, and something I
> will aim to address.

Thanks, it sounds like we're more or less on the same page

Best Wishes

Phillip

> Thanks!
> 
> Patrick
