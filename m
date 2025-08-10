Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98A24293B
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754820542; cv=none; b=ih/k2m11DtQoH66jBwFXeOfTGX4f1jWE9dXuMLQ9Wi5NRNGwwsw2jGOYnwF3CbX42UQ5IwhrkzGvbw2bqWv0PyAYZFQGHvbQiSS9hD2e8qZJS3czalSVCOKU34mwd1YgpTawkNKDszLR/D7AIHWqDbvO+oOPBHuwZmRGo2Ivhu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754820542; c=relaxed/simple;
	bh=Knib10HvpGv2N1cWPmlchMXkFRdHTSF0GpfOrXabgvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QETrx9qSTGMeKwOuS6bAr6GL3D0dg4EoVdvikOjTR6JBGx4yizk8Fj65tyFGh6C4c+oMZn3r46NOiUE0N1ULe85YRlJA3UeadZZ4XYjKepOus5Wfl7yrdG02B7n5dX6L+IvyMswLI93y41930XvkkezloOpQKQPagbplPqm6DHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlU8n2tW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlU8n2tW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so1621187f8f.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754820539; x=1755425339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwSOFjnZGqsfLbHAJQV7KyIzcMdXo7zPuTbKTj0vr3o=;
        b=nlU8n2tW4MbQT2bzqOCkWKNRaaKZFXCvdVAEb9PGSESCPNaD6/rXCmkuskiUTO2GzC
         SfrcxY2bqUVdd6yT/ba1lyaDlh6lmozvh4gnDDzDYat2tgRtTNGgyF22Y5/DfEtRaHw8
         BE8/V7Ce9K9QcobpwIiIRH/lflW8bOMfSSh3sQ6SCvImREJ4BtYvfCKVKE0fMMJp6kJc
         GkjJtOxzWtFiBat+e0QepXzctV6s22TScYtg3DF2+dcEEQ5kNj7yespPkZIBph1MhcOX
         OsGKzVSU2ZXfQ5ekmxwj6lw1dsv8KIKX4IX1ATYzIKFJ0Vz4zs7VmGSH4NZ38jwmtGKD
         rLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754820539; x=1755425339;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwSOFjnZGqsfLbHAJQV7KyIzcMdXo7zPuTbKTj0vr3o=;
        b=ZlK9DugZJNMTt//BpxkSJX5IioFUlTZyVV5Hra9L7c2IJkh5ghz6sc+4+pBLRBvDQI
         ldN8CWofdP89fCqit3M/oatZ1hNe6SwnVp95NEYU9pOONJx+4R2sowxyuTT80nYU7ACF
         y2/rtwIMZsi+d8egOiZUUonv2ub1TymOOXdHff5uIuJ7I0AzZUI7OVI1MQ9OtOK+i5Gx
         4QCjxe4D53hGltQA4sskNrKdHfL9KsynQxZf1fCNEhGKPawuQRB5XvCQesaIOYYIAsoR
         iuyswRoBrbVVXRMCf5hYet/idpfAc6iBQGBhDSvfYUxQBsQcNzGC6GPJZ4hS2Bnqa9bE
         obXw==
X-Gm-Message-State: AOJu0YxTuGsddwcp8HtoAtKTqWGn1AT/a/zRirR25YzdmF3i6Yt1SNOi
	uHrQFONKNikKzGcJld0/w9LGs8fFR+FvvRt7nfviBaaucw1dxxDAKxmd
X-Gm-Gg: ASbGncu/4OVKCGldqUN+0SONlJ4q98IBxnkcUuGNkTp7n4IcMU+Exfcn2mUqLzHL0EH
	ptwc99Bm1iI5r7INa8JkYcUqq2a7y5fat9mBEksZVM5QQpwLdvW6zBgJTcw2Y+KAtSgIR2JTjGa
	1Ruu199C+Z7JYlF5OeQg5ChSLqxJy9MdxHzyou0SbiL2TAX2fSBhhgmZmHaf183LEnxNaSFyR8A
	froSsC6MHnLMh023+8lLNpY7aLrWlfmZeLDI3ECvAkcO4M5Kn6tquRlboaBG1A5SQ+c2sGAkOuW
	AXA2/AZm0blrDOQj+zyGXsv+H50X+jHq1QAoCPQ5f32GWSh4BsetEFuxLpk413AMWh/uCWaghqq
	XAM6N7yYBWsLsjG8Dcrzk7EzPb4UGjv6+c9CxJgIwr0z1JDebr7zlz8gUqt99wq/z0UDAX//HJ6
	aVwiCmCPA=
X-Google-Smtp-Source: AGHT+IFDESrgR88kciMqxBIsc/6GDGMK5EcKxcO9e+JXC2QFVGJulUUd6/dZZoE/qhB3ZwYClbeuqw==
X-Received: by 2002:a05:6000:144f:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3b90093e6d2mr7116737f8f.9.1754820538654;
        Sun, 10 Aug 2025 03:08:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:388b:154d:e1e3:7131? ([2a0a:ef40:7a5:4701:388b:154d:e1e3:7131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c33fesm37300680f8f.29.2025.08.10.03.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 03:08:58 -0700 (PDT)
Message-ID: <cc90fefd-9234-4fb7-a00e-96c4004ddace@gmail.com>
Date: Sun, 10 Aug 2025 11:09:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-jump: make `diff` work with filenames containing
 spaces
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Greg Hurrell <greg.hurrell@datadoghq.com>
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
 <CALnO6CDnSXpUVQEUJr=dc1ZY6errSv2M=4EmeaOmfDvcifHvnA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CDnSXpUVQEUJr=dc1ZY6errSv2M=4EmeaOmfDvcifHvnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/08/2025 15:44, D. Ben Knoble wrote:
> On Fri, Aug 8, 2025 at 1:43 PM Greg Hurrell via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Greg Hurrell <greg.hurrell@datadoghq.com>
>>
>> This commit takes the simple approach of unconditionally stripping any
>> trailing tab. Consider the following three examples:
>>
>> 1. For file "foo bar", Git will emit "foo bar\t".
>> 2. For file "foo\t", Git will emit "foo\t".
>> 3. For file "foo bar\t", Git will emit "foo bar\t\t".
>>
>> Before this commit, `git-jump` correctly handled only case "2".
>>
>> After this commit, `git-jump` correctly handles cases "1" and "3". In
>> reality, "1" is the only case people are going to run into with any
>> regularity, and the other two are extreme edge cases.
> 
> So we drop support for case 2? Hm. I personally try to avoid this
> situation anyway, but it would be nice if we could just do the right
> thing here.
> Or maybe we should consider trying to parse --patch-with-raw output
> for the filenames?

An alternative would be to parse the filename from the "diff --git" line 
like "git apply" does. As we're generating the diff with "--no-prefix" 
that should be straight forward as the line is "diff --git <name> 
<name>" where <name> is the name of the post-image file unless it is a 
deletion in which case it is the name of the pre-image file. We'd still 
need to check the "+++ " line or look for a "deleted file mode" line to 
handle deletions.

Thanks

Phillip
