Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C71213236
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167292; cv=none; b=nQshACq5V1QcjKe0f2/WEkEEXCROPgZvxP0gh7IItsIOq9YU2gr050QK6xWtiO4aXPPlzA5VnJwzq02kk+rpYlL6pIjPvPL9WICGEBrKCVpC6yBU0kjjgrDmD0oouDswblVbSNhchR3688u+aoZnSQt3ahLmq1ZF7A5GrDWX/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167292; c=relaxed/simple;
	bh=9iQwDbv/7O4tYjkZiUj8V0eQQDWfCOw5VcCMC3yt9ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9RrSOdXuPbOUtFOYtNfJgNQMJbrNLdpUw+oo7PRMveDphk0zMfCVku9tam+8eW07kz8b93r5WKOaYO38x57WxYqzP341VLlYDNPzUUgCZGbJKbEngJNfPgVNToWpRdT8p24vwOqRyAqzwALlmCLFjdQP7kF81MCqMx2uIV5U7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Gp/NAK; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Gp/NAK"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8935b53bb14so20138539f.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758167290; x=1758772090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsJmimcGrt2hpnd2xJ4//Tjq+6aKfpAomDfOxWiS9T8=;
        b=M/Gp/NAKcUrFuHr09n/ytyYqb9hhYiXd8AbwliheGVuWEVXe6b+apFb5Fixkeqx19h
         ghx+MLBjWx24cfv1b9yZlfI5aDLcJkw9RKb2jAklU5whuEHZqeEiSGxvn12Ukk4TEnmH
         n7gn+yyNqMnnmbqsatIP1i7rwaVFLhX7Lg07XRnbvReBm3PbJ8NEohUW5T2xRFf9EGNC
         csGNOXxaNM0rKy++GhmRTbs/6jHEnk27IYtH+QwmvrTJxG88gNIvuviAKmngxuIFB2Dn
         E351kOfzMWULzjtE1qpTxsdXH3BeucAICWZm4VFRsvb8xvySXoEmjQ9hJCTWAGb3UKJG
         MaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167290; x=1758772090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsJmimcGrt2hpnd2xJ4//Tjq+6aKfpAomDfOxWiS9T8=;
        b=CDrIG9Jqwx1XWlqbtY/kOza6qs1VmLug6rkC5cgx6TyfT0mf/9o+CEePix3OPug/WL
         F5MZ8sevVfnGuJ0OC5rKHTSw7yboaulFuW+kApb44u5U3NVEFf+3XBCghGO/IKZPxAIM
         Y68qFpMS9CMd5v0ayfUMueHbO3dlRkEs8LNvB2VN63o4I5xptLYRSGqU3wFRbc04wfwc
         Sy6GD0EecSfPY+eDPOXAiVLWc6wGqTP/AToTgRlsblMTNY41OBLXdo53PIX7t/Jyu/Tt
         aXs6APKMcEQg0J8E+c4JbWoTGws2HXC/02ek4EIrfxddMu2ZbRh+L2+8uK9PB3U7pV6v
         /Mfg==
X-Gm-Message-State: AOJu0YxWDDM1TSmm6A8h/xrwKnsEb7T88f77tVoFcnTirs3IwZ1Ascd5
	fIuQgk3SUdAtmGtoBXfuRwSdJApvD45BwrLZthG3W64MbRXznPv67w4XaVaN6vuORLkARyi+WJ7
	I+e4leqPMIaRiHI7AZyXy/UHG359qzps=
X-Gm-Gg: ASbGnct3gxweGbWL63sDXolBiYPKrW5iMqbC74K1nD8VP2qZsjU1UyH4BzhfrTs4159
	4Iy7045R49sho/NUtZxPaPEehh+apRAtwDMOjUxEQaRnyFvHL3xKPkzBPb1DDnQIRpaZt2udfG3
	7sWfDVxsITs9+s38ztfA4WrSZgq59StG2zBUrkf65Nu7VPO++qSPWb5KAFcAfgblL8evrcKplB1
	gCTkuFc69z0McSvvtpIXza6L4UAXqq6C3o6Xxob20lWUPIsfS48p/wFlXg=
X-Google-Smtp-Source: AGHT+IF8TZ535wTOfKa2lZhBmTfrW8lxyGUwyg4IlzJV204kAt6x1sIZpOdPa+v5IDCBgFR0WvkSwXonTPUdMNsfwkU=
X-Received: by 2002:a05:6602:21d9:b0:893:649c:727b with SMTP id
 ca18e2360f4ac-89d1f34d457mr582882139f.8.1758167289546; Wed, 17 Sep 2025
 20:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im> <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 17 Sep 2025 20:47:58 -0700
