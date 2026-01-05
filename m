Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC832AACA
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644002; cv=none; b=R8hkiFDQ0rJpw7M1drJnHcv/YGgPX4tgZovf0gwMYPGRKmo8Jmmpju7qPs3O2vifBAaeKK+G4abykSFgaZwzazWmuFPcGGK7zDk4qzPBsoo4eoN9G/x4L9Kmd1SV8pmFpxjgQygAgXgXCzd/HYT6vIg5a9084YjSt4rXkHyXJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644002; c=relaxed/simple;
	bh=XH6H75Go1n1Vpv1zc2YbdDPSu6gOcqRRicRisn+l1MY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cy/OQjkbBdJDPFzfJlBmWCl09pVlRk36bBYev0fK5d41NX65HxRwy1/522me6sPeK1PZaKF6swGpn3URuUW0hpaMaQ9guTSRxmWemafrxquFQSJ+BYwRRPw9zbnOiB0STmZvNEf2aha4d16/p2gFFhBptY5u9dk5u2G86jA+QCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs6WJUdi; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs6WJUdi"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbd1421182so192921137.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 12:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767643999; x=1768248799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMwqmeruv3ozcRU6LPCvpb4aqWxLm5A8hblQL9dmzXE=;
        b=Rs6WJUdiRdwrimfvlnQxXopva1Kzv+/5kQlPp8YdsspAqhFRWD1KV8/CX5rFA/oXmm
         hQg+GYk2zx7wQepfYQlF1Dba3XhawNUGgitjVMPRPuOXuu8IAKOUgSIEerfFmPf/FFgm
         g4Av53GvSa1zMOGbMYR1Cm8eqCA2Rv9k1d9YZh638cG5Y/+0v/FOZ+fugYbIcoSKCUsc
         BkQqxSTK263WBYKm9/3x6C0I1tDasax76c0WbNVJ127d3zPzVCtVjBrrKOic7tonivZY
         jD9hDy/ewd+2Ldv//Des7zbX9dX9phGS3jxdU3sTGWIlmxjME5ffDgaGiJA902O7ORbN
         eNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767643999; x=1768248799;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMwqmeruv3ozcRU6LPCvpb4aqWxLm5A8hblQL9dmzXE=;
        b=AUpRdAW1e+7xZlf6l5FccK4DZMdCkWiX+ua9oYyL69lrrYhTPPMmKEQEk5eIqIjhWA
         +8PvXGP/xXCqZDRaac9whynXuz02mPMUuLugIVkRsxnAOn7SIC3GrHY7Hfm0ZLMnQrpz
         mgcUQYw0Zug36sPgiNZtF3AE7//YpJkdgj6C+MloBoUgbD0bQpydmOrjflpdphJ8vWeZ
         l7VtX/Q2yL9Y1pN+XMaEMNG63k+nS2Lf9pkn13/27Nyb+pV6pxE6M0RUjB+K1ljDXA2D
         PqWVqAw1G40cqJEs5qc8ZWA8pFUOAHt78xffZIxindWCTtXgQMDuul9L//SEAx4i0x7e
         tV4g==
X-Gm-Message-State: AOJu0YyceXzccBfOL5LQQgyPhwxkknDWuWg3AqGIcRj79oKNIUXn+HNW
	BQpiOZ85EF1WET2l8E8wJ821Hk3c1JhX7+hkwqSPXi632ClJPckNPo5lzh8l3c64FnDe0ddvtGX
	qATc/nOFEV9tJMbuhn+C78oiPpnH49Ag7V4tU
X-Gm-Gg: AY/fxX5RGs4VZxGgSfnp6IGV8wX/Tc+PdwhwhpVZFwtEMNM3vtmuwRCfkBKMOLIiH62
	heOqHW1gmQryQG+/XwNkpO2c7CoHpTkSROweW7Kda2WQZ2DH6gWtvqk6NtyUAmDbL36DY6jvzj8
	olsEz2iSWEeV+VtxLsOkRoRq+rIs1P2WUwQO9XM9zZia3jLfoocYovpFLMEqLnXJM9gelwy7vf3
	Ym9Ik0pvnEcAfxajuZYEdwqPXn787WP+GgpwlGWWQUXjDl4FJAEzOdFB/2hDb2ccggYpRVMORI7
	VXsC+zLCWs9hKLMn8igYEh1PWa2Iew==
X-Google-Smtp-Source: AGHT+IE3FH1739ZyDLBwF0MCV4hzPKJZty2Z9Bkunz5oIseGR+5Nw7lNRAkYYM5Qq/D8nMWm6gVDvVTwrAnTGbVD+3g=
X-Received: by 2002:a05:6102:3f42:b0:5db:9ab3:4291 with SMTP id
 ada2fe7eead31-5ec7452085emr244678137.33.1767643999125; Mon, 05 Jan 2026
 12:13:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 12:13:18 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 12:13:18 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aVvVAH1eRxGa60Fp@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com> <aVvVAH1eRxGa60Fp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Jan 2026 12:13:18 -0800
