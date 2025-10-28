Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECD27B353
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679088; cv=none; b=ZkLdxhjkdKRxt7Fb6PPJ3K+ts9xByp5p+gdbRKaVIbJ8RmasINhgwGptTodVimRMCi70jhIw0uiNYnAX0N0DDeapvG3pGl1/rAPj/1MF8GMP5zI0UmGjB4eOao2O1kmmNMMD2/rsooTQ6wkTIk/lt8m+FdMi+3TR5y9wVLk2XCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679088; c=relaxed/simple;
	bh=h5cNR0xY2fUX8URzeEKX0a/F/ftLWhp/QsSzOPW+kO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvqxabfLCKRdOsDbAPdvPv+lWsajpsKcOtExvVpAjoHHEvsPYgM7QhRhKuqoa/0qwo67F05+TqZ9ckrRDWJc6kjWTARoym6V1DY+c8Bty6yD+XddE8710Leilue1uXF01Ug0oP24j/hqpsmV/iOFdEZ8IBaeugj3AzdF9aQDt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JztMUZRv; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JztMUZRv"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378e8d10494so51842481fa.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761679085; x=1762283885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6fpz2hOfVh6Z5Xcog4g2o46SI57vRRl/XqEqfi+l9k=;
        b=JztMUZRv/DXOn1O+pROp0qlpNcN0ZAO3XkSw0O6rRRJDbn0AJSUsPEVreO8SmbjTpk
         us0VOhU81OGhGgwJTMIhXvyuGybvENU4BbtigfGMOxtsm6j0IjWxwm74eurBhkj7KEnB
         EOC7hpTf38+TEDyc+mrCH+vBI8uc5HegDCKAcl7KID9TODMfs/fCFyRoZg5DLNjwGEVN
         Fn/F3nHTyZ6I0pdPgOZR56euxDkogp6cBHRxY9auiA+TkdFrogiDRDli5Sidcl3GeQFm
         x6Twa6vamuNMhIZirNRrohaVSaWCVuEK4peg8nCo+pgZZVDf5Md+riMgfVsLfGC+Q2un
         g+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679085; x=1762283885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6fpz2hOfVh6Z5Xcog4g2o46SI57vRRl/XqEqfi+l9k=;
        b=vMei30wLWLn/JWX6urIhiQAmKBDgoXsYDaFu1Ll/68tsbhlhh+IpPT5KpdN+OmLL4P
         QvPkL2IZGTgK3xs4I/zYBQzufR9LWy0ul/MeBrYcB13xchZ/xdzbSXVkivcr2yuRboZA
         fVWzVJMLFnSXsoXiSpW7pL7WdFy6Rxn6CMFfhD/L8hBsxp/dmzBqD7XH2g93BNFcPjrf
         LPr4F8q2eS102tChci57uciZKAgWzHTX0L6YTfF89PkfpTwrU6fAyS734V9XckUc1ABp
         /LqV7bUpMPcFtpCAFZCHBJLLMqgOYlbKQRnEd99XOlMvcA2axNgR/dqRorIr4caVtX+F
         G6jA==
X-Gm-Message-State: AOJu0Yz7bkv4NjtEzO40YXQkI7z7HRsoN6uonrZela1dBo1CwbzB0XmP
	2u8h1e43kk4OnfYyC4uVXXya3mX8TeDpxCjoCm2LofQs76knMyjF7bOx3oO75GqYv1Xc3AMolIU
	MLJVkDju2TnQSC19Yqu3cNo/CCgRIRQDiyQ==
X-Gm-Gg: ASbGncvSeqDIKDoN2mWPsPBlEUsTZPXJywAzZ6WdQzR6UiZNWV47n2gRYShG/PTCRJx
	OkqyOeaRKG9tH9tCTCRUcS4klLRvkNcN1G29dNvjsvEuu0IScT49v432zweht2v22CA9jvwGUAa
	wYPVNxkxXfw5Vxt0vZ7V3Ml8lJnvF2tEPC+sLEKNPT/Iw+k3WLLmeddYostiDKZ4ehzTlBIHk+q
	wBhZozA6+AHbcsyr6zwILACzsnQMjhODu3iZnYZ9I8m9vhlgeti3ei8W4TF9A==
