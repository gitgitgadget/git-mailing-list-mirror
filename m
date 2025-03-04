Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF1278142
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129015; cv=none; b=uk5X8Ybe+cTmaMQxueou1/xopnLMRabNnKUMD7TxOPQwpNFaLcs4KfZX85m+Nw3fIdliu1UjP2WM5xO5uKAnvKX70tRmGtW0uOp4TZfGYXori/8Uc+Ul61zfravsymjkQyNX8HcRQ6CUAwGO9559p0f4ieH+tr0JiJrv3GWM2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129015; c=relaxed/simple;
	bh=HqfDOG7PLrBrBrwlxj/xW+LhXvjb1/q1K5AQKt4J27Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhdHwoFnbxng7H3E3za6eP51zeWNH8NPVmptKvyDxIzxgwwGTTuOHuYebprSIF3gdU/SKkBTZhGi2mgm4dnuFM3yqEgYCuKpeEBrwtBD7w3dky5Y7I8ZI9ypyYJNxpVLKrTQrVW0VCMxdz+n+sWu1lhjavu3G9qRwfAir4EoRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi6cCO86; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi6cCO86"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b018062a5so2792539f.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741129013; x=1741733813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOuPISCVk/j1dObHhjR9gHuX7PO11NNYoL9Kf9DJTnU=;
        b=Yi6cCO86dqpRXkqA1KF9uvBrcs/ijgvASfMWoIENxe5hPbFGhC2h4KLcdTbhuWMQ9g
         8BYFdNbpnZA4rLw76t9+YKHqSO+QRDazcRVGMlwM60a0hT/s+sFkaK8A8egR/0li4Leh
         dpzhP5gdZ/GJu2cqit+aundEasDmM9xx8xj9GNKlNAega/bfIC8niG4CTpFonArHmHnR
         MVDxn3apTJia4dFQhjB1Zx8svu2YeXOb281SZqBy5xYZYmZiWoXqEy4GKMeO7btx06j2
         xZncf/n2t0p1dgZ4PWJWJDO3QrSajJF2H7StrAywK45kHhhfAu3XVsp+Q41QM2N37sSe
         ymqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741129013; x=1741733813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOuPISCVk/j1dObHhjR9gHuX7PO11NNYoL9Kf9DJTnU=;
        b=K85JwRnlKgKGsmKtllSjENEnRKq5M2R7VCfTO0Kjijb30HoUa0U376Aknb3Z8k739Z
         Si3bxLEfxpNsa/dWaH1DP7mYysqG67hMDfU32HST5asMbRn2Kv1TrmCUelPOYdJEZ4XR
         hQJzBKJmOJDkhxqWr9svZLJJOzZZ9//H6g7+IJZeCE0rQ4PTaIPEpaI308sxtP6tYcl3
         hiTI9EnuviM2wrNZGXG90J2YTXgBBPY61BNyJNVmNRjwm+RbaeTtRBrvMrRdtfxkHLQF
         vAGPVCl5AU57sVhKnqQ2tn8rQHgUZDkN+ErevjdeDJYCYyF0TOo7andJxoHIR1iN9MVg
         E9eA==
X-Gm-Message-State: AOJu0YwVRaF0O1GkovKERatzrF1qg7R4p6Hv4cDC0A4IWlSRW5N/NhY3
	JjwSTNKm09kZlKK6xLhGFI9a8UVJfUO0OEvSBbmN6iEb864lae+rak/9r0DnkE6P8tnBGp8iLzu
	fqSpxGUizKy7p1nyknwhtoxpRnoM=
X-Gm-Gg: ASbGncvXSwt651gtCmqxroJnzFm5z+/H63rVRJBdICqqITYBw2GCfvrh5FpAahrANLF
	EPgMhBj6E8t0R6W1GVM4vCLGsWFGxgqn7J9ORbrZWX2XxRoP5o4NdmJW88SGLer6LvhMDe1QHcr
	WfY586tdPN+jJ5mOb0Swe1jlSeFLMamUycbAGPOE0VolbRgz+GpwzPZH8O
