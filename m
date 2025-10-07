Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BECF2E92D9
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862174; cv=none; b=sBbWzhPScVNn8Z38+bL52JuvuGtJGVUXTo5YLbcbtcb+3rabw9lMBMYnO8tDwNaL+9BVL/Z6Xn1MxlvUoWt6f/MFhxAhSIDvtEjBTHWKzbrEfx88qhu6v4jdpTT52fb5Zsi1KdZltyvEoPvR+YhENHntjYZNCZFDs+vt7sSEOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862174; c=relaxed/simple;
	bh=3Jtzl+iQC8HGS/KMCOWWkkc9FxalGrqIpdheMhh017g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOY6eNi2XSHlneK8asVFxVT2HE+A1+zfhO1Xn4neTvGYtKRfRah3EnWOsdLzmfGaQBCRGw3xsx4WCekm2VT2q+sRmQYpdhnph7yfBDVMyEHuGATdVzCAEWyorhWbmD21l7/OqiagHIwSIkq8R645OSCrvTvSY+/MOybL7alXClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dp85uAe0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp85uAe0"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63994113841so4983115a12.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862170; x=1760466970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jtzl+iQC8HGS/KMCOWWkkc9FxalGrqIpdheMhh017g=;
        b=dp85uAe07pWbRhhTKIyrWxVlVj+d2y02gCT6PrNcyPPgYB8aiPtgX9CsQ2RHCL+ts+
         ubYYAVaFYw9ZXHHBEvzGfVKC6MMNeWAlElYL9ML4khXgFf1Vll9ED2qbjUChbnjXDURe
         1OlJLpxQXGSOgd8f4h0yQxMNDuCe1yxD4zOI1O8fLqIysh9TfSu/Xp/3ixcr+nXeb5lv
         4+IQgd4kprWIteEOlFhNzJzkw8yhQ5Ffo0nvF31R3tn578Y9FavDiHdn6l31KYGUJoPo
         NtNunIByMiy6LP7WDYjIUMVqrFCPuvj3DGfxUHenDGhCu3Wu4DFpsm+sTkDXhK1R3Z7r
         jFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862170; x=1760466970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jtzl+iQC8HGS/KMCOWWkkc9FxalGrqIpdheMhh017g=;
        b=Fa5n4R3sIxJE1yoQhUYK5X1Z223C9xJVypQKWqMKbdWTBT0acGnPTL68JW3T26wNmV
         A0n4lYNAosvlKhJJA9Lg/EceJjQszD4CmzbncOET4wszXd0zMfVQ5xaNMsf1CneTlKKe
         QACuGUfid1UsvF6wBgBCG/0RNl3JLuVEYBTcQUa/HFYZO8dlxFfWdE5C7+gQyNj2YUZp
         rAR/cb+q8SWQoNHR/OZJ1DbG/ErwiMcPpcqFpLfAnggek6uIfsIs8jsvDSVqAhBI6OrA
         DNkpxdwOkdPuXh8uqwhrfQtJnPph/ZgRSuSdiEp5aNNjZcd0Mxi0qcuUACJxF+uKOMC4
         eyKA==
X-Forwarded-Encrypted: i=1; AJvYcCWHvQQgeW7FuGuBRraRmpFsdhcHkz8rDD5MleFoxYSKl7tyICFq/GDEdCWRFHu21boEF5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDiNG9fWAZS40VMlU3nIzYImmbl+mkAtboTjGXUVnD4/TauKt
	3iH2AGMDlJzPz7BVGgJBmx3O/6cTL2AYWT7xWCz7gPDpvC++EarpngzYQGuSINCfe2Uuk5uM3UH
	ckDrR+ts/fZzfDwhUVBZzt7jN6nelBp8=
X-Gm-Gg: ASbGncuFtsPqXBZIVlqMVnM7U+3lE6WJ0y8ToZOIvrqKG6w3eMaW1Rv70eDUk/Zm2Gk
	lEhyhK7Apf37PPznTnpEPMfvBEr1M7OL6kPBJExVLvTLMuNB5bh/LT27FcA2iiLBY5t/O+zD33V
	VZrKLmTolDiESyxAc8MR520lAl5i2ZWZX/omcefX+/3YMnPSwA6PcXt6O8MxCIQfkr046WdlAKY
	6aYo8/DTSJyM+gTnc0FiSFIX8nhO/xNQkuLUQP4+yrZ2mX2bpNFgUJ0velYhEyVxA==
X-Google-Smtp-Source: AGHT+IEyN3fz30i48Ejuf477g/qTgOnqUBGqNDQwISgJYsvolg/diyKdnfdrrrxcPhKt+K8+k1comHy4RwcRtSMKyJQ=
X-Received: by 2002:a17:907:a909:b0:b3e:5f20:888d with SMTP id
 a640c23a62f3a-b50aa7a1685mr85778766b.27.1759862170176; Tue, 07 Oct 2025
 11:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com> <10a9718421aa842573a2ba1ecf58d2cc46b5edd9.1759777131.git.gitgitgadget@gmail.com>
 <48224822-9f8f-4230-97db-a7fdefa557a3@app.fastmail.com> <80f61c1e-8e0d-4a7b-868e-876091595e3d@app.fastmail.com>
In-Reply-To: <80f61c1e-8e0d-4a7b-868e-876091595e3d@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 7 Oct 2025 14:35:58 -0400
X-Gm-Features: AS18NWDwjDh0MJlNJU6iw9cx4K5SsEiNrRkTZmIVFesfZW1VJMif4oGhKQK5Hbs
Message-ID: <CALnO6CDw-UbfXWFsODReZemwbk_7Wtb34vKNDYfFPKqivB1Rcg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
To: Julia Evans <julia@jvns.ca>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:35=E2=80=AFAM Julia Evans <julia@jvns.ca> wrote:
>
> On Tue, Oct 7, 2025, at 8:23 AM, Kristoffer Haugsbakk wrote:
> > On Mon, Oct 6, 2025, at 20:58, Julia Evans via GitGitGadget wrote:
> >>[snip]
> >>
> >> There's also a very terse description of "upstream branch" in the
> >> glossary that's missing a lot of key information, like the fact that t=
he
> >> upstream is used by `git status` and `git pull`, as well as a
> >> description in `git-config` in `branch.<name>.remote` which doesn't
> >> explain the relationship to `git status` either.
> >
> > nit: s/either/, either/ ?
> >
> > I think that would flow better given the long distance between the last
> > punctuation/comma and the end of the sentence.
>
> Is it the norm in this project to provide detailed copy editing feedback
> on commit messages like this? Of course it's important for commit
> messages to be accurate and to explain the motivation behind the
> changes, but I'm surprised by the attention to commas.

AFAIK, yes, though I can see how it might appear discouraging to
irregular contributors.

>
> >>
> >> Since the `git pull`, `git push`, and `git fetch` man pages already
> >> include sections on REMOTES and the syntax for URLs, add a section on
> >> UPSTREAM BRANCHES to `urls-remotes.adoc`.
> >>
> >> In the new UPSTREAM BRANCHES section, cover the various ways that
> >> upstreams branches are automatically set in Git, since users may
> >
> > nit: s/upstreams branches/upstream branches/
>
> Will fix this typo if there's anything else to address (or if folks think=
 that this
> is worth a re-roll on its own, not sure what the norms are).

It usually ends up depending on whether Junio applies the typo-fixes
locally, I think. If there's nothing else and Junio grabs these, then
we probably don't need another re-roll.

--=20
D. Ben Knoble
