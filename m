Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CBE376
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919667; cv=none; b=sAovjVTM/bHdPPxZWraVNNW2mLorp9Vn4taICVLE9wjcW/DlEDwqM42WafUWd0OdE1JBZDPcCJf5upj3T5IuhOHfpqjzW32IwmoDieFoE//1KxWxTHCg6hY3tImoCSIIL73GGuwhevH5lkPv1qrltWIAbNzXoq8OInsrIYdT0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919667; c=relaxed/simple;
	bh=F1/B+bcjpN7G7r3/kU2MEWfqAu3gZdikXY9rDn4SQQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a60TQanytJg4Cy1zj15UdXWNd1BtAXyP2drxELQiZGLSIveFFgpZhBX+adZT1NqEwyL6PpWK6LsAXGtdxE6VO4+vwSzNw0IA7N4E7FN7MkhTuuDQOp72Zq793brJe/EIP2G05qQjIuT5ajDGo3SFC948cTk/Qjvfx06sl8rQ7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTsAMCeZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTsAMCeZ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b790dbb112so183174f8f.3
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753919664; x=1754524464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p1a5K+tFPNW4fPisaCOjSkSBfrzK5NSVXzFmGclqXQ=;
        b=iTsAMCeZ7RplAH5ea+Y24PxNZ9NrGzB6VrE4UkRdPPXvJ1yxOzpdNmsmShk9vQMwlr
         i8G5v9dWk1/ag6tpXIb6zMXE2DKM/ixohMzulSKVEb3DfegauZEVQMMBKRAdfUZaAcjd
         IhFwEwdbzi1ecrCwoHlaD+vtrbuo15nE5+i/lAjGr+xwsMlLibpvU+CMcpl2O8OWXdC+
         yJTImy5afEFUKEV7iL7IHx9+moSkBzs9+qwco52SQ5StuQxaQP9/yVXUbRSGRbUDzita
         rLCVDF1JKjqBJDvcQFom727wR0/+IMqtfy38d3N3eqJEA0lGde/0sfv65sOFzSqwIXks
         JbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753919664; x=1754524464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p1a5K+tFPNW4fPisaCOjSkSBfrzK5NSVXzFmGclqXQ=;
        b=YrSp7QWxUkJG9Wu4TmxGSiPr7SEN6lhFCRWj/kNTSpih/dF1ZUc2tsj8s9BgXBUBJp
         L6Kn0DB3oZ1jw76XRwxeiXHOKQtI4UH88m4hT295tl3MvhEiK7i+LTeHl/SsZkX7Tzmu
         glCyqSOJCkBNzKR+YtBiP1Lnochy45ipKJcE6jtNNgNdam+CCNXJ2lBo1KG+HVxlODUg
         KKA32O3Lqne1WJ0gbL4Za621TQJoLTSgMIo4fYznodIYZgZohQiLv4Kb0/zPxzlP49BS
         4sC08m7J3bpcCER4+loQFvZHFEQOl4GyXs6kE8nPLvWh9Vr4DG4KpNz0FmAcHbD796GM
         U2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU9MOrnV+0iBOICgd4wKs2NwWzppuGGCRL+RDxXSDDrFOEnFYiQ+2Lrpertcs3IEXND1IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuXny6UenEu0WPd2EcZYPCvZ3cmB6UnGkKxJdml3EHzv+MSchV
	8thSvuw56to157bBzjibFrv5+Es0YZznNWi8TDNeGv4l+4lHmauH+O491iZMNQp/RgUbjZP1X/P
	6sv/37TqIopkC/IaQJdMM3saG3jvgwhUFsg==
X-Gm-Gg: ASbGncv8dfj4Okg7VRW8/UjY18TkQt+bpqtI+g73qogo3ZiEJbuVRBQFfrLYBG3zn+s
	wekT39nYa5vjETLdw5BlfpVH7/wft4VcUfEHp7oMd4tdN6nIUjj1zOf98E/vHbHmyGq7+09BAMP
	N5Rn8KsIyeXQlUqeKhXelLlZmgNTLwI5bxEgwRIK1Z0YOeFk3NgqgwjmB1DqpoUT2itnj8t55p2
	hfu/ONIa8Tlzw==
