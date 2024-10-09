Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189531714A4
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502909; cv=none; b=HJBAihKD92qpcPm8Xix0IBwpcb8vTvBBWPiXDizdiW44Gm5QU/nN/fVV94YBbm4Z4gA7zeHW8fdbTbp8NDTjagQZV2slLgZmWDblsYSFOlcCZ7rUAveNajGjPJhlI6mXu3v+YAPpTDB0QrvDAgkDnqtQJyNa+pMZcEllfByou6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502909; c=relaxed/simple;
	bh=druRtb8TgQtI58pefgXT9+z55CFxsSKlJ6oWXnKkHs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5Gt+kC9AmokZUHEoBD85lbaSKLMlQm1AdGDBU3nnzfE0+tfJP/R7fACu9vcW7+I+br0PRNOsm8yENV0ML3UHl30r+kyS6tGLSykJkpgynQ5NW7jOZH8jYK2I6jYn2BZ1Z/rSyDKgaSyE3CjJaupROy00fo7oOuMZvEECND1hVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVEYyqiw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVEYyqiw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-208cf673b8dso1098615ad.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728502907; x=1729107707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVi56HnFwzc+jjeM2m7juAX160TDpWt1LnJc/djFcKM=;
        b=WVEYyqiwTxyD6455uC7Xhz1g1uK6iPecgvMjlfgQNpu0oaQV4StwHrCAJ1vrJ3Mu+c
         3xv7OsTVimeH6y46ufYLRc/2AlV3weMZGmHLyaFTOhBxPIRZa42UrpZ1WnpgSA7qKddx
         iMDLtFLmzf9hXiOI0I7o3VFRhX6QjU5VDO4Y+/KFuR19F4dSspzysQHNC6EQe7LXr0Qv
         gELW2lANpa9SjTHD570NHHV9PhHF+J3y02rUJavlGhqcM3Q7Vmw2LeVS16avRYv4QQLj
         HswpZ5KDdK7dI3K/SdT2Y0v/NkAnu5t/b0HBxjlOOxxzLEFyzXVMhwIx07EckhWP98Ck
         jSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502907; x=1729107707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVi56HnFwzc+jjeM2m7juAX160TDpWt1LnJc/djFcKM=;
        b=Ljj8GS/22zfIFN1IlYL4udL/FgBcw7kTm96kFeyUiaez0SC7c4Nlsymj5FgLdmrLnP
         CCozqcnPhSMXiypamILSlOedE/9S4c0rCL7MC8oIFZnsJWb3oS5g7bbDV00EyyDY3t+w
         VKTDk4npHgFIuxJPUx4L1vIwOJpyUFsoKIhKlNbpGXYqG+wne3ves/y1Lwrq9cthjq4R
         B9hVB/DoJ7nrsj7QlfogCDA65tPiPTSmea3/KV02TAYlCxxQjS8coTRHYU7xD09qlscG
         gJG7pOP0RA46XP4rB5KRtRJ+boE2eqqRNdr8IUPJpGrLaAeSBOFfuXrtF/2J2ESwMcGL
         iZoA==
X-Gm-Message-State: AOJu0YzD305sZJZQEJlj0vpq4TS5J/Vtkaq4SbGzyegEwBseA7RQJOy2
	zlZ6r1eqqU/I0kYLORXhAfl2QnVuRBtHpv7ESZPxvPIudGDS5ii7SUL7o3mYaey7HLDmf3hDa6m
	xF3PhwkqpUk+Oiby5pkdozI1theBkhJdx
X-Google-Smtp-Source: AGHT+IEHM0g7hXUXQHeWx2znJKqQFwcuNwnYDWLjMAAhL9nSlh2veIHblDAiSI0fOhxgIpdxqT/TKhZkIENubtZCpGM=
X-Received: by 2002:a17:902:e841:b0:20b:9062:7b08 with SMTP id
 d9443c01a7336-20c6377f2e3mr43316885ad.45.1728502907297; Wed, 09 Oct 2024
 12:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>
 <xmqqcyk9rtwv.fsf@gitster.g>
In-Reply-To: <xmqqcyk9rtwv.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 9 Oct 2024 21:41:19 +0200
Message-ID: <CAOLa=ZThTs=EzFEAHM+aLJ5Eq_E-RPfGrKiceDADsBGJQE859w@mail.gmail.com>
Subject: Re: [PATCH] loose: don't rely on repository global state
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> >                       strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(m=
ap, iter)),
> > oid_to_hex(kh_value(map, iter)));
>
> The line seems corrupt.  Joining them with one SP in between makes
> the patch cleanly apply.

Indeed. I used `format-patch` and `send-email` right after, I don't
remember messing with it, but perhaps I did. Thanks for fixing it up
and checking.
