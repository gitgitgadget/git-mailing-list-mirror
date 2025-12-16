Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1733CEB9
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865905; cv=none; b=VTRmLrcyelLQuTfTA94tfLsSDFP/PJd+Eec3ECgLc9eKI89+ev99DJlaQMjHHOb9oELhIPkMGRgS9BmDIEZlEj/L1m22UNENfIMmrryDz6ErNS4FhatBY0+KKT0QX2nmTC1kdTehikU6EM3yhdL1cGQKg2ByF/zwiE4PBx0J/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865905; c=relaxed/simple;
	bh=PJR9DpUcHneZ2xWqrQ4eNXcBq8u3BvR5cVFw848fqf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVnceRGAYDi8u1wvqm6L94Q6UTQGS8Fi+CjP3hskwu7zJQo1Ez5PJXFdRBe9AsFpAPClt/ycaZhSdUNr0M3Du8xVH1gw1w95oCiPH3zIYRyTfr9ERgrcT+uT4Blxe5Ds0Dbzd8nH0PilIujje7woznNT6ETTBpMIrKrQ4lSc6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXiA6ovy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXiA6ovy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c38149f9fso33499657b3.2
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 22:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765865898; x=1766470698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvFZsxTw9GOXVBpr04R0JIjYSwWQ5nzqfEONuaWWVhY=;
        b=JXiA6ovyAuyd7tHEd9QJtaeLz6/sLkAJw+7HGBABreJVJtfpn9sGKNc0MCnp0RkEn3
         lDCRqV7l57emEPzGyLFK0r8iqrhdAY1cezqt2Afl6wIQPrX1uF31T8wQXGn9ba5u3Cb/
         1SDph8JAK2JyOLzV5AirVbPwZm7G0vOIJUfuT2xAiBDwg+hpMCbL0WZp6CwOBIt2jG+o
         0hAVzCeIEj5V/7v4hZOYyKGjRkdRamQ8MuS1wAMlK1Idbtq3UMeTMbveubYRgKtvafOE
         kMH7AGFCJMlJXj1y4TM82XE2QRnb3L/zhfXus4YgIf3JVBVoSdAI7ILW3jpJEj9daOZp
         jMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765865898; x=1766470698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZvFZsxTw9GOXVBpr04R0JIjYSwWQ5nzqfEONuaWWVhY=;
        b=Yoluk/qKPW3ybQH3oG3vUw7dEOOUtN4+C2l2t45ObD2biLVAgZWUTEpXvcl3CeF9jj
         1eH87Pu78lmxItsurwcotRISGBl212H9Ge1Xsz1UqT1UjzCDl40KBD5o29FeeMg4KiWc
         kqWZcZDY8Ghf8/IUiCPYnN7CsygwfuP7fDyFWfiEe7WEveGa62odoaNsAN6n1bmRnqef
         dKLaYUWbBF2Ubgm2tekMNwRfgnEiJ9QTEIY1QEhNLGu2AhUHjMGdBd0e/WSoFzzmrQCz
         lO9viq0k0Od+o64KKACfZnqCfeSFUdMAmMNclLPLoXzmCUi0Ci3MTR2R/8SHhTJyf9ML
         h0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUlxvTH4U0y0z5OSmsiRFF7qXQ2/AGMAHb/pCrf+LLQO1tc+oBqrOaPmb7wE0CZmw7wt7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRhB3bzYRojZz/Qs9eKHTpV30eXecv0KX8/L4GbvKVBNEsyt0
	9KZTB4wKWt1h26jal+JNfScfdkKk4RoV34pQP7AHYHA2VBKxZc4bkkbEGOZUeuiYDIhXQ7jJdt8
	lBGkzyWi/bKKtVPyeR/6njfr8jwtQXys=
X-Gm-Gg: AY/fxX5oPf7q8tD3IbyumMVbhn3/vJwrmX+ZggxSCP16DThAimyWx/SAMGMRYJUUwCL
	wEd17Jp2iJZxj3glh8CNbs4WHTl8UQTxfVfskV+MeeQyKSSorbtuNsn1k49jGulU/5vjoL+xR2t
	vDpNUOvgzqdPD0RPs7M+JJawmH2PoKlPnAS+SFOrzLdWMUwalwJ6w2AaatDTN6k8MnYOFwJZTLV
	MEiXQOZ7J0+IHcaLo8DVlR8AD/8c9aTo49eB9dfOi9u0oVHy6jRGq5bFtaleaj+p5sngg3Wn0oB
	89IV/4r3VT7O4lLvPHxgN2TQl6XpFiAQTZ+yz5EGN0/sqUHz+eU8PwlyULFPVsyzU+QiIFk=
