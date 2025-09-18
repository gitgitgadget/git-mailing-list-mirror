Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F2242D97
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215020; cv=none; b=D1DEcYSgEwUZDKrJhMEd7reiNV89pbDGokKt+xLkRsgX0hTlh71415c0ZCY4cSNuMK4jBjMYH3J0mrr1SYkWUFrSiEhWoW16WNBHECEt+0xaIiCemlRMdJ4ZgfSkPur7zbKuci5kuKuyhZltarch8Ry4FmNlxofwHzTTWNufrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215020; c=relaxed/simple;
	bh=gyYI7AU2xiptoF+89qDsWbpj6KHHqeRLiubtJPWF5Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+UducZTRCeOrM2Ypwu8uRAMa41c4eD6EVBVxDBXgjmjrX8NpyweRg8DCgwnOPnIe0j36gDUhbrlufbqZ4iDhZZ8XW+t6uwR9QVoXH5qnw+7EnUPTUmaiYgVim2mo5U/kZ9JxCS5lTeFdsGEdSYaAFEBWkNmG1rrXz1IizIxaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll/JJcom; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll/JJcom"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3601f884888so9891551fa.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215016; x=1758819816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu2NmWCVMZsnCfdtYxUV6iBG3lzfbxOobxHGMYT6ON0=;
        b=Ll/JJcom0OeXLTWS0c8aHDVRw31ii9rwcYCq/P4SR9fFrXLHNt+n55O9GqXXRlZ4pA
         a2BZeG2fsVL3ukm7cOeH4dUdIHBUv1gyODL4ygsh2NoSsauY0iB+YYFWH8V0Zz8fh05H
         tZKyOArWWo1jBCdrfJH/vPl4seCWH8gK+5Evq8r3wB4jrTwf9MUEbn8LmOqZWWjuijgh
         7qS4yd0d0dpidHaPiLenzVPUWAnZRQHTUyD8SfZ1BPZXsRy4IPHQtiLGc8k+OhUvxYJZ
         toN8DVE9VMUZJ7LXnsFPgvDJn9zNATG6RVCW6sfqEt92obakRUtgfvSubvf9iPZB5Xup
         XGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215016; x=1758819816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu2NmWCVMZsnCfdtYxUV6iBG3lzfbxOobxHGMYT6ON0=;
        b=PvcjidgCroeSyXKh5pFURp7XjASyIyE2fSKzgm/3++riUOxandv5zWf6sVZUZy7mFb
         fl8O6uOMa25wzuogjMBds78y/DlyV1KwWnI4/cbTWVbCCmx/HIHNiNyrH1NeQ+pPYeQg
         RdWtioLSxasYZg7suwZ4W5+5+m13UMO/ItCVasm5WzuKq5PwQ1c+QMMeHhFpQS539Tes
         tm9WWDEAH2vCYucdrc9oK3RnvgLzFuOKjeS+Hjf2fpSLmYGPq/IiCAQ9OVg59qJWWJyF
         0sEEMUvrpsu5aTsoFbiinVcYGdB9c+6PymejJI6WJMmfgFgV5UUPww0D80ogeAiuR2un
         rS0A==
X-Gm-Message-State: AOJu0YyJhwXk0k5ufs/U/mpyIa5dGZecgayOk1HNnvV/IuDEg8AqVwHg
	0nuCi+oISzvyY29k8t8BDSsb5Y2goZxvq6tOIXNjBEfaysSSxz972vojWBCoaUHgXe3jUfZj2cq
	0is4r5J8iPld13zzVZ/KJ6mCkfvYQoqVVZZgh
X-Gm-Gg: ASbGncvXZ3fxBEfgjD3VQTTY7bDFwJKwi2LJZJ4ZUU7IkUmHoZD3Uf34IsMsUIWjdRG
	iM5RQqVtuKhgKLjmpydWBaZu2NqDdeKyAfSK4Ki+AK/fpIrd2w1MJr3LPASxR0ugm3HSxrM1tpy
	9HUg5ObIe/XUWEjskMC+JWSLGhlaZIwpMbhraaZKp0wrYfbxoDqw99IJo0bzAqBHeHffRmYXF7V
	brGdu1wagYCa3Oq13wjYfaeDj744EAVtGI=
X-Google-Smtp-Source: AGHT+IFAQJABcs4QXvYX+Jbix3GY6OYX2X+csv0FH7D9wNkbZ13hHjH2iEIkPI9ItReMjXwGS3LFu7uIRz+ET+/ch6U=
X-Received: by 2002:a05:651c:1a0a:b0:338:53d:3518 with SMTP id
 38308e7fff4ca-3641a7f5205mr851961fa.39.1758215015908; Thu, 18 Sep 2025
 10:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
 <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net>
