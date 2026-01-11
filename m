Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B779125A0
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768112149; cv=none; b=K6wvSsCnOMq04syVPpYGhxcTi5uDvCEkHiDBUjpy/LIuSVEaUsKFh7BcAt/ZbkIva/eq84mW+d6ATBLFTv8aR5yaf6WUNwjGzfsb8ZJGwNIo+jc1Hzi0bx0wSP2cAIe7yh4eaGGqkIDALPZv+0u/nismJDNFI0dl6hoEPQcGnA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768112149; c=relaxed/simple;
	bh=eWqkH9WvrTeFGlo+6Kw5neMYAVqdyox6vkVHbPznnvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iBXsM3yC058Yt1c5/OKAb77PSIdIj2FvO/60zDPNGYobj1mOLN/USUbccOJ/TYEOf1WU7xe3POjzx2XhPnHpSQYyuO2lO58h89etrqCqkRVdCzgWummLoLIc4INerO8VsUKmbxjPlF3LYZsf7rF7EDXap6uvJnQ1cKiEL6vumxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOPd7rC/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOPd7rC/"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3fff664b610so896335fac.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 22:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768112147; x=1768716947; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Jbt9uLXbDuhoIDdTuHtif3XLKp728HknxIsd+p7Fjc=;
        b=SOPd7rC/3/pFAhz1z/owxp+wPxH9B47li6jloYz5rmPD9Wfc3Ki3+F4kL8Ed2dHmmO
         7IIqMKpZwAFdbDboQEcOYfKi2vn0M90PrwB6xmTVPz1eaSk5X5tlhZLL1+5DH4DcL6Oy
         niqe85+b3lEVE4w9tEBsxr1LYwjYZK/pbKBz9fGKO8k8Q3ctywz1ILmwV8KDbF2WiV6Y
         lgOXdVoVDwqBnQDuj2DoyivU/ehzw9zD8BxL3+aIqgfIWDO3K54IWFPps7O3n4bSgnNP
         6/Is6UCCB964+U17noiI0MGa8qDwphmjNV3nERS6dnm97I8tVIdq3/H/rWaEu1HjpoB4
         g+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768112147; x=1768716947;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Jbt9uLXbDuhoIDdTuHtif3XLKp728HknxIsd+p7Fjc=;
        b=U9soYYJrmnO7sNJ3W/R2aiSVGWvIsur53Fov1XlEseSCvGOt1HdxBkD0dQiVeDMhB5
         hWrYBlC7ulC/2sRRvrI6OC4ZkjtsQr6a4F/wnqI7KaBRDU8nNS6BGEB7aZnzxa7g2Vve
         j1VmMQTXkSWhuf9zJqgZ9eM4tZQjwWeAvt2QssDejkH5ZvDG5UYFqdK2dvnD4GIQoGWR
         m6l5u803tSd4z7KAydMNzMUm7FRvDXPZQxYoNperJyeGjWkP1w5hS9xCf+xMS+QDf5Ba
         CtgKDubtjIvEfhvECyJZPI0cMYti6UOxV5fSPb14y6+UwDAVHXKF9P9wQJrk4EJzMq++
         6ZGA==
X-Forwarded-Encrypted: i=1; AJvYcCXYn5wL0chiH9wu6VyMIkfcNI+J3t6snOslLKN9TZIgEYq2JJ75P5FD/bSEo+DC7oktC00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8yc0k8Rnetb6KluHLJiG4zGlqS26D4SJbhNOKbnnSKgAIL8n
	jziSCCFepwWNFZThrNhsdBLorj9gtb52bkUQmo19HMleidlQbIuvHmrkBfOxHq67CMhQHqDeXgS
	zx7VHL2CmqCHyBhEbA8fRy7Wncqrh9XRQFg==
X-Gm-Gg: AY/fxX5kYd3ebJsWeXdeI6hCg1Rvbigd9hHg27hSwQd2WzS1VwtgVEvDJUPZ9xehCsu
	0yBbsJ2eVFofac579Q5uQV1E/tJ82I0CcA0/ZT2y2LtMan6bO0fA9gGHaD/7FmG0RGVCnXUKEn8
	11/Q467O5m+9g/mn0a/pacI4yK+pQDVV62Xb2p2aWyV6RKyqOAAfF78U9XM/mgPUSZjxe9kQ+Wj
	Esgxq7C3DfG8BrmDmeEI3cYsmWxPj0Wvz0yTR3vBpE49Oob+tdmB+rgYswLbCYiFOga4cZYV+w5
	YgrdXMHCKPExhnVQ3qslabrT4dG7+bKWSIo7fdY=
X-Google-Smtp-Source: AGHT+IHa4hXOqUsLsgkSAdgbXh2GPUWb9nokAX7lD+UGh7WVEjqnD5m67wcUDhYAGjRlSJbUImdx8aCsldA88/eg18Q=
X-Received: by 2002:a05:6820:6ed0:b0:65f:1891:595d with SMTP id
 006d021491bc7-65f550857f0mr5462651eaf.77.1768112147218; Sat, 10 Jan 2026
 22:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im> <20260111055859.408891-1-newren@gmail.com>
In-Reply-To: <20260111055859.408891-1-newren@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 10 Jan 2026 22:15:35 -0800
X-Gm-Features: AZwV_QgYMNTpSaXclekKcHWym2a6fHoF4mZkNg9zwhq0BsjcA_js3JLbe4qBdyY
Message-ID: <CABPp-BFOqa5aTYgQEqxGF-2WUFiM3uTfwyNmvu9BaVFxYPpggw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Some
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The subject should have been "Some fixes for ps/history and replay".  Oops.

On Sat, Jan 10, 2026 at 9:59=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> I've been waiting for the history series to consolidate before
> upstream some local GitHub changes to replay and adding some others of
> my own.
>
> So, I figured sending some of my suggestions from my reviews as a
> "SQUASH ME" patch that Patrick could split up and squash into his series
> might be helpful.
>
> Plus, I noticed a bug (pre-dating his series) with handling of detached
> heads in replay that has propagated with his history stuff, so I added a
> second patch to fix that bug in both replay and history..
>
> Elijah Newren (2):
>   SQUASH ME: Fixups
>   history: fix detached HEAD handling
>
>  Documentation/git-history.adoc |  2 +-
>  builtin/history.c              | 31 ++++++++++++----------
>  builtin/replay.c               | 10 ++------
>  replay.c                       | 28 +++++++++++++-------
>  replay.h                       | 21 +--------------
>  t/t3451-history-reword.sh      | 47 ++++++++++++++++++++++++++++++++++
>  6 files changed, 87 insertions(+), 52 deletions(-)
>
> --
> 2.52.0.410.g227cdbe8e36
>
