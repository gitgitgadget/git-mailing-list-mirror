Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE41DFFC
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833158; cv=none; b=JkrOYHZl/35gLzbSGxVS4+148k5EBWfHbg+4CNOoQEaYJpQ56B8kkjPkkZ7t5jHq2/+Mf+ezKNEdepjRxQlHh0OgfTKPE9AIZZAqL9qTJwzLn05uMyp68nDYSD/9gyVNTZ2G4Vq3uvRnuSZ/WbCaMP4kb25Tmx2XuPVNZ4pCpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833158; c=relaxed/simple;
	bh=Kqb+N4opoU30vJbs4Aqj5obg5PB4tQKRjq9OrBOFbeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/ZCv2vISqxzDtccLDta2Cu7SuDx7eJWrBU33XKxj2xaOymnU8sYdpuWILiSFjqSxYIPgfPjV1BST/Pna3mqHPc5Kr4cs7vixA8aOnbjQ1rKFy+v58rLW7Trv1oYLEYo6EG2uQietiEgGMnR4hJDKffoGortBkUsu12KoGyYSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iijTX2/5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iijTX2/5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4311bb9d4beso20481915e9.3
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728833155; x=1729437955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dYjXa5Uor/9rrSnskJolayJ0tapnjV8NzsKjAVTa3OA=;
        b=iijTX2/5W6ZPmZC63q5ialxtV20DPAtbHVcxAnmWDWHK1/deAc9K7cGTmN8IdfX96H
         D/M5+CjQYxHfJo8o5HfAjesf9o/XUhEwnenGy/td/kMyWzbdmOIHMcoyBGSC9l4qOHna
         xDuVl+QoYIW/A3s35JuZ8/w6V405+9E76wWl/gsI4maiC8kwrgRyxLEEjNao3Sy+2mYw
         vmOfdoGtN/W7y1DLChxGyw5ExegbPNEYMW3NTBR+FZrpFNY2blf+BtlsNB5cJ5DKBKYs
         zWYRX0h6DxqR21XPGWx76Uxm1YeqS+4Tn4Q49FLb50+gw5mXpy4PsUJg7Z01kiW+MJKg
         0u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728833155; x=1729437955;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYjXa5Uor/9rrSnskJolayJ0tapnjV8NzsKjAVTa3OA=;
        b=pEZasb+fOpL2YCtu3mEKiAuqqvXRVzSOPT1WbE3/svN2HDvrIiNvK6TxjE3isQdf4c
         66ccVJf/4AHyHMD9kcbPTlIbx782PElOHpxC7O4FtX13Q97bxUplUJN9Bci9sQ71W9Vr
         Lk5zBOsZuqod6+jiRkv+SKqWtCqZxRTAsaee6Zq0B8lPw0Ym2Yf1e287oTWWHTitxq8c
         99BxhKaOVd6LUhDRKh51bP98Ud679g46Q478H7cyw9RqvfaIOgnSFv+JLJMtMi/07MTe
         zReS/O4++jbLA55vL++kWhxViBeMil6008ohe9IIwgBHHZeYi/szh1kOiTqxNjMU5lgo
         dNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxDvpF155faADO0Ojcz9HVppMft4CFqst8+DiCMB4N4yjEdL9xpDMKwJqUn5eqeKfEHI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoi4329dQgARjWLRj4E8WOaGtYzyiBNnPZSD+2818YPiMNjHP
	Ojf1rtKFk12vz9bmwQrv9+snQEMlQOCxj2tpY2tS2cJDmIJje8IB
X-Google-Smtp-Source: AGHT+IFgWvq+AmGpG88JKPKb5gFbee0VLC5jkrKAEdZqF2/+vG5w16xoEighLovLAS6sh555N5n5PQ==
X-Received: by 2002:a5d:68c8:0:b0:37d:51bc:3229 with SMTP id ffacd0b85a97d-37d5ffa1a2fmr2800486f8f.51.1728833154467;
        Sun, 13 Oct 2024 08:25:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0071sm8831732f8f.62.2024.10.13.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 08:25:54 -0700 (PDT)
Message-ID: <98261da2-c8a6-4ae2-b62d-323093f94bfb@gmail.com>
Date: Sun, 13 Oct 2024 16:25:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs
 automatically
To: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
 Abhijeetsingh Meena <abhijeet040403@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
 <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <4f835282-d921-4cd3-9680-d8522bef7b39@app.fastmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4f835282-d921-4cd3-9680-d8522bef7b39@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 12/10/2024 14:58, Kristoffer Haugsbakk wrote:
> Hi Abhijeetsingh
> 
> Maybe this is totally off-topic but I think it would make more sense if
> `blame.ignoreRevsFile` just didn’t say anything if it didn’t find the
> file.  Because the point of the config might be to opt-in to this file
> for those projects that does have it.

See https://lore.kernel.org/git/xmqqr1f5hszw.fsf@gitster.g/ for some 
discussion about this

Best Wishes

Phillip

