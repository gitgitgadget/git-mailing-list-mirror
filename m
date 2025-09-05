Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBFA315D2F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098745; cv=none; b=kiphVTbxM0zRLHP3SNXB6jBxvbWUXZcsoTdkUqRDE4ymeap7/JicteeU2HO5qdjnMyqWX+0xsLVeRaUqCArkPWa3EP3MHsDndFK2C8/tEhA/sHmJqT9snRWKO8l8LjR+F+CpI7F21/f6H8Up9FYpAjsMR4S8gUTvSjpeFth+NhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098745; c=relaxed/simple;
	bh=K3mbU7K7OiU2ywzqBnqSyRgpC50MPKltTKi90ll9NgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lk7M9vrW2jvmhRnNQ4/rErLejWBg7jAyxuWjN0LsGe5VH5mbvmeVxju7g5rWe0Py3aCHn/aQPE/z6GqRC/58oVQgQljguc5a8U7mKtBaPdr7wLNccgGBGZSD6636Mt6odSKuPpG0WdOYqenQ3bffxJrKshfEeOCn2TrZqPdDTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2tVaXRx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2tVaXRx"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b490287648so40354491cf.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757098743; x=1757703543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSghiykIFopnM3oPGHZX6+S/1C+N0QISyI3lm3cvxa0=;
        b=H2tVaXRxIGP9NyTKPiY5sb07SZKDMJeEeegRbVptnLhTAjEVPYXNiw7nTZTMohuOYU
         Sj3g62C0KuFCuP42TBovTnxFeONEwXWARBb6OZA7Jy2tL0PbPcerrAw+RVxnmqQwQ4uN
         I0by9DFl4Je8QnWntjir8YOt9nSeLD09pFVeb04rmBku9zhgMACFIy6yYWV5sM1IjFxx
         1QuQZk7biHcDIov0uTe9eRZ7R7eockxmz7cSrLMKQ5aTJ71mgD3H1q3XYAmT/78Niqdy
         tQOjiESFtoqEjZkA897d2MwC2AfgS4B2zO45kGQndOEYXFnkOo/y1H6PqTBwXzHezlLZ
         l2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757098743; x=1757703543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSghiykIFopnM3oPGHZX6+S/1C+N0QISyI3lm3cvxa0=;
        b=e/EdhJUQhZcaPr1WiGU61hOPDCjuBIMRhDm+70LIXCRegQ/CLQcn/xKozffnqmTm+i
         gn4thK5Yb8hCE+TkVRo/yH+ORfptTtSOV307aUAyQLppazy+kEcW7sy2ohqEIBcCUYoD
         qCmd7LvKqN2z+4PjRHLAS7gN+CAAAT3E0G1z4u/420ZVdeYSppNOAGt3EgGmfIkm1Dtu
         H/YledBr4ZwglpyIzOMS3SVPSycM8itFKzJIADwtnY5XHjUAPCe7CNnUyhNE/mUQkEzL
         panJIGaQi+uRCM2OovO66b4tEnz8u7fwnFBjtZwhegmGHTG1nL7FwcgtcpOoK6I+RwKi
         aN8A==
X-Gm-Message-State: AOJu0YzOvIGDCLE11z7lHPs8y4qRfDKoW6B6Z/TQj2RgB/EAj6hcvWuA
	KsTzcWTF2EPZ39QByud17XNOWuAUllCAezxiReFrnmQPDgwt4YZsnqzB
X-Gm-Gg: ASbGnctnCF7FSXLoR1Kz6XDXSiCRNa3JxKY84tTK0LMcwdwWSRQLoBrR9DjAajgkHbT
	6KyTqBB7hWnRhSYBqRtnmBaeEkgeg9BzC388ENlfzvMoAW8CyHA97B9CbOvfrPWRnRy/CeaFDdR
	uFgeDl39FV8px+yEjbVNP1q7A3ZxRCta6Qu0uIBa8kItNOU+6hF2F1sRKUnMfGm2jU04l2KIeMb
	Jaiz4qI7ozH6HztTmUYd9uKyd8LdkjcKI/os8kIL7qjyNVvbEikYjlSjvX4kq50gq1AaWKzTbf3
	i8PkNjf8tnd4u1hdRbdFI84xHlz2pWwD9ApGLFiDOUThdKJBZmj5iWbgRuW5Cy3dmx06BaUc+jC
	mpkoYo6hMLk/KzFhBnw+TowIpTZk3nGxw9a2Cot7lByLVWQ==
