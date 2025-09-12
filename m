Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE428641B
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684161; cv=none; b=F6/QVoccWIj6YQKjk+YQRI9RwpUV7rKjR0pdclvvS2ufp3CuVj0hcJ2vBTabXd5hTtkpN17GJHYWZ79fcYgQkDZsV7bjEn8UIyKL+bNeB/mg8bK6+ikfuaaEI/pj92copsSSMdkDzEeY7YOZ5dHYeOFFKELezQsvY5KaLeV+wc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684161; c=relaxed/simple;
	bh=/4XQpS3462nQbvwVDHFTt+YDOiuQOymeRSR241k6YE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/CNT6s3VY0PKNRy4HE9UV51U5VwBOD2DmXqT/qhusT8JsYAEt0mfs+bm3ZQPl6114IyunCzc9jzCXCcnIHLswB/kkAfAF+NGJtgodtNybBMwZzZTxogLvuEq22ZyjALbFXsAhsoMsaIQ3m0C7dE4oD8YyeMPDqjkz684TaE4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA1BYDxM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA1BYDxM"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so298054966b.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757684158; x=1758288958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bb0f2KiTE5O9KGuBtEgmo90DphX8Nbft0BJ0h/VUh8=;
        b=GA1BYDxM8Q4hgocTAzXS0BM/qHG56buVsBfKMyV61B4mickRUh/DcrisYxerpYZ3kx
         AzHfahLeLxr2i3+DcUkSUgzVv4KOxJbk8/IPXFPo4HFVeV2BdSpchHQc4fpMr9xO1d7t
         TejKl99dMtdgjH5AAOHdB76wBZBFlidvkZjUWaBF+WXbYsr3hHDfKnhpv/008fYnxmij
         7f/w1YS/9jWMkbMXlISNqrryxmHL6BFm7qRC1Hk15g5zq+kwb+TfKsG9FFc4RD1yNcgA
         v+CtRXm3wAS+gcFe1bKhu0s2EicY2gehf/EE4giyBKMu2Nu+jMDZKEwFoid29kQ+T+SN
         heqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684158; x=1758288958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bb0f2KiTE5O9KGuBtEgmo90DphX8Nbft0BJ0h/VUh8=;
        b=Ex/nZUqIt12vJlq2Ya/nUDDR2Vw8THciKbyShNmDDg5Z0QNyrsiP3sdcYFLjl093Nw
         tAs5IdY185hxehSuRkLW4n1CSbvrww/8OYahIKyXyiGi+zY/6y4A12XVatJoC2jvKjYg
         gPNY5AkL95clm/UhaPiWgXvFQQNOyTUmnuGofI+70YSyGuXVZwri5RLviT05Umg2PVkw
         l6mardg8h685ACRAY1cXBju1X8RR289lPx1GSdboWVyV0G+lBd3B0WhxLjTAY0OkJBqQ
         M8Nj5eKGPecGUdwqN65bjKgDctDNBcFwk6I6CHv2bjvNEgQXyp6wvQiGcW1A6UWjkf46
         lB6A==
X-Gm-Message-State: AOJu0Yz1Nw+tPKY5FOd7Pq3BWzkCV5xf6Mjd2vEdGKdwmZHn10rXOlTr
	N5a4HSAvYx37GtMUoS8oRLXWQC3BDy7+XHCSFHelX9evWYJcEAASQx0o4xrz/2Kph8D4/6YH7RT
	zeSIEq6IVr4NdovLbvI9YCD8g39xRNaM=
X-Gm-Gg: ASbGncsE7UZjWF1CBjsDBPsmg4m2vZUFKTVbOGfnYjDJw+kepbGDRDpMMGxaPF4DmeB
	BdSVX8jCxJJyEWWEmqaJEX4BTRFkh625VkphDwBAcGJ9mjN1T8FtMJGhv/nFSnbey/MOwXVwICM
	ikkcKHq14r9r/LT5xSM2vLUW1KD4sK9YVKQrhmtr/rrl3nZVrVn4JjkfqPltzg9oEgrlJT25F3r
	8CmfJ/qLA==
X-Google-Smtp-Source: AGHT+IGoL6ZI85bTg6F8yAyaOyp276gZYK5PG0jAoQzn9DjAq9YFInuzEv7MBaw8UFwjEElTkKjo59yD/jccoAj4s1s=
X-Received: by 2002:a17:907:3d9e:b0:b07:c28f:19c8 with SMTP id
 a640c23a62f3a-b07c37fa397mr330281466b.30.1757684157656; Fri, 12 Sep 2025
 06:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-3-christian.couder@gmail.com> <xmqqtt1as08f.fsf@gitster.g>
