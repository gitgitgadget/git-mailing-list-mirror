Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D83FFAB2
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344451; cv=pass; b=V/IfYnMlIcdTZIW8X7Up/CC3d5KXKYERXLVlXhNaeuCnjlAYIQJPqmsIP2KxvyAsSK4cwKYNLeJM1/u67vXDvT9CkDIMq+L6O14Iik4pdiIW2Y45EbtaJL4X0Wvhm1IqYcV1VnWu+jJZ0fj9l/9dMfF2jMSgIJ6+V2Ppx2VN1R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344451; c=relaxed/simple;
	bh=IxQPNuPR2APNFfDb7+SQ/3lahe1cs5u/osAPGBuyDcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=n2mEC+ZjfMXWrYEv1Fktf48O3NKnu4l4ZBrJhT76GF95GEB8yc2LeVhYDp1X3QgI1t+QLmOobmwhyi8oXAS+0SrjGpHmVq5tJe+tmhmql2HRiKZgW2pfUL/RfYKuafTJt9dOh5phon94k1Cpw8KjWaZ0QVxqVOHjMT+iGNH71EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDxspP81; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDxspP81"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so12896636d6.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773344445; cv=none;
        d=google.com; s=arc-20240605;
        b=kve2yrLOmHEO74Hm/njzMIkiTFRSVL8ZKDn7R/IxmvBGyt2eFEh7aNcpJTKr1tK6hz
         pNGmGSHPvUtxrLW0rZ5SCeVq3epM2IxXkJ1VRjN3QvzWOiECc8FOiQq/5E5Aww9tZg9o
         UTqz9Cjj2dKxih6Fb1Tec2Fv/KKTJpjA4dvkBf+IgPIIhSU78CBbiasT471OAN6OVfzo
         8wag7AjkVVDvFcmf9CW492bF9F3LHKaIvIAgRQrfuOtDD2/xReHFRCK3GsfXIs6hO4Bk
         XybD4v7sep8LtFG0vEwaf7d4zwnaTDEP1hLHVDgTTUW6JrEsePIS8RDbJAtiQrUQX7n5
         CELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qw5sgn846LlcJpvpcFjplQOqbRXGmTMg8sDtsjuZNaw=;
        fh=1N387CTumM0hdajKWntoDQbkpHmgN5mf3WJcn4Om8D8=;
        b=DcMU9GSM3HfB23GEk7BWkRCym1AuiXtJS3JRnYM4vyZ04qD/yVnGrDXGPC8FuaYKgA
         JRSdYbsi78cqwuJlkKPs7OmLBCIexptWn42WShnNcsSRO1hkm7ztte/xWUgNHSVS6yzP
         LM6cSVWEm8ZcCeNVx0VNgSjubkYPQ/wOGPoZG7IUd93TA76348VbYlGXEG/oZ4235rhY
         DJY7xIY65zxBuqM1SM/5W1/X5/piKD953MPwsEdW+Fw4VWzrsr66WWM3Qtqjy88Og2Lq
         TztWeogxsaLypinnStNUz/ANMVVjlB/u8QmN7d3xrjuu9CHQkNoxX8Pyp6LbZOmNsUSI
         pbgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773344445; x=1773949245; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw5sgn846LlcJpvpcFjplQOqbRXGmTMg8sDtsjuZNaw=;
        b=bDxspP81TjV7JiJgBfeu7sfY1mmfnLldW1II/xr/QuaVZPqH7ZEu6UmSbQn1WWbB68
         aJnnDdnnLloW2YZw16eBi6CWz6hewuZKFqN4/31T21KnlxSUb0eByWMYYRIi62LVT/eO
         9QOdai3L9ck5A0cv29etcrx7AqPyPSHPx7Zb1k7IFson+KdACesigTnUgI63XO9TBzQq
         gygGUktZNXzqrjCtI+6WOVTvz3qKRqEmRWaIJjSknLHjuTu0hWJLMK1txF6Q283Jq1l7
         pdXi0A9vAXcRHzY3d6NiGy+g0oLhu5rChMame6xqdpi0gUFf8UeZilTFr0//jq/W/CZR
         xblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344445; x=1773949245;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw5sgn846LlcJpvpcFjplQOqbRXGmTMg8sDtsjuZNaw=;
        b=iTkNSEtiXRWO1A+v+T+RhbRb+F1KVpiijbDlaPeAcjUEaP56ewcpLP0wdQVRMOMnY5
         qiFLLJu86ij0N9VH43AfhzRlEQ88VWR2KIAg025VYfWTXEvPGRvfMjVMsUFc5D7gKBmB
         A96S/M2XFMznenB/0LFR3kmoCcpSEL4WyYpI8pSc7MJE7zh29c+m9wwdy/QFfRojC2C3
         eSsX3WxG1OCvX1cJqLynaPpgUJuiikrp/QeH7D1bCryZRct6djnu9PsXfL/xOMVQ3dcL
         3p5HMXVpcYYeJMajtIv7VSkh8zEEUo43IdJSPG9yiZ+TOVSXzCeoiOy1ET9NID57qZUS
         piAg==
