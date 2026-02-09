Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9903793DB
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647849; cv=none; b=H6Uz9vM3rvU7t8LP8XpNkV9FIKZNSiWpwDLHYoGnai7bsfpK6EVL8ge7Psw4t1Tijoo5ruw4J2qU9rfXHuZ2MgcJ7BERAc1cXvH/uRjq5B2f/U1/r8RW3GsXyz/5ADUn11aGdC/DSM4v4EtH+rfOmwxDEB8wUA+PSwZcZiylMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647849; c=relaxed/simple;
	bh=r51x377mQXz/YVUPRRTSYTSARbzVlDIzDsyNkei1s20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmgCkfg2RR7o8XEww+JIev+33jvyFNQW8LzaXaR+1DT///VqpmoMSc1g+YOSYsgj7uZl7KMygyVHCwOdPC/T4RMBzfzJW8IPfWhnqfIRLAzmt0z2s9YlALqjofbt+e9Ix2z9oZZ4CZU4tZAH4HGF3FlIDE/iA1bTBOvk9dsoSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt4hHf5W; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt4hHf5W"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8954c9daaeaso28573886d6.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 06:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770647848; x=1771252648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Td/syo6zBi5WlrNDONNBZaZNUQFCqzYfphguzj86Tvo=;
        b=Qt4hHf5WgNeeIWn8JRCnJLzRA/ULZmUmTyz8N93kpMACFFpK+IkjB6bBcOh3tUk/nr
         BJazHg+xWZ2RM/EzrEW6bJbq0bO24KS13PdWqGO0So+aFnNJgGYCj6lN26AKy2RQK55k
         3J3/MUSI/K40ehijDT2YHfVrbGQuuE+kGi0CLDzQ7szoqpvNj7gPh4PDbqRYzJeapd/0
         1Yz+Ob8Ggpl6srAo9xx1dpmQMEb7CF1op3cLabijAOl93OwbsFiundBrNoF1zL1S5g7u
         TsFE/Px+8oITTSfIDNyhp9krmuId8dFhioaI+TXBz4cdVf61ITD0iDkrihy8QGfZzu5b
         +RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770647848; x=1771252648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td/syo6zBi5WlrNDONNBZaZNUQFCqzYfphguzj86Tvo=;
        b=eDwWgA4NO/tPefY3DN7GHl5rw70DyBQRKYtKU/WQAXynfLCbvlATsqpygnUqH3+oeH
         +ZI2jE8jQ2QP2O6ze/2FRthFkxsEib1MQzjVhqIlh1c9o6YrilEgQbykneEymGe6YB9e
         3vgWi9z8dHCOlakyR8NquHfxojrSC/90Dh4q4nmLAAGGZuvKHQZbmFYy3dgquK1UmJj8
         dVbDY79g0S306vY5tYL6y0zn2LmgCqo7G1Dfpsd3fFv/QIS6z6LsBkdvJUKdhI468eYh
         vFiAcpyFHQgXEz1G1WecigP2UA4rLdiiLFLUwaKyqLPHGNKV1AmgyBXL5s1LHIuYiQJ4
         bv1g==
X-Forwarded-Encrypted: i=1; AJvYcCUup3ieJkOVzs3fX/eeuAxKBg9/Vx0aJ9rw6qhGkLpnoPmtyItEBgEfwxWQrqAKVh5kIhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/h0mZcEFKtAO2McYeGDpr7LFGcQOYo7pBqtlo4KbVVwS0kbI
	3K4XjzNjQ8Y2wrhYko3SB1RdhjmmFk9fqp5DQMJfROIgVYEtTW8ZdV8U
X-Gm-Gg: AZuq6aK1b1R8+H0XdxFH8TJVHNgqH51XFs9vXZYVgLJj9srsIOkXpuHythcYKChIKaZ
	lU7taKOfgPXg86FCC037gZJfnVt2X+lP1QlUgqP1ksLlN2c6Zx+IfFGH7KTz4DfRlCOoDfqD8n0
	01khJABg0mevMph6fVzp73i5OYSdLKasp+wn8Cgsm1xdqx/8hmxEydjaduxAuajvm2EBKgBM5JR
	/WxJB6y2Qc4C/KkbqMk2xrh9IU+LRbwiUtDbfDiMFTglA11CwOpbBqewhcv8h0WrxBfpF1DWZ5f
	3vEieXI9jxzKnkEKSGZbtsLnvi0R7NvbFRknafY5eys1eZX8fZ+dI3RFARE+oJaexNZGTXN2G1Q
	HimwBw0MQxXVypmKKbao7+E1p3t8wrPsriFkf/i+ybGddpKgkKlNGKaUJZIwwrQWZqXBlOHF8NB
	QAfLUBljGfL4sbz2KwueFw2MXkl/CUMwDjOVM3A8D61zeyDg6yYhSO0nC6pg==
X-Received: by 2002:a05:6214:2021:b0:888:89fd:a720 with SMTP id 6a1803df08f44-8953c7f0d11mr181353436d6.11.1770647848556;
        Mon, 09 Feb 2026 06:37:28 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf37b9asm80071536d6.9.2026.02.09.06.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 06:37:28 -0800 (PST)
Message-ID: <9066e4d3-7671-4fd2-9a7a-5a0719ae24da@gmail.com>
Date: Mon, 9 Feb 2026 09:37:27 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] build: include procinfo.c impl for macOS
To: Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
 Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <c786a038f31f0d3b5f612e9124e3dfb23e56a027.1770307510.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <c786a038f31f0d3b5f612e9124e3dfb23e56a027.1770307510.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/2026 11:05 AM, Matthew John Cheetham via GitGitGadget wrote:
>  config.mak.uname                    | 2 ++
>  contrib/buildsystems/CMakeLists.txt | 2 ++
>  meson.build                         | 2 ++

So many build systems!

Each logic you included seems to be correct and matches the patterns from
the Linux case.

Thanks,
-Stolee
