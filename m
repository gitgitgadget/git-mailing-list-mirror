Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89219D093
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857338; cv=none; b=VGdLAdgLo6a+UTHAhDkEIYti5fHw4mm4CZIDvGm0ZoCSYYRLDTDT80+1pW36yQexlMVaTc3gZqaUAYgWTH/ah4Y+gNVuiKcCCWUMDjhQaKzj1Z9lwqU3AN5OS7evwau4FUVnZh8hBBIBApg9Z2+yk16i2c3i/FThwlHwZuKkWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857338; c=relaxed/simple;
	bh=ChEvucTELc2RKeRW1fn82oreP07mlYt5fJczGxcMGXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cs79V3vq0e7owwOma7VwM/wx7ruRTIAO5c9fQK4B51AAizSXOuNQp9Y1xeNPa1YfzhqqiWpwRpHFL3B6/IDUesMsK/VBpiYZQ3xLmCygjwpFAKJlIAWM4luhwgZTCClc6t4tSYTIwuu3Wc2rZXgYKtnStElc7g1xFC+HQzjJ9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp5pQh+s; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp5pQh+s"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso553885f8f.1
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 06:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764857331; x=1765462131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wxi1hyfzB4nx/0XMBlwNDfthABkAAGBKCW6AJehuPFY=;
        b=Bp5pQh+sZoMdiNHjfiXTFFpol8AazHTzKpKqz97JHU4oCfYAoNIu675KYt0z+EcZGb
         si1mZOsOiN8BXGCOusaKCCp3oDl6HqX4WZswQnOZF2qeUpFMCMogeBEfKS8PyTfhVr4a
         RZOSMwJ0YfYw+vNXoBNnlkJJIYDHOqYzLHwoKhJQccvnbRrJVOEbEnimDhwi9AFXsf0V
         6InvlySiFWxWmMBUHOaGIgXEVrb3G4qaLO7hELIIspcPDm9dCZlEXRDT5dOD8ZpeEUjq
         kzhaF2p15KR/RJo9zporwoYHNFs1XbmcKsKxVtXD4Ew3VmgbImVmS3OgSix30jUC/75V
         6UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764857331; x=1765462131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxi1hyfzB4nx/0XMBlwNDfthABkAAGBKCW6AJehuPFY=;
        b=DEgoO2P+PZmJKBoBFHmj31FBlkoahy9rlYXKBAFcRCsx4FJlqx64JdC9MeSFgoNRU/
         wSHkpVSJfvEQKjwTgJk712OOIuirk6hqnKgJCsCAkxI8dAwSDrgdj2OYS74QzhPAuBLu
         ZB1CpNXXTkI7sRBKYzRf0a46ejKAJQcXNB8xrDDMc/Yf6IBfsDLu04dUhCr3vq6vIND5
         tkQ4IWEwhmu4wqp1J+WxPF9OYWfmDRBen3JLE66zfGmywrBpbUUz/H4ZEbl+BzIltpbw
         OmAM8hM3OcZQWyqFZp3n0HCky7Z2/7m3rYkTOQ+WVyBFc+tkoVuJSQC4v4cEdzhjLst9
         Oq9Q==
X-Gm-Message-State: AOJu0Yx1qmaRM2a1Hi6OT8QrX8Dz+LCml4kOGA7rx+pBSvlSUYh7aBe4
	4SB3Q/xLTiI16LgPipkMAW4KLRlsmjZk9qnE3XDzpmv3g0SWqFW2MjQS5cgidg==
X-Gm-Gg: ASbGncvkUA3gGXrq2HWlR+2btc7OWtjtcKhUhyD+T4Sz0t3iK50ZeRDJwu62Xhg4bn9
	CyCKrSp57Z1BS4yhVXk0d/IOcJ+dlQhLkI7CBOWQ4LMhkanQFSqtUQZC8L6VgbLCWrJEBMl1PQp
	S6fnUNQ/MIzlfRhiTeu3Pr8iTr0ZzRJn/H7jWrTDxTmMofPXEyteHlqemBQZ2yAf2zgzDxhNiPW
	k4alqtmOJZEicCZOp+AOSMJQStuyUhkYPq5grZLdQL4NFsxa1wjNrQlRxh+MKqFgiqImK6ZppIS
	jQti7mKYY6CsVo8ixv5+Fq7H4sXq2HqJh88b52pFDMHG29pJjQYhQXW20Y+Moc9fINRM14XEAV3
	ULI1jHdTi6OGr+Knp8lKERGe4lGVXMmoqTQHFIr8D5XUwH02gH/Aghm+U5eL6R5CN8ZXWChT/ZQ
	6V2MuDAQPV4WBSLYzaZMe567LhqjVwEz7EA2zUC1SAtRmg2ABtb//TlqnCdVEQNUk=
X-Google-Smtp-Source: AGHT+IFOEn+9efIXbHFKdK3Oe5hM1lFVbsqjo4pW8TfRLWf194v5KY1RppGGb3VE0somDia/LAafhQ==
X-Received: by 2002:a05:6000:1a8f:b0:42b:47da:c318 with SMTP id ffacd0b85a97d-42f7320b37emr7093669f8f.52.1764857330945;
        Thu, 04 Dec 2025 06:08:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f80sm3431213f8f.41.2025.12.04.06.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 06:08:50 -0800 (PST)
Message-ID: <007cd7f3-0876-4912-9a86-e549876ec9db@gmail.com>
Date: Thu, 4 Dec 2025 14:08:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] replay: drop commits that become empty
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
 <xmqqbjkmk431.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbjkmk431.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/2025 07:29, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>> This patch is based on ps/history
> 
> As I take this more as a rfc/rfh than finalized version, it is OK to
> depend on the topic that is known to be rerolled soonish.

Would you rather I rebased onto master when I re-roll?

Thanks

Phillip

