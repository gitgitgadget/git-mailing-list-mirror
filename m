Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696611E1A33
	for <git@vger.kernel.org>; Mon, 26 May 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250300; cv=none; b=VmzZVoyQPE+u4wY676Asb88+Kz44PPkVwozNaJMsRyokZ9pWxMQnIz7IrKDe9THxMMsYv2aAguQxd0khui0xXGy/rTmMUsomRdPr/sCgUh9L29KzsRzqppMP0eJOK+cnJZDYgpvhlTb7cYPdyiOW9r965+aAspPY4SBCyXEPkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250300; c=relaxed/simple;
	bh=1IaFtfKQt78T7sjohH2UISqOyjvGiFr76KCvBpRfxYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdwCiNT1aCMxmSPbm6S76IO2JN86T3M8w4y1UJKK4ATYDWUvgamz25D7CgEAcAE0S3z/jsSPc/E8t1UndnjhOCwlFnuP827jpbPUCqvfkyF5S45hz1gCILuF7KBpZdnxEPaX9F5bk7Rm2T/DusrK9oujzP/bhrPHzk3dGnrLP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFBQG5FW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFBQG5FW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70825de932bso26922827b3.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748250297; x=1748855097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saPyA3/vpJ+BUNmkaj/KPP7BwyOgnyvsCJ+c/ah6IDU=;
        b=EFBQG5FWDnLg3sZzVDpZUI/vQCB7FjEZ7OJcomN/Ym1M2i1RKGVZ3WPqGW2sINFHoS
         Z0jM+xxnentD549x7bDuazS+qKPJW2biaxOLa8HaSlFwz9Yhs//Ti+TZQLz3V3hXySI2
         qxrxzt19Ky3brm+mnldlMctNpE8Z3g5MKJFkVpqLbbNTPWPrYipSHTlmBCiz9f2NWDA0
         k8DIgZiNEsBfmBfnTrrWt9YtFW5iEq2UdhnrAKn33eb2khV0ylAap6hXftBv4ux2pgQY
         aDPAmpXSYkzQMJdWUjJSepEa1LK/Jca7kUnlbs8e1YscRgFERejf7PsKrsrDISsDd7l2
         xzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748250297; x=1748855097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saPyA3/vpJ+BUNmkaj/KPP7BwyOgnyvsCJ+c/ah6IDU=;
        b=K3prrWJ9DF/tYLK6+7dL45g3Z1sNVKH9HVGBVHZy09qnQJ72WqNp8Yz2Y0VrDiYldi
         PdbtZWieYPT+hl2c7jXlsPjjPHOw+jISaaq1djesjMIVU/tHsUpq/FfAkct+ZBODhOzE
         rYGeEzIgWDTRKLq/NbdVWJeGUUwDf3SD3/n6Xgfo73vdDtBcCUpciaq1Xm6+N4oLgRp4
         sVajRwxk/ADUcNCsI4pzUs6Zgo3D/aVqxjzxjlRNJCvXDaRHuk4+yWNOyn0fhGNR73XY
         l5ekhAxUEfCWnygbgeV6adgBf9+UnaUI4acivyFcu39rLTGpQBYPu/Zau2t/HbisKW27
         h5pA==
X-Gm-Message-State: AOJu0YzOJAbLBistJww8LBZKGm9qFEgWy6MU/Gq47NwwyF/CyoCrTIvd
	G+jNnONdiFLwyjC7nRa/69e2JIyjDnOKvSKQPRE36o/bULrroi+5orD7W6fCJI/gu5fxj7cdnVB
	R3ApnXOEOitgzeO8UlfspP79/nAZ4RyroL0Ls/HIIFQ==
X-Gm-Gg: ASbGncvNtAUFCvdpvvgBANhp13pVrz4F5KHkJCLIcc2xiOyuStyHy31OG4e2AW0iFlQ
	TVgkoq3ctaqLUKwlyGjxutGFb2a/QSYjwBYFhCFEaG7Sn7y0LHfRWyinlo1j+UA9CzalhtihmZ/
	Y/10T6s309LAz1uukBB0gFWknSt4jnwH8asXK/7GnVhTM=
