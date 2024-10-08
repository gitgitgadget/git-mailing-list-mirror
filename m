Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C785F9E8
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419838; cv=none; b=f1cBFlVorqJHLmXBA+NPmsI7PHBOGSFT1Vw1V0sESVDgaQheDYQQ2V/PNJXmkizB8SkoPdcLWlN6jylQLIa4FKHymYBS2JRMKshrPbUZmDXUywrdalvJOhfccD1/6dtnYOfJjTyn0fDJquWFQ8A/caumSAz9dchbiGsyOPim2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419838; c=relaxed/simple;
	bh=24N9hDEyD+AFSHGECrywLhDHn7P8b+IUUKof/JHTRQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6p2MbrmVge6MLOhrlLjyXv6gahc/fI5dz3yAml9l1r/Fj8d5IRAG/cn3q4qaS8udkaVBtyyb9prfwLNZD5gW3wWoc8wZMQl+uMAYJ8ms4Ys7OHx8vPgy2vZLWKSEyJSxBSLmOei+o0+CkF3vYt/k2itDBTM6/NdT4EHcNUQ2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7aRFp5T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7aRFp5T"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so81763635e9.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728419835; x=1729024635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=up+1BFEQTZQeWMrktmPADcDciLpQwdSs9tv6n9iNcOA=;
        b=U7aRFp5TWe8lKyjEyJzgpZoBEYQ8ZkUtkOamzorqUzKdL8s2GGowhiPQz4l8aDnXZU
         FIl6VGUif8TeJkKaZ39jDWp+zYirpqs+A7i9CFZzLPgsDrwRkwMgZpPlZFLRz5xsR9Ye
         PWNg4iLS9XjkbQpZ6ttCj5QOgJ+87I7E9Vjl5iZc1Trg2at+urEouJ1QM4+GVl3L0Wes
         gp61AAga5MX0kgghVRiYkQeYuZ5mHMtxKx+LLn6nNorTmHFuxMrB7ArweDKiFB875tTu
         7LVOiavwc00lYRpfVwMZTDEArRUrxNkmfIFAtwdyoVjrDvOBBEJ4U2Hhh4YNZGXBeTH/
         ktrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728419835; x=1729024635;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up+1BFEQTZQeWMrktmPADcDciLpQwdSs9tv6n9iNcOA=;
        b=fP9lcZGtKwxUdw3OJs9oWZ1oS7wX4IHz8Z0c6CyJUNynGNWE23LrRg/yJC7QJbvRlE
         xekDD4TyxIlLAIrv1nIkSr0kcdae5zdcQhCIYIx5rwS1YrP/mxq1KNLr02PE0yU0lNKw
         fIMOwtZWaE8K/fQcBDQ/brEFyiDxiuT/V5mlguhdAf3MRXX3d9hEA5STWRhoUK/8j7IB
         19bIQLczFEAkqa3LhmLYGODs3Mt8BwVrValRcCUdf9O9Kk9qix+lDa6rPDbNGJ64akAp
         M3judjVcTKRCPimjdT8AMQXSvj+f1fS5+k1esYAstOSyKD4TXu+qZwrQ9fw5dWC7s5CC
         M/iQ==
X-Gm-Message-State: AOJu0Yzzq3xcstI/2nFZbytVhDQ5hRzkWmo9JmGArPNrOBtOoeAku/Kd
	VH1VRpNUrl/RoqCUf6grf7nB05DpdAo4uX7Dm+8+6tb61K5RC7Di
X-Google-Smtp-Source: AGHT+IEzElWi6/Y9zoIhH4DJjDCLefd/Hjpah8nX1l27hbO7PsKKSiJ5nWYEb/BywEdPYdwDHuDVQw==
X-Received: by 2002:a05:600c:5494:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-42f85aef6e2mr185269695e9.29.1728419835391;
        Tue, 08 Oct 2024 13:37:15 -0700 (PDT)
Received: from gmail.com (178.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf31b35sm21215e9.3.2024.10.08.13.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 13:37:14 -0700 (PDT)
Message-ID: <b1f2b664-34ea-4d9d-9bf5-fb6632b265f5@gmail.com>
Date: Tue, 8 Oct 2024 22:37:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] object-name: don't allow @ as a branch name
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
 <20241007204447.GB603285@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20241007204447.GB603285@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Oct 07, 2024 at 04:44:47PM -0400, Jeff King wrote:

> The refname "refs/heads/HEAD" is allowed by plumbing, as we try
> to maintain backwards compatibility there. So the current prohibition is
> just within the porcelain tools: we won't allow "git branch HEAD"
> because it's an easy mistake to make, even though you could still create
> it with "git update-ref".

Ah, your comment reminded me that something similar happened recently
near me:

   $ git push origin some-ref:HEAD

It caused a small disaster, although it was quickly fixed.

The backwards compatibility you mentioned, which can also be understood
as a non-limitation in this aspect, is worth maintaining.

I haven't had time to investigate why git-push doesn't warn (or stop)
the user when attempting that, but perhaps there's a small crack we
want to fix.  Or maybe it's something we actually want to allow...
