Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B07313E18
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710365; cv=none; b=Da1RbglvVzmMVPh8YbarM/cXwlououaZhQqAul8JoZSuAhECLkViI5GX0+5hw5ZzGUsUsCnT761tMzyG4brFy4pAMmD1uVJM7Qmz6vpj47+e05adchz2swTwhBhrs3s8ovhMBVj7hCwBBR51ZShljaAYQJkka5v4QhIOD6e4fIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710365; c=relaxed/simple;
	bh=hpVtq7ZedDD4Z5KK15HIDIDVgWyFgFuVkvUicyTx+N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZfnqIbdnRTBh6p8V4k+L0QtGYSUxeC4ZHECrtZ+zpinbDg9oxiG4kOYaAsSkwO9PywG7WWd86zvyqhkJwUrqb6NN3UmD4B+JcUzTm6lnj9xtv3cEb4jz/Td+LdfjtEKci6dkzXfQe4Y6JFfJelj4kJHePwOiRUuhy7aFAo1mTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXML9iPA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXML9iPA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so1072635a91.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767710363; x=1768315163; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts9uvQFqAKxDvbVEAP6ETiPrgZ6HDN+NIqDMZ7FECmI=;
        b=dXML9iPAu7qTRiPn2nIHh5SJWuAPwsXl8BPZhWpsKc8BsrHp9y1gSuwXhwcfTsXV6Y
         fFHNrr9rvVEsjCPDMLhHqwqT37VktBoYOfflPEolVXk4oG1s5KqWEHW5bRHuF7lci9nS
         JnTzljnvBZTrhXmicre/hD0+UAAII9XjlHTzhgmHd/TFn+QAet2jHbA0KIhEZMl++VVc
         6brQhE6A+urje8rRX/fc6dYSdxKrZCUQFSruaAbJcr9X+SEuPYxA69bY6Uu1upwogQiy
         +UTiMmeM1TK7HQHKEw2Ib49p3P7ZQNt7P1WLUc3ba3ggIdyuFhWJtnVhKgtYz3zjHL/+
         8dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767710363; x=1768315163;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ts9uvQFqAKxDvbVEAP6ETiPrgZ6HDN+NIqDMZ7FECmI=;
        b=iYEPc6b7XHfZv1FjrbVyK1+7LKY2IB+5tYHPXMr0xQlNC+dLxa7rcVzXjJ/nbZ7RVs
         8WpOkmkC0+ykSzELQfyor6YIl9Pf5fQDN6B7Me6dzAG04tgWc2ZiSLTgr1/36IYf+I5q
         MuUMD+cBYN2+53UdL31vb3cJCDneGpHuGNLUUzDEWV50huTO2L9J+J/j8h5w55Fl0ifq
         YKSUhWAMHxJTEY0UOOkt5B2nIB1pR3JANB69+z13Mt+cUy9MAQrPkRhTup1f6LQlUf8a
         /l1l0h/lPmjb7mkUK0emMzy35E/nvGvxPx9tgORkwQK0cvzTFui3X6fgmn7B2N+0ZGSQ
         8jWA==
X-Forwarded-Encrypted: i=1; AJvYcCXvindMRGAeqZk3M3Bxk7jUrU06wgJHR+H2HwztW6YxipvmqAVda8jSjWA087YJnkJWox0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3ALjhHpkQQioLWIOK8Q0y4r8/eVnrXsXmEwbOHwjKbAlIfe3
	GJdMmIYUBgg1x6uMJGM2TipgFFW+76Amk35SngEGY+PEofykQmkFXJqMZF1TBWCJaMzPFjZpv3r
	a4wghZ6QPhi0ldtI8rkIzNCRuHIjz4iHkiViuyQu7vg==
X-Gm-Gg: AY/fxX7Vl/C746jLaeZSvqmq6gn8L1DsdZyOMlhhCU3YG51K+4eOsqG+g7cjdzFl//Y
	cZBzXN+/t8o4HHK4iteZB6fm+yOl+EDwiQya+v5J63mlRv2uMerEMCis/3xVL5KHTjx2MDq8qcI
	mEA9FyzLqjMQZLNURMRmO7swhBZ3gaEIUVI15XVan1hNJu7Ad7k7AEviBs4zc9D9mK9C3P4KB5k
	f2+MVK+W7N7jBERpe9/g1dz4trbucZq7cbVhlszajGgUe7RpSGUQcn16kTpyOitkII1GXfGuQ==
