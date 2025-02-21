Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE41FC7FD
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129326; cv=none; b=UKdHaooAxmMGEz+crGCdShdp3GTv2dHRFwu5OxHBRIu4SoZHUHV81hRFEullBjDRnePgJT09XFIhc2151LkERENbyByV1tY25IPgKxsTK+v5KRATkxzDjYsA1wvQ5IhtWQVzC/Js1Py7YBqWZWfOyJlVLJzssXQ+z8cZvUwwDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129326; c=relaxed/simple;
	bh=g7dR+5j5BepgBUXZtJLEH1wIvKhWOGk5q3XN4Iwc76s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owsbJ2NHiCQFXFY9FaBrke+zkhLT2pUpR+Ror/Wdv+0leqEemdqoGcbdUxA0UehXuTRmBieQzROw80h0WO7C6L0gIEftEC2MLgt4BB4bTCfiLa8kwKamSYqnU74KTKpJvmCsS2/GwPyBONJIJqY9De74Uu/g69PEusBnJerdEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDXL4iAc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDXL4iAc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so2514500a12.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 01:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740129322; x=1740734122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG5GmDSkdnCyJQkxE8nUCt4amCFG95/ejbjMbRp+LGg=;
        b=iDXL4iAcxavO3848Dp3tllFTQlmWwcdWtaLoRSsyBNi+i8sM2uf6V2qNy6nXfONBAO
         3w5uip8oMMSLC7uXONM5DO3oO7scyvgcHsoBuKgsHkn2ntjyo71OdiY9pWtzBfsSCwIq
         xcJWxmBEpNK+/zRlzvofrvdK/9ahBAp7c4jO2nI/qxbb74983jKMXSLcIfE5nrw5TQV5
         gA9zn6YnPMWcxxh2FsMYsZoHgaRpuUMjpYW6wzCzyVH9V59QRgLCIu7ld6RvB+CIyyqg
         zReTtRBEqfB0767oeOqftsXfg+R4vNUXGRQG2C2wdhQ8oqNAGp+8nT9XVDFbLwRT/Dfw
         2WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129322; x=1740734122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG5GmDSkdnCyJQkxE8nUCt4amCFG95/ejbjMbRp+LGg=;
        b=SlZnX3gO9ssNEKQdiUttqzdw4vJyCml4Tzr8N6l3bFUrWDlJcWj51RdCWf5yb+bDz3
         smXLfPKyjnn2F+ujOGFw5NyUhpchUSd7ib1b+PnHzdbq6onuYrwlRYqehnYFsfx2NED1
         7ap/vGka3CVguwENkCNgclaI2xgK9FLm79TXwu8Zr65hXuDHjy68cSQ9YA9l+g2HUmZz
         XlUi0VwFmNcW1ciOyJUseFj8zqtML2LClDqTvT4EK3gXt+ASHiazMoGvWDLfqpfpQ3T6
         6zspX4HIjKmcRvmljiXO6m8nXHYl+Emm7euABJ5EuF821fh3doNNxarKksQmDZI076Vl
         MWqA==
X-Gm-Message-State: AOJu0YzFQXXYyySt1Dw+N4ViYYex+079DCkRDSRn+cOd8ddlX63/NAtj
	G2utRZpIa4JeIvElIzYpLnxMM6jpQ1FmXvQd8olWdSBmP1EcxCKoU/MTXn2/vw8YpODQEwNMeXX
	KLLynmjybJrRCxIWyA+CCsws27NJHzU8D
X-Gm-Gg: ASbGncsGo5ir4dIYHo+Br90wEZ8ppZDRJj4II+EpIAmWkUfTc7BGwyIneSnLH3WoSBn
	EePpDMNMNGiKoe2pSNRszSzv/+LrRm6jPdgt/hS6A4PFkDMqv6Q8X9bS22ocXmhERjc2Bge1qhl
	WBCkkmp/17+A==
X-Google-Smtp-Source: AGHT+IH8zFyNoPE6ui8mvTP3wtny/EWb2Uj4YH2q7XGwuVNQpudnbZ4LdquGAaHuhg55gJjlRLkjNzDeFtWCY05tsn8=
X-Received: by 2002:a05:6402:50c7:b0:5dc:cc02:5d25 with SMTP id
 4fb4d7f45d1cf-5e0b70d5729mr1971600a12.11.1740129322363; Fri, 21 Feb 2025
 01:15:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
 <CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
 <xmqqikp4ctoh.fsf@gitster.g> <xmqqa5agcbx6.fsf@gitster.g>
