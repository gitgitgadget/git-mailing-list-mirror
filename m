Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F61FF1A1
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012094; cv=none; b=M7Xf3rgW3p7DYBXuJIVYoie731gtcgwEkHbL0T7rqzTJ5+W86i8Tr6sOL8KIK5tkVXdwar159jRTj9nXdRHgTfGpFnSYzmP8YpEDnI/e5So0C4dDSE8rhbfhfrH83gqCE4jqenRh11zNqTqqT2KLuy3xl9Y28kfM9c7Y8lNb0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012094; c=relaxed/simple;
	bh=6ECStTAyeMkTca5cDnMuvQY7+OdzAH1gTbs2u0wdr3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQYq8yCQqjxo6ekCSFB33dkVY7URQfi3JCNR0d4l2q5U/D4VVtzmwWw/2ExFVICXDHD4aObK9jmylPnYlBwM/A7FMz9pkvKeP/OX5mbaeqhmUkopBgh9msgG6ETSTjQBVZ+owxtUpYaIJXzaRv+gSyaZvgGKwACFv/cD4Sz4NiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL4nlDmy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL4nlDmy"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3dda399db09so45561905ab.3
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752012092; x=1752616892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4ceUD4O23CSWZ7BoQuyIJ48ffssTi+LMpy83QV9/6E=;
        b=cL4nlDmyLWlfJxgZ7jFx7sR75PjI6B49/YkO7wnlMH1P9rPlx34xiRPx4mqdU+KUrX
         nWCtRS5BuSP96xQPXLL+KWzA+RD91s54XaGwDx5hMsGYNDfAtw6NwbpKzCjRacaryfyN
         xYNUvycLymCbMe5Za6YykFBnC3MlUJy7o+Sk+tc566GvEESLHOG4Bljx9sRVrXyv1GPH
         dIpGKoTLM9HN7kiAeiIA2HfYSof6u5pLaP/Q3nwT5lUVvmHLVVGohhtyO7p8bcC/CxaZ
         uGO0cAI0oZgEX6qehRoZEMVf96cL+JdAynGf80cdpgdF0H1K7ujAR1b6BhZjczKzv1bx
         OuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752012092; x=1752616892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4ceUD4O23CSWZ7BoQuyIJ48ffssTi+LMpy83QV9/6E=;
        b=CaXU/zEjghPkyjh7sAPY+eNlBjCsn9Yz7bontDEJjGYNIRGzJanjSKeu8AeMP0UZMM
         8TUHB1heOGRGBjKx4J0pxnF2W5qEuYGm9rm73y+g0fbCC4jhycBHT1X0SuIYRz3NkicU
         r0P8MV0NAfL6a5kaxiHCQukBnbsfiQffhKgkEs4s7MN9+sAzLm6MULhcmKbHsmiNOU2P
         xbucmopuLPVddCRDvrBxRordrmWf49X1XBcdjS4uTdZhlv+jtmYT38fH4UO1Yt7EGxd+
         yDHe6YoYR1fsges79gEyBngQrF3OmAxB45LF//nMJA6BlBT/vLqnXXbKYhOx7NCKi8md
         biDA==
X-Gm-Message-State: AOJu0YxERvQI3Mqvv3UTdZ5hbAQKZGOpVp2o/e9yLqFuLxz0OzRIgY0t
	EGIT1jNk6ea4MjBDDNdeds5ieWsLXZUU+JPUSRbS3vhBmK9fWda2MzV80vRcwKnz5AV3DzEnCkv
	Gf/GN4CTkFOoliywN5RNYJYUWxCkIQa8=
X-Gm-Gg: ASbGncuIQTRwtVnS3ll4/+2GcXV2tUqt3eRk4rfZ9mQuji5JrOLCIqv1q7j79tfsSwH
	6ZszM45L7o0kvG2vYsgc06O/75w7jfbvuEjeexLwy0ar00hhCrE/ciWEn5DENTJSN+wI8WJm7Ae
	VLuT+ZPQEvyr4fgA5lIQqjCRpIXGzBCns1TqtBYFKA3zxe8mI9Nj2C9eEopvzJtyWxc0Vc
X-Google-Smtp-Source: AGHT+IFXmGwusTS6IazXHq+eSVSDnMw1J/czqPYX0GFY9DRv1dpG5ryFHXMz4E2bVDeeyEMoTp38BK49iSAh6k0tdsU=
X-Received: by 2002:a05:6e02:3b85:b0:3df:49fa:7af5 with SMTP id
 e9e14a558f8ab-3e167111fc3mr3665585ab.21.1752012092090; Tue, 08 Jul 2025
 15:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com> <CABPp-BGSEsQ5Ljm4j81VUuM+_U6CJYDG64wKxj_-oEK=WVD4iw@mail.gmail.com>
In-Reply-To: <CABPp-BGSEsQ5Ljm4j81VUuM+_U6CJYDG64wKxj_-oEK=WVD4iw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 8 Jul 2025 15:01:21 -0700
X-Gm-Features: Ac12FXwxX4o5RzNn9RgpILjH49ydhp4M13bpQzcqpS-5dccgaCsOe3bRiKBYxT8
Message-ID: <CABPp-BEh5FdPSr84-YG=Bw6fBaE1P2s8Zcy5D68bSZ+_nsQrvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparse-checkout: add 'clean' command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 1:36=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Tue, Jul 8, 2025 at 4:19=E2=80=AFAM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
[...]
> I'm also curious what happens when (1) you are in cone mode and there
> is no sparse index, or (2) when you are not in cone mode.  I suspect
> those and the questions above will be answered as I read the
> individual patches, so I'll keep going...

After reading the series, I know the answer to (2).  I think the
answer to (1) is that it effectively turns into a silent (but not
instantaneous) no-op, which may be confusing for users.  We might want
to provide them with an alternative implementation, or at least a
warning or error that the mode doesn't (currently?) do anything when
sparse index isn't in use.

Anyway, I think the series is a good direction and you've explained
the motivation very well, but I'm a bit worried the current
implementation might be using too coarse of a hammer.
