Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFD2BE653
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897106; cv=none; b=YIovV6lI+cGnu+7hHdoSyyOieGtcjCBA2m5axE6Ygmdskvmh1Mf1MG+30mwtcVMRCCkSKorfFjc6hZ/0FKuhOFBqE3UxZSlaMyc6Z/2wo8ZJeh6F4L3PPrlhjO9foarE7ZTdB7+wyYdLt3ROjNPKpFxFHp58UjsFjojOsvPhq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897106; c=relaxed/simple;
	bh=m56rXzHaG3VgP9VPtJ+vwAUfJDCSg7CaimCFOy6U6Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzjdi1jq86XI//MXayciiI9CqtyIekjKyHaTRH6RnHkQKGuZDfl9iHR6b/Tr905o96HkMw2ADmZ6jOh3ocWyLQC6zljPs+ui29h0+7xrAvArHojoF64V93aiqLvX1D7qrj5ZogyHRSFp/kBBlCvLyJ98DHp9o6Gyw5Ad8Q234ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRqi8wTf; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRqi8wTf"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8c3414ad279so269753139f.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 21:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759897104; x=1760501904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiEF8TxJTUM/wQp1zJrhyGFJBBuFzNsD3rhMRI15odQ=;
        b=lRqi8wTfEprCpzyW5Rl9jPqMJimr7J2M/mX8WR44c45YwZ0rYTDqGgTB0dMG9rTTfv
         dyrAGGD0c64B9s1U7Nr0aI2492X+NfxMjsdF4fN+YgNRffyh3swG4Zxc+uR8tuNwgirM
         I2aW2cbivwTu78iuPgBV8yNDVfBPpx4NpuJe121LbR9o27MAA17olNjh2Vm47TfGa/Yt
         jXozLXmFtlIe/0WXMFawPU3x2okG9gC1fH1yDSUjnNTbMGdKwJJL5xIgMj20R2jYK+xL
         nSs5WFwMZQEcT5ze3n9UELUrZvLubHHe0O4u+jkBnKilgfjyVUmlouB3hpfUsDCbJV9x
         TrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897104; x=1760501904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiEF8TxJTUM/wQp1zJrhyGFJBBuFzNsD3rhMRI15odQ=;
        b=ldCNmXeb7D6XDAmjG68RMhhAXQGl+By+xDSrBO9mYuLXo2sb3U2IP5gLKvVtjyWJaQ
         RQT6a5X6yp8gviudsmPTOGMN+dMEFVGtspmf+bgu4Yq84UZKJO0+jKmQX+vOfsatqdkW
         Nsc/Gw6gGaFSPfXJ/fw6K8ljE2/0kOIJe7BIfpOUv4TGFBS/2Cib4pVbNfEJjAdhqcWC
         AgfPaU+cLiKEtmoJ1A/IrEImr5aEwcoXbdmgFUXZmHzj21G0Me2ExEzKZh2vBySrgWog
         hTrj4kMMJNrxqE6RT4XbXEkFS579w66uet3emxV6l+wGvYdqZOuHmHSoH+zjlRWI0pDb
         y8lA==
X-Forwarded-Encrypted: i=1; AJvYcCXO4ZNJmykdKhstm4YUdDtH5WZ5jE0sZ0bmUkJcay95qvUsDxhLOgyKGOWdfYd2zPP24dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJT9KKGbVx5Gt4o6ZfRhVVxVz/RrELsbN89DMw5CPYy3Vd18G
	EUNRjP3Yy4xw/jl3OBuaZrZ+PeJKxcth41fMWEfl8bj1acM1mP/Ldsfhxe4zqZM/yHlDFWee70q
	N0D/xRAIcgyllVvsrqFLQ6NwPY5gGfaI=
X-Gm-Gg: ASbGncsbWMVbdSSxAvQqHg3o4EWhrfYLqL3tZoMtRdbD7VVVACJ7G8fFWzZrJsogYiW
	vAgLudYW4vY2Y3tDKd+4koXIbWbiAqH8XrTWdMinFhj1qzBc4k+HJhU/jI8wkyII2gYKHk4/QJY
	i/qa14vAre3HS0tMG4rC1qC10CUpmzRdtHGDDNZx52G/+Dpee313rpPNiJIbYjrQQj9vo8hIP+m
	2DdndxQxbH+ZKF2WB7CG4e+veVPH3M6y4BfV86+CMBtVjNGctVVEfOEfIFYEPuk