X-Google-Smtp-Source: AGHT+IH6/EIuuv7SR7h/q5sbOjPa+L1DKkENxphb1fVcXUh1rFEFNYeUkQHtKelsg3qpX5qGUjIjJkuKv5kQy9rmdbs=
X-Received: by 2002:a05:690c:6288:b0:703:b47a:7312 with SMTP id
 00721157ae682-70e2cc54c90mr92879217b3.15.1748250297176; Mon, 26 May 2025
 02:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429175302.23724-1-kuforiji98@gmail.com> <20250429175302.23724-11-kuforiji98@gmail.com>
 <aBSXJcT8REHWrsrx@pks.im> <CAGedMtdRwsBwRK6ENaJfbZ1tba4jD1WMyk3HdFft3sC6H2001w@mail.gmail.com>
 <aBiKUGn7avRUcehV@pks.im>
In-Reply-To: <aBiKUGn7avRUcehV@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 26 May 2025 10:04:43 +0100
X-Gm-Features: AX0GCFuUJgLrKlzvYgUTP7Zla0LeSVD_yNmsRDDjzhxAmgnOuy63odBAtUqZ5Gw
Message-ID: <CAGedMteAkHj0xc2iq7T+CWa=uJWWg0me8hD6x=Nv8PHPtO1P_w@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 at 10:52, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, May 05, 2025 at 08:27:16AM +0100, Seyi Chamber wrote:
> > On Fri, 2 May 2025 at 10:58, Patrick Steinhardt <ps@pks.im> wrote:
> > > On Tue, Apr 29, 2025 at 06:53:02PM +0100, Seyi Kuforiji wrote:
> > > > diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftabl=
e.h
> > > > index e4c360fa7e..2958db5dc0 100644
> > > > --- a/t/unit-tests/lib-reftable.h
> > > > +++ b/t/unit-tests/lib-reftable.h
> > > > @@ -6,12 +6,12 @@
> > > >
> > > >  struct reftable_buf;
> > > >
> > > > -void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)=
;
> > > > +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id=
);
> > > >
> > > > -struct reftable_writer *t_reftable_strbuf_writer(struct reftable_b=
uf *buf,
> > > > +struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_=
buf *buf,
> > > >                                                struct reftable_writ=
e_options *opts);
> > > >
> > > > -void t_reftable_write_to_buf(struct reftable_buf *buf,
> > > > +void cl_reftable_write_to_buf(struct reftable_buf *buf,
> > > >                            struct reftable_ref_record *refs,
> > > >                            size_t nrecords,
> > > >                            struct reftable_log_record *logs,
> > >
> > > It is quite weird that we declare the replacement functions in
> > > "unit-test.h" in the first commit only to remove them at a later poin=
t.
> > > It would make way more sense if we introduced the functions in
> > > "t/unit/lib-reftable.{c,h}" right from the start and then only remove
> > > the unused functions in the last step.
> > >
> > > Patrick
> >
> > If I get it correctly, you're suggesting I have both the original
> > functions and the clar-based variant in `t/unit/lib-reftable.{c,h}`
>
> Yup, exactly.
>
> Patrick

Hi Patrick,

Thanks for the suggestion to move both the original t-helpers and the
Clar-based cl_ versions into `t/unit/lib-reftable.{c,h}`.

I=E2=80=99ve tried doing that but ran into some build issues. The Clar-base=
d
functions use clar_assert and clar_assert_equal, which aren=E2=80=99t
available to non-Clar tests. Since both sets of helpers would live in
the same object file, this causes linker errors for binaries that
don=E2=80=99t link against Clar.

I also hit Makefile warnings like =E2=80=9Ctarget 'lib-reftable.o' given mo=
re
than once,=E2=80=9D due to the object being included in both Clar and non-C=
lar
test builds. And with all declarations in one header, non-Clar tests
see prototypes for Clar-only functions they can't link.

Also facing errors like these:
`LINK t/unit-tests/bin/t-reftable-basics
/usr/bin/ld: t/unit-tests/lib-reftable.o: in function
`cl_reftable_strbuf_writer':
/home/seyik/git/t/unit-tests/lib-reftable.c:113:(.text+0x520):
undefined reference to `clar__assert'`

What would you recommend I do to fix this?

Thanks,
Seyi
