Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09822360A3
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmDzdq4B"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso657481066b.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 01:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704794207; x=1705399007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KPWpLlJzixgyK+8QsLciBaM05+Ta/Wlqo+PsNpTxfI=;
        b=YmDzdq4BjeOb1flgGoemY89iDrNwzjsti6VxhdNx/fR5bn3PSw+rMaz21rcN3tXWhx
         x5/tvsBINcITI5oRdo+YAjkhiu2zzQ77H2gGgkeo5KCWoQ55Ov8lt2TNIiHMEkDLkKxv
         Xodl951dmTbXctUz2736yRipwts1GH0iNE1n17ozadBYLNiaJSEOBWRoDTgaxpDqmGEW
         ZVuksNN0B/SSDqvyK8kEa96OHuMQkxcxdJd+Jxc8T+vf5Xk/fUj7D65sHWRPYL4tmHxY
         IICt30zAlmYQc7WhXl6pSGNNMD/VtLV0sTDw6ZODJ/fOP1yPGU3quVXdY04a/PWw8C0S
         FJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704794207; x=1705399007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KPWpLlJzixgyK+8QsLciBaM05+Ta/Wlqo+PsNpTxfI=;
        b=rw//1vfNKpLBbSkBoBykj4HzKm3PLkZZPWFcpr+4Kmhs3TNv4n6peB+RUB3WgLgZeH
         AbB4wf8X0gwUNTMDQKrf29y1phpGGSnCT59rMVPq5wz7YtlOWxuclXfIdXukMi3SCbXp
         461Ig0FNCd2l8XkpqIzDER3IfdYYm2OZ3slaiy1hd9Lcl9RD8UIV/6GS9ZcQIMAPQmdV
         3FDCD93LHh0VZyBXbtPm4/vUJy0Mzz67U4zkxsmrRoooxuCLPJB6hofuxCrIAhFFu5mW
         VMqwBojH6qj4Sy8HRXueqJ57T8jtlE3k+R43Y8vXUli+NaBsckyjG+MXykCuf9SB63Nk
         LVkg==
X-Gm-Message-State: AOJu0YzYPwqt/kuYMYPi2aHPTat5y5N6oirML9piArygsRNShimQvque
	nU4vgZoUlumljahmwVodnH11Te4LfRqy2g0ENi0=
X-Google-Smtp-Source: AGHT+IF93urWV6Dd5BbEIzzRdNQ3IYBgpgj9xlXD9bJkreC1WqyLfqIYLKHXMXvkKVJuh2qhPTRuCTAmw9WEoxw5Otc=
X-Received: by 2002:a17:906:ff42:b0:a2a:2209:5e14 with SMTP id
 zo2-20020a170906ff4200b00a2a22095e14mr372595ejb.37.1704794206914; Tue, 09 Jan
 2024 01:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me>
In-Reply-To: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Jan 2024 10:56:34 +0100
Message-ID: <CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com>
Subject: Re: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a microproject
To: mohitmarathe@proton.me
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "gitster@pobox.com" <gitster@pobox.com>, 
	"britton.kerin@gmail.com" <britton.kerin@gmail.com>, "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 8, 2024 at 6:38=E2=80=AFPM <mohitmarathe@proton.me> wrote:
>
> Hello,
>
> I'm Mohit, an undergrad from India, and I want to start contributing to t=
he Git project. I have already built Git from source and finished `git psuh=
` tutorial. And I must say the "Hacking Git" documentation is great (very d=
etailed and maybe exhaustive) and easy to follow. So I also read the topic =
on "microprojects", and while searching for one, I came across this message=
: https://public-inbox.org/git/xmqqjzpjsbjl.fsf@gitster.g/.
> I want to work on this task (if it is not taken up already) as a micropro=
ject for GSoC.

Thanks for your interest in Git and the GSoC!

> Approach:
> From what I understood, the idea is to *not* allow non-integer characters=
 in the arguments by printing an error message. So we have to replace `atoi=
` with `strtol_i`, like it is done in this patch: https://public-inbox.org/=
git/xmqq5y181fx0.fsf_-_@gitster.g/.
> There are some places where we want to continue to parse after the end of=
 the integer (where `strspn` is used as mentioned by Junio), and based on J=
unio's suggestion, a new helper can be created like this:
>
> > static inline int strtol_i2(char const *s, int base, int *result, char =
**endp)
> > {
> >       long ul;
> >         char *dummy =3D NULL;
> >
> >         if (!endp)
> >               endp =3D &dummy;
> >       errno =3D 0;
> >       ul =3D strtol(s, &endp, base);
> >       if (errno ||
> >           /*
> >            * if we are told to parse to the end of the string by
> >            * passing NULL to endp, it is an error to have any
> >            * remaining character after the digits.
> >            */
> >             (dummy && *dummy) ||
> >           endp =3D=3D s || (int) ul !=3D ul)
> >               return -1;
> >       *result =3D ul;
> >       return 0;
> > }
>
>
> So I searched for all the occurrences of `atoi(` (as suggested by Junio),=
 and I found only two instances (both in `builtin/patch-id.c`) where it is =
followed by `strspn`. Is it safe to assume that this is the only place wher=
e we cannot directly replace `atoi` with `strtol_i`, or should I keep diggi=
ng?

In https://public-inbox.org/git/xmqqjzpjsbjl.fsf@gitster.g/ Junio says:

"Some places use atoi() immediately followed by strspn() to skip over
digits, which means they are parsing an integer and want to continue
reading after the integer, which is incompatible with what
strtol_i() wants to do.  They need either a separate helper or an
updated strtol_i() that optionally allows you to parse the prefix
and report where the integer ended, e.g., something like:"

and then he suggests the above helper.

So it seems that the two instances you found look like good places
where Junio says the new helper could be useful.

Now if you want to continue further on this, I think you would need to
take a closer look at those two instances to see if replacing atoi()
there with the new helper would improve something there or not. If you
find it would improve something, be sure to explain what would be
improved in the commit message.

> Also, this seems like a large change due to the number of files involved,=
 while the documentation about the microproject emphasizes keeping the chan=
ge small. Does it mean a small change per commit or a small change per Pull=
 Request?

I think that adding a new helper in one .c file and its declaration in
the corresponding .h file, and then using it in another .c file would
change around 3 files and would be Ok size wise for a microproject.

Thanks.
