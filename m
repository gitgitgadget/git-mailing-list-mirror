Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7320FD
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628612; cv=none; b=aPjoY3Z8x9yCwl8KCkHJN4CG3CFy2/2RNKc9w7eAc1GfgbzurQySsUudebwTPPuTksq/I7PcEpcEuQe0pbyNuxOz+QFVSuFqbY34Tn0Q3cT2c+Zd6o17EKPFCGR5/viWGWTjIShpGH0AsXu8GMY18umQAyDdQ8warOYlReqd/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628612; c=relaxed/simple;
	bh=wg57gSf3wgnjdjIPL56dCv8QIFv/7/+j+nSgUogC6uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD/Rw1dMtuGKJJrZyarPFo5BSnpxVo1XKgIBj5/ruGzOvyw7nxJ/gg9sbnNDjUlbXeN9PmFGNYWNbeKUs7cfFGkcxmrVHxQVB/tcW7Xvs8BzVsaSIfPCKCixJ5U3o0/bpEl8zJQhgg4bEbtFkXbG3bo0qED8QjYX11n+G9IbpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1FFU/qV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1FFU/qV"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so279065e87.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 17:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705628609; x=1706233409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xumxo/vDM0D+nTRMI7Bwfl0XbSFAiypFLl0PL+8D8D4=;
        b=f1FFU/qVO6sPoYAUgC8CHiX2LLVGYxJ8n2sWHYkpqRLg3Rf3neBwEgrNzeqteWaDWy
         cT/ZVpHAk/hLQd1HICBiEnLd7bgUmJtdYJLQxFefKgEV0e9HdphHNPDyP1VA6yNzlBwt
         Qy9tFVXHwURfMmZtw0BpCJ3XzeZgMTLkFr2jr79dJ2jkMM1VgQ1AWqBEUg1g8HjD72YP
         PEM+Q+Epn5S/rfZWlQgCI5oeTMIlkROz3yxG9XE3Ieg9skn0f7Mk+ZjKNQZMeUEpHu/o
         qAbVnsAlVKsS6xlPPnD6RlXHIni9n/uKa61WtmzJRIXKOUgH4y7kJS3le+fFBQcd/Dko
         +yHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705628609; x=1706233409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xumxo/vDM0D+nTRMI7Bwfl0XbSFAiypFLl0PL+8D8D4=;
        b=XoYN/E2rfx0oX4c0ex2grCP+vNlducjl9WU18fW+Y6P3+l4sq+IIBdLLfBz4fsQkPZ
         mQoFKjNHSuwH8ctvDAvwPNezwemUiCeNAnZtdgxozkpbSvhTpnCWsPYwC55BMzxzIVqB
         ffOfG0Qoh0q3Euu/y0CR3P0Jkssqak4CMp6Q0nJwNKvFAwzEVba1fHaCKqFwPdfR9r5k
         WdTtVFMET1/M3YTVKqOYkasNJIr02mSofVweJ06DDswtIlVa9+7RJ1zn+6pG/2XKPF8x
         MXp4szu5PB9ivAet1H+Ewnq6N/c9pCJBGJWfE3WIeLdSdtawdI+pvW9c2vptB7lToFuk
         sZCA==
X-Gm-Message-State: AOJu0YwFLERJPI059BfIOjcAhIJb5Cqjnf3Np/BNSUOuMgxYyTIfKrWu
	j/IkNb5dQ+31IAROF+XRg1000OV7YImRrFl+g7CnjthyaJyAA0mrJBdTy3USCKzNSZ16yMagsd1
	VJYOSUUzjb7DaYerYhMlDhba80T4=
X-Google-Smtp-Source: AGHT+IEjFJ6nHdiIRwFLVsTAxyTU4bsg/lHEO5ALu3SPhUVbV0TYivD4FLlvVVRcrsaEKHPwbMQKLe10QZp3ui0RJDU=
X-Received: by 2002:a19:6447:0:b0:50b:f7bb:4545 with SMTP id
 b7-20020a196447000000b0050bf7bb4545mr212198lfj.68.1705628608659; Thu, 18 Jan
 2024 17:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
 <CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
 <CABPp-BH+cPdfsctquE60tw_nD6_LCaWf0JwGusuZ0tvQQuWy4w@mail.gmail.com>
 <xmqqjzonpy9l.fsf@gitster.g> <CY7M09XT547N.2OOTI5APX9RIX@gmail.com> <xmqqo7dvloiu.fsf@gitster.g>
In-Reply-To: <xmqqo7dvloiu.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jan 2024 17:43:16 -0800
Message-ID: <CABPp-BFSTpe=wT6JM1CCYJCkYptTB_OZSpqOa0Syq3puxNxEPA@mail.gmail.com>
Subject: Re: [GSOC][RFC] Heed core.bare from template config file when no
 command line override given, as a microproject.
To: Junio C Hamano <gitster@pobox.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 9:32=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:
>
> >> Specifically, the commit that introduced the comment never wanted to
> >> honor core.bare in the template.  I do not think I has core.bare in
> >> mind when I wrote the comment, but I would have described it as the
> >> same category as the repository format version, i.e. something you
> >> would not want to copy, if I were pressed to clarify back then.
> >
> > Then I suppose this warrants updating the TODO comment in
> > create_default_files(), which currently can be interpreted as this
> > being a unwanted behavior. And also amending the testcases which
> > currently display this as knwon breakage.
>
> I obviously agree with that, after saying that I suspect 0f7443bd
> comes from a misunderstanding ;-).

Sounds fine to me.  I have no particular interest in supporting
core.bare from the template; it's just that in order to do other
cleanup, I needed to remove the init_is_bare_repository global
variable (see c2f76965d02 ("init-db: remove unnecessary global
variable", 2023-05-16)).  Attempting to remove that global variable
made it _look_ like I was changing the code behavior and breaking it
in the case when core.bare was true in the template.  I knew possible
code breakage was what code reviewers would ask about.  And my best
reading of the fact that the variable existed plus how the code was
written suggested to me that indeed someone else thought this might be
important to support.  So, I left the TODO behind to document that I
wasn't breaking the code with my changes (or even changing behavior at
all), and left some hints for the next reader who came along about
where they might start looking if they thought it was important to
fix.
