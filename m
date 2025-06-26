Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF62E762B
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946188; cv=none; b=WZ9Dq0FMJifpk2SJpJoAm4MT0rVuV936GCwjiI+xCI+OMVb8wHZYtm7iblpPd7bXL3FpkDwGwD7nvIFMVHzVrZOuOafqFosn9Ohmu34CNeEOVyfqxLhPBPx4GtiryO2361gli8YKLN80UjIZhsLPmPL2HOXQQI6V74S/8sV32Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946188; c=relaxed/simple;
	bh=0n+OE07L4fPPzQGTXCVxnWqWbpiH6HutID2v6I1FsqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMhpqYJqOc3m9HoVYaYstFPCX/RboBelQMH8PEGkunOu0/Xe4CWC530kGdvHNFgPIXaaFU5ZARfL9PcetLrMJa666EQQ/cyKJKfgiOmyVS9AaRIPhkpVGkDGNWptAD2PkCYUjTQR6EZ/ztU4BJGvOxWAUQtZFpZPcA6PRh8b2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRC11Z9A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRC11Z9A"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso5253715e9.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750946185; x=1751550985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gLSM2Adw48DsPbvLwQprqdNAjgM3ZTf14yLHRvykXBE=;
        b=HRC11Z9Ag4SgcwhVWvukpPBLuBQkgd3VpD72lYgHVDYCgIW33U+r2FI6cSHErAkiD1
         eNFf10Rb9TNQS5qPBbMzHWDpLPTVw3vZRuKa6NIAOa6f/YGJTBOfo7e7EbI0iU3c2CkA
         WfV/t4m9JnlZs6bAlEJ37rFl4V9Gh8+aZ8JclisLtzNlKct5vRENNy9L2392AtQLSgXA
         tPibKGlaBsQsuoWxIPRm8sURH9QOyQ2i72LCcBrCyO7Q4HxqORb6FN1JxofKs0ops0fa
         teszmAYbFwCP67uc5tf9PfDYz60X7VrBpQ5fmZgILQ6IzxS0GBYMTbMLYaAmZBanGpeO
         FN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946185; x=1751550985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLSM2Adw48DsPbvLwQprqdNAjgM3ZTf14yLHRvykXBE=;
        b=KML42WDn8+PiTZ0w8YytiWlyx0q38qQ3pbRRLJhBfZ8mRjeD2mwF7kXmmkbVr12h/L
         ePdmHp1K7gh8Cd/IfhnqPb3QGJJcdBL6bs28xTBLmsLZaXJTuP7uTCppRfWR+nAq3Gg1
         CmwW4uTIbtFzEIDLdv3urMEnU0A1KLi4AVqEIROXDalEjyAEnsd88HdHyKpQkJ0MCOAn
         LWjAoa50t3yBHek38HSltdw+Tk8mA1Jw15S0Uixw9fnT0PeCgNtbnup4sqNc2Y0UVxey
         Kxn0bUIfyOBOEwJoQZt1Aa/bArr+80jgZKq+/p3GDMSGyoj1o3A5iFopAtmydAQccHrc
         EGng==
X-Forwarded-Encrypted: i=1; AJvYcCWttpguXcdfSuJRNDH8RhQFFpwfSb9HF29o0wfA4mZVqHpSHuT0n8kS3G6tE9F309BIXCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywp7rOmTMxlHam/w+zjN97Z6weNDFwlh12IYXGJZpjJIuJU5AH
	VGjoiePFv1RIembHvH67rE1Ji+s0hwy0j1oePp2egKOOP44CV3Qf7DuW
X-Gm-Gg: ASbGncsNuoSKM35QJ1dEIjZfok5mgJHDeRcsqtgdcu5eXFc14lDsxO0mzWKRYpdGhYK
	saXdGnpqEShFLoEuEMS4uUYud4GxhPhVhg0ihuZABCVsWbHuwcczQauYUswVFXF3hhHlZfJUrCu
	41rNH9NXxBe+KtkwT1PH1r6ahrm5dWUowD26bOxn/+LpNfjKgiIsN9alYR8R4ZJ/l9csddS6WyO
	IL1oRrSy5GGs9SuOCkStkTB7tw3kJhKRAQ2ImhiiTfyeAmgf1L6jh+15CJfp/mhfxs8DT4/t2Q1
	w6bQoDScqy+S7yPkq85IY1LInEuHwIv8/Cx1Ye2qGNIhamwF3ZpYb2/ASX1uqDRkOrqOe0qpa5+
	NCCFDoBALRjdNcA7Ggx+u1PipHzYtFqs0FclIfQ==
X-Google-Smtp-Source: AGHT+IGd4VoFajmT4gGHSi1BeFQTGlUlTr7/fYjuIDdn+/sVW8xOmCd8ho4lJcytJlLBAWM793omfg==
X-Received: by 2002:a05:600c:314e:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-45381aa56bemr67383105e9.1.1750946185092;
        Thu, 26 Jun 2025 06:56:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm28850655e9.21.2025.06.26.06.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:56:24 -0700 (PDT)
Message-ID: <a1fb8c27-6ddf-42d5-a062-a9710f6cc1cd@gmail.com>
Date: Thu, 26 Jun 2025 14:56:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Chris Torek <chris.torek@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
 <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
 <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 14:15, Carlo Marcelo Arenas Belón wrote:
> On Thu, Jun 26, 2025 at 01:52:47PM -0800, Phillip Wood wrote:
>> On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
>>> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
>>>
>>> A future change will start using sigaction to setup a SIGCHLD signal
>>> handler.
>>>
>>> The current code uses signal() which returns SIG_ERR (but doesn't
>>> seem to set errno) so instruct sigaction() to do the same.
>>
>> Why are we returning -1 below instead of SIG_ERR if we want the behavior to
>> match?
> 
> By "match", I mean that in both cases we will get an error return value
> and errno won't be set to EINVAL (which is what POSIX requires)
> 
> In our codebase since we ignore the return code anyway, it wouldn't make
> a difference, either way.
> 
> signal() returns a pointer, and sigaction() returns and int, 

Oh right, I'd forgotten they have different return types. I think we 
should probably be setting errno = EINVAL before returning -1 to match 
what this function does with other signals it does not support - just 
because our current callers ignore the return value doesn't mean that 
future callers will and they might want check errno if they see the 
function fail.

Thanks

Phillip

> so you can
> have the later be literally SIG_ERR, eventhough it will be ironically
> equivalent it casted into an int.
> 
> Csrlo
> 