X-Gm-Features: AS18NWBV14XCmwz2SVcxbtPX6XFhFXecwToQxBy7XtrddVGl3tvNtlUsXBXcZt0
Message-ID: <CABPp-BEiK49f_UB5UPe3qM9O7vQGGFJ8Nshw1f6W_6Lw7HRL6Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become mandatory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, Sep 15, 2025 at 4:23=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:
>
>   - Give us some time to experiment with Rust and introduce proper build
>     infrastructure.
>
>   - Give distributors time to ease into the new toolchain requirements.
>     Introducing Rust is impossible for some platforms and hard for
>     others.
>
>   - Announce that Git 3.0 will make Rust a mandatory part of our build
>     infrastructure.
>
> The test balloon itself is quite uninteresting: I've chosen to convert
> the "varint.c" subsystem, mostly because it is trivial and does not have
> any dependencies. But it does allow us to verify that C to Rust interop
> works as expected, and to play around with tooling. All tests pass with
> the "varint.rs" implementation.
>
> For now, the series only contains support for Meson. If we agree to go
> down this route I'll also introduce support for Rust into our Makefiles
> at a later point in time.
>
> Furthermore missing is additional tooling:
>
>   - At least one CI job to verify that Rust builds and works as
>     expected.
>
>   - Tooling and CI jobs to ensure that we have consistent formatting via
>     `cargo format`.
>
> And probably lots more. As said, the entire goal is for us to have an
> easy playground that we can experiment on and develop the infrastructure
> incrementally without yet having to commit to anything.
>
> I'm mostly splitting out the topic of introducing Rust from the larger
> series that introduce it into xdiff so that we can focus more on the
> actual process of introducing Rust into Git and less on the potential
> features that we want to build on top of it.
>
> Changes in v2:
>   - Introduce support for building the Rust library via our Makefile.
>   - Introduce a '-DWITH_RUST' define. This define is used to print
>     whether or not Git is built with Rust via `git version
>     --build-options`.
>   - Adjust Meson to not depend on v1.9.0 and newer anymore.
>   - Introduce a roadmap into our BreakingChanges document to explain how
>     we'll iterate towards mandatory Rust support.
>   - Rework the Fedora job to do a full compile-and-test run with Meson
>     and breaking changes enabled.
>   - Adapt our breaking-changes jobs to enable Rust support.
>   - Link to v1: https://lore.kernel.org/r/20250904-b4-pks-rust-breaking-c=
hange-v1-0-3af1d25e0be9@pks.im
>
> Changes in v3:
>   - Reorder all uses of `WITH_RUST` after the include of "config.mak".
>   - Add a test to verify overflow behaviour in Rust and explicitly use
>     `add_wrapping()`.
>   - Use explicit dependencies for the Rust library in our Makefile.
>   - Fix Alma Linux CI job.
>   - Stop tying maintenance of our LTS release to the availability of
>     gcc-rs.
>   - Add a fallback to Meson to use cargo directly.
>   - I've fixed the Rust edition to 2018 for now. This is intentionally
>     conservative so that we might be able to use Rust 1.49. For now, we
>     don't have any reason to use a newer edition, either. So let's take
>     the oldest version we can live with for now and then bump it as
>     required.
>   - Link to v2: https://lore.kernel.org/r/20250905-b4-pks-rust-breaking-c=
hange-v2-0-6939cbf4a0b8@pks.im
>
> Changes in v4:
>   - Convert "varint.c" to use explicit integer width so that we don't
>     need to use C types in Rust.
>   - Adapt Meson to unconditionally use Cargo.
>   - Don't use the unstable `--out-dir` option in Cargo. Instead, we
>     resort to a wrapper script in Meson.
>   - Shorten the timeline a bit to drop the extra step that ties Rust
>     support to `-Dbreaking_changes=3Dtrue`. This accelerates the timeline
>     until distros are made forcibly aware of the upcoming changes in
>     Rust.
>   - Link to v3: https://lore.kernel.org/r/20250908-b4-pks-rust-breaking-c=
hange-v3-0-1cd7189fed3b@pks.im
>
> Changes in v5:
>   - Fix indentation in the BreakingChanges document.
>   - Fix a commit message typo.
>   - Include "Cargo.lock" in the `make clean` target again.
>   - Link to v4: https://lore.kernel.org/r/20250910-b4-pks-rust-breaking-c=
hange-v4-0-4a63fc69278d@pks.im

Patch 7 still has the same error as v2; could we get the wording
corrected?  I suggested an alternative already[*]:

"...While Git already started to adopt Rust in Git 2.52, all parts..."

=3D>

"...While Git already started to adopt Rust into the core in Git 2.52
(and as an optional "contrib" component back in Git 2.49), all
parts..."


Also, as discussed over at
https://lore.kernel.org/git/xmqqy0qcae6z.fsf@gitster.g/, would you be
willing to re-roll a single-patch v6 (with just your updated patch 7),
and let Junio merge that?  That would get the important timeline that
you wanted landed, and then Ezekiel could pull your varint and help
changes together with brian's Documentation change and Johannes'
git-for-windows change to create a test balloon and introduce Rust and
have it build on all CI'd platforms.

Thanks,
Elijah
