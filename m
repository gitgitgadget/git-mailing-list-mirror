Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20A1DE89A
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391243; cv=none; b=DPd8XyuxPHOap1H56QaQkeImgIx14DhvoB/yh5sGIXOHgGrU0l9xCIWieUNro0ABkziqMsQAD+4+3+DEygNpYWwa93BUYUse4ZTt9Mb/8K3MLFMdS7QwuIb82valvnx0Eg8WghpNig0lf4c07aurAERqG7Bhi88utecX4qdrLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391243; c=relaxed/simple;
	bh=tGp4YfC7hdLRyo2AwmDacP9qy/yRsWHdTZvJ15ufbpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ft5aQxtIxFgEGDEMduGE0SDG4p+fMQHML7I9mdJ0mZ1a9Leb5XHIP6nXEhR+RqTt8x2bYGBfWX0a6n/4xC2RDIaIunrmW6Xo6Tt0qVbqhTBxR8Y58UZ/zqjJEx3V5FauwN1R3z3RsDCwdCD7+vx7Ah4/ShWXeNdYgOLj2OkLiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtQ5dSjG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtQ5dSjG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236470b2dceso29880435ad.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751391241; x=1751996041; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DC4qiuP8AElyAWbIF4qh7dvq+2LvAbt4SZiL8zHXAUk=;
        b=QtQ5dSjGWEor2ibAdwcmaUqMrdWm3YHbX7mx1Qay5LEG4+CWzgK7N0qlF30JalofOu
         nJ7wZNp1KDIPpKvNb1Q3iBAhONFtafsvaz9FAYmCILzOar9Z54TVc3IdoNnxh5kX/ucm
         pTxu2BOPw+610KYpfeC9oCRb6JebkVcwP3wg1RPtJkfOOCNohmTlxEImGvzXFcJw7TWA
         rtzYOSlC3/ATpyQsXue6BFyYadg5Qh/LwTx8mTdnDlY7E/NSbttGgRlYgubrrdrlAnFX
         6Qazr9zkiJE3XMPUbKdexW65gdBlAuG0ByMxfEsY/ts0KevfHdDCopFkOVR8irrGiI0I
         ZdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751391241; x=1751996041;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DC4qiuP8AElyAWbIF4qh7dvq+2LvAbt4SZiL8zHXAUk=;
        b=aH2NZEh9pYedtzQhuQ0sUp2/RkrJhmu5XdQVrxwCGJpUm+OBQDSCkPmXkiwT/+3ZxI
         fgdSPnAMm2F6ungkXsvwBwIK2dxGu6pEs7XXVTQIb5T+Rt5Hy/SvM0KvqR2WkRq+ClyP
         ZgyLMXM1BcDqDBnXJYSBEGqUONDDE6VQo/chRTf8FxvyZ0OKRlO/LFGWocG4XUBcLl1k
         GnlcQWcxtnr49Mkk9stqG6jJ7izHpGeEWKy1DTbogNPTv1/5eRD9LztYzsPgjQ/XCWGX
         XmdrlgapncSI5UDFbpZcNGzRZuzfrnxgSN2dXTpfkv9WU2Ov8Hl3RABD5/Eo5yJP7oE1
         Sehw==
X-Gm-Message-State: AOJu0Yzs8zWfTVqd8FnNX/GybcgScM/N6GcWc9VbmpKf6s+fPf4d12yT
	gXdTRzsdKQYnetMDEOIt06LN7uBmau4r9AtdOT9wP4YUMz8L60LZuQ2G
X-Gm-Gg: ASbGncsXlBZFZpy1JD2vFzP3SRjxTQfS3DVY8EXT+2AN2NTy0huHqzJXGYfPoETDD6j
	eZ1TR/pliEVxj1iOBgQb9Qyh2WpY/Z9PoLeiSr5NXmbXkA36uM5FCu1JEpY81HoQ/qKoELpDHfn
	miOsCkOg0NsyOhdgIVe6RMIWyomM1pTFlN4XLSRXbs/RP/6nb+hCqEwY+hvs4KFZyLH3T6HEEWJ
	CP2tkI6sowDkBMAhb0xw4/+DnbULvGjdBGpSOy+qQGQheFQvMxzMkwN09RYbke+Sqb/2NpW1xuI
	fHxoxaRbFTP85lB9x/wpkmxTslDX/kPDs8Z8wqEc/m98RLLtcbQUBdw1n176ALeF2Z/A1MRKpXv
	ce2jdC9488DMt8n+edQ39X0KJA5A=
X-Google-Smtp-Source: AGHT+IG/OMCaJniQe8r4Ng81VAPUEJa5qEz65fri5K5Lcyo7wpgFcrXjmmzsPacWN9mD0X5GuvzkSQ==
X-Received: by 2002:a17:903:1a4d:b0:237:ed7c:cd0c with SMTP id d9443c01a7336-23ac2d8b52dmr261533975ad.11.1751391240550;
        Tue, 01 Jul 2025 10:34:00 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3d35edsm108350245ad.257.2025.07.01.10.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:34:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Git PLC <git@sfconservancy.org>
Subject: Re: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate
 changes
In-Reply-To: <CAP8UFD3DCi5n12HpYwuF4Sh4gG-B98a57HBpDAB+uPrqJcN+jQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 1 Jul 2025 13:07:52 +0200")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<CAP8UFD0bd1PD03VPaenAd+76Q6CeCOmDOJsso1nMKk4tZ4vbMg@mail.gmail.com>
	<CAP8UFD3DCi5n12HpYwuF4Sh4gG-B98a57HBpDAB+uPrqJcN+jQ@mail.gmail.com>
Date: Tue, 01 Jul 2025 10:33:59 -0700
Message-ID: <xmqq4ivvlss8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> As QEMU is part of the Conservancy, like Git, I wonder if they
> consulted a Conservancy lawyer to come up with their wording? If they
> did, maybe we could reuse that expertise?

Or grab their wording wholesale, perhaps?

    https://github.com/qemu/qemu/commit/3d40db0efc22520fa6c399cf73960dced423b048

is the commit they added it to their policy.

Thanks.