In-Reply-To: <xmqqtt1as08f.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Sep 2025 15:35:45 +0200
X-Gm-Features: AS18NWAtZ9XziVXwyglPN5RzdeAk5dkaU8DUoPL5FXz0BzJ9HFaB61XyN4RMY68
Message-ID: <CAP8UFD0EAuGdMWY2ff_kjaQnZ3w7VP2ftM6Y4Hr3T4HQTsFB3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > @@ -2785,6 +2787,23 @@ static void store_signature(struct signature_dat=
a *stored_sig,
> >       }
> >  }
> >
> > +/* Process signatures (up to 2: one "sha1" and one "sha256") */
> > +static void import_signature(struct signature_data *sig_sha1,
> > +                          struct signature_data *sig_sha256,
> > +                          const char *v)
> > +{
> > +     struct signature_data sig =3D { NULL, NULL, STRBUF_INIT };
> > +
> > +     parse_one_signature(&sig, v);
> > +
> > +     if (!strcmp(sig.hash_algo, "sha1"))
> > +             store_signature(sig_sha1, &sig, "SHA-1");
> > +     else if (!strcmp(sig.hash_algo, "sha256"))
> > +             store_signature(sig_sha256, &sig, "SHA-256");
> > +     else
> > +             BUG("parse_one_signature() returned unknown hash algo");
> > +}
> > +
>
> THis is a new function; I am not sure if the division of labor
> between this one and its caller is done right.  See below.

I have removed this new function in V2 as I think I implemented what
you suggest below.

> > @@ -2817,19 +2836,28 @@ static void parse_new_commit(const char *arg)
> >       if (!committer)
> >               die("Expected committer but didn't get one");
> >
> > -     /* Process signatures (up to 2: one "sha1" and one "sha256") */
> >       while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> > -             struct signature_data sig =3D { NULL, NULL, STRBUF_INIT }=
;
> > -
> > -             parse_one_signature(&sig, v);
> > -
> > -             if (!strcmp(sig.hash_algo, "sha1"))
> > -                     store_signature(&sig_sha1, &sig, "SHA-1");
> > -             else if (!strcmp(sig.hash_algo, "sha256"))
> > -                     store_signature(&sig_sha256, &sig, "SHA-256");
> > -             else
> > -                     BUG("parse_one_signature() returned unknown hash =
algo");
> > -
> > +             struct strbuf data =3D STRBUF_INIT;
> > +             switch (signed_commit_mode) {
> > +             case SIGN_ABORT:
> > +                     die("encountered signed commit; use "
> > +                         "--signed-commits=3D<mode> to handle it");
> > +             case SIGN_WARN_VERBATIM:
> > +                     warning("importing a commit signature");
> > +                     /* fallthru */
> > +             case SIGN_VERBATIM:
> > +                     import_signature(&sig_sha1, &sig_sha256, v);
> > +                     break;
> > +             case SIGN_WARN_STRIP:
> > +                     warning("stripping a commit signature");
> > +                     /* fallthru */
> > +             case SIGN_STRIP:
> > +                     /* Read signature data and discard it */
> > +                     read_next_command();
> > +                     parse_data(&data, 0, NULL);
> > +                     strbuf_release(&data);
> > +                     break;
> > +             }
> >               read_next_command();
> >       }
>
> I am not sure if this change had to be this way.  The old code
> always called parse_one_signature(), which was responsible for
> checking the signature format and then calling read_next_command()
> and parse_data(), so no matter what happened afterwards, we know we
> are consuming the data stream regardless of the conditional execution
> that happens here.
>
> The new code calls import_signature() or an inlined sequence of
> read_next_command() plus parse_data(), essentially making each case
> arm in the switch() statement responsible individually for consuming
> the incoming data.  When somebody adds a new case there to specify a
> different way to handle signatures, they have to make sure that they
> do not forget calling read_next_command() and parse_data() themselves.
>
> Even though I can see, after some code inspection, that no branches
> in the current code forgets to advance the incoming data stream to
> leave us out of sync right now, this change feels like a bit of code
> ergonomics regression to me.  Was it so important that we pass a
> broken signature without inspecting in STRIP mode?  I am guessing
> that is the reason why the new code tries hard to avoid calling the
> parse_one_signature() function in these case arms.

Yeah, I thought it was cleaner and a bit faster if we don't parse
signatures when in STRIP mode. That's why I did it like this.

Now as it looks like we don't really mind parsing them, I implemented
that in V2. In ABORT mode, I still think it might be a bit better to
ABORT right away though, so that's what I implemented in V2.

> An aside.  I think the warning message about importing should have a
> word "verbatim" in it, e.g.
>
>         warning("importing a commit signature verbatim");

In V2, I have changed the message to what you suggest.
