Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01778149DFF
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402890; cv=none; b=VKjWImxFad3OpmcZhTNXdhjGR8tjpvxPCGx+NQdjm1lop3Rxi8PDbMCei+293K17+EuCodQOufdsfhyRxCbjoUP3uuuzL2qlOuMALeVDDfu6x6nDgJVo+F+ZUZyjOXzmDZTJy5yT2t3wfJqah9i9I708MKX4Y7Lu2BPrnzPS61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402890; c=relaxed/simple;
	bh=YaBG1/EHxo0ubriv08upHFGxPGXblqhLOkbQUdo67To=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MgYKzhtVdfGIO0emTvUM3RBAdaxtsT+8SRsS3C5v2fs7swc0FdP6wkarUKB6ZYUoL5O5iXS+CA135DkQF/iIJl6mlinwP7em7oLGGqc49RiMSZYAQ1z9dWo4rT3LzYq516lmYwS7cEW/vUmnHRR5FMuCVhGfoqLTh+2rzytfao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZiNdpgW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZiNdpgW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410504b5cf3so1386105e9.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 06:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707402887; x=1708007687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HL84aIpMD9KS11YIhe2lF3IGJPTL2+UMvXD8tEGlt34=;
        b=HZiNdpgW2AFQySJkziHUB6huBcuHicaOwMsmnv5G1lGPMHTenUih+GP8O/jhk7CA+q
         6dJExgCCK7fy8s63Hu4CBv4FJIcrn+7M04DjFe2ioUVy321b366FHAf3v0EQ2i+a+tYK
         sD+XDjzDR06lbgGXXPCoKL96AKfuNxDAR6bSydgwqizbzj+KSZN73tevqcwGcxh+vws3
         eaxsA1vOJM/ULsN2I+MkDqwtAN44FAr8sx4SSJh86kl4vuSWZfHWjJPRMPVJPBJzAIrM
         vyWXMsb0i3EndydnJ0lZl4VESsd873T2i0xVGZj4BtXQ1racr/2m0bXRZEUWYpYSTowp
         dQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707402887; x=1708007687;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HL84aIpMD9KS11YIhe2lF3IGJPTL2+UMvXD8tEGlt34=;
        b=mfXs9vRuabhj5GDk78qxKtDC4qpdSVqfxJP1bcm3qFEyTBHgw5ZkKPzhlGQn0p2zi/
         ks0jLd+ezJ70+ygWt193l/ZOxTAv/y4vmwfBM76jUcxBbyTsDlGV9DBAfNeNKLkE0kUc
         W4fc5Ck5PjvgaId35RyVGjJ4/zovsw6nWgjRtpEMQhsTyJGiemWIW42MrDflEsUH14z3
         3cCYOnHrhzmfBrZP2qiMNaXI7P1U2A4JlzR/HdPfFW2X8nFL4rF+MhD9yU6/W0rRQze5
         HrGy/ViAiRtMjMFSGZqA/nqBvsCbxtebYfeDCx7HsZjQpV2NMxYlgqgWM+YvHpcg86zf
         54vQ==
X-Gm-Message-State: AOJu0YxR1TGie1KxPmTu4wgacYPN3/Lk1BaL3Mk/VVA42I+hQU+HE/N/
	MInOL6aFPsvgQofnvtyErAv7XeAAcIWFqfZCbqWRYiNZTXx0k6C5
X-Google-Smtp-Source: AGHT+IFoF7Px2orl+lzOZWGPjwOUkLRD8XiSLPLvoMmfOefGRRO35RUWANRJr22iFw7ckIBg7GQPhw==
X-Received: by 2002:a05:600c:190e:b0:40f:c655:abd2 with SMTP id j14-20020a05600c190e00b0040fc655abd2mr7073703wmq.19.1707402886999;
        Thu, 08 Feb 2024 06:34:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUh0bUmTvv9Ktb56dYzDGyENgRHOmoNeJ3e5lloB8xRf/7gwKrGfLkhNYeZNx+iCBpa00XscCds2IsVocP+1Dd1gi5BqWm3qOD2gws4dcWG66K+PghE7PadVaG89cMOj/nDIdAknlNB9doUqe1J
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c4ed300b0040fb783ad93sm1807542wmq.48.2024.02.08.06.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 06:34:46 -0800 (PST)
Message-ID: <e137c365-13c6-4ae3-aaf8-0b9d7852e508@gmail.com>
Date: Thu, 8 Feb 2024 14:34:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] show-ref --verify: accept pseudorefs
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
 <4dedc5704c3af6ab4ec8cc7503dc826480775b8e.1707324277.git.gitgitgadget@gmail.com>
 <xmqq5xz0b3lu.fsf@gitster.g>
In-Reply-To: <xmqq5xz0b3lu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 07/02/2024 17:12, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> I think the helper you picked is the most sensible one, modulo a few
> nits.
> 
>   - We would want to teach refname_is_safe() to honor is_pseudoref()
>     from Karthik's series to make rules more consistent.

Yes, I held off sending this series waiting for a while but then got 
impatient. We may want to split out a helper from is_pseudoref() that 
just checks the name without trying to read the ref for callers like 
this which are going to read the ref anyway.

>   - The refname_is_safe() helper is not just about the stuff at the
>     root level.  While starts_with("refs/") is overly lenient, it
>     rejects nonsense like "refs/../trash".  We would want to lose
>     "starts_with() ||" part of the condition from here.

I left the "starts_with()" in as we check the refname when we look it up 
with read_ref() so it seemed like wasted effort to do it here as well.

> These are minor non-blocking nits that we should keep in mind only
> for longer term maintenance, #leftoverbits after the dust settles.
 >
> Will queue.

Thanks

Phillip
