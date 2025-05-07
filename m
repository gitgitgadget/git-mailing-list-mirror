Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD0B13D8A4
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580985; cv=none; b=N9ikOWx47OMGP9+C10kK/X4eqEcArOovU1lK87E4a/JKZM+4/jKv6039Q3ksrSABYLrS2Zy9k67MD/aPXWe9OCZ+Lyn9KrSEXh9CzOXUYqHga/iozZtPgnm5llQuUiBXlmKVq5JzdJ7o7HovMdNJ0Qp434Lxy3CrYdJjKSBRH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580985; c=relaxed/simple;
	bh=lTTkdnqFwszNq7KFxcFVVqyq5HTg2LKeRH2K9XHuwdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGok50ZN6aC4gGcMI0j6y1go3fTUj0YEdZ6TJM5wW1OtiVxDd2V9g5Tc7Gp9CTW8ahv4dza6m2yFsUG1Aj607gtHZBPGBF68wefDPpmbTHYNjKIzuL7MnQAghEDpZi1operEj8ZRs2zvgdz0zLZ7gO+5ZN84Qudmgp6jKKDWDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=YU+HPSy4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="YU+HPSy4"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b03bc416962so4439986a12.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1746580983; x=1747185783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjseUO/duD+1mz66osqnXmq4dg+jRG79wgXahJyOGSQ=;
        b=YU+HPSy4zCIw4el/k/g9I1ii3sc6UlZc6Eo8PpR3OzGBn5VmDFEPq0SzhX0AamNRvq
         g8oj7UuP11wnUREuQp9/vNUq5YJrU3aFMt5Vdg9T3W8yCkjz1Qz4MKeehhzvh3mn4YLV
         /5iKYzRILLD1KIU8L7RYMqfWRDrHoX7N1Rewov54HFyQl5g3LZCx85lNTIz8LSXWRk6x
         pbJjy33ZT9BDnKcYsJ3JXIp1xkPe0BJ4Bz+lm+4xjq3UUJhHA4psgLSeO0Oz3N2QiJW7
         tpV0GQkWpBgk1kTlwZVy+J+km2C/ibdu8ajZ82Iag3pphp5OeEAr7GFwIRkFLbRtpOA+
         OZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746580983; x=1747185783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjseUO/duD+1mz66osqnXmq4dg+jRG79wgXahJyOGSQ=;
        b=Vo9bKPksVrZVShYNPrpxYt1Fg84qIcKtSaSUhOCgZz9b+Gru/54rTi6d3++8SBosui
         27ifXE14lWxitDUAU8puIHSoqcJ5sP0XmLLKLYcmOdTgVmMjRFkx6CD1wJc2z/3KC/Nt
         RBUl/ZtXsKS1V7E6gKMxNPhC0a5LsUAglOa+pXydyhm4u1aWyAtcDc32U1weYP4SzCIK
         P3ZsjFhV45nwVQP/qaYZRcHHeuOtOSkwg5+eu9veUedDYddX+M7z12YA4NSnyYS8ltd1
         7iXtvZp3wlH6g+BY4W8nkpCpFd8TF/RoqOUXt0/L5CrcMqdNNVwmlpkHJPBVOQ2YEKKN
         gfZw==
X-Forwarded-Encrypted: i=1; AJvYcCW/PHgLCvAslVGXSTue3MN5aNw4gXUHvsiQ9aJIfy+2x9mb4szjRdjeowUL+aHNz1+qx/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjLqL9TzVuRbTkiL6990feq+naWWJndZFGYN52qCPcu1Jjuto
	k1pl5ReCNvOipj41ORxpVSGp3T8hVHAS1tsfCWL5Urykw7fkl7Nne8tuRlWLPSCLFiZWjVMe6YZ
	27dh7hskVkF3XPxgAyPeiQ6H6ezHvGYKuHQJXyKZEkaaS5XswN5aJBlvZ/XDmNJSFethRV3hfYe
	GAbY0v+anaxQroyBqz96iVx9ruMA7tyNOM8SuuIri+Apkh58BaHW52hrLo0o+kMGgVsoEdztDKm
	grTJ/yzJYRSxPUzaoIIcoWICG5EQD9oUI4aRm7UUpGbOcYGnphhWsAt9AtL1p6zSZ+bSkneAVhU
	mPgh5D0yJpg=
X-Gm-Gg: ASbGncvigXkk6As7jiH+yRY/lics8M/T3KkXk91GmytYmsCkCMOIQgRMrD3AfN2TpDs
	51/MGQ4ucNSHM6hE5NrP3zAdEHtil0Ex0R3cK8xE4O9VDW9cPqo6Dv5LvjTMqhsaT4bnk5RVmOH
	kcKGR+JNEZObJ/oxmgJSsQuR1odqSKeFkOqA==
X-Google-Smtp-Source: AGHT+IECEsPyrizRObFofPMPLLsk5A0MZ8VQ8hlNNi6iD6J/G/UVYMw81viPzd+fkH1KrL3x8Rqw486igg9Udm6RifE=
X-Received: by 2002:a17:90b:2786:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-30aac2c0015mr2106395a91.29.1746580982927; Tue, 06 May 2025
 18:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de> <20250506120644.186968-1-tboegi@web.de>
 <xmqq5xidlkvv.fsf@gitster.g>
In-Reply-To: <xmqq5xidlkvv.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 7 May 2025 10:22:51 +0900
X-Gm-Features: ATxdqUFSw2q9r5mnmzdfSqTyUtKCO-IANYhTE3mXfm7X6IGjPd4K8QnBqh9D6Lk
Message-ID: <CAOTNsDy4YcOP9H_xmUDKRdGuEu0GABDj8sM0Jt+oPEo7JVSQ9A@mail.gmail.com>
Subject: Re: [PATCH/RFC v1 1/1] intialize false_but_the_compiler_does_not_know_it_
To: Junio C Hamano <gitster@pobox.com>
Cc: tboegi@web.de, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:16=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> Just for reference (as the proposed log message refers to an "older
> macOS"), do we know if the toolchain on a more recent release of
> macOS work without this workaround already?  It may be nice to tell
> users what version they need to avoid the same issue in their own
> program.

I tested further with Xcode 14.3.1 (the last version of 14.x) and 15,
where the former still had the issue and the latter worked without the
workaround. Xcode 15 introduces a new linker which seems to fix the bug.

cf. https://developer.apple.com/documentation/xcode-release-notes/xcode-15-=
release-notes#Build-System

Koji Nakamaru
