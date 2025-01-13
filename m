Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1B1FBBF0
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787789; cv=none; b=kNH1csWAjk2GwvYf/GuDYniBFuu/w/rJ32f9PVlUsVYZVAIAlVN65jm270T9etJ+kvzK4rqV71vHJ3K0G56m6M+YKBebPGEiKMhQ15YAE0N15Sw/bWqtzdjj02Fb81moxy2dlbXXp1tYvwn2baRejNynLj3sUlUgkIzhoUypMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787789; c=relaxed/simple;
	bh=yhc+pdqn7pXfyjIAKH81UxwidZg6AIs0Ec6iT+gI9sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6dYsNzu8HtCr7t8l/chKz5aintrfwMyDwMVZaP8Ih7LI0ThakZnlbhEEFxoKq4ALG3IhGiHJOTXhfc+clru26EXa3GAiOI7CCfPorY0snjlBi1lC2265ZcENYzt1V/6ngJZipauMdcrZFls4uuVs0ttf0aU6ubhKf49pgC9GiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiBonviP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiBonviP"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso6803199a91.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736787787; x=1737392587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4TE3HxUcQ7MU1+K5sNFIS275Bm75ATzhxc41vUPFFc=;
        b=KiBonviPxdKHxEV5gu981W+D7z3sqaEsV8yBTMDpMIZIlvYRZoUqm+HSlrr2itvfo7
         EworkstPyZ+sE3DpMKisDcIc3X65xwHlcSKC41+VQ2NfwHP2S5eF/CTLL/Mgd+R4DBP9
         CfbS9kYNNSyqiOB9JOgfjW/jtW2Y15XPv+s76XBWuvDQNhpkn2WL0FWPGGZmw3hQuovq
         iH0jiMoZW7jc/I5SFdskhHetdmSNrf14/6B9/JjEYh2MZCn7AmTZiSLWP8aDmOUyFDn3
         Z1KMVDSFF3FlOemnkBs2QZew/0ICHL2an3NxUSF32z9X+WocmHpio25vVVWPW4xc5Ee8
         sXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736787787; x=1737392587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4TE3HxUcQ7MU1+K5sNFIS275Bm75ATzhxc41vUPFFc=;
        b=fYOWF0ONRQTGpppjsxDX8n9lfpbHAluxcjI/PXuFokesYWtAU5iuv9HGmMykRnzL7m
         ztSGDAHgCmKMLA026Hnusl3yuX/NVOLrYjZkElQ0UTlDPu7vciNreHXo1h2fkIEB1lvE
         QuQUPQv6fnCWc9uow30QuXsrqq4vaMhixMzPZl7ZbuUzHvpYPr7aaegRjPJGifAW7Uyp
         DSvvwmYcJKIhfEZHRC+fIFMmZ6hpUsKMvPsouSVS4nTtJozHkANOpwxtV+IuoJTGsE+o
         xDPKRwr/jjpwcFFc4wNNbjDEe6uSBTABjw5NsB4x33ZBolb7Wu0N5TH3m6+EeQLZGu5N
         OW/g==
X-Gm-Message-State: AOJu0YwnuT6bYQUrK93LmneZddq1iulgcjqDUaRkzU6j32hee0t1m46b
	aHqb/CA1p78TCgBDgO1LoAByoQnqSmsJDT47/bZIqmdw+YsxAVjJ
X-Gm-Gg: ASbGncvyvNf7kt7Nk8m4XfrWYNN5heqAWi45OAlOxQLUB5XFeIXwIyNLux0twDulxjb
	CqmKt5uprkg3mfjNnNRUtHskZTQ+ANwz3xdQAcyDpa8gNYFipSejJD0xDclkMIAaRONnwvlPhY6
	FlYcWkgYcoX8uTIlIXGIdEBa5sn+Vafc3u7oCYxyO7H3UDjfQyo6tjqBc+toKcjHDT2GO/RGJbS
	JzL9D96l/A5032Ugu8ExmgqBuPz5Vlc7spmRSYU5ziLv+NkBKKEG4DITC6A4pXi/ly58P0ypE80
	2FCgYbLt38bVIwlRR1A=
X-Google-Smtp-Source: AGHT+IHwlCoa+vwP0r0ndKBYzsw3zkZxknkxBkfP1ngXdAUuttjc7Sj7x78npLk0PwoXGHSzm7hv0Q==
X-Received: by 2002:a17:90b:2590:b0:2ee:9661:eafb with SMTP id 98e67ed59e1d1-2f55838cb0emr24717984a91.12.1736787787208;
        Mon, 13 Jan 2025 09:03:07 -0800 (PST)
Received: from [192.168.1.105] (23-93-96-117.fiber.dynamic.sonic.net. [23.93.96.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f55944ee03sm8132675a91.34.2025.01.13.09.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 09:03:06 -0800 (PST)
Message-ID: <b94df609-372e-4227-8674-a05a67161a15@gmail.com>
Date: Mon, 13 Jan 2025 09:03:05 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using Visual Studio Code to Debug/Trace Git?
To: Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
References: <vlrkbd$a0r$1@ciao.gmane.io>
 <A53D82B2-4F5F-4BCA-9C85-88B2A89139DC@gmail.com> <Z4TJIzVc4Ib2QyPV@pks.im>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <Z4TJIzVc4Ib2QyPV@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/13/25 12:04 AM, Patrick Steinhardt wrote:

> There are two ways to realize what you want right now:
> 
>    - Import the CMake build instructions that we have in
>      "contrib/buildsystems". It has existed for a rather long time, but
>      is not an officially supported way to build Git. It's also lacking a
>      couple of features that you can expect from our Makefile, like
>      building docs. It may be good enough though.
> 
>    - Generate a Visual Studio solution via Meson by installing Meson and
>      then running `meson setup --backend=vs2022 build-msvc`. This has
>      only landed in Git v2.48 and is thus really new. As such it is still
>      marked experimental, but will become an official way to build Git
>      and is more feature complete.
> 
> I'm aware of an issue with Visual Studio right now though when using it
> with Meson that keeps it from working -- I'll send a patch series later
> today to fix that issue, and then it should be a good way to build Git
> on Windows via MSVC.

Thanks for your thoughtful reply. I'll look into what you describe.

In the mean time, I've discovered another method that seems
to be working, for the very limited execution tracing I'm
doing. What I do, on Fedora 41 Workstation, is to build
Git from source using the standard method. This has the side
effect of generating various .h files that themselves aren't
part of the distribution. Then, using Visual Studio Code,
I open the Git source directory, open common-main.c, and then
set a breakpoint at main(). I can then click on Run->Start Debugging
which starts git and breaks at main(). From there I can set whatever
additional breakpoints I want.

This method has allowed me to trace various things but I'm not sure
if it's a complete solution, especially when forking new processes
or using threads. The one very minor problem I've noticed so far
is that the executable file generated by VSC isn't called 'git'.

I welcome corrections or comments.

I hope this helps other people.

Cordially,
Jon Forrest

