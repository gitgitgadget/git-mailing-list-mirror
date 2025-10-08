Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F6299A90
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897105; cv=none; b=eiG0xrISEzfMktmhfApFvKLP1L0/OHnyHkjijVcjn5wbpwZJGtB3wlBGcyDat3xn4vbdy0vCLg8FR59lvjxGVrOTlqjFAGQWhNm2bm6oJlcrPUTYaZ6SQs9coFVlzed7t8/LmP70op0vElURtAAIZDZUTwxNcshKk/P/g5fInVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897105; c=relaxed/simple;
	bh=+xo17Qu90WCS8BGWIZIcFz+jKjgE7hqem7+4fjS3p1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sIQoFJdhyk9QjbNpppBN9hbfw/xXpilN4//LeYBPiVxc+GpIYGQD9BaI73SIXJP/0lbDTO2YFpMz4+tJ7UbVF/cceM1xKHpHepRDh5+FVT6VnPt1SIheV8BzFPMHCNvDlFfuU/u0S+uXEZZxrgsJdCX61xrDe+ZrkNN6OrIA1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtnTBxP2; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtnTBxP2"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-92790f12293so335152539f.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 21:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759897102; x=1760501902; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhrzD1Op1Gk2X9nH2bfImUqtkrK60x328StG0Xoo+nI=;
        b=TtnTBxP23LJuEE1ydfBWTGncx9Eez7dA7QhJ3lib6/BzEbXbwMNjkkl+YsgJ0+EUva
         HIvIGPX+dYdn3yp9kfBf++2QjhmHvbFsl65IGRnf8+ex3bJEIFzIsglj9NhKSWPwL2Ag
         vi6W9V7I7zoyIK+6zyLE/rU6p5dWlv39Fjz5ipzOEktwwC2L4RsxjcSQg21omHj0IDkF
         3o043IA7yZBAs8T9qZPfr8HoTAUSIWAYRBMLDMJrD5uxPVOhTrV6FxXOTVNKeWu6Edv7
         RBoM2KfzF+4HlF8sVfpuf6TOd5tYB+YF2grTZbLqY3jZq3rOsgu1qfHbwfQSTy41e+uS
         terg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897102; x=1760501902;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhrzD1Op1Gk2X9nH2bfImUqtkrK60x328StG0Xoo+nI=;
        b=HYRq+g2KJL93Vv0+PAcjWd1EZLwYQx0R8PWUmnn482cLcfThTwps8cKkvgl5d4jz3B
         UeVmjBYdZAfqa4ehUs893MweSm3zcwAXM+5GuL0Y1S8jQJq6qbwJJI+KIx5U5Wks5EAD
         KTOxPqIgWjdpxU+m5Ma9IGcwN/Fb3CeSRm1lf9r4oAXtHeHwQP4iVs9hGs/lrmyZwnfK
         hMiQ4miAiWyatvajitTe59Gelsrwbrp1kdVva/yGoJpwYIkymSx8EIQgfQqT4MTyk3Y5
         skmhbw+Hj4zbSpqvBidbzPyRUo6mokG5730osFirq605fJkZLH22lHK583o1nD+NaPgm
         Iqog==
X-Forwarded-Encrypted: i=1; AJvYcCVMlfjIGOen/UpZHrzzbb3kQDr/XLC7pPvBQk8prk3hFiibczLhAcNfQ/ByXiNYPVPYCH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOT17ve5YqDzUY1K1dKc55QGyVsBWPYNq8jWuHFwvC2LVnNHs
	8alieu/BSfh/0gTKmQKE+i11MDhVY7r7/moyDgMX7V+BvSNbkKC3PpJHp2GKTK4B8+0rpumUQBi
	WzIsCtkl43KUXxnDEkT3galRatMp20bU=
X-Gm-Gg: ASbGncvKTK98BTcRj23z/JHeuoBxxjFRDS6ne4pXpltf8Mmb6/3uy7nLXj98SZ3UNRW
	C185yxpFZ+HSNL39u7cI8zVRXRMYwS7K3mkCUDNbx/hbhomgQxxWI3kJNzszhdtTcCec0JqRtCJ
	aAyiq3vXygf7VsgVmU39XiI7n+6ZMHLT+v9Su+zmfEKj4KQLoX86vml9SJboVByXZS3CdywqmpL
	GndF4yN+XJq3cUdqcI+BL4uniB1rYUu1zcnINGjOKokxvxcdF4nC1k7aoRAMfmw
X-Google-Smtp-Source: AGHT+IFK6WV4u6OTZrEbybkb7E7VnHHJPLZHn0puAqe2dAif4uu7CHraKZzwta16qqtovnpoJ5SIOsQP3F7tABr+W+0=
X-Received: by 2002:a05:6e02:1a01:b0:42e:d74:7260 with SMTP id
 e9e14a558f8ab-42f8743c075mr17225375ab.29.1759897101647; Tue, 07 Oct 2025
 21:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net> <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
 <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