X-Google-Smtp-Source: AGHT+IFJ+3Nj5+Lj6/0Fi0/V07baDd8UEq16MG5vv+5yiILVbZQYiQ6pJYLNX2GYT3JKZdZBd3uShgHRPcC3qbjMTDI=
X-Received: by 2002:a05:6000:2511:b0:3b7:9c79:32a6 with SMTP id
 ffacd0b85a97d-3b79c793525mr232147f8f.47.1753919663669; Wed, 30 Jul 2025
 16:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730164052.15371-1-carenas@gmail.com> <74891c16-8850-4148-ba15-d5b3e5571bcb@kdbg.org>
In-Reply-To: <74891c16-8850-4148-ba15-d5b3e5571bcb@kdbg.org>
From: Carlo Arenas <carenas@gmail.com>
Date: Wed, 30 Jul 2025 16:54:12 -0700
X-Gm-Features: Ac12FXyQV1Nh2-shlFvpGMyj5vLKuzDyrrzQAXtu8crcIJhLKxpbsYgj0BS1CcY
Message-ID: <CAPUEspgpF5=w-=w1zofkO1P3+HYdvRUxZfpnM2pcJGYOOoEmdg@mail.gmail.com>
Subject: Re: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in macOS
To: Johannes Sixt <j6t@kdbg.org>
Cc: Mark Levedahl <mlevedahl@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 12:09=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote=
:
>
> Am 30.07.25 um 18:40 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> >
> > Patches 1 and 2 are minor fixes that could also apply to maint, but the=
 main
> > change is in Patch 3, which removes the long obsoleted "Git Gui" app th=
at was
> > tied to the system provided Tcl/TK framework and that has been broken f=
or a
> > while.
>
> This sounds like the lifted requirement of Tcl 8.6 isn't the cause why
> this part is broken. But the commit message of patch 3 says it is. Which
> one is it?

It has been broken multiple times.  Since macOS 11 (released in 2020) using=
 the
system provided Framework had caused problems, some were worked around by
use_ttk=3D0, but it was more reliable to use a third party Tcl/Tk.

For example, Homebrew tricks the Makefile to fail to detect the system
Tcl/Tk and
to use their own version of that dependency.

Something in the recent meson related changes broke the generator for the A=
pp
and it wouldn't even start, I didn't propose a fix, since that is
likely also affecting
maint and nobody complained, which is why I was proposing to remove the App
instead.

The last changes that remove use_ttk and force a version that is no
longer provided
by the hard coded dependency of the App are just the last nail on its coffi=
n.

> > Patches 4 and 5 are needed to avoid the system framework and facilitate=
 using
> > a third party provided package of Tcl/TK 8.6 instead, but the last patc=
h also
> > protects against a conflict with the Xcode provided git that for some r=
eason
> > includes a copy of `git-gui--askpass` even if `git-gui` is missing.
>
> Patch 5, I fear, needs a different approach as it breaks RUNTIME_PREFIX
> builds. I say that after having looked at the patch; I haven't test it.

I tried not to break RUNTIME_PREFIX by only using the build provided execpa=
th
to locate the askpass helper, but the suggestion by Mark seems like a
better approach.

> Any help would be appreciated on the Meson parts

The Meson build works when tested outside the git repository, but since the=
 main
meson.build doesn't yet use that to build/install git-gui there is no
way to do a full
test.

Eitherway, it can't make things worse.

> and whether the updated
> git-gui--askpass build still works. I don't use either of them.

to trigger the helper you might need OpenSSH >=3D 8.4 and having the follow=
ing
variable in the environment before calling git-gui:

  SSH_ASKPASS_REQUIRE=3Dforce

note that G4W provides its own native `SSH_ASKPASS=3Dgit-askpass.exe`so tha=
t
must be unset first.

Carlo
