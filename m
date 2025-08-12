Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06E2E7658
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989643; cv=none; b=Up8SJ14IEnEHQhPGSVdlEPRLki1k5TcJ0RVwxI1b/sPq3Z9xzU2LJsktnCmkRYqnbCLqYQdDhZwyWA1BW5SvMwZVcxD6WRGFuHBcjqivm0CC7pC14dhkYD0OOGnuxd+72ti628bv4JxylinJ6SsfmO00SI/XVDtfgkYUZ4G6RGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989643; c=relaxed/simple;
	bh=sWpplqUIQC2qWbaNA6sEQ1CtBs12RB0N2f1YaeEu0pk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1p0xIa7ND1wiunZYMxdZEZ4CFiFSQSPuc5/1iRh4+kuDWq5Gu6Xre8sbKZsvCw6+zWDlmZTuKfIhCue4MlYkblVqaNfDCam0H3t3IqdQR8X2Wb7SpW6kGzsWIMkoMUqP5q7DIR59NDcHwG7W3tlH7GcR7frMe+uRY4FZtCWREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlxf/mbl; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlxf/mbl"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4fc9db52e02so1602586137.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754989641; x=1755594441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4asfmlLWq4BltP/LBuQXFxJDHyKofaRBt//XgRKUQ4=;
        b=Vlxf/mblHKoUhCaqtgcSFLMM6HVJ5aP+JeHAU4wEXiiHUd/d83O0XiPRTjQssUo1k7
         wp6S0mUFCPTrtFRZTLcK/oapNIeudmI6xxZFjaxn5CsJClhZKUeLB61OrcJ9Yp5JITEX
         svxBkiOBnOLW1VzQ2CELvK+2sM0uT5qto98DP8BES1tpXGAPs/VS/Kjv7jo6M5L2WfGf
         fLHFCPkPmccU4AwximUO3MLdYaJLr+IAROMH8JgAowsv9r6bLPKHb3o+08ajcQqFiZqK
         lbbkiaLIDtTBAp23p1tMkMuaEvWYw1wSzAkbXLFI8pw9eZu1CXpiSijC8GK5y+04Sml5
         nlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989641; x=1755594441;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4asfmlLWq4BltP/LBuQXFxJDHyKofaRBt//XgRKUQ4=;
        b=xE7eVJ3plexHXt+IJQPZ6lgcG0nZlwH9xZ11+PkjYwOdboHDiufikWXGBNc0+rOJpk
         Li8RgVC5kHUJ9VPdGCYhfV5EVIGDqtfEOqTpkHO4tF8hbwMDLSAyrA5nH908oEHKvZ9B
         JQkDtd6IZhP1Am5ZWAOVBDDr4tgbsSnr+QpNOnHupKuaUypYxm9Gk3YVg+X5nQLZyHJL
         EveAN0qLX7cLvSDV4P8KB0If9AVZwHtbuOM2dZmDi8MlumJCbn9Q2g9uIDNmNlR4CAIp
         CgozE/vjAsn3mET+qkZPUi5WvS0jrnHIbfsB6a+Y10IFlo7+I5ZrIAjDD/eNhxm9JUEB
         E6fw==
X-Forwarded-Encrypted: i=1; AJvYcCUxU9pZr8y7Os25AdlrMEvWwsjNqzK0QeENShsJVGQ8IT5fJqCvFL5x1HSVc63JYzctmZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytsReMmTdXdx7sk0gePtx4f+5KG+3D377f0otBLAOGwsoxaJ7T
	uffd+iwmy1C+JhfsyU8WNfER/oxubXi4nC3Ww8CBY9wtXGT3W8FnyBVqhEx8tF6eQSHG4Y0yIVR
	UjTIgDHnmx0Eti2uXIxU64V4nqyPdo7Y=
X-Gm-Gg: ASbGncs5GtCx9O/BqbUBBblAfxo07MRA9wwSYr8WZuNNA/ELoCWsfvmlZeAxOYlb+iL
	933oRNJADBQDgBBiHXhdlaeeXkqf/EutowcKG6FTEr++lpXOmHdixvygM470s5dQ3zCNyx113CW
	1G394PFBnQTseO1iKh9HQ6b1KXszi8xV/KGLXbqteCVXYv5Md3uKM5HxL0qwg1hUxFvkanG9qlT
	U9ezIU=
