Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FA1C680
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710617642; cv=none; b=EChdko04hLJpHoWFr6CYwul8Lsup7dzFCBKLQ+9J1EUSKXXFItB2kW4scxP54gxfIavY4qkBjo5H/NZgWegQxMBGBpBcrGNGg7mJ9SNMQleIZE9pMK+iKZXiPAp7abvjsBqW63W7ysD6stH0nX17+iW9qetcaL2VlS9swgzDKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710617642; c=relaxed/simple;
	bh=qvV4Mb+bKDJ3cqey09oNzUToscziBHClibliw3hsNSg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PCRD4sAN8B/Eu3Z19JEGj5oykTFEaHm5vW9AOutTj4GuUe/kyXd5o8pCvB73+OILFg9o8l+Do1Dj9ET68TDuMo7WK26ff3V+LpsLO64EBocYgw2Y91brRnYteWW6FaIw5+JLWbG2Jgqr44LD+AzwRCXCyr/L0tzx14u+WzaSGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL/xfU3O; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL/xfU3O"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69107859bedso22113086d6.2
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710617640; x=1711222440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qTRjhI22jQB24ESnP97XpEh2b0uvt5991LTNntO3Hs=;
        b=ZL/xfU3OHz5IjaVEnaJHmkDfoyBLP7/pta+J+kK+kDO8ER+GxzQnwMmJ4zT4WUm2QQ
         iLxaJyhadcQQmmeIYRWPW4Skz9vg1LCn1kutZdyOTwqOP5gHH4FfXsAdsVxdY6PU41Rp
         6Oz2uhUT/+1gM+ooRIbwjiX8LUft40iIEMzAN1zFHNdd01cmlQq5r/39D5ouFLay/770
         idqTvcyRn9Oj1/QF6T2V6kaGuMsXpBCjcWaFNm6F8Qdk2qfprder3o+Llqw4yCbTIjli
         36ZngLXhFKiusqXOKXKmC5rvv1crI6iP2EA+f8Bzydmaw2VehuEVW3hkiddBzEmlAVIM
         L8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710617640; x=1711222440;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qTRjhI22jQB24ESnP97XpEh2b0uvt5991LTNntO3Hs=;
        b=n/x9Y9jHBKfaWhGm1/VcLoNr71Cjxgm+O2iYpHMTMWiv9cDh1fg0M0KN7qgfvA06dr
         +VcMnkeTvoG59FyR5iO7fLjPdepN91atONRj5vTDIPrqvOGUwTy2aKGM11KSOzBqurDS
         L8H/UR4dxwfo30vu8KLFBmjeDBu/nDfAmKIIW8MIy0dF4+/R1pmhOZiqHAi08iGURoOa
         Za4uXi6QpJq1uYCCBLnksp7hg0XXU5ZDpd+OMVtiu+AH1X+heMpf6R3kzELh5gtpY46c
         U3KUHmMfFN6mhkl4Y/P2y6rhT/efu6IfqScRWl8eLFfyiQox0obe2PZMjVG19q62Mh+K
         liDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHuhQhixFmd2VNs6PES68KlmEDgDV44MZA0hpqUrb4yYDjrQKR+WGtUqERgtdGuEtHtzrb/Dg8iYbdIydfpwAihZjK
X-Gm-Message-State: AOJu0Yycwq9BZX2PpLNru1LCefdZeApkD+vKm8xyEnv1sjv5WXC0ZYtr
	Zq8nY3+Pinzg9lliIPjgMw/OBHuLgVt/K0BlBv3sZR81ejlkth69rOx5WGjZAcU=
X-Google-Smtp-Source: AGHT+IHIN76U6CwMgjlk8BrDN6m/U2JzYb8BIwgm5/UTt4a5AyXBnG1RHHERPK3H/06zHf60Pqk8WQ==
X-Received: by 2002:a0c:df04:0:b0:691:257e:3c8a with SMTP id g4-20020a0cdf04000000b00691257e3c8amr9147478qvl.19.1710617639725;
        Sat, 16 Mar 2024 12:33:59 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:103b:f04a:b551:cd51:32ac? ([2606:6d00:15:103b:f04a:b551:cd51:32ac])
        by smtp.gmail.com with ESMTPSA id jv3-20020a05621429e300b00690cd39da04sm3402688qvb.32.2024.03.16.12.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 12:33:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sequencer: allow disabling conflict advice
To: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Josh Soref <gitgitgadget@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 ZheNing Hu <adlternative@gmail.com>, git@vger.kernel.org
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
 <a2ce6fd24c270fcc89439cd7d119c701dd262ec5.1710100261.git.gitgitgadget@gmail.com>
 <15049e66-09b8-4baf-887d-e9118b9cd175@app.fastmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <6051365b-7ebd-b63b-2ece-4fc072a001e5@gmail.com>
Date: Sat, 16 Mar 2024 15:33:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <15049e66-09b8-4baf-887d-e9118b9cd175@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Kristoffer,

Le 2024-03-11 à 06:29, Kristoffer Haugsbakk a écrit :
> Hi Philippe
> 
> On Sun, Mar 10, 2024, at 20:51, Philippe Blain via GitGitGadget wrote:
>> diff --git a/Documentation/config/advice.txt
>> b/Documentation/config/advice.txt
>> index c7ea70f2e2e..a1178284b23 100644
>> --- a/Documentation/config/advice.txt
>> +++ b/Documentation/config/advice.txt
>> @@ -56,6 +56,8 @@ advice.*::
>>  		Advice on how to set your identity configuration when
>>  		your information is guessed from the system username and
>>  		domain name.
>> +	mergeConflict::
>> +		Advice shown when various commands stop because of conflicts.
> 
> Given that topic kh/branch-ref-syntax-advice is in `next`, maybe this
> should be changed to “Shown when”?[1]
> 
> 🔗 1: https://lore.kernel.org/git/7017ff3fff773412e8c472d8e59a132b0e8faae7.1709670287.git.code@khaugsbakk.name/

Thanks for the pointer, I will change that for uniformity
in that section of the doc.

Cheers,
Philippe.