In-Reply-To: <xmqqa5agcbx6.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 21 Feb 2025 10:15:09 +0100
X-Gm-Features: AWEUYZnSV4dunAdzbCm9eqpdD90ftathMfMCeQHImT4by8ezbQMJaKzBBXLFyTc
Message-ID: <CAP8UFD3XVgJCc2Qa3wWZA54fg38jcpyiDtQOPNc8UQT9uL3vWg@mail.gmail.com>
Subject: Re: first bisection step takes quite a while
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:41=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> So, here is something that _could_ be the beginning of a patch, but
> just to illustrate what I tried.
>
>  * In do_find_bisection(), we try each commit on the incoming commit
>    list (which is sorted the way rev-list emits, probably reversed)
>    and count how many commits in the set each merge commit can reach
>    (which is called "weight") in the "honest and stupid" way.  I try
>    to collect these merges in a linear array, and try from the
>    middle to older and newer.  As the loop to compute weight for
>    merges have an early-exit clause that says "oh, this is good
>    enough", this may improve our odds to find a good enough merge
>    early.

Yeah, it seems to me that in practice this is a bit like bisecting on
the first parents first. It would be nice if we had added an option to
bisect on the first parents first, so that we could compare your
improvement and that option.

>  * The "this is good enough" logic currently allows us to be within
>    0.1% of the real halfway point.  Until the candidate set becomes
>    small enough, we could loosen the criteria to allow larger, say
>    3%, slack.  This code is written but not enabled (with "0 &&").

If we want to do this, I think we could loosen the criteria even if
the candidate set is small. Weights are integers so when the number of
candidates is around 33 or less, a 3% criteria will mean an exact
match. Then the last 5 steps or so (as 2^5 =3D 32) would still be
performed in the same way (with an exact match).

>  * After computing the weight for a merge in "honest and stupid"
>    way, we know what other commits in the set it can reach.  If the
>    weight we computed is way smaller than the half the number of
>    commits in the set, that means these commits we can reach from
>    the merge we are looking at would score even lower.  We could
>    mark them as not-viable before clearing the list to check next
>    merge with "honest and stupid" way.  Again, this code is written
>    but not enabled.
>
> So, in short, I have three ideas, and with the first one (that
> is the most straightforward and least error prone) alone, it seems
> that we gain significant speedup.
>
> The current code took ~20 minutes for me and its result is
>
> $ git bisect start --no-checkout 09fbf3d5020 96d8eab5d0a1
> Bisecting: 581164 revisions left to test after this (roughly 19 steps)
> [2c71ab4bb465c79a4687cc2fd5012e470aebdb1f] Merge branch 'for-upstre...
>
> There are 1144459 commits in the range, and the point chosen by
> bisection can reach 563294 of them.  563294*2 =3D=3D 1126588, so we are
> 1144459 - 1126588 =3D 17871 commits away from the theoretical halfway.
>
> With the "let's try from the midway merges" approach without
> changing anything else, I get a different commit (because the
> original algorithm is taking "good enough" early exit), and it took
> about 30 seconds.
>
> $ git bisect start --no-checkout 09fbf3d5020 96d8eab5d0a1
> Bisecting: 572238 revisions left to test after this (roughly 19 steps)
> [eafdca4d7010a0e019aaaace3dd71b432a69b54c] Merge tag 'staging-4.18-...
>
> The size of the original range is the same, of course, 1144459
> commits, and the point chosen by bisection reaches 572220 of them.
> Since 572220*2 =3D 1144440, we are 1144459 - 1144440 =3D 19 commits from
> the theoretical halfway.
>
> My current thinking is that the heuristics #1 (which is enabled in
> my experiment and in the following patch) is good enough, #2
> (loosening the "good enough" threshold) is probably not very
> effective, and #3 (discard ones that are closer to the good end than
> a merge that is known to be not viable) might be interesting to
> pursue further but probably tricky to get right.

I agree that #1 is probably good enough.

About #2, I think it could be worth implementing as an option if it is
effective in some cases, but the criteria should be loosened even if
the candidate set is small. The amount of code to implement it is very
small and it's possible that, for some users, having to sometimes
perform one more step of testing is not a big deal, compared to
bisecting speed.

About #3, I think that implementing an option to bisect on the first
parents first is likely more useful than implementing it.

Thanks.
