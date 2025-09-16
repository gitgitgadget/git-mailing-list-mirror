Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE921A9F86
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065943; cv=none; b=qX52PgA6dRXEOX/JRXfxD/VnZ8U5yJ/NDwC8CHqb/+jaEhhHNb+3i4myFx204MKQo7+eE0iCvVMoSBFTZ/X0khDOrVJAwfqL+m4ctHF8swcgZOk4/exCovUb5GH0Ufy+1fLTKvobhaZbl8xh58NYCnUqp3IRF19mIVzr0lByw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065943; c=relaxed/simple;
	bh=Kc4yu1v9oiaQ2dUImgC+kPfJ591bUOSlu0ZtRMfwUCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osihsKmz+LsFV9bgKmRUjpc3QVjjWwUkmEHBl03bM6lkdBuvEpxKmXcQTu3py0lVp30bTAzgvTPN8fn/4HIPR1Z3JCnHocsIRdvdksKTr4uXX1lKGdUQq4A3B1iVRHfhpX3SFVEpMgCr4dwlMIeerZdSrk5QrZLaCfFFH3aUoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Itl9m85g; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Itl9m85g"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-35eecfce023so2956601fa.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065940; x=1758670740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8u7yrd1TU+YZ7a6ROaNnvdMRHOoHBPW0DboXdf1O6Q=;
        b=Itl9m85gDo4LZH/Lz7cMnei/A5bSgQHloEnBjVQp3MSTqR09RG1m4RFBdiW9oQNPXd
         Bid2iL9OiUORyrJO69K74kYkGUUdbL/3bYkl5WWbMPE3jcsnfALH9DAmqxvAngmL9tsl
         Bl1oGuomSb/81OpCAE1FnE8iyBp+Aoawl1zXvMZ4djuKF0HXyhl0oeRg56ZGcDd4diz2
         DU6YeyHL/QPyry9wb5EzLsE82Zb4mUI6kcsdLWDkKMpvGOg2wPz+7evXo7OyM0ZMCq3d
         /UU0lQqq3kK8+RDjoYaD98SDY9tctai9c+iB4/OF/EsWUbS9blOdnX/T9cKZQVJjxLhw
         /mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065940; x=1758670740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8u7yrd1TU+YZ7a6ROaNnvdMRHOoHBPW0DboXdf1O6Q=;
        b=C5//ERLMKf6db/DjvbmDl7VwrlDhbkKDuU5FjyhEArQw4sjJ5bfHnyotJjm2/0mxoB
         kVthx1SYXW17MYa3n4tvrCYIzTUGeKLL5hPOq1bRjD2sx7z+mOQmZsl7PGGUT+aTzeg6
         Avv71znpOEujEELD7Vt2fyW5rAF1imitBl3cWAt2DaC/T65f7cFYqW1tqegzjsNl6x9u
         eVV3gZ5sjfNP3h8EI7o32z24DrVxR0P+WhgkkLMcf4Pnrna+yKpxchTcIlVlC9Yvj0dB
         mAhGKlEDwmvFh6uw/FJNkodQYD4wBjziCf7aHYGVYx+F8qix1ZG6+dTgoVuAFH7hFyHa
         Fw6w==
X-Forwarded-Encrypted: i=1; AJvYcCVb2ZbQlHA4lQXzLLevTHK3WZGAgCaZedgs/9uVj+T1kCK9cSclc1i2A5uilxKeEiwX7nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6cehxHkmoBe1W+iJRXgqQNkSd/O0QzA266JrtKE7wYDHj5Vd
	5+xRawa6tzAkD/x+ugMNncL3xsrnJFc0EswgtVo4Xbz5vinRYMxlSkFglD06YZkkJBmIRo09niD
	8zBrSVb3jn7jgPUERSueE6o6jznONh5g=
