Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AD1FC10F
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073990; cv=none; b=oZ+F9ZdsMEzs6VXC9/cpp+76Q37KBzp/gNrv0hGmfHi89/ABgcw+sHpFF9YVlVgkydsyxQ0agy9VNq3VtVhVwisxSxJOaXYC/qgbUsH944ylK+ZrA2JB/+bA3s7iotWJY9ywtTvjLxXGtPr0K8A61R1j1/8FTOmUUxyRz4TWrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073990; c=relaxed/simple;
	bh=RJVY96CJTvFLl7PgPTh/kx+/9VdOUi7aa+JJoUfhx7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvQLH3pKElPI93qMsqnKuUi8Ma+dDTXXgKOkXo24ya7m/H15jYYjfjWMObJq9Zuwvjh50jJbis/KALyP8MzqGOLXRrua6besKqdtatc4dw34DDCX4lMshUsghqtfK8C/pz20f/kGl8YziGt6oaHI5YXjsMdFFq/oDMOY15HuP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/vesOnV; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/vesOnV"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6ef60e500d7so43605997b3.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 23:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741073987; x=1741678787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL+HN8KOPQhR8lA4+ipSzL5JZ9nE18GoeYaC+WIhL9Q=;
        b=J/vesOnV9pJ3GeUede189itm5iK+v8uKWOuf2EMZjz0+Dve3h8ClcWwOYkBnTI02UV
         jmbJwCjQxFUBHvwwE8VxPqdQ+A7Y7o38uK6qj06hZLHo+BPaxGCh2BgHApwoWoL4iN7T
         GvMYeMhIajSiuW8TbP92f2Z8WHJuwAzujtdEbALZ6ToF4KoOMyHgvpEjqcX1XUr5+M50
         qUWmBbLgjSq+HhgxWMXIH6yHVHgv0jcdCIuwSjODn3JsHP/Va2aZl1CE3KE2OyQnqqPA
         D5t1DFQigvfVTCEhwR36f+BatnSPrY9gRQLxKCphnwdho92BvfscwCkOEs5eM5lAMs7t
         BVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741073987; x=1741678787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL+HN8KOPQhR8lA4+ipSzL5JZ9nE18GoeYaC+WIhL9Q=;
        b=VvAvQAZkqFfmXBe6RlODmhRGmafMra7seLGYJf6YO5al49RJWPII9x1+5a6dMcmTpO
         axg+6/dcog8Rvl4iPTttt4XUm59Oyy3duIjJnClehHolQn0cY7W44/KK/sXzeChX3bb7
         5wEcr0pT9tnGHzAtNZe2+gBZM6qsCMKU+HHkt4UIMgSaRJ8T+X5HYPN088CTvFEihIyg
         QCNkMBGEazg63wx/Qekw5W0VwvD7B7ovrZnAyzxcA8faSRdKiDmvsz3JAuWpfDqBZlhy
         xeAcqH5IPsAr2kVav23HpM/4+gIhsAUulVz3dTqwYjebPu8it9lrifdmxU94aEFbuZ3B
         1vZA==
X-Forwarded-Encrypted: i=1; AJvYcCVmQ6K65fxj+UF+72k3bwZelYfSB6tD1CHpiqc0qZeYAf+XFwuU4AGS8KpEs/XVUWIIQgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFKLGgAGB9BkW+d+iJqFOeJ3PWNAkINMWcumKvF0LAnwP+WME
	v/icWGRu4yBgfzQ+Iir/015+eH43+/6Nk/imi/VPwMtoD0Eva0lmrPRizbuQY51luUB9b/cKEPj
	fF8HMmOQW//VhlCoX/GwKJXI6L1w=
X-Gm-Gg: ASbGnculh7hR2Bu1to5h5voY1rGZvsUO5gxdSilPOw9psdxQNvQejPKDNPBfW4NVOpE
	FzOKLI7phOUaSawAfWkBaKjJkBf7M4D4kYwMM0b9cZbspvx5rH+oGA9OpBttKvFyQb5KQ9SrCjk
	Fp1Y2blOZlrikbGYfHiWmpaQxn
X-Google-Smtp-Source: AGHT+IFFLtnavQkGLImwaN2uf2Bpo4byPQlW3A8JnMyPrWT7B1T6teu/yby5cOach38mg+IdOs6rossfFaViITAf7As=
X-Received: by 2002:a05:690c:4801:b0:6fd:1d9c:bd6a with SMTP id
 00721157ae682-6fd4a03a63emr201621747b3.3.1741073987672; Mon, 03 Mar 2025
 23:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJd+fZSUiiUm05D_eO3HS7p=WoxAWSZo51dUNjyGjUNJBvyGg@mail.gmail.com>
 <bca5c0ec-0995-421e-9745-330f729357d6@web.de> <20250304063329.GA1283445@coredump.intra.peff.net>
In-Reply-To: <20250304063329.GA1283445@coredump.intra.peff.net>
From: H Z <shiyuyuranzh@gmail.com>
Date: Tue, 4 Mar 2025 15:39:36 +0800
X-Gm-Features: AQ5f1JollyjouWZb2cJUi5CTKJ-PhVGBtsEIB4LD83JdBLzhmUMdgqvIntRYp_s
Message-ID: <CAAJd+fZ_EK=ZZKptFjuumx2TLsdQ3s7WxTT+n_x3ARwZw23BCw@mail.gmail.com>
Subject: Re: Subject: Memory Leak vulnerability in reftable/readwrite_test.c
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Very nice fix, thanks again for doing it!

Jeff King <peff@peff.net> =E4=BA=8E2025=E5=B9=B43=E6=9C=884=E6=97=A5=E5=91=
=A8=E4=BA=8C 14:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 01, 2025 at 12:31:33PM +0100, Ren=C3=A9 Scharfe wrote:
>
> > --- >8 ---
> > Subject: [PATCH] reftable: release name on reftable_reader_new() error
> >
> > If block_source_read_block() or parse_footer() fail, we leak the "name"
> > member of struct reftable_reader in reftable_reader_new().  Release it.
> >
> > Reported by: H Z <shiyuyuranzh@gmail.com>
> > Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> > ---
> >  reftable/reader.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/reftable/reader.c b/reftable/reader.c
> > index 3f2e4b2800..f38c83f140 100644
> > --- a/reftable/reader.c
> > +++ b/reftable/reader.c
> > @@ -666,6 +666,7 @@ int reftable_reader_new(struct reftable_reader **ou=
t,
> >       reftable_block_done(&footer);
> >       reftable_block_done(&header);
> >       if (err) {
> > +             reftable_free(r->name);
> >               reftable_free(r);
> >               block_source_close(source);
> >       }
>
> Coverity complains that "r" might be NULL here. At the top of the
> function we do:
>
>   REFTABLE_CALLOC_ARRAY(r, 1);
>   if (!r) {
>         err =3D REFTABLE_OUT_OF_MEMORY_ERROR;
>         goto done;
>   }
>
> and then the done label hits your new line (the "done:" is right above
> the context in your patch). And err of course is non-zero.
>
> So this probably needs an "if (r)", or multiple layered out-labels.  Or
> alternatively we could return directly when the first allocation fails,
> since there is nothing to clean up at that point.
>
> -Peff
