Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5342673BA
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833079; cv=none; b=A0G0UKzzmaiAWBiK6sIB/Bn85uyyPhcps6hUc98otkR5hkG8C1GPVonHbAw1f1Bo7RICY7zBiLccFUbEC94VmJTY18DRTuxSjPYiJ1DZ2UgbE4hrxPxUHNdtfWuBfcH2LJpfi7tAuWf4CFI2H1pX6tROaOqSXPRICxCeJqHbgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833079; c=relaxed/simple;
	bh=h1E3pyf2G7BvH6gjPUG7ZSWBkBxakn27zU3GGJMtRUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHTYLkzArsZB1Jsx8JThfiTUsHDlsYSY2Pam/F+5PcN5I5fIUIdDxMCljRYxeHDHqEc5wxiUX0eaqUBHE0FYmNo1dVLEBKO51B3twnGjVyTBd/hyXfhSC1N3G90SnhpTgLXYSbXORLGPC+K7apA+Y3g84G4Ce+1b3qSMTgVmCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOyiF6mD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOyiF6mD"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso9964089a12.1
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747833076; x=1748437876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0DSCAcNT32Vp9hJd66DZTDVSJg8dn1C/CmsT4yrejo=;
        b=eOyiF6mD0ZXx3xUCfHb4Yr/W0KF/w4zEWmf+cH4zvAmMcvWWGjabIKJDjssqVFO6Zj
         RVc/5ywp94eDnFd/YPuzu90Kc6X0H1K+KE5QTqPlaDlsQM2b2Ol3qYTUZK5I5lnBG1Iw
         479u6vLzh9fDLQmKbHf3NmNeHoa+j90ttiYAgDMJHpBqr1Tz7SCx8pHVecmGcbWtUJWS
         jSKorktyRcmr3wsI/zyWaFs2G23xn6XcjuttQEYlUAORNcZwiJrlf1uh5hisfpQy/s7v
         x8Nzl4jgd+Z100dAszBoTQ5pP8TOeuitvbMVOwj2a18Ba1jwkbsKNylL9UNFKytTQYe5
         ufMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833076; x=1748437876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0DSCAcNT32Vp9hJd66DZTDVSJg8dn1C/CmsT4yrejo=;
        b=IVxCq/aXYq/Bnd5i9y8uQIZ0UthhhKBLeF5lS88YqMu2c85iSw0gn9ggGGE090GZb9
         CmOBychbdDJJojZAGX9x87I2nIiYGFHRZERvQP7j5u3Lcw6pHiiauTZ2NAFBXi0o+otY
         YDps36SBykcW4cw8z2tU+2ZtZX9icUmwj1wGDGEsD+VpcdpWNDSJUxPLuJ3reZW7+NO1
         cpX+ugPy7t02oh00NByabafMTPq+dXIeJm4CTb1RDASZNBiH5O+aEVoZEB7BhqkpJhnr
         tld/LQK8/CTfYHK4V41GK6RASLo4sc7H9S92a7Fz0/XWC7SwekBeFdXoCAk59bzUl7zr
         hnsA==
X-Gm-Message-State: AOJu0YxSlQZFLKdjMkUelYj6dRJa88STpdKJoAh8X53iPNrokJEeeom2
	+KIAlDIqFZFCla63EDVLqKEyeg6lNymXLNCWwvmThmKPLOAOrOlftfhgjXxlYCRzSBOIRRZVo9e
	nYOcFbnh0icu0yfNZEp/B0Lb1AXgMCk0=
X-Gm-Gg: ASbGncvt+LXn1EM70eGvXBeY9Y+jPxzmchTOrY6sTuSgpEF45OsPzTuyQNcXJyd9aa+
	YN3AI8sGTcCT8jcmn9zyaCn1q9KFi1XHYhERgBX87bghv9f4ern9BcPP2j0zK4xaEMRJuPWJqYi
	pcdzeV+dXbg0UZYJWHo6nd69sJMGikM7HR9joJMdg2HfhWf2kdJg/Mae5AxakCRE/MCeA=
