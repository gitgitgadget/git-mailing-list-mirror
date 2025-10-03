Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8877267729
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481488; cv=none; b=Owy6QkgY1DLJYkWVf1P/CsY306zIo3bRnsqTxqr/rdlwepSztjS9cdwegpk0fDNLn0PDU9se/UlYu6joO0fYPZw0gzQ8wo1sE7B51xLaA4XpTHkgVQzHXQxC4lXIjqSIvavT8PdOVGLLt0ktjDrGPCOVq2zgdxWzc/6idIS/UDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481488; c=relaxed/simple;
	bh=2x8/6CV9at/8HQQh1X6TbaLlNbnlABKg4aMw1A3Zckg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcQ9XS2ycvOB1318hebV/oHoDpT9M1FXQan/rpWRd2lSFbt8rKbkPnfZ7p6qAbA3Oh+wdkJuPlZCJe8qpUtAHsxAaqlbugmcsTpFDgjku0LfpSkY32/im1r1wqrOOGNkXC6tlDrpfOKBnlOVtqMEBWHHDxDIfkC4p4Uln7Nk2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/V9Zt8T; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/V9Zt8T"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so381177266b.3
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759481485; x=1760086285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG5StTOowRs4AXqOouzsXKlfCW7P139c4YhORlNZ3fI=;
        b=h/V9Zt8T184a3ko9m88hMWXAlWGgeCvnLNm3uEHOdTatOlw6igpg8WhcfYKQDw6F3Z
         JMjksejBwHXMgtAo0QolrR18JqQH2GEbAwG+YaFXT+q2uyGuXTpGE7ZEa0AojxFp5Qab
         Gsuiefl664uhlWODY8nmD5Givs6YEk2dmmHLnwzhkBZsBzNgkVB01AmN0zpNsRxCQHdR
         LME7qtnJ7vUXhTGxhasmRyoAN+EW26a+bqw4L43ftsHGhoH19t2MFxeLAfDkMzvJw3w3
         mrL2QzRa2+LWd1QzxV3rLGqL1c3rBNTwg50pGlrs/Oc1IqSKi7NLc8yUK+mp4H6yDfTr
         OCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481485; x=1760086285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IG5StTOowRs4AXqOouzsXKlfCW7P139c4YhORlNZ3fI=;
        b=lVPzKhU0pDncVKyYy0WZTbEkU0lfS4s+2G4Is1VVKk2UAIrQmodW0AiDzXivk+La+o
         zrCY/LIPFzhvo24Bm1Vmyibzam9R8jGeXVM0nJSZejJx30vpAGRt+f5MiuyrE963hduH
         bK76c+yjUvnkjc9g0EFnrnpUV4WJ1FaflAwnvbvCFXe/I5jI5Mov7/3aowdrO7UrJxd3
         LEQzJPDFMyZuk/9JJYeiVXzQor2Cx1i8Mu7K2hwXOjg5sspvQisrwUA5vePxGWiHgQpN
         aOmdd8Ymq0HvwuLs8jRlrwGi8wa9II3yAb2/C7IilApFIhoMwCirnGk3fnFaAfRMPS7Y
         3dvQ==
X-Gm-Message-State: AOJu0YxLGt4fJZb2dlYcq9FUUY4K2nluUquu2zs98x2WQMz1RRI0jOJ7
	cckDfiMx/GdZbE0nVVqZ50mPQAzhY+zMZABvEPt7KthYM8dzhb11PN1MiqxYzmfEgEOhqAZIKQE
	nGJeD4XzCbwnhikcqCzK0tfOWPl0MWv4=
X-Gm-Gg: ASbGnctBRtPl6EHQEAlPVCWhlfFR570YlT0M+0WngfTTDPXFFkHsGN/Kb3jkHzw3086
	GC+FVkgNZ9g4zQw3seNcqswKbpAAIv3TTYubD04upFqaUauimMU3Scy+nnyjsCVW2C/FBXWv3/v
	Qg3QHE4H2Kl+FkMjynvx7V6CuqqOmUQ7s0yrSYhccFHG+i8CzKR/IQ1/E9u4g2eJHWlRWKyDlol
	I/bV3/36PAeSXevnjuuY88v7WSgZ5o=
