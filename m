Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A61E5B6D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399091; cv=none; b=COJDXCGCi2avgH82OSafQ016vBMP0BcvyancCGfrnGTPPc2J1py2yTU+56Eyabg5O+PNRKFWUfVZFXN7ZW8i+kASilLL1JTeMwAmyFN/htnhe3hUimw8Eq6eGe2OAqUxm9GJ6Ibo7mUCMNNdWGuKifXHbB/dmpCUuRn82Ruofow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399091; c=relaxed/simple;
	bh=CbETRSRIp8j4hC4QYIN7q6FDIUHw7mrAlN+qFpQL0q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdAVf9K38kznHXTktQ5MhQMfR3BFhe65bME1GcmvzzoxgbeEPIIRsRhDp101WazWP4JoDrbRX94lVjATh3K48wo9qI23x/by4RxM/ibDxGgkEuu6lTCHQRSIs7JaLWSc8m23JGMTSjpI0aWUoPyVe3QSdj+koH/XUZdoqeKXJ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBGNbqQE; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBGNbqQE"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87ec5e1cd4aso1215521241.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751399089; x=1752003889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFZ0IUyUnw1fdxfYu+LQlH8Z3XBpdgLcL0pXEPZ40lY=;
        b=kBGNbqQEwusRY/71SK3D16PdDMi3T4/lJmZ02BpMjvT710GvHn2LFBBBv3oU4uosQL
         T/HeuoubvEHVih9hpB999agcZD4qeBfluXa9nrSGvfVhO9ZXAE354eVoqdnrk/87XRMJ
         DsXzCVNN2/UFzySATT1hLbtvPCuVApGpUq7uzDF0SgVzOLCe/4U+3Muo24ZeGj5uuD9P
         kmNxu4khPLWma4MONUchr3W3/VG2Q338XNGA0buPW2shNvJvOdl/mGrLgvC5ZWvUc5b3
         byHL5VL2XV9mbEO874G0s/V9q96JyzSUzYzgkL2jkj6v0Yjl3N/eetfk4iR3A5BPPDsU
         im7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399089; x=1752003889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFZ0IUyUnw1fdxfYu+LQlH8Z3XBpdgLcL0pXEPZ40lY=;
        b=Ak4CzXg3fjao6FO5dCrbvFWW/1in+l81YBpjf9b8OGzgwips0cKtcOF1FbAFTgJbWt
         6IQJLODJoNvk9pQ1WHVtVRF1Zb7hdK7q6vA1YsrxShtb5/UJrk8DneOBpuCG2mILDaA8
         UW4mGil7B/vcVgTJu/3rI0sjqnvIwaw34qeZhNOSqjYZ98sTJs+bUhaWzhBrmbFZCkOi
         Wgli853X3gTBw62P5nxmhIdjVnELQ449unaDZuexQzYzzXRZ37p0dUeXBvKCj3eWlSLC
         8ltuhmuEhcMp3oNoYnS6roGJyNWObYWpy+3swp/1hCOy/f3zlp1DDbL/B0nqsPCfZv6d
         HcSA==
X-Forwarded-Encrypted: i=1; AJvYcCXHgVNu99Tx9/0bzWJNKCJdMCYF1/ulmfK1oewXVeWdMZV+pZFaS2r8Eef6k9gf7d4RYu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpSvbCGx4CUQbXCrvvaKSEERPcZl3MHFU0mq1/URZrJp2g1fn
	RR3+s3mMSGMPrC8D7eejPhc6Eh6UgCCbb+M/p9O9cucvI0vcVL9rVAeyy9d+v0tpS2duOxO44PO
	oJ4qk5jvXKi2zGdZ/M81CVj0T0Hg/SIM=
X-Gm-Gg: ASbGncspF4a+vAuV6B8Xh0BhZS44/Oy+I4SMpLdbcfM6didiizGzves0wqbH3dF1Zkf
	MdQV+msVKZoMkoOIxFmqjq37sHjbj6ofHPvB9hpU8lM2B6OcuzaF6cg5IV8fcBBMr/NLHmC+FLl
	lzkqrcOKi1nC79OdwMvhfjMwNPV0ga+S4cPjsGswAA+Po=
X-Google-Smtp-Source: AGHT+IH6KwrtA55drSDcG2XpGuosO65c95vBWwitxzzZOV7RXBY4+j1IvdjLjZbsAY2FqwKA5B9cn4IO/FAdH6yW+Pk=
X-Received: by 2002:a05:6122:1799:b0:526:720:704 with SMTP id
 71dfb90a1353d-5345835feb4mr443583e0c.7.1751399089062; Tue, 01 Jul 2025
 12:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751296633.git.ayu.chandekar@gmail.com> <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcKgR0G72JRSlM@pks.im> <xmqqikkbkglx.fsf@gitster.g> <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
In-Reply-To: <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 2 Jul 2025 01:14:37 +0530
X-Gm-Features: Ac12FXxMBYGLAKWA4Az8cDIT80F5gmEK8rvFE8aYC6BY45GlTSlHnPbq052FkCs
Message-ID: <CAPSxiM8EkctHgD=to=JxwDC8L6=5xgu=vpb5=bfhQ7bL592eWQ@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on 'the_repository'
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, christian.couder@gmail.com, 
	git@vger.kernel.org, shyamthakkar001@gmail.com, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:40=E2=80=AFPM Ayush Chandekar <ayu.chandekar@gmai=
l.com> wrote:
>
> On Tue, Jul 1, 2025 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
> > >> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
> > >>      expire =3D TIME_MAX;
> > >>      save_commit_buffer =3D 0;
> > >>      disable_replace_refs();
> > >> -    repo_init_revisions(the_repository, &revs, prefix);
> > >> +    repo_init_revisions(repo, &revs, prefix);
> > >
> > > Does this work correctly when running outside of a repository? In
> > > general `cmd_prune()` is not executed and would instead die as it is
> > > declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the u=
ser
> > > asks for help we may still execute the function with a NULL pointer.
> >
> > Good eyes.  "git prune -h" would safely exit in parse_options() in
> > such a case, but this part happens before the parse_options() call.
> >
Hello Ayush,
>
> Thanks for pointing that out, Patrick. Right now, `parse_options()` is
> called just after the `repo_init_revisions()`. I can move the call to
> it before this.
>
> Although when I tried running "git prune -h", it still gave me the
> expected output.
Do try this outside a repo, i.e outside a git repository and try to
run the all the test if it works.
>
