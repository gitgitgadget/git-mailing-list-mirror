Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BE267F64
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397019; cv=none; b=uSTuvobZkIrbZmJ1UTAn+2nsU66b1NStQ/NyrnQ0lYyqXSLSNrbMw0LDG/0dY1UiiFZvbWHUD3AFXLa57l+O62qICdhNDtdWASJWcRMoZgsyXIkKel20fwT+2evNMwDMvSfIcePmyHZJQk1Nemh8OIbOMGOzivMFzHuD6NCfgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397019; c=relaxed/simple;
	bh=a4gFgE2FVCrcH3xwyiPCmb3LA+dUMXi4MCCZNOUqCOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+1Ox3k1OSs7JeWNhO71pEU6W5tN9vQr6atoAs+J72+wnas1TjMUUOxtKgLLLh18F1wlmYgVgz5AHaB5LJjY3XifoI17PkcjV+2T54kj/GG32K/a/1YBAl9kQzzvWIak0rWNstj8P0f3F+z1yrNxNTXx18O7LFtKal/SBkPfalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHDrL4hw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHDrL4hw"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so3876237a12.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744397016; x=1745001816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4gFgE2FVCrcH3xwyiPCmb3LA+dUMXi4MCCZNOUqCOc=;
        b=jHDrL4hwN+vm7GRmQtdlOcJ9oXE8aj9rNwuNLfMLa3GaPjey/9v2hrMLY5wSKEgDRq
         xb0l80SABdDnEWXmSGDPaXuymDjzJB/I//Zmw6Kbnworkulm/Q94VSXOVrDM7lUYHBKL
         snuuUPVxR7Iost5jJ0W45iqaiuqVIGD8nlCIoBev5nn0qrg8ZfsOO+MkQfx4VOhJYvKk
         k/FZKCiIdWqB2J4VcYGpNBVwXzMhcla975wqJdWsQ1bkNSJET+K0A+6vMgRQ1XLJRxKn
         tTZ3cRwbE8ZXpz5VikCK2nQliMuFuGdqPhAAtWwhWS5TEl2sYCD6mFS+Fbo22bHw8zO9
         LWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744397016; x=1745001816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4gFgE2FVCrcH3xwyiPCmb3LA+dUMXi4MCCZNOUqCOc=;
        b=HcMkhyoTaQlzM2gLa/wqCTbG9f4YyyHwgy8pCKBwIiy9LY3D9cPADuar6uG7Vk/WLk
         ywqzjIAieZEKT6ypVIicy9JygzHSTBM8hVTH2VDROUy1gKIYsMLzVd4EleBxj3/OrIUo
         Ml/haUyuYPWzW8I3bLD962CVLVdP1QTPsoNbyyrQeEuGutitdJuSJS1L5qDLBNI0rdIh
         P2dwQE9MHieoSQDy9orAKWSXsBjhLh8tMADB7uF4UFNnTiRGM3SrJC9UU6GMuRlg8+27
         gN/R3VX7qKkcNUAtaKu2A8M79YZ9Feq3apsLfVN3Fxq50PPyXvJsqwZ5mVdOcN/bRKbF
         JSmQ==
X-Gm-Message-State: AOJu0YwFZ99GwtZNiK2lSLdp7BFMtM03DZk8LxKE8NFl6wSqw2c/Cqnq
	CfN0wdbfJ+XTA2GG1zDo10+VBuGTdXlusJsfaFTlm7yUrSzdG1YFGU4qt0BwR2pOH6LvifyRDfD
	u+FO3Vw0TlJRjQzep+DzLJXOErbpeNlRb0fvxFA==
X-Gm-Gg: ASbGncsO10NyZ2VybpJwpa0NPEB09lFKMHxjPMiDdoC6qed38AGdU6A59/ys7FdcAlN
	ijW0+PmgHgvMQEMnT93hRZmPPHRYN/86JgGN885dIMrt/32O03U1mF2kr7dn4jd9WnOJ71cy5VP
	V8sgFCPZ4FSRuE48MmaptWDJLkD+46Ob1Breo4KwltEE9k3Dzpsazileoi
X-Google-Smtp-Source: AGHT+IFF7Pcbx1RrO/koUy7zAcoKDX91vijqYLuImrmiq3Ew/6Xhc488YquzluANeU5/3g/5sURBnuNLcoUf1CU311w=
X-Received: by 2002:a05:6402:40d5:b0:5ed:4591:6901 with SMTP id
 4fb4d7f45d1cf-5f36f64752amr3119171a12.8.1744397015589; Fri, 11 Apr 2025
 11:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2afd91ca-13d8-4b40-aa8b-c1917f0882df@frank.fyi>
In-Reply-To: <2afd91ca-13d8-4b40-aa8b-c1917f0882df@frank.fyi>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 11 Apr 2025 14:43:24 -0400
X-Gm-Features: ATxdqUGSp5ZgLhUlhKP5_75Ry4rP42aJZJbpuZ6W_IdbnZhHEbCHiw86558PfHw
Message-ID: <CALnO6CCUHE6-RcZkTBYT-CeXHnYPBPe1eGSogWd7=5tK5NyuxA@mail.gmail.com>
Subject: Re: Way to "impersonate" remote or sync remotes without fetching everything?
To: Klaus Frank <vger.kernel.org@frank.fyi>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 10:01=E2=80=AFAM Klaus Frank <vger.kernel.org@frank.=
fyi> wrote:
> Also not to mention that none of my current approaches can do a real
> sync, they are all relying upon having one of the remotes designated as
> the authoritative source and if any of the others changed instead it'll
> just fail.

Maybe I haven't totally understood your use-case, but what if the
authoritative source is your local repository, and then you push to
all your remote mirrors to publish your trees? That is, I don't think
it's a good idea to have a remote worker automatically pushing changes
across all the mirrors; rather, you get to be in control of when you
push to those mirrors.

(I thought there was a push-equivalent of remotes.<group>, which I was
going to suggest as being helpful for this kind of mode where some
remotes are your mirrors and others are collaborators, but I can't
find it.) Configuring a new remote with pushurls that point to the
other remotes [1] seems to be the way to make pushing to multiple
remotes easy.

Of course, this doesn't help CI, but then it can just pick any mirror
it wants to fetch a commit to build?

[1]: https://stackoverflow.com/a/14290145/4400820

--=20
D. Ben Knoble
