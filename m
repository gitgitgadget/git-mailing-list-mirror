Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C752261B9A
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472764; cv=none; b=lX+pVTK5LmfiC34HijiiSx1gqb6NbOqNSGCikwBlmq7TXYqIUqr/I5aStTLM6M/Hzc369iQtbD/lXBmaU+7wT3StV4+6LYFMBT2755GfxNDoleMECoq7pw+40Z8LALFAzL+Bad6ag+jBNf0gSfODojVKpbVwCY/iI8qHpW/SvBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472764; c=relaxed/simple;
	bh=fX6z6kdOer0E5Vucuf3BKYC7CrwexYqU+urN6heMY9c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zi7YoGxX2JUCC1xGqZciLONCxk9GlNe+fg9w4UJZUlX8zQfFmKxJjkNBdTjVl7fjRZegp4S269ni+GsWW29VdWwNXDuidKni7K3TKrtuh1RcWvE3DkyiT6luzF3GJUxWbm0yqHlrWDsU37ANno5szdqBhrZF1UhIdPDHNrnQRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+x3hoXI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+x3hoXI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7d485173so10181075e9.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756472760; x=1757077560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tyM8WTfd24saRUo2v/SV3CyeFM7A7vHkPkVSo0G4DIs=;
        b=R+x3hoXIL80iWmCGiUtXoqpugroaR+M40gpLvOaofDzBydLXrHSpx1PCZCUnEENT40
         XSxdIRdTAyWJzPKiOmEmro4mmP4+A7lYpQmhz2+HFdm+Pb0emdV+AHchCDSlNk855oqt
         T9reUohw75wZapESjVVKN0lm+Dg6YMdxZXDtBEOTTsvaVu6gMo6lQp8/7U4p7+xDo0iu
         GkXw4kTJzUARMD4594klD9oy5w0nHPWEXkzKg+BeMAI67ClcBRLSfCxh+DctB9Vdd8zn
         pnXNuOFYMD6ErkHTWQHUABVBGOfT8YFM+a/AgbVEqV8TnGqwrEi5vvMZ1fGdRsq0XUkk
         D5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756472760; x=1757077560;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyM8WTfd24saRUo2v/SV3CyeFM7A7vHkPkVSo0G4DIs=;
        b=ee9JfDJNVZ4uTPidqwrf9CvuY2YQjLliwMEisj9+xnZW94tk8JSFjj/KwTVwIv+JAv
         CyT7C7ZWtARW8xU1mlLpPnnr1Ed7Fxe7moHzWf9hSzKqsU1T+fsehltL+X+ycLQWaScS
         jjNGDwcKDGNai8qQQxbxviyIiYfuQL2lQwPhbVmLuswchCMfrdaOR7tUwr57+x/ANiXl
         nBh1MNdfkAe8vFvK/5zbXihTHTfWiqnlCOTp34V1SukN7Sq7nYKpssYau99GUZ+CDN2o
         0mslKnlZ/Tebu3K0f5R8tBxPyRftIvm+ozdxxMNZZXoHzdkDh8boyISvNiu7ArAg68eX
         jPHA==
X-Forwarded-Encrypted: i=1; AJvYcCVmPFq/+FFaUNvbN8UcyTTC/+1iqqO63J5mrlua9xSRyheUytNUEMjx3LXL5BXSJKxGHkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBBL5e6uyp2nmPXBCyn3Ve9j+V923QTzBVu5FAHBWq6nKPnD/J
	wLJ1bOUls7GvAheGCuP4DfIGdbP8p/oKnkbDul64Nkj63ao0YMHoePcZzr7Wnw==
X-Gm-Gg: ASbGnctkMrxSGLJ5ubd/dCH9MTJ9YkXUAXVfmgBtjvd+wk+JuxGfbLLSrKK9N+x1m3K
	106VktxEVZ7C9wwRMHIidE2AGZBL92oKwNYnU7d083/ftt3x/2/sxl0TCcDIRd0P8wI+cRYmGVa
	22zB0gYHCdNKI5atPiT2ep1IqzWJyR20qBJ5OrjXvDgvwk42J9/ZInPwJPSwa/J8hyt5o9E64wm
	9X5qF0e0MlhOMu6Ekkjn5TRXuLxTGmxv6FTtgbil0ivWHCq/QnpRhZ15LbhYViEDlBFZjnP6g5d
	589vpu/VfzeY8JvqI0e+3N/sNuk1OBm7BPt9lGHaCRRenQdqNgefuw86V6JZ/3P+NTGx6HnPEzd
	anVVowmPLVfH20vRSDTG4f0gM0pIj+u1f8Fo+oDF7jKjtCbUt2u7FNiLs0wYLxu2MCGfzFrFggh
	dT
X-Google-Smtp-Source: AGHT+IFrsL47RrNgNU68sLHGNUypQqldFRTErAfX4gRP2V+l3aY+qyKhz4+6fzVla4WIT3mV4LLJcw==
X-Received: by 2002:a05:600c:1386:b0:45b:69c0:1909 with SMTP id 5b1f17b1804b1-45b69c01d6cmr100747805e9.8.1756472760072;
        Fri, 29 Aug 2025 06:06:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:1c1d:4ebf:5a41:64b9? ([2a0a:ef40:7a5:4701:1c1d:4ebf:5a41:64b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b83f86c8dsm344765e9.7.2025.08.29.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 06:05:59 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <0548f4b2-6c36-4958-8725-5c9ac91e31e8@crinan.ddns.net>
Date: Fri, 29 Aug 2025 14:05:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a
 repository
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org,
 gitster@pobox.com, chriscool@tuxfamily.org, christian.couder@gmail.com,
 me@ttaylorr.com, ps@pks.im
References: <xmqqcya63cqx.fsf@gitster.g>
 <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com>
 <370f11e1-b335-4111-912c-94429c5018d6@gmail.com>
 <CALnO6CBbEB=94YsZn8vtjcwYENuMhMdg_wb2RbQunVCxnf53jQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CBbEB=94YsZn8vtjcwYENuMhMdg_wb2RbQunVCxnf53jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 28/08/2025 14:47, D. Ben Knoble wrote:
> On Tue, Aug 26, 2025 at 12:04 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> +for cmd in $(git --list-cmds=main)
>>
>> This lists all the git commands in $PATH which is causing "make test" to
>> fail when I run it locally as it is testing all my local "git-*" scripts
>> most of which apparently fail this test. If there isn't already we
>> should add a option that lists the commands only in $GIT_EXEC_PATH and
>> use it here.
> 
> That should only happen if you set GIT_TEST_INSTALLED or something,
> right? Or maybe some even more exotic setup: even with my
> distro-installed Git, the command doesn't list my git-* scripts in
> $PATH or installed extensions (like git-when-merged).

Sorry for the confusion, I've just had another look and it turns out I 
had some rubbish laying around in the root of my repository which was 
causing the problem.

>> Also when I run the test with '-i' it does not stop at the first
>> failure. I'm not sure what's causing that as I thought
>> test_expect_success should exit on failure even when it is called in a loop.
> 
> That's odd: when I make some modifications that cause a failure and
> run with "-i," it does stop early. Hm.
> 
> Thanks for looking carefully! I'm personally having a hard time
> reproducing the issue though :/

Hmm, I'm not sure what was happening, at the time it looked like the 
loop was continuing but I can't reproduce it either now.

Thanks for taking a look and sorry for the noise

Phillip
