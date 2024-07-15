Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813052F6F
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061642; cv=none; b=rkna5GwYdBB2CwH2R1yPkiy9/C0EKUdvS5ZtHQsi9XOuznWjb9G5eqUPl+4beZNGBQc/UTbDmidXs96AVc66LP9xSn92MKHS2PBoX6GoGFqrRqDqOP0fACtsLg+i+tQ8EZuIRK7QcCmd4Jq4v6GAgymQwV3MOv+I1fMdzh4d34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061642; c=relaxed/simple;
	bh=5srytGP5DHcCzubb+7Yu41fL86DFDqJB9UqNoQPOwJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxBk2X/rE+2j8NUtDDqfCrFAuDayCuOMKEIq8OGVZCUhMjxxlW872gw8V3qxMBDLFVraA3j2U/1OmgDlCSLPOV6e227hQdenmJQBaxIaW2XsuojLfXMAGhS/wqNTs0N4zaxHew5AjFXTj8ZZfCtt2c11Bq3HuD3gdHI9ll8sz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkX/F+8V; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkX/F+8V"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-654cf0a069eso37848557b3.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721061639; x=1721666439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJRU6MJ8yZ4F/6dxR3TwDmhK/U9/TlKg9Kxi28UfNtQ=;
        b=YkX/F+8VVkIF+G6SQDPpw9eK8sVvyEqAyaoH40tR7gbtZikeNQ+6rhjGibET5a2tbF
         lQJ329cKGNY9R1CZebY1Jr4ea9u6QEz5emtlEKw1eLwMmVqrcQ32Ogh1YhdWEC0XXKi5
         DRrAf/4uRDpgAkKKYybZIhtExZ1VJXI2gS3juXXVBr5myIXb2OGj2h4aXgN6lcD6HvlX
         0bXPIopN9wmN6jMcirNw5cbIY9S0zPO2Aw/AFg5rNdJ9Ygd38FOYS1yiXukE78CovbAB
         wxZMTZntXm83APhnQmbJDOyXW3NidnMt5y0RT30BVyLuiYQSLeNbxHqhJRblouDLe7Is
         8uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061639; x=1721666439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJRU6MJ8yZ4F/6dxR3TwDmhK/U9/TlKg9Kxi28UfNtQ=;
        b=cIUBr40A7bheoek4bh5PgZXWIw4f5nGyc62nMIuAcPUd6bWosPt918j6PYppqUq3P1
         oa7pJW0kl8JJL/yxJME7GL9Xmk/sfj3NteqF7T5ryqoiSqSIyqU2fROpxOleAX+wfM+A
         nan1quDa/y4VNxFLIEhe+2hqqoEUK6B0jRF3fIWcQr3BF7SHfCqwm4RBbyYzZYh5+7IA
         WRQXdUswmMebK1i+g6l26TTjhj1le/0ik1lOBA0uJsfLRCYr8rMIYuhRJrkAZWMaSTSB
         DQo5NtEGcj/aOBGkyWtMXnIBFflmupNdN5Adn8GPi9YcCyOi1viNuT/Vlhp2lkaDVBc7
         sd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7wOXGR1NPstIkQdKBKcjHD1exucChfknvN2OeTX3Rd+EMv+eHxoHlKWMz0x1d2pC0YgKk+AjqeIgzuO2EnPAPyRNH
X-Gm-Message-State: AOJu0YwB1uXTM8i75aqjLGBqfMZQFodlj8Pob+T2CWkm9UuVra5848VC
	ABZ6WM/ES1fnj+menKqhusHH+B7AEusQvJP4DJMuCwCt6na0T7t1HNsXHT+IYDdlmLANaOg1sFX
	zNmmQF+y2egvM/0huf46ajUPDxevxaAbck6OoaQ==
X-Google-Smtp-Source: AGHT+IHAo8H8mfgXmk6YBS9YVPhK73tAz8YhqmgFQjuqtxU21HOJC3fDABOtFGYqsyR4prCymChNSwBwdXBctggM0nE=
X-Received: by 2002:a05:690c:e05:b0:62c:c696:56fd with SMTP id
 00721157ae682-66355c43757mr189667b3.38.1721061639490; Mon, 15 Jul 2024
 09:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-2-eric.peijian@gmail.com> <CAOLa=ZSY1y4wz6M9mOLvTCPoeCmceD-HKqT5tomF+BzbL5yp4Q@mail.gmail.com>
 <CAN2LT1Ctwdij9-DujKeuzPX71mzEoMVbdrTkJ8bpRnX9NAZy9Q@mail.gmail.com> <CAOLa=ZRi2w_CXovpg3h1mfMsOiLWrpS8vL+NzS5o_NwhFdysTg@mail.gmail.com>
In-Reply-To: <CAOLa=ZRi2w_CXovpg3h1mfMsOiLWrpS8vL+NzS5o_NwhFdysTg@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 15 Jul 2024 12:40:28 -0400
Message-ID: <CAN2LT1AM5rYpwjZ+rhYerxDkL6mbxr7iDc=wvuhvNKS8VVXQ8w@mail.gmail.com>
Subject: Re: [PATCH 1/6] fetch-pack: refactor packet writing
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 5:39=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Peijian Ju <eric.peijian@gmail.com> writes:
> [snip]
>
> >> Right, this commit in itself looks good. But I was curious why we need
> >> this, so I did a sneak peak into the following commits.
> >>
> >> To summarize, we want to call:
> >>    `write_command_and_capabilities(..., "object-info");`
> >> in the upcoming patches to get the object-info details from the server=
.
> >> But isn't this function too specific to the "fetch" command to be
> >> generalized to be for "object-info" too?
> >>
> >> Wouldn't it make sense to add a custom function for 'object-info' in
> >> 'connect.c'? Like how we currently have `get_remote_bundle_uri()` for
> >> 'bundle-uri' and `get_remote_refs` for 'ls-refs'?
> >
> > Thank you. I am reading through the old comments left by Taylor
> > at https://lore.kernel.org/git/YkOPyc9tUfe2Tozx@nand.local/
> >
> >   " Makes obvious sense, and this was something that jumped out to me w=
hen I
> >   looked at the first and second versions of this patch. I'm glad that
> >   this is getting factored out."
> >
> >
> > It seems refactoring this into a more general function is on purpose.
> > It is encouraged to use this general function to request capability
> > rather than adding a custom function.
> > Taylor=E2=80=99s comment was 2 years ago, but I think refactoring this =
into a
> > more general function to
> > enforce DRY still makes sense.
>
> It would make sense then to move the existing users to also use
> `write_command_and_capabilities` eventually. I guess this could be done
> in a follow up series.
>
> Then I would say `write_command_and_capabilities()` should be moved to
> `transport.c`, no?

Thank you. I am not sure about this. Currently, the file dependency is
like this:
`transport.c`  -> `fetch-pack.c` -> `connect.c`  where "->" means "depends =
on".

Moving `write_command_and_capabilities()` to `transport.c` would make
circle dependency.

If we want `write_command_and_capabilities()` to be a more general
utility function,
it seems make more sense to move it to `connect.c`. I saw a bunch of
these general utility functions
in `connect.c` such as `send_capabilities()`. Some custom functions
such as `get_remote_bundle_uri()` and `get_remote_refs`also lives in
it.

Please let me know what you think. Thanks.
