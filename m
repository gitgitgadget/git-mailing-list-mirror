Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5A3F54C4
	for <git@vger.kernel.org>; Thu,  7 May 2026 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163298; cv=pass; b=jkZd0sy2/q1GdDzCdzKjNqtZu83TPJHOAk9STxK89YkheceQtvmJahZFD8JOh5wAxx8yG/bKFqiZIsOpj68KV84ymWyE01GfcYgmeEKY2qs/UfGGy3uKuWHOzbQxVgu6fSIbLxAlfuYUfT+jh7g/nLhUqMYo4uof8omDv7LB6dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163298; c=relaxed/simple;
	bh=kjDWhdQk7kGNUai4VK++6T883IKzsnhU4OHA9/l/84g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mxp/4xMJGLzMM/S2OfOghHKQwDyrpF/MmPmHfRgx3aVJLQKW/A3rcmKLALw5KIqLtpVTvNREMV4oWk6u2fR9obyldcU433lu7zKti7BjvnNlQtPQ+bHzvf3O0RqvMNBr6gUA9JUQn5oGyjuSAWsWQsdoqdBmQ1hNchy1HKvmBns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjqrwEUK; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjqrwEUK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2addb31945aso6911935ad.1
        for <git@vger.kernel.org>; Thu, 07 May 2026 07:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778163295; cv=none;
        d=google.com; s=arc-20240605;
        b=RwQpHd22jBP2hr71G3NL09iR85wws05A9YuRj0Ym2lzqvEy046jpGv1PQMk7Jtwsk4
         ENAzwV0eikGj7EZqA/LAtY6fXv+R5DmuqgOfL/fC5YyckxGwwo+Xm9AZCyxTD9MijmkI
         Y+I5uM4AJ1A6ep3/Ievu9fJ4nfdbYMFbwfxkBzZN9M5U6ULz9fomoRroWrV04Yf4ddTh
         vaiW6IveM4eh3BLfhIJTQvfWSShRyRcXpgXoecEj1sNfupIfipLddVU2BuBcPsl01H14
         tw5jg+d0m8noSPEfx6Apjm+pEpR/D18W3YtFxx7gmGNtchRmA4V3RBUn8yC7WJmy3YpC
         GdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kjDWhdQk7kGNUai4VK++6T883IKzsnhU4OHA9/l/84g=;
        fh=IlIpqNvVVz8u9oqg5F6OIpWHHVUF9MQWeIfpHF0llE8=;
        b=P41EemXhRq5wjI8HbwhcQO8vq7CNvwVg6HX1ru7bJ8JE143uGBYVfrIz4+RuJpEmLo
         kXGvfeQsJ3gWtc+Qj27htICk/eqa511uI5KxF+CXFY+zB6znzdWDgn1MPK7huEKM541o
         EdYNnnwupVyojfbNxiOkVQ8YZFwxFe2LSWIUo2nGuv2jGirc2lql8qMhNAEF2pwK0Gzq
         VxWYgCxSgXuhsqZiPMSQWHb6XcVnPBAPVJOuosGrnVtv4HqeuQxLc+AruFcedRU9b/sk
         8tkrz/o1wFJXKs9vqH9pZPdBhcDi8nF6c/pd0jN83T4pKqU+iylSaBQsyyoCnzx4x4N7
         sBmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778163295; x=1778768095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjDWhdQk7kGNUai4VK++6T883IKzsnhU4OHA9/l/84g=;
        b=EjqrwEUK0qbeL7uKrbRQnYKNziIeElGy8yXXK96bQreu6ZIxQX1s1g1i4uPiSGxfGq
         h5v4iYJrdhYr32uzi0IScbCdq8v57dKJustNdawPlgGjuwaMGd7TMsyt6C3KYtxwMXEK
         Y/dAOl5eZ5sSB/bRVMjXzAanBfPTPp5lJQcbYhkAm+D/CL7VEADdlRfzQJvs8VcE0XPJ
         gbFCtEilUc/yhoZ7EP9p8qTDnTcONjjGcahIiII/r3aJ/0KPNRhLhjD3W7qMvMWynd7Y
         RpXMuC21lLXVDB/Ahv1TJzQ9TpZF2J9BqKbojFO5bMJNthdDx3vrHO6JT12qRZytqkyK
         MDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163295; x=1778768095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjDWhdQk7kGNUai4VK++6T883IKzsnhU4OHA9/l/84g=;
        b=idk5+tgy7V4jRI2IHtjUriJy7BWOiUGtyuAj/IHitfCqWCXC3DX8D3/j9jbV7F/s5d
         pJcTXn8AW6dAI8hnWdnQ+WhmUTYAUioi96hfFSbZqCjKnG7w/DKv/YaflWUbkhi+iRa/
         mvEFSJE8F1VvIWA4/MYuN3o/CtNdpzYkQ26xV/f6p6TpyyqOUsF+OaJ/yTlRrLB/0nOz
         J4gVFsUc19ZH7FNnTt6ZY/0ZSQeHO8hQr53wzgt/xGF3uqdEUG6fDvJomLIA1WaBhFoA
         aOEUeb7eSIwv23eSjKO6yC3fcz4VtXrqqWDd3ocLNKbWwJ0XEosA8oTI9rFW+t4jocqI
         PUtw==
