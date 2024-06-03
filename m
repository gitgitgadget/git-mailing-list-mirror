Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CC1E504
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423988; cv=none; b=rHBtkbRPmMdJaMpi2O6U7XEXb5j5DGeE6x9FhjV+UMb1PHv0qAMEgYsGpLXR1w5/Y6ALYF63aosJ7QLUMFdqJ6a/Fz1oIoHBth0LRim9nvklUsQGh0tDHEHudVMb35tVjKetEI+kx0J1Km0rxB+gNu2S+3RuWgr3h/RNwAMiAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423988; c=relaxed/simple;
	bh=Xg8BIYK8eNHgTg0ytNJYTrBI8NcGUTp5gmN5FigB/DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/uLLam5oM1EZI8WOktqhhBSEPcwTcvJt4i3B0oJ4dfHNp+Tev+CfzCP/QQSIcCu90Ql651ygIVqWmFMI9frU201RwbO2Vv7HpMqhJQ8eRS5veVrRyR19bluM2rUZhbqJIx5Vk65AuExhzbFI8DNfmXMwqO29qkuB1MpuV6IbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKyrbV3T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKyrbV3T"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42134bb9677so27408825e9.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717423985; x=1718028785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8VZVX0Sj2lK2zl7O1uwM7llOFXYMbYPjKIJ5FT0yRyQ=;
        b=QKyrbV3TBdEHhuzQ+xwgma7ivPWd1sYsIW1s9FIS8h82L/GKus3ZD9L4JbbZHNFl9l
         PpH39g2ch4toeotOwUhS738ZFtoiuwtbaBo2oL5NheLrTx5tek/lTxTCarlD2aMySP6G
         6AJ1e6iWdpwFgMVwITKC3UW76CpXYBgBlvluRK9GJOWC7QScf8pvzxwJ7ufHu/44RZ6B
         vdo/h428K4GEtVRkq/m2Deo8lXqTIeuXGWnHMc+DBwSeAvmx+WmGlvSSf152GNz4Fi7k
         qsBHH6Ro7FS87p6BoActeAczCy7j0W+eFwJSshKkPqYsMrSoCPNuyEpUwHJBEQ1FPVYV
         MfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423985; x=1718028785;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VZVX0Sj2lK2zl7O1uwM7llOFXYMbYPjKIJ5FT0yRyQ=;
        b=sY/yehWKtZdinLGCflgDiA5zeMKu7RQY6gvyct/3Q2xbBj3MQdHyYvxS9zjSG/pQ18
         reM5jUtWhVhLaV4urDQXgixo4ESZtnwwDDZAiUgVytYHMF644edtUlS7BwNKt80Lf0U7
         bar6Oua5A3YaAaoIelW0JvRGinha/V1MCn3t/pCWihOX7khvNFv7NlfcB4Hz5jKoqY1M
         yH6tyFDY9MRQ90ZVe0dku7lMJ8pZ2E0NgR+A2EztU38AaFKVjj7XsuWJQT8yZP+hS8xb
         vebpHhOlRRbOpNbJgFeVqOGlyJidbYBSjoDMzSLOgftw2Gzy7iKOeG5XsxBhZfkl0uAn
         laRg==
X-Gm-Message-State: AOJu0YyemaoUjrVRhtF+pPiCZ4lnQRTuXch1SQJfBCndgDGP3fU/J/q7
	0NtfUwcehVOZ6Wo96M8QWWEZQEm5G+GCgMvE8qTcB8FfaRjLBM5afkC+aw==
X-Google-Smtp-Source: AGHT+IF7hXEjeayKQbQcqK9kl3cr3DJjQilS6a1phbgQmKkPmn0s6pEch+SkqjWJt7v+7Y4EG6LPDg==
X-Received: by 2002:a05:600c:5012:b0:421:29cd:5c95 with SMTP id 5b1f17b1804b1-4212e04ffccmr110478875e9.10.1717423984568;
        Mon, 03 Jun 2024 07:13:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212c0fb782sm117800845e9.24.2024.06.03.07.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 07:13:04 -0700 (PDT)
Message-ID: <67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
Date: Mon, 3 Jun 2024 15:13:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
To: darcy <acednes@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <xmqqwmn66zzc.fsf@gitster.g> <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi darcy

On 03/06/2024 12:44, darcy wrote:
>> Do we also want to check for overflows in the other direction (a large 
>> timestamp with a negative timezone offset)?
> 
> Is this something people want added? I am happy to implement this if
> so, though it wasn't my original intention.

I think if we're worried about the date overflowing in one direction it 
makes sense to fix overflows in the other direction at the same time 
especially as I think that the other case involves a signed integer 
overflow which is undefined behavior in C.

Best Wishes

Phillip
