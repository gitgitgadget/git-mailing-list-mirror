Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A314280A39
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024075; cv=none; b=YnSfZsiTKqOdzFqVOst9AFKnPkR7TsupTlks+7DmTsoRKAd7TUA3bBZx3Qiq8ct2C9SuyN8l+sdJV55qcUQcNilTV7DPbD3NO2ORoMFuyiCfoQQjAFVk7jqUQBjk1F4iDGyqunoDdB4t2+4epZLmcw047PrTlTwGkVbj6XmXvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024075; c=relaxed/simple;
	bh=MDpdN4kNTpLwc7wS3eZTOoxqnRaurdfZFoDe00t9yCA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gMO9mhnYbXB7d4udFHxDdkTP5G9MvSYkay+V2K1k1ImgNgZ84ECYW/hjaYP5p4btrqrnByqEAi/vUKo6Zd39r2zs2ENwRciG0Qb41ALTfAvwKbYzHipfWcx0ZFfrscNJIYiqanVlIehf7IQSDHkj5A2xRFmQNuSZnW27zbYp35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWasjOuV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWasjOuV"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4586576a12.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749024074; x=1749628874; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MDpdN4kNTpLwc7wS3eZTOoxqnRaurdfZFoDe00t9yCA=;
        b=LWasjOuVkBvGlfYd5/jUboD7RGYTsZZnO7Xfyoe6u6MPCQaDshmkY/Kq1EJ+/WvLBm
         qvztjTzKKDUgv5vrC0+BYJlNt7bD/2rwWzA4lhdIcJ254/mbnxGGtOFXfc5HmF+bBUtR
         JDZpZu8gdUg1vIH/hOFpllS35o5X2dzm3It4PxJwqXJHmqmmGnC/oHdXttzeMDted8KM
         psfNZbagRsppPWqJG4R03qLtD96NzKpGMVYCjSApmud7D/AFyc5m2/M2gsYd6ar85z6y
         GRP/B43YrroXbPqRZnYjFU1D5tLe4r2rQdEu9cGYklP6kQl6+CMDTrxPjd2/rnFEkYxY
         yWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749024074; x=1749628874;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDpdN4kNTpLwc7wS3eZTOoxqnRaurdfZFoDe00t9yCA=;
        b=uUUQ5hQ70UEJ/twy1p/mbMeQDQqTmjsmn7qFScEdxKT7BFCmIzeH+vEnnXKKIuoByh
         WDoxzEho3JiA3fZxKm5QozIoVVZ/hn80OaTqIzK6V00UIoo4wX+vBuGrq1oTKhLUFFO3
         smstAeSJ8Q2d4JcAaBhQzlEfOTMhv7rDM6h96CQh7yc0X3CUQqArdkTGv0ORjKUMbclN
         ncOq7CMvV6ekv9JQfNj9vQz0k8rQ8DqCWPI2ZnXU8E0mCHZo/afwpra/mDUAVcGHKcUC
         s//gbicU4ATMxdTUY1YFKqbq4xVhkl8d13hnfBh3HqbJqq/0r4riwJ3b/uTiTPzJlPmm
         d/tQ==
X-Gm-Message-State: AOJu0YxclOgQa2G8aiRyH6PJ3/YvKNHYM+fnS2bS2E4LThkWU49iZGRx
	6K/xvBgBRti/JNwEXX526thwxh7zlvSmR2b8Ny7mF/CHUdg/TGlCBTErEO/qri/19aTEcYRPoiu
	cGQm8ENHgxVOT4XWlND9Sw7g8daNFvZpcgtn6
X-Gm-Gg: ASbGnculgI5F6FKUuKZAG9smumpqcm8z6GfEcJn9blPeSMFgmV4dnIzl+hLBu11NtgF
	tUu72yNofVrqqDNaJ2uX7Op/MJqN2BZZEXIAoO5IxM6P9u6q77L7olZ5U32ZSMoFyw3ff4vqAPi
	Iry8uegf0QReprSjLrrweeDJB6V/EYGDRwwIvXlDLJaq4=
X-Google-Smtp-Source: AGHT+IErr5mJ3GbSbtoJl0w8BBz/9LKqfCUZ/DIr1sm5Db6XTA3sNqi7rUDJzpJtqzmcNiSawh9FT2sZeRr8l6hUdi8=
X-Received: by 2002:a17:90b:1e09:b0:312:eaea:af8e with SMTP id
 98e67ed59e1d1-31311024b47mr2429512a91.18.1749024073548; Wed, 04 Jun 2025
 01:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Wed, 4 Jun 2025 03:00:37 -0500
X-Gm-Features: AX0GCFvL-v91XSSuWvXbQDMK6CH3ceN8nLRtYl1bPvl7breZGdrsf3rXVqOQh8Y
Message-ID: <CALaQ_hoWoovjJHMYz_0f1cE1sqt6upqpivv0qNXLy25vEUuonw@mail.gmail.com>
Subject: Redirecting Checkout Output To Variable And Tee StdErr
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Assigning the subshell output for a `clone` to a variable, while
simultaneously outputting to the user works.
With `checkout`, it does not.

This was brought up in IRC #git and #bash, and JAA (most of all) and
jast and others have contributed well to this finding.
This came about by my need to clone part of texlive (which supposedly
would otherwise be 6GB (it was already 700MB @ 8%), when I only needed
the source, so I used the great `--filter=blob:none`. (I have been
made aware of (in the tug ML) the nice `git svn` feature, but wanted
something that'd apply to all git repos I come across.)
With this blobless clone, it'll only be like 8MB.
My intent is to be able to have the user know progress is happening as
git `--progress`es, but also grab the output and act on messages that
may come up (like any error, where I act on a string of the error).

Test:
$ cloneVar=$(git clone --progress --branch trunk --depth 1
--filter=blob:none --no-checkout -- git://git.texlive.info/texlive
2>&1 | tee /dev/stderr)
$ checkoutVar=$(git checkout --progress trunk -- Build/source 2>&1 |
tee /dev/stderr)

`GIT_TRACE=1` was also mentioned, and that certainly provides
output... And while I saw `fetch` being mentioned in it, I saw no
reference to `Build/source` in the output to draw on (in case I could
manually use `fetch` itself to only get a subpath (which isn't even
looking like it's an option)).
