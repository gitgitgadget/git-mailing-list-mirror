Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56E23CEF8
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671316; cv=none; b=uUsquDWs1aJFJ+ETGVU7ilSU8WO72qyZU/Hb5/doyDm1V/EbB+i5YGDAHOo86d4WxfwZ13jQ0bvxLMEeJ654cNkaUY9xt15fNAsFY4P7u5ONhyrgXE/l+coaehSXSq+q55BMtGJvMfBV0xLP3qBM5tUYHN6jUSyG+LJswdo2U8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671316; c=relaxed/simple;
	bh=UIq4XnEI7M+31TkNWTirWcX8+ZtOyhYE9TjrgXWJR0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDe6o7gCgRP7+NwGVFgBaSqfP4tT/WrlTz1m177Y/0AtL1gDnPfYkfLR9ufquEIt6QZS4akw6FI2zuWmOyXQ5XrYVsfQJ34x2dn7R0WrEoZfyKse6x3AtoEe3BqgZUnONi3YdNt4wicPtAqf39gxInZ+R3lmaEX/FmiR7W6/WAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9nz4I5O; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9nz4I5O"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441ab63a415so41477265e9.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750671313; x=1751276113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m5vQLGXfXQvNNBb/O3cWCpTLTkjcrEffI3x+41wPbh0=;
        b=J9nz4I5OhfitiT+F2jPuhA+2KLg/jP5APtI8tpXzO92KVY1EyKVH7sLFKEILMgaCVm
         0En1J44bg0KbU5NboRJkJ4I9wYRxTEZAcyRDuViYizpaVMZCWUgTfodJf7DxE3cp4mlu
         3MbVqorBjqikdDSbc34/m5IOa1eSjPMTVESroRrFUMA7f2/MX4FdY2PBcmLyxt2yvTcb
         qw9C94q4MHuV1VWORYy/biZ61vWnjw5hFgmVn9ZKtFHybk9d5fyk2VJIKx99EUZ67QbF
         okPOpp4VMEBRdnZLCT2DUguOVTR/ZMFO6tdlNqzTIChGTwuo3vxiCrdSfWkuSlhJeGDn
         4H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750671313; x=1751276113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5vQLGXfXQvNNBb/O3cWCpTLTkjcrEffI3x+41wPbh0=;
        b=ZhkjXB6ZLy76jZmUu/PssvmdQ/yIe42B6KnWtcyAV1wzCAP5qawzqq3MCF+dg49oF7
         dXJF1wqkPE3WevYM00zOpXJJwJrLSTAIy3L1pGVvOAlcMTu0qy5fPVrNUw0ITsg68qS7
         NRJlhNxgW0Wrran8yJbVYck8ZDMcRlUX4x6homDVLJKIbL7iX9AQh2i03fCakQWoLea5
         6N//VeRzot7tuTyvKSGZgKc0zx45VOXlLR1JxPybMcpvbOD2mzD0iG+Ng2+I3S+00QDh
         Qa/B+GT9qjVrvQ6rt3ZW3MYkHn1GHhHRx7TmVEGh6MveIilaYjoMVF4I5hlOqP1bSbFc
         XXtw==
X-Forwarded-Encrypted: i=1; AJvYcCXpIKDolTpWXt8a6Q2ATqQWi6lD/CX3WuW2a5WlF900sYCabxMX1b5ONdHO9vywoBnpw3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwV/hyRNaD15Ib4dp9fdVJ8c31YJTydhg6A+cMGJixP0ZXJLa
	eR7cST5mW9QG7+hbMJ4ujHczu/oJcEys+03aLR32wqt2Qa6POoIZ1Zda
