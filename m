Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C639A04D
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120499; cv=none; b=XGTTKR2ioudtYypxof/WqYYD48jsLV41La8mgXVq2dQpWdH9GBN+ZLFgdX+RJgEGfDhRZeAV1Ct4AtNGjKVlAdZmwewgZJISzGNV2c7CeKgcOH7iOJko1LSC7C9XaxwxxGdm1hzArRyHTzUDcekxLOqhzM91fElDpGgFHdkJQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120499; c=relaxed/simple;
	bh=pAFDeEcpGRx/X0Z/2oy7UBMLuT3gDwuEjx+D6F5todo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K6r0StPwh6cW2QTxiKBVKUcK/cGw6PPMp+ZX8ZcpoQiz9bkdBnigrjDl5UmDeSznmLEHhUe+hpEQTL2CMX0SGmhiRwu7x4FvCFcc03bYd22Pa/lg5flvkSqzFclG6ibSnJb3JBge84CXc7UzQHU/+B5zd7XsEzD6ULJ3jhhk6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nz2Sc9rp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nz2Sc9rp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso2905923f8f.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782120497; x=1782725297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRLHPg7lF/m0Qyb60M5B0Xt3gmfx+q8NpF7C4zasylA=;
        b=nz2Sc9rpP1KsyqvH6aE8D0gW0Wl74lttGoR8JffmHKq8gs7iMfiigROLJ8eldwZBME
         LaQD3i0RkGkLqQJDkfRJFALL11a1DGoMf9lFb6GLnmgRuZLVEQRnmnifnMx6v15Ukiiq
         rbNC1p1MlplB4LVjcljPP1EfJs1hwH2OhqK6f+vKmE2H/74XfX0mKBqdCgkdmyh1ZMAx
         7jbcSnK8s2QMqQ80xul0Z4sQR6aoRqaiqaApBUh/U9Qx3thbvMjUPpMo0wYXvvs5Q13T
         iOXGZMlxqcPoLBcwlaK7mhSx+hjep5ZcsMyvwYtKdY32kO0UEQb4SNGfeHPzX5Hr8479
         OM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782120497; x=1782725297;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRLHPg7lF/m0Qyb60M5B0Xt3gmfx+q8NpF7C4zasylA=;
        b=VFutVhPKSxxoPIf6ezkKBAhi1UP/uV8Oz3KWBKanftoMWOHBELtti3Jg4EjutEh9aG
         jyGAreDpR9il1qg1kf8MptwRV0rDyq0UNz9Hj1IKTyqvl4gU6ZWa1CpX8Xou0Nuta3j0
         yBqSZGkz3I9kUxW1PEdtU2iKHz6TJkqx8UVnKqL5J5tvNXev0MVHqv5SuY9P1pbwxAUm
         17/8pBNJMibe1Oxnlymof2k0udcN1Whoufo5nmrD74TfW0L+c7rnZrR+lAIowvDPRFFu
         SKGgBD2pe3ioWCu9rEUfcpeJgiPUMKGaS80q6dKA8diq9KNMoZ3CWP9AUfsy5kx8NxYO
         /Iqw==
X-Forwarded-Encrypted: i=1; AHgh+RoWz6FQv2CqCmzpgxKlQbyEVWWGjP2/ftSngW/1YI5mUpLxrvwlLZf8USRbMMH9NOiedJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjKxwk13vnp7jcv0P8oaA8LC4Sp/v8LHXHESJeVDBSQvCg4zm
	9IoJxmgupNWO7TTzGJqNnCVxqRAw5mYJx1gIsKduZtr7Hokahfzxvw0c
X-Gm-Gg: AfdE7cmoMszsqx1hyV9yrqpYLtpyH+Bh77qch+61kA6zPk1w+qgLSuMCsjiWELJGmhQ
	9oC22r010nKi9LEcPY1dOnq9u2GeHsEwHLsQwvAwa1GwDPTkfWWBlokCaEvq57ZCNuwUDsk9Knw
	yvbPHoFPSw9wrvDb1RmRF5NNlodRYEBe1NVuoCsIw2qhvKevI6d3ZsDBsGCE1BI7geE5fEMLrMK
	KrO/wv7+p0PImBS9uI+VS2yWubEF38HQGSQJhpQob88BB5gooqm0Vihu0wPgPFeY+NcVNFQWvAA
	TFshLcq5CbQWf3MobMgQ5Nzbx/z51+6DNAbY9pUnTQuN3lwSI2FJ7EmIxLkyiKNnGLvTZMsqXzX
	m7FEFoZ7KMfzq3C1MI7iMaPIpJ6z7LT2UY/FPjtCqF9grBmO1QM2FcAii5W0C2smnUBwjmuwC/p
	BVLRLDwFdryzTvpy9l47+D82NNE8oOJ1+OGoLmXatCr5DJqbRK7TsNGDJveIRMELEJ8Can8gRpK
	JxI+x/i
X-Received: by 2002:adf:e010:0:10b0:468:e22c:3f1d with SMTP id ffacd0b85a97d-468e22c7d10mr4422264f8f.17.1782120496721;
        Mon, 22 Jun 2026 02:28:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667881bfsm26074993f8f.22.2026.06.22.02.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 02:28:16 -0700 (PDT)
Message-ID: <a3bd3514-dab4-49b6-a210-bc7b8ddd701d@gmail.com>
Date: Mon, 22 Jun 2026 10:28:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
From: Phillip Wood <phillip.wood123@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
 <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g>
 <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
 <CAHwyqnVce7NKft9AEyCUnR=S_y1ygiXjhf-qmJqmi-tuUXcw=g@mail.gmail.com>
 <31172867-5577-4c1e-b8b6-425ef9fe44e1@gmail.com>
Content-Language: en-US
In-Reply-To: <31172867-5577-4c1e-b8b6-425ef9fe44e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/06/2026 10:09, Phillip Wood wrote:
> Hi Harald
> 
> On 21/06/2026 19:46, Harald Nordgren wrote:
>> Looking into this more and attempting to implement the logic for
>> re-assigning the upstream, it becomes quite a lot of code.

Having re-read you previous message I'm coming round to the idea of 
clearing the upstream of branches that have been merged but cannot be 
deleted because they are the upstream of an unmerged branch. Is that 
easier than reassigning the upstream?

Thanks

Phillip

>> Maybe an easier way forward now is to avoid deleting these cases. We
>> can always add the re-assigning logic later on without breaking
>> backward compatibility.
> 
> Not deleting the branch is certainly safest and should be fairly easy to 
> implement. Adding an option to reassign the upstream later sounds fine 
> to me.
> 
> Thanks
> 
> Phillip
> 

