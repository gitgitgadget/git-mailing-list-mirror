Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C252270ED2
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932182; cv=none; b=EWT6cyOBqse2V5CzAYqXl7nDsJTCc2Zxmgi84QmZE6uAW3D6YICQ/cZf2TqbZMAYW4UGi03rXzhCSEBTPcmr2y2h1G8HhgrojmY/z9AQ2Lk2Azq+u9NlwyDxhnXyptJX1Gejb2R1brs7g3uxTtML5FfnupwTLO11/sQl0yj9bUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932182; c=relaxed/simple;
	bh=pqtfnArxWcdXkRtyM+/EmffyYGGmQKlevAbcmdvxyRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3tB+s32Q4gq//irBwXj77wu0bAfaljMtz7/TnOugRAiWaQ0M6kU+55iiCmqvwaCX6c+mVxU3oZdrKBdCi0J8a97JqEzjTKmKkKfhIgL0a73Hfl6bwka7MGb4UPbShqbMkP0wZjy2vIPoMZKZfZr4vDp9L/O+leZrPbMfpyCYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx6GnK6w; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx6GnK6w"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so659013a12.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 23:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762932179; x=1763536979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X3Z7txrCvG0uHXhJVhJeCltLUFxAcYsarIfJCMhFzU=;
        b=Gx6GnK6w2Szm+0qu+37KoK40JSoTk5uqGR37QDarQ9bVXRp2MIxpeeKBJKFP4+ovFz
         kmApJrO6bfVKwdOE8lDDV17GCgtzTAgMQAUvOCliHre7EUvL7F9JpSegDVO2HUEn7drq
         KUVwx2nsPfAjv5EknS8WPCTmABPhGHhhMUUan8sz3y24qU1GUEjglgfg7kym1NDTKhEC
         8mqiDoXh2/7Bo50yRAPZjSf4L7uokEyDk6usvWRPd7DMvrUyrP2XRsUEAVCxx1r3okK8
         6F6iNK7/cjcLpmeu9frseHvYy6eedZQXfJGjgosUNsxsC3AVMfsBms0N8sOGSgA7oEhz
         xajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762932179; x=1763536979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/X3Z7txrCvG0uHXhJVhJeCltLUFxAcYsarIfJCMhFzU=;
        b=sm36DxEUBK5mzRXZScTjYYcyUI04QMIVRYkwHc0oeaMDQLXa9CuC4QPVtOLpe9TTI7
         mpvM1D0KWsqb1aK3ODpdrtvcbvD31iGVT6IbLIgPfYW3kSU9GC42ixAn/HEvRcev86Ma
         jzc+Ew2SWO7T944lsvkeY6cVprsJd6osYu3Xo3XXEleRtfGBeLlq0fH7LMalY2TMIAHz
         HwJJERlqAxkHguUY3NpEknx6y4bU/SfjLOEtuVHmJtkbvbFfCoRKMaFzuF1f/q9FbCkK
         LhkLeELTinB8EKJ09MXuIAn9YnEuxUKUEGVhpwe3fvgnfS90ESfaLapWdN095XoL71n5
         70Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUoS+aDI/McIuYDvJSGrcXNeHbU+LWxUrbuc7lKSYxC3OM0g5/j/qmnKsO/AZq/81TzOGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrTTJbOWKR1Maj69f35FDMysYFWlgGVV0yRnMjAFIoYDydAU8
	xq6DP3ByNuDlR75ikyddPCGKdzq8vM9XC9mdRENZfiybW0Z4XI0OaYRhEElnvfJgbGMPcS6mPqZ
	2/IDObRKTtQiHkoC+BhYPOwvG0F4fS+4=
X-Gm-Gg: ASbGnctmje6KT1bn8398WSJAN8orPek7VmrnfJ1ceuGd56Ck6dCHB8nIv9Re6NskLd8
	SV/mroa4zMaJJSsGAca0LJyDKndtUogRRjTcydH24Vd6nB4xJkrvU++ine5uj8Ld+ukNTQ6dwDb
	Cd4QOSY+ErwbKuDZ2JdJki9fiaYJ+uxcqanaUzVNN2/SwNjrF8cQzF/tlje2929R2MVjtSz5Bp1
	ABbriuqpNeby48+651Aa+njZGmgL+fgwMwZKUwL9u4PT7Wywzl6ODwU30xY
