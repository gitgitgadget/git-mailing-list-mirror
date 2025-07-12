Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551F1FFC59
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752313690; cv=none; b=gTRUtJ4Lc33gTGkIBkrxuxXqf9pRdbeoahtC8PlvViN8GfhCwimPsR6b1OiIH4KJoBWKeC5YlkYeIz8O9Olq90lJnDvOSSUtnn0Z6tr5O2d6k7tNhHVLkD7ocHFsHBmOmZ6p9IM8XOfa8qNodA1etsAoVWTHqxcJWVvhU32v2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752313690; c=relaxed/simple;
	bh=l7/gL1MwNcrxWDwPesOsPM6npFiuQqNvRhHiss5Qks0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tNdvWCVKdgR8LCeqVYBUvf3YfDlgy3PIOJI9io/lizUbITX88kFBuwVJGgYZb8xVdqF1Asz5Dwi+I3hVwIaLeM6uZ3qAfnVJX6SRlgHnnpmGuX22eV/wqcnQ5qGaAthUgRuVwfi74CPyHG34AxcuQZrUc0IPakrjQBDu7nwF7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpk7fm3B; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpk7fm3B"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-748e378ba4fso3491376b3a.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752313688; x=1752918488; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZxo9UJiruEIqHGu435GEwVPovLwzt+uXXhuT6hg/uc=;
        b=Bpk7fm3BI4wwelCifG+QtxqJhENw7Yki1wkm1aNIQ9hPgVN5Pe9ZuwTrZX8SAtnrgU
         Rq6A+SOf0J1kIae9UEI/TANDdk1eRQtw3IRfqmBANqVxLlfZBchqWT0q3M73ciWp2JPf
         AkxLMoNrXOkdG1bwDUEnd+ZTu+6vMgzAJzpjnSz3VrCaBQptqF3vvurcjycqK1nhaeet
         vUejfPlylUmrW+5TsGcT3dP956vD6MmHyGH6pv8psLD4+tX/+HI5eObSoZI0Dex7Wnqv
         BjaBIcpoujAlBZUZ3soXebn62o7ovBwVikmaltPjeIM11Jp4GAXSuj9YYNIlhz9OE+Kw
         Jy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752313688; x=1752918488;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZxo9UJiruEIqHGu435GEwVPovLwzt+uXXhuT6hg/uc=;
        b=KVUr2cBuMJpIfz/ms8iVT3YU1WriNmZTyChstWAfBYFGA6GmOcLanAfrcMXKPxF9lj
         fH0kouERgnukZmEfyLKLcLMHHx1uuBchYxpzI+w81/zqZLQYuCC6spOY9Urxug0jUz+j
         wyvRpAPUnHmsu546WMPOmB5fUIjYonU7xJ/oBpqG0ixEdJyz66fjK2WTP8/TcjZLB7l5
         xYS1dEI6196MXPSMP0lKNzq4PhDLOu8tK5pgor9seCWXboAvUFxUMXqRVdzeGuWKBiNS
         8O6sal6OvZjQqR0XX98wK7SYYV4bhyGZB2GVmDIbZuNXxB/xTIlBM4C507lBJtYoD2QH
         B/cA==
X-Gm-Message-State: AOJu0Yz56b8OWKyAb48cfZf8fxYlZCi8wiEPQ23Wi98rc5OLUG3Yzzzd
	as1sVVFQJ9HdxaQMXA6mCn3UQtRZpT5rHoYKG4aZevCYkwifkE3ApxZX
X-Gm-Gg: ASbGnctw8ht4qsnNeAR8+QK44SKRPkDjs8LsLpO+e9LlmEGwE2YecV84fxpqjKPtF7V
	9dEBXIKsDErBYgZelLavMyHvgE+0d1G6fEhdQBuGTaZhQZoCWs7F0XADgtkcC+Hd3npojNIn6J0
	AaHuT4BxV3hh4qmsGMw4SH04/8Np0T1TOi5fu2IazklcNCAfmkCEVeyLiJy+CHFIb/RXtOm6i5Q
	9IKGOM92aFVa57YX9JwODx5C9WOjuQLdj6CMh/Ih0Xiink0yDi6uKjv3aNvmiE3MsBdCkJYF2/T
	AitmLLdJ3PRGb9IEI1hbph89GGj0sOOmYKOEM3VQBCKmz3+m1bhwInMbzaU3r1itMFAuK3ODSDO
	GM4roGYrpFyMavZmwo9BIJsxR4DvoCfRSy7SeGOwSMQMRtIKN6L2NePL+37NkkpSOyARZdzlKVj
	V19yThSWScHYMxi7aTnhrTOKzj
X-Google-Smtp-Source: AGHT+IETxbVkU0araotTB+0VCqAMfsuyE1C8i6qQwm+wv8ugTlXuE5U0aDT/rhv+srUlebCQSDf06A==
X-Received: by 2002:a05:6a00:1385:b0:746:227c:a808 with SMTP id d2e1a72fcca58-74ee3df47ffmr10614040b3a.24.1752313687936;
        Sat, 12 Jul 2025 02:48:07 -0700 (PDT)
Received: from smtpclient.apple (n058152022104.netvigator.com. [58.152.22.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm7003419b3a.72.2025.07.12.02.48.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2025 02:48:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 5/5] To enable optimize multiple pathspec items in
 revision traversal, return 0 if all pathspec item is literal in
 forbid_bloom_filters(). Add for loops to initialize and check each pathspec
 item's bloom_keyvec when optimization is possible.
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20250712093517.17907-6-yldhome2d2@gmail.com>
Date: Sat, 12 Jul 2025 17:47:53 +0800
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 stolee@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <A25E64EE-CABB-498D-8B34-27588B349FAC@gmail.com>
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
 <20250712093517.17907-6-yldhome2d2@gmail.com>
To: Lidong Yan <yldhome2d2@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Lidong Yan <yldhome2d2@gmail.com> writes:
> 
> Add new test cases in t/t4216-log-bloom.sh to ensure
> - consistent results between the optimization for multiple pathspec
>   items using bloom filter and the case without bloom filter
>   optimization.
> - does not use bloom filter if any pathspec item is not literal.
> 
> With these optimizations, we get some improvements for multi-pathspec runs
> of 'git log'. First, in the Git repository we see these modest results:

Sorry, seems like I wrote bad commit message, I will resend patch 5/5 soon.

