Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E41922D7
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528094; cv=none; b=abqStIdt2x1NwI0ZCHI5hoMT3d+7kMSuqqgyIhf5J+t4yeZGKQhrAFUCa5OGykknj5KpNFXeh/Icw2P8E1y0KcdZmHoR+hvktiNobtlztv3xcwKbLHtWzROSBR4Y1xGviobB8dlUvKHdE6ysrIJdBs/JG3/wRB1KT0+QwbE1iaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528094; c=relaxed/simple;
	bh=yMxMIBqfmiiFUGzbBLA8dXGsKeojIPXdqdxy+A5lxNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX/6JLgFJHKioIqBnYpvj4c9dT391TDC9iNL2lq+CPOll0p5H1FuOSqmCg6CwqEdC5l+WXrXDF5V/q16lKZUFjXjB2x0NNEWwnzp+3ZTklEpcVX64GH/Vc8PMnbBlBpo0rB9aP3IFLojQzld8TzUomQFWkdQqkQs3myzD5fHIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXQDbIvZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXQDbIvZ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa53a971480so215849266b.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732528090; x=1733132890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnxRNiriJ1cJNeVCoBVos78BCJBHsuqWtksOX4zXY8U=;
        b=YXQDbIvZxXmRPekFGsk/6so+XDm3saGyK3uCkiVBQNgTrwScYfX1H0Up/r0e8WHLup
         jgxJV5bWumaDhoaweGAdgnSj/ZgJDfSIGvf0fh6ZRz356bVoLbA+rAeGy8xCKPfIzGzM
         tX+1sbTcj8UFXN2Y9puYA4EZ6K11xImKppd+lDKfYlgT+5PbsIXw4YNX3Z0U3chZ6cq2
         QRnX417H6Oo2VG2MS4R0oLo/7RZ+zrr1ih1qDtQHqYWw68qNgtcZBjSj/7/P+51TaVYh
         VaXQ6+N1strkmXzY9YIgqIRs5tyhzcC5BlLlviH826vQsQ+x+zdcIK/8afZ3BgbRTrO2
         ZurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732528090; x=1733132890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnxRNiriJ1cJNeVCoBVos78BCJBHsuqWtksOX4zXY8U=;
        b=uytnERHyorIKQp1KMKo5VeDdKwrN9Yjo6kzW++heGhQya6l1Up5vs1zw+lEHvZjxa7
         H+STfbhqHVHdml87gsgYssJ9nDYCQbCSXfljJnJ55R9w3ZjvBmKrPN/ibjCy28ANu/Yp
         JoM1QjXmCzPN9RlZfcwCu5BYhGooRJ5jC9N3f1nq8yVDLUXh/1U/Hj+whmzSc+UBmBys
         +m8i90mtk3YPWmzb23H9/f60Qg8nmocjITY0ANPKv209gwXi1KtFdFCARc29/GjXt0MC
         rwW6A/ut0Jl6jNnau+tppZfY8IS30Iytzbeg0/LD1FRhkLu2bKBcuqph8M5XxS1tR8y9
         lmwQ==
X-Gm-Message-State: AOJu0YyBrbyJ8Y3OUvywPOMKPaMaZ9ct5HruA9pQBSam3tCsYf7vhy8b
	rTpoN8qAJSGtBYTgMvbITzwF321d5ERDwp2x6vkhJ1YPMVRsPsRlaCuAxpyGAM+rhSS/fqI0Ewt
	qoHkbqvKW/2uP8JE5eSGKeus+344=
X-Gm-Gg: ASbGnctM/trTeEwvXtSvkibw0o077cyMovKe2Q7W0pox9apyOpfCRhhmZ4bb7pZ5/to
	qdSEEVRArmFPjAq71tXtLMjdU9VL/W9qdBg==
X-Google-Smtp-Source: AGHT+IE4/ErBdeSybr76musIyOrnUJoVUvtsdnCIV6+SBbnidNTYHkVJRWtbXyWzSaEmK+lvBJNkY4GAJQ13zGMcTh0=
X-Received: by 2002:a17:906:23e2:b0:a99:f972:7544 with SMTP id
 a640c23a62f3a-aa509bbfb75mr1092096766b.38.1732528090384; Mon, 25 Nov 2024
 01:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730732881.git.ps@pks.im> <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 25 Nov 2024 10:47:57 +0100
Message-ID: <CAP8UFD2woZV1O-B9vxEdM-1_R-oTDgt-k1RKt1wJJsofZHb9rQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] refs/reftable: reuse iterators when reading refs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2024 at 8:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> this is the second version of my patch series that refactors the

Do you mean that despite the "v3" mark, it's only the second version
because "v2" was just rebasing "v1" on top of a better base?

> reftable backend to reuse iterators when reading random references. This
> removes the overhead of having to recreate the iterator on every read
> and thus leads to better performance and less allocation churn.
>
> Changes in v3:
>
>   - Adapt some comments to refer to the "backend" instead of to the
>     "stack".
>   - Fix indentation of a statement while at it.
>   - Explain why callsites don't want to reload the stack.
>   - Optimize `prepare_transaction_update()` by not using `backend_for()`
>     twice, but instead reload the stack manually.
>   - Split out the change that adds `reftable_stack_hash_id()` into a
>     separate commit.
>   - Link to v2: https://lore.kernel.org/r/cover.1730792627.git.ps@pks.im

Thanks!
