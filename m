Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409301DF255
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187511; cv=none; b=R+vuBKl+E8uPoGFzU3JwLWWdaam6C984SYvi93PT4LlWasXPeR+ggak0gMKDbQlyDRdabNY8EWxrq/byHd+p3S5mUqbRPSR+sLyboYj0JnAkKbinYT5S2TukedTybvaQJBfb3HRAlrglYIcdzozHgeebqaWYNvCiJKGhNe12nUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187511; c=relaxed/simple;
	bh=DocwIzzQ5wBeN4xD6DyicKZSx92N2jdvtJGNRpTBFno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3fS1gw79+L3B24GFjIdXVwhNZ7c3rxyEzEu/IBh3vt8Uy0BlXx97Z4CCq2vpSLZjK82bf0Pe+LHzw2z7VBIKFAy8SQm6IgzElG6xRWxg1GsGrx37/7vi2Pl5E436pGE8s9uf40srorUH2uBqbzOSHGmGal4goPsEisrFYLI1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M4d9twqB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M4d9twqB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f3e2b4eceso77861245ad.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739187508; x=1739792308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DocwIzzQ5wBeN4xD6DyicKZSx92N2jdvtJGNRpTBFno=;
        b=M4d9twqB8cfd8WvQWSIC1jqEZv5ZLq7bCgBYrRESSgZ7AXWRd6eYHZk4Mlp0S7kUIi
         lIkUIgsUIIe0BV5n9NA9fbo/GAiubTZt+Ky8QCyLW25+erAQMY8Z1Re0hDjuYKATbneB
         y7DOPz/o9doJibxH5nMolACq6pczzbg8Q8vu+SUBw6qj0agdAkrfIhyFtSCwmgH4bWkv
         sq3RLTsKI8F4tHlNBmhAolI0L8aaC9tMAuRapFd9Rwn4Jly+qDCg0aiAoedarbXXvkMF
         /ZBQB07HMHKjAnPG8LnYQWLkbTNafNSNtYc7jNfb8EOv3D4XPCSAiQ+0F4dsfoJ/soh6
         Ueaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739187508; x=1739792308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DocwIzzQ5wBeN4xD6DyicKZSx92N2jdvtJGNRpTBFno=;
        b=AXAAlLM/6LrLQ2m5dwhdtw366hQFF+a7Ya3gWVpu/y0NBMAYgdjvHgkD0l0c36VNUN
         7hepnDqK9ThS5dfgonnuY03BcwYjODFJiUXAdALcric/rdg4kquiBCG4CsK+vFiDLtTL
         LHzPeloUsEIP5k6eFGudnunYvOcb4qqk3m/g6B9l5DHmZTYag8ZHfbvin8qKwiEKY0Uz
         ZQCt5o1vhVbgyfNeDfpNM8b79rchqFntR1gqlXbv7RPpMw5bszykTrGpmp/GdSwdjanp
         QfbaS/E4CeUO/+HDvHsUkfpuEkcRjLsgln8m+lzOzi7dg6AExUfb7Q8bUZKrALXxGCbE
         0MAA==
X-Gm-Message-State: AOJu0YwS2h6dxQ3g8CZbbh2oZ7Bt2wM1ezMSFuiH4in0fYCtP4EA3oFa
	XjxwLlyQXO0Q8pEMYTu4n3RMtjDkq5jyisS2eSCVLeUE72IrEF1pojbMPxsljdCYaoAM4907JMW
	apVSv0A06dZD1YNiUadtZdD6rCskEmURDpA+J9kxhH3QBGOQSe4SV5Q==
X-Gm-Gg: ASbGncvYUO759/C3Jd3sEJfn6IytOiPwndoqeWiVugFVmZUy6zXMGF0bpN/oJWcRyPE
	wLehMeQMlAACDZpid94GItXOp34rnEWQFEA/ERiz0lJCiqlc210OiWWnvc0dwj9txGh13gaKKMw
	==
X-Google-Smtp-Source: AGHT+IFrmyjS3fER0bihrzlOHgI6qWCQqxH7x5Ml3mw4NZXS5xH9TSCvzeHrfxo1meMpXw8T8ALKXvtb/zW6IrG26Gs=
X-Received: by 2002:a17:903:1250:b0:216:4016:5aea with SMTP id
 d9443c01a7336-21f4e7059damr218821285ad.29.1739187508468; Mon, 10 Feb 2025
 03:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz>
In-Reply-To: <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz>
From: Han Young <hanyang.tony@bytedance.com>
Date: Mon, 10 Feb 2025 19:38:17 +0800
X-Gm-Features: AWEUYZnGbhrH--6neGpap_UppcJHR5rR4SCOyhwd-OeVZiiMTsUFt4AfnPwobH4
Message-ID: <CAG1j3zH1xngk0NZUjHA9Akx526yfEiQ=KsdfyRjE9XAewWV=Sg@mail.gmail.com>
Subject: Re: [External] [RFC PATCH resend] builtin/repack: Honor --keep-pack
 and .keep when repacking promisor objects
To: =?UTF-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 6:12=E2=80=AFPM Tom=C3=A1=C5=A1 Trnka <trnka@scm.co=
m> wrote:
>
> git-repack currently does not pass --keep-pack or --honor-pack-keep to
> the git-pack-objects handling promisor packs. This means that settings
> like gc.bigPackThreshold are completely ignored for promisor packs.
>
> The simple fix is to just copy the keep-pack logic into
> repack_promisor_objects(), although this could possibly be improved by
> making prepare_pack_objects() handle it instead.
>

We repack promisor packs by reading all the objects in promisor packs
(in repack.c), and send them to pack-objects. pack-objects then write a
single pack containing all the promisor objects. The actual old promisor
pack deletion happens in repack.c

So just simply copying the keep-pack logic to repack_promisor_objects()
does not prevent the keep promisor packs from being repacked.

One way to achieve what you wanted would be to filter the keep packs
in repack_promisor_objects's for_each_packed_object().

Thanks.
