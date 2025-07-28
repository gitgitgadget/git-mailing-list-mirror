Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC627605C
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729911; cv=none; b=XUx6whXs37zxrc3WGXtHoWr7kiGJk/hYxVrvyJ6wMLzkexKh0GpNmbJ/a+IRiA2+p9rvmjkgLW76XB08qpF5Lx1qtT1IvgDWfzmTFWamqP6/hwTzH6/c6QN75DX61ZGGYnFPIa++9g/3fTKpMc2NUlbMzcEj0+K7eznCBXERQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729911; c=relaxed/simple;
	bh=x6Z/DXpms9sJmCxGFQXT1tdMa8BfkUA+do8Y8Jv5sHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sFTSMfSdBOameppOo7OE0J9OXh5kT4UUulIZth0IJOO5tQF1ouO+w/2+Jl3jgAgZh3OvpbX3NDAK7qbSJwU0GhKtxi8zMlr4WjR+CVowm5kif9NtmdHjVAmmR3Ugwq4x+Zs9xhyyyry/wQjfaI56kAOXTQ/Vx5RC5F/yT8O14oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC7yuVIM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC7yuVIM"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32f3ef6178bso40300441fa.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753729907; x=1754334707; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCLnen4RVHMD4ZF30kiHhOjXNGSX9K9CNmH5kIcqZBA=;
        b=IC7yuVIMcLVWlNfMBk7ivxG7SuWaS9uxOhaMJEQzajijQUK7parwMti4wEG55Dhq32
         fkh23qenaC30DVSPbQb9/g/jUT/nSiJsVNwSLGNvwic5/3UTca9vyUMk0TOJGQF3y0SD
         JxtuRKNC+2kbMzTGyVpOKBGn4DDimm/S8dSrpygaj1WG3fZN9YRLQEYrXFTfzdz2gzFd
         jq/UrEMszrjLknVVGuRhlPDPb5lDSjeHdtS/lYEaEGH3lHoXJIIzSVn2n6vbYmYHMlR4
         TahNnF7yCprKLJDYi03kxryU901lcyzGo9WuPjmWKg48qtxwwSlwXMDJCgBAnnPRMwIA
         GmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729907; x=1754334707;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCLnen4RVHMD4ZF30kiHhOjXNGSX9K9CNmH5kIcqZBA=;
        b=b8mFJqHGQYuFj2mloYBnWyawIOLHwXVmLPxDqLCX3G/3X3RMG69sgwZSx6WlMghoiH
         32Q9OKzcrNY5X/qtC8B7FRLg7C6sRUoY5raFibAZmG9HTg4FUnTuijBDEJGuxAtqaby2
         ZRruSTY6a83iBrpwLFozcbDQbprpAAjwerD+Tf2HU7k4Bv+uxaiASAHRzNr9TOptpH/1
         rGfsHWKv4y7+vlAhJUQmXJwsazcqQRMwzUlBHlMfQeM/hbO5OupQ8yFGYXS4uK6SAMJN
         96hTwBDBifFrJ82FqZDNl2DUXYMkLe7DfmKuiJ9Y/Zrs0V0bpe5hstJhOIIls57Qm9fz
         UElA==
X-Forwarded-Encrypted: i=1; AJvYcCVhIcK8Qcjk2uV4vYAKXNUdwJt5LEWEwFAxBMpTCK6J9TcOH3WcpGCINJD8Uev7wspw85U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEF4WYSWD6QMmG2UpFx1sTqoiypgJ4hxYjY1edTkWN8O97TaXN
	w6nSEq209hobxUK8TzWeBEfMOi4iVWg3n5ezC6EeEXQpnU1PteSjP/x3/zpKwWmK8VnNwfqcZA4
	kmYH0t4BO+Y6QPZ4vQwZy4cJFMLj1mlWJNQ==
