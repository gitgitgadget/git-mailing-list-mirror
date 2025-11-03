Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B0314D01
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186837; cv=none; b=DjdU0203PzrjSd3kYIdBzPhNRrsxi6VEdkWkAbRbfb/oCZTRVvI4szk+cujCW1dSEyjSqtWHw6Fs6XrHZkCVuLuRLcZFSlBYfDsOcBeCtmtBptywAxpCc97evtikr2boEn182XUxErdyWKfrOshmKK5jiLF7TceHmLZOP6FUZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186837; c=relaxed/simple;
	bh=aEBOXuK5WZKKVIeWL8fEqe+UYuxWjZrARq2zmAwWO8I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AhRosS1xCuV8ESDDuPtKqUOUJnwB2Rvg3XPcMopYnRBBZ0veLjg+m1CHRczRGqyNrZh8RPu3EQ2nZUpdWAPKMoQbtAcj1G8cwB9UY2aaTkNBz/3oxwH+0KrrE4vIjEF89fsHHTn+AYOdTUY/kMlYGIaBrqcD5fQhQkY52TA84mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATeZMtVo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATeZMtVo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711b95226dso59308645e9.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 08:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186834; x=1762791634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7FtNEsIUiUd96qUmgdcVZMZUfGy9YigVvYNxBpEsvI=;
        b=ATeZMtVoWAKOEuBOsgkbC7B83d5Oi9CInybezBnOzUKJCAU3yKsPw8ywR2Cr4FMISc
         OrNA06QwqQvJY0p6xvsvyVMNQlwNdxfEPZOsCIaekws1KqszjXajwN1xgiHdHrpwKwmk
         PVLvUJsUAQA2Yn9tOlcFG5sTP8AzFI1CjPmlPKHtHBV6KguR2o9Rx/HUPAOfLIl07RQt
         W2bzU63jL/h5zujYO3JMpOSkrPncJhQKZftQ1rFNbyIVk1kANxTHvWgRGxzpLCO/onfn
         wkzwY5Mw5j/veDvMGXiJkN8qcO0C/R3VNZ4/CjF/K++QAmFzU2VFGMlK1bQ29G1zhpl4
         34Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186834; x=1762791634;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7FtNEsIUiUd96qUmgdcVZMZUfGy9YigVvYNxBpEsvI=;
        b=JtxAHajWSTKrHBvX77b/ImhZ5wNIyWSQ8xqIUD6UN2YONSkquK6sJJIKgg87mxcSf5
         LMUVltFwL7evJrlgo4oDEn+ofIHa8NV2oN+OuGzxgWpwhPfGKdoAXvNDhVS3tWQ4j1oB
         4NjbktO7pa/y4HaEj9MUBpxmlID3dfneroX6746GVXuFtn1GHSSaI9wFPjBhBB4dJjLt
         kg8nY2U1fX8VP47cWpuedmggvJQ/PgHKcvBgkLOXPF+xJTMtPQYgCThb764J5OgpeiIk
         2Hiwo4nyYOtj7NV17Fpl0XLxsDdV8HIFx+E5a40E6dpd+3vsQrMawnOsPIkF6D9p6ma7
         qmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5W6mtEX0R/lVdNd9/QuePAaX+xamdn1zlLYcYVN817ukQs3UR8xZrQnAT6Qw8UPUgzwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQCD7+isUsh+SlAFwVFWxd9bjgGlgThxAfw8cI8cXjokMBYHt
	RU+KIzuOW7Vkr3yTJCjymczIA9fXT271OMZ153ERS8K1lDx0RMjOHdb1
X-Gm-Gg: ASbGncvVgr7MYu7wvUyP4TufRcwHvJ/ODIBX5rMil55rc+aOGk+aq2dZzw1EzjkA/7R
	Kd2+uN8ggABmiOWNWjQczVqEmlOTEppYTtTkpoRQM9c+OuSQoB/lh+5vCx9/8kP53q6lxuFy1XJ
	8BjH4qFDbfPdfx5UE/6xoGVe8I6Op0dXmsJ0EfiLX8ymCq3+zz0karJus49hvoMHM7E+sNzhn2b
	ofyDE4FTtWQRe+e4uocScyLPCX4rMo9wXdQ3CaGdWDIzFPCP6bOVpe9lFzbWnKgoSeO5ARUSH1P
	C2ReFvVF9iEBQRQ3eiM4V245BVqh7Hl0YbzmTWKhQmKDXuAeNsbCzCNzNySl4EAb1MqfEan9WuC
	J0kf8MR5nLKEDKNZF59JLu9m4vZgEoN/FtLiUdKtuq+hyWUD4dDKWex80ZGMvd9EJE019lAp3dY
	fvvaxZ80759PWaC2+NAkFh7/saFNAQiCc/KMX6CB9oWxKRoZ0eMpqb+JGpxt/a65M=
X-Google-Smtp-Source: AGHT+IHWT74UcnHT/tG5t/TtPtNWPR2J17veue1q1VfmbGTPTeLy2hrLVE7DPOqK+iIrCI9HaS8nSA==
X-Received: by 2002:a05:600c:a43:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-4773087b051mr118553465e9.21.1762186833501;
        Mon, 03 Nov 2025 08:20:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2ff790sm166402535e9.7.2025.11.03.08.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:20:32 -0800 (PST)
Message-ID: <2405ed1a-8ae7-4b5c-abab-e81c8cd4ad10@gmail.com>
Date: Mon, 3 Nov 2025 16:20:29 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 17/29] tests: t3440: create expect files at point of
 use
To: Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-18-me@linux.beauty>
 <4eb06e60-e088-462b-9f1b-ca800af39b94@app.fastmail.com>
 <199e82ac06b.22809060320824.5985600477588171363@linux.beauty>
 <bdba181a-915b-48d7-8e24-84fd08436576@gmail.com>
 <19a2a5aea22.54000694646975.5864990720344586426@linux.beauty>
Content-Language: en-US
In-Reply-To: <19a2a5aea22.54000694646975.5864990720344586426@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 28/10/2025 10:26, Li Chen wrote:
> 
> I mistakenly misunderstood that you meant changes between each patchset version should be reflected by adding new patches.
> Now I understand that you mean refactoring the original code needs to be reflected in new patches for review. Thank you very
> Thank you for telling me about --color-moved, and I found that git log also has this parameter. This option is very amazing.
>   I will do as you requested in the next version.
> 
> I sincerely apologize for the misunderstanding and wasted time.

Don't worry, I left some more detailled comments on v5 at 
https://lore.kernel.org/git/7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com 
please do feel free to let me know if you have any questions.

Thanks

Phillip

