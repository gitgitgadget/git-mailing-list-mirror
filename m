Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947641AE875
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352441; cv=none; b=qekQPgjWj6TusgSBgHmjuCW89lNvZU1Or1mfwwyZlDNhdUYeBQiL0L1b0CX1tT9qyPhmooOX4aKDsu+BUq4aqsImvWpCi0CGmZbqJql9/KBi80KgVp9kC1hmnBKxNjwIXRlhkcTmEde3lET49mHUiC2UMULIZSFAa47/bgKrO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352441; c=relaxed/simple;
	bh=JPfGr+NGer4Ot5NFrsp2KQNWVx/M4zS41qbgq9aM2BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nEqfXcKhnxN6Fk47Ho5rgebSwDAx4HjYWjUH+bIX0JlLbwMaBcNapFpuE+kAS0JbWjvBDU/TnbY4FRqpsRTB+8GFqZkDyZewz0ApDHYn9aojN+2vZ0D1QdPvFOHyihqSimcmbojEwKk5rq9+4ci9Aags034QjE3ggbeBIJoKdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr5PFU7I; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr5PFU7I"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so6894753a12.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745352437; x=1745957237; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkjpajAPyOSCsXsZo2GIvArSEQkz11cDpwktT1Ntfxo=;
        b=dr5PFU7IaZF/lvGwn3lXchs2YnC5KWnFkZBDpSH09/DImbohUKamiRj8oBvW+B2n17
         lBPuudUE+mYj+QF63eEgJoFujOyN/o09UyxZV4IMHdhy2MS9kyvPMYf7IPCVQk4Zysmb
         lUBE3msDA4zerw8NbjFcCeIf2fa6HvZfPSwnrzE5UvPnoPYK3u1w9iLH00bVApErvM/Y
         +b+8QA8Qw/GIYsHW3VmovlMos7Hwfn4DIdMfcJhqn/iQzQ4mLU+VR+qwty1oiZCm7fs0
         rD4YN7XxN/Zgo5ylPlu+VmlICf/sva4SZdNGrS7Y0+H46eERMBaML2iPhRxGks0nm5Rh
         Ne9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352437; x=1745957237;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkjpajAPyOSCsXsZo2GIvArSEQkz11cDpwktT1Ntfxo=;
        b=MB8ZhO748TFG4X7A+bf38LA2NwagSVH+tkIMoZrvmGk0HEeQwppD+zfuaRPUwnJb5e
         Mlqw3Ugdkh+NRN+QyhDTT5yCQRlw5cy9M4OiolPYZihH85LEQji1FhC+Ea9m8SMGhYks
         ibF5/JCkRxQVFavLvanWsNStH/sGX+LxMcW6JBIYEMhTC4otfZkTF1hNnntsBxPKZ2/I
         SkGZzqqIg1Vx+id+p5HPPr9LRwkjlbgzWznm2PNuIfysqLQm9aTu+G61U11ddbm1idOP
         ej/yUQDklaAb1ZMHdl86v+o7/Ub4pPgMzSHlCyd4vMcjl0zbIS96o1PRuljRpdWKTkFZ
         SNjQ==
X-Gm-Message-State: AOJu0Ywd7QtjiJDdZ3Ltj45lJ8FrnOV7h0QgcChTsc+RozEYf2Tg8EYv
	Uv37HSfclJTi7zES49ZoPFyNr3ec2dJOD7vpA2okCOdE+r1fstWtjoiZJhYYzU2TdIdO2xy39l+
	QnWeOCsg4KqqceD3fSB7VFqi+3FX7+rtdoy53BQ==
X-Gm-Gg: ASbGncsgwTYrbRDp3rxu1NIYu629tjdzb9Vv1yYPiYOWxoLOkhOwRZtCXAmboFBNTxF
	j2gytQpe58PQUo10aqOrpdP1qlHb8m2/6QhOf2Gz3tI0V9pdjE7zc0Ox52mS0gfR62rti6TskFS
	EXunQzq5KTWquuH4GlCospdV7g00alY7fwO3pSsgLtUuQuOf0Sp7rC+5mtKyC3VixRAw==
