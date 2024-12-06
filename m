Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27A1925BF
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 04:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458998; cv=none; b=HYbvOHpCCyMEaOd+jPOuJGebdHgSB9YfNRltLAReybWiMLMgAt0vRlAE2tuxy1XOYGKbLR+Gf784RxvGlzLFUH4iQdo5bnJ3ob9P/73amawkhire9sTsUIayVqy9yMU/AqciOL0l3UMrjOg2zxf+/Cg6aQmDIQLTcg+PQksj+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458998; c=relaxed/simple;
	bh=GxuqaTB+Cpz4m3KTpG0+oavngWiBuuJnU7O2I7tkyjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfZezZK525MnviNIhl9Dc1REMDSS6ZZZdNz/j2Lbf9c9ReKwgwfCA8+jFDSVj7BBTta6QKdwY8k4D11g+Ob/GUiYO7jM2ChaqvN3fXoZpGceAQ9w4m4odP8+FDMbEoBchfSRlhr9blElYOVv1saJSNeeOewkYuRIC1/K9HD3EWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=W/L9Hs4H; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="W/L9Hs4H"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5438c6ba7so27314366b.0
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1733458995; x=1734063795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxuqaTB+Cpz4m3KTpG0+oavngWiBuuJnU7O2I7tkyjM=;
        b=W/L9Hs4HRXHiZg21ZJzUFNdlB2Cs9LI0+dITYvgjsA75K7Q/s0wK+QM/JE6zF+rDAO
         Dm9PuGInOZ5Tnm+adpiuvInotmIPE1mq+pL4Twp3TP+nbnujZiEK/NVZgTJ4ZcEcby3a
         cP87nFuLgQMyZRsW5tZlXTYVpEEaaTL6hSve8WaBpaQOF5kE3txfhHhCsiGmZv/3nozQ
         YQNEOr+i3rkNGSivCM61AhvC0XObxe0QAiG5KYLXsKZ2FuO0EeBqdf1WZ1HVH43gosuX
         yKw4TAjVCBUkTdXbs7ovEU4HnEcFuEXT0SAF6x4KfAgSqp0NN1WGk/QVXFzNrfrLxUDC
         v2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458995; x=1734063795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxuqaTB+Cpz4m3KTpG0+oavngWiBuuJnU7O2I7tkyjM=;
        b=Kfp1A6yx2pFRE2jr5QPV1B7h+B5yH4WLQ8V1EzL4+DMMQzUUwyhoJYUCUEveqJ3ib0
         X0odDdCSVhtjmHqcQlw09ruyVkDHF/W8ZfAwZpbBhuiFEMQ/S1+JAB763ublhDlCkRbT
         JAetU45hO0ja+cSoUu5/lhaXGmX2aOscn84lkBxUqj/0oV/JaABc3m8y/IMRGHu+tgv6
         KClWS31gRebOQ40prS02zD90LcqW2BbG/0VcHMUG15pcWzU9yeCzCsbVS37/4YX9FwSr
         QaQCytz52pkEcP+o8E3ed9nNWe+6LkHZuZVKtrYoW9qT42rRVwSYLWrfPLwJEhr88nhH
         ff4A==
X-Gm-Message-State: AOJu0Yxj4mxjaskJWE7wt62qMNVEDGXoKx5buxYHdsG8z8LLB4AAngfw
	6hT5dwhvPOf21334qCRk0qZVEB5SGzCQVJXzkLkrW3h9WECumSyqe+nDZqoa0IhuMjLj3qt0pLI
	LY8MYGRwu+ynX9ZuZ2BDV1zyykBNWYZVGfWg5WIh2YbKmPG5UdszR
X-Gm-Gg: ASbGncuFlph0S9UIxr/p6mCHcBq+oasnSgrkIb9r8GrwJVPvBuy7JvSVV5xjaOjpOqt
	wMXb7+ZLy/yhM5TNAW7u7Np8Bwt5R24yc
X-Google-Smtp-Source: AGHT+IHWkrGpe5dsydbIJBU5cKtVZoHHzLomF/GZ/fgJH8IILSF+9AAHBfPbi3WmS1+27XLqYinAqId8aPY+qquHSFs=
X-Received: by 2002:a17:907:7291:b0:aa6:193c:f391 with SMTP id
 a640c23a62f3a-aa639fa5d53mr45065666b.2.1733458994694; Thu, 05 Dec 2024
 20:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACfnds=++C75pg8ojn5sJzjKzLcgnyPxgR2c6pOPCRmf2rDKvQ@mail.gmail.com>
In-Reply-To: <CACfnds=++C75pg8ojn5sJzjKzLcgnyPxgR2c6pOPCRmf2rDKvQ@mail.gmail.com>
From: Manoraj K <mkenchugonde@atlassian.com>
Date: Fri, 6 Dec 2024 09:53:03 +0530
Message-ID: <CACfnds=J=Q+viagTEoiQ3edUxU8GSY_s7=biGUGY4NKbQpsTvw@mail.gmail.com>
Subject: Re: git add -p is slow for sparse checkout
To: git@vger.kernel.org
Cc: Shubham Kanodia <skanodia@atlassian.com>, Victor Chan <vchan@atlassian.com>, 
	Shrey Somaiya <ssomaiya@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

++ CC

On Fri, Dec 6, 2024 at 9:16=E2=80=AFAM Manoraj K <mkenchugonde@atlassian.co=
m> wrote:
>
> Hi team,
>
> I am currently on a sparse checkout repository, and it looks like the
> `git add=E2=80=94p` command is much slower than in a full checkout reposi=
tory.
>
> When run, the `git add=E2=80=94p` command expands to the full index and t=
akes
> more time to start showing the patch.
>
> Also, we have git trace2 enabled, and the timings of the subcommands
> gave us an indication that the `git apply=E2=80=94-cached` subcommand is
> taking way too long, with an average P50 of 3000ms against 300ms in
> the full checkout repository. The other notable spikes are in `git
> diff-files --color` (180ms vs 80ms) and `git diff-files --no-color`
> (180ms vs 80ms).
>
> I am really interested in understanding why `git add -p` expands to a
> full index, which I believe is the issue with start-up regression.
> Also, would be great to understand the difference in performance of
> the subcommands.
