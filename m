Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFE32AAC4
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793432; cv=none; b=kimBPKMGkciovfDqoKir230XiuNNm9+BZFC0qN3Ww9Veg4iXhGsg/pwx1TjKRAaYT+zxjJ7kC5iOzPtdcXGNmrHvlsFwJ+fZaFkuUY7mojvNCJykFxeOj1h6RFBncexGWYVp/j+mV3YuplzuHBw150fqlgRiyKbfTnneDEJLbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793432; c=relaxed/simple;
	bh=pgXviGSbpzJ4gHVX5VwISBaBRLwUiB6HxeZUQj+JuTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEzVwqEd0a75Srz7lKU7CK2byzyBFXIGpPahL0fagZaMSf0o/3QQbIQ50sIUGGkOCWmMVtIUtGB2jp10lW37tMm0Kyu0FgPhzY86YrWSO1rckgbAQg6ObwHo9RR2nxb6K5NdhCmG08MY5INVB7440Eo4Qchiyty5V1ivG7Q/nv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN/zNwuc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN/zNwuc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso39741245e9.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765793429; x=1766398229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt37nwi6GFUEVpEduVk777wKL4qObHzJsQ/JO93yoUU=;
        b=LN/zNwucVEmPAR1AerTZFHyNyGsBQZeIWCl3nuHjn+fE+SD/fJGJ7O7mSsODUdCai7
         gGfTtoDjuR5r8GgSxQES0ycN1XyzAce2MiEVvfJNUyaaxND4INHcUjY/ivrGPtvEV7lB
         tR0iWXe1IAQB04HGANr56e3WAHAkgZAmVZiD+VRdsBBZFmAWsUehJLf8h9QR+Af3YpKo
         vbgsAYJZ2mhl8nIqFliqJB56xdJa4cM+Q05DcHg3rqICrCkhnuBrAKEhsDHjkdQqJGVl
         R+ueNsslY6J3u3jXYjEPzR4l+ZlTgv0eT2wVKX1nvq2Faffm07WhYzH68h+wpCPRQR9y
         IQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765793429; x=1766398229;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt37nwi6GFUEVpEduVk777wKL4qObHzJsQ/JO93yoUU=;
        b=dEn9mSbE2UMBpq0+2ksdKC2M6HKyNmF22NbpAV7AACdA+ydfZppbTB7Sp1kTPMarmS
         opBhv6+G2toGs0GHclCUKIN13w6QJhPAqcBf4vk5DXmDAAnULDYcExQd8yU9CvD3GRX2
         jua4zH37lnf2xy7alBxlIZXkw/1hK8quLlpndMEetYcrX3WsX7OfwMslLAAh5+sUD7g3
         Ht7mZG+cumNnWIwYJYAN4i6Riq99lpYoD5ofu1W7Z/FlQmjJumdpyKH604DC0IPJrIqX
         64pL0SQ29nqJVReq8bGJtOl0Rxmpux6+8XBAIJcYOevHHIcDui8Je5sQRr2Vk7BC5QMZ
         cYpg==
X-Forwarded-Encrypted: i=1; AJvYcCW9nJRO/yz6/o6gBiHwp31H/roFIeZpMf5NecJc3y0D0XGk4aVPv7yYoh82k/Ci7W6zDWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bHrsFGFZd5mKPu8nNufak5kr4lS2sa3KHLMp6BwiYfBipnTT
	P81s8gL9xbLtRNEVFeWsadXg4xpVzl5z58/E3I6QVQGH1vGViobr05lj
X-Gm-Gg: AY/fxX65ropyBMOEfVmPV57D/qpxMQ5t1BZIvB7dyakDT5fLtjyl2XBKJJnybTkmRfh
	LO+zhjzxL2bjVw78vmbjjG6i7IT6xugpEAao7dvgmbkYIiUHkJHmU0Rv7qoauR9r8dAk/vnFy1K
	5S/qpmGaIK9lA+W129vtLN69p3rNv2pb2pxL/MYCZg59cvd69frcReXCsjZDfBYpr28WTcKxsLV
	tIzTiKxXCoJij4nYET6b9OxdYyf75WHWOFYjTq7xqDrlGKzuDKgIjsI0ZrCs3ywkZSNtfiabRz7
	1UiYt3ywr3UOLdbotqJghDKUmODF2GzIeZjld+4UxBeFGVDUlShwdRtQDF9WamqeBI77CWiITEy
	YkKlUkIs8G255zFXAfi1vxCOheMZVjwhLiO/YMf7X5N9a38Y5YqGjjrqClj7B30wS5TqyqkMLaH
	iPzV76KNEBFxrWlsAmPRhFFyQdGhPXNOQf+uEdhoBjewi950K9Ri7GkGSuxEzZ924Dcw==
X-Google-Smtp-Source: AGHT+IF5K7Apu2nwRjCX0tWcmk+DN8pfhUjnBItggY9B2vkX9MAd6e2f3yQS07XPogekVGV+Jdgm1w==
X-Received: by 2002:a05:600c:3f18:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-47a992e2ed8mr54828845e9.10.1765793428473;
        Mon, 15 Dec 2025 02:10:28 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6f118esm69074165e9.3.2025.12.15.02.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 02:10:27 -0800 (PST)
Message-ID: <a017e50f-7c8f-461f-8627-2fd1445d29f6@gmail.com>
Date: Mon, 15 Dec 2025 10:10:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] replay: move onto NULL check before first use
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>
References: <3d83161b-ec34-404a-bb0e-bf4da7ac1db5@app.fastmail.com>
 <9db2b913-b5d6-4617-b079-b4612eaa2b97@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <9db2b913-b5d6-4617-b079-b4612eaa2b97@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2025 17:56, René Scharfe wrote:
> cmd_replay() aborts if the pointer "onto" is NULL after argument
> parsing, e.g. when specifying a non-existing commit with --onto.
> 15cd4ef1f4 (replay: make atomic ref updates the default behavior,
> 2025-11-06) added code that dereferences this pointer before the check.
> Switch their places to avoid a segmentation fault.

This fixes the regression nicely. There is a preexisting bug that we 
treat an invalid --onto argument the same as a missing argument but that 
can be fixed separately.

Thanks

Phillip

> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   builtin/replay.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 507b909df7..64ad2f0f04 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -454,6 +454,9 @@ int cmd_replay(int argc,
>   	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
>   			      &onto, &update_refs);
>   
> +	if (!onto) /* FIXME: Should handle replaying down to root commit */
> +		die("Replaying down to root commit is not supported yet!");
> +
>   	/* Build reflog message */
>   	if (advance_name_opt)
>   		strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);
> @@ -472,9 +475,6 @@ int cmd_replay(int argc,
>   		}
>   	}
>   
> -	if (!onto) /* FIXME: Should handle replaying down to root commit */
> -		die("Replaying down to root commit is not supported yet!");
> -
>   	if (prepare_revision_walk(&revs) < 0) {
>   		ret = error(_("error preparing revisions"));
>   		goto cleanup;

