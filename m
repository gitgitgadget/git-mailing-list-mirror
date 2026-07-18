Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477B274B3B
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366552; cv=none; b=Ipnrr3Ct3Lss1LX/+I0zbEOANNAsgMGJ2R6+tc2fjXiTNNpXVm+I+aPO1cRokvnd2tn3cM7PYGAY4UEdh34rt37zREzvMLKf203WFyu79w0jaq8mPJ/Vfk60l3yP82zj/lNSyyOJMfz4tzYJje7RUgERdI+lqexomy7MM4DoiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366552; c=relaxed/simple;
	bh=8G1h23lF5DEaMF1yBmnVTTyrE2mk2XPC/gzY5wZrNJs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gvqO2OORLOtHPbs9evJcIriKD/MuvoFkLQYNGL4DdN/je2hn2rG7g1YhC7k933ecNfPqhoAG+7YOAUsNevl571qcF+GqMQIYtsxBruDjw9L+oyO4g5ATOkReDcq9aXQT+51//Vaj4uzIAm2sOJl7cZeY5aRa15+HhDnn5IYt2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRpVJc9d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRpVJc9d"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so6762718f8f.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366549; x=1784971349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+siAwHX7TpnyHLabO6Ibkbq3/mir4iHWR2Tf9vIkIsI=;
        b=MRpVJc9deJUBrJsKITOI+busUDe8XyCbi+v2VNTwJO92pQfseLWRUi3xyJ6/Wo1xqk
         OZnm0XGR1MjhGQYNCsLYPsI1C4XyjZjy4DPnUwoY36d0R3weLqLcLzhKiNNlzqcF1WJF
         DRySmsSt558xD4k/SycM60cvhlvjr7Q1BqZt3eUPz3EOE8YRXomeYy54WzxExOaA6/kJ
         7pHbpqkGLnpOOj4UCJKMB+FhPXzryBQJRG5XNLfsA66ZiQTTlUF4qQ1x1yIptHd9+eAL
         FIRqk4Xge+aNtNBOCdUXU3/CrMlfTgkiDD0vj0Yyy7DKE+LwYwLbFv7TH93y3nYi7kiw
         J1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366549; x=1784971349;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+siAwHX7TpnyHLabO6Ibkbq3/mir4iHWR2Tf9vIkIsI=;
        b=LJxAw8yjAhwriS4pRBWwSnfXpGzrcpguUGfb4Hrf8rfgg6KxSG/9kpJ74bEh2pBnD0
         WoUO+vIYVRtS80I3iYXU6EnqfrO3MnzPzVna9D3Ak6yX3Oki4Bpark821nWU0wVHfvlp
         D8b9B2fcirtUrDU7abDKqYmg+d/wbPQ4QkGEfjV/skw4fRu/FMbGXz02MTTqfavWnpth
         OvG4ZnP/tgrHlBgyYfK+KeLYSprvjNbSk8uCTppXNh3szoFayGjtQXmAUMQb9k7psymk
         l2VISF+Fqagj0JXrmA9i0kh3P9ZU1D8HfNDpfmxWY7nuHyR5eXBRxrygPdjS7RGwj19o
         eoYQ==
X-Gm-Message-State: AOJu0Yw5spxTIdLS+Ha4u7ljzdTLizgQR8AQo+2lcfPWzASlR3k5bt3u
	HsShfZ94YYc0b05JqTYy96v8jd4x3vINpyKJHWrJlinEYfhMzqnskd/E