X-Forwarded-Encrypted: i=1; AJvYcCUs9V+n1kOzfGg7OiiBEcsNbXg4HPXmd3GXxdhzcslkzGQ3dZYhNs9PArLhMouOegN+FwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtSuBI2UuleBpPwFRTk4OF3wgFpFHcl5B32Zem1qxRoABVhq/
	gsjD6rKymbKFa+amOFCA42QOwmNnxH7NNype/psVi6iEqvJLs3eszs8vgRCCb9gtUGJI8xTG5eA
	V043IBiVfZ9c8KhPsSzx5HuoRRdHykqY=
X-Gm-Gg: ATEYQzw5ChPacOocqlpQk7zc5A0MrcXt/RkKYZIItOZAa2xZev2dUyIBBmlXD69pGFY
	GnUjn13eYSnbCQKkT4BgWOVE9lkugJxa/NKaUj8rfhhTFf8lIpZ6Y8vnGSP6kmD+SydmKkpCfRp
	6IHf4fHwuYtHWYquWAiAeFH+1d107jp+9hl5/YsgRgB4DSJ9Mb/8McVxO/X//Lx50JVpOXHVQgg
	BmUVmueob8ufWGt4B/O1GybdEI5PwsX6QwZKM23eUSa37kmc7cbhS/EdLQO5dWGMftVke9MGoxl
	HGBI
X-Received: by 2002:ad4:5c6c:0:b0:89a:7d9a:e0b5 with SMTP id
 6a1803df08f44-89a81f9c4d4mr14970186d6.58.1773344445043; Thu, 12 Mar 2026
 12:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223165147.3294516-1-cshung@gmail.com> <abHbddcYKpW4hlMz@fruit.crustytoothpaste.net>
In-Reply-To: <abHbddcYKpW4hlMz@fruit.crustytoothpaste.net>
From: Andrew Au <cshung@gmail.com>
Date: Thu, 12 Mar 2026 12:40:34 -0700
X-Gm-Features: AaiRm50xoHZ3ybj0Tjz-L-Z3ysagzrJlxVrlQPoICCGaVwRvVghyTSPNlMHblZM
Message-ID: <CAGVkMb6eBWWo1bd_xLx6K9qAvhORVJtkoiFX+Z9X3sdYTcU+Uw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fix zombie children when git is PID 1 in containers
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Andrew Au <cshung@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the suggestion. You are right that tini is a common and
reasonable approach, and I will look into using it regardless.

That said, I think fixing git to clean up its own children is still
worthwhile =E2=80=94 processes should not leave zombies on abnormal exit pa=
ths
whether or not an init helper is present. The two approaches are
complementary rather than mutually exclusive.

On Wed, Mar 11, 2026 at 2:15=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-02-23 at 16:51:46, Andrew Au wrote:
> > When git runs as PID 1 inside a container and exits via exit(128) on
> > transport errors, child processes (git-remote-https, ssh, proxy) are
> > never waited on because the normal cleanup paths (disconnect_helper,
> > finish_connect) are bypassed. Since PID 1 has no parent to reap its
> > children, these become zombies that persist for the container's lifetim=
e.
> >
> > This patch registers atexit handlers in transport-helper.c and connect.=
c
> > to ensure children are reaped on any exit path, and clears them on the
> > normal cleanup paths to avoid double-waiting.
> >
> > Blog post with detailed investigation: https://cshung.github.io/posts/z=
ombie-git/
>
> Usually people use a tool like tini as PID 1 in containers, which allows
> that process to handle process reaping while still exec'ing the normal
> Git or other command.  It's the case that _most_ processes are not
> designed to run properly as process 1 in a container or otherwise, so
> a specialized init-capable helper program is usually a good idea.
>
> Even with this series to fix some of the process reaping problems, I
> expect you'll find other cases in Git where we don't always reap
> processes correctly as well, so an init helper would still be useful.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
