Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63E253358
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169515; cv=none; b=uNXzXtUs46HKCg7bjXR/kwbhBXOOlZuPbbXJUtTRB2ieKj0+0lvMVEsChYn8m8O7YXWWKk9PyW1Hqv64XLBGs+t5kelhenskKhVC7BeQdiyBxRxrb0BizTULMqkVYNlznrCfcHvL4Eq8o2MGomz3PPcZv8uYQzlubtsbO8d48+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169515; c=relaxed/simple;
	bh=mXUVsPW3VZu0eEuvAdk67ZBLX6VHutFvTZ50r41DYbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNTiW6usPsbWelHMxema2F4QH7ThI49OMTzRQeUIXruykEOrRpVRcm9WUEDYONlmzBqg6qda/19kzX2Z1zmljhQyCuy5zCuBm68rxZV1p6wjTPI3qp5GclplA1IuQYInxxRTjqIjHiPjKoCuAmvDG0FW+5V6fiFIQvn/ux3pdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/YITwg2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/YITwg2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so4503893a12.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 12:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169512; x=1740774312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IupgRh9JsSphGLhSwYA2QNOdbHvsNalDPi1IAmNKt80=;
        b=l/YITwg2B/e6+JCAbUXZLy2QYPBD0N50AMiT0AI8iR1eskSeupayfqRehBUUVxPN9n
         Oaw54VVwr9QP3X4Qh2DV+IwILZcOyQttQdYFF1lPEw93LNg1iXj0bt1KFefPWYPFEA49
         iZPsXWqfsR2z2SC5pxYwowNGrQ1duqhcdnMlPo7gVBSHBBd0xkEtgVo1c2p/y4hRCewF
         dCvkJ/g8u5FOphF2LIksqCZNGmWmS8Kz+piM9Z5BKm8/WO/0O7Ofcp/dCI8sqhvBrO02
         d+9jbFf6bhc7iDkHqO2hBfY+iBKdYrK/KFGQfslS74fIV3eUTa0a7rRc/7q+8f/kjcnY
         3JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169512; x=1740774312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IupgRh9JsSphGLhSwYA2QNOdbHvsNalDPi1IAmNKt80=;
        b=DFd1co05VcgRKs+R9N2Da3b9Lc10JQDNLf5KdQJt8W1/cCADJcCQzJ+p1LuC5sBxyK
         HvQylBxEg4XtG+13jbmZZXg8J5Qa8A4JS3R90QeeDd8guOWWXII/nL+MXfy38xPmSoxl
         1/xcb4biYQeUBz1+JGMgSFwOvjNnK85E/jw0h2PPwFBTP4GcfFviIiY3uay+dxn6v7ZN
         ke0shnwtzolw/BpQ1bkEmLRf+YzKzz5i/lxizJADQbF5HodChkAowZjSRBEv0Lf2V+9O
         EU/sZDTCwJTeHD3Nyz7QSel0J+fXfnh2FW9rxJBIIvZg4SSPwmBe2Sfz0RdbvennRdO1
         qvtQ==
X-Gm-Message-State: AOJu0Yypiycf3YSzakEZchuXqZT3NA++6dys48jE3ZFiT1pj1X0I5v2y
	ggjXnSK9b2V4QMGchNxJfoNqAY1dzpGcKs/tZD3vFBWpUXlQKcaiZ7fKD10gjZHkQk8Bi7lBAf1
	+7I8PslBj1Zetz8drcDqTpJJZ7N84WiJS
X-Gm-Gg: ASbGncvV7gcgh2zgUL7LQcFB7Y7xK6m4JurfdkhOeL6o1tglPXvdc7Q6ZM10ddmbURt
	6CPgf5o+VEgH5YjfhA7k52ckdpeYtRLlbMY/r82sAQiZ7PdJue9KRhvgUNlovdozwu7O4MH2zZ4
	vBISh8mm5gUw==
