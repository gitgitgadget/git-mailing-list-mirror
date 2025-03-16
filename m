Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CB42A8B
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138393; cv=none; b=RbDyEjwfSWKqZoum6f+HWftM1NlQjT2fZT8hl4uRa1ROWL7R3rCjuE5jbFGedH0XXtSOP+6ZMaD0ijF/z6isr6FZ5Sn+wnYRQ+ZUYwYPBJ5uB1nMFarhwRjMJIuXMi2/aiXKa8ToCpLGRnMGKRoEXkUFyezm0+C1SWZsz4nQKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138393; c=relaxed/simple;
	bh=V1c8AJD20tXa1h0RrbUCwaDpLQNFeyJrcP3cr2FhEHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze7xC0C3NRcI5/DLZm/oPl+H5L2S1OyE8a0AFrUEiK/euBrm8h4OacVikO987/TW66Kc68cyihhXp07x75iNyuzS8xIWBfc3oJRw+i7Tl6nF4ClL1f7xm0Bta6WDlbVCvAoK3TzqOtwnjWdC6u8IsKB4VHsw1OEkGL9VuNTn96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZawVfrtL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZawVfrtL"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0782d787so8437885e9.0
        for <git@vger.kernel.org>; Sun, 16 Mar 2025 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742138390; x=1742743190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho2KgFprDShXC6tWbov/q5g8l+BckMOVV1WjRksFNCo=;
        b=ZawVfrtLeTvGe3ntwLgjfQCDunLHJ/mueADV7cRYPMPRm8rEmUJX9KTPx23G2CO4qG
         ik3rNdXJ1ZO4K20HxzfO2QMziv5JoVjwICN2j2mAtQq1ay4L5aZFt1Kza/CcnHaoVBZV
         9KDTWPlqM0jKJAooKehnKYvaGeDssdq59wz83mal90cDohXHPMEMhmCkATF6iM9NrPZ+
         S1xAAzKfMdczlX8a1aH2xiKJdhVFq2UT2INcGFo/xtQvE4J9iWegLtEg8gjOiv00CzN5
         Halg3WHRXNNiwmA2yW7zodGl3yeeic89fKivoHDzCvoISqAckwgx2Rzm34fFJ6Cg6iBl
         A5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742138390; x=1742743190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ho2KgFprDShXC6tWbov/q5g8l+BckMOVV1WjRksFNCo=;
        b=aY3dLUnNBO2efWsWmVJoZOjtZA43U3J5jVWsXZHjTZzEj6+zzfNkL/Kp+GPV3Xa69p
         aexBoymle/Ij5JYXhomw3G67PRLiUoH5g8w3AsZEUbd0x6zVkUWlkGF/z8SaiZyNHgOs
         /pfmDgiPFRTyj9KLHyB68lLFhj06fA1CucSkwlEHCCFEyhDEsqwmhiH5hPmR3rPiZO4g
         tKjU7X4Nsd0D+F7PmoSxFOYvcxyJrGFfNV/wrieRztgA7r6j6+erEtqRsThdEqjl9vkh
         tLeB5OvZ8IwSKgyE80wfsXmqUZI5VHajeaTUAzhH8GxfIUsD0KbXsk4h/uVgUB6ec4NA
         DHhA==
X-Forwarded-Encrypted: i=1; AJvYcCVZsl0qoWvW1skUr60hr2Kb7ZJxl9zfW53uHD84pWOXIQY2lRRqcPkl9ahMxmqaBHmxtZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCy7aZjkAv5zwYSrJVdII5AnBEIiNzs/YxRKLBn1cuEg+CTnPH
	+Hn8FkWSyAWuXMDpHMqsOsjsNFuyIdAW5DDY8xyN7bSMDofwtz7j
X-Gm-Gg: ASbGnctG54BIqanIPCinIQK/iAwuP7D6H8Dj3i5KRaNXH4TLbXkASe7Pwd6yqjk+Ko4
	dINsqf2be2qZiurWlmFyFucB/SqgohYBJvfbf47k7bcj5sAuUQKe7B84JZ0ok7WtX/lf1j2zkkN
	JgKwQM+oB5YQyp3/3Tqg/eSJ2kvny198vzJs3pnUXzH3ihp/7GXp1kN+2pVlQ0o2r5PRTjMGouy
	oedN4QYbcvdW7Px5jcD8uMDlWHOkszPHNod2Xtjbpai+UsTOt2TnsacXujM/wP8cvkURJupGyCL
	NYarLsJrdvGEyldnR0HfzdPjuQvvinKlaWrz0i1fRTYRV8SzYRIFnwf0zYxwCwNa/+iUGUgeHy3
	qwpe1Zk8ebHtn8Ht/53Yc
X-Google-Smtp-Source: AGHT+IFSvOcTTguquq54I7m5kAAY9q52+LB6/+axfYVs47iPErA1+NKPLvbOm7pxyJtmT2f9QPUEUg==
X-Received: by 2002:a05:6000:156c:b0:391:456b:6ac8 with SMTP id ffacd0b85a97d-3971d8022f9mr11186249f8f.24.1742138390065;
        Sun, 16 Mar 2025 08:19:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb876sm12164592f8f.83.2025.03.16.08.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 08:19:49 -0700 (PDT)
Message-ID: <44a3ad4e-fb50-447f-bb66-f43b5c5ae012@gmail.com>
Date: Sun, 16 Mar 2025 15:19:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] meson: don't install git-pack-redundant(1) docs with
 breaking changes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
 <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 12/03/2025 13:17, Patrick Steinhardt wrote:

Thanks for taking this forward

> +manpages_breaking_changes = {
> +  'git-pack-redundant.adoc' : 1,
> +}
> +
> +if not get_option('breaking_changes')
> +  manpages += manpages_breaking_changes
> +endif
> +
>   docs_backend = get_option('docs_backend')
>   if docs_backend == 'auto'
>     if find_program('asciidoc', dirs: program_path, required: false).found()
> @@ -479,7 +486,9 @@ endif
>   # Sanity check that we are not missing any tests present in 't/'. This check
>   # only runs once at configure time and is thus best-effort, only. Furthermore,
>   # it only verifies man pages for the sake of simplicity.
> -configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
> +configured_manpages = manpages.keys()
> +configured_manpages += manpages_breaking_changes.keys()
> +configured_manpages += [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]

I don't think we need this hunk as we add manpages_breaking_changes into 
manpages in the hunk above.

Best Wishes

Phillip

