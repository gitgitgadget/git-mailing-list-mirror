Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9370824
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500633; cv=none; b=jB1ByfBg4qvgCxiGzy4ldZfjoysWg7LbUGFiVLCSQDuVC7oCS8BoXsjIMqLluefdepgLH7b908EEBlYv4WiQdCwk3NWE9V7FTmiQWFVkbdqIHf+5yzYaH/e43tZqKpNopCvc5qnm+BsYjM1oczI8IgW9pLGotHVpr9NTw231nlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500633; c=relaxed/simple;
	bh=aTf5IO+XiNCZIkWxnBPFYe84Bn7MGYrDPVvK/mmUuB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlxjCxqp2XO7Lok6t66KwyRGSFFeNmS9lup+RG3euS09gc6TmwpceXChtpbT/7xsaZZLe44QlR5vjAVEIIBENjUhdbS/gz+issYD2nNIz6HFEQCYpfndirLXXNKlu40emCbX9jgiqBRfP3MBMU2AyOmeCBMqxfrXrLx8fgRZk7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctv5/hdl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctv5/hdl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff2adbba3fso10327657b3.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742500630; x=1743105430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bh0OpTOWwctOqEiKmQmZlpQMWn1rwtK+wtUvZGOaTB0=;
        b=Ctv5/hdlAC4WZjSdp4c7gMjWrVbRHhP97dQo/4EhhisTzjjIE2f85avp55ZhqVdDdp
         5wtKnPlduQwbryzoGFpSlANDjVrGVbGqHDfvCXJaspn+HR3Ye0pIIqantUBDlJ6He/t6
         zr35+xiSlp8G2kmD5OnBaJvLyfBCQ81abnVS3nWBhRMkd9DgN42HEfoxTLk/b8xWDHF+
         heJYlL8vJTmHxUf0ARdSAW7UEjnxC6OsfbL3V/WXuvzt/DoRXkpy1GtEBYisq5D0lg9X
         FX4H7BXj6s6+H5u6xsGVZcA6fpZ7zBTajwXaVAuptHdGg1XrQMKyarFPxhVc1+gbQ5Va
         Kn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500630; x=1743105430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bh0OpTOWwctOqEiKmQmZlpQMWn1rwtK+wtUvZGOaTB0=;
        b=nExmkE/YKEfmd0PjUdSGQIT51tLRAoKtem1eFAshJ106G/dH1gpWIkNm6xeZA+uJEG
         WTi6P7AXexOeDZNLoyfIMfQC/FolhJpoLS8Es7F8KzevC/RwmH8bbuvUVQAM20mJwqJg
         0ilZf1F7eaE9cR8kfHUqFLdCdAcIBf51097i3Sg2VgYrsyOgq6NLt3xSAg/P4G1rAV+Y
         9+XVvir47mGZzZn5V+Vg8XetiX5iYdKevWdvomWymoCxhkhHreOPYk19p21v06Ft59RM
         /KC9Xq63qeOSojkjIM3QaKwhRx7h7SjXgfo2vnP9dwMuSm01X7WWKynt+IUkc8BZdGOE
         JP6Q==
X-Gm-Message-State: AOJu0YwlyH/hgIisIjq20FSRk2uBC+3HHP7TRgA4QGJjA1ZxVy/vox/F
	b3GJ9RzgmH7LDe/T595GYkU9jt1+GQNwJkt/uaG7+RZL0ABZ4GwY
X-Gm-Gg: ASbGnctVfNq5h9X1r6lenDpfgd1bA3v/wm36a3dOJ7P0gUJf0sQcIt+nMOGcFtMqgmV
	/+/UZtuIGfKaa+mJVrbsYZQhx175N0LACMvtt7//ElWaFKqCbBgfPQ5TkucP9K+XMWCFxDtlJUe
	zX/R3JA3Bab+oHRj2cfmfjXsgriCfkoXopejb5tTgTDmBqpfiU0+Fr/IS4yTYugqRY/QoKkODYS
	XXQzd+sgTkdQE3etgdKZRBiUNPku54neVdJN5XItVCZw6P1k+Iu407QCPikmqcnPsyd3osu9JHB
	qxmx6lu132euJ56C4LBl2H1wykJs6EjcZsC0aKSFhSH+rYvIzlntseX7gTaljnqLCR1WOwp3Wd6
	QUb+igzAQsuBAe10M1cT0KLT1MY55PRU=
X-Google-Smtp-Source: AGHT+IG5oA1/4cJUzwij4bv23ywr0mqLNIrLYNZStK/9vSfGqKcfKUZn/7NhNklqFPBxqPTrOPPECQ==
X-Received: by 2002:a05:690c:2501:b0:6fe:bfb9:b2f1 with SMTP id 00721157ae682-700babfd535mr10085747b3.2.1742500630119;
        Thu, 20 Mar 2025 12:57:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f12b:82ea:4a0b:3183? ([2600:1700:60ba:9810:f12b:82ea:4a0b:3183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba793580sm767127b3.66.2025.03.20.12.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:57:09 -0700 (PDT)
Message-ID: <58750d8c-fb1e-4c6d-a356-7cd0e59c621d@gmail.com>
Date: Thu, 20 Mar 2025 15:57:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] pack-objects: refactor path-walk delta phase
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <c047fbd7f275ef79695b5e1356075705e6fd7bc8.1741571455.git.gitgitgadget@gmail.com>
 <Z9H65fCcv/cybKRa@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z9H65fCcv/cybKRa@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 5:21 PM, Taylor Blau wrote:
> On Mon, Mar 10, 2025 at 01:50:52AM +0000, Derrick Stolee via GitGitGadget wrote:

>> +static void find_deltas_for_region(struct object_entry *list UNUSED,
> 
> Interesting, it looks like "list" here is UNUSED in this patch. On first
> read I figured that you were going to make use of it in later patches,
> but it looks like it remains UNUSED at the tip of my local copy of this
> series.
> 
> Is this a stray change from when you were writing this? Something else?

Actually, the intention was to make this method less focused on globals,
but it in fact uses 'to_pack.objects' when it should use 'list'. Thanks
for the careful eye here. 
>> +				   struct packing_region *region,
>> +				   unsigned int *processed)
>> +{
>> +	struct object_entry **delta_list;
>> +	uint32_t delta_list_nr = 0;
> 
> I know that we have a lot of "_nr" and "_alloc" variables in the
> pack-objects code that use uint32_t as their type, but we should prefer
> size_t for these in the future, even if it breaks the existing pattern.
Unfortunately, the fact that these are used in the find_deltas() method
as an 'unsigned *' reference, these types need to be as they are. I'm
hesitant to use 64-bit integers that will eventually cast down to 32-bit
in these instances.

Thanks,
-Stolee


