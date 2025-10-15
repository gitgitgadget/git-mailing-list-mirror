Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7233043CE
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565371; cv=none; b=DklBi07OdoJYhstN63TnH4wumkYMjWm5I/+7s/34G2hHRmwDYTLnncT3OmLFxagJHuSFNueeZf+vwVV3GTg3PHO3/fGBEeb6GWn2gWuTobvltYnzGi8p28sX/wuo3MYgcd3RMikVzpYwjjHTAuB3Z7TycPyF+eeNVRDNGoFefyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565371; c=relaxed/simple;
	bh=mirZ7JGHBv5b9g3gd4Nk0B6fNEmfxY/6TmhvTYgG1bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DglmUF39kESlB9Iq52vzVEMCTIbcWQeXNf+wLJwYke2pa9ypfh7dvuGYzKLucJVmZMcBLmJfbxVb9PmOw9/eDv3eYkmb/NUfaFpoGxletPI6fC1Jk532zCVElS+lD7H1YpzA/d6Tv1FGFCXJX3ACwvpGtaVscAJDLB3PZdnhJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsmHqGjQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsmHqGjQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b60971c17acso6357a12.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760565369; x=1761170169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmpO2iBYzXWQsO9RHQys7nZG/95e6xKYktIw6wDZVrU=;
        b=TsmHqGjQvIdG+b4vyI0kL7dL/8X0pzg1+j8hLwBZWtA0wGDA3f3TcvpHz9ckm51oIi
         n086iwQrvrK2DzDzVwcnN31icyE7CTNuhUWP1TQXz/6Kr6E4iI6llWSZZJuFAhVdxxgp
         YQFPIoqawFPmbCo+GwEEpvE+Co12q8j/RJf14O6j1Tm7ZtYZl1C/vSIdsFoI1REtYs/F
         YgryN4fO1My7G4RsEbM0k1lp9sQCwmo/Vx3r9G7RAJOuPK9fr0SUTbsQQ+EyhgPcu8Ts
         9Ypgn1SljwL9/fbVigJPRq/DI8JqOv5JKgqY9tBf+uegSkj/F3pfX6nSlpRjLyGg2TRU
         SKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565369; x=1761170169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmpO2iBYzXWQsO9RHQys7nZG/95e6xKYktIw6wDZVrU=;
        b=q3qajNmphEaP1gIqSoogrvUCzsJ9RViL5rwYFmcPEtUuAFalJR5amKEiCYcaEAoH2M
         YqSeClSHpjzTXwQszFk4I3UuOqdq2RJJ0g5UjZdwbxxvXLw8d26tQlgcvQ+QZP97bwF1
         x7NBJeg+pFuxppe7IBo1GpfwT8grLCnVOdn2hev1kFLJHINQs8OZdySo4gk7I9C7ET3k
         MZqc3Ar7FNIGf+EcRcvaexZ8wYTAE7cZn+aH69X5G26WfHedhs4tFm6MZ4EuOLgeA9Rb
         4CCwXatlcIFMa/vTv8qr73hRvDLfgPb+JRl86NOR580x/AimAjdPv94imIhzOiNg+bT5
         4+7A==
X-Gm-Message-State: AOJu0YxaTptbE3sWa1uWoFOX8d83UR3PjhZ3HDJhK+E+oivlGoPCOiIb
	PFwoO6DQTmYjVgydqfLbp6flwKFj5fU+fKcZWEvcies6rUc3Kk0xDj/xbPTCMTrgQ5l5j3mfQGM
	NTXIr0ACCpeuXg772L312ioRvfTb4tMw=
X-Gm-Gg: ASbGncvwyOOg8qxzgY5DXfgjjdL+aNSui3ojekvhdl8s+DyHvbDIRwaa62hSZXYxWtV
	JRn39zuCP3lL3M/yk8tDa31yVS1TRxOl7VhyK6/tcoLIb/jCUnEbaga5ERUhOS7vORJTbkFU6gI
	7uQyiaJSVYHbVa/M19/1Nd64nZBJYcH0EYflMWmdpr8voRhIa84EU3VRXu+j2qQhXnilknjcJtl
	uNoUmveED7Rc//kKwEeG/dS2pf5R9V7QlsIjy4huDRsqjIHcFAHuENS1J7icFX0L5XsWmxtoeE=
