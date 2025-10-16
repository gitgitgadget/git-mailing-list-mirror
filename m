Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92832580FF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647729; cv=none; b=cjGKBlxO3zJ7B5Pr1Kl5E5rL2aRCPjYWQoDA17BDzycgAkb05Yzrgy0E2Tt7HDvlA3/1oE5iIhGKNfgUu6Tq0LWtdtE1zPbS72uPkyZY5FigbGvdn8sLDGKidw0fMGb6vFBLJNjn51MsiRSZJcwSxvfqjtaPaNqRKf51Segbqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647729; c=relaxed/simple;
	bh=dw5m3U2qrl6lkW4T6OqBZfXrROfjMpAl0XDSBq1ZOmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpQ0uAfOQcOOMiorPnSFc0SjnYkZyt/WnODP9UTV19gQtmzFWGVfxA+gRedRlC8g6Fw0Y1aPweTtzjcj8P0+rqrZVxN9n9r+HE7J2rc2MctRVmj5D5sZPMbj/59F5oYam7DiP78HpquO+dRibqWXI6XeGpCR4X85uvGt6WpuVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU1627YW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU1627YW"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-639e1e8c8c8so2287830a12.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647726; x=1761252526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y87xlyxCCU6SnqFSNFyMLMWqUQpWuVpVjWvcVfxJoq4=;
        b=JU1627YW7xz6b9ZoA9QGLcN+GvCmp08pPevK/seJu1B2PTDmuEl/LP8K52H92TUFo8
         fEGM9scYUDyT+FRMT9VO1P0VZVgfWio/KXVwueHcO3ybHjBw9hB30Fu+RUbX1L6300RM
         3Y7vCDu1BRrC4MjeowcV00+vwTJ20yAyULLj96Y/CK3TKXqUXGosw/CJ5sst1MYyVmye
         3OlYcAEXBRk3lSbgciaD6tcN35T6j7yH3ZfDbrz7FhXJRZ7gH5CF0mOk0hI29ZFNKMYY
         RnVmyu6m9gZQys5ZuEgOqHEfvlbFim7vKckkCP3uSuhseDk8YfcKceL0kFRHXRa5vzLh
         4KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647726; x=1761252526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y87xlyxCCU6SnqFSNFyMLMWqUQpWuVpVjWvcVfxJoq4=;
        b=RJjDyoHcXpeqErnxsxnB83vr1FaXDBXO6TILDyRmw1ZQVKuEq2PkX2XEmw+VybfUUL
         lAsSlQlSPOruYtX+8rhCg7dspnXAxM7P83uqpi0SCzfs3jz1pySLCw2+7wtgr/S8S8oh
         bbtHRNnlv6o4dyPwtSvZrEmAAeC5wyf8EUz0JskfYWBBkL0BsUKE+E1QciRm9DyzkQkL
         a49CIXt376s200HYtMi3GEHoGrEYdmgxc6tzxUDvIM0EFfFTiFkhss9bBay7bk0p/Z1x
         Yl+6yRTZSO2TjboQL9GvJ9Ue3IpG4W6kGJUG8BsQazeyWSdOiseb7/alOvD5KbIjn4/G
         u3HQ==
X-Gm-Message-State: AOJu0Ywu4+slmfnwft2rMp19HiDnVeDFk3HLDc8fheDC6ePFynuh+tLj
	48Wm1p6lP7t1aZBAH72kLoL3mLGNqHku8P605clUQzkyzqPO0ZPHBSF5IrZhLabdTDmZidFsqy4
	0EkDPsfAX7thQEBZaWSo/ZheMY3Xf528=
X-Gm-Gg: ASbGncsYHp1fGAFaVUPcOqL8Myi1aWivy4KTOu6bD9Qg+130UjkRWGSINfNddkEEJq0
	H1k2BhXH4twbOU0e268FNHEUlAKUXnMUj+cEc/PNqKEYlctewlLGYlRgWZxiaOvhVX9M1kY+ABO
	NJBcIdWUkDmUIoAozq6iQBpzSkKqGnotqUIVNXkjc3b1FSYjKivkgxrIJHKwHaREOBYjBzJolzR
	GdgXPQt9/nnlGIb8tn6z53e3U9BeNOqg0/6fMQei5QzprF41CfPC1VBROyRY35BHtYlFZhkWyhI
	A4zjfF6E4dONkrf+BQ==
X-Google-Smtp-Source: AGHT+IHr40VUAobollKSDmiNwrsc7vdO5YsxvcJmTi1dAhoc25HM8AX1kjrIxGtx04vx0++sGP6zVInKgrKVYo7sFBM=
X-Received: by 2002:a05:6402:1e95:b0:639:f253:aa21 with SMTP id
 4fb4d7f45d1cf-63c1f6c3db2mr1069744a12.29.1760647725856; Thu, 16 Oct 2025
 13:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
In-Reply-To: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Oct 2025 16:48:34 -0400
X-Gm-Features: AS18NWD5TmufvZ4uL2flOP-4K7J_5jg6rrEddW0WcrwJ5bzeNDQKFDxQIgKNifA
Message-ID: <CALnO6CBwuAdBFjESZSYZkChNdU9R17OXDc+CY=Z96QoACPgrpQ@mail.gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:39=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
> As an added benefit, this implementation gives more correct results. For
> example implementation in 'master' gives:

"More correct" is a bit of an oxymoron, no? It's either correct or it's not=
 :)

>
>     $ git log --max-count=3D1 --format=3D%H -- pkt-line.h
>     15df15fe07ef66b51302bb77e393f3c5502629de
>
>     $ git last-modified -- pkt-line.h
>     15df15fe07ef66b51302bb77e393f3c5502629de    pkt-line.h
>
>     $ git last-modified | grep pkt-line.h
>     5b49c1af03e600c286f63d9d9c9fb01403230b9f    pkt-line.h

It seems this commit is the merge to a maintenance branch, which was
authored and committed after the mainline merge but topologically we'd
probably consider it "earlier," at least starting from master? Anyway,
I'm not clear why this result was produced.

Thanks!

--=20
D. Ben Knoble