X-Gm-Message-State: AOJu0YzcT53hbA13F61TS9ua15ppIlUfohs6e+R5FEN2Z5Mz+3XIiIC5
	L8ZZG38t1d3yk2MAdjMFkA3+R22TKy+E6eawM5t31fld+omgxl1uqz6q1THRgkkyT2tCANB8fuv
	dkhdEGWFnrGe6Ugy0ZiA9qjCdmmBiQCw=
X-Gm-Gg: AeBDievtaHh5EmbXLWJfIR8gGDCIZzDSk5i6kKIICx7g9HJBBZdsWVzAXlyRGQtTjEe
	LDw/hRG7nE7GxS/YDpqFAXuud7lwuiiZVEM5zmQjGpef3pRVdUhE+ReO+1dlHIZKccF+eMF1MuB
	PlBI1Neplev9NarCJFxLstEn4pb4Vk0NO3i8fC1ZrHn4chdwrdDnCGukhh7XIaMuSBo9fxfPuPy
	UsV8eOrK1taLsQN/HGXPyBxMS6RR9jardEXO+8MWF8uV6hFZwwQCqKrFXFot1x0TXSGcbx0pfbY
	+DeptKvOiEXaCuPD9X01+vEGmGeiOdQxS/iEkd204zomioGwk6/z3mBEjmg4p0kSi4LvP0R4Fpg
	7FZSmXjJlhpj8wi6+s/oLzQcuoQ==
X-Received: by 2002:a17:903:1ae5:b0:2b4:59d4:9a with SMTP id
 d9443c01a7336-2ba78b4a778mr92411895ad.2.1778163295400; Thu, 07 May 2026
 07:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
In-Reply-To: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 7 May 2026 10:14:44 -0400
X-Gm-Features: AVHnY4LFIGbhQwGrrn6e411EqIZHwsR2lC-KI0El2_N8KqeouBwHYcmRdDQrC8Q
Message-ID: <CALnO6CDJgUEiEgG=4r_F4jeyrHSsSpwD0X8rZzh+EScL+vJn7g@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] replay: support replaying 2-parent merges
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dscho,

On Wed, May 6, 2026 at 6:44=E2=80=AFPM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> git history, the new history-rewriting builtin in v2.54, dies on any merg=
e
> in the rewrite path with replaying merge commits is not supported yet!. T=
hat
> makes it not very useful for the workflows I actually have, where almost
> every interesting branch contains at least one merge of a feature topic. =
The
> natural fallback, git rebase --rebase-merges, is interactive and stops to
> ask for re-resolution even when no re-resolution is needed.
>
> This series lifts that limitation for the common 2-parent case. The
> algorithm itself is not new: Elijah Newren wrote it down in his replay
> design notes
> [https://github.com/newren/git/blob/replay/replay-design-notes.txt] and
> prototyped it in a 2022 work-in-progress sketch
> [https://github.com/newren/git/commit/4c45e8955ef9bf7d01fd15d9106b3bdb8ea=
91b45].
> What is new is wiring it into the replay_revisions() API that backs both =
git
> replay and git history, plus three specific tweaks that make the trickier
> cases work where the WIP sketch bailed out: identical conflict-marker lab=
els
> for the inner remerges of the original and the rewritten parents (so thei=
r
> conflict-markered trees compare equal in the regions the user did not
> touch), tolerating result.clean =3D=3D 0 from those inner merges (their
> well-defined conflict-markered trees are valid inputs to the outer 3-way
> merge), and self-fallback for both merge parents combined with mapping th=
e
> rev-range boundary commits to the onto commit.
>
> Octopus merges and revert-of-merge are surfaced as explicit errors at the
> dispatch point. The split sub-command of git history continues to refuse
> when its target is a merge: split semantics simply do not apply there. Th=
e
> xdiff special mode for matching conflict-marker hunks across inner remerg=
es,
> the XDL_MERGE_FAVOR_BASE variant, and the modify/delete and binary-file
> specials that the design notes flag as future work all remain future work=
.
>
> While I was at it, git history reword had a pre-existing silent-success b=
ug:
> a positive return from replay_revisions() (which means "conflict, no upda=
tes
> queued") was treated as success. Obviously this should never occur, as a
> reword simply does not change any of the file contents, but bugs do happe=
n.
> The merge-replay work is complex enough to make that class of bugs more
> likely, therefore I introduce error messages for those instances.

Fixing this bug sounded interesting; I had a hard time spotting it
while skimming the first 2 patches.

Did I just miss it? Is it worth splitting that fix out to a separate patch?

Best,
--=20
D. Ben Knoble
