Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B655E69
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743963351; cv=none; b=ga75mXEk1sKyd5JTXexUo6ML1fuFacJawXzRORSuMttS98bQXNHqNv4CV4KuT2qX/xF833VZrQkEgFyrv7ZeHjHFhUNocwNuTV7QXMLMaOz2AGMrjh5E1ar3uActMcpkintm1Y4D99OU/ORrsgSiUCFyf+8aBAT5xCISbRTOfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743963351; c=relaxed/simple;
	bh=xqZ/m++d3HfPfQTwwHI+GOBCAbz7zOWoDihZaBT5a94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG6PCNni0DZk5eUCCUDWPRkTvrz0TyC70lBdLuzEf+2Y27rcaNRGUGc08xoaP6nH9HlWqdpVn+iUosn2lBEfldv82xTSZSpw5j1Pb8vLSnT8Fv4Wz3HTTItVoJ+Ma//RmCeHXe6VereqjP4MYfAclTXja+4xFBjhdqcmtaKBNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEkP00Dt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEkP00Dt"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376dd56eccso3877077b3a.0
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743963349; x=1744568149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYTbcinWUZQwJ02K4eJuKkGrufUN1J8liOcq0igd2/s=;
        b=CEkP00DtS2gbuaF4mZ8qbJv30RHIb291vq66b+hzlQVCk9gtq4NvRJQowscV8NreC8
         majfF1puzD8OcS7xznrnz1ITflKcFvJEzc9ZOJSCVLlc5YxMryTa4gNB2iGbFLZsAB3S
         0EFH0dUlUopep3JpqagTIVBGFk8HS3JeYnnmHQlF4LGnxm0z7UqzRfknp/jvEatKqyar
         fcd0vljqFriA6IUIUbub2KdyFKMXwNwzqFc4vOsZKFdhLI32AbR+UBv6RkdelAiWQgN0
         9FtcHtZIgkfHGUHTNPdLWXraWUJK/nRoHRmrJ4kBv33HJkZXB/AoG1RH2Se6gXftAUB8
         qF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743963349; x=1744568149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYTbcinWUZQwJ02K4eJuKkGrufUN1J8liOcq0igd2/s=;
        b=h1+IYT9j/yBpz9tkVQtM9UOwXG71+0RTjA7gpHROP34sjqB+Ba8GkIvn1Cxx1/0AxC
         GP99O7r6j3C8L/OOHB44z1Oa6W/wTicOVigjBEcGbLZ4VIJjnphMLAkO2Og0ILE4gwN0
         7trgF0TNczR3KLhBgbG7cIG/0QVbchixXOnd+BEqZv4pGy7z52KJ9BLBnMK+R9LFaVLy
         0c83spRDx3IQuublCFMp5cr4fiEZIoCcx0tlVolRPh422RUKqwXhPwtazCDEVtlSvpCS
         xBG31yg8syRgKkAtlURyrGgH9cfGJLIcs3JpiOcU3WJj+R5eBm0FTtwBw33Ny+Cs3HTh
         Lv5A==
X-Forwarded-Encrypted: i=1; AJvYcCUEmd3RIbrh5oP3FbdJMIA0rdFv6OkfQ4r39JhGBTxLRQE3pEycEsBNX6EEI6XDOMdJg30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/6pwS94mhM+A2PZupFbO9iIJa4BYkrNU4hypDlJKz9jU7kgA
	t5kSuREn6jT1pbsVTsBzRoavxQtN7dmWR0gZcfm7XfLLPpRMYAdd
X-Gm-Gg: ASbGncvrtV2nB6GJDsKhqMVoaUBpb32MN70djGJHjXTR9KNSTxmu1BoxJOb6cKHEm71
	9xw+nFUb4CKPkmdjXywSBD39bzvAFrUusezRcHfrtd+vFhNNdc8k761M44bXRuJHa1GY8H6ojj5
	ejrhopK2/j3VKilZ9119P8ZLVNIEJEQecAoR8JSeN1fvWavgE9SHvxI94KBP93PQqmfrYEC8sWr
	KqxwCGaKzpVNhJCihc+sOahIuG9zrmck3AT36EgtqPFxh6eS+KxaHgTdQXSFse8VwHq6OxiXpaa
	TmtG6kkKHfvuTwPSEcIlVAKuSrez8vrQQUsGPNQlJ37uK8cihfBEIw==
X-Google-Smtp-Source: AGHT+IH4T/oFCVyUxSu2+MPWwM3xl4pwBp8V5q+5bsD71Y9x2ckYqBsVefbfFEO67mbSjNnu9jcxRg==
X-Received: by 2002:a05:6a20:d498:b0:1f5:7e57:501c with SMTP id adf61e73a8af0-201081835c1mr13664920637.39.1743963349220;
        Sun, 06 Apr 2025 11:15:49 -0700 (PDT)
Received: from [192.168.0.7] ([106.51.24.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc2cfa92sm6030471a12.1.2025.04.06.11.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 11:15:48 -0700 (PDT)
Message-ID: <08ace3a3-1eec-499c-a1f8-350832ed7519@gmail.com>
Date: Sun, 6 Apr 2025 23:45:27 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC] [RFC] Project Proposal: Refactoring in order to reduce
 Git's global state
To: Anthony Wang <anthonywang513@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, karthik.188@gmail.com, shejialuo@gmail.com,
 christian.couder@gmail.com, shyamthakkar001@gmail.com
References: <20250405104124.25272-1-anthonywang03@icloud.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20250405104124.25272-1-anthonywang03@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Anthony,

On 05/04/25 16:11, Anthony Wang wrote:
> 
> I'm interested in working with Git over the summer to "Refactor in Order
> to Reduce Git's Global State." My main motivation for choosing this idea
> is that improving Git's environment handling will enhance long-term
> maintainability and scalability, and allow for multiple-repository
> interactions.
> 

Thank you for your proposal! It seems you're starting a bit late in the 
cycle. Anyways, just wanted to send in a gentle reminder that the 
proposal submission deadline is April 8 18:00 UTC. So, there's very less 
time until the same. You may want to consider submitted your current 
proposal and use the option provided in the GSoC website to update the 
proposal before the due date (if necessary). This would help avoid a 
last minute rush.

Also, a feedback about your proposal. You would need to include the 
detail about the microproject you've worked on and the state of the same 
in the proposal. This helps us while reviewing the proposals.

Feel free to let me know in case you face any difficulty with submitting 
your proposal.

--
Sivaraam