X-Google-Smtp-Source: AGHT+IEjUbFOEdBVniEjULwIKcEtsYS0B1keKaQX5kkDTuufw5dCl26DiiCYv+2ia4TlyWsmiCcYqvoc9PSkeP08Jow=
X-Received: by 2002:a05:6402:5194:b0:643:c8b:8d30 with SMTP id
 4fb4d7f45d1cf-6431a55e3e9mr1491837a12.30.1762932178471; Tue, 11 Nov 2025
 23:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105061918.3688870-1-christian.couder@gmail.com>
 <xmqqjz04mtji.fsf@gitster.g> <CABPp-BFWem8iWFQn0Sq7JhHigm7rZsa81D6r7zbsQSh3+ZH91Q@mail.gmail.com>
In-Reply-To: <CABPp-BFWem8iWFQn0Sq7JhHigm7rZsa81D6r7zbsQSh3+ZH91Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Nov 2025 08:22:46 +0100
X-Gm-Features: AWmQ_blw-ZN29Sh_hzEDS_uFTd_5r6gxq6qqqC6Siz5oYWEoOjfmqAxa6q6-bns
Message-ID: <CAP8UFD10yqwmdDEbkq19ANtgxfG93_Mcw7tK50Ouyu-G7MwGWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 1:35=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:

> Good questions.  Let me step back and perhaps motivate the change a bit:
>
> There's a fairly significant chunk of `git filter-repo` users who also
> have git histories with commit or tag signatures in their history.
> They often want to specify rules for rewriting history which happen to
> only affect "recent" commits.  While they could try to specify commit
> ranges corresponding to "recent" commits, they worry about getting it
> wrong and want to just automatically rewrite everything, expecting
> older commit signatures to be untouched (since the modification rules
> didn't need to modify older commits), and get new commit OIDs starting
> with the first commit that was modified by one of the rewrite rules.
> Unfortunately, when fast-export exports history, it does so without
> signatures, and thus they get every commit rewritten, not just the
> recent history.
>
> Christian's previous series allows us to have fast-export also export
> the signatures, but then we run into the problem of determining
> whether those signatures are still valid and what to do if they
> aren't.  This series attempts to help us determine if they are valid,
> and implements one choice when they aren't (strip), in addition to one
> that the previous series implemented (keep-it-anyway), while leaving
> another (re-sign) for future work.

Thanks for a great description of the context motivating this series.

> So, yeah, I'd presume this mode would have to assume the user had all
> the necessary public keys in order for fast-import to be able to check
> validity.  Perhaps that is a tall order for a small percentage of
> repos out there, but for them, is there any good alternative?
>
> As far as signature handling goes:
>   * Since fast-export doesn't know what changes filter-repo may make
> to the stream, it can't know whether the signatures will still be
> valid
>   * Since filter-repo doesn't know what history canonicalizations
> fast-export performed (and it performs a few), it can't know whether
> the signatures will still be valid
>   * Therefore, fast-import is the only process in the pipeline that
> can know whether a specified signature remains valid

I agree with this analysis.

> I guess one alternative would be having fast-export include for any
> signed commit, what that signed commit's OID would have been had it
> been unsigned.  That would allow fast-import to check what the commit
> OID would be without the signature, and if it matches, then just keep
> the signature without checking whether it's actually valid.  It'd be a
> change to the fast-export & fast-import format to get such an extra
> piece of data, but perhaps that would be a preferable strategy?

It would be a different strategy. Perhaps useful for some people, but
I think it could have drawbacks.

For example since signatures are not checked at export time, it's
possible that some invalid signatures at export time would still be
imported back. Also what if the signature becomes invalid between
export and import times because for example some keys are revoked?

If invalid signatures can actually be imported, then a name like
'strip-if-invalid' could be deceptive, so such a strategy should
probably have a different name.

> It's
> the only alternative I can think of to what Christian is doing here;
> am I missing others?

I think what I am implementing is what most people would expect. So I
think it's worth implementing even if in some cases another strategy
might be better.
