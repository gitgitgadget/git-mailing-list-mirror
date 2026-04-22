Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E13C5DA6
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863618; cv=none; b=oXPS7bCk6rn+r+t6GD5nnEclBlKqHMI5Gd8an72cmFQByWF4nmGMXgUn0z8dt9tP+Qtr55oeSSNvNk/bRTdTyleBQGoTvwasPb/2vZJzgjJaJxZJvkfextKMybYjSNZ7JPsPgLq6YgIC4JuG3t8P1bwSOt6FiIq8vT5s+aLuE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863618; c=relaxed/simple;
	bh=5+8uzNKAIK3wwt2vOkmtZl+38sPW/wFeOIY4sYnU7RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdD35h/0jxSQSSF+Z8d48qKQy9UDJIyVWVKcu+DPj3XC1ywtW9HO4OOsQ8NVTnUFs7eiFzxVizpGrHruxkK6DDJA2elhgCUIB6L8McA0NPSFee+Y+HTwUN+LfUYokfmUNNDlQpLFqVHxxhxLjI48hcAaBtgMFuaavF2nSNgkzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buLW5KTy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buLW5KTy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so54209055e9.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863616; x=1777468416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u4mTwArM2v3jPl6Oyu/9Qm1PyhoS2nyj8QB56xkBTYA=;
        b=buLW5KTycpkmXLmwR/nJeRtYmakwQEKygQH/1ybUaYxmp7GDsG/P+RCXgUw7EKmCoY
         7i/oN5p7uToQm2feLYOIrjiia6vXuC/wkNzpderUavymIKxjrLTN61hRVnTxENNddCPX
         tGogK6uJE0E05DCwUNXy1f/HG3H1jwD7jg0bjJz+Nth/aYpLVuKVmSyNLnz6an/o4K+1
         IuifRNlOXrNuNa+YyrV+8G/a2DcfIb7SUjQQzYfz+llhWJpl67gs4ICkuXasgXA28xaM
         PZlb5h2nLdS66kVJBzFImzFpnPgIQS76wzH39NSa/QzryhcuiCbjr63NUmGi2e0EugJY
         NE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863616; x=1777468416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4mTwArM2v3jPl6Oyu/9Qm1PyhoS2nyj8QB56xkBTYA=;
        b=hNq3g9FB+sIPEP+9hqwf4vBxbuj+xa7XCaPB4+IHSVyX+3v7bYXFlCNSzyBQ8FsBiA
         ldGuESoJEeS6m2+odF9QAEj7g2QtvBsm/b7wr5JJhm5Xr3mcRv9fDi1Z3gsgotWvpDb2
         RlIInkF7Fm8Xv7y4qsvVMiVnC78Q1ERaCLAgUuHPZfpcCtO62t8SQaSh6+i6Cx9lvWkv
         zDu15gnoKZ4rpAq5wulG7wILcvvb7rVfmD45x7CZWmpjf+Tp1p1sHiJXrq5Zxjgv+D/J
         EXuBR7Y3MD6FinN4scMssnU5rF2ELHfScmiy7Ep8m/Zm93j/yVF0e/6O6TGxk5FxJpfi
         8YSg==
X-Gm-Message-State: AOJu0YxyEEk3P410/lemPzsAK/xK3ULTPEd6/Kctb1BbnGzfvDyNJdgU
	/1Ckm4ah3Jj2UwmGABJbq99W2k8US6zveqXvloWvCWH8/TGgzlB/DtOK1LAG1g==
X-Gm-Gg: AeBDiesxMR14Po0XMmH3Gd3dfJUr2CKKl16+6npuVZSsOTeXER7OyqR6fhc90/M1uFm
	hbwXZuvV55z5RANGGh5z4Do/FvKAcqs99AzoNYEulq7wcGBgZ0VYH6qgJAxVW7UTiaICkkhFACZ
	h2w76cZ3rnSj8fRZGr13sOcWap/WDYYh634onirN648jlt6uK4RFB+R3ZXettgdTWbIpSK8c0tW
	1H/mduhwUkgSTmjJN+zEYIwCHG2IUQAftbIoIJ4cK8NWlD7vNStg01dJFn+d+CejqfXdjjD/Vzs
	FRWNdOkcUrIw9nrO1/lNicQZdlwtCFnCZBfhYS/ez1TuNq00jjmLaB+v+iBbJBVnIagSs1ts7Fn
	KELNujquXRrt8FM0ccIdbRjzrEk5N9VMT1PhI6JieANsW6YnmiFXBM9Kfo4tkVMi1/JkBDrX2zF
	AR8fS9ogzQNsaiL170Tdol9DdbfeePFiVxmih8Y0kQuofSvfXT4/eEZrpIlwu1+rdLTyGepHluw
	214PtdmHmOsqw==
X-Received: by 2002:a05:600c:a416:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-488fb73b31dmr270127645e9.6.1776863615466;
        Wed, 22 Apr 2026 06:13:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm419973425e9.9.2026.04.22.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:13:34 -0700 (PDT)
Message-ID: <fe75e0a5-1a87-4515-b02b-bfbef0366aaf@gmail.com>
Date: Wed, 22 Apr 2026 14:13:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] git-credential-libsecret writes secret to stdout on store
To: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
 Lutz-Christian Quander <lcq@wateringcan.de>
Cc: git@vger.kernel.org
References: <b7b6b94c-7e42-42a5-95e5-d44a54d6da0f@wateringcan.de>
 <2d5b37b0-3442-42f8-81f4-18b48e95a617@gmail.com>
 <60cf5f7c-9ccb-4dfe-82e4-9b6e54b3c2c0@wateringcan.de>
 <0b2370ed-f3e1-4011-8a2c-8da539759881@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <0b2370ed-f3e1-4011-8a2c-8da539759881@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/04/2026 06:49, Mantas Mikulėnas wrote:
>> 2. The direct-invocation pattern shows up widely in distro docs,
>>    StackOverflow answers, and automation scripts -- empirically the
>>    "internal protocol" boundary is porous. Fixing the helper is one
>>    line; documenting the internal boundary across the ecosystem is
>>    not.
>>
>> If the preferred answer is instead "users should only use
>> `git credential approve`", that would also work for me, but it may
>> deserve a note in gitcredentials(7) to steer people away from the
>> direct pattern -- the current docs don't actively discourage it.

Yes, users should be using "git credential", not be running the helpers 
directly. That's why the helpers are installed in a directory that is 
not in $PATH. gitcredentials(7) shows how to set the config setting used 
by "git credential", as far as I can see it does not suggest that users 
should be running the helpers directly.

Thanks

Phillip

