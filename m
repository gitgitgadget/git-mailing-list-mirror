Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4817BDB
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806182; cv=none; b=OUXFQuSQuy2pRf3BUzoo3YDtpR9zbc74l89+k9uO8yeE6rovkWNbe7iv0lmvAWPJDZmLTDVenKrAIxZkeqtzCjNNmRtnH+CQ/eIRdXyP1seuzn6xypmXlzbpC8KE3zK0uhPevur9PZN8+uwLwWuIwys8wqkS1vKqjDYcjKPQBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806182; c=relaxed/simple;
	bh=4FSlCiRwG3LRUkaBVsnc5n7XWwBHIxgkr9CASA5NorE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vl7UOnImQdmSrieWapXnezUlxLi1P4ZlCVzi+3zZ0yGeZ3a52Ehsw5+E2bh/DZ/gDovVJl5Jydv1ruOOosIgarAHTtcj6iZ/wr3gqh2tuF5H+BUq2c4a7v0jiHq799CuzedS0JzYILGdMLndgqDKpq2XBJZI25hcbX05K81AMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StcT9Jph; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StcT9Jph"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d061f1e2feso14910831fa.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706806179; x=1707410979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FSlCiRwG3LRUkaBVsnc5n7XWwBHIxgkr9CASA5NorE=;
        b=StcT9JphZR8RazrkmT0r7N+EruIv1pZYfN69V3uE1QrHuoIYRgf1oscs7DrcnpSUFk
         aRYkP/vmW/qPiWZT4LD90uwOwoEnSA1RyXwJPnPGPcRYOipmgFLZoXzIZdPNMWd4MAPI
         mYIW3rX50QJdozyZEogwJjRQK5sucL9omIAFQlPVmxZe6fdYKS8eLnTSICY/FC+p7aqE
         jstKVEJP6XndGINjGlIww1Z565rNc9CryVmJOHjVaWtITI4hM3Nv72qdFf3q7yjkfGFo
         OXOOmwdRxpiTc87x8tpbUtb+5VtCf89svwv5gV831lDKgvWpEPvxVfuPaLsKo+CoxdUc
         wi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806179; x=1707410979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FSlCiRwG3LRUkaBVsnc5n7XWwBHIxgkr9CASA5NorE=;
        b=gurWR5DN8MtDbeoKK2xDt47Bcj+4Hl5/SNnHCcMwyyQpJU5UgKS7hmpF1jXl7g4AmH
         FSOUAvC6Pv2alcI6wxaEc9ENV3RFElo4FdtoiNc+JSJo5WTB98SKAMMNRsIoqVYWOfIA
         mroadxvqt1rN+7XNtBmv5fIs1WhIkKQ00sR9Ywp+YGnqUZYqjnFbk3JEiv/Av++KbwUw
         jyhxrGSQ5aJDBNqkBw4Kg2qZR5PO4uvTHl+O471nvCGz0MmQkJJp/0javBaIpifcbEFd
         dndx/9MT1RA2PZA1x9Mfoxbmf/juEn1D1QuZJsogaV/Ta8iUsGeI/vfW+5f0Zg5WaJg1
         LM8Q==
X-Gm-Message-State: AOJu0YzVag7vt/NqetaN9bQeO+sP15QHx28gdSmDcta/6WFVzPEGH3W3
	1zk0nRsKXkOwnazOaDlO1bjWPWH7JJtd/9StsoGGMzo1ScAhFC7lcfgQiadQgsU0ypCNGHxM3et
	oJTndHq8/A93bHnbiehmMMhfectc=
X-Google-Smtp-Source: AGHT+IGDTV+h5grqKNFi2OsFto2/zu2k0NERXXceZ4ZfI8T/Qw0iNPeYzC6THXKPBiW4wktXSuPIr8XmrYOuJJUlM4Q=
X-Received: by 2002:a05:651c:2105:b0:2d0:7590:7dd6 with SMTP id
 a5-20020a05651c210500b002d075907dd6mr2236183ljq.5.1706806178790; Thu, 01 Feb
 2024 08:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-2-christian.couder@gmail.com> <CAPig+cSNM0VJZ5SpvazY5T6rFvXuoTdfgD5J5f36PW4iW7xLVA@mail.gmail.com>
In-Reply-To: <CAPig+cSNM0VJZ5SpvazY5T6rFvXuoTdfgD5J5f36PW4iW7xLVA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 1 Feb 2024 17:49:26 +0100
Message-ID: <CAP8UFD3ka-HyUAdJ8RTfMt1HPmp5nQ3EKK2soE1Vjn+7C5OmMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] revision: clarify a 'return NULL' in get_reference()
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:53=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Thu, Feb 1, 2024 at 6:58=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> > In general when we know a pointer variable is NULL, it's clearer to
> > explicitely return NULL than to return that variable.
>
> s/explicitely/explicitly/

[...]

> > Let's make the code clearer and more uniform by also explicitely
> > returning NULL when 'revs->ignore_missing' is true.
>
> s/explicitely/explicitly/

Thanks, it's fixed in my current version. Not sure I have to resend
just to fix this though.
