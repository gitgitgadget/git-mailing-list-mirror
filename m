Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E91BB6BD
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933281; cv=none; b=ku5SkxMYSScRq7KhmxHtb5iht9LZcdPsB88/+zXm3QAB5yocChTam2Mus2QcURsYNClNEnDPsyqvErs84JcgId3K9LVqcznIT+HbHF/rj0HtTGXCltsbYksJb0Ru/fuxVZsR+wPRbqg24Yw7td3Erclt3J7r0A0as+81uBKhHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933281; c=relaxed/simple;
	bh=2x2RaIdt96qX5fq4lgWev5IiC2PzYm5fmOO+gQrD5Y4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=sRGQHZ3L9n71//SgI9XEYgJNfaxpLWMJMajcfyhNSZuf0k29nsGGrSPS1XDb6EMBxRjZKXV5r1Edq2nzoy7tYM9LW7gA8aZC4M6AFDZFbw1nlwfCQzRjJdez/AiQ7b7TYTL1mE5VKySKw+Bk81YF1FtfQ8FPa9qXjjSfu2m4pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpjGRCa8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpjGRCa8"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so2531084f8f.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719933278; x=1720538078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEzLVIOuluzRhuln/dG7KtE0laPpbcO6CXCU5GwGZYs=;
        b=kpjGRCa8/272R2L2+ex0EKz1lebMFN1Heqx507WrU7alPRU5YoEDt58H2VHBbDDLgw
         iPxr0X1JqcsE0AbyWq17BV4uCtt/p5E9EsVxRuQBMkoQT65WUbTxTQQLqnNTgE3JLvMD
         1+d++M/bFRpsdNJtk+97caVoLiVs8ka/zxlnyntceKtOMd+gGJri6TlWjABuAnHhTWBV
         CXToVZt3eU4VBz5M2qPnU0ORnOQ+FTh6JmUn2yiKLWV+e+kazr+/wjq9Ot+UnoNaeq6S
         5hDe3boc8+z3Q1abfksZduX3/v7xyekAHQGmQOSGKTQ95e2tt2RL7/la1BleEDI0kv15
         NOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933278; x=1720538078;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEzLVIOuluzRhuln/dG7KtE0laPpbcO6CXCU5GwGZYs=;
        b=jVOdu302v+/4ocTqNIUXcRMBFOy87aLtCTExUNJ7PqnUw95+1gjJefK5r+a+a3b74P
         Ra00Uw0XjzqUlMduAbFXUZtP8w/NjIXGD/pSeO1dbBVjoIdruJyxqhwEIyR81NpEmMFH
         hlj2jrq+CGi419mzIsXEyxqK+7+A640EagtevAe8JVB7jC8TnltVDdkYiKuXcSgb/oVs
         HA4ustzW2FhRLnDO/KgQUBKd40+MK2KJ4fznaAYguLhRxKqwba780E6BMw0Hf9ueVBRg
         LzmiTuG8C+prHSZYhUsXn7z3Sfq/YLEnb8z3kigYUQHD5RCm9xUYcdzvLxkEAavRfgzj
         5IMA==
X-Forwarded-Encrypted: i=1; AJvYcCULr7rsROhuCSkE+BAstQ0m0ZXkh1tGrMiLQStwor5YVGN3vbapXx+pEWvAXMQKZ/if84+8PgaIfPTEJE4eXOvWOt06
X-Gm-Message-State: AOJu0YxsPueYngMg0z6ohxJ15EUkM5yj05CxdVzhI1zNAt168+HkLrVa
	wqj4dlVBHevXkEAF42CoX+tKrfogJ4MbfzrCQ14mAD9vp+oHWYlH
X-Google-Smtp-Source: AGHT+IExBwMiFvYSwi47V+v8hN/eXUK60GG30lP9ajbJlvDyXAWod6SIYUmmAMGmWphH6RGfpYfuLw==
X-Received: by 2002:adf:dd8b:0:b0:364:626e:5699 with SMTP id ffacd0b85a97d-367756ad0fdmr5712971f8f.15.1719933277957;
        Tue, 02 Jul 2024 08:14:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e0661sm13349328f8f.47.2024.07.02.08.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:14:37 -0700 (PDT)
Message-ID: <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
Date: Tue, 2 Jul 2024 16:14:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
To: Josh Steadmon <steadmon@google.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
Content-Language: en-US
In-Reply-To: <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Josh and René

On 01/07/2024 20:58, Josh Steadmon wrote:
> On 2024.06.29 17:47, René Scharfe wrote:
>
> I think this commit in particular shows how TEST_RUN() is more
> convenient than TEST(). (Although, arguably we shouldn't have allowed
> the setup() + callback situation to start with.)

I think the counterargument to that is that using TEST_RUN() makes the 
tests noisier and more error prone because each one has to be wrapped in 
an if() statement and has more boiler plate initializing and freeing the 
strbuf rather than getting that for free by calling the test function 
via setup().

Having said that I don't mind the changes in this patch if that's the 
way others want to go. Getting rid of the untyped test arguments is 
definitely a benefit of this approach.

Best Wishes

Phillip