X-Google-Smtp-Source: AGHT+IFz2MK5nFVnjkbVmtcpokP313kRDJOrZ5xscNQRvadRPzOCKmfP1NOJjinXVvoJ5NMWpWazVuPYV5xDUoV28eU=
X-Received: by 2002:a17:906:9f96:b0:b3b:206f:23f6 with SMTP id
 a640c23a62f3a-b49c3935b6fmr275291766b.40.1759481484935; Fri, 03 Oct 2025
 01:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <xmqq4isi1gpm.fsf@gitster.g>
In-Reply-To: <xmqq4isi1gpm.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Oct 2025 10:51:13 +0200
X-Gm-Features: AS18NWA-KlTf8Ll0KPfoRR6CYVeZ1aKHrV2YiX9NPtnDwCaHTjOjMxb-oeGkyPs
Message-ID: <CAP8UFD3wc-aj27Q_kFXvknJrpa-ySWbZiPmNCTMboA08=HP+xw@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 10:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > As more and more developer tools use AI, we are facing two main risks
> > related to AI generated content:
> >
> >   - its situation regarding copyright and license is not clear,
> >     and:
> >
> >   - more and more bad quality content could be submitted for review to
> >     the mailing list.
> >
> > To mitigate both risks, let's add an "Use of Artificial Intelligence"
> > section to "Documentation/SubmittingPatches" with the goal of
> > discouraging its blind use to generate content that is submitted to
> > the project, while still allowing us to benefit from its help in some
> > innovative, useful and less risky ways.
> >
> > Helped-by: Rick Sanders <rick@sfconservancy.org>
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> >
> > ---
> > This is inspired by the "AI guidelines" section we already have for
>
> A more important thing to mention is that Rick is a lawyer at SFC
> helped us to draft the wording used in this one.

Yeah, right, I will mention it in a v3 if there is one.

> > +[[ai]]
> > +=3D=3D=3D Use of Artificial Intelligence (AI)
> > +
> > +The Developer's Certificate of Origin requires contributors to certify
> > +that they know the origin of their contributions to the project and
> > +that they have the right to submit it under the project's license.
> > +It's not yet clear that this can be legally satisfied when submitting
> > +significant amount of content that has been generated by AI tools.
> > +
> > +Another issue with AI generated content is that AIs still often
> > +hallucinate or just produce bad code, commit messages, documentation
> > +or output, even when you point out their mistakes.
> > +
> > +To avoid these issues, we will reject anything that looks AI
> > +generated, that sounds overly formal or bloated, that looks like AI
> > +slop, that looks good on the surface but makes no sense, or that
> > +senders don=E2=80=99t understand or cannot explain.
>
> A milder way to phrase this would be to jump directly to "we reject
> what the sender cannot explain when asked about it".  "How does this
> work?"  "Why is this a good thing to do?"  "Where did it come from?"
> instead of saying "looks AI generated".
>
> It would sidestep the "who decides if it looks AI generated?" question.

I don't think the "who decides if it looks AI generated?" question is
very relevant. If someone says that a patch looks mostly AI generated
and gives a good argument supporting this claim, it's the same as if
someone gives any other good argument against the patch. In the end,
the community and you decide if the argument is good enough and if the
patch should be rejected based on that (and other arguments for and
against the patch of course).

For example, let's suppose that in the future someone knows that
ChatGPT7 is very likely to use double dash ("--") and the word
"absolutely" a lot in its sentences, and notices that a contributor
sent a long documentation patch that is full of them. I would say that
it would be a good argument to reject that patch. We could be wrong in
rejecting the patch because of that argument, because maybe the
writer's style happens to be similar to ChatGPT7's style, but I think
we should have the possibility to reject such patches based on the
fact that they definitely look AI generated. Otherwise I don't think
we can seriously claim that we try to uphold the DCO as well as we
can.

So I think we definitely need to say something like "we will reject
anything that looks AI generated" or maybe "we will reject anything
that looks significantly AI generated". In the v3 if there is one, I
will change the wording to the latter.

Thanks.