X-Gm-Gg: ASbGncvV5l5XMjJm2lw1cqkz7bMkDLhJQXBKyBRTRfENSZRWf8m+TXNv1zH2q7s46dW
	z1HwOu6wii/sOlgu/Slmc5ZYUyLHzE3AGpzicux9tsbmn4oYWi0D12rarZcJurQaG8YqFW00YVN
	/PyN/viUTuEIymGgkg8SNNrJ1DBAicnQ4Fh4+GhxJmWvQYkiUEutYEQbINLJnYRV1uqMoKp/y1g
	Pes2gtMeGt2bnulYpYv6LrtqK5cdbT5Mcg1iwv3Q8gONrlIisWrg/ihPLvTRT838OwlA1/BMiJa
	flAEelaIzlmvzoCaUSoxQB2pfUVaj5dwW3QjKjYCNPKufHcQSyEHDNIF4Q/tqDUu7E7Zxib7xn2
	3jThHCvh1StlMjvoVyCKIHL6tRJsDdz33nIXyubxELq935NDC
X-Google-Smtp-Source: AGHT+IGodfg1Rq1XAlPwEbWumVrRGfqCuuNcLdMX2Omwdk1YjONt3Oez/AAetJf3EhSzf3LlcQr+6A==
X-Received: by 2002:a05:600c:8b07:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-453653cc952mr98912555e9.6.1750671313119;
        Mon, 23 Jun 2025 02:35:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d128cf7asm8862624f8f.100.2025.06.23.02.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:35:12 -0700 (PDT)
Message-ID: <14cc73ba-3e6a-4994-b966-a5a09dd042f9@gmail.com>
Date: Mon, 23 Jun 2025 10:35:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Ensure restore_term works correctly with DUPLEX
To: James Duley via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: James Duley <jagduley@gmail.com>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James

On 17/06/2025 19:56, James Duley via GitGitGadget wrote:
> From: James Duley <jagduley@gmail.com>
> 
> Previously, if save_term/restore_term was called with the DUPLEX flag
> and then without the flag, an assertion was hit.
>> Assertion failed: hconout != INVALID_HANDLE_VALUE,
>> file compat/terminal.c, line 283
> 
> This is because save_term doesn't set cmode_out when not DUPLEX,
> so an old version of cmode_out was being used.
> Therefore, hconout is the correct thing for restore to check
> to decide whether to restore stdout console mode.

I found this paragraph (especially the first sentence) rather hard to 
understand - it was only after I'd figured out what the problem was by 
reading the code that I could understand what it was saying.

As I understand it the problem is caused by calling

     save_term(SAVE_TERM_DUPLEX);
     restore_term();
     save_term(0);
     restore_term();

The first call to save_term() sets hconout to a valid handle and 
cmode_out to a non-zero value. The first call to restore_term() then 
sets hconout to INVALID_HANDLE_VALUE but leaves cmode_out unchanged. The 
second call to save_term does not touch hconout or cmode_out. The second 
call to restore_term() then hits the assertion because cmode_out is 
non-zero but hconout is an invalid handle.

I think it would be helpful to include an explanation like that in the 
commit message.

I agree with you diagnosis and the proposed fix - using the filehandle 
to tell whether we should restore the output settings is much cleaner 
that looking at the mode. I would suggest that we should also set 
hconout to INVALID_HANDLE_VALUE when save_term() is called without 
SAVE_TERM_DUPLEX to avoid any problems with call sequences like

     save_term(SAVE_TERM_DUPLEX);
     save_term(0);
     restore_term();

Thanks for reporting and working on this

Phillip

> I saw this on Windows with interactive.singleKey when doing `git add -p`.
> Specifically, after hitting `e` to edit in vim, once on to the prompt
> for the next hunk, pressing any key results in the assertion.
> 
> Signed-off-by: James Duley <jagduley@gmail.com>
> ---
>      Ensure restore_term works correctly with DUPLEX
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2000%2Fparched%2Frestore-term-windows-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2000/parched/restore-term-windows-fix-v1
> Pull-Request: https://github.com/git/git/pull/2000
> 
>   compat/terminal.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 584f27bf7e1..72b184555ff 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -279,8 +279,7 @@ void restore_term(void)
>   
>   	SetConsoleMode(hconin, cmode_in);
>   	CloseHandle(hconin);
> -	if (cmode_out) {
> -		assert(hconout != INVALID_HANDLE_VALUE);
> +	if (hconout != INVALID_HANDLE_VALUE) {
>   		SetConsoleMode(hconout, cmode_out);
>   		CloseHandle(hconout);
>   	}
> 
> base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77



