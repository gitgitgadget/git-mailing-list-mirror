Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF833556A
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982759; cv=none; b=IdjlDXZ3ezLzuQcANUkpbtzQ1n4qUUzrzB8B4m/9hnHoiVIzqptLp3gS1q0QCQHs+fxtPYsMgaDsqj7RPgmStnhmvmjXTCMkFNGl8B4D9ZRpi51LvCHLk9fFPNJJehLV17EYzLynXxntwL8qA2RdowtFtJzt2aP6ziHi9DhCOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982759; c=relaxed/simple;
	bh=QcU+czZqid9DyS8PjvQjT8/pbWgk8NLDxuWsqPnf0Bw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m8q8DWJxoVGHCSShA0/M+hTutz5b5bP6itQC9QoKGvY2eMMWI7H84iKalIS7XKXrX4K/Ytx7GMLIH/Ui3hM4iz/0lpXwvMF+hujicfbUGToHOEtHuApDucSPPCb5A1aRynVoHaVZrFN5KtloxBz9vXcEx4SLQoEKG8aWJnFa/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuCYQp53; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuCYQp53"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2118704f8f.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765982756; x=1766587556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72ojwG5b8eOEY3OZfO1ZxP2H0o35RG8QYlpptHdgHI8=;
        b=XuCYQp53l0Hzy72cV7SZE8mSzwSETGWKcjxPANJbN2jJVkHdofKFIAFguuG5eJGWyD
         hsiO95Xk8xCbzUJVUmgypa80VueYc6+XmQtzvM0c05owBJiD3Mqw0hh2cvJ+PL+W0kD0
         GkTNQ2SE+n+46MqPuYniQbdZ/9n5qr+R6Pf21iT1Dz0PyaxPUcaPenK9ve+TIPSbzjzN
         TRAal3QQYGAyyMp+zSvEsWrbMsfea8FD+bEspC/f0fRu3ik8LZZrCRv4tXviKCgBDfGC
         bZIryPAgfe1d8+XLX6YaGJTbIKpCtU5KhI8MzW7j4qlVuu4BOAbvKZkIQse5t90fh7N7
         1zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765982756; x=1766587556;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72ojwG5b8eOEY3OZfO1ZxP2H0o35RG8QYlpptHdgHI8=;
        b=pMPLjjd+fm+VG/GoQwMEWk5fp13VUiAa941II58r9oYGDdsTpio5StV1JAJE/f3OWS
         UAvw5UM6bUYvR3caDoYhFmiTZKp4xL47lqWrv0aXHA/00z+d3ZCjIYC0Ss1L9QCzX5Fy
         w0I+pqsdq0SNNuwIZzD7HQqXmxHg4ijHUsQeNRdC1alYpr6YgXg5Y947Fvpsy1SBRw6O
         xm2HaOSeH17sFIQLsmmrqbxZTU2PJRbcqlxwKnuvVKRSVRv9hv8HTMZarlkNeYmZgYTq
         Ek5tB2eYEKdVQhP+B1r954p2F5dtH6dg44fe+wJDiazJAAMQG6/6+nJ+JkWe1x38xHg8
         dLDg==
X-Gm-Message-State: AOJu0YwW4ouDQb6mJXNDVWg5a9wot0kAKeuGVEo1uyqlvtS0i7prZKWn
	0ikB/NIpZslpssdbKnZBtXxme5n50+WxrqSn3UL34XOiVvlYvV30sCM+
X-Gm-Gg: AY/fxX7ORMxOTsFwnBcHpcEJeFr71ygS930Q60yDrDOfvpWT5jfb0bVBfAvFOS7M8n5
	zFe1L2sP8cZhlVeVpWRVDes1pkQSNyXOCwG4+WcHspe/M8+2/0jjlVfvt/bg97mHgGVe/7krbkR
	AQr8jO5+OpC6cpEcG76QUKlMOZibBBHhuRwGcqwf3VCeU/WzXQPq2DzY4Wh1oO/PA0qHanaBVMp
	C8SMBdWZam4a8NsAJ1msq6kd/JJ/p3mXwnL4ExsNSUvrZoGFbHR6n4QJZMKHuo7nzQludFfeLqb
	CIzepDchLiwcPlwBz6eKMg/Vce4MK/FCck2xaxw3UCXi4bJ7LrBMuXXnhtH93mpFvP6JIPdZC82
	7/DQ9G4roNjFjPLIXAvP2TCarqVec/arv85+QcBhf4Ig8h1ozXM76mgt5RLzcLeNNisN0ZLo+ER
	67BObfrPuPSxpZ9S0KvkNNs6qnLWoVJ4i2MHGLrBvu5OJLVVSdSXBg5uf0udk8EL/5OA==
X-Google-Smtp-Source: AGHT+IEd9cRAP71yubJc5ikRZn+hbo6rQ7xGP53V/6AbDduWRBf03Qhkwpc7EAa30ZvijXUc3eq4SA==
X-Received: by 2002:a05:6000:2012:b0:430:ff81:2947 with SMTP id ffacd0b85a97d-430ff812fa6mr11029164f8f.40.1765982755585;
        Wed, 17 Dec 2025 06:45:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee5dsm5324298f8f.30.2025.12.17.06.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 06:45:55 -0800 (PST)
Message-ID: <d54c50ef-9d6c-498c-aca3-ed4461733190@gmail.com>
Date: Wed, 17 Dec 2025 14:45:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] replay: drop commits that become empty
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
 <9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
 <xmqqpl8f719x.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpl8f719x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2025 23:50, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index cf3aacf3551..9d4b0dd1a77 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -25,6 +25,8 @@ test_expect_success 'setup' '
>>   	git switch -c topic3 &&
>>   	test_commit G &&
>>   	test_commit H &&
>> +	git switch -c empty &&
>> +	git commit --allow-empty --only -m empty &&
> 
> The use of "--only" here is a bit curious.  As there is no change
> between the index and the commit our "empty" branch points at,
> wouldn't it be unnecessary?  The option, together with --allow-empty,
> would only matter if you did
> 
> 	git switch -c empty &&
> 	modify blah &&
> 	git add blah &&
> 	git commit --allow-empty --only -m empty
> 
> because without --only, the changes to blah will be taken.

I've got into the habit of always adding "--only" when I want to create 
an empty commit in case there are staged changes. I don't really like 
"--allow-empty" as I've never wanted to create commit that might or 
might not be empty - either I want to create an empty commit in which 
case I don't want to commit any staged changes, or I want the commit to 
fail if there are no staged changes). I can remove it if you want.

Thanks

Phillip