X-Google-Smtp-Source: AGHT+IFHXrxYXwAr/Dgs2ZQ+KeEwgcxLRmp+ze4FNpl8TXPS516fvZkXXQT/RxsRYc+OWHB3dNWxUKMIAEMualUmKfg=
X-Received: by 2002:a05:6402:3491:b0:5de:5e08:babd with SMTP id
 4fb4d7f45d1cf-5e0a12b9c7amr9054784a12.11.1740169510865; Fri, 21 Feb 2025
 12:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
 <CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
 <xmqqikp4ctoh.fsf@gitster.g> <xmqqa5agcbx6.fsf@gitster.g> <CAP8UFD3XVgJCc2Qa3wWZA54fg38jcpyiDtQOPNc8UQT9uL3vWg@mail.gmail.com>
 <xmqqcyfbb35h.fsf@gitster.g>
In-Reply-To: <xmqqcyfbb35h.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 21 Feb 2025 21:24:59 +0100
X-Gm-Features: AWEUYZkVNU-ZaXaGaLH4_B7DIbDS9CwyvxTQMJStRIznfMVLPQ4mU-GlVycE4X0
Message-ID: <CAP8UFD3EpwK3edfBfqRWmcncRFG--Q-yHR=K1wZnDHJs56ZipA@mail.gmail.com>
Subject: Re: first bisection step takes quite a while
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Yeah, it seems to me that in practice this is a bit like bisecting on
> > the first parents first. It would be nice if we had added an option to
> > bisect on the first parents first, so that we could compare your
> > improvement and that option.
>
> Unless you are talking about something entirely different, I am
> afraid you are confused.  We added first-parent bisection in mid
> 2020.

Yeah, I know that. But I don't think there is a mode which performs
first-parent bisection first and then continues bisecting normally (so
not only on the first parents). That's why I called it an option that
does "first parents first" and not just "first parent".

> And the first-parent bisection does make things easy, by making it
> totally unnecessary to call the "truly stupid" count_distance() at
> all.  We can pretend as if we have a single-strand-of-pearls, give
> the "good" end of the history "1" as its weight, its direct
> descendant (and there is only one direct descendant when we are
> doing first-parent bisection, since there always is only one active
> "bad" end of the range in our bisection session) "2" as its weight,
> and so on.  The commit that gets N/2 weight is the midway and we
> need O(N) computation.

Yeah, that's why a mode that does first parent bisection and then
continues to bisect normally would likely perform well. Because when
first-parent bisection is done, then hopefully the set of commits to
bisect has been reduced enough that further bisection is fast.

> Unfortunatly Uwe's original problem description was not about
> first-parent bisection being slow.
>
> >>  * The "this is good enough" logic currently allows us to be within
> >>    0.1% of the real halfway point.  Until the candidate set becomes
> >>    small enough, we could loosen the criteria to allow larger, say
> >>    3%, slack.  This code is written but not enabled (with "0 &&").
> >
> > If we want to do this, I think we could loosen the criteria even if
> > the candidate set is small. Weights are integers so when the number of
> > candidates is around 33 or less, a 3% criteria will mean an exact
> > match. Then the last 5 steps or so (as 2^5 =3D 32) would still be
> > performed in the same way (with an exact match).
>
> The above follows the same reasoning why we chose "division by 1024"
> in the first place.  The illustration patch postulates that we could
> be way more aggressive than 0.1% while the set is large by dividing
> 64, without wanting to loosen the criteria near the end of the
> bisection session when the remaining set is reasonably small like
> 1000 commits.  So we cannot rely on integer division truncating.

The code you posted above uses 10000 as the threshold, not 1000:

10000 < nr && abs(diff) < nr / 64) || abs(diff) < nr / 1024)

10000 is between 2^14 and 2^13. This means that the last 13 to 14
bisection steps likely don't benefit from the "way more aggressive"
criteria of 3% vs 0.1%. I know that the last steps are the fastest as
there are fewer commits to take into account, but still it seems to me
that we could make all the steps (except the last 5 or so because then
the criteria change likely doesn't change anything) benefit.

You say that we cannot rely on integer division truncation, but when
comparing integers, we could be careful enough so that there is no
difference between comparing them to a truncated number versus
comparing them to the same number not truncated. So I think we could
be able to rely on integer division.

So maybe just something like:

criteria =3D user_priority_is_bisect_speed ? 64 : 1024;
if (abs(diff) <=3D nr / criteria)
     return 1;

Thanks for working on this.
