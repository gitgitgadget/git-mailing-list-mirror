Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6630DD0E
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115868; cv=none; b=J6lalRLxTVWdn0ghvvcKDMdarJhty0GPFCxBLRco7wIUN9Q1sE5eenSGx3abm2nLPgYVaRH5H3+R4EuveIXLy5LOeIYhjSrt9/536+ot5gIOMka0qqNC4BgYKkvOGrSeC7FHWAEQ0xe6T+1GaQrg61dp97StQLOMQ+WCOODVHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115868; c=relaxed/simple;
	bh=GcgK3f2xxKH23mc1kVTVCu2/dHNGMUF9Dlf6EFn1CGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lnVzp4w59smi30InHMs7ZT/G7TqbPyMV/y/wZUftU3sXxNfiAz4MmwFxjl6kXbTx0qRr6gitioz/+GGSyelMH/DBwQa8wxe05NfEk9Y/KiaeF6MiCWN0TGo5MVnvenK7MH2lcwtj5lwOL2aQAFxfmLRuakUO1vWuCTAgF3VSkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDoK3632; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDoK3632"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477775d3728so18305905e9.2
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763115864; x=1763720664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w60cVOttx+8AHsmxxxOpSjz9DVIcZm0ci1r7sAeQZTM=;
        b=dDoK36325chElBl02vvajQOisqBOcyqjrLHsQCTAUuUHbKqe83ijzJzGqaipLmzHMD
         E/i6QycsDbdLAZNILFJ+gk+eefGOY1LMxE0JTra9vTOeZSmKpIhKRmKeL4/MsLargzth
         s9IuD35NR1Bvdj8I/H8YqJW6AW5WGE0x0XDBI+ggDhxt+XLA2ILmNQuUHOL83NNf5uEb
         IV74OBAuPZrLgzD5VKtRa4/Bog09bdEfuwxoeMv0G13VQZVGheAomlHYskswus04EpYk
         CsAE7ntEbWTugUatKXJFAIoUQkCCo7NORpUIB4VdTj60/xKdmaLcXo499TOsipFpEz7X
         jRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763115864; x=1763720664;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w60cVOttx+8AHsmxxxOpSjz9DVIcZm0ci1r7sAeQZTM=;
        b=lPkMFSWjomRRqDt6VAG3D1wo+z1SkOXn4EdJfQdq/40xOFPvotyEYKWSG/Vl9z2uhB
         L8uu/V4QUT/CES1kxVgnEeltPksBO6GwUdV17p/J6xScLPyGyqlr+drI9rkNFUNUL5Gi
         0Qd4t1fN9MpTWj961o8b1p6eV8LsL1vNC5D4JMjXzQmYa/PzVGVwrtXtAfcEtfAELdYH
         heQeV94noqqijPCFv0GxNlPlaVz8fOc+gij+PGg0vAibI6RYeC/E3wSemsJ7wRKIwr02
         IT/RuCb4mbChO0vR2tmqJz1yqMHyough7gLdShXljyGos1lHBq/1CDGBgekg8oSK2ldj
         rcWg==
X-Forwarded-Encrypted: i=1; AJvYcCXEPazZkHjkEhgEU9zl5f7/6oeC1safwC3DGQ460cCuwMNLDqHFf7Do382bC5mVzBYLQvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTkVvaUNLngySlUUGBwkAx6lbqyWvCp9gYXHlIjJ9qxwkBHBM
	0ivzBg6kaVyg1G29QjK+fZ5mEhBUWNelf1x1pf6LY9BhOJ2BiUvNk6lr
X-Gm-Gg: ASbGncuZE+OjE3M7byAeI0PrLlgbTvoRZClAABhlm8ZOcdebeE50opkyZJEuClhEKBQ
	9Zde3skih1ZUrX82gxD98RJpqL1DEkYVLK8rmUcs0as3JD5Jzn55YyC4YquvGsT26g9JQcOuMAF
	zfkwElyF/EiDJKWfwWLk1PIaM88lhZ7FQQgcGNvvLDj+xUOdwzUu/KIZ/mfd8yli19cINTupJ5k
	+zGY7qfdLQu2/aptdCAC3CYKls1s5b8IP9/HE2twGY3I6bxDaSHV0LYPfAHKafZqvofN6yb7K/H
	a67qrCnRGpaDZXi70xEXHuR3+enbMZ0m1BQyiOsWZlREGCh+BiFCYIdn5MqiKhRSlQwVodbtssa
	+x1qUxEPt/kp3GRV7bGOru48mOACW+Pl1ZcMCp/NSpyv+w8z49FWwL0RFHqAEGh7k/rGjqHB4tD
	wDO5VkDJGClzay0DnZ1XoNzkF3BWBk0RR/SuardIfwcizTzvgjVrEe/7jrCmoqlO+WWuWwDnfIs
	up6V4Kgsc2K
X-Google-Smtp-Source: AGHT+IF/GBQivLLrbiM2yk1Rx1hvRRF8Z56nSEaOjKVjREk28wVjtW7jIG+meygefMT2VvD98wnVLA==
X-Received: by 2002:a05:600c:4695:b0:477:7c44:c0bd with SMTP id 5b1f17b1804b1-4778fea8704mr26317055e9.34.1763115863504;
        Fri, 14 Nov 2025 02:24:23 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f21948sm9094375f8f.43.2025.11.14.02.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 02:24:22 -0800 (PST)
Message-ID: <dfdbfb71-2d3f-450e-bbcf-95ecbead3292@gmail.com>
Date: Fri, 14 Nov 2025 10:24:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 00/12] Incomplete lines
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 22:02, Junio C Hamano wrote:
> Changes in v4:
> 
>   - The preliminary clean-up for "git diff" in [04/12] no longer
>     "corrects" the code that updates the line number upon seeing
>     "\ No newline" marker, and leaves it for later series to clean
>     it up as #leftoverbits.

I agree it makes sense to leave the existing increment alone as it's not 
really related to this series.
>   - Our house rule updates in [12/12] now forbids the documentation
>     sources *.adoc to end in an incomplete line.
> 12:  068229790d ! 12:  cb86d9b45f attr: enable incomplete-line whitespace error for this project
>      +-/Documentation/**/*.adoc text eol=lf
>      ++/Documentation/**/*.adoc text eol=lf whitespace=!indent,trail,space,incomplete

Should that be "-indent" c.f. 358e94dc705 (.gitattributes: remove 
misspelled no-op whitespace attribute, 2025-11-11)

Thanks

Phillip

