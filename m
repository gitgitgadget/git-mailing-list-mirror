Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E4242D70
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048789; cv=none; b=uBIjr1ad7JpxprmOqR8/kMG2zzwbJe8+CKVwqq/Vme9UuDeI0AV5ptz6TajlwmMI8nInvVQZzFi7S9eaUj7OCtlYUy+ia1I805NjxzS5ko+/PhyA7e04zRBc8v3oIQJi6+UT0jgmYY8MeD2++SSxdi5kEhXhbDohNox972o2Nl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048789; c=relaxed/simple;
	bh=85VwSsjMWoCVh0ZaziOOjWB36O/z/DHGopUlS5r6JsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI8GL0anZi4nnV2NAHh0n6/BWyVzUnaNBVZjuNVoFXyjZkifL3p6R6BVHNoZfmJ3oZgr+RdJt8pluGDzwRiq1Uv5cCfcq5KP4+rcb0j+RVpdUZKHfYTsPOhk9m6aTmh9iKUFlXdcnqojPMuImPEKq5xDEFqPXzBgSc1CjF99a2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRpj4o50; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRpj4o50"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so4554791a12.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761048784; x=1761653584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiR6rEGM1uKP/ocm0Z58dtKSV4IvNBLVki7KNEV7WVg=;
        b=SRpj4o50AQMWxHYuRa8OvsgAIUtsO/Pxd67uWjX7j7nBH65xG/Cu3nNV55ysU6nUxC
         Z7VOuNMux9deIr/ffxw5/DIY337IcYnC3rgcO764R+HTZzz6C2xhupY7abY+neiPcZ5O
         ZS4+Fi1K/PsI74SU5kVEcidWF1wt4NqWmXjxrZmJJCYl+tk01VJaCPOIHUEHWP17D1wc
         9+xvHOq47i0TmHHJupUVhilJE9ArP0iOS8bCuDE9HR6apBhyS+C4kW2kJGXh3iiDDzDE
         tQ4x9z8fssmkme21llENTFtbbLRfn4RK5UotIgdgYKf19I9IL6yj3R8CcN2zokhhDCmf
         V/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048784; x=1761653584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiR6rEGM1uKP/ocm0Z58dtKSV4IvNBLVki7KNEV7WVg=;
        b=uKBEKGoeYFyvYqcWZLylHbdgSk9z/e8fDsVeeIFq4y/PciN7uo0y4lIVoxDkXSZYKA
         ya6hwdNjtOAqwkKWsij2wi5v0QzVyqchOhpNY7mREhxkW2Ma4OIeG3QGeuYOQTQnwYgc
         aG++8NyQ5Y+VCaOe1RBSunnOXIRmEZFRjnq1dG6YxyCcVIezPkOdwFecARr5IhxgKb2K
         uAsq52CibC4jJ0eXLQLI/PW0+lbJ0KRA0avm6kC/dw6VdPhrtjq9f9HqcXLRv8PnatEX
         3D4Kui4PWqtWvMUFGhv7RwNzdOv6QQ/lJhy0sKnTKgeKAQ62+t7+kNgKKNE7dnyBhoiz
         PtAQ==
X-Gm-Message-State: AOJu0YxEc0aWYHJi+PndJ3izwMB6mHS9+RWzcAId+esrn+bqOf0e9akr
	DQv821YyQGimiJ/lyiBXlzqocWr/ZnP9R9o8BRzLfhwWrA+OXY28DEkwLogAOqtA00pb6l7MQtU
	0cEEcuboIzQd7vpkN/Fz4ePyoOWGmRxw=
X-Gm-Gg: ASbGncsZqbG/Jyv2qCQ6W6w+7PB61LChn7PTAysilsMB5biFWgvG0G3fDVa6bUnmg3K
	ojg38HWlW9E5sDMEe2xSxk2pa0IQJXm5Sfbavnpq/bwydgjMIW9efjeoITDMxuVQDNp1uACVmci
	w5mGSOonvyk+9l/zQ2vTOJXUJB3sISGJhSxuHkXivjfHGjxkFP9P08A5engRT/QYFJMYLTQWnV6
	yD9F+ZHWPRnKM9vJjrCIj+bSkM2V+qj3IlP7gvQlYehYUhSbeeDL3IoAM50QQ9ozrKrj1g1
X-Google-Smtp-Source: AGHT+IGbCz4By1hQhtakoAnvWG75//loyJcH6Rr8LZSbTG4g+gE6eByCrehzt6kH1XEY4OLjrI+7jJf1SYVRr/c8U+c=
X-Received: by 2002:a17:903:1a4c:b0:24c:c8e7:60b5 with SMTP id
 d9443c01a7336-290c9cb6242mr213907545ad.16.1761048784486; Tue, 21 Oct 2025
 05:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com> <a830de15ecdb5e5f45625927cb69b2be552bda42.1760997183.git.belkid98@gmail.com>
 <CAP8UFD1-H5jRyd6b5FhgCMLObnErXVr8p0s+kMd0qO5jWkkt2Q@mail.gmail.com>
In-Reply-To: <CAP8UFD1-H5jRyd6b5FhgCMLObnErXVr8p0s+kMd0qO5jWkkt2Q@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 21 Oct 2025 13:12:52 +0100
X-Gm-Features: AS18NWC1ho5wPylkgTW9KCypAf3r-_kW0jwYXssadMPCSCqTqwGrb6NXGObdq7I
Message-ID: <CAD=f0L9sn_D437PM1LQdaY=nGCtEe0yg3Nq7_d6-yupE9pMMZg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 2/2] gpg-interface: do not use misdesigned
 strbuf_split*() [Part 2]
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Oct 2025 at 08:01, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Oct 21, 2025 at 12:57=E2=80=AFAM Olamide Caleb Bello <belkid98@gm=
ail.com> wrote:
>
> [...]
>
> > Reported-by: Junio Hamano <gitster@pobox.com>
> > Helped-by: Christian Couder <christian.couder@gmail.com>
> > Helped-by: Junio Hamano <gitster@pobox.com>
> > Helped-by: Krisoffer Haughsbakk
>
> I won't repeat the issues that are the same as in patch 1/2, but
> please correct them.
>
> [...]

Yes, thank you.

I will fix them.
>
> > @@ -887,19 +887,21 @@ static char *get_default_ssh_signing_key(void)
> >                            &key_stderr, 0);
> >
> >         if (!ret) {
> > -               keys =3D strbuf_split_max(&key_stdout, '\n', 2);
> > -               if (keys[0] && is_literal_ssh_key(keys[0]->buf, &litera=
l_key)) {
> > +               begin =3D key_stdout.buf;
> > +               new_line =3D strchr(begin, '\n');
> > +               first_line =3D xmemdupz(begin, new_line - begin);
>
> What if no \n character is found by strchr()?
In the original code, just the first line of a possible two lines
is returned.
So since we need just the first and if no new line is found,
I can do
                char *end =3D new_line  ? new_line : strchr(begin, '\0');
                first_line =3D xmemdupz(begin, end);

Does this work?

Thanks
Bello
