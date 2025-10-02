Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7F27816B
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431050; cv=none; b=aI0yxjWNLvBaOXDdPyp3FFTxPfFzlWR8oZVM9muZM7VEWpCOBXNkY2F2ibxjSmkfxDubyZganRIrtaaAzSxezpeO5SajsUwAqqcO6fqCoV64rmcqP8wHIFrh2V+IacflenvXq/S7vweZGYQf2vTdNWXNtbaQ8VaT7h7Yj8SpcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431050; c=relaxed/simple;
	bh=wcINchk22zVZdx7P5wW6J+atye99T7lQGuHt8cH3TH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBtcMKZKwM8R5W2Dq/3UklL5fRdHKmkcevoj+hnpDc+43eNpiTO3VyyKH/hHNaBMM7nhG/k3m+L5gaj6NJ5DAaPDhDxx+QnyhBvl/Wf6DWdNkXQ16q4RIaTSY3iJE4GB5RIvDVHeo3EZFAsdZskzPW4zr15p5D8woLGdj6iS/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+zxkKpt; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+zxkKpt"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-371e4858f74so14974221fa.1
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759431047; x=1760035847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBRAZFBUyJGbXt3AU4eVOIyYWe7ShKlCO668rkd8zrg=;
        b=e+zxkKptIm00oZvOU9gbP+rlAKDqsVpcspSDShgh72A0+PsAi8+1cqZbkNq7qa5OFF
         Ds+lc+E+YcH7C59ay3A2P66CTktsNXbgC0sPH7T+P8LoadsXjQzyitG4RG3cbYxajXFD
         f0CNaNpBgeP+CZ967RO847cZ6mhvCnVAbfwiWBM24JjtMo+IXNIrzbRAACfI/IpmVMCt
         jN+8WCr8kynx7ubn2XTRcjATrRq7Fiijr8T2jrIe2AZQ2jV8ni9ZoRpqEPQ6rodahN4c
         4m0i9RXiFd5SGQEEbuz37vYgRui8txoEGU+zjzLql/ThWR+ENbMP/gPPaSLaLDRhCj2j
         hB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431047; x=1760035847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBRAZFBUyJGbXt3AU4eVOIyYWe7ShKlCO668rkd8zrg=;
        b=R4uMNFgdGwtjl9MEerTWj1m2jJpsAngBEu9wE3gRd4uYPRvqgwBxLgQu1xVy4ANokJ
         GdUNNXogPaTe+rZRHPp0+TYZCH+3Qoq3C5bIqFQ6tWmxMz5gvS5dPAJZJglVBzHdBBXd
         oi3BQYD0QeMswQ8lCw4UZJP6u6K5XE+qkyqrMBKhwnpaKLk7ggSM5QGP9CnC64eYmHys
         63wfUrSfjec+kUmy6nq9B/mSUpdtg1b3A7/AP7ly1iIL3Gpoq7CeVqkVgFeGDL2E6+YL
         d+08TnBgY2FcMUVs99n2aiE6540ZbOWbawdnvhGPCI0K6wF684U0w+Kntl/1bc+CtzJU
         HWAA==
X-Forwarded-Encrypted: i=1; AJvYcCXt9oU9nvWjsFDlDYIM/zQIXJq6AirnEvC5SsP7QUkgx4QJ6jwFOOVV4oNN33GZuM8xEho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEiUywiMunxFM00YCi+uzZIhMRV9cqBFw2VwhJOxP5VZt6ukU
	C+BXanLkAw6bqW43/kGWt6cWlWVOo9SLYpe6bmCgiA4oUiASjobjoSBI3wA9ssDkV8TkiHzlwxe
	Qs4XCTJ3VzG2Uoh3A76jY9OoV+QUj9q+JEnWiVVQJdg==
X-Gm-Gg: ASbGncuNyOkuAwtAmsIgQ8yXfjfhQcqWLCDMiYB41HDXhcIzch5SZ33queRLlc8dfcE
	VQmJJH8lddVdYZlwbf3xu0pQdWHTFlLG5phYcuNA4xxl9+yX1b3/W1FBdaAEZQETsYnQGWVtluv
	eo8RitGRpTRg72ew+TOPDtydLpUTHbJlW5yb/OcPJbb+voGeoBlEe0j8dHL/c0emMGqPqrCHiFW
	uqNUdlb3xygFL/mQ9nGXpZqXqUYsw/w
