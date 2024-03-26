Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3C13D53A
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484801; cv=none; b=Ki/ETWVP1t7qK6XVcUJgaJ4IyrkyBSeCoqOMufqJEWxCMVnyy9HZPOj36JceyVq4R3q8yMy2p21jAEL5vpQBq8ySqhnpCNa/mNq8G+frXxqQ/gVu2Ttm+vWEIrjFGq3E1tXeShfHkYn08xbMdNp6e5I/SAr870pcS1urwpr19dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484801; c=relaxed/simple;
	bh=Pu6o+4yCUNMR+z4M9STrHo0BOfcexJKP/tCeKZnh5cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRdxhid2Q0pd3d1ReYBvyTAtFetK45yw+5KyaLm1kuVIibzFvmYkE/cinyHIafezLf2C/XRuzGmFaaazP17XOt4MW07aX5t7efAxlvY++FdXEtPbIgskjCSuaHfGbx6jneLz3ARKeRKM4rj1ipaVzi0zDxjoFB/uc5ggMdgAfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fegD4uCc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fegD4uCc"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so24777051fa.1
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484798; x=1712089598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMhuolpo3nZzm37gOf/YomIKfVQO8Owg/5l13Px8GL0=;
        b=fegD4uCci6wjvrSTJYDlbZSaKUmWMRNX0oJaYTpzz0dlqIipGagJ37kAZqdWIf7d+z
         hu1tgWgobt1bpYP2WaCQtLJ/LubL3tb1ywQsL6nLFh/y+TNVGu7ZsUtvhHuuI1IGXKUb
         SBBu71php2We67o+3OpV6ugXHvSd+2uowJ4pW41J0XrPULSgALE980IYOtKDogtSBqTB
         zF5hEsaINE4dmpXtVW4EYo6b6Tbf57qfhjWbmYyrDb3d4miePq6kY8Djqc/wsZYOhEzn
         cvrfXkIECGvBnXgx7K0xt8Uqo9fWXDUXry3ZjesFmJLCIDlSWtd9O4cSBhqKuj5//6dr
         60EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484798; x=1712089598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMhuolpo3nZzm37gOf/YomIKfVQO8Owg/5l13Px8GL0=;
        b=uqvIG2h4EkEVy9NHJhgTrCVAkE+R/Ab2h0yQb4pBWjeLGYrHiAWhxw68faBhKdRUkd
         832dO4wfEAzp4fyMjHH4ClMFvw6TRc7B91Svpv+yMaaHN0wPSy6V50uM8ghvEzyXb7VD
         iG9xQxyTGdDMHQdcLipRmhIAvtTmW5WSyd2pb/zgW3s/SqGjm1PFU2lI0JNr3k79Xtho
         +YyccYlgb6r6rDEagDIZgtcxZURiyAPd6mT00V/IzrpJ2iQiU/3/PL/ni9HZ2/6R7uBc
         axCg2AFhuA30Ih94mRcbEi3C11VKoXxkuzGacLQp3V5we2HWQS4yCJZsg/CTcLXDOJsY
         eyJg==
X-Forwarded-Encrypted: i=1; AJvYcCVk2Lc29UEOhC2uz7w/M9/fGD9CRXOF1PoSdrMURqOd9MA/APjye5/wge4Se+yIbef0sWw/5pxtxjnacBvuBPxhkUfy
X-Gm-Message-State: AOJu0Yy58B7Xc7l8KL25HGz3aDqB6yDu5R4HAXFH9CeKynfz+dNAm4sc
	oe2kyxBmGXoQPNLDUPoeTREgkYC075FTUoRQF44DcVR0ZaEGZM6h
X-Google-Smtp-Source: AGHT+IFEHC7OAnpJ85sAyqgC2PgO2xh1AVMl3K/6tIVqk7t3xeOkjCQqE+T7V5+EgnDXFlhdEm8lnw==
X-Received: by 2002:a05:651c:10a9:b0:2d4:842:dabe with SMTP id k9-20020a05651c10a900b002d40842dabemr2156482ljn.36.1711484797390;
        Tue, 26 Mar 2024 13:26:37 -0700 (PDT)
Received: from gmail.com (156.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.156])
        by smtp.gmail.com with ESMTPSA id en9-20020a056000420900b00341b451a31asm6812094wrb.36.2024.03.26.13.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:26:36 -0700 (PDT)
Message-ID: <f6ba7944-c0ed-4caf-b347-aa2e58d847d0@gmail.com>
Date: Tue, 26 Mar 2024 21:26:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] improve interactive-patch
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> <xmqq5xx9dn6q.fsf@gitster.g>
 <eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com> <xmqqcyrgajrp.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqcyrgajrp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 26, 2024 at 12:13:46PM -0700, Junio C Hamano wrote:

> IOW, we already have the payload
> to show.  We just want a pager involved in its showing so that users
> with a huge hunk that does not fit on a page can use "less" on it.

OK.  In a superficial review that I made, I was struck by the atexit()
we have in setup_pager().  I suspect we need to deal with that.

> In any case, the future enhancement is not within, and we shouldn't
> add it to, the scope of this topic.

Yeah.  I am quite sure that the other 'Invalid option' thing does not
need to be in this series either.  I'm pretty happy with the current
state of this series and there's plenty of improvement here to have a
future improve-interactive-patch-further series.

I'll wait for Phillip's comments and then I'll reroll a v3.  At least
the ssize_t change deserves to be included.
