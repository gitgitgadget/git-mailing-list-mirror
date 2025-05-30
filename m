Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7159476
	for <git@vger.kernel.org>; Fri, 30 May 2025 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748576636; cv=none; b=d3eI+opeUqh5W3ZNKlbNyalJUTLtQEO5mnl5igDfWHjP1dZ9D6w5z0yc+94Yi3QzQaN8HnCiDX+dXTkxFibsyjPXtMHiMxr7U0H3yhs+4c1ulcZH7/An0Jp3XUWzUS8jivZB4sCaijSCeX31R643Wvv4rOAGqgFoepFUz/EzEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748576636; c=relaxed/simple;
	bh=aakC9X5iOsO3Nfhy10cHg7LCQK0yO+v4qa29nNHTDLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djBGWvvoo7sZtEhLWFLBmS7dyjtFPH9cNNu/D1+JZO1vKYbOKvxcerTzG9g/dGXmpO2td8OHSog+QT3WC+03cK2ci4daBuco9qxK8duL4tTvsMUxgDY4DM7gvn0siekBicuTbJuuAZTgdMYCjpX5wDyUEz6Z0RuWtA5TMZhwPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck9HGEgF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck9HGEgF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso911035a91.1
        for <git@vger.kernel.org>; Thu, 29 May 2025 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748576634; x=1749181434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN4YVTkFAvRHPP39SctKIRNrCuLjagjBTuewEAEchpw=;
        b=ck9HGEgF8/1gBXkPrS+/zA1eeTfkWNDITuDy0gdTKT9TzsqrpsylutFtysKgxmU4OG
         nvFmfugyAYHXLTHHrKPPLwBuKWLsBfbz4YgmmVMdtJFOR9VEAc+5snjM855QrscE5N7L
         ho3zeXvKUYJFA4+pbf5JN+QBAWTnGIvQTHu6sSDvpENoCy2ryfiE4oIR58PXZmApnSks
         myTr9Mh+ATjnqa1x5REONalEHMPXD2uC6riaNxdP/MslJHW4seK4Qwo9Q3nO1K+wtKUa
         z7DoBR+kbx3dsLN4zIl0l1rIHefyeZ3+Fntdm31DWowDCQRSb+baYuj5EaDjlx8eEzpb
         ni6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748576634; x=1749181434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN4YVTkFAvRHPP39SctKIRNrCuLjagjBTuewEAEchpw=;
        b=wTOZn4EPu4/t1nnhVlrhjbZKIjxBqQSa/qSvIOMbDhDh10UplKrL0oAl/iLN9VtR4g
         7gbu95eC9YgO8epQlbYc1f5B1yrv/u0ixrFIbs04+2k5jOoZ9a/Oiihlu10srFNjb30C
         +OLjzGeSCanE8hxALLaNEpyvzYqYRO+7DbNzUXLzId72yFYefnoQR5iwhBDl+CLotUOp
         2E+ChuHKPG2z430JbntktzXnjuer0Dr2rayiAUhEViABPtU6G8QuebYCO5lifcRWcjOn
         GleKeIwBjnv221mm3MLAE2qoC38W+GDAxsCgMYFgqiqVOhicaPDG2WAoKebFVh8XhvAO
         /yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbyBW9AO271dilv92svw9TbY5SWoc1YoobjQGfi+waCdOdNEUwFj7aow2ArDyUNLDBDvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSP92scHUkCUevuUZ9ulqiI4ds3ecp+Mi7HHwwKHsY+AUp5nf
	nQS1UC2TfzcIN8qto0JoNBfrzNUVLo68mFMlzVu11ik7ZU7iYxx+pbg2PV8EEu/G6karU1Eokrx
	CB11Td4ogb9v8xiIVhGJjcXKK5spKecU=
X-Gm-Gg: ASbGnctX9upPoNxtFHgOZKXd6XEvEqKQX5uWXHgp3Jx8szn8YKBThctfMoFvr9Wq2WU
	hdNr/unPAw0gfbrAY9rbZpwcEJ36Sa9H5+yZBKdv6xw2kk4y32xRYdRJjOv1nzvoh+saS8dH017
	d/CQIl2i5wG3PoIFsAJVrRm33edzXwHxNkkbSyXfchbQ0=
X-Google-Smtp-Source: AGHT+IE7N/wDRqzdnPpaIo4jMVFicx4pvL73zSIwRhINfKX261xyCB+26Ed+irCRojSbHmi0zRzCsZTRckdchOsXeFY=
X-Received: by 2002:a17:90b:1810:b0:311:9c1f:8524 with SMTP id
 98e67ed59e1d1-3124173445amr3180686a91.15.1748576634461; Thu, 29 May 2025
 20:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
 <d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com> <CAPig+cTdN=x2GXGW2p_g_k4jgC0eQmjW5zLsWhJm-PP7eMBTiQ@mail.gmail.com>
 <4c1f645b-42fb-40b9-987e-08ce9e057e01@app.fastmail.com>
In-Reply-To: <4c1f645b-42fb-40b9-987e-08ce9e057e01@app.fastmail.com>
From: oneee <kimww0306@gmail.com>
Date: Fri, 30 May 2025 12:43:43 +0900
X-Gm-Features: AX0GCFu69HMMXuOt0tZJfUX3ic4uxbY8jMdDbIPfkDA0EVlm-18FyEYc2wWDND0
Message-ID: <CABXyHXoCuwAUqiQPxE82mV4n0PQtY1zopD+rJDb+oyTkR8qwyg@mail.gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(I'm resending this email  since the previous message was blocked due
to accidently containing HTML. Thanks for your understanding!)

I'm sorry for the delay.

On Wed, May 28, 2025 at 3:58=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> I would write it as:
>
>     doc: sparse-checkout: use consistent inline list style
>
>     Fix this inline list to use a single style, namely numeric, instead o=
f
>     `(1)` followed by `(b)`.
>
> (Numeric or numeral, I=E2=80=99m not sure)


Thanks for the suggestion. I'll update the message as you wrote.

>
> > Signed-off-by: onee-only <kimww0306@gmail.com>
>
> I=E2=80=99m not saying the following is not the case.  But FYI the projec=
t
> demands that commit identification needs to be your real name.
>
> Just saying in case it is a pseudonym.


I wasn't aware of it. I'll change it into my real name. Thanks for
pointing it out.

On Wed, May 28, 2025 at 4:21=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> > > +     word "patterns"), and (2) the sparse specification might
> >
> > I would also use a semicolon to separate `1` and `2`.  I think this is
> > the correct style for any list introduced by a colon:
> >
> >     see here: (1) ...; (2) ...; and (5) ...
> >
> > Because then you can use commas freely inside each point.
>
> I'd like to push back on this suggestion, at least in the context of
> this particular patch, the purpose of which is to fix an actual
> problem in the documentation. The sort of improvement you suggest
> probably ought to be done as a separate patch, but let's not make it
> seem as if we are heaping extra work on the patch submitter; it's more
> important to get the fix itself landed.


I'd like to apply it to the same PR in GitHub, producing an additional
commit. (I don't fully understand how the system works, sorry).

Thank you all for the reviews!
