Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40694A06
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077588; cv=none; b=PcZme07we1vYoPvZciZQ1lIJ4LMaIUqm8PrCVctPsLUecqgr1VDW7vu2dgZdl8mJqbuvSCPsAVZT6U7lrYYIzhixRLNma8K6rC03/scv+8puVPhNz7fqZRQaTNaMI2ZnJOvZuapb7vfvIje3v/E7FwtxyQ8F0+X5EvYAAo1CNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077588; c=relaxed/simple;
	bh=yQ1fXS7v1X5tYl8Stu+BtCgSOm/bpxAbOF5Z0hIPTu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV6RtjsQsKSzD+DRaAPDqIeJuqsMiISiqbxjbxktJpYcCRbvW7xPZP3TokYrEIaHHeYzVhBHiT3230IchtSaA6bJzsr8y2CGtHPLKDLLOi2qjLgjlJaF9BsQqzXQnUnftzrZaQmYHot7JVlGlrmaCNs5KiDa12nb8KxLaIqTTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euFo2S9B; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euFo2S9B"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a46c3b3a5bso782126137.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760077585; x=1760682385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUUikiCO//9XDRbK2eKFFAZxO1Q2cEGdE+yiNhj3gyY=;
        b=euFo2S9BbzzpwuU69M/Tq0IHwb/m4GkxIb2THemxczUJ8RlQf+hd5zGDu4aAGRGD3A
         aqGS9MPzrivLnh5+H8YPSHqkGv7KRq/p4Zdj9BdnsMwOUkBkokPal8WBL/lKGm6/dyEQ
         ybCh+0w1RU5DPMhNSZel8hqJcIraSKmIgD3/MWFUEgz/iR+g4OoBffhw1q9Tu/pqeOZD
         QwOzjb9uD/c7+D+8jVPMGS7igQKuMAFuCXVpD+2Xv7kZzsNTXaE3GYRgyC8NuJ1XMHxg
         psTcXdpFY1RzXUMD2MHG5d+SpciJZZ/RVlIK/k+ElpNQiRmBniiOWO03aJeVc/ysA0kR
         gnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760077585; x=1760682385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUUikiCO//9XDRbK2eKFFAZxO1Q2cEGdE+yiNhj3gyY=;
        b=cVxez0ycUzmgyWlUBMPbj43pkmFnTzkuk1DkX/+gzcdg7RiZin+afNV+A8cTFAUyOv
         cJQVVCrMr3t9QTxzCNSI73HzeEa0ekoEmFE5vvMoMeLNdVIps6x1JWSkKhxS4KhW2v4m
         xyegnZ/3x4Qz/lvDV84s1YxBEmOmXSuK2L90/GmUCsKwz+8bJ3v3n1UL8LcNtcnGe4c/
         ci/lOPrqhxdRcQvEyAjnz9gQj0YJ7LgIe7KHkIQGn3cUZB+WDlkP0ETC00M0YZ4ZatkY
         BE99lkZ9XGyRbS6Y269dPIAw5p+o3IUgEOtI7hl3vK7yBx/yyWNko/CCSqPO+ExWm9fS
         H0kw==
X-Gm-Message-State: AOJu0YzV15kJhz2IIh/2AKYV/R4XTctLyQlOvJnCbnWx7YsXRLdUXKMZ
	PL02nKYN0PP5PwT9O0Lr2wRzzpYf8gnNWS6nOY9pPsk8LUyOxEqmEQEPdvw1rHED4dydUzL8E7u
	c9jv/A7ZeuBzo5xgJHORECnq1cG3dMiI=
X-Gm-Gg: ASbGncuasz+0SeIU7z4TW00b+vn4dw4flMkbvd75xA7v7Xlv4EhiVMVpNpMv4IELnUI
	eYz4Y+eLnDxFPkrRnxCFVpmIj6MRhQ7f/hRpKLY1hyl2o9aRvNyiDXqrTlb6YzWdNGQGcH6wdUc
	lAGQ/uRAfByZviHYHSxO7ozaas9Of28bry6frdOtSdbfeQN3JVSCkJJ2mZF29bW8+YyJqettVCX
	i2gijN/0nd7GOLHkDw8U+PqKuyh/YDgoBLD7GkvII0mdvSb2H/gg/AnVkqlhzeN3nou
