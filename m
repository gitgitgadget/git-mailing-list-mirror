Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E11CDFD4
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216161; cv=none; b=myy4/wTbAy34Z5jQ0avb/lqV1xbZyTADKGuClYUaD4yBAsYqzHrlOwsOXsJkfpfv9ghQvfFk5d9x2iDyA/nWYCBlYWABcT6r0pQWfe96nI2UO7CS3i7isPXF2GV5VABKn+Hp4Uo7oc9XLPXp7LwiDM8CasqTtJ4I7ZQKNKtqoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216161; c=relaxed/simple;
	bh=2X880G6cEN7YUmDowIZDMzrB27ac/1B1jKAG4dMTxoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETzTt3CfOzmy9p2YrkrWQJ2cjRH7Ia/kwBsUDnvUGi5PyYuco5HhKPcBtfJ899uJXj7FlsFDWj4FpXBJ4+TQ1hzno/DjEje2SkVvdev/FHnCJQ//732vCRy1hyfSw6oP+HQuQOOAFRYr7CTbMS9Yh+0yCMmXw4LZIqmTlfmBdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evQP47PN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evQP47PN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54b0d638e86so8385872e87.1
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744216156; x=1744820956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS8OlPvrPP2VnwATfBKkyuKrP3OL0RjRq2fZxJgvk6w=;
        b=evQP47PNfmuHLWHrTthqn2TdLcG4fPEFi5gHpBSRCjXUgvFJXg51i6JeXOI5f1y1a2
         RPrK2hzPeRJ4mPA1iacps2kGo9NshfViC3oRyk3v80rUwqaEd0BxWmt4scre4oZOOJRm
         zAHOC/N2GLk0wWFGaML9mxaSKPsr97MMLXfazVcrGLNwuArT9h+BAwC75mEiyEEtfpI5
         T97gdoTiaN9iwxXXG5JMluk1ng0MjR3ZmQ0UPkOCZcMqU8jMMGTe7q4quW/d6ZFT8mKz
         WpP0OGQQCjvGMp7LCQyI+tKDFCaN2xbntRMD38iSNzNjmJdqX9OnNkCeYuhxfFeRnFfZ
         EnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216156; x=1744820956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uS8OlPvrPP2VnwATfBKkyuKrP3OL0RjRq2fZxJgvk6w=;
        b=K3R4cc6nUnCDPdqLV7eUWDqAuCFhcIYB9h6Aw5wLSBk/NxDxlvU+ik+VcFYQpHM/4j
         OQ7/Rh4UZMrq96cvdRDuzb9927EvRyV6J5lDRJA/4c7Gth93POPjVn8MhRg8OwPIHGuG
         L+e+SrQhXRHNNz24ldk2WLmOenq8G67uv2BcnJPNk1xzOrBz3UVeGVpJb3tx8hRBZth8
         uOjGgXq+i3CjRiHrf+aXQ98hTYkDmyaXZnAPKwxgApQ6pqhaIa6Zzo/DmsJoutRyaIR0
         jctQnTaiaSBHzXD5a+TD/bFhvT4qvjueWPBhaVMxSEIPc3O5BqIQfYb9F/03BVZzzNIi
         OCeA==
X-Gm-Message-State: AOJu0YxoJO8y3phfg5ewEvXtqylBmVS9afbp31yXctL21WWyJ0Y2LK3z
	sa0khHNpfVgpR8Ya0kHWYLqGifTgzrmVeVaxJ4tx/5Ai7s+A6khWpOSTy3zHxQUH8TZexKSa/1l
	DjsarGlvAILdJbVU9YNlGCpBB9Mhn52gvoUA=
X-Gm-Gg: ASbGncvT/dn0y3IV7sdQKc7eS8WbqWwI+y5cs8h1XX+IvFktyWOzyhxZGB/75Z733eA
	tUglFRCWV3MpPmziazUXUtVJc4HOTAp8/yE/pRMq/rUQimXWZKhzg4iEntwiHb1NoGmO36LlDfD
	b7WC3Y2lRraMf8tgL+O7nTHJ8IMojhP6LL47fypjLqWDGQiOdUWOwZG3k=
X-Google-Smtp-Source: AGHT+IHitViQhkZ4j1zELwaePn4YRuJUbknp/mOugxsPoX893wZiKYWJtILk3xnnV01t1P2XbhMG8M/pNjD+pap3hwI=
X-Received: by 2002:a05:6512:3c90:b0:545:c33:4099 with SMTP id
 2adb3069b0e04-54c444ff18fmr1016579e87.27.1744216156070; Wed, 09 Apr 2025
 09:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403144852.19153-1-sn03.general@gmail.com> <CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com>
In-Reply-To: <CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com>
From: Subhaditya Nath <sn03.general@gmail.com>
Date: Wed, 9 Apr 2025 21:59:04 +0530
X-Gm-Features: ATxdqUHCDm_aqN_VWRiw2O_hb6JF3Wy4WQmQ7fJsM54cGra6dEs5E46JXQFoU5I
Message-ID: <CAPHxB8un1w-NBnfLne9d=vv9Sqa69eGoLhjOM0GcmhgkYKt-PA@mail.gmail.com>
Subject: Re: [PATCH] t7422: remove extraneous argument to printf
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:35=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> [...] for the sake of consistency and to match the author's original
> intent, it may make more sense to retain the argument to printf and
> instead employ `%d`.

I see.

The problem is, there are multiple ways the printf statement could be
written -

1)      printf "[submodule \"sm-$i\"]\npath =3D recursive-submodule-path-$i=
\n"
2)      printf "[submodule \"sm-$i\"]\npath =3D
recursive-submodule-path-%d\n" "$i"
3)      printf "[submodule \"sm-%d\"]\npath =3D
recursive-submodule-path-$i\n" "$i"
4)      printf "[submodule \"sm-%d\"]\npath =3D
recursive-submodule-path-%d\n" "$i" "$i"

Which one of these is to be used?
I shall update the patch with the approach that is decided upon.


Respectfully,
S.


P.S. Sorry for the delay in replying. I got caught up in something...
