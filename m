Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DA18D629
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286999; cv=none; b=dhuU4gSmn+0mk7IfVQJ165oO6sHBTZYJVtRtlRqVIwgqLMiXXMDsuP+9gF0r2TdxsGWNWsuSt6CM9NeatJ1nf/0llTrVwOkEd8gI4qnZKPgvpBx/VfKxA3MK/DSWrz1yOFm/DHrPf/urmEZL4gFq5nXDyDJ1lgBq72pCAHBd4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286999; c=relaxed/simple;
	bh=LZXRxMqqaE1ppDue+5OKQKYWu+eT94zDwjdCtFR+bHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipROiBMVlNx8HIgMr72HbcqQNzt5w7cSg3uWJ8B1ONhMJQVGL9K6xTZmHvsirIj+iMaMEgiah6UjYExHORbl0zkChs/2Gy3btTCLdCmU0oz9HeJjIrqacNhZAC4VupCLfQUyYxPZN6hsXlRWGtndfrLSdyILD9Pj9n3gFXvPiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L61FG+Js; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L61FG+Js"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a47d70cd8aso758608137.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729286996; x=1729891796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys8B2eDXdc1jF2IriJ2QwdOoNkk9u6uj/gENyEO5IlA=;
        b=L61FG+Js7urV38Kk6m5Wpz28VW6Q5oib8X11/hdJwzVryAOleGDf/q2D+At8wqxL5m
         HddpV5CBdPPF6l42aLmkSwqSjcewjJaB0AMbbKQJdwRSa5Nq9bEG5ifc8ealyoxLMDPV
         cVQsxwp57dONStxiRHur2doEIPRa7jxmX0Uu0DeLtYG0mO33z9AHXbGifmu9d/EJoKy7
         J6VB5aT1hz30/2nFsIBjZ2XKe75jfcnFYi2okcWXA0LLYwmDB13B/ZNtdCGev0Ehinz0
         Wi6+GaJQMjHupIE77r/kPSzFRaTat01cybad2hcsoAzVGY5HaWfgalz6cUnIPb6vCew5
         lsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286996; x=1729891796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys8B2eDXdc1jF2IriJ2QwdOoNkk9u6uj/gENyEO5IlA=;
        b=GyIFzGMEaraiqM9NyymRdbhH4tzynTQKYX6F3PTsc6GB8QUnYoVMO872pvINJ/E3cH
         s/oLoZQ9Qx1urocKO62ZJcTcuG+q2WZj5dS45rpJga0fkoYEj3W3SpnRiYyrfVr6dz9j
         o1Gl6i6h3FDVdDzPAeQJPYRWCQRP21RvsuIUXym8LRcGB2bd7OyK3mkdoQhg5Qh+8qWY
         uZPF9EbDrxUDZ+p6F3J5Gjys4aOfnZ94DVNV/HmT5DBhN76apQlOi9yj5lngdp++Jil7
         ZnmtWhaSXJPKsBv97VfYn20CePDoeRqTo9d7xKRLFj9PaZy270u2WungtCdF1xdo0pmx
         5N9w==
X-Forwarded-Encrypted: i=1; AJvYcCWR5KfGFozPiQE8i7p7KWvsty0/uPZb/OwLpouLvpAOmCkqRUH3fwCnehIrtUTqZvYco7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJRGtbDTBMaezMVdlQko2LRTWmVANcXm7OmU+n1e7U13+ElN3
	R3r2wo+GnuYx+7MQIEQA6cRGoDib0m0Of2E0yEkQWbd93uzV2xx68vuX/xcUvdbtUL3A/Lt7xCl
	mjCfhR14BCU9bwPtZmVHlQQJmSck=
X-Google-Smtp-Source: AGHT+IFozrREFVb/U3pwCxlyqfiGAmIxzdihMokzbyAaLaKvE09YQz9meJrCtRgNqwWevRd/DLDRo5X36ytJWT4k5b8=
X-Received: by 2002:a05:6102:41a0:b0:4a3:db98:4458 with SMTP id
 ada2fe7eead31-4a5d6bb52f5mr4452629137.18.1729286996597; Fri, 18 Oct 2024
 14:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <ZxLRdu4cPDgPLpCz@nand.local>
In-Reply-To: <ZxLRdu4cPDgPLpCz@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 18 Oct 2024 21:29:44 +0000
Message-ID: <CAPSxiM_dcpmpAsbo9wmXSDqGWXxU==QLfdVpowK5Xv-LW9iLCQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Taylor Blau <me@ttaylorr.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 9:22=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Fri, Oct 18, 2024 at 01:52:57PM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > Changes from Version 1:
> >
> >  * In my initial commit, I mistakenly included changes from a different
> >    patch and commit. This issue has now been resolved.
>
> Should we treat this as a new series, then? Or is this a true reroll of
> the previous round and should be kept together?
Hello Taylor,
Yeah, this should be treated as a new series different from the two below.
 - t3404: replace test with test_line_count()
 - t3404: avoid losing exit status with focus on `git show` and `git cat-fi=
le`
Thank you.
>
> >  * I have split the original commit into three separate patches for bet=
ter
> >    clarity and organization.
> >  * I added corresponding tests for each of the changes to ensure proper
> >    functionality.
> >  * In the first version, I used the following logic: if (strtoul_ui(v, =
10,
> >    &timeout) =3D=3D 0) Based on feedback from my mentor, I improved it =
to:
> >    (strtoul_ui(v, 10, &timeout)) and similar cases.
> >
> > Usman Akinyemi (3):
> >   daemon: replace atoi() with strtoul_ui() and strtol_i()
> >   merge: replace atoi() with strtol_i() for marker size validation
> >   imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
> >     parsing
>
> Thanks,
> Taylor