X-Google-Smtp-Source: AGHT+IHJijl0PKSGqDIox/2BAekV76NhhdQyoQ2Z7mNcryvxf/52rpbaolTA3Dgsy5UCsyCgwo2Ey8/LL7TfzvkHoFI=
X-Received: by 2002:a17:903:2345:b0:24c:da3b:7376 with SMTP id
 d9443c01a7336-2902726438amr426383005ad.26.1760565368993; Wed, 15 Oct 2025
 14:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760490943.git.belkid98@gmail.com> <aea3b80a8883c4dac4e05defdee3eb82b83fe8c9.1760490943.git.belkid98@gmail.com>
 <CAP8UFD1U07T8_nX+sSL6ZHhCQsQuy5PwfQfbHC5piC5W5T=7Cw@mail.gmail.com>
In-Reply-To: <CAP8UFD1U07T8_nX+sSL6ZHhCQsQuy5PwfQfbHC5piC5W5T=7Cw@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 15 Oct 2025 22:56:09 +0100
X-Gm-Features: AS18NWA6fYMH5dhZ3ehFxqifnXseoG-uUo_nBVAGrm5HAg9qkYRNkOhmZ0VH8MU
Message-ID: <CAD=f0L_Jb8Fx9k8fU70qJKMw4oQh23f5H-BbQg-WrnSfsCTfAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [Outreachy] gpg-interface: replace strbuf_split with string_list_split
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 16:01, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Oct 15, 2025 at 4:19=E2=80=AFAM Olamide Caleb Bello <belkid98@gma=
il.com> wrote:
> >
> > get_ssh_finger_print() accepts a signing key and then uses pipe_command
>
> "pipe_command" is a function too so it's better to use "()" when
> talking about it like in "get_ssh_finger_print()".
>
> In the commit message subject, if it doesn't make it too long, I think
> it might be better to also use "()" when talking about functions.
>
> > to execute the ssh-keygen command, gets its output and sets it in
> > fingerprint_stdout.
>
> Anyway I am not sure we need so many details about what
> get_ssh_finger_print() does before the split.
>
> Maybe saying something like the following is enough:
>
> "In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> put into `fingerprint_stdout`."
>
> > The string in fingerprint_stdout is then split into 3 strbufs using
> > strbuf_split_max(), however they are not modified after the split there=
by
> > not making use of the strbuf API as the fingerprint token is merely
> > returned, hence they do not need to be strbufs.
>
> It might be interesting to say that the fingerprint token is returned
> as a `char *` not a strbuf.
>
> > Use string_list_split instead for simplicity.
>
> Here also using "()" could make it clearer that "string_list_split" is
> a function.
>
> > Note that strbuf_split_max uses 3 to specify the number of tokens to
>
> Here also using "()" could help a bit.
>
> > extract from the string, while string_list_split uses 2 because it spec=
ifies
>
> Here also using "()" could help a bit.
>
> > the number of times the split will be done on the string, so 2 gives 3 =
tokens
> > as it is in the initial instance.
>
> Maybe: s/initial/original/

Thank you very much for your review, I make the adjustments.
>
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>
> [...]
>
> > @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *=
signing_key)
> >                 die_errno(_("failed to get the ssh fingerprint for key =
'%s'"),
> >                           signing_key);
> >
> > -       fingerprint =3D strbuf_split_max(&fingerprint_stdout, ' ', 3);
> > -       if (!fingerprint[1])
> > +       if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) <=
=3D 1)
>
> According to its doc, string_list_split() returns the the number of
> substrings appended to the list. And you said in the commit message
> that it should give 3 tokens, so I think the above line should be:
>
> if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) < 3)
>
> or even:
>
> if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) !=3D 3)
>

Okay, thank you very much Christian.
My thinking here is that after the split, it is expected that the
fingerprint token
will be at index 1 in the list so string_list_split() must append at
least 2 tokens.
so if it appends 1 token or none, I assume the fingerprint was not set
in the list.

I agree that < 3or !=3D 3 is a better approach.
Thank you.
> >                 die_errno(_("failed to get the ssh fingerprint for key =
'%s'"),
> >                           signing_key);
>
> Except for the above points, your patch look good to me. Thanks.