X-Gm-Gg: ASbGncuAx7BnaQwBN93HRUbIrUxpnprfzsVRQTYxhVAy/Z9ICtR46u8Yi0kDICcOAii
	Hyfxvq46wQ2c4ZPl/5vsNfC6YKZIxS/ZUwkxV6wnDV894ovEn8yNr8UjalwjEGMQDYIJ6UTDK6e
	ES6v+vItVOJ17CMv/B3gJe8XEy/IhiZArqbft5n22J/9ks0K5gczKTgdqq9tqlyfTPzWk+1oQfj
	jlQGZxV
X-Google-Smtp-Source: AGHT+IFn2Uj9Ll04yEnOmC+GXH2rY0paSqiGZUiXJtuaONOouFwqKPrsqIxId+UI03NvDli7aXSeYF/jZpKtoDGsIMU=
X-Received: by 2002:a05:651c:1503:b0:35e:401e:a8a2 with SMTP id
 38308e7fff4ca-35f653c888emr689131fa.39.1758065939528; Tue, 16 Sep 2025
 16:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com> <1feb8bd5-ef47-4cf4-b306-e38c5edac601@ramsayjones.plus.com>
In-Reply-To: <1feb8bd5-ef47-4cf4-b306-e38c5edac601@ramsayjones.plus.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 16 Sep 2025 17:38:48 -0600
X-Gm-Features: AS18NWCFECnU-lL0ouowzVYmJXR3SxZJkoBlizNfu9RzOlczGGXFjSGPizrHoTE
Message-ID: <CAH=ZcbA47pzMu9VsrTC2Ni9_RN6iPKmaaDNNxSvx1dtroza+Mg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become mandatory
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Elijah Newren <newren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:05=E2=80=AFPM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> I meant to mention during the initial 'xdiff series' that running
> the build_rust.sh script failed for me on Linux Mint 22.2, because:
>
>   $ rustc --version
>   rustc 1.75.0 (82e1608df 2023-12-21) (built from a source tarball)
>   $ cargo --version
>   cargo 1.75.0
>   $ rustup --version
>   Command 'rustup' not found, but can be installed with:
>   sudo apt install rustup
>   $
>
> [if you try to install rustup, it offers to remove rustc and cargo!]

The parts of my CI code that use rustup should not be interpreted as
the right or wrong way to acquire rustc + cargo. So long as the
distribution you're using has an appropriate rustc and cargo version
then it doesn't matter. The reason why I used rustup in the github
workflows is because rustup makes it easy to install different
toolchains. rustc and cargo are released in lockstep so it's confusing
when they're not both part of the same package in a distro.

> Also:
>
>   $ cbindgen --version
>   Command 'cbindgen' not found, but can be installed with:
>   sudo apt install cbindgen
>   $
>
> [I haven't tried installing cbindgen, so I don't know if it would uninsta=
ll
> rustc and cargo :) ]

Again this is confusing because cbindgen is a crate that can be
installed via 'cargo install cbindgen` and then run as `cbindgen`. I
think it would be worthwhile to go over some Rust terminology:
[rustc]: The rust compiler.
[cargo]: Canonical build system + package manager. Even rustc uses
cargo to build itself.
[rustup]: Rust toolchain manager. This provides rustc and cargo + other stu=
ff.
[crate]: The unit of compilation. In C it's akin to a single library
file or executable. It follows the structure of
my_crate
=E2=94=9C=E2=94=80=E2=94=80 Cargo.toml
=E2=94=94=E2=94=80=E2=94=80 src
    =E2=94=9C=E2=94=80=E2=94=80 do_that.rs
    =E2=94=9C=E2=94=80=E2=94=80 do_this.rs
    =E2=94=94=E2=94=80=E2=94=80 lib.rs
Where src/lib.rs (the entry point) means it's a library crate and
main.rs (the entry point) would mean it's an executable crate (though
you can define both in the same crate).

This means for each crate there will be lib<crate>.a and optionally
interop/<crate>.h. So places like xdiff and reftable would be easy to
fit into the concept of a crate. The rest of Git would take some doing
to organize into crates.
