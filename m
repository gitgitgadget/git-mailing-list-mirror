Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8C1F2B87
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674723; cv=none; b=Z7ZzpNxlYIrxqlVGOi67TSphntmAbuF/hJAoS1cS0lJAxVsJss3mkjdpMG5oBxTMlJ0bK4dZxKbWcCEuEmHYCVGXrMSKmgKb3QgujyfMRowl75APoUxcDoqLnhSVerpbxNaUKGxp5ltZLJC5MSJM6mkIwor5HcRi9xnuZMy0Q6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674723; c=relaxed/simple;
	bh=eeu92KeKl1NpnBAK1y3Sa98EQ9qP6nFOFohAzq5/Rng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdWKyg7a9cFNqWRiEnuC5Y/Y3/cuzeDK4T6BAoDLOVFnIQjh7C0KFti/8KvyvvOO0QVknlmGpPA4CqpXLpvcrE6BJcIXs98A02o+ZvT+jYn/MU2QvzNfnL/yvcTKMMJbKHG2V0SuC4+QY+CBfnPPB0Nf+ajUJLtVll1zcxGj9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj2qy1cX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj2qy1cX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c3e7b390so635465b3a.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743674721; x=1744279521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pnblQUTQFKrSVWsnF2vImkD8nZFSV/uLI8Qg+SHx9I=;
        b=Kj2qy1cXFZX/TMLg6JDqxfCakhYxS0V1cj0f4p5yvURfCbXrdi0PnRxlbMOmE6uBrf
         8dIqhWtuI+vvKEISgMMK91ro07aJO4vG8ia1fJuKjLEgLHRV+G3ftajJhs0baGx1EO/B
         4TVruf2X/lxI2JfcQdqxt4dIT9S+WGb2nMb7jU+YY0THFDt8L4Qdu3rTXdpsnlefzfrc
         MR9sPhVuuLczjBbyBR1JuwfLIx2Rhow/qs+n+gT1kdSzKmFKhxJFrYTAYjvvxUulPUw6
         0vR08Anyc9Pg0GnsQ9UxNSYyPppHm83s6kupQNaKDiUG0Rw4OKun1NVkzm6opavv77hD
         pfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743674721; x=1744279521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pnblQUTQFKrSVWsnF2vImkD8nZFSV/uLI8Qg+SHx9I=;
        b=It1+G+PH5lIQzwE2VWRUU0OQ7JQBeBqZU0rkVy7fNDQKcuAWbiXmrXsScCCfWDN6CQ
         6zftDIYwiGMy4/ENBWjXPF+oJ32J4t1XBJviTctKW9B2lqo5rrX60hXqVHGB0GQpme1M
         5/2zazuU419eQkGmDiK6egusgTs0k7LUN3ydT9Km8u4Uf8KrpWNxMxpWVzfDkN8EdFA9
         0nkR5W4gLoHaFYRYLyPdMaAHAeFJSRYfk/4M56jgPJ+L5tQL+/qldajKaTxmt/tNrImE
         iN9/FR3WkttqpY/XaaAggiJVqwI5wR25EnKoHudF3z4JRtlVBp6xuqdrIVyak023XsD0
         08NQ==
X-Gm-Message-State: AOJu0YyX158g4HVCyvipMxt+ZCGKFjL2qzxyYMs1HfobnNtTEw/bydhU
	KRcb4fBSI8cd4hUTkhMqjrGo1OWgVHVa8yJLmV70aM2W9PkUpgXWrmX5sljashLxUYCa0uI7w0I
	kElvoVYiZlbEyldjNEqnWGOheLgl7S6dN
X-Gm-Gg: ASbGncvx0JGZ5HXHfZyrmHLUnSacTxwERojefxgh2NkOKgezjwUVQZFn7Ad3IshfCPE
	D2jN5koA39WlcXeWvzaOLZyt/EVLeRGQhUg/3gyP3esrKa1Rvk+SZcW81MG4KB1oC7sSQK5Mtfc
	gMsExn2AWPw2/zlPtYIZ+ubVUc8+o=
X-Google-Smtp-Source: AGHT+IEmjqrBGvc6f7NtNGhF3ZYtReouigyUwcniF8usSJeRd09Vli41CIBgeDloZrdarPoXvOG3lhQGv0O8ZYUC+RI=
X-Received: by 2002:a17:90b:3a44:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-30532163db8mr34559774a91.33.1743674721024; Thu, 03 Apr 2025
 03:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
 <Z-zzbOrZde8B1kA6@pks.im>