X-Google-Smtp-Source: AGHT+IHK4IJTnGG9mzyR0yR89YwilAI5eotaLRZwSqn8vF2KjDY6D0PY9o/o7gBuaJdKgZj/bco5orxdMLzvU6Zm41g=
X-Received: by 2002:a05:6602:4a06:b0:85a:ec03:b124 with SMTP id
 ca18e2360f4ac-85aff9cfc23mr168888639f.4.1741129013051; Tue, 04 Mar 2025
 14:56:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740680964.git.me@ttaylorr.com> <cover.1741124116.git.me@ttaylorr.com>
In-Reply-To: <cover.1741124116.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 4 Mar 2025 14:55:00 -0800
X-Gm-Features: AQ5f1JoA5TdUK9f46zLDbBL571KfV28RQvzOJTjdcHDGPWrd4vYMYq_0-PGLI-s
Message-ID: <CABPp-BHv2_tgeQBKU6v4mnwU8_wOPHfPPRcpRQZ8wEP9P-HovA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pack-objects: freshen objects with multi-cruft packs
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:35=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote:
>
> This is a minor reroll of my series to fix a bug in freshening objects
> with multiple cruft packs.
>
> Since last time the only updates to the series are textual changes to
> the commit message, so everything functionally should be working as it
> was before.
>
> As usual, there is a range-diff showing as much below, and the original
> cover letter is as follows:
>
> ---
>
> This short series contains a fix for a bug I noticed while rolling out
> multi-cruft packs (via 'git repack --max-cruft-size') within GitHub's
> infrastructure.
>
> The series is structured as follows:
>
>  - The first patch simplifies how 'repack' aggregates cruft packs
>    together when their size is below the '--max-cruft-size' or
>    '--max-pack-size' threshold. This simplification changes behavior
>    slightly, but not in a meaningful way. It occurred to me while
>    writing the second patch.
>
>  - The second patch describes and fixes the main bug. The gist here is
>    that objects which are (a) unreachable, (b) exist in a cruft pack
>    being retained, and (c) were freshened to have a more recent mtime
>    than any existing cruft copy are unable to be freshened.
>
> The fix pursued in the second patch changes the rules around when we
> want to retain an object via builtin/pack-objects.c::want_found_object()
> when at least one cruft pack will survive the repack.
>
> Previously the rule was to discard any object which appears in any
> surviving pack, regardless of mtime. The rule now is to only discard an
> object if it appears in either (a) a non-cruft pack which will survive
> the repack, or (b) a cruft pack whose mtime for that object is older
> than the one we are trying to pack.
>
> I think that this is the right behavior, but admittedly putting this
> series together hurt my brain trying to think through all of the cases.
> I'm fairly confident in the testing here as I remember it being fairly
> exhaustive of all interesting cases. But I'd appreciate a sanity check
> from others that they too are convinced this is the right approach.
>
> Thanks in advance for your review!
>
> Taylor Blau (2):
>   builtin/repack.c: simplify cruft pack aggregation
>   builtin/pack-objects.c: freshen objects from existing cruft packs
>
>  builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
>  builtin/repack.c        |  38 +------------
>  packfile.c              |   3 +-
>  packfile.h              |   2 +
>  t/t7704-repack-cruft.sh | 105 +++++++++++++++++++++--------------
>  5 files changed, 170 insertions(+), 96 deletions(-)
>
> Range-diff against v1:
> 1:  8564f982597 ! 1:  63ea9d4d00e builtin/repack.c: simplify cruft pack a=
ggregation
>     @@ Commit message
>          would get combined together until the sum of their sizes was no =
larger
>          than the given max pack size.
>
>     -    There is a much simpler way to achieve this, however, which is t=
o simply
>     -    combine *all* cruft packs which are smaller than the threshold,
>     +    There is a much simpler way to combine cruft packs, however, whi=
ch is to
>     +    simply combine *all* cruft packs which are smaller than the thre=
shold,
>          regardless of what their sum is. With '--max-pack-size', 'pack-o=
bjects'
>          will split out the resulting pack into individual pack(s) if nec=
essary
>          to ensure that the written pack(s) are each no larger than the p=
rovided
> 2:  c0c926adde2 ! 2:  7ba9054701b builtin/pack-objects.c: freshen objects=
 from existing cruft packs
