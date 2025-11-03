Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083827B4F7
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134792; cv=none; b=GmVVxlOnhCzTPVP2Ej4U54r3GqiTJkfcdwj+hOo3ADHZ3XrbxArK2Z80cWhTAPmYPKflFf2rN7JHJEYIQ0NaStQbi9p0VKhmC4fGVVzMh6lyjmuLy7WzUXz8goXOS49nclZPhpjWqmrsq2ym+08HH7r4mrAHjsVYCOEN0YrNdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134792; c=relaxed/simple;
	bh=IEAPMDQ8Oflv0SD7heFnVLeBHZeNKYsYkkeerTdImFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjxY+28O5IU9W4/5a05YhGpwm6W9nIdsJJHl77r0pN4zsXZ3WroGbYR1E/O632f6Ktaa2DwOePyTVeoT9weNngcQNziJ+fgXmrlwqhMLY4VsK6DkjHiJ62LIVxVaolEJDAuEMQu+9TO9oaQ8Ygql5Vvog90nlzTO78puV4YNePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/xCb045; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/xCb045"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378e8d10494so39324171fa.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 17:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134789; x=1762739589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IEAPMDQ8Oflv0SD7heFnVLeBHZeNKYsYkkeerTdImFw=;
        b=W/xCb045EeKzX/5q8LiOrtUKM6uQq5B71OGJ1FHeDAI20kyUhLlZjIrQ4NnYfKY/Ju
         XPhnslorxv7pHmA5HrBru3lJcKHubXFATVXwjbmDkOZ9DbjSa0Qt4kfhSbW2xIZ7qDEX
         IEIfqmZBz43rESZg0XB/2dUJJK+Bkac6Y6sqaUQzhZYJ4DT60iBrMCpde5A6nWZkRwEi
         AYWB0DrF7YQ/xSqZAm5wjYVoKMlW1C349DxPDToafxcmfFEMV0WoSVOt9UQAEwhv+6t8
         lPKgnGdiQc0pUhdL6ORMq/9rXqdixnNexr4rPnI5ElaLGvMIh2cqBUA2PpYjx5dO+ALa
         zoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134789; x=1762739589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEAPMDQ8Oflv0SD7heFnVLeBHZeNKYsYkkeerTdImFw=;
        b=fIPcPn2AxkJniedY7XLAp4ppuEgUq3LKRZxGtt3WIhDIxmiiPAvHH/N9kK7ZmldKjk
         k4lA2FR4Y7tRuaKgJ5otuU6qhVCic3wvD3kOGV6AH84E7FBYWkoC0XpyOQGgTnJiPOHr
         m9eKLzqbg3FFBBc52mL8WXLTsWEuklhxyU7F1gO7OY71PGvYTHjsc3de2l0Ez5yuhjMF
         SAc3qnDb7QWoW4EJkZ1DuW32WZckcJaunw1FcKuT3qxo1xK3AYRdIxUE1TzguteYeCAQ
         BgoSXHVvPQZA/vWvTPhIawVwMopEA/+6Pse5WArZ26JkkAWBB1gyrfxb9v807ygjQl3j
         ZJcA==
X-Forwarded-Encrypted: i=1; AJvYcCVGrdFASjXgjiRsbniVjavgWdE+K2mQi/TmLHwFdvd5uU6U1tc7aqgxV/5T5I56SS9CByw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl71ZePFg5Fcq0yoovBylp+u9qtcdNK27pjDEkYNgp7ZwHqxOW
	C6JhuTT9xL4xhQQNoIEODyfszqxEk5ro/Lbkuzopt6adKkcoUoBvrqy2cdNygRPMGSqR6xWQnbA
	JAFbSS+naW+8I+KM/eMrHkbv+7iCzpiyq7g==
X-Gm-Gg: ASbGncubbGUTOCKbrJcsf73QsRgIIdmTTLh6hMCd9HGZ4GXYmdQhO4+rxpfKlaNrOQZ
	cdVjO6w5tCfvERPEPhL1Czvqdbguq95/+eTxTwS2tlfgbtz2h4zxg3LimVxRqESIBt+FS07NE5F
	qSy2PRpWDCax6Pqj2urJ4p1pAZ1MzWDw7wjQB6oWTIerlG0i2SK3pl+JoY7ZVUcWF/9Jp5OmynJ
	o303gsaLIomuZh7kTjWb8YcXeuIn+fYlFepiNIWion0XM59HCaF68hMY4a556cE3tCwsWzC
X-Google-Smtp-Source: AGHT+IGZ6mMG60obFJIG1YbOb8oXB/XwBFLZrR0NPvTDt0FKx1A16J2xpH3p/JTUmesccJxuiq9udilqWqJHTvxOtDo=
X-Received: by 2002:a2e:7c1a:0:b0:350:adaa:6b93 with SMTP id
 38308e7fff4ca-37a18da8ba6mr21559551fa.6.1762134788843; Sun, 02 Nov 2025
 17:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
 <xmqqcy8418me.fsf@gitster.g> <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
 <01b001dc4c62$04943500$0dbc9f00$@nexbridge.com> <CAB9xhmMzqDUXk4K=p4EW+OybH68WTGBLVW+tPwjO1nTeAtiPZA@mail.gmail.com>
In-Reply-To: <CAB9xhmMzqDUXk4K=p4EW+OybH68WTGBLVW+tPwjO1nTeAtiPZA@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sun, 2 Nov 2025 17:52:57 -0800
X-Gm-Features: AWmQ_bmsSPZ0ZO0RD8sSJ9_1znerIzK8fn2RYm7nPXG3HKe2O1yq1J2tExl2woA
Message-ID: <CAPx1GvfYyEKNepKWhjr66i0vPm4VVz=J0f=aym7P2uPKueSFhw@mail.gmail.com>
Subject: Re: git-2.51.0: Fetching tags does not work
To: David Bohman <debohman@gmail.com>
Cc: rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Okay, but before 2.51, it would fail to move the existing tag but
> still insert the new tags.

This is a change in behavior, and no doubt due to the new
reference transaction system: now either all tags get updated,
or none do.

Which behavior is the buggy one is the real question. :-)

Chris
