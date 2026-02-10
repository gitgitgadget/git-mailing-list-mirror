Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99112328B6E
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770697506; cv=none; b=Lk79lBKe+4P8HTA9SJV9s7xfOMttjlRV5TgifiaPbXDZK+Zo5wc6jMYK228vpuG10BbkUvtvK2OcBH1ScNeWKFr9KiBQL+1gxwk8UtzSubae21tVzXsxTvG9EbmhhbOiRaMP5dRIgZVeEpi4NDYh6lfO7GqKpzpyjGXP/a1K6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770697506; c=relaxed/simple;
	bh=f0tlZSag1DZSyj8mWI7SasFPOTj5bZM6ZIyCXQOVWh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZByDZICJjOmxzYBfq+KAtt4vBx9hG5LvsXBZqZlhaRNLNv3CV7tO8ICWaOu58jcXMJKWYiWrUmXeCxj3dLhubBlVDtSpYoLDat25cvS2xfg2M0wA3vw3mo17jjvO0pCznVFzYfcIEWTkFRde2NGo1yqlyKlLd+uVcfSA8rkCODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYQROaM8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYQROaM8"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-896f8feee14so21749706d6.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770697504; x=1771302304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTuP7OSGr2+DG3r2P7M7GMFbAJvOdqVB6tcAeokWtSU=;
        b=OYQROaM8SD7cgi49qzVTcK0nuN2RRxenK8uXIkaU3T4QN37vpfaEwclfIeKHGI8jdg
         +Jgdtc+UouJ2Hbqc3fvyL3o89OCA5S8xcvMWV9iIH99SAHkL6UnQjI4gOCfxAT0teE0b
         AGGS+yalAn4Qnh29QHFXJB0Lw4M4mlvdlzqnmhoIn1uUAR9mMoBnk+K53C3sATlt4FQy
         UMr28cHQg5uGaWCd57FLWhWjRJWo69sMq0BNo4FaRRo1vF7PpvMENlLVAZA1nYmFJvJI
         yOskhAXJlR87lgfkKN+d0ql4qfqi3PSQub1nAFOj+0MgHiGUOcR5QFEOo31mmFh2iTSF
         pfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770697504; x=1771302304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTuP7OSGr2+DG3r2P7M7GMFbAJvOdqVB6tcAeokWtSU=;
        b=mdJPsOwaD5R4fH6GIxq9dZvqU3CVMIxnpuOmpzsbYkFzKvehIJ754empjuYAPV96mu
         p7W8MiQxgGQc0MaNUabrBrlWajm3zdcg9NM2UWIgKlBnRdhTGB7UaXy2ZtEB58LSDpfJ
         sAL0AIdtKy1+ZtInN3ERBX80CJ9hMJXZhIiXGhwcTGmHZypFxTMzuD3inSBuFTXL2BFe
         Kj8MHddAf6onAvRdAyfXH6VVqZn7vuY7omH+xQFCpk4rdyogBZQHuVSg6+sh5PUEn7Iz
         0oiASSVldVQv6j766tUtPMZrtBwLZRUGVH8/sg1qcCXsnSpJgUKSK6rOxiRDl77UHS9I
         HlMg==
X-Forwarded-Encrypted: i=1; AJvYcCUf/atbM1BWD2z+fSGOZMAbo2779EQEvBd6BjFACrRLflOH8scyIdVvvw9VsLvZxldmtxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJw2Rn8oXYmD4p9PVzLz2ngJU81Xr80twuRggxLmDXOYgEkEk
	TtuWwQhHovGyUOHSRp2Ymm2oP3BOLGJUt8Wk/ff3B5Ub6wGPov1FXESA
X-Gm-Gg: AZuq6aJPTQHjzMIA+7tH2o5saZq1fiEmXToifd/mTN3BLD47DRoGpmqe4Z5hn+/fj6e
	z7wHUNXP3pnZLRQTNpBnsKxdtaK8MENjJVsLDmxHXpty6j850oNfgqm4wcNUbloH1xpN0w/qmjq
	NpWOMaiBm06NpY14DAIq0BPt7cIZxZ5vyaYmJE3vLdDT5j9EHA6PchiB6oEPMyAiU0klpKxcT4K
	0hP5IQlDv9LXlAjpwzf9eKcNLGWjDGTC5wZcLxRZTUNzRyEIoYaXR8LtJd/ezRWDNMZVQ7q1Iq6
	sY6uAOOcyWxdHf75RhXGWQyCsx0TpmlqvB4WdZdfs8sRDBbcq3I5sDrKOE8Tq+O6neYr2b6vAW8
	yo5mOsQrwhNaXnNBD6XeRcaDsMqPRgcYxwW/Fw25SDA8Jk7ewwanFYe9FNitmB3kwOlTZpLfmmR
	xq0ZdumhfQ90y5QLVrtEzXMBZ8MtK9dxAeYCWxvzX6eTCV1X+L6QfXeihEWU5m2AbfOtpHKg==
X-Received: by 2002:a05:6214:c23:b0:894:71b0:6b11 with SMTP id 6a1803df08f44-8970e2236fcmr11519926d6.14.1770697504486;
        Mon, 09 Feb 2026 20:25:04 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf37b9asm93875416d6.9.2026.02.09.20.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 20:25:03 -0800 (PST)
Message-ID: <3455bd60-abe4-429b-b684-340a713d0b13@gmail.com>
Date: Mon, 9 Feb 2026 23:25:03 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] config-batch: add 'set' v1 command
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
 <1cb68e4f-930d-456d-ba1b-b153e7a66524@app.fastmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <1cb68e4f-930d-456d-ba1b-b153e7a66524@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/5/2026 2:01 PM, Kristoffer Haugsbakk wrote:
> On Wed, Feb 4, 2026, at 15:20, Derrick Stolee via GitGitGadget wrote:
>> [snip]
>> +`set` version 1::
>> +	The `set` command writes a single key-value pair to a config
>> +	file. It specifies which file by a `<scope>` parameter from
>> +	among `system`, `global`, `local`, and `worktree`. The `<key>`
>> +	is the next positional argument. The remaining data in the line
>> +	is provided as the `<value>` to assign the config.
>> ++
>> +------------
>> +set 1 <scope> <key> <value>
>> +------------
>> ++
>> +These uses will match the behavior of `git config --set --<scope> <key>
> 
> `--set` doesn’t exist. I think you meant `set`.

You're right. Also `git config --<scope> <key>` is the older mode. I'm
not always catching myself using the old format. Or inventing a mixed-up
one that never existed!

> Is there support for a user-provided file? (`git config --file=...`)

Not at the moment. It's worth thinking about what that interface would
be within this query model.

My initial feeling is that we wouldn't want to accept arbitrary filenames
on a per-command basis, but instead would want to provide an alternate
file in the command-line arguments as a replacement for the local config.

Thanks,
-Stolee

