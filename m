Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85C1DFE8
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742445038; cv=none; b=emA638LYNG0404gXl8utnnvTSvyC5m9xSF2o8G3kmpUWLmF1arwo/QoMLyiUEtp1ysW4m+xjYfGCxjmakvVMK9uV0XWmix3UNKkUTwzSyduDNMnIaGw/qdsBJj6DTmr9F15pBcXcb/aoIIuDPyTMplBAU2xOcSAKkP4uJjuv9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742445038; c=relaxed/simple;
	bh=Ue05K/I/PGfEDicBJjTM06PQeua08xVchR2PvxIjPeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHXsoTkfyCvktXJudkMNsGcDOI5Is65IluHeLbfd3p1hvxStF1AgOVpoj6q6bznBCCbcYetwIaERGzWrVdY2xeFEcSvQ8UbQRz28AyCWE5Q6LAcCGdTKIAg5hnmyMRfAB2YBAkAmEaiQIcbOwKgw7dOCN3ePuMxPfYEE2fUwb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSfMP0sv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSfMP0sv"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfc8772469so1793665ab.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 21:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742445035; x=1743049835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNMf5zjBOhBTUslDyYlIxy4+jmczWkEiTB7jyjeDGyo=;
        b=MSfMP0svL/+a2DTBtW32IoQfh0eCVY7Ognueo+dHPZxQyHpgPecdyD0RkKyT4WDZ2K
         naGT6hxbiTH6zFcqpv7skQ7xT+ze5qIMOqVaXgKWdG8VmQuYVEJffC8agQOh7blVpDEc
         covRMe5V1lx5UETwy/jxNdLi5cNrOyBjbfvIFKm8lS4t8RhtlvkT2ayZ4ioRLcenoNKp
         DUwQYcessVVqh5CR5Mu9s+v18eiTZ5EH2ugd2hdsTtr/hBbcq/fV/9nr0nHgOb6UQ6Kw
         onFmoiSlS7eLzNWe6ID43Z2fzY3vi/Dt2BqtEiJoQ9DuimGuXKfF5WfaGjOj6sbqmYRC
         61Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742445035; x=1743049835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNMf5zjBOhBTUslDyYlIxy4+jmczWkEiTB7jyjeDGyo=;
        b=Up2zEfl7NSflt2bUEOklRYCGGBxpG2+sUXQgJIfit/mxKZg1qe4j9PVG29xeVCW3vF
         vnK4pOdzca2RLWwlJgad8RdvaiFKjjkBjPY7pxqWbcGtyc9CO+NLunoJYuwxre9raHAY
         1kWVcRz5O54bXOO4884kZwlLW700qKMaM62aNSzP6+DVrIO79HOBHIxGgd2w8q9yXcht
         ueew1dlLOHSXBZByil1vQSB5pIy0PHxwcelY/0pi8bD32EjmnVy5ulH8UgIne36I+TLQ
         94X/YUiXqn5YryrfTzbEZ7KLKH9uNzVRMXzZOtu/DBMcQLoqOI1mBhs8zXEHqqOgSs6g
         cdPQ==
X-Gm-Message-State: AOJu0YxekBa/3XvantJJpwKN+Xw4X54LvCMqZKmqwHIrNGuu2JjbgwpL
	nZuB79ZAgv80YClVE225bECxaxtRiZ/57SKYogUkLmSGrmGh4abEDhxSqivKMqU4/w5CxUdHpRx
	hL9AamUiaSZ9xJS6owhcOzdMHdX8=
X-Gm-Gg: ASbGncvezTJRB7WcNdCntcu+VBCOsvIyOYE7uxSDkngoJgYsNkhC6hLFY6Xi3l5bQre
	zBY1R474YyZPo4D1eEijSUg6BPVSE3dEE6e8CtqK0FTG1Mav9PWG8pesRLzlUrS4ggwvfunIo2B
	lxLCnuIaJCVUhNTVvZ5bBIVV89FUHi
X-Google-Smtp-Source: AGHT+IGUXcP1GQxb3GMJ73izmar71gzXDb4imC428VeQ31+QtONRMwui9xxqChG143ldBdGAZ3yPPUrOhjSzeGcDOZE=
X-Received: by 2002:a05:6e02:1aac:b0:3d5:8908:c388 with SMTP id
 e9e14a558f8ab-3d58ea973c8mr17842915ab.0.1742445035332; Wed, 19 Mar 2025
 21:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742252411.git.me@ttaylorr.com> <cover.1742424671.git.me@ttaylorr.com>
