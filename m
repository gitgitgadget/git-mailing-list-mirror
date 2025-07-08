Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC133256C8D
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984621; cv=none; b=YOg3YHKhkxEzlDID8p2nFv89ApPLEASvplhTb4RR07Bh8cOHLqsMfK9VrO8QI9bnVBbfa1l5KtT0uMrZw2oU68VCzHTyZ+DvwrB4FhjDge9sFW+zAwiQrSaTO8mAQuls682v+jeDKwSWekd2L42BDXkaONxFmo/zAdez1oxOzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984621; c=relaxed/simple;
	bh=3qt6XG5GUcsrcIQ7jtrOv6BXidWFg8pFiuFrl/ThteQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mz0kTkUNKZNm4l9TYTe4urMsB2x04ruOP9xDMz+e9zx8gv5ezl2LxWNHwsQ41/YOF6L6mOS7Or1MLA3j1a6sbBFmMIQlO4zRhCsnMDD4rotaGntP9RBjlxknNokzrNtx0whvV4MGxO6jhNJQ0riJdABL0EHSy9qxPaCaKEG61Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcIF5n6B; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcIF5n6B"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so6037641a12.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984618; x=1752589418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxZbANNfLmRKbOMnaJnUPDqwUliIQiL9BQdC0PKPF4k=;
        b=WcIF5n6BooN9uIK9O2vTxiEPRL9L9t3MTAgPgthDw9hl/VtOpSp/RPY/Q+OpGDNGCu
         Vt8Qagsvk3+j3cXv7x7CPG7ffqNMsXVIGZq7kU0wwtz/BLzLzwwiCaJDBEy3E94nnnLS
         yikjy9BuXSDx+hHulxMV2g1wD8MKVcMsvbIKeXXhsIqwVdhIhGE2K1rs9uRgKNZRC2+6
         hFhpl51U8OCSccV83sGnU4Y1iasfZiMFqdk+NOeI0OI+deY6ljPcUC6Z1Sb9hFB/eLqT
         c9hatEvKWAB68OpdGNNE5cQkyu976A+CQ8XOHxjgGSPkZghzb4qJvGoqB7piV/qTIJNZ
         dqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984618; x=1752589418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxZbANNfLmRKbOMnaJnUPDqwUliIQiL9BQdC0PKPF4k=;
        b=Y9UDrAPk6e4sz1dtzB9T52YWdDf+7gdtRJpjIkMyhyIyEj+WtifRaG33iJOXG2fuqU
         LV/ASFGQoSjBJhZoAaW5s3Da954cVPGfa2DJ+X6/aS72AOTMDd8as6rOfJoNvXUFEUnI
         W+erPc8we7Qeef9f+YkVNx/dfjlfoEumFgVgzQUbLCW9l2Pa29X/KyxTIiiZd/28rv7h
         cpEg6yB91hQB44GX1rAUr01/MM+t3oew4F+pRxBbcxwb0ymxGoFbeQzWkyKoxFtM9rTr
         5lpAPrv9guhFZMp2zF8U3zOtEmGHGoqALhUg3FccGXwatl90pR6O0m/L1gTZMIJVJEj4
         geaQ==
X-Gm-Message-State: AOJu0YzWQupPgzs+fx8W0JdnGGZAhBQpxnsmvyaxPMS66op90MQ7abFZ
	WgFY3o7mvJWYi0vNRI1pxNh0hEyp/KM868FgESg8HnDr2MagT/kOhnKNHJAMTab9TlCzDRNsQWd
	1i2sjyxM6sHh9ZZw9RQNh7TC1apaumd0=
X-Gm-Gg: ASbGncsSudrnJkubZTMUcLEHjfVc8nmWpNidGxyRs3g7TGMYquLKLXwG6t/oIbFiBxm
	Yi0Outo6MZEMDwUAMglw+jnIjuUD7kzxkGfe3jXPX5JXAxBObnympfb98BZrZq6KDa/hpoY8RgW
	gE9YE5Tkk6rZ3rhTubaWKnmS7/fUFqAF3RtSClJGf3RBTw6A==
X-Google-Smtp-Source: AGHT+IHqCk2DvVYJusdPMcUlwY7P1vgI21hT2pTQiUXXTfxub4XFp46GHBKbBbbcw/I7Nx57GttgBANq9+6MBelKx9U=
X-Received: by 2002:a17:907:969f:b0:ae0:67b4:991d with SMTP id
 a640c23a62f3a-ae3fe7b15b0mr1404090366b.35.1751984617777; Tue, 08 Jul 2025
 07:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <CAP8UFD0bd1PD03VPaenAd+76Q6CeCOmDOJsso1nMKk4tZ4vbMg@mail.gmail.com>
 <xmqqms9nkhms.fsf@gitster.g>
In-Reply-To: <xmqqms9nkhms.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 16:23:26 +0200
X-Gm-Features: Ac12FXzGGvv-8cvar1q3grYueFnhANxTy5YzVbja33eCXbe4ZCqMn9Do669we90
Message-ID: <CAP8UFD1StfAY3kLNmCtBJrCVM9ADuDVjQ-WC=9yMdSSouLLCbw@mail.gmail.com>
Subject: Re: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate changes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Git PLC <git@sfconservancy.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > Here we would forbid licensing any "AI content generator" output, not
> > just AI code generator output. So what we would forbid might be more
> > general than what QEMU folks forbid. For example they might still
> > accept a new logo, or even commit messages, made using an AI while we
> > wouldn't.
>
> I didn't think about the distinction you are trying to draw when I
> wrote the patch, but after thinking about it, I think it is a good
> thing to prevent us from adopting a new logo graphics somebody may
> have ownership rights without us knowing.  I would consider the
> commit log message as an integral part of any "contribution", and
> read the word "contribution" used in the [[dco]] section as such, if
> the rule covers the commit log message, that is very much
> appreciated.

I am not sure about logos, but for the commit message, it seems to me
that it could have drawbacks related to translation or wordings.

For example if someone is not a good English writer, they could write
a commit message in their native language and then ask an AI to
translate it. Or they could write it in their bad English and then ask
an AI to improve the wordings. I am not sure we want to forbid all
that.

> >> +Hence, the project asks that contributors refrain from using AI conte=
nt
> >> +generators on changes that are submitted to the project.
> >
> > Here it looks like using an AI capable of generating content to just
> > check code that would be submitted could also be forbidden. I don't
> > think this is what we want, so I think we might want to reword this.
>
> Good point.  Asking agents to proofread and suggest improvements is
> like asking your friends to do so.  Care to suggest replacement to
> these two sentences (above and below)?

I could try but I would feel better if we tried to find and ask people
around who have thought about this subject already.

Especially I think it's difficult to draw the line between a tool that
suggests improvements and a tool that generates content. For example
if I were a very bad English writer and asked an AI to suggest
improvements to a commit message I wrote, then the AI might actually
rewrite nearly everything and the result could be very similar to what
the AI would have generated in the first place based only on the diff
part of the patch.