X-Gm-Features: AQt7F2qUS9g0KL0EpSCORM-QfOTXgZKtNsMegiomlOyU9OnH3P_v-ksA01DnyHc
Message-ID: <CAOLa=ZT5YwDXEs=wHqVcHqLNxen51-hucaPXOWQEMug3oWfxOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] refs: allow setting the reference directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com, toon@iotcl.com, 
	sunshine@sunshineco.com, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000a861db0647a9b072"

--000000000000a861db0647a9b072
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Dec 01, 2025 at 12:24:57PM +0100, Karthik Nayak wrote:
>> Changes in v3:
>> - Cleanup some stale code which wasn't removed.
>> - Localize strings which will be output to the user.
>> - Remove additional defensive checks which are not needed.
>> - Link to v2: https://patch.msgid.link/20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com
>
> FYI: I did an internal review of this at [1] and mentioned a couple of
> things that I think still need to be iterated on. Most importantly, I
> think that we also need to handle worktrees:
>
>     I think we need to do something about worktree ref stores in the
>     context of this series, as we're now thinking a bit broader than
>     before. It would be somewhat weird if you can change the main
>     reference store, but it doesn't have any influence on the worktree
>     ref stores. If I say e.g. that the ref store is located in
>     `/tmp/dir`, then I'd expect that the main ref store would be in
>     `/tmp/dir/refs` and that worktree refs are in
>     `/tmp/dir/worktrees/$name/refs`.
>
>     The reason I think this needs to be handled as part of this MR is
>     that we are extending semantics of the extension now. This is only
>     possible because the extensions are quite strict now, and thus we
>     can strictly extend them. But once we have extended them we cannot
>     just alter their semantics to also cover worktree refs.
>
> So you can expect another iteration of this patch series once folks
> settle into their usual post-holiday rhythms again :)
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/451

Thanks for putting that here. I did reply to one of Junio's what's
cooking emails [1] stating the same (mostly that I'm on vacation) and that
the topic isn't abandoned but would be delayed.

I've been looking at this with a fresh set of eyes post vacation. One of
the things I still need to solve is around how this works with Git
directory detection.

The current implementation works because it hijacks the refs
initialization to set the new reference directory. But this assumes that
the repository has a 'refs/' folder and 'HEAD' file within the $GITDIR.

So if we want this to work with worktrees the way that Patrick
mentioned, we'd have to create the worktree reference path within the
provided reference storage path. But this would mean that the $GITDIR
for the worktree wouldn't be initialized with the required files
currently required for being a valid Git directory.

The issue is that config parsing is only done post Git directory
detection. One hacky fix is to create a dummy 'refs/' folder and 'HEAD'
file within the $GITDIR, similar to how the 'reftable does it. I'm not a
big fan of adding something like that. Would be curious if anyone has
further thoughts on this.

[1]: https://lore.kernel.org/git/CAOLa=ZTeEEntiQdCnDd6B8a_ppJrrZqdURhQJV=bNktnp0JqMw@mail.gmail.com/

--000000000000a861db0647a9b072
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5ce855efe913dfae_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sY0cxd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFJRQy80NUtUV0xPa2NpSWdaakJMSU4vNDcxNXdyZQo3VnlhZG1Cb1Fk
SEYwdTd0QU13eDI1SHk1T2lNTmcycjJJbkhMOGlpTlJhdWYwL28rN3h1eTg1VmRGZVBkMkxWCitG
TytNZU5xOWk5M1Q0NEVJU20wV2h2NkhCRC9VdndRS3ByTGxJeU1tdWQwd2hjMnp2VnlaVXM1ZkVt
b20wRUEKUFNqZ2pZZUZ3Qkx6U1diamJReHcrdXh4azMxajZjdlhlZXR6UFp1MXFsZlYyZ2ZibFFM
SVdmcG1TWlhoLzgzagpRNjVyZXhEb3VrSG1hMklscm14V0pnck9UeTFaODFSZE1QT3pNME1pS1U4
L2Vid2swN3VyOGZzZzM4K1YyTk51CjF2aVBlajVlNHczb1F3WEtQZDBRVWlHbmxraExMWnBkSzRJ
a0FDNElCUnNJSzJxT2tWUkh3eFpYUGpZVVVvaUUKb29iWkJyK2I3eGRwRE5MOEtiTmRqdm9WOFZr
Y3doNGFwNm50SXVSMXVQTWd1U0pHelZZbnhnRkQ1cnk1V2UvQwo3cFFiOFZrSjd1N1kwUkZFL3ZI
ZER5aGlhZ1pXTTBNbFNlWXM0eWpob0ROekFxRXpNanFQVUNGZXk5Yjh1bmZ1CjV6Q0kvbEtYK1BV
T002VTZrUjRWR2VFd0JFdnFrN1ZoUVNqQnVIRT0KPU9BMEsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a861db0647a9b072--
