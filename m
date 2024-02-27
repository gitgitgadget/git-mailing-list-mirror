Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F752F95
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027963; cv=none; b=bUUSr8JlaZtu+a9EoHcNYvaS+xv2E6rG34dVwYxZIu4OlQqLBbNgKK5BuU2tZ4bQjJfpACJDvb4jafFxEYFuSyvzJbOTb0d/qtO8mGExnZmpX4uTvW6p9f9wuMu845Z4GqUbJRgKg3KUTcuHxYGNCoKfOmuGzxDPHZG+yP6kBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027963; c=relaxed/simple;
	bh=JFwcXqdT/6jLTkHB2xyEf/KTMyH3URDcHkVFf1RAf3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4cFfYZX5iEvQ0Wxx/OXeeeoMrBdFuY7Lcj/AsNx4P2RH3nzMyWs/bjE+O2lLYJXn3ePtQp5YHqepmZ+ubYJ74e+IFByYnh8JjZnFZHHr2M+ubUwSgqTjif8Ew53oAYvarwKsLJDjZcRRiJo007Q3H2DG1ZeQ/QFTDM5xB+hEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMkw45WS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMkw45WS"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4396b785b8so114151466b.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709027960; x=1709632760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFwcXqdT/6jLTkHB2xyEf/KTMyH3URDcHkVFf1RAf3I=;
        b=FMkw45WS1e7MkCWmk5Wy6eAiU6j26AXQEQIHg/m9Kr4s6TuzYz8OGd5hfy32/brMkb
         r+p4836DLRawt6S7AancYE1VcNEOsuyOu0B5tDTA/LGe6RyxnPsel6pOWCllyKzKRe8/
         RefOOMaOuRu1NT6AGsBY1D+k11VKxvZUYKW0FK7UCvr5Xce2ejmu0EgxrcWdu7HHoola
         cdixaTBSIJ66ynsluHM8VGGQ4qz0ljIw1Q8DCuZb0/2RECazKMt925Mi9gCMLbP+n08y
         QTm4PY7JA8fsxWXgJCEWXt3UR+/mVf2mOjLlj0pDD3SNPgYf5vh5wx/8Pa6Q4WhoP1Sl
         /1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709027960; x=1709632760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFwcXqdT/6jLTkHB2xyEf/KTMyH3URDcHkVFf1RAf3I=;
        b=kkvKERk2HAma14ugSKIvQnJlZ2KjpXdSzq8hG75SnfM4FNNetWDS1XmMfAxT6UDFXh
         Ko3p5MI2eL5hnlRYmMllvUsfZZ4wgZQdWW8DlNprun8elMaOje/F1Dfa4hUDmERl5Ik3
         aa+8GKkMDpi0lmUbSo3spM/ixy0uZXEi+8I/e/Q/n/SMlZdJP6ML5sS6VyqVpWBqbNBZ
         o9VURkBedp5tcmfpnpONNhEcVYzMs8Wy8pQwh4jODtWfaGoyPZwlpDBoiL1RUYTc6qv1
         RB+kQmo5yQs5YyE43SjKmv6b1vGFzQgve1yyBSKhiwhIPsYCLmEpP3RY9QmNsn47MPob
         /9nw==
X-Gm-Message-State: AOJu0Yy17k3jvhOQmZ1V0ItRRrYlfwuXrm1u45GjUHu0IgvAe1Rgmvp0
	V0Asfv63f8BQTfYLsmjtCUHQnxbO2tCno7wWHmfzmOAls/OJNlUuvnwMMBz67EGIw5glaCfJteb
	iu8AwZX/PXzSCMiOqMD+kiWkIhXKk6UPLgMY=
X-Google-Smtp-Source: AGHT+IE3Oy0f6aIZonLTZc9zp0UNKW3DzAd+SYu5101yW95X8Yv3wZ5HaS+aE/HFMEKDOubJqsbQ8E8RAllZL1ERIVk=
X-Received: by 2002:a17:906:3811:b0:a3f:2ffd:c68b with SMTP id
 v17-20020a170906381100b00a3f2ffdc68bmr7069954ejc.6.1709027960193; Tue, 27 Feb
 2024 01:59:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223193257.9222-1-shyamthakkar001@gmail.com>
 <CAP8UFD088GRkVQWjrBFk04_HFfiEk64Saxm2toYsci36oHgkdA@mail.gmail.com> <CZF8YROS9RVC.9H2EKYCF08VK@gmail.com>
In-Reply-To: <CZF8YROS9RVC.9H2EKYCF08VK@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Feb 2024 10:59:06 +0100
Message-ID: <CAP8UFD0yOXPyTvRCXxhoWXASW+HP230jVMCDzipg5PLAyVXJUA@mail.gmail.com>
Subject: Re: [PATCH] unit-tests: convert t/helper/test-oid-array.c to unit-tests
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:11=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> On Mon Feb 26, 2024 at 8:41 PM IST, Christian Couder wrote:

> > So I think it would be better to work on other things instead, like
> > perhaps reviewing other people's work or working on other bug fixes or
> > features. Anyway now that this is on the mailing list, I might as well
> > review it as it could help with your application. But please consider
> > working on other things.
>
> I understand and will work on other things.

Thanks!

> > > In unit testing however, we do not
> > > need to initialize the repo. We can set the length of the hexadecimal
> > > strbuf according to the algorithm used directly.
> >
> > So is your patch doing that or not? It might be better to be explicit.
> > Also if 'strbuf's are used, then is it really worth it to set their
> > length in advance, instead of just letting them grow to the right
> > length as we add hex to them?
>
> I thought of it like this: If we were to just let them grow, then we
> would need separate logic for reusing that strbuf or use a different
> one everytime since it always grows. By separating allocation
> (hex_strbuf_init) and manipulation (fill_hex_strbuf), that same strbuf
> can be reused for different hex values.
>
> But, none of the test currently need to reuse the same strbuf, so I
> suppose it is better to just let it grow and even if the need arises we
> can use strbuf_splice().

It's not a problem to use a new strbuf for each different hex value.
Tests don't need a lot of performance as they are used mostly by
developers, not by everyone using Git. Also if you want to reuse a
strbuf, you can just use strbuf_reset() on it and then reuse it.
