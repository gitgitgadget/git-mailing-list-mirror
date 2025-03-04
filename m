Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA8209F5D
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125192; cv=none; b=iOM4QI8wRaYTyCJuNNXrNgg2Rad8bX8UdiqkEW6KlsjrkEhKvSQOOgTen9/fdTmfoDfgud7N9DXe3BTaeQuQmoo5C6USoo9k1MNDOr1z9dgpmLvdBEo1nIykUgs6WWjoqMFBrdkSa9xAzHJVzvupfvWvqdqYfN4EFTIw+ROjFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125192; c=relaxed/simple;
	bh=N2sWwZrUKYY8yvCoTXz45z3x28iALOJTqB2VfF1VXPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXt4lM2PDC6/5+H4WiRubJz1TW/fvtCbp/n2GSHaI9z7cU7YHIh2Be4tbJraEwWgtj7oY3sKJzji2JoAtufKKf5evWX+BUiGRBw3XQiGh13L6kd3wWHCVAs6ZArWV4uqlci43iwAdPuzocjC2VafIynz4p3+H/aQD2l780cY6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGjxaUEI; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGjxaUEI"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85afcb0c18fso22255439f.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 13:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741125189; x=1741729989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvuu3oaJmD9cpcVTa7hvHZZNKXhhimolZMNiNOUbwm8=;
        b=KGjxaUEIgvPXpxeza7PY31mxPT4GgeVtmcXNBxvpk7pyXxJD55zF4t27AVnOBHy6FY
         9DZAmFe5WK8/16n4TUDrQcW/Qxo3HwVjFC3E+/nZzpsRwwyfUZ7r6JIBrbIebIU8XDWa
         f2rWcXqn5TcaTCt1YaOBKGJNek5bdJ3OmTkToEKiWv/Miv/KEb2uAeNCK4CVZjGMNrmJ
         rwdAlFH7Pj+BWiaoDxiGbzqxIm4TlNw7xBe1XOtQ1+Bc0miXxQaCYvZPNFh4ySiMxxfu
         r4s452QvRMprZfaaE9Iug0ApBcJcQT4FrMdpjiX+04ZGpWYJFc5clb6RFxqju7IJOMdD
         /9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125189; x=1741729989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hvuu3oaJmD9cpcVTa7hvHZZNKXhhimolZMNiNOUbwm8=;
        b=r+6xbGbLM/uFEjCptdgFO6omi5DIuJOgahDtxrQes9cfnXvtkiHG+GZpNQqkXGi0IQ
         0HBXkc8NdnH92RSqiBylEUFURAMrb6rZy6smL9cGfN1yzxAwbdhtQVjpFhbigNf+Klmx
         g8bBOHVWPo8kX+CVqMGAnk4NC5HdPsRsbo6phIq/F3KaCeDtRLC0I5g8neiN2Mu4L4pV
         x5s1A4iq2/ozZ0Yl54QCJLUuLz7XVWcgiwiMrUEEQYooVX4+spz3qDiCjKmF/icZlHhr
         F3ha2HBEz47tMLA0nsy9hSxftigjDgAq9kIOrGxYhq2d1OxTLhuHIj6HRlcCd+MFxaOW
         9sDg==
X-Forwarded-Encrypted: i=1; AJvYcCWtVPOCyKME/BuCXjzJvGmmeOzm4nurx8uZ464V9O1ghIhqFK/79J89m0cbmuHkQQarJYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKMbQzuLAymkFFt8PxkO/xar0FToG6kAPdiWo7eyosbJBCWXU
	fxn4FFQy0HyCO1AybdhaEFAqfx4IR4XLP5vFytJ9wueopD4brp6hp6vfuuSfF3Nz2SaAnooKYnY
	UPnxrAUGZ4k5OrscnDQP+8OnDSTw=
X-Gm-Gg: ASbGncvf5KwqUmEjQIn5j+F7U9yvmcpZjyM7CEit6IsQEzAhYMCKMPbn+dT93iTAsCf
	2qpA0CBvhtMLwXtHk1tmXCAcGoq+oDgOv+Y6oWtquVp3AR9Ao1XdoPp2YMheoybrfWbngqVpQoA
	acF99zKGJla0yhL5ozfJsJBRdvfbj8o05sNMVxcSfi5f5+GcYVuhZFpHtL
X-Google-Smtp-Source: AGHT+IH7sYhtoYgYR8zYLpzklmZ9yWAOXEFy4zHE5usHnnoxIJe9MUqSUlGM902HFMXonWujVvi7jys4TDP7ZZzmRhQ=
X-Received: by 2002:a05:6e02:12e5:b0:3d0:4700:db0f with SMTP id
 e9e14a558f8ab-3d42b8cf100mr10596875ab.12.1741125189452; Tue, 04 Mar 2025
 13:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740680964.git.me@ttaylorr.com> <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
 <Z8FrIfAj_oVwxz3X@pks.im>
In-Reply-To: <Z8FrIfAj_oVwxz3X@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 4 Mar 2025 13:52:58 -0800
X-Gm-Features: AQ5f1JqyEEgLdIPVVRRc26p-YNJijx7jZo0AoIkqHGwazkrK5hUBPJ4l-XOCCn8
Message-ID: <CABPp-BGnbQdeSC=XUwTWOnr8=PiGMnt1Q0OXkUAzD=ZiaZoUhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/repack.c: simplify cruft pack aggregation
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:52=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Feb 27, 2025 at 01:29:28PM -0500, Taylor Blau wrote:
> > In 37dc6d8104 (builtin/repack.c: implement support for
> > `--max-cruft-size`, 2023-10-02), 'git repack' built on support for
> > multiple cruft packs in Git by instructing 'git pack-objects --cruft'
> > how to aggregate smaller cruft packs up to the provided threshold.
> >
> > The implementation in 37dc6d8104 worked something like the following
> > pseudo-code:
> >
> >     total_size =3D 0;
> >
> >     for (p in cruft packs) {
> >       if (p->pack_size + total_size < max_size) {
> >         total_size +=3D p->pack_size;
> >         collapse(p)
> >       } else {
> >         retain(p);
> >       }
> >     }
> >
> > The original idea behind this approach was that smaller cruft packs
> > would get combined together until the sum of their sizes was no larger
> > than the given max pack size.
> >
> > There is a much simpler way to achieve this, however, which is to simpl=
y
> > combine *all* cruft packs which are smaller than the threshold,
> > regardless of what their sum is. With '--max-pack-size', 'pack-objects'
> > will split out the resulting pack into individual pack(s) if necessary
> > to ensure that the written pack(s) are each no larger than the provided
> > threshold.
>
> Hm. So the result would be a new set of packfiles where each of them is
> smaller than the threshold, right?

Are you assuming there's only one threshold, or that --max-pack-size
=3D=3D --max-cruft-size?

I read this assuming --max-pack-size >> --max-cruft-size, so the odds
that the N packs smaller than --max-cruft-size add up to more than
--max-pack-size is small -- but even if it does happen, it just
results in the cruft packs being split out into a couple packs.

> Wouldn't that mean that the next time
> we'll again do the same thing and try to combine the new set of cruft
> packs into one, and basically never arrive at a state where we don't
> touch the cruft packs anymore?

This would be a risk if we allow --max-cruft-size to approach or be
equal to --max-pack-size.  (And if --max-pack-size is less than
--max-cruft-size, then we'll perversely split into even more cruft
packs rather than combining as intended.)
