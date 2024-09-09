Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4F12B143
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898077; cv=none; b=jrTRpKFEsPpPegZlbvA5u1SCXd+0fdBs2VFAKSLaJlIRGu5AM++MY0SNh/zxlsoJRFZM4IWs2NXnabqBritGxhqtBluEPs/nHnqmZDpSBR47FG898O0eBbrtbYW0TG5b7Q4WQ5/FtTo4aQ9T5wiGr54uU8jS6buhyDfaCPPM95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898077; c=relaxed/simple;
	bh=ia4AObRwPaTUNAjLyP1stzfh/vi+qFwXjiV8HjdYwn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXadG3rR+1J2MhO8E8xZaD+h/n23x9dZOIyP/fXuehW1gNHl6r0zmuLhOaARnoiroc2k3sXobVSw2D/l6YiE0UwFJcltq0vMRz6tMRMadgP8vaOn5xqGcXoR7wSspYpeUQecuo0xQ+k+VwL0yPEcSaiYDXTRQPQTX7x3CS3o82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLsB8GGo; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLsB8GGo"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e037b80140so1144382b6e.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725898075; x=1726502875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uc02A3ZxN7pFX/zL1d88FWJmBpbAz/ma/taTKykMXOQ=;
        b=hLsB8GGo6zQ7CXmgF3TYdmACgeVEv/iSmyGcfkDxpY+BJ5xJEc8se+4d1aS7rIVjgm
         Ig8SzD5COEOqlkCQ+2WU6eGdUhnAuQu9Z2KmZz/NS0Uee0bfNubaX7Og2VNOQkBfIWIp
         ERRSUZo7LGEP7xCJQI7lj+1Ov6KQ4F2anDR5vBWZv7ENePN0y34sMI8JrhhylgV01P0v
         C0kMwaUCWwulN0liKneEQsqMmlYVSs/7UpEfWvz5NdiNj7wn/CqQTro0xcPmDxBkQt+m
         WW6ztbEacc/1cFmnab0RboIVLoa/ZG93pGnKYbvwybi3gnBlxjarIH1vZ5+ygy6Snlxp
         YGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898075; x=1726502875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc02A3ZxN7pFX/zL1d88FWJmBpbAz/ma/taTKykMXOQ=;
        b=FL1uNC3OD+LkB6HVwjQNIJWJIzH7o5qVG9fqeZt96FNNZ6UlRszp3XKnk7Pw69j5uf
         DvicwatfBJlO9z8UID6APh65kWfrjgj38ooWcn/GUQFeb8/SpOsrXw29csRqx0LuynT4
         kFdv03RzOQ7um3dObHM8NjSuyKooko12JdcugUKX3R+lmHoWyGBJ3ygPesHLnxulbOLK
         vbSfm/mFfrx6nbo9fFf7Kmi0l+H+P6jGPhVIzD1metKgj9aPv/GyXb/s/4+1BpplfyXf
         bAGMzeVhtROBTf/9Lae93t2u2aovQ4hQQrCJznCCNtubImQU6j33O1DQB5h0z2ztCM1Q
         HIzw==
X-Forwarded-Encrypted: i=1; AJvYcCUVmNzvrbdvApYFhI20zdrpUJ/JZ3xBxb2dvB2hZzBnAzDLtS8PU+6lLMqGFpetEO1jND0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIdjgZT57X9FTpsx8Btotx6y+sW45mYpOBXkXd/VwiWjtZ2w2
	gOvp/UaJOuNF/MwF/YIYYPdtTKVeckw5tpM8S24sNajlPGoC5F8jmF++9g==
X-Google-Smtp-Source: AGHT+IErdercHP+Vo0PTYKulBz8ioCe/BtMVQFDFPkW1cuJiA90WTtnrkeVJT6eu0RveC2718wTz/g==
X-Received: by 2002:a05:6808:3020:b0:3e0:1222:b1b9 with SMTP id 5614622812f47-3e0373b6f49mr8611030b6e.21.1725898075246;
        Mon, 09 Sep 2024 09:07:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e039b7c4d5sm1192501b6e.31.2024.09.09.09.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 09:07:54 -0700 (PDT)
Message-ID: <86acb6f7-f1cd-499e-b95c-6cad4ff93863@gmail.com>
Date: Mon, 9 Sep 2024 12:07:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 9:56 AM, Derrick Stolee via GitGitGadget wrote:

> However, my findings show that when a repository has many versions of files
> at the same path (and especially when there are many name-hash collisions)
> then there are significant gains to be made using the new algorithm.

Of course this table didn't render correctly. Here's a readable version:

| Repo     | Standard Repack | With --full-name-hash |
|----------|-----------------|-----------------------|
| fluentui |         438 MB  |               168 MB  |
| Repo B   |       6,255 MB  |               829 MB  |
| Repo C   |      37,737 MB  |             7,125 MB  |
| Repo D   |     130,049 MB  |             6,190 MB  |

Thanks,
-Stolee