X-Google-Smtp-Source: AGHT+IFHaTCpvMmnLajZEZnfPalYX/55WAfG01XSSg3b5D85BDp0kmy2xfpYgp861gsJ2+uYWSOHxg==
X-Received: by 2002:a05:620a:1a05:b0:811:ae92:e67 with SMTP id af79cd13be357-811ae9210ebmr290244085a.56.1757098743039;
        Fri, 05 Sep 2025 11:59:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f760331sm51159191cf.24.2025.09.05.11.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 11:59:02 -0700 (PDT)
Message-ID: <745f5241-b745-481b-85e7-8cfe6ef73844@gmail.com>
Date: Fri, 5 Sep 2025 14:58:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] midx-write: only load initialized packs
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <e02a444315acbc638a3d31279c10a936f0adb7b4.1756589007.git.gitgitgadget@gmail.com>
 <aLgVIPpW9QBFmgb7@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aLgVIPpW9QBFmgb7@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2025 6:14 AM, Patrick Steinhardt wrote:
> On Sat, Aug 30, 2025 at 09:23:22PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The fill_packs_from_midx() method was refactored in fcb2205b77 (midx:
>> implement support for writing incremental MIDX chains, 2024-08-06) to
>> allow for preferred packfiles and incremental multi-pack-indexes.
>> However, this led to some conditions that can cause improperly
>> initialized memory in the context's list of packfiles.
>>
>> The conditions caring about the preferred pack name or the incremental
>> flag are currently necessary to load a packfile. But the context is
>> still being populated with pack_info structs based on the packfile array
>> for the existing multi-pack-index even if prepare_midx_pack() isn't
>> called.
> 
> I honestly don't quite understand why the conditions are necessary here.
> In other words, why do we need to be careful _not_ to open the
> packfiles?

My wording is poor. "We don't load packfiles unless one of these
conditions holds" is more appropriate.

There are some test cases that want to keep things working even
when a .idx file disappears, I think. This is a reason to be
careful about open_pack_index(), but prepare_midx_pack() is
something we want to call always.
 
>> Add a new test that breaks under --stress when compiled with
>> SANITIZE=address. The chosen number of 100 packfiles was selected to get
>> the --stress output to fail about 50% of the time, while 50 packfiles
>> could not get a failure in most --stress runs.
>>
>> The test case is marked as EXPENSIVE not only because of the number of
>> packfiles it creates, but because some CI environments were reporting
>> errors during the test that I could not reproduce, specifically around
>> being unable to open the packfiles or their pack-indexes.
>>
>> When it fails under SANITIZE=address, it provides the following error:
>>
>> AddressSanitizer:DEADLYSIGNAL
>> =================================================================
>> ==3263517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000027
>> ==3263517==The signal is caused by a READ memory access.
>> ==3263517==Hint: address points to the zero page.
>>     #0 0x562d5d82d1fb in close_pack_windows packfile.c:299
>>     #1 0x562d5d82d3ab in close_pack packfile.c:354
>>     #2 0x562d5d7bfdb4 in write_midx_internal midx-write.c:1490
>>     #3 0x562d5d7c7aec in midx_repack midx-write.c:1795
>>     #4 0x562d5d46fff6 in cmd_multi_pack_index builtin/multi-pack-index.c:305
>>     ...
>>
>> This failure stack trace is disconnected from the real fix because the bad
>> pointers are accessed later when closing the packfiles from the context.
> 
> Okay. So in other words we need to make sure to always prepare the
> MIDX'd packfiles, but we may not want to open them?

Yes. Always prepare. Don't always open (since that loads the .idx).

>> There are a few different aspects to this fix that are worth noting:
>>
>>  1. We return to the previous behavior of fill_packs_from_midx to not
>>     rely on the incremental flag or existence of a preferred pack.
>>
>>  2. The behavior to scan all layers of an incremental midx is kept, so
>>     this is not a full revert of the change.
>>
>>  3. We skip allocating more room in the pack_info array if the pack
>>     fails prepare_midx_pack().
>>
>>  4. The method has always returned 0 for success and 1 for failure, but
>>     the condition checking for error added a check for a negative result
>>     for failure, so that is now updated.
> 
> Nit, feel free to ignore: this change feels like it would make for a
> nice separate commit.

True. I only included it since I was modifying the call anyway due to
the changing parameters.

Thanks,
-Stolee