In-Reply-To: <Z-zzbOrZde8B1kA6@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Thu, 3 Apr 2025 15:35:09 +0530
X-Gm-Features: AQ5f1JoPyCuSNazU7ILIx8BfdRQFn6CSJbtqRP2pMoUa_IJnVsM9pwP5uvSYGlU
Message-ID: <CAPhwyn2GugzXg5LgcdMGjrvP9kAvCFj31RXrUpp7ZJdoGfiyKA@mail.gmail.com>
Subject: Re: [GSoC][Proposal RFC] Consolidate ref-related functionality into git-refs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shejialuo@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 at 13:51, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Apr 01, 2025 at 07:07:21AM +0530, Meet Soni wrote:
[snip]
> > The Plan:
> > ---------
> > To tackle this project, the consolidation of each command will be divid=
ed into
> > the following steps:
> >
> >     1. Create subcommands:
> >       Develop the actual subcommand under  the refs
> > command(builtin/refs file) by
> >       leveraging core functions from the refs module. The implementatio=
n will
> >       mimic the logic of the legacy commands to maintain consistency
> > with existing
> >       behavior.
>
> It should mimic existing commands where it makes sense indeed, but we
> should also consider whether there is opportunity for improvement. That
> is of course a harder question to answer, but I'm sure that we will find
> some subcommands where it would make sense to break with existing
> behaviour.
>
Makes sense. I'll reflect this in the upcoming version.

> >     2. Tests:
> >       Develop comprehensive tests to verify that the new subcommands fu=
nction as
> >       expected. This will involve creating a range of tests, including =
shell
> >       scripts and/or unit tests located in the t/ directory. For the ex=
isting
> >       tests covering the legacy commands targeted for consolidation, th=
e plan is
> >       to retain them initially=E2=80=94even if this results in some dup=
lication=E2=80=94with the
> >       intention of deprecating them gradually over time.
> >     3. Update old usage:
> >       Modify all call sites of the legacy commands to invoke the newly =
created
> >       subcommands, ensuring a smooth transition and seamless integratio=
n with
> >       the consolidated command.
>
> This would be nice indeed, but it's not necessary as part of the GSoC
> project from my point of view. The old commands won't go away anytime
> soon as they are extensively used in scripts outside of our control.
>
I wonder if this is a better candidate for "Post GSoC" section maybe?