X-Google-Smtp-Source: AGHT+IF7BDcnHLH+qqap0iRgOd8NXYeCmL9+s+g5o03PGvJjc75hgIa1fIhVtksENpfjFodIa/XlSR+o7nHncA2FR8g=
X-Received: by 2002:a05:6e02:218f:b0:429:6c5a:61e4 with SMTP id
 e9e14a558f8ab-42f87362431mr15170385ab.7.1759897103577; Tue, 07 Oct 2025
 21:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net> <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
 <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net> <xmqqh5wbq5z8.fsf@gitster.g>
In-Reply-To: <xmqqh5wbq5z8.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 21:18:12 -0700
X-Gm-Features: AS18NWDRMXJd9PNMD-L3JurkvaDC6Cq4niVwn40hEqFwzoH_yyYGnu-BDHplsvA
Message-ID: <CABPp-BFf+_8cUc6sWZci9F0voosOQFWQ3x8dNs0YXEZ-uRvhNg@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Rick Sanders <rick@sfconservancy.org>, 
	Git at SFC <git@sfconservancy.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:45=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > It may matter less what the situation actually ends up being legally
> > (although it could end up being quite bad) and more whether someone can
> > imply or suggest that Git is not being distributed in compliance with
> > the license or contains infringing code, which could effectively make i=
t
> > undistributable because nobody wants to take that risk.  And litigation=
,
> > even if Git and its contributors are successful, can be extraordinarily
> > expensive.
> >
> > So I think, given the circumstances, yes, the right thing to do is to
> > ban LLM-generated contributions with a policy very similar or identical
> > to QEMU's.  If, in the future, the legal situation changes and it
> > becomes unambiguously legal to use LLMs across the world, then we can
> > reconsider that policy then.
>
> OK, so here is theirs for further discussion minimally adjusted for
> our use.  I do not see much difference at least in spirit with what
> started this thread, but phrasing is certainly firmer, and I have no
> problem with it.
>
>
>
> Use of AI content generators
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> TL;DR:
>
>   **Current Git project policy is copied from what QEMU does.  To
>   DECLINE any contributions which are believed to include or derive
>   from AI generated content. This includes ChatGPT, Claude, Copilot,
>   Llama and similar tools.**
>
> The increasing prevalence of AI-assisted software development results in =
a
> number of difficult legal questions and risks for software projects, incl=
uding
> Git.  Of particular concern is content generated by `Large Language Model=
s
> <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
>
> The Git community requires that contributors certify their patch submissi=
ons
> are made in accordance with the rules of the `Developer's Certificate of
> Origin (DCO) <dco>`.
>
> To satisfy the DCO, the patch contributor has to fully understand the
> copyright and license status of content they are contributing to Git. Wit=
h AI
> content generators, the copyright and license status of the output is
> ill-defined with no generally accepted, settled legal foundation.
>
> Where the training material is known, it is common for it to include larg=
e
> volumes of material under restrictive licensing/copyright terms. Even whe=
re
> the training material is all known to be under open source licenses, it i=
s
> likely to be under a variety of terms, not all of which will be compatibl=
e
> with Git's licensing requirements.
>
> How contributors could comply with DCO terms (b) or (c) for the output of=
 AI
> content generators commonly available today is unclear.  The Git project =
is
> not willing or able to accept the legal risks of non-compliance.
>
> The Git project thus requires that contributors refrain from using AI con=
tent
> generators on patches intended to be submitted to the project, and will
> decline any contribution if use of AI is either known or suspected.
>
> This policy does not apply to other uses of AI, such as researching APIs =
or
> algorithms, static analysis, or debugging, provided their output is not t=
o be
> included in contributions.
>
> Examples of tools impacted by this policy includes GitHub's CoPilot, Open=
AI's
> ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> generation agents which are built on top of such tools.
>
> This policy may evolve as AI tools mature and the legal situation is
> clarifed. In the meanwhile, requests for exceptions to this policy will b=
e
> evaluated by the Git project on a case by case basis. To be granted an
> exception, a contributor will need to demonstrate clarity of the license =
and
> copyright status for the tool's output in relation to its training model =
and
> code, to the satisfaction of the project maintainers.

I preferred the version Christian sent, but *if* we end up adopting
some of the QEMU wording, I've got a logistics question:

    Will we grandfather already accepted series, or proactively revert them=
?

For example, the series merged at d12166d3c8bb (Merge branch
'en/docfixes', 2023-10-23) [or on the list at
https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadget@gmail.com=
/
], which was already merged a few years ago.  I don't think that
series has anything remotely questionable from a copyright standpoint,
yet the QEMU-inspired wording would explicitly disallow it as far as I
can tell, and would claim that such kinds of things would never be
accepted in our project, even though people can find and point to the
fact that we already did.  Would that be problematic?

Of course, if we don't adopt the QEMU wording and go with Christian's
version, then we don't need to worry about whether to revert or
explain how it is grandfathered.