X-Google-Smtp-Source: AGHT+IHiqPbVIlrsFvkSBFHpX1b/HMRYXHJfnZdhonqmlQzfMu27f+uoV5mWL8bTop6QN9vmTx++0rqs9p8LXzdtewQ=
X-Received: by 2002:a05:6402:268c:b0:5f6:c5e3:fa9b with SMTP id
 4fb4d7f45d1cf-5f6c5e3fc38mr2393692a12.7.1745352437060; Tue, 22 Apr 2025
 13:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g> <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
 <CALnO6CBi-c9U-UskTzjNBH+k8VQybdSshYgs+A3_DRH-iz7zHA@mail.gmail.com> <CALnO6CDq5BRogPCcDozTi1NEYL6nCoEDaNkFdq2+1V6vVRy=1g@mail.gmail.com>
In-Reply-To: <CALnO6CDq5BRogPCcDozTi1NEYL6nCoEDaNkFdq2+1V6vVRy=1g@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 22 Apr 2025 16:07:05 -0400
X-Gm-Features: ATxdqUHPwTm0bP9I45O8Jo9ZiMa5wdqmeR4R7KnMkY-F4jhvVpNk9602PGaKt8g
Message-ID: <CALnO6CCMP5qS0f8oMyjav03CzT1AYSCiVCex1C7nqqxg=k7g-w@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:05=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> On Tue, Apr 22, 2025 at 3:58=E2=80=AFPM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
> >
> > On Wed, Feb 5, 2025 at 4:14=E2=80=AFPM D. Ben Knoble
> > <ben.knoble+github@gmail.com> wrote:
> > >
> > > On Wed, Feb 5, 2025 at 12:42=E2=80=AFPM Junio C Hamano <gitster@pobox=
.com> wrote:
> > > >
> > > > "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
> > > >
> > > > >> So, I dunno.
> > > > >
> > > > > Agreed that if pull.ff=3Donly is supposed to override all other o=
ptions
> > > > > (except those on the command-line), this might be wrong. And `git=
 pull
> > > > > --rebase` works in the scenario I described.
> > > >
> > > > Yeah, I view --ff-only as a safety measure for the user to say "my
> > > > workflow is to make sure I do not have anything locally cooking on
> > > > my branch when integrating with the other side, and stop me if I
> > > > somehow made a mistake".  If rebase or other options override, the
> > > > folks in the rebasing camp, unlike in the merging camp, cannot
> > > > benefit from such safety measure, which worries me.
> > >
> > > Is there, then, an existing combination that means roughly to treat
> > > `git pull` with no other options like this:
> > > - if not rebasing, forbid merging and be equivalent to --ff-only
> > > - if rebasing is requested (because of branch.name.rebase or --rebase
> > > or =E2=80=A6?), allow it
> > >
> > > In other words, something like a pull.merge=3Dff (or ff-only) meaning=
 to
> > > apply the rules I've attempted to describe, in which case I would
> > > leave pull.ff unset?
> > >
> > > I suppose pull.rebase=3Dtrue is close, but is not quite the same for =
me
> > > (I'd like to be warned when this would imply a non-fast-forward for a
> > > main branch, though the "rebasing" logs might be sufficient)=E2=80=A6
> >
> > FWIW, I found some tests that indicate, to me, that I should use
> > pull.rebase=3Dtrue (or merges) + branch.<name>.rebase=3Dfalse for the c=
ase
> > I described: https://github.com/git/git/blob/08bdfd453584e489d5a551aecb=
dcb77584e1b958/t/t5520-pull.sh#L505-L514
> >
> > So it turns out my itch was already scratched.
>
> I left out the commit reference, whose message described what I think
> I originally wanted:
>
> > my main or master branch is typically fast-forward only, while I want m=
y
> > topic branches to be rebased; preferably, all of those things happen
> > for just "git pull."

Since I apparently hit Send too fast, dropped the CC list to just add
the reference I repeatedly forgot to paste:

6b37dff17f (pull: introduce a pull.rebase option to enable --rebase, 2011-1=
1-06)