In-Reply-To: <cover.1742424671.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 21:30:24 -0700
X-Gm-Features: AQ5f1JoVmZKldCgTHBiJ1-qiYXNnZn71WfXtTlh5J3ZnOikgPNIfvHZFaPF4lHM
Message-ID: <CABPp-BF-i5Npbnp+tHoW1QbvrYzCngwny9dMTOnf+0-y5yxc2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] repack: introduce '--combine-cruft-below-size'
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:52=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Here is a small reroll of my series to introduce a new 'repack' flag
> called '--combine-cruft-below-size'. There aren't any functional changes
> in this round, and the changes that do exist are limited to
> documentation and commit message tweaks in the final patch.
>
> A range-diff is included below, as well as the original cover letter:
>
> (This is based on tb/multi-cruft-pack-refresh-fix from Junio's tree,
> which is at 08f612ba70 (builtin/pack-objects.c: freshen objects from
> existing cruft packs, 2025-03-13) at the time of writing).
>
> This series replaces something close to the existing behavior of
> repack's '--max-cruft-size' flag with '--combine-cruft-below-size'.
>
> The new flag is much clearer in its intent and function, and avoids the
> lack of clarity between the two that was discussed in
>
>   <cover.1741648467.git.me@ttaylorr.com>
>
> The new behavior is as follows:
>
>   - '--max-cruft-size' is a cruft pack-specific override for repack's
>     '--max-pack-size' command-line flag.
>
>   - '--combine-cruft-below-size' instructs repack to only combine cruft
>     packs which are smaller than the given threshold. This will likely
>     result in packs which are larger than the threshold. But that is OK:
>     the point is to limit the size of the individual packs on input, not
>     the size of the outgoing pack.
>
> This series does break the existing behavior of '--max-cruft-size'. But
> I think breaking backwards compatibility here is OK, since the existing
> behavior was so broken to begin with. I'm happy to consider other
> alternatives if others feel that this isn't OK.
>
> The series has an interesting structure that I feel may be worth calling
> out. The first three patches are trivial test cleanups. The fourth patch
> modifies the existing behavior of '--max-cruft-size', but does so while
> keeping some of the old infrastructure around.
>
> That may seem like an unnecessarily complicated approach, but it greatly
> simplifies introducing the new behavior in the following (and final)
> commit. I think that this results in a series that is a little easier to
> review (since we don't see a ton of code being removed in one commit and
> then re-added in another immediately following it). But if others feel
> like this was a mistake, please let me know ;-).
>
> Thanks in advance for your review!
>
> Taylor Blau (5):
>   t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
>   t/t7704-repack-cruft.sh: clarify wording in --max-cruft-size tests
>   t/t7704-repack-cruft.sh: consolidate `write_blob()`
>   repack: avoid combining cruft packs with `--max-cruft-size`
>   repack: begin combining cruft packs with `--combine-cruft-below-size`
>
>  Documentation/git-repack.adoc |  21 ++-
>  builtin/repack.c              |  62 +++----
>  t/t5329-pack-objects-cruft.sh | 302 ++++++----------------------------
>  t/t7704-repack-cruft.sh       | 293 ++++++++++++++++++++++++++++++---
>  4 files changed, 355 insertions(+), 323 deletions(-)
>
> Range-diff against v1:
> 1:  0aa8aa65c1 =3D 1:  0aa8aa65c1 t/t5329-pack-objects-cruft.sh: evict 'r=
epack'-related tests
> 2:  5e8bd3e66e =3D 2:  5e8bd3e66e t/t7704-repack-cruft.sh: clarify wordin=
g in --max-cruft-size tests
> 3:  b075ad8601 =3D 3:  b075ad8601 t/t7704-repack-cruft.sh: consolidate `w=
rite_blob()`
> 4:  7941997e33 =3D 4:  7941997e33 repack: avoid combining cruft packs wit=
h `--max-cruft-size`
> 5:  7f120c35e9 ! 5:  dee780a2aa repack: begin combining cruft packs with =
`--combine-cruft-below-size`
>     @@ Commit message
>          Introduce a new flag, '--combine-cruft-below-size' which is a
>          replacement for the old behavior of '--max-cruft-size'. This new=
 flag
>          does explicitly what it says: it combines together cruft packs w=
hich are
>     -    smaller than a given threshold, and prohibits repacking ones whi=
ch are
>     +    smaller than a given threshold, and leaves alone ones which are
>          larger.
>
>          This accomplishes the original intent of '--max-cruft-size', whi=
ch was
>     @@ Commit message
>          But that's OK: the point isn't to restrict the size of the cruft=
 packs
>          we generate, it's to avoid working with ones that have already g=
rown too
>          large. If repositories still want to limit the size of the gener=
ated
>     -    cruft pack(s), they may use '--max-cruft-size' instead.
>     +    cruft pack(s), they may use '--max-cruft-size'.
>
>          There's some minor test fallout as a result of the slight differ=
ences in
>          behavior between the old meaning of '--max-cruft-size' and the b=
ehavior
>     @@ Documentation/git-repack.adoc: to the new separate pack will be wr=
itten.
>
>      +--combine-cruft-below-size=3D<n>::
>      +  When generating cruft packs without pruning, only repack
>     -+  existing cruft packs whose size is strictly less than `<n>`.
>     -+  Cruft packs whose size is greater than or equal to `<n>` are
>     -+  left as-is and not repacked. Useful when you want to avoid
>     -+  repacking large cruft pack(s) in repositories that have many
>     -+  and/or large unreachable objects.
>     ++  existing cruft packs whose size is strictly less than `<n>`,
>     ++  where `<n>` represents a number of bytes, which can optionally
>     ++  be suffixed with "k", "m", or "g". Cruft packs whose size is
>     ++  greater than or equal to `<n>` are left as-is and not repacked.
>     ++  Useful when you want to avoid repacking large cruft pack(s) in
>     ++  repositories that have many and/or large unreachable objects.
>      +
>       --expire-to=3D<dir>::
>         Write a cruft pack containing pruned objects (if any) to the
>
> base-commit: 08f612ba7000bf181ef6d8baed9ece322e567efd
> --
> 2.49.0.4.ge59cf92f8d

v2 + your comments address all my feedback from v1, so this round
looks good to me.