X-Google-Smtp-Source: AGHT+IHPUZ5AFlkhtAZTWqDc+i9H6ACRT/Q8SQ9Aq07IanD3wq2l1eRwjpHsXKZFw8CiY6/wMsS5BRd3XF8WZqBofLM=
X-Received: by 2002:a2e:be0f:0:b0:36b:2fab:fa6f with SMTP id
 38308e7fff4ca-373b8ca6ab8mr13360171fa.3.1759431046500; Thu, 02 Oct 2025
 11:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
 <aN4R51_j2ieF-sjy@pks.im> <xmqq1pnlzayy.fsf@gitster.g> <aN6bL07N8Qz6USTf@pks.im>
In-Reply-To: <aN6bL07N8Qz6USTf@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 2 Oct 2025 12:50:33 -0600
X-Gm-Features: AS18NWBSG2yv6IstCUbb08mRnBi15mREQyicT3sQcplhTTT5qIzak800nIL3F5M
Message-ID: <CAH=ZcbBQ2abBS5n=_OZ=qY_K=on9sBa_sK2HbbBzbwa41gWFQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:33=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> On Thu, Oct 02, 2025 at 06:31:33AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > On Wed, Oct 01, 2025 at 06:02:27PM +0000, Ezekiel Newren via GitGitGa=
dget wrote:
> > >> diff --git a/Makefile b/Makefile
> > >> index e8fad803be..d89ba03286 100644
> > >> --- a/Makefile
> > >> +++ b/Makefile
> > >> @@ -1397,8 +1396,7 @@ XDIFF_OBJS +=3D xdiff/xmerge.o
> > >>  XDIFF_OBJS +=3D xdiff/xpatience.o
> > >>  XDIFF_OBJS +=3D xdiff/xprepare.o
> > >>  XDIFF_OBJS +=3D xdiff/xutils.o
> > >> -.PHONY: xdiff-objs
> > >> -xdiff-objs: $(XDIFF_OBJS)
> > >
> > > The removal of the `xdiff-objs` target isn't mentioned or justified i=
n
> > > the commit message. I personally don't mind that this target goes awa=
y,
> > > as I don't really have a use case for it anyway. But in theory it cou=
ld
> > > continue to exist. So I'd either retain it, or explain why it goes aw=
ay.
> > >
> > > In case it goes away, is there still a reason to have the separate
> > > XDIFF_OBJS variable? Can't we add these objects to `LIB_OBJS` directl=
y?
> >
> > Doing it this way lets us still keep the "logical" organization to
> > tell which object is which, even though we may lose physical
> > distinction by throwing all objects in a single library archive.
>
> Well, I guess the logical organization still exists due to all the files
> living in "xdiff/" and "reftable/", respectively. So I'm not sure that's
> a definitive win.
>
> But in any case, I don't have any strong feelings here. I mostly
> wondered whether we can simplify the build infra even further.

My preference is the same as yours Patrick. In my Introduce Rust v2
series (that I dropped) I did it the way that you described. I changed
how I did things because of Junio's suggestion. I think doing it
Patrick's way would be more consistent because in Meson the
`libgit_sources` variable includes all C files that are part of
libgit. That variable includes the sources for reftable and xdiff.

snippet from meson.build:
libgit_sources =3D [
  ...
  'reftable/basics.c',
  'reftable/error.c',
  'reftable/block.c',
  'reftable/blocksource.c',
  'reftable/iter.c',
  'reftable/merged.c',
  'reftable/pq.c',
  'reftable/record.c',
  'reftable/stack.c',
  'reftable/system.c',
  'reftable/table.c',
  'reftable/tree.c',
  'reftable/writer.c',
  ...
  'xdiff/xdiffi.c',
  'xdiff/xemit.c',
  'xdiff/xhistogram.c',
  'xdiff/xmerge.c',
  'xdiff/xpatience.c',
  'xdiff/xprepare.c',
  'xdiff/xutils.c',
]

I will go with your preference Junio. Do you prefer your way or Patrick's w=
ay?
