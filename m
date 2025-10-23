Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D04C2E0
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207452; cv=none; b=YM7UsBk4/JeFKm7zwHkvpNd/8ixvHHN2RTmPO4D93Xy4+7sz4bHUqz35Y0PHJDrur+3eLM9/Ie6ZiKQGB7AZz8m+QOCRHQyF400QVaWL4HUhEqqTB+uOuUrQXT1vKf+VXP7jldsEXqBoQpTPe18pJmatQSZNZcWQ6jd4AC07bvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207452; c=relaxed/simple;
	bh=5tKxQ5gjGlEsDjcpWWdTZQ1f6M8n4DU6mqMi3Ni5K5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxGe+WUeswfGmON8qi/Mjh8h57nGVi/ENbgj1pnBKJjDNg/qDKVQ4T6kVstpyT5Q/YRaWw8YltzuniQqPPRC4CfsjfS5BpgIDV3NiLW7qj8pjFaPfaMxv78seaiHeemMFBalBSEJ5LfPs56EkfujCYmrGBRZsg2/LtVbrOM1LVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3bAiVCY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3bAiVCY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29476dc9860so2251315ad.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761207450; x=1761812250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYbnzWhX04aI77HfUAM5zG0WYOcJs2nsDMtSprLJyjo=;
        b=Z3bAiVCYzIk1vdMAfVCFyG3Kqv/C/9r3kx+mpZD9shunPvGlxuAccYTmdm5w5PayLf
         RN17+d7PG1Um1hLxdCcN3o5U5H+Ak2f3OYlt60pwlSfKqLCQ7ivcRLUHKcZt5xpdCeFm
         48wYBXniplSeIIDMWainckj5Y6zf+zsRIUQFi8iLgq4LG7tMjEhz8uhC5BreNcBTuXVm
         xxShmxsn/wrhkNojClZKDp8Ak3IIAHzx5FxkTvJbQzM3PN3tNgyAyga3dy1Nd0klPyVC
         LuKELacKUyEq0V+3q33WwjB6yPTMADyN9z0y5M5mNC1qWCNMXRN1ufUMisvDsKetaRIJ
         q0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207450; x=1761812250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYbnzWhX04aI77HfUAM5zG0WYOcJs2nsDMtSprLJyjo=;
        b=F1lyVdIz8EoVSMWuOS0Cnl9sTPwV7B6Nw6m1pMq/xcYQh4H80RzA3tt11Ga0Q8tM1R
         RF791L5I33Tvp8qq97wGxK96JvN7oCauvPVPQ6w0cq3y8jXRWHkpDKaWugy9XjUgOtSD
         d7iNr2Nf1Ocv8rcJYFd/yrPwwB43q0mSr7IlJXT+TzN3OA8HmxXcXDEDlEzHxf+D5GHS
         fgWAQoESXRj9cobOnqVwSMM1sl6jREoVt4pgM8hExw0XlovpBvMely+WOY9QWd7M4mN+
         0Yhz4+/nccMohvf0LLqzYsS1cA1OlkSMTNOKe1MiNtRhqzam78T2ZB4kttsBa4DrVgVV
         Vzsw==
X-Gm-Message-State: AOJu0YyXCkqcKQZLNFPlwD6XqNS1oScxAH1pKJpFZPXI6RyA9OSUgsMN
	fEnQYzvJPf9LJAf2NzcHR70BOgSwB8+dHbLrnKf993GYEJael7LSOl2pwOeVQJrSfG/ddxfS8Cr
	K1McfAbGjmThSwTOaYr4ZR9ucBf9hVds=
X-Gm-Gg: ASbGnctIG+DUIahKCXebJXGI5mMTlS1PtNV+NGpsirarbaYg1a6krHRLOZhGyf7H8Yl
	mFElxTBufS9H4nQcJuwIt/tz6r6FRRQHEq1DD/XikqFhhpVCs/z23ccDKH5MwpANilL/4NKVjA0
	96KRKopopCiZ0rvPHr+7d2Qtc8XEQCWOsL5gDXekKw6on/PJ0dqegSJxvbKqdq6Vp9osWVmxCuP
	oPCl3A2E/LTj0RZCiiH2FPu3GmGwZevK/a+8vlKxuk6iwOHbvwcxMVnYMBSJPwa
X-Google-Smtp-Source: AGHT+IGOgvPGb6EO2StlnyUJYM7VPc5aRP84lcTAqVk+L11GZUU2RDQiayAOhi0r+eIw4z7NAyjeDY2piqLcpic+iNQ=
X-Received: by 2002:a17:902:ec83:b0:276:305b:14a7 with SMTP id
 d9443c01a7336-290ca30d76dmr276494305ad.33.1761207450417; Thu, 23 Oct 2025
 01:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761135129.git.belkid98@gmail.com> <5df667227b8b8951bad6c3cba54230ea8f6d3830.1761135129.git.belkid98@gmail.com>
 <CAP8UFD3OTMi6uxv+z4rTqJ4wVpmezSG2Yj8tZMpgptWaWU343w@mail.gmail.com>
In-Reply-To: <CAP8UFD3OTMi6uxv+z4rTqJ4wVpmezSG2Yj8tZMpgptWaWU343w@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 23 Oct 2025 09:17:31 +0100
X-Gm-Features: AS18NWCzgmIsdI20OUcPBnB_4ENWmbX8107txihi1vhyijVxHfKpl1OWEPHVf9s
Message-ID: <CAD=f0L9qsVOo5=2XfKxd-UvzzzJ=PEE0-kW=wyOxSVvTYt7Vyw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v5 2/2] gpg-interface: do not use misdesigned strbuf_split*()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 15:04, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Oct 22, 2025 at 2:40=E2=80=AFPM Olamide Caleb Bello <belkid98@gma=
il.com> wrote:
>
> [...]
>
> > Simplify the process of retrieving and returning the desired line by
> > using strchr() to isolate the line and xmemdupz() to return a copy of t=
he
> > line.
> > This removes the roundabout way of splitting the string into strbufs, j=
ust
> > to return the line.
>
> Nit: here also I think it should be clear that these last two
> sentences are in the same paragraph.

Okay

>
> [...]
>
> > @@ -887,19 +887,22 @@ static char *get_default_ssh_signing_key(void)
> >                            &key_stderr, 0);
> >
> >         if (!ret) {
> > -               keys =3D strbuf_split_max(&key_stdout, '\n', 2);
> > -               if (keys[0] && is_literal_ssh_key(keys[0]->buf, &litera=
l_key)) {
> > +               begin =3D key_stdout.buf;
> > +               new_line =3D strchr(begin, '\n');
> > +               end =3D new_line ? new_line : strchr(begin, '\0');
> > +               first_line =3D xmemdupz(begin, end - begin);
>
> That works but I wonder if something like the following is not a bit bett=
er:
>
>                if (new_line)
>                        first_line =3D xmemdupz(begin, new_line - begin);
>                else
>                        first_line =3D xstrdup(begin);

Ah yes.
It is much better.
Thank you very much for your guide.
I have already learnt a lot in this series.

Bello