> >     4. Documentation:
> >       Develop comprehensive documentation for the newly implemented
> > subcommands to
> >       ensure clear guidance for users and maintainers.
> >
> >
> > Command mapping and naming:
> > ---------------------------
> >
> > I have taken reference for potential names for these subcommands from P=
atrick=E2=80=99s
> > suggestion (https://gitlab.com/gitlab-org/git/-/issues/330):
> >
> >   # Replaces git-show-ref(1) and git-for-each-ref(1).
> >   $ git refs list
> >
> >   # Replaces `git show-ref --exists`.
> >   $ git refs exist
> >
> >   # Replaces `git show-ref --verify <ref>`.
> >   $ git refs show
> >
> >   # Replaces git-symbolic-ref(1) to show a ref.
> >   $ git refs resolve
> >
> >   # Replaces git-pack-ref(1).
> >   $ git refs pack
>
> As I suggested elsewhere already, I think `git refs optimize` would be a
> better name. The verb "packing" mostly stems from the "files" backend,
> where loose files are indeed moved into a "packed-refs" file. But with
> the "reftable" backend that name makes less sense.
>
> >   # Replaces git-update-ref(1).
> >   $ git refs write
> >
> >   # Replaces git-check-ref-format(1).
> >   $ git refs check-format
>
> I think this one could be improved, as well, as it doesn't quite
> indicate what format you're checking. "check-name" might be a better
> fit.
>
Yeah, makes sense; I'll reflect this in the upcoming version.

> [snip]
> > Options/Config sharing:
> > -----------------------
> > For sharing configuration options, I propose a structure-based approach=
 that
> > centralizes common options while grouping subcommand-specific settings =
into
> > dedicated substructures. This design embeds common options directly in =
the
> > top-level configuration structure (struct refs_options), and then uses =
separate
> > structures (such as struct list_options) to encapsulate options unique =
to each
> > subcommand.
> >
> > Below is a representative code snippet illustrating this approach:
> >
> > struct refs_options {
> >         ...
> >         // ... Common Options =E2=80=A6
> >
> >         struct list_options list_opts;
> >              struct exist_options exist_opts;
> >
> >         // ... Similar fields for other subcommands ...
> >         ...
> > };
>
> The other structures probably do make sense, but I don't think it makes
> sense to have a structure that summarizes all of them. If there are
> common options that will need handling for all of the subcommands (are
> there?) then I'd rather go the other way round and introduce a
> `refs_common_options` structure that gets embedded in e.g.
> `list_options`.
>
Okay. I'll update this in the upcoming version.
In terms of common options, there are a few that come to mind--such as
--quiet, -m, and --branch.
> > struct list_options {
> >      // ... options specific to 'list' subcommand ...
> > };
> >
> >
> > struct exist_options {
> >      // ... options specific to 'exist' subcommand ...
> > };
> >
> >
> > Since we plan to maintain the legacy commands for the foreseeable futur=
e, we
> > must ensure backward compatibility while developing these new subcomman=
ds. Going
> > through this I wonder if we should make the commands as a standalone
> > entity, like
> > a library. However, it needs to be thoroughly discussed.
>
> Much of the functionality probably already is somewhat encapsulated,
> it's mostly the option handling that we'll have to unify somehow. In any
> case I expect that the exact mechanism will vary between the different
> subcommands and it's fine to decide on a case-by-case basis once you
> start to implement them.
>
> > While studying these commands, I thought why not try out one of them to=
 better
> > understand the project=E2=80=99s requirements, scope and get a firmer g=
rip on the
> > codebase. So, I developed a reference implementation of git refs list t=
hat
> > mimics the behaviour of git show-ref with [--head], [--branches|--heads=
] and
> > [--tag] flags, which can be found (https://github.com/inosmeet/git/pull=
/1).
> >
> > Although this reference implementation is still a work in progress and =
not yet
> > ready for merging into master, it demonstrates my understanding of navi=
gating
> > the Git codebase and the process of creating commands and subcommands. =
More
> > importantly, it indicates my ability to execute this project effectivel=
y.
>
> Nice :)
>
> > Timeline:
> > ---------
> > Pre-GSoC (Until May 8):
> > * Continue to work on different things like the pending WIP patch that =
I have.
> >   Be engaged/involved in the community.
> >
> > Community Bonding (May 8 - June 1):
> > * Talk with mentors and discuss potential names for the new subcommands=
 and
> >   interface design. Start the consolidation early with mentors=E2=80=99=
 permission.
> >
> > Phase I (June 2 - 29 June):
> > * Consolidate update-ref command along with subcommands/flags to refs=
=E2=80=A6 command.
> >
> > Phase II (30 June - 27 July):
> > * Consolidate for-each-ref command along with subcommands/flags to refs=
=E2=80=A6
> >   command.
> >
> > Phase III (28 July - 24 August):
> > * Consolidate show-ref and pack-refs command along with their subcomman=
ds/flags
> >   to refs=E2=80=A6 command.
>
> Part of what git-show-ref(1) does is also covered by
> git-for-each-ref(1). So it would probably make sense to implement those
> two parts in a specific phase, but single out the non-shared parts (e.g.
> the `--exists` flag) into a separate phase.
>
> Also, given that you've already started to work on git-show-ref(1) a
> bit, wouldn't it make sense to move that to phase I?
>
Both of these suggestions make sense. I'll update this :)
> > Final Week:
> > * Some final touches. Make a final report about the work accomplished a=
nd
> >   outline future work.
> >
> > I have not allocated separate timeline slots for tests and documentatio=
n, as
> > these will be integrated into the patches that introduce the new subcom=
mands.
> >
> > I think if permitted to start early, I can consolidate one more command=
 within
> > the GSoC period.
>
> We cannot keep you from doing this, but please keep in mind that if we
> end up picking a different candidate for this project we would favor
> their work so that they can successfully finish GSoC. So I would
> definitely wait until you've been selected before starting to work on
> anything.
>
I completely understand. Just to clarify, I meant that if I'm fortunate eno=
ugh
to be selected, I=E2=80=99d be eager to start contributing during the commu=
nity
bonding period--only if it's allowed--so that I can try to consolidate one =
more
command within the GSoC period.

> Thanks for your interest!
>
> Patrick

Thank you for reviewing :)
Meet
