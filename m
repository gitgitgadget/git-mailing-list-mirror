Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C138398
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528069; cv=none; b=QKd8NEE8pxQ8YpEqG7xIYNXtBVxchTcgKzpk4+tX99HTreq9V2sAekvMC+Yqmdl58+KwE+R9fQUSBQvU65pJTcTxCAR3bKpMXkd2CxX0PpqNQBWElgqYMceJ8dXnOMS6ly9AE+i6YdR+211kxBCiyyKEF2RGgpqfyEOkCOknWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528069; c=relaxed/simple;
	bh=B26YoLjXZHjgLgqaRQXa/3Tz0A6maOusKDNyULI1ums=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sk9ejQxdCfbASOYvJa1X9CJ4X//kVugCWHv0TNzveFT73ZGIa80C7qByxvODyd38Jl/YseK1AVdCgrxhkMvhBzeI/fwKjmtlDKD5m5kn1WoDcE7v9wUNC/4Iqd8uL7pYopudlSrNp5QXDmzgU12WK573PzChWYsxu1KPc6eutt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/w8wlQh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/w8wlQh"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dc20645871so4306968a12.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 07:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708528067; x=1709132867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B26YoLjXZHjgLgqaRQXa/3Tz0A6maOusKDNyULI1ums=;
        b=I/w8wlQhG0ogwwMKIKUmcLiOQb5Aanjuy/Gto8pdJoxKM+YBvEWXtBT9+9YuQ/JNmk
         yh71IOxpNOOjk5ASvhNGttI5skJ/cFTmSG1ku3MiCIcHXGTt6OxuwldvgMnD/3N5Wm6Z
         PORkd62Pmu+nDjjV9eijyJYbsGBhM4DYl2hS9L0PcdN8q6pkuPvrUzspFySi/nY6qXHF
         Xj85uwAmUgJn2/G69i/ZzH1BAdvld9D01uJ7qYN9gVyMGvYeS+p10Y995ycK66kYUIgI
         uCQayOYWakzFMrT6OwxHuzSSAs/9sD7mbTOyrNIrA3rPM5ki+b/LFDrzuSXTr4dFWhZS
         uGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528067; x=1709132867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B26YoLjXZHjgLgqaRQXa/3Tz0A6maOusKDNyULI1ums=;
        b=MkTXSbIu6DYSfYdcC0xIx1nT1SoG1nP/V5m7F2ykHLsZ7LR3uaF3aCGrHaZCeOzEIj
         +jHglka02MnafmR6j15zF+2BAFXayNjH7U0H0B4Nd5doMVELtWGTUcP0QFj8/ti9x3rO
         wt8vwHrjXQ1yo69Ak0vYnYtEaR089J3fIN+5ucX295NDvT+jL002ReOGWB4TiZmcgWHO
         n3FU2Pyj5S9pgbW+m1tVj8tWw2yYMEvK0K74xhITppFeYTbNlW31r93+6pTU36lazhB3
         2YZ5MtD9FqQspjz8IUXBUKSYfdQbzeqJW2O2nD2vzu8JpX4/biBx0WecXR6V5BpJHTHh
         scsg==
X-Forwarded-Encrypted: i=1; AJvYcCVZMlnFFdaJE7gh2Pq1EOFq9/835kR3f9m6nYX56hHjlquIKND54zCdudHXNG6IWmBQQqzq6ki8/o6wVGaz0OwzKKhl
X-Gm-Message-State: AOJu0YyUkgcL2goBBpUS5/djoX89AUI5pZKI4wzu+tBKtzIQk6ANWxMJ
	HQJViz6l6xatDWVJNwhojr77vL12qDZPUFnVmHVQtfiYhTm6V8xMtZYFqyksYZjO539GM/tzsT7
	WfkgsvmCVj4pce5feXTkYRldpCeU0RpAP
X-Google-Smtp-Source: AGHT+IHkFVAJSqAlbMTq/hOr4HhgnMz1ucv52iQm/qj3L21sF+fKnMD66cqcd7Vxs90HLwsGEhgT8GAimClkN+SwU3o=
X-Received: by 2002:a17:90b:3713:b0:29a:72b:df85 with SMTP id
 mg19-20020a17090b371300b0029a072bdf85mr4402712pjb.7.1708528067415; Wed, 21
 Feb 2024 07:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
 <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com> <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
 <m04je1dhdx.fsf@epic96565.epic.com>
In-Reply-To: <m04je1dhdx.fsf@epic96565.epic.com>
From: Maarten Ackermans <maarten.ackermans@gmail.com>
Date: Wed, 21 Feb 2024 22:07:35 +0700
Message-ID: <CAB=tB2uZb+8QLmrk_tK5PKJtDE=RmBr=eBBb7U7ygSmkFoXvWg@mail.gmail.com>
Subject: Re: Breaking change with "git log -n" since 2.43
To: Sean Allred <allred.sean@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would suggest displaying a warning in case of invalid input (such as
this out of range error), and to fall back to output all as if the
"-n" flag was unspecified. If more strict handling is still desired,
it could instead be a deprecation warning with a grace period, giving
applications some time to update their git usage.

On Wed, Feb 21, 2024 at 9:25=E2=80=AFPM Sean Allred <allred.sean@gmail.com>=
 wrote:
>
>
> Maarten Ackermans <maarten.ackermans@gmail.com> writes:
> > Applications that have been relying on undocumented features and
> > limits since they were introduced, now face a hard crash: "fatal:
> > '9007199254740991': not an integer". Regardless of whether this is an
> > improvement for future implementations, a crash in existing ones is a
> > suboptimal experience at the least.
>
> What behavior would you propose instead?
>
> --
> Sean Allred
