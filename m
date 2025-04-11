Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE3278E71
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369657; cv=none; b=iCiCVfbI1m7jG22KfgLgdFx8tujccgFZPoG380glPEbqkeBixi8WqLuq53B49fYt6l4TVpjuzPfZ6tvJnP7+gl6cP7frn5dDotPAw8Mzo29VV5Byq6DniQ50+4nz21cdu9PnFEy/FrBMoCfVrFzdIBHBlAROzX9o3nZyQLWb/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369657; c=relaxed/simple;
	bh=bLE9Xg2Ghm7hblq4SNdLa0/nYbYnSCibgto5F4UZ7X8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ie+LXW3d44eoCgQyDXFG7RAXuBdx/jjjen2JxM3yR+ByjfXTFY6uuYHCTBnUzEOZj4GmDoxN41bp7D5GdlltQHznmhMBoHR4CtnP+nSxFZ2q83xwNlgFuYFBxAEb7JvKPILn52fUMVDFcqqyROl/xCaPX7mECfMeWpsJvxiOf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com; spf=pass smtp.mailfrom=odoo.com; dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b=YrDNzfeD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b="YrDNzfeD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so18615785e9.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 04:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google; t=1744369650; x=1744974450; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuDiT4k50dCGFoEB2HqlaAZXJ1rN26LVZ74+ITHS95c=;
        b=YrDNzfeDl1QcMSqS9GO2wlYzykmzrPeCnWnx5HQ0d/VE803lvrTVfBMh5Vq8TuEKgf
         iz36RGXaoAL2G248tPmXO4fQCV0is8Vqneu/ruvV/C91lynNx5kr1W/Emei1pZBN9ygu
         IqxIwvw6e6wTKBEMlwFcKN3tdLHiXB1ayF7EheX+Mmde0v8RaIFNSTDDjVr7tnlG1rkS
         KpL4ZF6LgJrJqOxzmdmZb++lP0O6OOwykHVZgDsHk9U2XVO70X6D7q8zzDdobx7sRr+G
         CbjBCl75YsNCS05O1A9pvO5N5P3zz9TsV7JUnNYoM548nfK7XDpv8CQMG+CLsSl7SSR1
         t16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369650; x=1744974450;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UuDiT4k50dCGFoEB2HqlaAZXJ1rN26LVZ74+ITHS95c=;
        b=k5E3bNf1OU61CbqnhtlXINOMioVZEZDubdSU+rCXbHI8r/5z2VnSHKvko3lVI9OH2j
         VAZmhJVpFjwCMUr754TxvWT4cVqC1IzNynmHsls1t1scxNI0ys7epwwa13f8jUDoJ42P
         DpxlTsJ09mlqMm+ff2siceaIIq12mkJSxNr3ZXus7I39P0DXKYWgJWsdVlYVO+tzoxTJ
         sPUTnh16fnb9lpZnWRPZa2xDcJqL3x7o+Bgk6fXUqwqEu7+eqhXIV5J7Hxezzjhtdlx2
         A4+FJttKYOb+309LRBXukGSBJST1LB8E3orqjlnxsLaIYV/y8TvEQaVIYwj1O9a4DthY
         nejA==
X-Gm-Message-State: AOJu0YzKPwTkR1PHA0bY/m0t6cD7Y0J9xZTMXQTPbSLS4nDPHSCVcu8I
	wDipJJEC/YkmVvfUt53QeinCYPnJdxRrQ/+ogNwC/7M8fOGY+6dFFt7cIVK+uD/yM6aMQ5GYRtj
	Y5BM=
X-Gm-Gg: ASbGncv3Qw4IOTxWx9X+KpEm4l0mtra0ygmq9nw5thgrzagUn3T26myP+eKscNlz7LV
	CuL/sZjpZ0Qu41Sz+kW671CO6WpFY6xkCAC4v09V0d2E4vmj0z7dy6AxEgspdRKzsPWAJaW8ldJ
	mzTkIOgxq1B6sKKOYq1HfvS4+QIPWM4j6vTHy7yLSJZ+p2F/+jC/cuCHUpgc/6X8i6zBCAbxK+d
	MhgAgT7MACkuUI0J5/hLbq/MS7h2q3o8A2Y9wnO7y40/0aHskgsvvDXaKAy6LJmrGwe+vdQSUlc
	5+WNtmrc0Vn4y3afDL/bNKUk35C246coeHCH68wXjhCn1xztBaLuxyiC2qB1d58ij0Og
X-Google-Smtp-Source: AGHT+IGyC96jwGcl54Ue4d/7+p7GNXgi/zZPY5ojswmDbKSskcmy4bP3fd46eSQMrxDi5KUnWHdUuA==
X-Received: by 2002:a05:600c:1988:b0:43c:e305:6d50 with SMTP id 5b1f17b1804b1-43f3a9a68e1mr18923635e9.24.1744369650066;
        Fri, 11 Apr 2025 04:07:30 -0700 (PDT)
Received: from [192.168.0.2] (ptr-178-51-192-241.dyn.orange.be. [178.51.192.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d6e8sm86943445e9.23.2025.04.11.04.07.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 04:07:29 -0700 (PDT)
Message-ID: <bdf4c917-f1b2-4c24-9b59-97d8a770d06d@odoo.com>
Date: Fri, 11 Apr 2025 13:07:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Xavier Morel <xmo@odoo.com>
Subject: git clone --bundle-uri: provide progress feedback?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've been looking at `--bundle-uri` for a repository of some size (~5 
million objects, ~10GB fresh cloned though an aggressive gc get it down 
to under 2), however from a UX perspective it seems to have a bit of an 
issue: while normally `git clone` provides pretty extensive progress 
feedback as far as I can see there is no feedback whatsoever while 
`clone` is interacting with the bundle, even explicitly setting 
`--verbose` and `--progress`, at least when the bundle is a local file.

I assume bundle-uri is mostly intended for large repositories, for which 
even a clone with a bundle uri can take a while, and the lack of any 
sort of feedback until git reaches out to the actual repository to find 
what was not in the bundle is somewhat distressing.

And side-note, it might make sense to emit a warning when trying to 
combine `--bundle-uri` with `--filter`? I assume if any filtering 
happens it happens only on the reconciliation fetch, which should be 
extremely small compared to the bundle's size. Experimentally with a 
sample size of (1) using `--filter=tree:0` with a bundle uri yields a 
larger repository *and* is slower than leaving the filter out.