X-Google-Smtp-Source: AGHT+IGV0f8/Y1SB1towun9Y9EEai/92vXccHlJfw5pOwV1k+MjjmrNanQkhyo9WgNGzntTAyK05ImzhaZm+E4U4wG0=
X-Received: by 2002:a05:690c:6e07:b0:78c:2f4a:b67f with SMTP id
 00721157ae682-78e68433551mr107069967b3.55.1765865898403; Mon, 15 Dec 2025
 22:18:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209225820.2861276-1-jltobler@gmail.com> <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-3-jltobler@gmail.com> <CANYiYbE3Tx6B5L5rEoDue7hTYzFGxw_qA-MRpC9RSxQ7HRczaw@mail.gmail.com>
 <xmqqqzsv3uus.fsf@gitster.g>
In-Reply-To: <xmqqqzsv3uus.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 16 Dec 2025 14:18:06 +0800
X-Gm-Features: AQt7F2ra2V4odE_UgtJOLJOe1rghfTJR1sF_xDGpnWhtKHj5scYT954QjpTYcm8
Message-ID: <CANYiYbExjGoCw4n92a75xtREE_EhjEySVSmk=NwJd3GoMAoVLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 12:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > On Sat, Dec 13, 2025 at 6:37=E2=80=AFAM Justin Tobler <jltobler@gmail.c=
om> wrote:
> >> +               return humanise_rate ?
> >> +                              /* TRANSLATORS: IEC 80000-13:2008 byte/=
second */
> >> +                              xstrfmt(Q_("byte/s", "bytes/s", bytes))=
 :
> >> +                              /* TRANSLATORS: IEC 80000-13:2008 byte =
*/
> >> +                              xstrfmt(Q_("byte", "bytes", bytes));
> >
> > We have already defined "byte" as a 10n string without plural forms in =
the
> > file "t/helper/test-simple-ipc.c" via commit 36a7eb6876 (t0052: add sim=
ple-ipc
> > tests and t/helper/test-simple-ipc tool, 2021-03-22 10:29:48 +0000).
> >
> >     OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character=
")),
> >
> > The newly introduced usage of "byte" is now marked as having a plural f=
orm
> > (via Q_("byte", "bytes", bytes)), which causes a conflict. This results=
 in make
> > pot failing with the following error:
> >
> >     msgcat: msgid 'byte' is used without plural and with plural.
> >
> > This happens because gettext requires that a given msgid be treated
> > consistently=E2=80=94either exclusively as a singular string or as part=
 of a plural
> > construct=E2=80=94but not both.
> >
> > To resolve this conflict, we can unmark the singular "byte" in
> > t/helper/test-simple-ipc.c, allowing it to reuse the translation from t=
he
> > plural-form definition of "byte".
>
> I learned a new thing today and am happy :).
>
> But how does one "unmark" the singular "byte" there, exactly?
>
> Would something like this ...
>
>      OPT_STRING(0, "byte", &bytevalue, Q_("byte", "bytes", 1), N_("ballas=
t character")),
>
> ... a good idea, to "mark" it as a countable noun that has a plural
> form?
>
> Or did you mean that we can simply drop N_() around it, i.e.,
> N_("byte") -> "byte", to discard the i18n, because it merely is a
> test helper?

I prefer dropping N_() for "byte" in "t/helper/test-simple-ipc.c", and
the i18n for the test helper will continue to work as before if we also
mark the plural-form of "byte" in this patch series. (i.e., drop the N_()
for "byte" in the test helper in this patch.)

This is because N_() is a macro that does not invoke any gettext
function, only returns msgid as in gettext.h:

    #define N_(msgid) msgid

And the actual translation for the msgid (the argh field of an option)
occurs later by calling:

    opts->argh ? _(opts->argh) : _("...")

in "parse-options.c".

However, replacing N_() with Q_() would cause the string to be
processed by gettext twice: once at runtime via Q_(), and again
when _(opts->argh) is evaluated.
