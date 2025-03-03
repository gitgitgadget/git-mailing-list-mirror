Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CB199FAC
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023471; cv=none; b=VshMzKOUTsK+rUmlZBZzad9XUBpklR31pRZBkYJgxVuWP0HMAfwvlsEWQDFVih/gfayZ1FZ2jX37GJW8XinaCU78BEOp4cWGBQb8brpTVyspt3cjWXE574+BvoCqnsopOYS/A1Z636Eble8U4ZfQuZ0pLGlFU055Uc+5UtVEzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023471; c=relaxed/simple;
	bh=DUqTw2hi1y1hmCWeD7rbNQ4tzkQ/yAJ3QCXeMO+xT2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPpGgoXua1eV95hmAUui2uOZD8QmNRxoIJSJl5764vOeQEHeRYXM3nunQXRB3YYfNsgIwsfMsmGstLoJOSKld78cmHTa8WWyeVbTPb7smfK8h+kzm6jieFHR8gkcriAU51OmBebreT81DpsSouDV7DBzpfaY/YobLRU+5EpfB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njNVzhkx; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njNVzhkx"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b2aaf84daso1858187241.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741023469; x=1741628269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUqTw2hi1y1hmCWeD7rbNQ4tzkQ/yAJ3QCXeMO+xT2o=;
        b=njNVzhkxgcfzVjI3Xd/4wYtoxnPAUFcD0V8WIbIZA2nGyXW2ow21os5FO1KIGOfGgI
         aP1Ogd/a2lgGQkAGAo4CnZn+C5GuJssCTcyPIhlF4sfXfzyBm0E1fdrQUdnsmvuP3orB
         Xd6EHW8BUbUQpVxHebIweu1LZRrdIfHU4Au2oXn+0akyZ5tLWB677m67Bf3cE8bt40lp
         W+KKS7DFtCDyqdY8AeKC3XwAUkMmOd0SY5jIUzCF8F2dM8e6Ys2aZ9/rvcHF1HCkgrvO
         hrOg5ntVZnEF5sb8T0Cno0Kp/cg2gZr47PHN/HAkroWE8Qazxj2l3kg4tl/uvW3f/uP3
         Vrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023469; x=1741628269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUqTw2hi1y1hmCWeD7rbNQ4tzkQ/yAJ3QCXeMO+xT2o=;
        b=a2vvdMbSdOmFRt1RoCTUovwrdbE7BsZZL1gR6PV7d67Qrp8oMzbkPIuo4h2Wy3bOPv
         NX5HU8Bkvf6sQiWceuELmbQrLOiKg+0dER9RATeYrnsvrYIbmlHoT/CUfIjVAKdjxzY1
         wg8nvO2L5RWDmIjFxRavucWa574I6nrq3a4ztpQuYc425R1zoUdATcat8ythxvtTLQU3
         bX0sgkfnwckQyAPBi+m730oYrz0uClUEuLD22Ij+9yxIHNlb0lENHom/AVjg8UHCTBTn
         RoPNUu2vaOmD2zonrsH0q1uYdckQYAN1bFSNqDkLo5UtNcNFFDmrxj9om6z6dVQhQGUn
         VNSA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2JuipTlEjHv2CoJVbTfCDRomT2GVDqTQ0uP7aoqByov+K0U2CHxaSIvxewo24ZtR4O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyile8gpZmxWG25qKNsBYdSj4aI9k1dON3iduX/TLPkO8gPSw0a
	ICKJQ/YRYETb3Ww5J5XJayYA/6+Q46s+8biQ3Ap5KPztjNS+A78VIhGyTdwk53RX6OWSSAX4ebE
	lUBr5F95J97Yb8RhRew0dHWJ5yPOVsE6G
X-Gm-Gg: ASbGnctjJ5CVQk1B/mNvx3pUWSs/GUdcQyDrDjr6p/EzyCMzATpT+DQAIgrOSPsJaGH
	ImO1S14vT/VyNtL25GGlobSFcVlcZ3+BfeE8NN3F7lbx557YwkdywH+W4YEcp8jfHuQvc2lPNhL
	6/zhcCK2RkKA/UfqECQ9GjM8ktDw==
X-Google-Smtp-Source: AGHT+IFQF+/IyXg2BmYuZD1QlHs7z6WWqTWd2VYE2/ROyeOgtrKY9MQNwnmeLfURX3fLtmfunI8TxnOGApTlheOE8nE=
X-Received: by 2002:a05:6122:2788:b0:520:af9c:c058 with SMTP id
 71dfb90a1353d-5235b7984bcmr7783743e0c.5.1741023468769; Mon, 03 Mar 2025
 09:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
 <4e21312d-0d9a-404a-a2e0-0e2fcc681ad6@gmail.com> <xmqqbjum2ayc.fsf@gitster.g>
 <CAPSxiM-fzKUtvvf-DB2=VaGznr9utyb6zaKU5onxpy49KPChUA@mail.gmail.com> <xmqq7c58zg9w.fsf@gitster.g>
In-Reply-To: <xmqq7c58zg9w.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 3 Mar 2025 23:07:36 +0530
X-Gm-Features: AQ5f1JpSj5l8Tb_4dTeuUjbeqfLA9YzcHs9D-GYj7BV9BqNlhJpYk68C5udFtNY
Message-ID: <CAPSxiM9x=3WTmH-NSuV7Z1FtXMJ6v5B0R-zB3DOKcyiLKXy2rg@mail.gmail.com>
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be NULL
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, shejialuo@gmail.com, 
	johncai86@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 1:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Also, about the testing, I was thinking of using the clar framework or =
the
> > test-tool, do you have any in mind ?
>
> Neither of them seems a good fit for the task to me.
>
> Once you rewrite one of the built-in commands using this and run
> "git $cmd -h" under "nongit" helper, wouldn't that be a good enough
> test to future-proof the codepath?
Thanks for this.

To confirm, You meant using the "nonigt" functions in test files
inside the "t/" directory?

Thanks.