X-Google-Smtp-Source: AGHT+IFhETDdU4Di4gOlImnBCrmE9Q1ggK5bAcDJRumtBUXL0grvUzOyVojwwoBOMbMeevrrZjQP/QeF3QwZJoGaWLU=
X-Received: by 2002:a17:90b:2e8f:b0:34a:b1ea:6648 with SMTP id
 98e67ed59e1d1-34f5f25a1c4mr2288171a91.2.1767710362967; Tue, 06 Jan 2026
 06:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3xRKfeij_3OUzVPv6Mr4bXjwkB_m7DZt6cbisL-VD473QLpQ@mail.gmail.com>
 <aVw-l-vi4PegDhY3@fruit.crustytoothpaste.net>
In-Reply-To: <aVw-l-vi4PegDhY3@fruit.crustytoothpaste.net>
From: Son Luong Ngoc <sluongng@gmail.com>
Date: Tue, 6 Jan 2026 15:39:11 +0100
X-Gm-Features: AQt7F2rChKiRdcxeEf_zJ5v01kXGRiXFFp8jvSfyjEF_lyf03YvzG4I6ptCP184
Message-ID: <CAL3xRKdmyeSSKKqo529JTeg9ko1swJAwoZCHWT=GzJKZ-MV+Qg@mail.gmail.com>
Subject: Re: contrib/bazel interest check
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Son Luong Ngoc <sluongng@gmail.com>, 
	git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Thanks for giving it a read.

On Mon, Jan 5, 2026 at 11:43=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> We already have two officially supported build systems (Make and Meson),
> plus CMake in contrib.  I don't think adding a fourth build system would
> be a good idea, especially since it's already burdensome enough to deal
> with the main two.

Fair take.

There are a few folks who mentioned that they might be interested in this
on the community Discord. Unless those folks are willing to share the
maintenance load, I will go with the out-of-tree approach instead.

> I'd also like to encourage you not to send this as-is to the Bazel
> Central Registry, since it hard-codes various values that are intended
> to be configurable, such as `SHELL_PATH`[0], `PERL_PATH`, and
> `PYTHON_PATH`.  It also hard-codes a variety of define values which are
> not necessarily correct for all systems (for instance, my Debian
> unstable system _does_ have `strlcpy`).  Shipping a build system like
> this would be a regression in functionality and result in broken
> packages on a variety of systems[1].  If you're suggesting to the public
> that this is an appropriate way to build Git in general, it would be
> nice if it were no less functional and flexible than our existing build
> system.
>
> [0] For instance, I set `SHELL_PATH` to test building and running Git
> against zsh from time to time.
> [1] As an example, this would not work correctly on the version of Git
> a previous employer ships because they ship their own version of Perl
> and Python that should be used instead of the system one.

Yeah, the commit is definitely more tailored toward my use case right now
(building libgit and linking it to some Go binaries).

In the Bazel ecosystem, these tool paths are determined by "toolchains"
and the "platforms" selecting which toolchains to use (1).
Luckily, shell, python and perl all already have their dedicated Bazel
rules set (2)(3)(4) with toolchain definitions included.
So one should be able to make these configurable in the future through
respective rules toolchains instead of using the hard-coded value in my
build config. Good call out though.

I guess I will make a note that this is an unofficial,
"community-maintained" build setup when sending this to Bazel's
Central Registry. That should help set the expectation of downstream
users and remind folks that contributions are always welcome.

(1): https://bazel.build/extending/platforms
(2): https://github.com/bazelbuild/rules_shell/blob/main/shell/toolchains/s=
h_toolchain.bzl
(3): https://github.com/bazel-contrib/rules_python/blob/main/python/private=
/toolchains_repo.bzl
(4): https://github.com/bazel-contrib/rules_perl/blob/main/perl/toolchain.b=
zl

> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA

Cheers,
Son Luong.
