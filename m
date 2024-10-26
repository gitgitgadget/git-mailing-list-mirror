Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417B79C2
	for <git@vger.kernel.org>; Sat, 26 Oct 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729904672; cv=none; b=X+qr2lsDXYQhCxVcO+7jKPsGmngP1SZKaMnvSSQm15kBbEQrmTfE0+S+KlN36xsiLQe66HQ975VdqAn+TI0qUl0Po2adG4FDLVeFEiUS859xibOYmrsHWcftWCY00zIH0ul1x222RIpBLIzSUTnWQkOu6XYpnYslJqEYcXGZX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729904672; c=relaxed/simple;
	bh=3D8mN4KAwwF/+hxZI6OE28OiIHNcV0q2C32G8hPDtoY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VqPXczroOvzmoKWLJz0GHwyVqyecRXmlz7EJZXuLt4oThu2A49HyTZDSARUAfE/M6ct5TC9ZmkXgO18hEFIRacOCSzwGX0MJUBXDoNFSPsGS1JQWXZd+I4uQSGyPkPUAY+wZRWqHnMkxAVGYKJJO169dIDXCjn0z0MSvgbIWv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAl5+0qB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAl5+0qB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so24460845e9.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729904669; x=1730509469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D8mN4KAwwF/+hxZI6OE28OiIHNcV0q2C32G8hPDtoY=;
        b=EAl5+0qBJ2dxX7wJGUR4FO8R52XBppFWp+Cf9HBIw1g6R+uqFdRUTLfbK/MBW2dA8h
         0zbgcUODutNCqWfrJR0QnZQb+GO1nruZt6OkXe0z4L0usVBbP6jwE21u0H4Bm84qCNwu
         tDYG1uJxyGF+YDoueXAfk3Tf/ScdPrGx80ZrGIxHK08XBpib9x7ufVmWKEWerqEXBn5p
         vN8V2k9fyp413CyiQfYVSNXt2cEmDQExEEIK027D7wV0pyccga4qweMHELNaD00ng8F2
         T9stfqzpNd7zaM0uv2u0e8nwh/rbxf3XsDxultbSUKyebNz/xmPDdJiWEcicx+ciICVT
         Jlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729904669; x=1730509469;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3D8mN4KAwwF/+hxZI6OE28OiIHNcV0q2C32G8hPDtoY=;
        b=Qvrz2GjnuBU7E4EUF0iqoWUJ0aY+iP3/yUJL6w7ed4OrNG9TyPeNH8qKoq4aInCfle
         l1kbZr9D9rfjL+rDkZE3MwGci4lWjNRnG7BtJxzrUYR9/QZJtdwGeBt7iZ5DtABAOqCU
         v1h4nYwFOeA/idhfbH1ZAjHGl+BW3WLb0r5MsBQxIC2WjAbPPFdXRyaz7ev3UcQYUbRb
         ZbOYrAms94UnOu9YiHkKwEybibXScfVvoqz4oVHDDmF4kzYuA5sdqNru3fIivogjWVQr
         jjJxNSUdSVgi+wTCHAmOsUI86i2JbKHwxLOPDqDmHWiit9PDtxNSM0oAlY8QXWAH/eSR
         ezvg==
X-Forwarded-Encrypted: i=1; AJvYcCWNhwG5WL/XSXp3W3kCBYLclYKKjT9uy9XIoTrvDmFtQ+sbubhy1v5d2TRMjUWFxQU0A4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nVXo4sz8vsnW+LEas7UBoCyjPi0jCuQS7jx7juwdslz85M+H
	66uZDwMqFO+dKf2ceLTcFSLRwOQiEDsK8RwKmkDic5dnCnVH1A==
X-Google-Smtp-Source: AGHT+IEJPVKIzJKxT3gv/Jam8RKd197+AullsomXwGJtbNurcJSUARALdqP5Nf1+EhiCMlSCb6efig==
X-Received: by 2002:a05:600c:1d15:b0:431:5a93:4e3c with SMTP id 5b1f17b1804b1-4319acac8admr8684265e9.16.1729904667288;
        Fri, 25 Oct 2024 18:04:27 -0700 (PDT)
Received: from [192.168.206.6] ([102.90.67.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bd8sm2895423f8f.87.2024.10.25.18.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 18:04:26 -0700 (PDT)
Message-ID: <fde4f324-eb32-4ffe-917d-d9077d11a522@gmail.com>
Date: Sat, 26 Oct 2024 02:04:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ps@pks.im
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 usmanakinyemi202@gmail.com
References: <ZxeWDTFHpHmVePdF@pks.im>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
Content-Language: en-US
From: Chizoba ODINAKA <chizobajames21@gmail.com>
In-Reply-To: <ZxeWDTFHpHmVePdF@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Usman for raise this. And thank Patrick for the clarity.

