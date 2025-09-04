Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709C302CA7
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992469; cv=none; b=eaDgo5slsHnPY8pocNF07hKx8HIWuq5Ydp8McDyI0TmKTWJu0xu7exS1gYORmEWWxm2p8tTeEU8NmfX9HaDFbsJQwfCIw8IP0Qpt0CNGLXhgHONjJSysMFyT1vTuP4y0cJ+xkek283NGOF/w/oj8dg2wrkc8S0MVCRgB6AsF7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992469; c=relaxed/simple;
	bh=QnnAXc+pYru1iqddtS3eOd6zPdABGr7uoOhyE4xXrh0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dDSwm359+50rpXC/JIqX1FibC0O7uqUd6EHJOhjs1W3iLveIFlvgqp/2WfraLK2hNcbH4kZMmez6WwnB2Y9nlZfcnT9BOpTZBjdFRdkiLQTK+ftdueRD03SoARo6opBt7q+hY2Axh+LA1d6jiRGK3b18X+D0gX815A/VghdWdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmcFAZ98; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmcFAZ98"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b7ebe667cso10148805e9.3
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992466; x=1757597266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDDJquX7giwL8uzpAxOztdfhy3CIsWFIIIeBTWIkgW8=;
        b=KmcFAZ98FO22+lyg68y2ekSLcBQ/v4JsvJ4D6s0dWrAijY788Win0+6gbQyDwNmvQG
         n6jG6G5YH4BhFVBhyVspaYkwXHX40DLLdSsqOi+GkzRxcYiPKRdpUm3o3IsLFyvmr6v1
         jo2+L/1oHBs85AwvEVP6P35pP5I02LtmblArhDnkmB3YQmIKxdpQf0hr+1Gn2gmZeqoL
         US8AySQDDLua8vXVAKuOZ8lY+fWxLtR2XVeZzCE1Ye4OonUBJTVgk9zcXvwyKCf0UQC4
         54pyLkIif7sMz/JzqQhABdwRXt0WdhCWJEspwg73QqnCru0l9xTw8sI75PpKiz19o3ot
         T1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992466; x=1757597266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDDJquX7giwL8uzpAxOztdfhy3CIsWFIIIeBTWIkgW8=;
        b=hotevblThSPH47Obs2wO8o9dxNaDlLe8+QUDHP8q6eKV5z5E6vXx5XI77AiaAnquKK
         Ia1AewaE7xHqGVqowOyKS5J/j3eEmbQ/ByFpDuvzA7nNFQw7z7H6CcAL3CPf8M7+o4vS
         r9zPnsWFUSTEIZQ5AIylSGgYUEfFPIP2bPYibKqxadLPIkoYP/hmm3826ywE1yjMRh8O
         WlsBBnKP/041AucEr+rsOL1Oue2u7i988nNLCvFBSkl4B0FE7JKWW+gxjLsfgT+0b2kF
         IkJzliW1rtyb+GOs0ra2pRSBWsU1eXlFnirqrnNW61X/0XIlGPT6oTyGCJ26hk+1IUVJ
         mMTg==
X-Forwarded-Encrypted: i=1; AJvYcCVGcRzx0jKZCRICqQEzK76Vz/KDWeyp8J2h0VUgNc7g0ZAY+AZz+E30jagExnoXfVhwL8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyjko07k3y7MGBzgj8EnkjjFI9pVx+yHui6c9Iy8NqTH73iDUZ
	uKdensF571Wrz4OukodjrhJ9aSoq4gG2w40ZX6OtAlz4GjndgT8S+SqStIIVng==
X-Gm-Gg: ASbGncvLsqC3lmmZfgcygSH4pueCQ5sMMMEeEaDeAPzC4DfebaI+g9okyOL9SviAsmX
	rpbcXTZQ9F+tWpApFJ4bFcmrmjqGNedZ32zChhG4/ebLb3qLuEmCmqqk1pUGvLhe8oYoELzkFCh
	MGECYR3MWLFNSjQOzWLUUZtsmR1IS+ZFC5x6YDTrvLlj1YJi105urT+YyEQLnUNDl0gnJQmdSpp
	kYsWgxHyxp4w3GBRjgFqTMghKADDyKQwq8w7v2A6eF4sUVvY1Tp5qtAGwo5JWQBPfSjc6NHs9JT
	FeQcOzfQoAI9tTl0zkwk62O28pXG7xeklySxbH2GWx5urhJGocr/n/XGBd7GW78l7Dmy23CykBm
	hfsjpFS5wexUjQw6mdFcE/okE2FD+evBglz1EAxvmbohviYN6zH5VhCEB5+e7913sHN3E2mulO2
	/G3eX0f9kfpj//x/A=
X-Google-Smtp-Source: AGHT+IFWoYQsidjleKp/54GE9/qGwSOI7M6qIeh5tdE4+ystLU+p15pWOiJiixBQn+LK1BsM+m46Ww==
X-Received: by 2002:a05:600c:1387:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-45b855261acmr164829925e9.1.1756992466073;
        Thu, 04 Sep 2025 06:27:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dedea839c1sm6115180f8f.63.2025.09.04.06.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:27:45 -0700 (PDT)
Message-ID: <fcf633f6-26bb-405a-8cfb-718333c71dcd@gmail.com>
Date: Thu, 4 Sep 2025 14:27:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im> <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
 <aLfHvl5JuttXrI0y@pks.im> <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>
 <xmqqcy87fkhm.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcy87fkhm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 19:40, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> ... like to keep the patches that switch the tests from using
>> "master" to "main".
> 
> I have no problem with that.  I am still unsure about that "reftable
> cares about the name being 'master'" thing.  If that can live with
> any 6 byte name, we may want to fix it to something different from
> 'master', for the sake of removing 'master'.  Perhaps 'banana' or
> something?

In the end I left it as "master" as the series was really about changing 
the default branch name rather than eliminating "master" from the test 
suite. There are a bunch of other tests that also use "git init -b 
master" which we may want to change in the future, though to me updating 
the documentation to stop using "master" as an example branch name would 
be a higher priority.

Thanks

Phillip