X-Google-Smtp-Source: AGHT+IEm2mUjYgW98JpES79XFlYTgswTUAQw+cHlkHFW+jUtxauAcLDnuiVU4rvLFfJjsDkjzqhUoSwU2bZTvGd40NU=
X-Received: by 2002:a17:907:1b0c:b0:aca:c49a:aec5 with SMTP id
 a640c23a62f3a-ad52d4302d5mr1839957566b.8.1747833075424; Wed, 21 May 2025
 06:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk> <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 21 May 2025 09:10:58 -0400
X-Gm-Features: AX0GCFucpNpoeatkqWtVhbYA_tIGLTA8uDCymKEG-bPrscniqQZ8Jm9n_MDke5A
Message-ID: <CALnO6CAMqVvHbY2sR_+dt8vYHxDn4S7f4B2jq+HcMEXx7SLj9Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] midx repack: avoid integer overflow on 32 bit systems
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:05=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> On a 32 bit system "git multi-pack-index --repack --batch-size=3D120M"
> failed with
>
>     fatal: size_t overflow: 6038786 * 1289
>
> The calculation to estimated size of the objects in the pack referenced
> by the multi-pack-index uses st_mult() to multiply the pack size by the
> number of referenced objects before dividing by the total number of
> objects in the pack. As size_t is 32 bits on 32 bit systems this
> calculation easily overflows. Fix this by using 64bit arithmetic instead.
>
> Also fix a potential overflow when caluculating the total size of the
> objects referenced by the multipack index with a batch size larger
> than SIZE_MAX / 2. In that case
>
>     total_size +=3D estimated_size
>
> can overflow as both total_size and estimated_size can be greater that
> SIZE_MAX / 2. This is addressed by using saturating arithmetic for the
> addition.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  git-compat-util.h | 16 ++++++++++++++++
>  midx-write.c      | 12 ++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 36b9577c8d4..4678e21c4cb 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -668,6 +668,22 @@ static inline int cast_size_t_to_int(size_t a)
>         return (int)a;
>  }
>
> +static inline uint64_t u64_mult(uint64_t a, uint64_t b)
> +{
> +       if (unsigned_mult_overflows(a, b))
> +               die("uint64_t overflow: %"PRIuMAX" * %"PRIuMAX,
> +                   (uintmax_t)a, (uintmax_t)b);
> +       return a * b;
> +}
> +
> +static inline uint64_t u64_add(uint64_t a, uint64_t b)
> +{
> +       if (unsigned_add_overflows(a, b))
> +               die("uint64_t overflow: %"PRIuMAX" + %"PRIuMAX,
> +                   (uintmax_t)a, (uintmax_t)b);
> +       return a + b;
> +}
> +
>  /*
>   * Limit size of IO chunks, because huge chunks only cause pain.  OS X
>   * 64-bit is buggy, returning EINVAL if len >=3D INT_MAX; and even in
> diff --git a/midx-write.c b/midx-write.c
> index dd3b3070e55..c7cb2315431 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1699,19 +1699,23 @@ static void fill_included_packs_batch(struct repo=
sitory *r,
>         for (i =3D 0; total_size < batch_size && i < m->num_packs; i++) {
>                 int pack_int_id =3D pack_info[i].pack_int_id;
>                 struct packed_git *p =3D m->packs[pack_int_id];
> -               size_t expected_size;
> +               uint64_t expected_size;
>
>                 if (!want_included_pack(r, m, pack_kept_objects, pack_int=
_id))
>                         continue;
>
> -               expected_size =3D st_mult(p->pack_size,
> -                                       pack_info[i].referenced_objects);
> +               expected_size =3D uint64_mult(p->pack_size,
> +                                           pack_info[i].referenced_objec=
ts);
>                 expected_size /=3D p->num_objects;
>
>                 if (expected_size >=3D batch_size)
>                         continue;
>
> -               total_size +=3D expected_size;
> +               if (unsigned_add_overflows (total_size, (size_t)expected_=
size))

Style nit (only in case Taylor's approach doesn't prove better): I
wasn't expecting a space between the function and its argument list.

> +                       total_size =3D SIZE_MAX;
> +               else
> +                       total_size +=3D expected_size;
> +
>                 include_pack[pack_int_id] =3D 1;
>         }
>
> --
> 2.49.0.897.gfad3eb7d210
>
>


--=20
D. Ben Knoble
