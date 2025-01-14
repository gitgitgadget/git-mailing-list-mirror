Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C431CEACD
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843814; cv=none; b=Y4XL5ZGoDFMbGB1HX8uN7sQJqgC6VL6ZCs+oRjbYhY3vj/Ke2K/tmEVtt/4haXKTokbwjlNQm20YjKm1OPDIRvJwDJKsZhPTGp64AZSbf9diEPah44fszhBUjlGDOvNSNlFdJ7j3G6dLHNL+IGJSueCfx9TwkdiFbGULrfcBhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843814; c=relaxed/simple;
	bh=jf2BavUEQpkSfjFw6jAw24lXJMzFImRzKReJVnalxC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDFls16rFGIwUepDFWBYXbaVzs85PWXibtzoFpymLOMmCSfZicna7zIS7I4DP6eB9/ji2SUNShx/JASNx7LdxgkJkALzj/dYBei0VFKP5K4hVq3d7wM5HSqT+ygND0gS+p4J4GXYiAkzRKaUVAlk791CbDRmP6th8DV6ls71N24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdb+muyz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdb+muyz"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa689a37dd4so992901166b.3
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 00:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736843811; x=1737448611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmgBpnxb3P1tYPXZudHATwX0nJSqM5KZpEdYIVZdFsQ=;
        b=mdb+muyzW3MQWgreT/Z0WaY2t7EC8O1TH6kPYmrc7M+Dz1Xxf/fcp/IcLpMfUsPSiD
         /LGm2kwK4qCqvr26E+/B55uVWsQhlv9Tuyp5Aiyeobt45wCGdsqOfaY6HhUTHLu4RZgz
         Y5TPUM+tZYM88glwiYW28g2CfMwZe856KIcTOy8Fafg5znYpE910irXrnmPPFeEZzmmp
         upH4f9QQAAezkV5NoLkRnH17pM+M0O/OEoaZdUiLwMMPjT3tSJJlWrxY5cl33mh9Obd1
         dUMlC+6ISwbfbfh22I/g8jr5BnZjURAsgDF+Sl+OOI8C2XzNClipKHxxW5rz2fVu7LX6
         fGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736843811; x=1737448611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmgBpnxb3P1tYPXZudHATwX0nJSqM5KZpEdYIVZdFsQ=;
        b=g5T0wGK8qR/HtFcaeWRp13F7Ij+XGqSUR028bdCXQhc1pYXP5A7TsBNYVvabiINTY+
         aZSAtFUJapYPa0DbMpo0LK9J60FtZKaaujPGm/ozFqI+fcfe4DTa7i7ElmuPOcKe5YKX
         pCkXZdB1jV8J+9Aa06/Y7bGLTVJ3gaHJotiNRRubnGwmrco7mBoqahHrCW+hsQmlHVth
         uG/PeI5cTO2cIRIDYaoEJHoQ1U7tkmmiXEeQMeD2vE7s6LMJCMgV06NaBksUewtzVTKg
         LH+OWufexR9S5IAFdMGTvACfIf/79VXM5k8OOAMVBSC5w1F/fd03PAxDjqh+6hO08/6U
         0lag==
X-Gm-Message-State: AOJu0YzJHCH+zihl9cJsZP1R51Ol70YcpNRvEe1eKYR/CM+A3FeVyAif
	bUtCqTKDmCwr+BJh2lYxVRL8K2e3Kp/JDxIdlaJwLdc7Jvpf5HPyYR4od98J/9er2E6pYdRWSe7
	vhEZHc3/bvacy3UgedH8z+Alow9GjPls9
X-Gm-Gg: ASbGncu1+MCG/zE4n6FdWnB4mjhgaApKECUptvi/2fFgoAd11YdBAyVQczDrw1apu43
	dTeUjhNSVlwPnqaXKKFRKx8VUCjkSoOuBAKkmDCos
X-Google-Smtp-Source: AGHT+IFebT8N+oxax+yI5d8+WSW3F4oQpA8FKrt/9rNo8vpaYlVIDK7M71NCvbmt+dTqFSgLwho6X7+msjENgh3rQnw=
X-Received: by 2002:a17:907:60cf:b0:aa6:8b38:52a3 with SMTP id
 a640c23a62f3a-ab2abcb07e9mr2459270266b.50.1736843810585; Tue, 14 Jan 2025
 00:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFAcib9rWO8WFmaAwf+1Ng85+N7O3Y=QM6wG5xEz0r4tGXJ8TQ@mail.gmail.com>
In-Reply-To: <CAFAcib9rWO8WFmaAwf+1Ng85+N7O3Y=QM6wG5xEz0r4tGXJ8TQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 14 Jan 2025 09:36:38 +0100
X-Gm-Features: AbW1kvYfvkKoiFgxx90RegIMGy_-Kd4cLBPNq3llAilF2Sd8ipAQCc9xhpfr0VA
Message-ID: <CAP8UFD206mL+CYxOUKOPWFj7tX1Y79Moc7UjvH4BsLVLbAk-JA@mail.gmail.com>
Subject: Re: Should 'git replace' respect GIT_NAMESPACE?
To: Josh Bleecher Snyder <josharian@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 6:17=E2=80=AFAM Josh Bleecher Snyder
<josharian@gmail.com> wrote:
>
> I was hoping it would, so I could have different replacements in
> different namespaces, but it doesn't look like it does as of ~now:

It might be interesting to know what you wanted to do with different
replacements in different namespaces.

When replace refs were introduced, there were discussions about
extending replace refs to be able to have different sets of replace
refs used at different times, so that it would be possible to have
different "views" of a repository. For example there could be the
following views:

  - the "default" or "canonical" view where no replace refs are used,
  - the "timestamp fixed" view where some replace refs to fix
timestamp issues are used,
  - the "authorship fixed" view where some replace refs to fix
authorship and committership issues are used,
  - the "build fixed" view where some replace refs are used so that
the build work on all commits (which should help with bisecting),
  - the "old history" view where some old history of the code (that
was not imported when Git started to be used) is linked by some
replace refs,
etc.

> $ git version
> git version 2.47.1
>
> $ GIT_NAMESPACE=3Dfoo git replace
> 751eeb3b4d23c7fbde919aedde8c091f04f4f819
> a9dfd084086ee4d6bf00a33b0976f28c0997457e
>
> $ git rev-parse refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
> a9dfd084086ee4d6bf00a33b0976f28c0997457e
>
> $ git rev-parse
> refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
> refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
> fatal: ambiguous argument
> 'refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f81=
9':
> unknown revision or path not in the working tree.
>
> $ git log -n 1 --oneline 751eeb3b4d23c7fbde919aedde8c091f04f4f819
> 751eeb3 (replaced) add go.mod
>
> $ GIT_NAMESPACE=3Dfoo git log -n 1 --oneline
> 751eeb3b4d23c7fbde919aedde8c091f04f4f819
> 751eeb3 (replaced) add go.mod
>
> Is this a bug in which case I might hope for a fix, or is it working
> as intended?

I don't think anyone mentioned using both namespaces and replace refs
together before, so it's hard to say.

I think namespaces are considered a server side thing to avoid
duplicating objects in the common case where different users have
different forks of the same original repo. And namespaces might not
even be used much on the server side as there is the "alternates"
mechanism that can be used for the same purpose. Also on the server
side, you generally want to disable ref replacement entirely as it's
just simpler, and most often what users want, to use the default view
without any replacement. So it might just happen very rarely that
people want to use both namespaces and replace refs together.
