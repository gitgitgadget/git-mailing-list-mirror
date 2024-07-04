Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243ED1A0AE5
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098585; cv=none; b=GYMloNmMiui0EfGd33gvUK6qOZnOxjA4qVMgm5hCnkfF7eAsKee0nOEB5wwdQWECFNrMSkxjCc2us9j6SOXDPOTPD+z9thlKrz8/bLfEDMTrFuNMsSvzPw3Q+a7lHvJYe270EHCCn9FbGTb7NDgDCJfVGycMEtFiUYM/4tO89vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098585; c=relaxed/simple;
	bh=ibY8adP2Suxosi270ttg5fpAiDsAXpdDLPMLNSytwSA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=VZ+sn0hBlBdkKLlO/vGmObEJROB2qrTS7PEaUBjmY/UD0POhPb8iFgmIGbYgUU0ij1SiSoubJgprF9N6+v1McL63k0wuDAuRIrzj5CzkkdlCWICcKu1SQDOnJwagXajZHpTe3+Y83DgNF1TFaQnVxfteZxp0iw2j3ilTFOPmrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBw2CjTQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBw2CjTQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424acf3226fso4377825e9.1
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720098582; x=1720703382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDt0eZprWVI3MGPgS92WT4IjuKtzsbWCaeJhWvfyaNo=;
        b=JBw2CjTQCngIkxY8HRm0umDFsQ4vFHYS6RDz+GJDYd+O/tkLe3f3Ld3Lj/r+hg0uek
         HpLlwV/iXDnXcWrSx7AHZhgJdcjK9amt6LMgQZmChVc23UB/MbpNp9u4l0iv2OHS6b49
         dIowm2DEm3JNwjAJa0+qth3XT3y5aXQ0x28Fk90i8F95hpGcU1f0U12LgrmjmSHGV/8J
         cLgf3ar3xp+8U0dykNx19bIyTrFN21oQRR8DUYvVsl67kxAh0W6V7Bwmc9ldmfbXIYVF
         E8CZo5uZXY/kX9PmVXVWo8+2x/UHnj9ozCLSFXzOQaByyhljz03LZwf5/o2XU22rbEMf
         GQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098582; x=1720703382;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDt0eZprWVI3MGPgS92WT4IjuKtzsbWCaeJhWvfyaNo=;
        b=QlaW96yA6++VUtz/fWJGlq6nQaXrJHrh5dPnXP/+GCXZZNRifTJhXPyUN/Amb7xrl8
         ypeC4JWs/jiWpg97KmmY/2Xo1IIw+VZVpR8ByHEGxyjUqsKeSf9qKuV+VGUDbk6N8dZD
         2avBKSUDcA2gKrBTKnCriFcfbH8O5mFR0a0mX9W+23fq353PHNRqPEymnEWouGAi9UIg
         ne8TaVLI/5k6YPa4Lu4Mwpm3casNpm7kZ//yEBRCckthgsseU0aGT7vUPiFzy5a3ecqZ
         dCalHO6qshf6gKzw9NxGQumDtcRinQBleBUmarIXDPnw0TbFFVqLjuKypDX8N28TSnnY
         14hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcejDsBo4noj2LMmWMMFTknxfB8dm2ofC5VTgTG04HNxmaPksM/28CsnMRKMI4DTu3vH0CiD9K9vpwTmSsw95S1jeG
X-Gm-Message-State: AOJu0Yx3sutez912tq3b9jS9Gb3jDK0pQVrzp95qrc8erLyueenb/m4e
	+qy6FKNw2/uC+4myngpirdxJ4mvPJWdJKN0jSiwOhfxDh6BzvDNx
X-Google-Smtp-Source: AGHT+IFFwRzjKc/FMcdH8bYhFknGoIwoY3yBOOdyBdAtn4N7zhOgF5CiYI183b5ZWicjsjDsujGO8A==
X-Received: by 2002:a5d:6182:0:b0:367:9409:f7f7 with SMTP id ffacd0b85a97d-3679dd34158mr1181001f8f.31.1720098582176;
        Thu, 04 Jul 2024 06:09:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679dd5ea09sm1543537f8f.65.2024.07.04.06.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 06:09:41 -0700 (PDT)
Message-ID: <c2de7f4e-e5dc-4324-8238-1d06795a2107@gmail.com>
Date: Thu, 4 Jul 2024 14:09:40 +0100
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
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 Josh Steadmon <steadmon@google.com>, Git List <git@vger.kernel.org>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
 <e4da5c4d-2900-4d62-b855-7c4382a2b949@web.de>
Content-Language: en-US
In-Reply-To: <e4da5c4d-2900-4d62-b855-7c4382a2b949@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 21:55, René Scharfe wrote:
> Am 02.07.24 um 17:14 schrieb phillip.wood123@gmail.com:
>> Hi Josh and René
>>
>> On 01/07/2024 20:58, Josh Steadmon wrote:
>>> On 2024.06.29 17:47, René Scharfe wrote:
>>>
>>> I think this commit in particular shows how TEST_RUN() is more
>>> convenient than TEST(). (Although, arguably we shouldn't have allowed
>>> the setup() + callback situation to start with.)
>>
>> I think the counterargument to that is that using TEST_RUN() makes
>> the tests noisier and more error prone because each one has to be
>> wrapped in an if() statement and has more boiler plate initializing
>> and freeing the strbuf rather than getting that for free by calling
>> the test function via setup().
> 
> I guess these are two sides of the same coin.  Explicit initialization
> and cleanup is closer to what real strbuf users do, more idiomatic.
> Which helps to see what the tests are actually doing.
> 
> The wrapping if is less annoying than a wrapping function that I have
> to name and call.  The condition is just !ctx.skip_all, though, (for
> now at least) so we could do something like:
> 
>     #define TEST_START(...) if (!TEST_RUN(__VA_ARGS__)) return test_done()
> 
> ... and tests could look like that then:
> 
>     TEST_START("this and that");
>     check(this);
>     check(that);
> 
>     TEST_START("whatever");
>     check(whatever);
> 
> Perhaps a bit too much magic, though?

I think so. It's an interesting idea, but at some point someone will 
probably want to be able to run a subset of the tests in a file like 
"--run" does for the integration tests so I don't think we want to 
assume we can skip all the tests just because any particular test should 
be skipped.

Best Wishes

Phillip

> René
