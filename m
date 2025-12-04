Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497B334C0B
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849133; cv=none; b=NefO8BW8AP1/18znLsgln52W9jFpTe5PhkQiW10CLCaQXl3DtQSqBw9e6TRCyr4M/7ZrRihsz8jyXNHzEJtm4TEnyl9hUrKIaqzL9fLQKw+xyI/dgICFx/TgLYplaRzpZzDoS0R0Ng8YwqlJZZkFc1Mc5LgyubwLYO5sXOnjLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849133; c=relaxed/simple;
	bh=vWRJFO6L6FHxf6lmCDWqemcvQNvJBjXhC7Tq1osXCEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btS+iRtRMSqEZL73DSL3OuViXBUr67PqqtH40HfLq+gqRqOlFqufXwerCKee1bXfw2DlOtYmcac5/HVO/JVqHnmGHQxnlOwmiwy4KijOQDboEx4ier5pYPJkS5NynQjE571aRPs0aFoAOl1fjJQpV27sp38qMmk4Ul+AVHlp9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUnErWcX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUnErWcX"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so641105e87.3
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 03:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764849130; x=1765453930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOW6XeNbUs78kT8+JMapPDVnabb6YIjk8gYSAFqchKo=;
        b=KUnErWcXTVh50ixPeo0Fh8R9fGoxt8LnuPllm57gxeOYiEog1PpOCtBZSlgP6wxFpz
         HfySSxZCr1OOhCei5SWbKaY6HTQm7L2HI5sShaOOl+zn76sqFC6iKxOvA5hso1J+lQgE
         eL/FLGSXEXBw/bZD4ilkszeaHy+v7o3zgdAfxL1Xd1kZiWVhIWVT3dYIvGB1qZlI9jVC
         DRIOi0fpE2CHfzRi2v7rtFrV+yeGzI0R13umqXdFcLwjdCf1KhjlUptZTfGi4mC6USYY
         Ga12ZXujgtuUQbYbVCcRs0BwFGySTOvSmo8t85EHCqQ2rkYMhK2Q+7VGqtNc7brwcXyv
         Wx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764849130; x=1765453930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOW6XeNbUs78kT8+JMapPDVnabb6YIjk8gYSAFqchKo=;
        b=sc4xPMy2extW4CvCQgastTHb4Gb37ZPgynU5ljakZdBKUNTT9KlJnbgH3pTkz0fvKS
         Lmg1Or9yiniU9UCcJteX+f9tdBXqgFOfp5SLizIswFXYOQtmhgQswRDMbBB1FSzWlNbH
         O1A700EKN7/6YT+dQ7x5XPfcmqGH8iODcXvFeilnUDuAW0DZNzS/s3FyfMDVDe2naweQ
         VL6UoePw9r748d+BwY1XqGSIblEGfC96qtQEIJmSbv7vOK7bOn9vzy5dvmCQ+2m84ARE
         taW3GlFvUtMgX5K5JRQXUuKW8y++jycUpFQJJzNaMN0tZg8EmzUCrImM4Ssg2nZkJDtB
         oUjg==
X-Gm-Message-State: AOJu0YyQ+ZBTFhHl0wtQQjNsU1o/rY4xRL7fqWfZdpzfDWJl0xyowtT1
	kYFfCY55WmUN7Q4aCl4o+3CRoYixmTFXRhOBBpIyBqQ1Bgd3e2UPVt62NXopbGp32JdxCA5X+zO
	2LWzshDksunJ13R43qXu7cqvr6ORuNemP9pW5
X-Gm-Gg: ASbGncuQ4gOmcSllEaS8nZs0NbPxocNisjhtNI27hHeNT0k0/FhuOcZcWl1KIHlNHM7
	9gc+5cLsRFohPBy903E2UZZRdBhTUhLu4otfZ4w0/M2uVhShmTaB2UxrvwkRlEwbXaPw63nrbcF
	/YvjYUChxKJorfPW8RMkv5jwRfKGeA9KHjgT9SOg63d89Z14iGBEqFZeUBUhvlqHpCWJXuoCYIU
	g3+Ph7bmSIDrTLrl77IjwyKohs/YBUk2L5agVo+mFIfr4RiuI1BkLcoXChEsCbz35Rhp2Zb
X-Google-Smtp-Source: AGHT+IFK2yfLa48qZsSdN8dl/cRA8Sqwhq0XEH8OFjnPbhTBK1Lkrti15+2j1PoUo2kmduNUkNlgdpuuHFoP2aKRJdM=
X-Received: by 2002:a05:6512:a89:b0:594:3039:2d16 with SMTP id
 2adb3069b0e04-597d3fa5200mr2323815e87.32.1764849129918; Thu, 04 Dec 2025
 03:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de> <65c997a7-e480-4617-a761-fc9dc8a7b20d@web.de>
In-Reply-To: <65c997a7-e480-4617-a761-fc9dc8a7b20d@web.de>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 4 Dec 2025 03:51:57 -0800
X-Gm-Features: AWmQ_bn_x-s1zTNxuyxHmHn9BU7t_BF5eyYnlMxwCP3OeQequQWlxQ-_oq-d9fo
Message-ID: <CAPx1GvfAFLZz_SA+mBe7o8Cu4sL0_U5zzerhpev=sp4asEwcPw@mail.gmail.com>
Subject: Re: [PATCH 1/4] wrapper: add git_mkdtemp()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fairly trivial, but:

On Wed, Dec 3, 2025 at 2:52=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
> Extend git_mkstemps_mode() to optionally call mkdir(2) instead of
> open(2), then use that ability to create a mkdtemp(3) replacement,
> git_mkdtemp().  We'll start using it in the next commit.
[snip]
> -               fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> +               if (dir)
> +                       fd =3D mkdir(pattern, mode);
> +               else
> +                       fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, m=
ode);

mkdir() returns a success (0) / fail (-1) indication, rather than
a file descriptor, so this is kind of misleading.  I think a
comment mentioning it would suffice (but also be a good idea, lest
someone later think it needs a close() call).

Chris
