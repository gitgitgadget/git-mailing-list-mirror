Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5DA95C
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730001257; cv=none; b=PQxgvBT/NPa7lekeSdGtVX2ygRYCnSatgp7J2n2Ba1iilmyM1D+NcIs32SJIJlc5pBvNgV7x0WLFg13aH1Pxn+x+3qJFUVf7Bv42dWZDWw+gtXPG8DNEZXFPlCLmvwyrWuw9Mijniz+FMKHqAyJDL+Z+wTeWEtxqXfBa+uGefQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730001257; c=relaxed/simple;
	bh=Lm7ucsPvIenmxx2uqgWYEnxojC9ZjZ+wtX4A0GnrsJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUbqgqCyt34R9sgSpHvsiaf0BYKm+l4mbLW6m73xWJMfWv7V85pfp4wIbavPbEGBrZXeQT/d/2MFWxkQpOm8P8+SgukPX+hj2vUHU8mgQoJ6WB0hT16l/oTRmtkf8tsxJMrjl/n1kJhqXGH8eeeXCKqagpMguzHGDR+NLHiSSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc3Bh84L; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc3Bh84L"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e290554afb4so3475081276.0
        for <git@vger.kernel.org>; Sat, 26 Oct 2024 20:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730001254; x=1730606054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7TRraTCXrRiStn2QNNwpLywmsb3cxGaU/7FGZpN2Qw=;
        b=bc3Bh84LcR1z71d43h8ZM+Uje9oI2ZJzQO8MWcWBot5kwINqFyzVSMu9a0N+yx1pwh
         t7DH5UjJkH5+QO0pKhFH085rPtJplZ1ByPMsqQUenvwJe9QF1nU5BsuPjjTYuI45NN8d
         I+b52V2+fDyi++LJcHkDv+HGGURXtfVCtMT9Z6bRuZbAKaL00ZphCmvHOlShvSUZRDY8
         PlodlC7cTf1qDndxz89D40/obm1gGwvCv+YRYT1VbS9XcenZpeCN/lfmscx3nd9rZiML
         +MzhE0JNV9HtOWINhZCXl2U8xZGD+rXgmP0rribY7u5u8XET1deG/iVfupziyUt8nQUk
         GaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730001254; x=1730606054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7TRraTCXrRiStn2QNNwpLywmsb3cxGaU/7FGZpN2Qw=;
        b=EEWim5U+CKn4x8bFqXiZYDFFzRLDb/MY/H2FObfWTXu/1oh3c1gl6UECbZeH6sRpjQ
         0lSidIU7EhjmhJV7tWyNPabnKnO4vtBHMc8F+Q2T0c4AjtXxkhr6S63vB3hwMHMhsQt0
         70A6erMVh6eJOZ37KaxZTc0pM8PCMRuyNWAr8OxXjMfh4zSKKhAaiyVVHNuDX8bzyMq6
         P/T4lMa15pMPLUEGjitPb4lBi1DtktiAzgm5ETv9Zpr8e6HYnTfAoI7KnGodgLljj/jx
         PorBZbJAh60diX24j70e92X+PDtlkzrMEPxlCrTOyWhK+ZY+UHA4I7fECYMmOt8CInZu
         MvtQ==
X-Gm-Message-State: AOJu0Yz1WrQ6DeFJC60jXTtHM/kpvK/nPHlati2UJX9+ao6qTroOjnEY
	J3F00QoTJs7v1PuZM+MknR1G4zYvzYsPlMAAcj+PVii0pm5MoNT3QsxyB62db9abvG2RsafbCHI
	ujdxAAKjCCCljVC6pqNSc51JDnJg=
X-Google-Smtp-Source: AGHT+IHEtAnbYggWwBC0RTL0JULyZkzu6e65F2EZll/R0mnXylYquAJMqn2Q9sM2+2MiJFXDh7mG5n0SbegqPytdOsw=
X-Received: by 2002:a05:6902:1885:b0:e2b:ad82:e592 with SMTP id
 3f1490d57ef6-e3087bfc5e6mr3645603276.36.1730001254122; Sat, 26 Oct 2024
 20:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com> <ZxwGAhWYm0tASMI3@nand.local>
In-Reply-To: <ZxwGAhWYm0tASMI3@nand.local>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Sat, 26 Oct 2024 23:54:03 -0400
Message-ID: <CAN2LT1CTi+7GWsDOYKDF+PEg6H3BFTfCVSwPvK5u5KnHi_AbZA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] cat-file: add remote-object-info to batch-command
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 4:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Oct 24, 2024 at 04:53:53PM -0400, Eric Ju wrote:
> > Calvin Wan (5):
> >   fetch-pack: refactor packet writing
> >   fetch-pack: move fetch initialization
> >   serve: advertise object-info feature
> >   transport: add client support for object-info
> >   cat-file: add remote-object-info to batch-command
> >
> > Eric Ju (1):
> >   cat-file: add declaration of variable i inside its for loop
>
> Thanks. I just want to make sure that I have the right base here... this
> was previously based on 3857aae53f (Git 2.47-rc0, 2024-09-25), but
> applying the new round did not cleanly apply on top of that commit as
> its merge base.
>
> I applied the new round on top of the current tip of 'master', which is
> 6a11438f43 (The fifth batch, 2024-10-25) at the time of writing.
>
> Please let me know if that was the right choice to make ;-).
>
> Thanks,
> Taylor

Hi Taylor,

I probably rebase on the wrong master tip. I am working on a new v5 now.
Would you like to resend v4 or can we skip v4 and use v5?

Thank you.

Eric