X-Google-Smtp-Source: AGHT+IFtBA7/WC9HlpuJ+e0uKnR0E8GgkCSgiyw6IW+LVrM6xEdmjM2jp00yxvxrpfe1dmtHXsNSAJQZrj9LDLlE2hA=
X-Received: by 2002:a05:6102:e11:b0:4e9:b0d4:1133 with SMTP id
 ada2fe7eead31-5060f0cddc8mr5537469137.20.1754989641238; Tue, 12 Aug 2025
 02:07:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 02:07:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 02:07:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <84258154-322c-4ef0-9ebb-44858a5d58fc@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com> <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
 <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com> <84258154-322c-4ef0-9ebb-44858a5d58fc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Aug 2025 02:07:20 -0700
X-Gm-Features: Ac12FXzMoJf8L3lHd1y_B2jN13P8ZFpTFh6KVWyDs-9FVcPKojUHVko87naoKs0
Message-ID: <CAOLa=ZQwwcfEQNbZqp3o6YfTWMhUr=s0Vw5jP87pUELsktLRaw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
To: Phillip Wood <phillip.wood123@gmail.com>, 
	Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>
Content-Type: multipart/mixed; boundary="00000000000026a630063c275ec3"

--00000000000026a630063c275ec3
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 11/08/2025 10:13, Karthik Nayak wrote:
>> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> +
>>> +You want to transplant the commits you made on `topic` since it diverged from
>>> +`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
>>> +by running `git rebase master` while the `topic` branch is checked out.  If you
>>> +want to rebase `topic` while on another branch, `git rebase master topic` is a
>>> +shortcut for `git checkout topic && git rebase master`.
>>> +
>>
>> Nit: now that `git-switch(1)` is no longer experimental, we should start
>> recommending it over `git-checkout(1)` as necessary. So perhaps, we
>> could s/checkout/switch here?
>
> Junio has already expressed a preference for "checkout" here c.f.
> <xmqqldnte6h3.fsf@gitster.g>. I think that is technically correct as
> "topic" can be a commitish and "git switch <object-id>" fails without
> "--detach". Also rebase does not do any of the extra checks that "git
> switch" does before switching branches (I'm not saying that is
> necessarily a good thing).
>

I missed that, but since we do mention that `topic` is a branch, it
still makes sense to use 'git switch'. But either way this is okay.

> Thanks
>
> Phillip

--00000000000026a630063c275ec3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 67fbfd23cd3504de_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pYkJFY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXhzQy9vRGRRQ1J4Wmd1bllDTTd2TmlZSVlzbWgzNApjd1BxV3VhZk5P
YjFxZWVpQWdOUW1YdUxUMlhZelQ0TGQ2RjZYbEd5dHBNamVwdVFlV25xd1VLZjJtQ2JBU3RtCkE4
VnlKZkhNcnhIVTlpUWtkODNBZy9ZZktOaXJwdmtzekV4UWthVlNkdFM4dWpyK1RhMy9nU3EvWmJO
UDI3WVUKSEkzMFVMTmlsUjhCeDNvZSs0LzZYNFBQYlZLSjFTOEdXeGZnK1NGUkUxN0lJRm1QOWha
V0lpSWh2M0JvVjYveQpUcHk1KzlKdDJaZUtpdFlIeXhtUDNsb09rVytZRmdLRi9YUnlMMkdOMkJs
Q21CZjQzSGpEY3RRVU5VQmp4K2cvCmVqWU1UU0M2Zzl4VCtwVFlmUlNTYTk4Yms3ZmpuY3hvRHVa
cFBTOEx1cW00aHFQL3V0VFhGSVp5c1IzQ0Q3cGcKUkdEZWZLRitFdjFuR0VrVXdpOGllOW9RMlRu
WVVCRFRKVitUTzJZeUNmMnl3N2swYUZGTFZJRVEyTGxnTjg3NAo2VVVLeDI0cGY0WG5hZzYxWi9l
bzI0elZISjZZQlFwQ3VMZlpYdTgxTG9pMWVxWjBVU0tBK3lVL0hrbWFNempVClVaZ3NlY1ZZQWxo
VDViS01ma3pZVlp1cm1XaHE3ZGV4dTZmVHZGdz0KPUJMZ3MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000026a630063c275ec3--