In-Reply-To: <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net>
From: Antonio Mennillo <antoniomennillo87@gmail.com>
Date: Thu, 18 Sep 2025 19:02:59 +0200
X-Gm-Features: AS18NWDwaBsL_wDUOs150FfjY0JfhWqDGXokHu71Gxgg_RooaKs5-Nmqrlz_e0I
Message-ID: <CACEPZDU2Bu2c9RFBwD499-UUNyQGuRRXNbMx0aBrqwGoc=4EhQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC=5D_git=2Drebase=2Dclean=3A_mitigating_a_=E2=80=9Csemantic?=
	=?UTF-8?Q?_conflict_cascade=E2=80=9D_during_rebase?=
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Thank you for the thoughtful response, and please excuse me if I am a
bit clumsy =E2=80=94
this is my first interaction with the Git community.

> Usually we would recommend that each commit be atomic...

I perfectly understand this best practice. In my context, working with
many junior developers,
it is not always possible to enforce atomic commits. In some
=E2=80=9Cemergency=E2=80=9D situations we
squashed just to make progress, even if that meant losing granularity.

Your explanation really helped me see things more clearly, and I appreciate=
d
the constructive (non-toxic) way you put it.

> Are you familiar with `git rerere`?...

Yes, rerere helps with repeated textual conflicts, but the scenario I
worry about
is semantic: if commit M changes an interface and commit N implements it, t=
hen
changing M during rebase can make N semantically invalid. rerere
cannot solve that
=E2=80=94 it remembers markers, but cannot understand that =E2=80=9Cthis
implementation no longer
matches the interface.=E2=80=9D

> I think most people on this list will consider losing the history unaccep=
table...

That feedback inspired me to improve the tool. Version 2.0.0
(literally born today,
thanks to your comment) now works differently:

1. Temporarily squash the feature branch (so the rebase is effectively `1/1=
`)
2. Resolve conflicts once, with the full final context
3. Automatically re-expand the squash by replaying saved diffs, restoring
   the original commits (with new hashes, as expected in any rebase)

In integration tests this preserves detailed history while avoiding cascadi=
ng
conflicts. All 23 tests currently pass (including empty commits, binary fil=
es,
special characters, conflict abort/continue). Of course, real-world
usage is still pending.

This workflow essentially resolves conflicts with full context, then
reconstructs
granular history =E2=80=94 a kind of =E2=80=9Cbest of both worlds.=E2=80=9D

I would be very interested in whether the community sees this worth explori=
ng
as an **experimental rebase strategy** (something like `git rebase
--squash-restore`),
or if it overlaps with existing mechanisms I am not aware of.

Code: https://github.com/anthem87/clean-rebase/tree/v2.0.0

Best regards,
Antonio
Antonio

Il giorno mer 17 set 2025 alle ore 00:14 brian m. carlson
<sandals@crustytoothpaste.net> ha scritto:
>
> On 2025-09-16 at 21:39:46, Antonio Mennillo wrote:
> > Hi Git community,
>
> Hi,
>
> > Problem (observation, possibly a known limitation rather than a bug):
> > When rebasing feature branches whose commits are semantically interdepe=
ndent,
> > Git replays commits one by one. In practice this can trigger a
> > cascading conflict, similar to a loop. Example:
> >
> >  - Commit 1: add interface IUserService
> >  - Commit 6: add UserServiceImpl (depends on 1)
> >  - Commit 11: change IUserService signature
> >  - Commits 12=E2=80=9315: update implementation/tests to match
>
> Usually we would recommend that each commit be atomic.  That is, each
> commit should compile and pass all of the tests, so commits 12=E2=80=9315=
 would
> be part of commit 11.
>
> > During rebase, conflicts may appear at 1 and again at 6/11, forcing the=
 user to
> > remember prior resolutions and reconstruct intent across commits. If I=
=E2=80=99m
> > mischaracterizing the model, I=E2=80=99d appreciate a correction. I=E2=
=80=99m sharing this
> > humbly to verify whether this is expected behavior or if there is prior=
 art I
> > should be aware of.
>
> Are you familiar with `git rerere`?  I have just done a complicated
> rebase of this sort and it remembers resolutions for you so you don't
> have to.
>
> > Mitigation (userland workflow): I built `git-rebase-clean`, which
> > squashes the feature branch first and then rebases. This concentrates
> > conflict resolution into a single atomic step with the full final
> > context visible. The obvious trade-off is commit history granularity:
> > you lose individual commits but gain atomic conflict resolution. In my
> > experience this reduces repeated/conflicting resolutions across
> > dependent commits.
>
> I think most people on this list will consider losing the history
> unacceptable, so I don't think this is a thing we'll want to encourage.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
