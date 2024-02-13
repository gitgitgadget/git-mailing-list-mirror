Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150A604C0
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847961; cv=none; b=NwMXE8nsU9L2siraOuD2zKT/+K676l0ufYBJI64g869UVWoYmEOUj7GHCT/A2pB7PRCdRDkLcaMrySkDsYZRxwSQwbn4VT1zfRwBL9Z6GKd74HMIUHZ6Jc1sh0ugjYhEKl/Oyu+NmiOgkTdlfN+HLtJI6MpWZV/cFxC4t/qoz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847961; c=relaxed/simple;
	bh=w6IwzzUpx5e1/+auWiYwIXyzm87si5K4rA/0HuTIstI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cibbjr2d7zD9sSNHnANjGt3XRxysWCBhPo1xAamowKdNarnSqOS7vnK2BU+gWJ0fW7oVCfTatNFr03xHXQd+8Q8BoJuEoA3SVT3EbIr8NhHVYUnLsR2w8vwAm+ERLAwMKrvvYAVvX/MEZiar75CnE7tvY3/VVtMNqDz1frodDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWzL7RNO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWzL7RNO"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d486bce39bso35636855ad.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 10:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707847959; x=1708452759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ig5J1FYL13ns5yu4EzJUy/VuMnS6s/9DCSw1lkkCo94=;
        b=XWzL7RNOGx0Qqv3+tqDMWkRk19H8cVW02/BT4jqxfv8iwIa2jTL/+UabU2D4dm4iOC
         Ks8XwlYIFVk7saYcxbZJY0lsXjpiVCdvivt16kUG6Sp3nP2rXm4reDh7lG61p+1EOi44
         3GFKLxZHUX1jsfuB7yHug99QR96iRJApXjRXfVL9dKQu5nDFYWsTwhw6Cv8Zc85OINkq
         CUTosV5GDhTOgYtRERkLKxRcK0Ea/fyAxrUz+0KopEEOHEyd4PmoTlr7EOxX/O3oVNtN
         giRHWz+D5xGXjeFqC0UebVuEJr83aevsP2YgbiAyJOIjNUQ7Ba1P2+/X0sqCSufHf0G5
         JWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847959; x=1708452759;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ig5J1FYL13ns5yu4EzJUy/VuMnS6s/9DCSw1lkkCo94=;
        b=N2IOllhq5V5a3VI2lFeKT4QR96flKHe0WS0Vnhb1JPxPXJGvQPWA1lt3r4SSR8wWMc
         kIJdxoakp0fxY+3hxao3GDS70NVFWhnzf23hTQm3mnuY9l9l49zoQaJ7i8OhIqUjosDC
         5+TxTuvPfunM+m234erQglGB7tkl2aLfwQ3pQ1BIHqrALlF3Th9qW2yxVO9G31OMShCt
         xyXABuYdqRQ04pb7R8LQQPFU8+insIi+d6kXcHPy050SVubJY21Jdj8GMT3MFWxvy76s
         Bv+0PBkER8VRXueHe0PWTOL+gHJRk5m0jdJi1MySylTW1xm8+dr0XKpCRXLO7YelXYUP
         HOeA==
X-Gm-Message-State: AOJu0YwJuZ1REuNgsRVHxnS25RBnflMHnJ9tm+p+CsuivSXVgMBi4jkt
	5y5+lGnZCDTJ/MquPtzc0ox1oLTL2OO2F5IN/ZudGQOoC2bMyPr1mMeDSDHpX7KzLUKmMRRDQO3
	Swg==
X-Google-Smtp-Source: AGHT+IFxOx2GA/s/IeIymKEReFvfQ+Wdre06idr79TP7tDAq2uVpiizbHjdtDsLxV8MdxTztEZDBMvWif9c=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:e74a:b0:1d9:f75f:7647 with SMTP id
 p10-20020a170902e74a00b001d9f75f7647mr734plf.1.1707847958929; Tue, 13 Feb
 2024 10:12:38 -0800 (PST)
Date: Tue, 13 Feb 2024 10:12:37 -0800
In-Reply-To: <CAP8UFD3u8qNpxObdOJDfBq+zVfxNwAG56bBcPeSC4i2=ZuhWjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <9720526dd8a63b916c75fe9d6322ee13c8b36621.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3u8qNpxObdOJDfBq+zVfxNwAG56bBcPeSC4i2=ZuhWjw@mail.gmail.com>
Message-ID: <owly7cj8b5d6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 26/28] trailer: unify "--trailer ..." arg handling
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> Move the logic of parse_trailer_from_command_line_arg() into
>> option_parse_trailer(), because that is the only caller and there's no
>> benefit in keeping these two separate.
>
> Well one benefit could be that 2 small functions might be easier to
> understand than a big one.

True.

> So perhaps
> parse_trailer_from_command_line_arg() could just have been made
> static?

In this case I don't think keeping these two functions separate would
make sense because parse_trailer_from_command_line_arg() is much more
heavyweight than option_parse_trailer() (one is just a thin wrapper
around the other). And I didn't like the thought of having 2 function
names that look very different:

    parse_trailer_from_command_line_arg()
    option_parse_trailer()

be so closely related in behavior.

And I already have some more patches (not in this series) that refactors
this area a bit also, so I wanted to wait until the dust settled down a
bit before deciding (esp. when unit tests are added) whether keep this
function separate. It's not clear to me yet whether we do want to add
unit tests for parse_trailer_from_command_line_arg() (if we do end up
"resurrecting it" in this patch or later), so IDK. The main reason is
because I think the first set of unit tests should be for the exposed
functions in <trailer.h>, not so much the helper functions that only the
builtin uses.
