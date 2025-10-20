Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E62EC0A0
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970363; cv=none; b=rwHkm14VjCFAKy6LTe4JSJn4MBmwO4JII4ZLHr8awSdJ/M6rO3Y6B07zXI3GZkA7yhW9+wbLkgEP0ZIaCMA67yK/8KVgUmhaX3q3SD4VM11B8KHiVIEKVB2cSQT24dIYx1d0t5W9vX0qArVG2p1y1cSGV61jSIJuTpEkwdXmlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970363; c=relaxed/simple;
	bh=7NjcB3kFl9XByxXBzaAdoCJbYFnh44ZHhH+gTLbxaVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHae+KHfjlTnAcnn2I+0OH93lPrDVjzJoQxnVR7niFRSrrIgMRCC0CZqrwF2/9qGRtqxAzkc9psiKjCJWc/NhxoLGhQ+YkMUD42YWD1H8PWoSDMq09jQL6Fk2EUEOXBswrWvArxOiTBou1OgOlrIOOUJ5gPI1Q6DJjuKqJBmR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4gltBXY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4gltBXY"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87d8fa51993so37224746d6.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760970360; x=1761575160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEm4IfjHz09cMC82ZuIiv36596fReEwa+IuMwZJ+shE=;
        b=A4gltBXY5nKSqaCzg+FtLDi3K2UJoUCO+M6571/lBvOv526ICf/Mdr1SCNz9VuRvO4
         35ugI0jQSjv7eP2IPGUAa5Hjy8Vdm9V3cMWm9WkiVunYIerh90DyAY1ZstBLpHCItzaL
         WVwgmaknPGMR/yv+e4oStgSNYCvPWyOb19+DHpaB8Kb/6HiFVG/HQz2Eqd43H86q8yQI
         d2zoCGzP/516jI2WYL60RsJOyYuu5m1I1TX2nl1UznKxDoqDdvPyPhrCMSN0VB6qLwXZ
         HFIdSUbQXYOwbQ60Q846E7UlDnrFHVpVju1udvN6GcabPjL/0rJaFy0ru33oHimDMfcg
         DR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970360; x=1761575160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEm4IfjHz09cMC82ZuIiv36596fReEwa+IuMwZJ+shE=;
        b=hz0/W32tTTLIYSq9kc5rVqHyUsRHS8sG3tCyv/a8d7doPWw1Ig2QOxeRH5Cs/mC65h
         lOVmYVG65nMhHCTKUjeKY6Na/OvAor6VIjNURZkA05wC4XAl4uGudPKaLO+O/bpXohGo
         7oRIixZRBONp2rsDoRGVFyPnOO1t82TPce+sakEU7DybFLTN5vU0PIiSqQdEfnk8MZtr
         hBTNy5H6ZImzrPqA0xFx0yQAV1t/YQ6WW8xgYdHRTrj/tHWpU9NX3T5epoJt3Hh3W2O8
         +xJfXKp67iG8zXeZIx0V1r60kbl3icn1ft/tYImkheFKEG5hKhzmioUddHPIfqMAy/cP
         l5fA==
X-Gm-Message-State: AOJu0YwQM4UiN0t9+KbZNnZpxuVFcddcKEztRScgtXQpSiYxhHG+y4L9
	53EX9rzUApUNqxzwkbGI4UUOuM8AbjbvifuLqDacnJBsGk6iaaO9WG54
X-Gm-Gg: ASbGncsVECxW2iXRNjJjS8m3D8xqBl26bkrdybYQ+h1ixXL4BAFSQlFrsVYttlF41aX
	QH4Swe/Y7Sy4RnBxt+1NxOOugXzt++wlS29pSIznyduLzxQW2fxFlrnLWZ1l0xkI30PjOkTyaa8
	vp3ojGk32T7lfP+igqc8R3oilIy7IMxhSxYQpEPNN3HxEm+nLxfWCqhgJMlR8WnzKaZcr91HkP/
	qQpHep5Fj0GaT1yL3XLfFo82keb3SQY73ua80vXez+wgnzbjck0tt7ubKkFjxxMhx6tPiufwfIw
	S3Ni2v8s855x+xonZyQ/Sgbmy2ZRL2QMeFvCc5A6tdChP/CYxHJyNedHqvCxXBlVJdxs6qbQIkq
	3bhi4mmgQLdFo88i7qdYnkB4IOnCCydKBkTjUC3SMrGSwzpDNTjHQ3qVO9S2A34BQmbZyihcMLV
	5RmJg7y2rwN4JMAEZd7rFMRK8OQJY9BJV9tRJg62N1d5eJistVmdrjrFxJYdzr/OrGHd0PdLuLq
	GmEI+Vg0T5S1GsYSZRoVx6qJAoOrSkW0A==
X-Google-Smtp-Source: AGHT+IHVZFOvCSHRwcq4Rd4rtjMvnrw/mr9evlrCFcGiwQWeBYXkyMCBRWV9jPZi34BRmiNYf5ZrXQ==
X-Received: by 2002:ac8:7f02:0:b0:4e8:b739:6b5d with SMTP id d75a77b69052e-4e8b739747bmr82402751cf.46.1760970360441;
        Mon, 20 Oct 2025 07:26:00 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b1:2f00:3d56:be00:69bd:1efd? ([2605:a601:a6b1:2f00:3d56:be00:69bd:1efd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd09870csm570138085a.16.2025.10.20.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:25:59 -0700 (PDT)
Message-ID: <528686b1-e0e6-4c4b-8339-ef894652f774@gmail.com>
Date: Mon, 20 Oct 2025 10:25:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] sparse-checkout: add 'clean' command
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
 <CABPp-BEEHsFwE-bDjcUoDtAYm9pvVN0tGUaoh0KPEJu23LywOQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEEHsFwE-bDjcUoDtAYm9pvVN0tGUaoh0KPEJu23LywOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 7:07 PM, Elijah Newren wrote:
> On Fri, Sep 12, 2025 at 3:30 AM Derrick Stolee via GitGitGadget

>> Updates in V3
>> =============
>>
>> Huge thanks to Elijah for such a detailed review. Apologies for the delay in
>> responding.
> 
> Likewise...it's nearly been a month since you sent this.  :-(

It's my turn to be late in responding. :(

> In summary, I think this series is close to ready to merge, but I
> think a couple wording improvements to an error message and advice
> message that I called out in separate emails on this series makes
> sense to fix up first.

I sent a patch 8 to the v3 thread [1] that includes an update to
the error message. This could be squashed, but I sent an extra patch
to avoid a reroll of 'next'.

[1] https://lore.kernel.org/git/a34cc559-5823-4e68-8f3f-07c182f7299b@gmail.com/

Thanks,
-Stolee

