Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D432B9A5
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348019; cv=none; b=uhiPYl+tDuoU2Epln5xRi4eMGw/JX32TbpTn/iuB7req2h6JC65QbqvkO0zm77CX7zkFV6govlxs1KDg9+scdqLXOl4XRd3iZd6qxxlCv5C/1Ve353uSHYDDy4FWttvpVbIWMYil8zGwB+knTaQNqnePdmoFeqgg6zCy7dnguXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348019; c=relaxed/simple;
	bh=MSBoTDCkancuU/mqUWQv1cqr1OMjBOQTe+m8kw/Hl5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT16XwnJiUHsc0fhkvzNr7F3s/E6MuaNB2b49jp3j0iHn3C5//4TA0skQHOIAvaKTmQiNtgcczTHlkF2bWzKsKC6qhc2+o+rbcsAHRTPWfjNxS7VIYWRdCPws97yvsz3YBtB1F9G4bXdLO0DHe4l9KolDToWesCRPm/WDMN9Jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9imRLFH; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9imRLFH"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f664c47adaso22448585ab.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757348017; x=1757952817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiJeDhsZjF6qA6SpZVsUXZUJ/G++BfdDKvXdbPolYHc=;
        b=K9imRLFHu63wNjBqx7YktSpzD4KD2Qjozqe7dTKoQmRCBAKlrAaa68roJoDEdvJ/4F
         9jKxlIM7EwAbXX/7XNgU/oy6yfGMcx3ZXUsB1iYKCtQEpL/siaI1geXcwDooyA9RnBx0
         l/2GwxOnEGjW1pzP9hWwnHn46oaOFTMZylfMXcVQ2kn9UU4TLyG0b7H4uES/EfCBGTUY
         wUr+JCzYMWYfDoTf/UA5XAaUSDCbYOM8UoqfTt8M3/dkf2fGrO9pWC21tQ+FPbngQHjz
         JCZuFKZ3I+8So+lZTY5Ds493QX5GfY9R7SupdRap0/eyEKLgeK+abf/g9sl/16073PZe
         R9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348017; x=1757952817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiJeDhsZjF6qA6SpZVsUXZUJ/G++BfdDKvXdbPolYHc=;
        b=Z3fYA0Lv3IB8XYMEKb3pd53L4hpA+jtOolW1sMkm7uJ+cNI/Fxvo0WXI6Db4sxtfW2
         xCsgSErYUI8kguJgzqgRn7kTxbqkb8YE1S1o+7UiK0wpPYEomxkLcm9ZpusvclBFi0pt
         mF8rJUYdgpZdNJekYY7nBBeHN7VsrNL+vX0SHTdFReZ+YSKQMlF2oe/m8721vhw204n8
         Gp2bUVCc4WC8VaFylLMsYsKs845Pyn7Lo3p0eZkcKyJpbvTiPAcZD7GAkwQIsrIWJQ+h
         ifBy7qCahlMsoRISzLwqmWF5Z8dmikoQHc4p+QhveFdNXAtFy49BHyKuAW9H+zOKMvPE
         /8+w==
X-Forwarded-Encrypted: i=1; AJvYcCUXHMQr25P3hdAtrlkYG/gxW++k4xvR9BVZlZMaWgDbVztH4juNHvy0YIvJmnqzbpkjJ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKUHpdfPEzyCmfQ+Kb2eT2fCmHwWzU9vh8e+qWRfi2/PgjKiz
	5NAjzoS7vjupSbveI/vV1TyJb2kkeP6wXx4pgPzq1fkReTmfUDoJMIkwkGZtGW5hlD4rJobkpc6
	u261YS5bz9diBdOSGWyDsFl1CExUFEs0=
X-Gm-Gg: ASbGncsI0EAjQYSZM/TEatlR2gCeByatLKc2tlIw5jdsJOuCx3SCtOwKigeOyC4+KJ1
	w5QO1s9pP6rIKdXio3Xe3NVNGFtcGJrVPr/H8ub/2hBoBsXns38sRjxwO6Ft8F2ObRTjv2PRZIb
	ZxrMrRvEAjEOIrFPuIqDfuR5WQLoxqIErBxZ608YKTXkrGTq5ABF3w5YTMJF83WoWrVgG4g0aNu
	Pr5mC6YHM0wcSK09gG9khnuLBM40lLyZVmxvjqMJFk/uBjfTwADy+DpM8U=
X-Google-Smtp-Source: AGHT+IHVvOjQ/f+h3L0Aih3FEfyCZiaU445Qx3yN4E1KPVVp1kwuFztoYVbLzgHLImUBoAeX5bg7InQN1QzaKQGIbYM=
X-Received: by 2002:a05:6e02:1605:b0:3f6:626d:6b50 with SMTP id
 e9e14a558f8ab-3fd7f0a8726mr130089195ab.11.1757348016954; Mon, 08 Sep 2025
 09:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <aLqIHCdlbwF5X6Cm@pks.im> <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
 <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com> <CABPp-BEEU0yhurwewuRjrceU+AeHy9vYzXaOFmK5u0nnoSbp6w@mail.gmail.com>
 <049401dc20d6$69086400$3b192c00$@nexbridge.com>
In-Reply-To: <049401dc20d6$69086400$3b192c00$@nexbridge.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 8 Sep 2025 09:13:25 -0700
X-Gm-Features: Ac12FXwEoJW4nP9cnph9Sqt69IIwbEXk_PAh83bMZd_wTnugn4NK2octsDDl79M
Message-ID: <CABPp-BHQyQk+Vkzm3RhVXxvNrpLB--bCLYwSCfZBQhB6PGBQQQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: rsbecker@nexbridge.com
Cc: Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:37=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On September 8, 2025 11:31 AM, Elijah Newren wrote:
> >On Sun, Sep 7, 2025 at 9:10=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
> >>
> >> On September 7, 2025 12:10 AM, Elijah Newren wrote:

> >Thanks, Randall, this is useful information.  In regards to one point no=
t fully covered
> >by Phillip:
> >
> >> Also remember that without support from the git team, the code base is
> >> no longer the same, meaning the auditors will not necessarily accept
> >> fixes from third-party sources.
> >
> >Why does it need to be "third-party" sources?  Linus years ago blessed h=
aving
> >someone else be in charge of providing updates for stable releases of Li=
nux.  Junio
> >could do the same with Git and similarly mark an individual or group of =
people as
> >the maintainers for the last Rust-optional version of Git, and those ind=
ividuals could
> >make official releases of Git with extended security fix support.  Then =
it's not every
> >platform repeating the backporting work that needs to be done, but rathe=
r
> >individuals from the affected platform(s) collaborating on that work and=
 then
> >making official first-party releases.
>
> Linux has one set of rules, and other platforms have others. I do not def=
ine the
> audit requirements for PCI, SWIFT, or HIPPA compliance (and other rules o=
utside
> of North America), which apply one way or another to most of my community=
.
> The audit teams, which are both internal to the companies and at
> governmental regulatory levels, do this. It is 100% out of my control but=
 is a
> reality. Fixes to any code involved in managing financial and health inst=
ruments
> must be done by authorized and recognized sources. I am not one of them.

Perhaps I wasn't clear?  Let me try to summarize what I've understood
of the conversation:

Randall: We need to have official git releases for the last
Rust-optional release.
Elijah: Great!  Let's enable interested folks to make official git
releases for the last Rust-optional release.
Randall: We need to have official git releases for the last
Rust-optional release.

Which makes me just want to repeat what I said last time -- let's
enable some folks to do that.