X-Gm-Gg: AfdE7cnVY3KpCBk0wRWAeemiHqa4lq5FRWdOYrpQ5+MR/b5y8HDJ7Wug2JcIxLGOSrC
	GthbY1w9ewzmeVYCvYiteP7Rr7SrAqRX1vfawjtyz1my6mHHwOgDhQygE2AIqwzY2tkWKMSI8fi
	Oj7IXy7uIduYAOGX58ySjhJzYckZtsKbuI5vyYif59Ik2Csax+66NUU1DZM3OjDwmEWeJILKbgl
	mYYMNiSBjmDtAZfBg9gmMe89GvTQ6EDHyL9zjcq/PwK5sQaytMue4D5ALznzpqKPqwFSltMbimd
	dUqH5Q/u1juNi+aUd89huopzFNxHxA4Y6w6Tms29jxYArw0NGbCdixSTIR+OV8iMs7bWfI6eYe5
	bfuH/eYaLsSHq2HviSceLBBfir7k+eY9UPrwRH36dx0BcxMY3jWKmN/3/ZptUd0YjddbB3RbvxA
	c5MTf7Z6Aju4r2t5WnLtoG26te1d59BBm6bk4Oz1TYWzcs+sgQCYck+gU0
X-Received: by 2002:a05:600c:4e8d:b0:495:54e9:c080 with SMTP id 5b1f17b1804b1-49554e9c2bbmr1534275e9.31.1784366548055;
        Sat, 18 Jul 2026 02:22:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2f210csm123558365e9.15.2026.07.18.02.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 02:22:27 -0700 (PDT)
Message-ID: <82527cd3-b3b3-4cc6-80c6-b5833b262c83@gmail.com>
Date: Sat, 18 Jul 2026 10:22:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <akSuP-IWiH2wPd6S@monoceros> <als4huLvpnHsl_Mi@monoceros>
Content-Language: en-US
In-Reply-To: <als4huLvpnHsl_Mi@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe

On 18/07/2026 09:37, Uwe Kleine-König wrote:
> 
> While it works fine in my test case, it doesn't in my real-life
> workflow.
> 
> I have a big branch of changes that I maintain on top of next/master, on
> todays rebase I experience:
> 
> 	uwe@monoceros:~/gsrc/linux-2nd$ git rebase --onto=next-20260717 next-20260716 -r -i device_id^{}
> 	... handling commits that get empty using `git rebase --skip` ...
> 
> 	uwe@monoceros:~/gsrc/linux-2nd$ git range-diff next-20260716..device_id next-20260717..
> 	...
> 	 24:  901ca5f67bc5 !  24:  9f3e8813f6b4 mtd: nand-omap2: Move omap_nand_ids[] to raw nand driver
> 	    @@ Commit message
> 	      ## Notes ##
> 		 Forwarded: id:901ca5f67bc57219a9222115fabe1a1729b87e25.1784229863.git.ukleinek@kernel.org
> 
> 	    +    Forwarded: id:20260716123646.1933293-2-u.kleine-koenig@baylibre.com
> 	    +
> 	      ## drivers/memory/omap-gpmc.c ##
> 	     @@ drivers/memory/omap-gpmc.c: static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
> 			of_property_read_bool(np, "gpmc,time-para-granularity");
> 	 25:  69be5d4f9f13 <   -:  ------------ drm/radeon: Only define radeon_acpi_vfct_match when actually used
> 	...
> 
> with:
> 
> 	uwe@monoceros:~/gsrc/linux-2nd$ git notes show 69be5d4f9f13
> 	Forwarded: id:20260716123646.1933293-2-u.kleine-koenig@baylibre.com
> 
> When I rebase without -i, the rebase happens without hitting empty
> commits that I have to manually skip and then the notes for 69be5d4f9f13
> doesn't make it into the neighbour commit after rebase.
> 
> So it seems there is still something fishy with interactive rebase.

For historic reasons "-i" implies "--empty=ask", without "-i" the 
default "--empty=drop" (the UI is a mess). This patch series only stops 
commits that are dropped by "--empty=drop" from being recorded as 
rewritten, so it will only have an effect with "-i" if you add 
"--empty=drop". I'm still thinking about how to handle commits that are 
dropped by the user, for example when when they run "git rebase --skip" 
after a conflict, or they run "git rebase --continue" without committing 
after a commit that becomes empty with "--empty=ask". As an aside I 
really wish "--empty=ask" kept the empty commit on "git rebase 
--continue" and dropped it on "git rebase --skip" but the current 
behavior dates from the early days of git.

Thanks

Phillip
