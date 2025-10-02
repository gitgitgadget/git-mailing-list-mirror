Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159712C544
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431225; cv=none; b=K+wENRw3dBc/gLhALhGgn+bKs3i1k+V/mQKZJ8XEbtBj9oDQ2hjVA9RQEQ0iruEHe3wWhpc7czKF/STBLk7hpPF8kpXiSc/7Lv7Wu0/wr0otVJeWeD62miLRr2Eie5+VV0LQQ+mzUopcFLVnnQOZZPpnEDHe+F7Xl05IAH/iFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431225; c=relaxed/simple;
	bh=XzzNSupyAsrcRU+WgyeQShO2CBPsPA7ijtyhwcAgMLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djcq/2AnC9yd62H94NWeTZJNKHYR1sPiN5v1iWT6OmSEkm056O2aeu/kpkkDd6hfI+KDcJ/LftvpECt5MF+fpl3Es+QpDv+mpso7yAEBi8nAj1pyaX9oVDc5vfoH1JmI0wXiwguWcDs+SOiFdvk+6K/d0q9oXlDk2MAZSSeWwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKy/sn7p; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKy/sn7p"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36d77de259bso12451211fa.3
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759431222; x=1760036022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0yEqoABfQ8IMdCcO8W78ajWgMzVP52rfflwJs85vbk=;
        b=FKy/sn7pc60xc6R8PEGxMhYhQBBbo/6LutdCAyr8JU/s7R/770+VXwhSCCRdzURnvr
         3koLIgw2sIs286jSmwCUsX5MH9qxiOdqqiED7W7l204Li+uIjumk/U+Lxawm1APXccFX
         30nZf/uwGiXuD8ujT3axDP95oEr+43gCN6jTcfhHu9rFcaAF1hBe1imyuqVJGMAGjFwd
         feSEMIYVedoZz/RIQC7c9EM0cnrn9svG8wDXbIjQwcWn1Rvp8UcWF3/PFfoGffcAK0BE
         QMPcXjhiDUw/i00iym4k/z3DT/t/IlvQhMO4ZMLxblYAI98TshDIZufzcAIg3xPZY2cf
         G+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431222; x=1760036022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0yEqoABfQ8IMdCcO8W78ajWgMzVP52rfflwJs85vbk=;
        b=KBsEtkdNoinqVAERq5alGNUgchnIKNydGmlZVYRA6x4B5niIaQ3c0MfrvkCbw2rUpf
         EVzg5evgPzb5j6w1fTUHQhFiPinRl78jvbSe217wLNS8swUw6CN/XfekhDiatRkB7y30
         jN8tJ6xdxuuMvBM5PMJJJqsVfHfVas7Gp5RthHWAD7sbHSImWHNjzZDjE082D8HnNRWS
         iCiSAeELQh/ybZQaluIJzJ6YugjWvT0NnPdIV5i/Q4tqXwoC8Se10UJM+FHtDsspI5BF
         2l2BR395EA+tvOVTAtLeeCv+wBsm8wqjWI+xL0DUmjaLxLWiuAD1j7flvNjOSBiVWyaz
         CFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9U2ldCgYwYlkBJoX7KT6Mi+k4utQ1Q7N1yS+EGpn8qtlBl5fbS5VU6VUqEdr29bm+JRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJET5anxnGrsIvbp+IspFt6NkVhwukSJ9LwTrO92C6LLofLBE
	D69isffvfwBb8vA7tclytcFY02yOEY5F3v6Hw0UfvvNNqZht2iPUIhcDcNlH+SYHEc36U5dsFVl
	sLrl9Udoq8MqxTPhlFqXvJG3TZzOk5P/Omyi4YY8=
X-Gm-Gg: ASbGnctwym7UsSJJobCLBcAtniccqer5vCmTT8/LRlGDigqQzRCa1wUQ8XAU+fDlSzW
	QZjRrp/gBNQDQXTMMyVQp5GHifFNHML7UucZno9ZM1SJ+PEtn13+VIGiUEnpg+Pf3b90Qsl5AGt
	ydW7UavTShalF1qWulMzB8ghoPVCAXZZi12d5Ow8gMETX8p6q3k/ELNijk+oAcRu6PmASGRjR9J
	e6FAVzP2zabuYhz3LVx8S/VCfAMeGEDVu/WRZHZ0Cs=
X-Google-Smtp-Source: AGHT+IEfbLcNpmLEWO7sIEpjdYYVZZZD7YC/Cdb9QDSsa6RSXc4CQiXSKAMdF+e2uK1i3t2mgaG8d/UyQq9GjsFDUio=
X-Received: by 2002:a2e:be25:0:b0:338:2d97:4d3e with SMTP id
 38308e7fff4ca-374c37d9cccmr746471fa.25.1759431222085; Thu, 02 Oct 2025
 11:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
 <aN4R51_j2ieF-sjy@pks.im>
In-Reply-To: <aN4R51_j2ieF-sjy@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 2 Oct 2025 12:53:30 -0600
X-Gm-Features: AS18NWBh6PmmdBRi6Tx_trnALoBZYZT7Dh2-AttWpCAkI8uXQ55EEGH0twv06Eg
Message-ID: <CAH=ZcbDJWYzgMt_fK5z_07VhBFgKW=Q7stZBLhZJZTz+Ez2-FQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:47=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Oct 01, 2025 at 06:02:27PM +0000, Ezekiel Newren via GitGitGadget=
 wrote:
> > diff --git a/Makefile b/Makefile
> > index e8fad803be..d89ba03286 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1397,8 +1396,7 @@ XDIFF_OBJS +=3D xdiff/xmerge.o
> >  XDIFF_OBJS +=3D xdiff/xpatience.o
> >  XDIFF_OBJS +=3D xdiff/xprepare.o
> >  XDIFF_OBJS +=3D xdiff/xutils.o
> > -.PHONY: xdiff-objs
> > -xdiff-objs: $(XDIFF_OBJS)
>
> The removal of the `xdiff-objs` target isn't mentioned or justified in
> the commit message. I personally don't mind that this target goes away,
> as I don't really have a use case for it anyway. But in theory it could
> continue to exist. So I'd either retain it, or explain why it goes away.

If I understand correctly, the PHONY target xdiff-objs is to make sure
that xdiff/lib.a is always built. But if it's folded into libgit.a
then its purpose becomes moot. I will update my commit message to make
this clear.
