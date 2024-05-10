Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D8D495F0
	for <git@vger.kernel.org>; Fri, 10 May 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370563; cv=none; b=Zo6heGmEtzlI+UWy+ziolgb9rKvecItetZdziDMaXjpherSb1cvelWEQQvclkOWKAtaXdmOkBRSgWixr962JnnN8OdfM9+i1pweVHMIx6kn2MwrJmKK/1LVb9gMPfYcdrd/biSlzeCCxaWAslC7CGRF2b6skq49c6BYfH1W7NYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370563; c=relaxed/simple;
	bh=Xxb+x/uTWw1frmf2VG0aozo7VqwKmi11cmO5sObYTEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTKBC0LJ2R0PlPZUxF6LJRPtiT8zkJh3xjfpGSBWAyP5O1ARnWus329vARkmJMAkobjaZ6b7TvL19QP0Eysk8rUm565FpB64n/NIb/vq8SVu/nI9+7BSB+jPj9QCt16fZXm2Qi3mGedpSM+fxxFvN2N5800XMM4/DRhXVYtqiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Drj8RXpa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Drj8RXpa"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-439b1c72676so5231cf.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715370561; x=1715975361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daSB4tuDCUwpC3Djw306kLbf/P3No6fOwV2vqsBdZjo=;
        b=Drj8RXpaUst94TPbWwC4jAb6WdcRHuacdk4yDiBKp0OCn+qsgU6k0J4mxhLyjWvGB+
         LhqsEAdR1NPIECcKg2M8daY+F/czfArpUSohdtLzTWPN3xPc1eYl6b3vYNuwwJxbzQEk
         QcVpTqcqqntoVMkdZf7CG3vs4OfeOc1/Hs63vC+dfzI5NucZ4somXmgN7JON148jBvcw
         9u34omXEyruTWAXHL8z3U+7/wPZiTXuZnKDcZOy1Agr4ppLxpYm+0VCpG6nqABIouQuK
         aD6zndh9Ftail9sPkAi9VirGxAK568ykE/heEjCug9G4xhJAtAYxWnSljZOtBZLBJRfJ
         VpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715370561; x=1715975361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daSB4tuDCUwpC3Djw306kLbf/P3No6fOwV2vqsBdZjo=;
        b=DJJo261akDCgoOR+UZl/926sjw1tCgYNuGuVxv01BAIrFVk0YRiORvX1OuAWjSjiOK
         K116ZJPm4QNWZTdDW7mDcKDtLh6Egb8swuu5jUQlZPvbaY+u3Q+586G67GpSQivTMa83
         Q1TEfIivfX2/XGDvmyEJUw/dSQIfe1IhsV58V+WsY2oCle06w3DOl1MYosB+K+kzDTLP
         gQwY5uk1H5K19U9pDC/9btBM0b15yxuQk/nrXffkTkp8o+p1qHqD0jYaxzks66vhOw+w
         B6V61wiA4rUJRFTW0DR5Q81n1HFU1dd9HswYrjDKpYG8BBBk08qx1uYEci6bCU0XQqWE
         RJQA==
X-Forwarded-Encrypted: i=1; AJvYcCVLRycw0BXv5kElsPJI+HdqFrWIxTU+0+DMeRYbxhqtCYUTUuUkllJBGpV2u3VxmYjZSnopSqFzq+vyJS6nJhhhK2ok
X-Gm-Message-State: AOJu0YwP/dIg7tbcvRHuZ9j9xLwCqgpVcWs/vrbdAIP7p/vHWJiVz922
	f4v/44Z150x+Gryl8g07En+gRMkO95Vk51GWMcFk/HFfII2llVX1zrrMtkAZnAw3PMJisXPwFyD
	8rXa94BkObF/JmzoP/CSIonAUT9GB4xr283SQ
X-Google-Smtp-Source: AGHT+IGYKfxaUZ7rJrJ6SpKNpMwJT0txKDrXkoMo8PqWnPJMsj78mnccfjG4w/2W1joGzHJ2tTkNIy5B9E/ZS6azvF8=
X-Received: by 2002:a05:622a:2587:b0:43d:a002:b with SMTP id
 d75a77b69052e-43e0967da35mr449301cf.9.1715370560671; Fri, 10 May 2024
 12:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510172243.3529851-1-emilyshaffer@google.com>
 <xmqqv83l4i86.fsf@gitster.g> <CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>
 <20240510194630.GB1954863@coredump.intra.peff.net>
In-Reply-To: <20240510194630.GB1954863@coredump.intra.peff.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 10 May 2024 12:49:06 -0700
Message-ID: <CAJoAoZkXTo69AiowTVFvKyZBCo2B73hPp2ys+oZyOLU5qxAgFw@mail.gmail.com>
Subject: Re: [PATCH] trace2: intercept all common signals
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:46=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, May 10, 2024 at 12:34:07PM -0700, Emily Shaffer wrote:
>
> > Yes, it is because test_must_fail expects "natural" death. You can
> > tell test_must_fail which signal you'd expect to receive, in theory,
> > but I didn't get it to work (and it will be tricky to provide the
> > correct signal in shell - I had originally hardcoded signal ints in
> > sh, but then moved the signal enum->int resolution into
> > helper/test-trace2.c because the alternative is doing some nasty
> > grepping on other shell utility outputs, since the signal codes aren't
> > platform/arch consistent).
>
> We have test_match_signal(). Unfortunately it's not integrated with
> test_expect_code(), so you have to do:
>
>   { thing_which_fails; OUT=3D$?; } &&
>   test_match_signal 15 "$OUT"

Right, what I meant above is that `15` isn't portable, I'd have to get
the correct int value of SIGINT/SIGSEGV from some other shell utility
at test time.

>
> See 5263e22cba (t7006: simplify exit-code checks for sigpipe tests,
> 2021-11-21) for an example.
>
> > I also wonder - do we want to capture SIGKILL as well? Some people may
> > have muscle memory for `kill -9` (I do, for better or worse) instead
> > of gentler `kill`. My intent was to notice any indication of user
> > frustration resulting in manual termination, which would include `kill
> > -9` too...
>
> You can't catch SIGKILL; its whole purpose is to be un-catchable.

Duh :') Thanks.

>
> -Peff
