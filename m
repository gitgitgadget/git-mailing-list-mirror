Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0E3074BF
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616618; cv=none; b=aSPrremD3VLVsDy5NLJbHBrI/hArAU5yqdbDcERFM4DFvjupG/hiwp4VcAfPWzSK3BTqpEeMZzJ4zuCSwbxtWptGuhw7DIT1coRJBud9SmVJrHVUFr/sPExAdcVKzLDWioVaLgodarCNCVH0DMPcNTH0SFT3do2IrilaPORhivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616618; c=relaxed/simple;
	bh=2ho/Yag18nPxbk6e8k2tJ5U8t95ygsrlwGa+XKb3PWM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c5fU3Jj8sjwPrETycXB613xu28bJ01ZGvUfFZ3+0tKbrf359AqvXmSepRNCY/Gs99QvNmWQkuwRothewrfEOQOWxO4tvYyZYjgouteh2fM2UOFL1q0eY6g6GbXhczgdDFtQ0BFvAYNdrc2fbU4WXXVGKlPaqsotNrHn9Z6kGF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADurpf4Y; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADurpf4Y"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-237e6963f63so5113635ad.2
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751616616; x=1752221416; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ho/Yag18nPxbk6e8k2tJ5U8t95ygsrlwGa+XKb3PWM=;
        b=ADurpf4Y0yhzQtRO1zdlRBOY219CKSS0mEVSXFCUZ1FcD/fuLbnBrulAEAmobFEsh/
         eqdO6Mdl86inJqLtmicuIaKXK3BAG9GzjEori11YfQ5M11Os37hHR0uCGiAckbPx90R7
         tsiqY35mtALvfKgXZ5p2L0g//acd6uVYrA5xEz8/S+uaYZPjt6YNlwj/MdAwzF6SHTo1
         Rn5t8fkjhS4TcDxxlax+2wFlDpUgck8I1RtgYbsjjGjTV8SD6aokCGmJ5DimTSylwBUY
         zgqx4+y+yQLNHWyH4KiOttQcwirsGzdqwNNTFI66qlNQhIaAI1F8kldU31ZnsNN5MBQr
         w4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751616616; x=1752221416;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ho/Yag18nPxbk6e8k2tJ5U8t95ygsrlwGa+XKb3PWM=;
        b=MH1c6XAUFzZZrimeR6Lsgi5eGh/o+ZSjFcI9Kqkv9Kp2Z1D7dlrUWhaHj+yzo6HlvZ
         tcKMegW8LKaTwPNAcsztEn+S0IcJLQGdVeLg4FnhC9jMhMdBDEj63qNf+gMoar1jqYp0
         U0ZK5M8WUWRolEgODy3r9MgwvhDRVmuMa/3WUAQiw1wAYzEGFix8jMwN3pjmlmfxavEB
         a3DPERzslgx+Zr/ldkf7MwcAX7fS37MUtC+LCLlpItB2CJ6YhISEUlCi12Uwuw6U3YWN
         Dj/5X1kRiXzpqKn34f381wMGlCYRTq02PBtKePJRtztG0vushRhtDFAm/Jnnwj/1gwef
         kRvw==
X-Forwarded-Encrypted: i=1; AJvYcCXPtCICtJpWepYtWq1rDG3G6IZWQM/kaWw+7lIhZzOqcVAnykf3YdFBJouwkN83aZ0+sAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56Tf1dXJ3+VdtWm0M7C3QWDbmOQi9kne468gZnQd0PhgcO9Wx
	c1Q3pmf8K7+VIniNyhUQlszhX1WFa/EqJcNCpa/BDBB7kFbM9GqToxEM
X-Gm-Gg: ASbGncspE11s3hUIy6Aoh0zVYRjaZ5bt7MVKfiC5ClQzxHNwsk3wYznizc6QUQoomZk
	5b8XqXzr/qzbY6yx/37ZEgPo7VhvGRZHEggUfSvqoS3IlMeJyazFto1Zqk+erOqdNtZ38aKiUtv
	Cj3sLtyS4BOsicWIECJlPbbFbc0l6Ghm2vW6n3N88QFjSs7nsKugASQqVfcnR/z78SA8FX3NQUG
	NfhcX71CqmyEexxKNoOi7/3nt39xNIZjERKDCfEW3gsLKrA1s3rp9x+bGAeHJaMOoll+pMroFkQ
	kgRXfdV5x8/IPXzNckNKBGqmXS2DaHXYj2QENLGD1JH/WiEKSTlPiD2XJ+7KOjjoHLJG4snkr0q
	7ogVh1PsgeG5tr/r0SZwKJBCgkyOi82iGnuqgsc8e+THgbW77A3nk56L5AZFwnA==
X-Google-Smtp-Source: AGHT+IEMGvOzoaaA22q56ZQn7Lqqu1lilQ1pJcyHTo6PgYBlJScglPOhUkcB9v32S7baY4UogER7gg==
X-Received: by 2002:a17:902:f681:b0:235:779:edfd with SMTP id d9443c01a7336-23c8758cba3mr19039735ad.39.1751616615864;
        Fri, 04 Jul 2025 01:10:15 -0700 (PDT)
Received: from smtpclient.apple (awork062012.netvigator.com. [203.198.28.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431f25csm15024575ad.48.2025.07.04.01.10.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:10:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Allowing "/" in the name of a git remote is a strange choice
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <aGdi6GRbI6Txm25Q@pks.im>
Date: Fri, 4 Jul 2025 16:10:00 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 Per Cederqvist <ceder@lysator.liu.se>,
 git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <10608B81-587A-4DED-ADC6-8F57B0B67E39@gmail.com>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <xmqqikk8bltr.fsf@gitster.g> <aGdi6GRbI6Txm25Q@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Patrick Steinhardt <ps@pks.im> writes:

> We cannot just blanket-disallow this now, true. But shouldn't Git be
> able to detect this conflict, similar to how a user cannot have both
> refs/heads/branch and refs/heads/branch/nested?

Perhaps we should forbid having two remotes where one is the directory base
(i.e., a prefix) of the other.
