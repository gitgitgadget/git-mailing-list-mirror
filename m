Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E231A256B
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988225; cv=none; b=A8aFtmaWqcde2LgIbZ4OjmyLNcgYQrUFEpCW6UGOHUirQSwusMI2RcNRgRJjmdhvjwHCDQTmDpgKv1xYdo1EG8tDEh5GkWXQ6/f1A+L8rKjrZLI5Pplb+pEcezsJvfzxokUZbahEAb19hGYVnwV29HzvH4mU7t1zr4AxKJCAJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988225; c=relaxed/simple;
	bh=PSefXvYzDOEtgtKYJGDWIkdToIHycr9bvWQlVH521B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=makIVDcJq4rnCZ8Pm0LmI0AvcLzZmHgTuVOaLwKdxg4BFRpbbB7wzvw1h3kpqiKWFgWZfaAIwUHhV5eVwcpAcMUuv2Jo4VMpjUFHFs9Cs/WR6V5GQF2cihGCF0D/DrB3cHOSM0se0QHoi5P8qaIK8lU+vJCSvK8Z1WJ3D3mllkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjqtaaVG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjqtaaVG"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33ca74c62acso44682591fa.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757988221; x=1758593021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bc2NOH2+04bQcEhzM+LY0Db0PFeZy3QKJ9OrGc0lneI=;
        b=KjqtaaVGonS8rsExgSVo2SZM3ReTX44/CL39d4sBAPcBcv98pzkE81W7Zl4OHnSixd
         nQO7WTWOuFO3ZxwFJpYokzs6Wyp5d2V0IoDAPzhUdFybkPSzX9VRbBGyo94PZYDAY7pa
         h81MjP7ct4iOvPCGAaefFcudmCt2rGXE30AH7LjpVyd50tq/QWaKk5EHninqsJ55hUex
         poPszJQJNb9hL3HMhn8qL7ZGYph10lEOP7lw8JOUiiCqgnp9XJi2UEavqlQA7BXFvcGr
         r8ENVKfMnt3oD+jMNi9Ba3d2n/5wiPJjOZJCX5+eu92zQHqK03n7WPJGqiN4VgbJHVhg
         Jn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757988221; x=1758593021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bc2NOH2+04bQcEhzM+LY0Db0PFeZy3QKJ9OrGc0lneI=;
        b=S94ZuHxArezJpUlW16g6eTclJ+h3xMG/tMqZvR8e7hyep9qp97aK84yoWhFw6aUZ+R
         V6AVLMlAC0Xb8LGftoeADm+czGJrIyPh9Hm25oAnFWHrLfbkKXBc6T14cRlHml2isoBd
         wI4UqJqrKQpprgPkHgx0ETHkm0GEiiTZu+lcboL3IVlgz8Azy5SA8JVgTGGGswcx9OCy
         sEl3PQ2Vzms+um2cDZkofj7eCysCjiwrDi9LhuknhyzB3g1xJZL8Ky3WDsnbkFy57BGL
         lOigo+CItGKpGQ3jyJs+1aI8q5KStt4OwtiMGHt5HE0scQuty5cZJ0JdIm/hoFFY2z91
         EBKQ==
X-Gm-Message-State: AOJu0YzFLYdI0bI+PQPWVvqukBxeEdfRRaFvHWp71Lz/g3nBvhXXuvSh
	Lg/KAA4CDCFg1yeHOVd8T6eOJRDN5mpcCDSetjzlxznOBY0u8RA1VOdDvkhF+iqesmkFFaAPHrw
	Y66BumkIdsbFfXCAnRR3NykWOfdHJVF8=
X-Gm-Gg: ASbGnctdy6KRAHTQ4Kqm3BxV6KKmP74KHNM2msIxUqjpRsPN+FgoWXRLBCtLsmWKEgm
	NAHrYH+ZegIs36WWOz6Atp+pB5daK/SJGDOYpedGXC//m1O+KP3RL68uEWYJRJI5IbHb0C/PBvC
	UdRvhQtH6/dxZdba/LnNGdqF7BrMYDYPMs6A72M8+oMSo6FWJShrdmdC8pR6yX9esTBr0ExEj6Z
	ztqlx5yASodEXoe2JU=
X-Google-Smtp-Source: AGHT+IHpJSOIA3pHKWu0EZOC9eVb4PYPAWVwMjWgcFigUccBmxVTcSjfAm91DBXG4vhiuTL0MpPyC0TEJq63KB/Ch28=
X-Received: by 2002:a05:651c:1501:b0:336:7121:525a with SMTP id
 38308e7fff4ca-3513d5796afmr51010781fa.25.1757988220870; Mon, 15 Sep 2025
 19:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im> <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 15 Sep 2025 20:03:29 -0600
X-Gm-Features: AS18NWA3nuV2ET873THeotMQF_zz-ZlQca6rd595VoN_xawuDNBFYUyo4Lux85s
Message-ID: <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become mandatory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"

I am currently working on a patch series that makes Rust optional and
addresses several concerns that this series does not:
  * Rust calling C: Makefile has no way to build or run Rust so it
would have to call cargo test, but that doesn't work unless build.rs
tells cargo where libgit.a is (among other things).
  * Build tooling alignment: My build_rust.sh is called by make and
meson which eliminates defining how to build Rust in 2 places.
  * Cargo vs Meson: Meson is adding support for Rust and it's getting
better, but Cargo is the canonical build system for Rust. cargo is
released in lockstep with rustc, and we _have_ to use cargo when
building with make because Meson won't be available in that case.
  * Crates: Patrick's series assumes the Git codebase is _the_ crate
    * cbindgen: Cbindgen outputs a single header file for each crate,
with only 1 we'll have an unmanageably large auto generated header
file.
    * Modularity: Using multiple crates makes Git more modular. Elijah
told me that there was some desire to make Git more modular.
    * Cargo Dependencies: Patrick wrote his series with Meson first in
mind which doesn't address how we'll be able to use crates from
crates.io
  * CI:
    * Sparse coverage: I think there's only one target that tests his changes.
    * With vs Without Rust: I don't see anywhere that he covers
building with vs without Rust in CI
  * Build integration: Meson has to have every .rs file specified
where as the default layout of a Rust project allows Cargo to just
know where to look for .rs files