>     @@ Commit message
>          only be modified in a pruning GC, or if the threshold itself is
>          adjusted.
>
>     -    However, this process breaks down when we attempt to freshen an =
object
>     -    packed in an earlier cruft pack that is larger than the threshol=
d and
>     -    thus will survive the repack.
>     +    Prior to this patch, however, this process breaks down when we a=
ttempt
>     +    to freshen an object packed in an earlier cruft pack, and that c=
ruft
>     +    pack is larger than the threshold and thus will survive the repa=
ck.
>
>          When this is the case, it is impossible to freshen objects in cr=
uft
>     -    pack(s) which are larger than the threshold. This is because we =
avoid
>     -    writing them in the new cruft pack entirely, for a couple of rea=
sons.
>     +    pack(s) when those cruft packs are larger than the threshold. Th=
is is
>     +    because we would avoid writing them in the new cruft pack entire=
ly, for
>     +    a couple of reasons.
>
>           1. When enumerating packed objects via 'add_objects_in_unpacked=
_packs()'
>              we pass the SKIP_IN_CORE_KEPT_PACKS, which is used to avoid =
looping
>     @@ Commit message
>           - exists in a non-cruft pack that we are retaining, regardless =
of that
>             pack's mtime, or
>
>     -     - exists in a cruft pack with an mtime more recent than the cop=
y we are
>     -       debating whether or not to pack, in which case freshening wou=
ld be
>     -       redundant.
>     +     - exists in a cruft pack with an mtime at least as recent as th=
e copy
>     +       we are debating whether or not to pack, in which case freshen=
ing
>     +       would be redundant.
>
>          To do this, keep track of whether or not we have any cruft packs=
 in our
>          in-core kept list with a new 'ignore_packed_keep_in_core_has_cru=
ft'
>          flag. When we end up in this new special case, we replace a call=
 to
>     -    'has_object_kept_pack()' to 'want_cruft_object_mtime()', and onl=
y
>     -    reject objects when we have a copy in an existing cruft pack wit=
h a more
>     -    recent mtime (in which case "freshening" would be redundant).
>     +    'has_object_kept_pack()' to 'want_cruft_object_mtime()', and onl=
y reject
>     +    objects when we have a copy in an existing cruft pack with at le=
ast as
>     +    recent an mtime as our candidate (in which case "freshening" wou=
ld be
>     +    redundant).
>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
>     @@ t/t7704-repack-cruft.sh: test_expect_success '--max-cruft-size wit=
h freshened ob
>      +
>      +          git repack --cruft -d &&
>      +
>     -+          # Make a packed copy of object $foo with a more recent
>     -+          # mtime.
>     ++          # Make an identical copy of foo stored in a pack with a m=
ore
>     ++          # recent mtime.
>      +          foo=3D"$(generate_random_blob foo $((2*1024*1024)))" &&
>      +          foo_pack=3D"$(echo "$foo" | git pack-objects $packdir/pac=
k)" &&
>      +          test-tool chmtime --get -100 \
>      +                  "$packdir/pack-$foo_pack.pack" >foo.new &&
>      +          git prune-packed &&
>      +
>     -+          # Make a loose copy of object $bar with a more recent
>     -+          # mtime.
>     ++          # Make a loose copy of bar, also with a more recent mtime=
.
>      +          bar=3D"$(generate_random_blob bar $((2*1024*1024)))" &&
>      +          test-tool chmtime --get -100 \
>      +                  "$objdir/$(test_oid_to_path "$bar")" >bar.new &&
>
> base-commit: 08bdfd453584e489d5a551aecbdcb77584e1b958
> --
> 2.49.0.rc0.57.gdb91954e186.dirty

v2 looks good to me; though I'm curious if some wording improvement in
the commit message might help in distinguishing between
--max-cruft-size and --max-pack-size...and whether we want to provide
any checks on the relative sizes of the two.