X-Gm-Gg: ASbGnctgEV+1Aj3YP+dMMC+jZdVi3l4iPwCuRAxOx7jNJ4+uiQHBx5gIBi3sITB/ueE
	9uJa4a9JHtIFUowXtcxTZuUwjQ7Xhvi0ojb3pqj3Y+YMFKjGI8kop1SUpcMWsiSIzM1VHItOwlH
	B0IAbv9IHudFXGYkibykvs6JHj2mHu6Pn2E+OoVlK8icT8PnSfG8ktm8uVdnP84d4/dBKyh+E+S
	olL0axZ
X-Google-Smtp-Source: AGHT+IEwwMtRPuq4rObOcEckkMETRqkJnLouoySlqvOR1fJQqid07uA3KodiN2V50iSKirGJ7buXCnVDqXptCKCFVcc=
X-Received: by 2002:a2e:bd17:0:b0:32b:9652:2c04 with SMTP id
 38308e7fff4ca-331ee7ff5fbmr48179921fa.33.1753729906955; Mon, 28 Jul 2025
 12:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
 <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net> <CAH=ZcbBebM6CememqOUFY2YPOXpk_mC=zE0OnLOKDqcJQTdMuA@mail.gmail.com>
 <aIFauT8M0wRfaZV8@fruit.crustytoothpaste.net>
In-Reply-To: <aIFauT8M0wRfaZV8@fruit.crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 28 Jul 2025 13:11:34 -0600
X-Gm-Features: Ac12FXzseTBmbQVf1nCGDpiejdxDqRw0VF7X3YZj5SR_okTNODPfP5tx_S3llwI
Message-ID: <CAH=ZcbBNg0Ku0VKvF0HUyksrcZdbT=8Xmk6_kQV0178ROATf8Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 3:57=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-07-18 at 23:15:19, Ezekiel Newren wrote:
> > This goes against what I think is best practices.  Don=E2=80=99t we nee=
d
> > Cargo.lock to audit and debug platform specific issues, and to ensure
> > reproducibility?  Without Cargo.lock, we might get different results
> > one minute to the next if one of our dependencies releases a new
> > version. Checking in Cargo.lock aligns with Cargo=E2=80=99s documented =
best
> > practices (https://doc.rust-lang.org/cargo/faq.html#why-have-cargolock-=
in-version-control).
>
> I appreciate that, but best practices also don't limit software to a
> six-week lifespan.  Rust the language is a great tool, but we also have
> a special case here in that we need to support software that upstream
> does not and that we care about OS distros, which upstream does not.
>
> Note that when someone builds locally, a Cargo.lock will be created and
> they will get reproducible builds from that point on.  It is only on
> first build that they will get whatever's the latest.
>
> > I understand your concern and I agree that this could become a
> > problem. I=E2=80=99m totally flexible on which rust version should be u=
sed,
> > but without Cargo.lock checked in we lose the ability to audit why a
> > build failed. I think that this will be a pain point, but numbing that
> > pain means we can=E2=80=99t solve intermittent problems due to dependen=
cies in
> > the future.
>
> I was one of the maintainers for Git LFS for several years.  We
> routinely had people come to us and say, "This dependency you're using
> has a portion that you're not using, which has a CVE.  I demand you
> update it and do a new release immediately because our security scanner
> is going off and our company policy is that there be no exceptions."
> This happens literally all the time and I absolutely in no case want to
> see those people on this list or the security list.
>
> So the options as I see them are (a) we don't check in Cargo.lock, (b)
> we convince the Rust project and the ecosystem to provide LTS releases
> with security fixes, or (c) we only accept dependencies that have our
> same lifetime policy (which are very few and far between).  I know this
> makes builds unreproducible (although not under the Reproducible Builds
> project's definitions), but we really don't have many alternatives.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA

I like having the Cargo.lock file to figure out why a build worked on
one system, but not another. After talking with Elijah I've decided
that a good solution would be to add Cargo.lock to .gitignore and
change the github workflows to ensure that Cargo.lock is preserved for
all builds. We should also add a comment to Cargo.toml stating that
any build or test issues should include the Cargo.lock that was
generated when asking for help. What does the community think of this
solution?
