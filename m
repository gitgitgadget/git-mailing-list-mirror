Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8602837143
	for <git@vger.kernel.org>; Sun,  5 May 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714922757; cv=none; b=TZqp2uunrv28W2x3Uzfl5GcuygLLAdcXsfkncRd3oxphe92NSUGkj9YFwf6PAAGu+++eeAvoMt0DB33IgqsO/V20x0DQo/hJ49GFmJFfSvOTxDpCexGXg6uhHj+rp67srZr6d6GmO4mBNWrSwCMBBvwfxVbQ8yGtO8hvjNToh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714922757; c=relaxed/simple;
	bh=ez6n/QmwqmWjJRtB/IqVyt0JYbOSJgqph2cJINXK5AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFu10Kcem9jVp88uOXalbh85wUmZGuA5R+iql2lnF1vFYYB02e5UN37/QxO7TRaB1mWGnyznOJKIPo+5yU1JowhM8ZlMtMcO6KELIo85wiULgHcFLrtIVJl9kwEC1AM7TdOBcmBFl3RlnR7qDjOEOEUqQE5ZNBsjd31gxo8i+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8dbleOn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8dbleOn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41ba0bb5837so7900585e9.3
        for <git@vger.kernel.org>; Sun, 05 May 2024 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714922754; x=1715527554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UTawFqv4ESIm2fFREu3FlGrHRBKZvFyNu7mfllBGyfE=;
        b=A8dbleOnN84sGI1dV7Gpgi7qJjr/KKk25BmmSSwaxTYWcZcT9FG7si2cokmCrDEbl8
         4MqJcAkFmIRruOiy8tQtQRs/rQ16/uoKF66bTkJ+lTCO/6FQIdAQjY4TNskveCS/i1Qv
         aaVXFFshV/UpKbkB5U7goWu43sGtoC5ZY+m0cCvVf0vLjIcoAL8uJFCfsmI2ZK8LYNkT
         DquOkursVa3DCBxptPw44f27Tl32MAp9QIegIEsFaNGZgr9lMdyYf1svjE0HqtGZEN1Z
         QSs5BoH35DhxO47NWOrveFXbWzp7pZsEXnQK281XE54C+jIs62pQ4Wp6XHnOHoGliD/i
         HWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714922754; x=1715527554;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTawFqv4ESIm2fFREu3FlGrHRBKZvFyNu7mfllBGyfE=;
        b=KWT7XrtyzkxJfu4f1roDcDR+DV898NDFiDpWGmHpcHIRuYtx7U++YrwH78U29+5Th5
         HligQDE1p03aCT9AF0KGERZdPu8wBZauSrMoakAhwuicR7lCrUY6pYNYa+exCeoKnpwq
         4bCg7ewTjdmSubKJUZSgQcKyPc/PQP8iIetA9XOeQXeG6L3MyLoQ6/h5AP3TlgO6UdRW
         u3+qkmBybPYzU36clhgG87TR2x/8l1/eW1B5lqcIF7EC9KLLHkbtLjYQ0kW7YB0UXs4T
         8zo3AJP8V2aYy6CSC9Xx8Iuey3bFzrV8bzp8T+5U9bg3vSHwA+mL0+S3xuSLpzq6XfSl
         Q5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJgrhSH7v4/vZBME2OybeQCURJALreuWFbRVopL8HvFvfboowsHWaECQP7gZcr1VqHboMWjwyab7Bo9vBvNcsqLQYc
X-Gm-Message-State: AOJu0YyYhpq/iru9sXP4sWPVukOwtybthZpbE0NkquwW+KkX1FUvkV4i
	Mk8mhqyCLtP52ei6xEESEQJe447x57K5mLyZxWDtPpOpsgGTw9iy
X-Google-Smtp-Source: AGHT+IFU+dZ7hD0J5MHj4w8mOmnZ231elTvmilc1C/UR4wjn38VdpSMDrar9cGGhn2jfF1YI1d+etw==
X-Received: by 2002:a05:600c:3b22:b0:419:f9ae:e50 with SMTP id m34-20020a05600c3b2200b00419f9ae0e50mr5851286wms.37.1714922753658;
        Sun, 05 May 2024 08:25:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b0041a49b10a13sm16508020wmo.11.2024.05.05.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 08:25:53 -0700 (PDT)
Message-ID: <99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com>
Date: Sun, 5 May 2024 16:25:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: fix --exit-code with external diff
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 German Lashevich <german.lashevich@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

Thanks for working on this

On 05/05/2024 11:20, René Scharfe wrote:
> Finally, capture the output of the external diff and only register a
> change by setting found_changes if the program wrote anything.

I worry that this will lead to regression reports like 
https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/ 
as the external diff will not see a terminal on stdout anymore. I'm not 
really clear why we ignore the exit code of the external diff command. 
Merge strategies are expected to exit 0 on success, 1 when there are 
conflicts and another non-zero value for other errors - it would be nice 
to do something similar here where 1 means "there were differences" but 
it is probably too late to do that without a config value to indicate 
that we should trust the exit code.

Best Wishes

Phillip
