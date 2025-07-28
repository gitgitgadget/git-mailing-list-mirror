Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4631D130E
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693619; cv=none; b=Jl+dQSAuOH2gJiEvGFELFFOaahjFbmPBq0Vp1KD1R9x/GTnIom2fBxVCdFES0DQLJS9CWAbhyDRBN2n1wbi3MlE+0gc4kmJNlH+H96r7k6MFGSEg3mXiwF7CLkyjOSh/0+ZWe8V1Ja4GxWrnDVaDOjNRFoKHiqGeZL86nd0n/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693619; c=relaxed/simple;
	bh=eij0PyCIEvEjeH93hl7X2IV6+BCpPBQhVZ+V6OS7zYs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KkYVsvGl/JA0Dzhyw6kMbUeZ4z3Ixt9dNW8L7F6k/3vsMXBCCMuex4UnyuOg++pekoTvxzH7kJjwQI6jv70D40imVh1kxh4DIkMMhzDqEvy6t4EiSyiRQwVr8+PhojIUYBjTgcXoAd+oUgPA7ZL0X8zatKCDGc4ciW0eh2gbuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com; spf=pass smtp.mailfrom=embecosm.com; dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b=QYPC8jXx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embecosm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b="QYPC8jXx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so47051415e9.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google; t=1753693615; x=1754298415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :reply-to:content-language:subject:references:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNT2bIhlvNxq59OSH4zKCmF72xzdpRnJblaahLDilhQ=;
        b=QYPC8jXxlrgpLyz5nLSPEpwU3be2gHviyMvrxqVzVrKgvDca2N5NTSeDaVIE9kInXO
         0jAZF96nstwxmdOLEC1r/SWRo83NShKRmoNZQZ//uOxV6HY5EVPE4iIuQP/bP/PY+GKw
         UWT+hBycKQTavITPE7kvbYDP4CGFXzgxVhFnTMqTYIHl/g9mCm8yy9j98TyQzLO7NwGm
         1ISq38vk36R5xKdsNgqYwxFuj/MHT7M/MUouOSyBrNn3nX3BHunvQlg8x98M7U2gdmp4
         zPatWWPZ65nmNqJJeginWRFhCRYt/jdPVZIhRRTqcOt2grDMSXj64lEtf3LwDHyNjNzM
         1owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693615; x=1754298415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :reply-to:content-language:subject:references:cc:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YNT2bIhlvNxq59OSH4zKCmF72xzdpRnJblaahLDilhQ=;
        b=qxF7tJxrGw9zm3pZLjfKub/vLKBPR0XIu0kuk5SjU4dghMCRrhZllZptQVRTpeggWr
         8/PgqUbfQf/MIizRZmudpBFOGrdR+/4zazsU4jZLsqTqSI8Ygl4qnWTy0QvyEIriMMdh
         Jc7ajL4VhQjXEVPBlzn0CqxjK03bL4V2OOjEob7dfEfkJzy3sbdB0DzGSuAS69nWp3aj
         NKdQmmCb7cls8Dim1+L8iRwz4rMkSeKkd2smKCoae3ARNAf5PTooNiql6FgfrOqT/CgQ
         YY11rMALZad0YP2d9pJ5Q9JyjZ1nNe/0QOdhVq6byi8Dnrr4zS5iaenGLa7eZHXnYzm8
         H04Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZzukV5ZfPirtatkqxmI15nNYksExcRN00sFmhFEuDp35Nbv6KbYA0oIDMwfDavSoPdFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfFcMVByu/ndzN01uTBrVzGFoqb4Zj5dTKsPkytGyD523jrQ9
	3qZcopUklSGL4XhHH2gNCal6NJaTKKbT73Nh7oXoTs0c8jGgX6NmCKY+PkVzizqWWK8=
X-Gm-Gg: ASbGnct08zTDefQZs6A1cKZSBP0QaYb3/M67tZ99THdQukNYCO9Vo2Akwz+pBIA6bhg
	DYSxXVBM3GjwF8B9PGUz1ISmTEPXzwkKZ16HKJ+jFf3OqpJCzfMvOf49hD7FmzsGSZfJwi6cJyE
	v0oCuF/9azR8/v7uggclyiDU9TcNczvGGFgrGGSeTt8R3nKF0VkoYrALF/l8PhH2IuhJcBXxk6H
	a57QQg2qgHcUJ47DtLHXGx4u/tZ4WDDf6AxZBa/Z7pJZHXPoGXRoJcR7iEdJuiojRS/AapOhuA5
	rGJ3+vTq+OvfDhhb0pvSdoldo6PzWGeHxw5xXZjw/cOiGujakeS3u+XsifteMa4K1SonP6qEjSg
	LcLzmqmaGIq2vp0hEpCygapedPqj/1zXEyTwDSouvBSG5jI8EbcFG/FbW1Os4snZ8v73tDIjvf0
	hFwTypelNI5o8=
X-Google-Smtp-Source: AGHT+IEtK08YQo+E6lvU5C9sWL7X1Te3N3ayJezJbWyL6IC4Dr9gL29lNmkK9RDnYtuTXNeIJDMgfw==
X-Received: by 2002:a05:600c:45d4:b0:456:26d1:445d with SMTP id 5b1f17b1804b1-4587666b032mr81185845e9.31.1753693615094;
        Mon, 28 Jul 2025 02:06:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1f0:96b0:2863:44c4:9edc:7fe6? ([2a01:e0a:1f0:96b0:2863:44c4:9edc:7fe6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b788f5f27esm2283673f8f.14.2025.07.28.02.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:06:54 -0700 (PDT)
Message-ID: <d452bb67-569a-4772-a943-950e3edb4e16@embecosm.com>
Date: Mon, 28 Jul 2025 11:06:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ps@pks.im
Cc: eschwartz@gentoo.org, ethomson@edwardthomson.com,
 ezekielnewren@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 me@ttaylorr.com, newren@gmail.com, phillip.wood123@gmail.com,
 pierre-emmanuel.patry@embecosm.com, sam@gentoo.org,
 sandals@crustytoothpaste.net
References: <aIIETOdK4Nrsy5Jb@pks.im>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Content-Language: en-US
Reply-To: aIIETOdK4Nrsy5Jb@pks.im
From: Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>
Autocrypt: addr=pierre-emmanuel.patry@embecosm.com; keydata=
 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
Organization: Embecosm
In-Reply-To: <aIIETOdK4Nrsy5Jb@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> And I expect that 1.78 will be another significant effort that won't
> land before the year after?

Yes, even though it will be easier once the foundations are laid off, I 
wouldn't expect 1.78 before at least a year after that.

> For my own understanding: is this something that the Git project would
> have to support or something that the distributor needs to set up?

I would say it is something the distributor needs to set up. From what I 
remember rustc requires a flag with the path to the rustc_codegen_gcc 
backend. This means that has long as the distributor has the alternative 
backend and a way to inject a flag to rustc through an environment 
variable it should be mostly fine for them.

Pierre-Emmanuel