X-Google-Smtp-Source: AGHT+IGMxCfJIowqNbO2PUwpaNP3wmvXBYTo1r36LgwV7b9HGlUbptMK3crNNHTTcdXou6fR6LaVUn3ny9lHzvFl0do=
X-Received: by 2002:a05:6102:32c2:b0:508:aeba:ac31 with SMTP id
 ada2fe7eead31-5d5e21fb6ffmr4655658137.2.1760077585284; Thu, 09 Oct 2025
 23:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
In-Reply-To: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 10 Oct 2025 11:56:14 +0530
X-Gm-Features: AS18NWDRt1ylEsXghlyCSv2vipdyk0bFdJ2-_Wo8k-2PF0o3XzV-BVKsaxlCxJ0
Message-ID: <CAPSxiM9yejQNQtw22Q=s1PrG-vUGBX5DiNQZMvyHACcXVfOtfw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtPdXRyZWFjaHldIEludHJvZHVjdGlvbiAow4FnYXRoYSk=?=
To: Agatha <code@agatha.dev>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 3:39=E2=80=AFAM Agatha <code@agatha.dev> wrote:
>
> Hello!
Hello Agatha,
>
> My name is =C3=81gatha Isabelle (pronouns she/her) and I'm (yet another)
> outreachy applicant for this cohort. I have some experience with C,
> developing mostly device drivers, a couple of patches in the mainline
> linux kernel, etc. I also do some assembly (x86/x64 & riscv a little)
> and C++. My goal at outreachy is to regain experience to work in
> software development again after some personal setbacks took me out for
> some years, while also contributing to an interesting open source
> software project like git.
Nice to hear you are interested in the Git project and hopefully you will r=
egain
experience while contributing to the Git project.
>
> I'm looking forward to interacting with the git community once again
> within the next few weeks during the application period.
>
> Currently I'm looking through the documentation to get a better grasp of
> what is expected of us during this period. The doc says I'm supposed to
> send an introduction e-mail, so here I am. But I don't want to just do
> that, I would like to let you know I'm also working on choosing a
> microproject -- right now I am exploring some intersections between
> git's object model where objects are immutable and tightly linked to
> author metadata, and possible privacy concerns. Especially for people
> who would like to exercise their right to be forgotten and transgender
> individuals who might fear former name exposure in places where this
> information is protected by laws, tackling cases where a simple mailmap
> entry won't be enough and rewriting history would be way too disruptive.
>
> I want to see if I can work on a microproject that helps to tackle those
> privacy concerns while keeping objects immutable and preserving git's
> design principles. As it's supposed to be a "micro" project, I plan to
> explore a small, concrete first step rather than attempting a full
> solution. Yet I would appreciate any input on that. I have a couple of
> ideas in mind to check if they are applicable too.
>
At Git, you are free to work on anything that interests you. Meanwhile,
the Outreachy contribution phase is not that long enough to work on
some issues/tasks/projects so, you might want to take that into considerati=
on
while picking a microproject to work on.

To iterate, the main purpose of Microproject is to get new
contributors acquainted
with the Git project workflow. [1] gives a good description of our
expectation for microproject. [2] Gives the examples of Microproject
done by previous contributors.
Other important information can be found in [3] and [4].

Just to iterate, you can always work on anything that interests you as
a microproject or
after the microproject. Most of the selected past interns whether
Outreachy and GSoC
finds Git interesting and they do send more patches after their microprojec=
t.

> I think this would be of actual significance for several groups of
> individuals, especially for transgender software developers who face a
> lot of challenges to get in the tech industry, even when they have years
> of experience. While in some places linking their current names to their
> former names might even be dangerous, or at least lead to embarrassment,
> losing credit for their contributions to avoid exposing deadnames could
> also be a limiting factor towards obtaining employment in tech.
>
> I=E2=80=99d be happy to discuss whether similar ideas have been explored =
before,
> or hear pointers to related prior discussions.
While I do might not have much information about this, I will allow
other contributors
to answer it.
>
> Best,
> =C3=81gatha Isabelle
[1]:  https://git.github.io/General-Microproject-Information/
[2]: https://git.github.io/SoC-2025-Microprojects/
[3]: https://git-scm.com/docs/MyFirstContribution
[4]: https://git.github.io/Hacking-Git/
