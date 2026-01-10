Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7C21FF23
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008423; cv=none; b=o5oO+9st6V9O1BxgGENbc2s1fubuGd3VDZGEAGCi9Vd21RMyOeE0m/cPLVkV4nwz2OVqECF3cvsMOOSMXCte/hsr9QAoN5YeKASUyVHljZov8Tb7ZycrEpHoGAHxzFnzYO0VN0Z1yDFd5LGGyglQVAROLO7CI1cv3fgnjiH0E7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008423; c=relaxed/simple;
	bh=ykgk+Gugr46+FZM0ObsQ68/xelb/13OrjgqBsHvPsks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFwBCP32Un3O5pXA+f5SlzK5bzDVIAadC1ziq9x46EHKKXYDqlWGWZVWvlp8pYSePFFB1D+iffbg7phn9pP7w7g6zGCLdA5OSFUnU15pz6ivd058e2Sx0Xvr68KJEr/VFClqzRFJ+AkmBTprTNUuAH8cZv22dCTwaeL9MuZOK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVQ4qJRm; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVQ4qJRm"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65b6b69baf8so1668006eaf.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 17:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768008420; x=1768613220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWSeX0YDsoRxlq+SPKW1YTt4GoNe6BU3s9R5nzWPsX0=;
        b=NVQ4qJRmYmy1VW3IyCIDDDEZSfFuYS0GEX+4GxxQJZIiI08BOIgI5q8fyPBrSuJ6jb
         c3P/oMS8y/JlSQYpKozckDclZvVnnp9WPNReFM2APeOhjQ9fhlclnNkb3DKLvYVuWb8x
         P7iFrvYQgoS5VbcHX+jYuoB6L1oGp7qMuIsgUp8cQogZHemFn1IiGfDuzr7YFi92w1W+
         pW+zax2e2rBMeHyb1sKboyKvGdZew1RIJ7zwDqtka28VIorfpKXWluyPKCObNOp0LqJf
         ITT2iJCWYjqrC8y+aSRu4mmVlp6RvS3wqg5kmnk8P2DWWQ7M+r1gL5/WMdrEjWOMpfYW
         WoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768008420; x=1768613220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWSeX0YDsoRxlq+SPKW1YTt4GoNe6BU3s9R5nzWPsX0=;
        b=P/ToxamquAyOS9hCZsgb3GOwao48nDhNcgjrZi6Jt1ps8JaRHHvOY+Pn+CYHlLBKDJ
         B85Xrkqg3t4UFCMg+yvhO8CZSlHdLuqsniue9abfKSoime/IbgnRHq9Xsy/5VJUlGx+s
         vDBDgEeym0Hnxh7z9lsqaPGw9trtM1gjbIedNdC49WDyYx2gvOXmDO3NEbKFtJICe078
         OQDpeJQQYYZAe2jSgqYkv+5hM6O32KCzLW1d8yPemn0gUV/phMTjtjVczgaQQO52RFP6
         dV5cczzb0lCagyoqYPjbd8mY21rsRUZCCd4F0KSS5kaXEdFa7byaJ18s7EDUMjmArb6/
         6/Ng==
X-Gm-Message-State: AOJu0Yxq+hvHHvNwFhHqS7SGpRs5VjC9IwB1FZmpPROUBYGaOi3CZlMH
	D0eqekP10SLb3+eEqlRh8lc2Do7FvUuhCdqLxQb8N4irSmUlyPV7+awLILKg0wdASy8BzQBZOJx
	p07wxOx5lNN9fCkJ3wgL/jN9UgTiUHGE=
X-Gm-Gg: AY/fxX4DGlVi4q6ya48zX7GFxXbggUwjlr0nbH1CUDK+WO8f8b3y/e7JUMZ36m44buO
	16pPRuQw+/2E08pFHK5ZNnqVJM0tlqmJCqfv4vdQNhHftTk7lvG5SSqpB+37Dy/fCxwfNQqjJG5
	QhM+WNxP8sATUUZJtkRQMuTsK17O/FhnYw9J1TRgS4/w/XUxdFd5pHk+9TRsAW0Mes3LzuEcUcd
	dWTojtNxPO6gmb+F1ykomkxOYHizqA/UVjT/iJLhrBwkLyW55bDoBdZTXq/b3Kd+En3YUMDxiJ6
	D2g5fQ9DrzvnLj3N89q2knE8IAc=
X-Google-Smtp-Source: AGHT+IHwjv8HllmVTaGHlSPve7E0r7gklqYOsrKU2KsQEP0kEAjkmwZj2Cm1lLbDgHd2OLbAjgyEiO0wGG7FDWg+xE8=
X-Received: by 2002:a4a:d0d6:0:b0:659:9a49:8e84 with SMTP id
 006d021491bc7-65f5508aa17mr4515865eaf.84.1768008420094; Fri, 09 Jan 2026
 17:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 Jan 2026 17:26:48 -0800
X-Gm-Features: AQt7F2qIzp7RUu6cbacescfubBk631dA5cjDfw-qScd1P2nOhNslyiTBgBLnnmw
Message-ID: <CABPp-BEVZbN08zF2P0wNWuOZozc+tbWodfOjtiAkX+XhMiyC6w@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Introduce git-history(1) command for easy history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Changes in v9:
>   - Rename `struct replay_ref_updates` to `struct replay_result` to make
>     its semantics less focussed on ref updates, only.
>   - Clarify and fix return codes of git-replay(1) so that we return 1 on
>     conflict, 128 on an error and 0 on success.
>   - The usual small improvements to commit messages.
>   - Link to v8: https://lore.kernel.org/r/20260107-b4-pks-history-builtin=
-v8-0-18e9779e3a26@pks.im

I read through this series in detail; it's forming into shape nicely.
I think there's still a number of small implementation things to fix
up (see my comments on the individual patches), but the design looks
good to me now.  I suspect we'll be ready to merge before long.

Thanks for your patience and hard work on this!