X-Google-Smtp-Source: AGHT+IHjYeJUuePM5ySSS4sWGjdyUB/W63swzaJM/CRra9F07M22SUSNmHb4lU+oTazshUDhOFzbGAmNSFDm4OJujXc=
X-Received: by 2002:a05:651c:b2b:b0:336:b941:4ab1 with SMTP id
 38308e7fff4ca-37a023c4069mr2115361fa.17.1761679084439; Tue, 28 Oct 2025
 12:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im> <20251024-b4-pks-rust-cbindgen-v2-3-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-3-4b4bd4f18490@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 13:17:53 -0600
X-Gm-Features: AWmQ_bmHFzwNGb2J3H1nafTXSHBSVK6QAkL3gwpmOghgc3br7ks_RBLMC0Ln920
Message-ID: <CAH=ZcbB3J2Jt5Najc8p3z1iaig_Q0S_t5hGWRN-4fNRVGggARQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ci: use Debian instead of deprecated i386/ubuntu
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Ubuntu has ended support for 32 bit platforms and is not maintaining any
> release anymore that has 32 bit support. But we still use i386/ubuntu in
> our CI pipeline to test for compatibility with 32 bit systems, even
> though that specific image does not receive updates anymore.
>
> Besides being end-of-life, this image also doesn't have all packages
> available to it anymore. This creates problems with a subsequent patch,
> where we're about to pull in cbindgen for generating Rust to C bindings.
>
> Drop the Ubuntu image and use Debian instead, which continues to
> maintain its 32 bit port.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 3 +--
>  .gitlab-ci.yml             | 2 +-
>  ci/install-dependencies.sh | 6 +++---
>  ci/lib.sh                  | 2 +-
>  4 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index cc54824c388..0b16970cd7e 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -395,9 +395,8 @@ jobs:
>            cc: gcc
>          - jobname: linux-musl-meson
>            image: alpine:latest
> -        # Supported until 2025-04-02.
>          - jobname: linux32
> -          image: i386/ubuntu:focal
> +          image: i386/debian:latest
>          # A RHEL 8 compatible distro.  Supported until 2029-05-31.
>          - jobname: almalinux-8
>            image: almalinux:8
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f61ec2b6989..31d5e5a3e0d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -66,7 +66,7 @@ test:linux:
>        - jobname: linux-musl-meson
>          image: alpine:latest
>        - jobname: linux32
> -        image: i386/ubuntu:20.04
> +        image: i386/debian:latest
>        # A RHEL 8 compatible distro.  Supported until 2029-05-31.
>        - jobname: almalinux-8
>          image: almalinux:8
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 50628ee2dd6..b7b3cf35edf 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -39,7 +39,7 @@ fedora-*|almalinux-*)
>         dnf -yq update >/dev/null &&
>         dnf -yq install shadow-utils sudo make pkg-config gcc findutils d=
iffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel cur=
l-devel pcre2-devel $MESON_DEPS cargo >/dev/null
>         ;;
> -ubuntu-*|i386/ubuntu-*|debian-*)
> +ubuntu-*|i386/debian-*|debian-*)
>         # Required so that apt doesn't wait for user input on certain pac=
kages.
>         export DEBIAN_FRONTEND=3Dnoninteractive
>
> @@ -48,9 +48,9 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>                 SVN=3D'libsvn-perl subversion'
>                 LANGUAGES=3D'language-pack-is'
>                 ;;
> -       i386/ubuntu-*)
> +       i386/debian-*)
>                 SVN=3D
> -               LANGUAGES=3D'language-pack-is'
> +               LANGUAGES=3D'locales-all'
>                 ;;
>         *)
>                 SVN=3D'libsvn-perl subversion'
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a5c4eb40bea..fdfde612339 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -250,7 +250,7 @@ then
>                 CI_OS_NAME=3Dosx
>                 JOBS=3D$(nproc)
>                 ;;
> -       *,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/=
ubuntu:*)
> +       *,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/=
debian:*)
>                 CI_OS_NAME=3Dlinux
>                 JOBS=3D$(nproc)
>                 ;;
>
> --
> 2.51.1.930.gacf6e81ea2.dirty
>

Makes sense to me, but I wonder if we should test with other 32 bit
linux distros. This isn't a critique or a suggestion, I'm just
wondering out loud.
