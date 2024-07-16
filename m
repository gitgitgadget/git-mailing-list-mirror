Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D818E28
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152748; cv=none; b=G4H+5NeA/TN6FyTJfzjd2EBInEJSeu4gZHpjqt3M0rRuvGO6ETDeWUOrKKpEfiJYNSdGUjr8O5hRqM6gEZmw2G5pAcatwmB/p4JgL1UlC6D/65DuhHXfp4ZMaTxVLh+WeYBt94gBtxe/PzjFOVCHLk/tNGOdlWrQvG49LVKQmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152748; c=relaxed/simple;
	bh=96nKq3bb/7zEQt/x0TTw3mMlOtVefYqrMr+Zp1Bt01M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEK9Iq4hjw5fiETdrN8ZX0aDu9dVK41m9doYS2W1O+jEs1WeQrxbwq8QeD3sNvLN/RVJJf0+78gwAKQMNzmQ0bY3Zcz6gqZuI17jog6xDf2xpzHPc5Td50t//ODIGtG/UCObR951eRIoHbKy4Fc11cUJAFrXygxYtrCZYFdmWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4kGndF6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4kGndF6"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447f8aa87bfso40881cf.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721152745; x=1721757545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj+EUwwO02kA0kM1MOTNdInQGK2fjIiZoSVXvDHAN20=;
        b=K4kGndF6PjnVDTWWAcdjLbFpsLhWnpffUrjwQuzeXF//wn2yqPgmcdUqoJHx7Jk2qA
         1yQMn3EcDt/uWPfPQ4i+HLCHBj5vOSW6RHMEW3deqO6Tgi7AeEFiTbjgKsOzkEmi+0Qa
         w6mzREYUHM19iaMdXJkYNOh/aE/fBxZ9rj/WzWc9Jh/CNKIFEWpSVZuu/Ptctj9gYs4I
         XEuK3OY/1I5SwH+t2ONUZDhimeRBaMPlAn2RdvOPrXXvCdDmUcOwuErwyeVdIG1qFZ/I
         QKFwlSnLX2gsuOWD49kRKj5+dcFVD+sLDxZ62masP5FLGkghotfAR6Xr6uWMEK3VZYEP
         aUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152745; x=1721757545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj+EUwwO02kA0kM1MOTNdInQGK2fjIiZoSVXvDHAN20=;
        b=PoVnr2hyKPoxuPcg6XBYwnXsTFcBm4AU0EXnajpDyDh9ZK8otNed11i1bTyloGlEk9
         VAeLKZG33Kz8UM8ku9nvXJqMeZNEEx4H350tP2yO7J2fHYE23N+T8nYNWx8Dlpr77dJ4
         FbuwgxcL64JKFHeRgwrvCeViSf1fEZ+PO1qkQolH56Hvpmv+DmXNArs7vVR0GMF9HrTq
         hRZlmFMMQXwH/Wk9rY/+VgJa82rMogvQPF2Xep9aRgCe8RVBLGXldCEUcNK6U+dz6hf5
         u7FhEQspqNjTswmGOvj1sDqaiA232SbT9KEfyrnqfOfJy8ZdcG7J/CUWuUKqkF43Zfmc
         HZZQ==
X-Gm-Message-State: AOJu0YxVhCUwrl+XUmNBVskYDa1nRTZu3SYn3SuQThg+Pf0SnylSk+Co
	II79AoabMzz/nKf/NA6yB0IoSqSo4jbwooOY7uzR2mQp9LRL+zSjQD50e3jRiv+SWhndoYCUXhs
	54v95ROskMt/CNPryVQRi/usYArvjdkSv/BGP
X-Google-Smtp-Source: AGHT+IEduiGrmrduCft8dsRGLmdTkbkl9GXCavLSRQCdVB+gFk+/2d4F1HLP6yywuAIEdrgx2fAA5INgkLkv3sdPLq4=
X-Received: by 2002:a05:622a:1c08:b0:447:d225:6e3a with SMTP id
 d75a77b69052e-44f839438acmr181711cf.4.1721152745090; Tue, 16 Jul 2024
 10:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711232413.693444-1-emilyshaffer@google.com>
 <xmqqed7ylbna.fsf@gitster.g> <CAJoAoZnUbgX1MpisdS+TkGLFrBUyX_x_M_Q6iZ2n_AhP8r4mNA@mail.gmail.com>
 <xmqq34oa1an3.fsf@gitster.g>
In-Reply-To: <xmqq34oa1an3.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 16 Jul 2024 10:58:52 -0700
Message-ID: <CAJoAoZnbsqF7xi9AW4--d9Dsfh=GnRuko6rRELsGUW0ihRvaVg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: add platform support policy
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> > If I fudge with the rewrite a little, I get:
> >
> > """
> > Git has a history of providing broad "support" for exotic platforms
> > and older
> > platforms, without an explicit commitment. Stakeholders of these platfo=
rms may
> > want a more predictable support commitment. This is only possible when =
platform
> > stakeholders supply Git developers with adequate tooling, so we can
> > test for
> > compatibility or develop workarounds for platform-specific quirks on
> > our own.
> > Various levels of tooling will allow us to make more solid commitments =
around
> > Git's compatibility with your platform.
> > """
>
> This reads well.
>
> > """
> > Note that this document is about maintaining existing support for a pla=
tform
> > that has generally worked in the past; for adding support to a
> > platform which
> > doesn't generally work with Git, the stakeholders for that platform are=
 expected
> > to do the bulk of that work themselves. We will consider such patches
> > if they
> > don't make life harder for other supported platforms, and you may well =
find a
> > contributor interested in working on that support, but the Git
> > community as a
> > whole doesn't feel an obligation to perform such work.
> > """
>
> The part before "We will consider" reads very well.  The part after
> that, I haven't formed a firm opinion on (yet).
>
> > """
> > * You should run nightly tests against the `next` branch and publish br=
eakage
> >   reports to the mailing list immediately when they happen.
> >
> > ** You may want to ask to join the
> >    mailto:git-security@googlegroups.com[security
> >    mailing list] in order to run tests against the fixes proposed there=
, too.
> > """
>
> Looking good, I guess.

It seems like there's not much more in contention from the current
responses to this thread and v2. I've got a reroll ready with mostly
wording/formatting changes based on your reply.

I asked Johannes if he wanted to take a look on Discord[1], it seemed
like he wasn't interested in doing a full review and doesn't want his
name on the maintainer list:

me: @dscho did you see
https://lore.kernel.org/git/20240711232413.693444-1-emilyshaffer@google.com=
/
? do you want to be written down as windows maintainer? or does this
policy differ enough from the way GfW works that it doesn't make sense
for you?
[...]
dscho: That document makes sense for Git, including on the NonStop platform=
.
dscho: For Git for Windows, the processes are substantially different,
for example: not using a Git mailing list but instead GitHub
discussions, issues and pull requests. Also, there is no seen, next,
master nor maint. There's main.
me: yeah, I guess I'm really asking - does this do enough for what you
need to make your GfW fork work
dscho: So: Thank you for notifying me and asking; I think it'll be
fine without my name in it.

What's next to move this patch forward? Should I be asking around for
more people to review it? Or do you think it's close enough to ready
that I should send v3 without waiting longer so you can take it? I
took a look at DecisionMaking.txt but don't see that there's a clear
answer; of the people participating in this thread my impression is
that we have consensus, but there's also not that many people
participating.

 - Emily

1: https://discord.com/channels/1042895022950994071/1156706741875130499/126=
2827182162575471
(requires Discord login and Git server membership :/)
