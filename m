Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D9224DA
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313904; cv=none; b=qJS0CbWlVCoE0chiIIBEys4pRfyujc3CgTBJbXzkSAsicQcwvnRNK/LfBWE8R2lYLpsErSrvjoOTq9URumHTA5TJ1zYib6QnfLRo3DkWooEUgrLjW6I/dqQvyljjiW3Ph4vEHBQKrWLFvk4mjnYri55CY43R8YEMzrDgpQCZfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313904; c=relaxed/simple;
	bh=xraZ7ZpH8sTpsFldr6T4d8ia0VWc0vXgjlqLugp/Zgc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N3r/VWMSVY8q8Ox3d8DAqEwXz0mln4sCTHehiQeKn7BBTqKYkfQHcpv1VpCqd01h+j/YPvM/oQN/0WWjfA9guBqO1lzlJbwr1V9ftw7heZiiux9n1FlmmvJmoLlDIsKp/xz3eQnTApLtlYBzImdT3ljTO1W/IQQIAvYl5wpkakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ/mV2eV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ/mV2eV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41001c6e19aso3843155e9.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 05:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707313901; x=1707918701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCS4f0BlNCM2r9X5FlzCnxTmsSDLajqOQabNIIbQde8=;
        b=iJ/mV2eV3XkM9K3K+6clrfC0+teAWR2cPx9R2uMWhkvgSauC/eD+8rwU8MZZvGvgRU
         D43e5Z9NRwifbDIFUsleQP4gsJl73go7Cro14k4hBtN6DSuBGqyRFo1j1nTwa5pxCkgZ
         9x+mNNzAbBQYJzddqIIyVIb/jQNwEz4y/+wiw0KvriImLtJqrsbuodA4N8p25X3nT341
         KT9j/dtmeiOCHoqbe++m48wwuzKqljHNpmVrd35gjzuYQiImQhsx9qF65jcB2DnDpoJD
         Q88w2JU6SnNgrti2K0yoqZeWa0vSNDcoZTCr5QGPpln6qj9uYbA4T7uxd3PSOvN2xpEt
         TF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707313901; x=1707918701;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCS4f0BlNCM2r9X5FlzCnxTmsSDLajqOQabNIIbQde8=;
        b=CRW4XiHHqvkO2lL0a+xo0jnUQ2FP0Ko2y15gSnGCefNEMBR8CVzIIcZCtUFGgt2f3i
         CegMwwd7lZRjBoGQHF5DeBM2PZ5yaCe6z8Lxdokz+QvDtIgLC40T1f9WHRMTBRI2o2hT
         JGQMYzxEAIH1mpNx6fCVhlCFTuK6PKJqXry7wMvdJLyt7m2j9oqmmqQKYY5Z2Ri0wraS
         9M0FH3++Dm0OAIIY0csoBKpOjMSC31FSICcIVuTUgsgWVd/gdyQ9/tWprBeVFhmj86pL
         0HfYtNu2W3rvOYMHuxkEWaDRo9YKB6+RIFYEA0OEfsxnGDQoNOv+94jhYFihvCmfVFQ0
         u4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCURDwBUpf26QdnjqDQl5jBsVgYMqSc0glhAKFjk1ZBvqrRS9/07iE+6gUlBKdHfDZiGf68bMzJTzraHCVnNzFCB9qpS
X-Gm-Message-State: AOJu0YwAglYhmYjY3RTi4v5c6j+y20evxCuII+u/NtXMLvfEa7xc7k7F
	3ivwWBJ6W5KHjVWz5g35Z+POsGxb6KLrvUzJGlJlNI5GqtfG6YeT
X-Google-Smtp-Source: AGHT+IH8Vs+LkJ2EfwDP/FSa1HhzqKOFXAZaKskaRZflWwg10e8vkWrq25FonEN87bFowB30MjUe9w==
X-Received: by 2002:a05:600c:4fc6:b0:40f:bbdb:4f2b with SMTP id o6-20020a05600c4fc600b0040fbbdb4f2bmr8777993wmq.19.1707313900895;
        Wed, 07 Feb 2024 05:51:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3g/9kzXzmlF5h/VhiiEZF3ijeEtmZKgH0SBdwyQZ1gBK5Zagra3YZABpyn24pAPGpa1dcS0V/O8CfZFjGaGJqv1KnJJJPnwNF8eGjFVw=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id n5-20020a05600c4f8500b0040fdc645beesm5452634wmq.20.2024.02.07.05.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 05:51:40 -0800 (PST)
Message-ID: <df1fc65f-8716-47bb-b379-1e1f1eeece8b@gmail.com>
Date: Wed, 7 Feb 2024 13:51:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/3] add -p tests: remove Perl prerequisite
From: Phillip Wood <phillip.wood123@gmail.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
 <20240206225122.1095766-7-shyamthakkar001@gmail.com>
 <8baa44ef-4960-4f0d-8cab-38d3d6ff971a@gmail.com>
Content-Language: en-US
In-Reply-To: <8baa44ef-4960-4f0d-8cab-38d3d6ff971a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 10:50, Phillip Wood wrote:
> Hi Ghanshyam
> 
> On 06/02/2024 22:50, Ghanshyam Thakkar wrote:
>  > The Perl version of the add -i/-p commands has been removed since
>  > 20b813d (add: remove "add.interactive.useBuiltin" & Perl "git
>  > add--interactive", 2023-02-07)
>  >
>  > Therefore, Perl prerequisite in t2071-restore-patch and
>  > t7105-reset-patch is not necessary.
> 
> Thanks for adding this patch. If you do re-roll I've just noticed that 
> one of the tests in t7106-reset-unborn-branch.sh and another in 
> t2024-checkout-dwim.sh still have PERL prerequisites as well. I don't 
> think it is worth re-rolling just for that as we can clean them up 
> separately if needed.

I didn't cast my net wide enough when I was grepping earlier, 
t7514-commit-patch.sh and t3904-stash-patch.sh also have unnecessary 
PERL prerequisites

Best Wishes

Phillip