In-Reply-To: <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 21:18:09 -0700
X-Gm-Features: AS18NWAhhAfiOkifAWY_s7-ElUXNUm2o-x1nA-jyXm6WsvOqEMlrBSdfJ-jcyNs
Message-ID: <CABPp-BHNaWdjkFuWs7uHdNweuurDGhb3DOrseSZmAEQnCEZFgw@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 3:20=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-10-03 at 20:48:40, Elijah Newren wrote:
> > Would this mean that you wanted to ban contributions like d12166d3c8bb
> > (Merge branch 'en/docfixes', 2023-10-23), available on the list over
> > at https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadget@gm=
ail.com/
> > ?   We don't need to go theoretical, I've already contributed such a
> > patch series before -- 2 years ago -- and it was merged.  Granted,
> > that was entirely documentation, and I called out the usage of AI in
> > the cover letter, and I manually checked every change (discarding many
> > of them) and split it into commits on my own, could easily explain any
> > change and why it was good, etc.  And I was upfront about all of it.
>
> I think the main problem here is that we don't know the copyright
> status of LLM outputs.  It is not uncommon for them to produce output
> that reflects their training input and we see evidence of that in, for
> instance, the New York Times lawsuit against OpenAI.
>
> As I said, the situation is very unclear legally, with active litigation
> in multiple countries, and we have to comply with pretty much every
> country's laws in this situation.  Whether something is legal in the
> United States, where you're located, is completely irrelevant to whether
> it is legal in Canada, where I'm located, or Germany or the UK, where we
> have other contributors.  We also have to consider whether it's legal in
> all of the countries that Git is distributed in, which includes every
> country in which Debian has a mirror[0], even countries under
> international sanctions, such as Iran, Russia, and Belarus.
>
> It doesn't matter if the person using AI has indemnification, either,
> since that only covers civil matters, and at least in the U.S. and
> Canada, knowingly violating copyright is also a criminal offence.
>
> The sign-off process is designed to clearly state that a person has the
> ability to contribute code under the license and I don't think, as
> things stand, it's possible to make that assertion with code or
> documentation generated from an LLM except in very limited
> circumstances.  I don't allow LLM-generated code in my personal projects
> that require sign-off for that reason, and neither does QEMU[1].  I
> don't think I could honestly assert either (a) or (b) in the DCO with
> LLM-generated code because it's not clear to me whether "I have the
> right to submit it under the=E2=80=A6license."
>
> To quote the QEMU policy:
>
>   To satisfy the DCO, the patch contributor has to fully understand the
>   copyright and license status of content they are contributing to QEMU. =
With AI
>   content generators, the copyright and license status of the output is
>   ill-defined with no generally accepted, settled legal foundation.
>
>   Where the training material is known, it is common for it to include la=
rge
>   volumes of material under restrictive licensing/copyright terms. Even w=
here
>   the training material is all known to be under open source licenses, it=
 is
>   likely to be under a variety of terms, not all of which will be compati=
ble
>   with QEMU's licensing requirements.
>
> I remember the SCO situation with Linux and how it really created a lot
> of uncertainty with Linux because SCO created FUD around Linux licensing
> and how that led to the DCO being created.  I am aware of the fact that
> many open source contributors are very unhappy that their code has been
> used to train LLMs without retaining credits and copyright notices or
> honouring the license terms[2].  And I have spent many years working
> with non-profits[3], where I have always been taught that we should
> avoid even the appearance of impropriety.
>
> It may matter less what the situation actually ends up being legally
> (although it could end up being quite bad) and more whether someone can
> imply or suggest that Git is not being distributed in compliance with
> the license or contains infringing code, which could effectively make it
> undistributable because nobody wants to take that risk.  And litigation,
> even if Git and its contributors are successful, can be extraordinarily
> expensive.
>
> So I think, given the circumstances, yes, the right thing to do is to
> ban LLM-generated contributions with a policy very similar or identical
> to QEMU's.  If, in the future, the legal situation changes and it
> becomes unambiguously legal to use LLMs across the world, then we can
> reconsider that policy then.
>
> [0] https://www.debian.org/mirror/list
> [1] https://github.com/qemu/qemu/commit/3d40db0efc22520fa6c399cf73960dced=
423b048
> [2] Regardless of the legal concerns, this implicates professional
> ethics concerns, such as =C2=A71.5 of the ACM Code of Ethics[4].  Ethics
> requirements usually go well beyond what the law requires.
> [3] Software Freedom Conservancy, which handles legal matters for the
> Git project, is a non-profit.
> [4] https://www.acm.org/code-of-ethics

Thanks for clarifying your position.  To me, your preferred wording
for the position statement doesn't quite match the rationale.  I think
for cases of:

  * fixing typos
  * finding wording tweaks to existing documentation
  * tab completion of e.g. the next three lines in an IDE when limited
to e.g. what most any engineer in the world would write based on the
comment on the line before (or if the AI plugin doesn't quite get the
three lines right, well I already had them in my head and if it gets
close enough, it's easier for me to accept and then edit into what I
already knew I wanted)
  * assisting with wording in writing a commit message as an editor
(or maybe even suggesting some initial wording based on the patch I
already wrote)
  * identifying potential bugs in a patch
  * identifying potential typos in documentation

that none of these particular uses cause problems for the rationale
you specify, but at least the first four would be disallowed by the
preferred wording you want, and perhaps even the last two wouldn't be
allowed either (though I don't think AI is very good at the second to
last one, so not a big loss on that particular one yet).  Perhaps due
to my incomplete understanding of copyright all of these would
actually be problematic with the rationale you already gave for
reasons I don't yet know about or just haven't yet understood, but if
not, I'd rather not disallow these kinds of uses.

The first two from my list have a good example in the form of the
series at d12166d3c8bb (Merge branch 'en/docfixes', 2023-10-23) [or on
the list at https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadg=
et@gmail.com/
], which was already merged a few years ago.  So if we adopt wording
that disallows these kinds of changes, then we also need to talk about
whether we grandfather already-merged series or proactively revert
them.
