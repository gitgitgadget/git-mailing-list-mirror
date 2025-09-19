Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF329BDAD
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315493; cv=none; b=lYpoZLdfvjtnx2xkDTz/UaK4nPl6490CKA1lyVL0NtnW9tANGz4i8uwFpbhk9vJC6dDayqRTWrNY6VUZadLd9rmKywS9BRIaGBRp0vHGZISzXX4ifai/FBCkJw+Uu64FAHUePEaV34Cf+UHtSPhNDjGudyhl9s+EbXPSUHWUEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315493; c=relaxed/simple;
	bh=BbRnflTBQX5Ny+dZP+403pLMtV7W4+fOExhe96katU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSDtJwLIaqdcyRD9ReB/6sFqH8/cEdQBUZWLznbNprP5QJDy5O1s2OfvCnJRcLweYcpsAWMc8tfTa9SOS99LWAoi6rbymp1ra2Gw5YydLVSDxZOYfzTPUaqgejAsy+W+9blzkK2BuW81RVObgzRa/+wjjl8rKemOZv7ulzEWkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T77P+bAX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T77P+bAX"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-362e291924aso15194881fa.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758315490; x=1758920290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bifc5jAhgncgC3osqUKPl9OjHV/5+vNj4lJ2yTj9wOI=;
        b=T77P+bAX7GGpzgOGkN+EK1+/aTbwPZoc6T2x1Lhr5kg55lgpgJpsS/C8I6qP0kOMc0
         ytPKSe6x5OrA6wu1n6OuU3iwS6sUJnBgCC5RStIRmTgbkzvUKStV6tUjFSFCpH13L5gA
         AcmMfB6jA/jcgiR2/D8d212yDnsBWyiUhIdxeAckEMrUDJr3JgueuhOzp+DR27SrBPDi
         1n+2ad3cu83OrrbvS1rt+lpGnuILxHkwmEaH08RyjACSkBOFHomn8lQ7qM308r2wyOtO
         7LP05j80gf+3T2Hmlpler/ZHPeWRmMwUUocUW9HlNCt3k+X1gAqY662641M32JEp4CFw
         bcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758315490; x=1758920290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bifc5jAhgncgC3osqUKPl9OjHV/5+vNj4lJ2yTj9wOI=;
        b=LmWwf0/oReiGNu7laUX2nkXPfgicBqAc6P9dZ7d0ZpsnlUReZF5qAVEDWaJ1LHAKDJ
         E4YznBi80Bpv3Q9WRG6+7bM9CN5a7accZLDEQFUhAXogIOqBNfjQxOekCR4TIAu/Lu1O
         odp05SaQBlU0QJPJRkoBzb+eRP/x87/3moqfHmBphqzteRrR3Xet+j2wDCncHz2CunRj
         MJl6jxIwtxb2Ff/Rhfc6tfP95kT0xaozWoitR73Wj4ftCkVBYYF3EY4mgxpsFgx69Y9k
         aPGtRbx3xRxh92cGrgfmb8EQlDijfyozB5K73xoPaXpiMpCej773+xswotWepx0ZQp6e
         kSdA==
X-Forwarded-Encrypted: i=1; AJvYcCVwnLWBjeVi8EjDiBZMOemTJ7+1wWXn0cktm5JNlLvGFJXcfpw+ke/jHq7BK423jqCwxUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynodT0c5DD90jxCwOwhAZIouu+OLRjY5vucTmZAuacwUJWabD
	2nh9cfKmKOJy8iuOdY9z2o0vaIboA+G+6mQSkUpjDDCrBrkH+gWzIMc+62EcIrObABx6Mx83s4S
	robV8v1vekxchWaLBes8PCbBdQCsnsoI=
X-Gm-Gg: ASbGncsSEC/vi4HOgHmqXSu7Yz0vU9Khs8afvtAZarbUlNID+vu1ntsxhqdcEK6LHII
	FtdQ1rOGCyzHpMtH5UFFUWVbI9YX29C7xqJH0Xh1MNjK+tL9WTAGw0jPgx+yay02rSoHXdkiMpk
	ZqtZSbjH6hxD5rjivXU99RMTenDV0Pr5VXJ6/30301YIHXMVMCLVO+j6MJZD4vZVqlt7PirekET
	SdNYFN3umbhSTNPGN0=
X-Google-Smtp-Source: AGHT+IEgTaxB95o4CWlZPsPfbQmA0f4g1d/jMGdupf2AQRlT8GxOYdBv+9f4aXJ2zmZd9lpHp8e2nQ3EDUE6+EazdEY=
X-Received: by 2002:a2e:83d7:0:b0:337:f025:512 with SMTP id
 38308e7fff4ca-36417287d88mr11809601fa.16.1758315489674; Fri, 19 Sep 2025
 13:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <aMpODEpyaaVhFMO0@pks.im>
In-Reply-To: <aMpODEpyaaVhFMO0@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 14:57:58 -0600
X-Gm-Features: AS18NWCm3qyxvlxWwG5CjU7jZcEaIwW23d5Z2d5dvLCugGnsoXcol-win8uyGMI
Message-ID: <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:58=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> Given that this isn't yet ready and given that this patch series is way
> bigger than the one I have in flight that focusses on introducing the
> policy [1]: how about we first merge that one down and then rebase your
> patches on top of it to iterate? It would reduce the scope of your patch
> series and allow us to make smaller steps towards our goal.
>
> To be clear: I very much think that most of the steps here are quite
> sensible. We definitely want to introduce cbindgen, we obviously need to
> introduce support on Windows, and I guess having multiple different
> workspaces is also something that could provide benefit.
>
> But there is no reason to have that all at once, so hence my suggestion
> to build out the infra one step at a time.
>
> What do you think?

I think I made a big mistake of not making it clear that I intended v2
as more of an RFC. My worry (that I expressed very poorly or not at
all) is how hard will it be to apply my patches on top of your
foundation? I don't know if minor or major changes to your current
path would be needed, so I proposed a different way to Introduce Rust
while trying to incorporate work from others.

I wanted feedback on:
  * Cleaning up Rust type name collisions
    * People don't like it, so I'll drop that
  * Have Makefile produce libgit.a correctly.
    * I think this is a good idea, but it doesn't belong in this patch seri=
es.
  * Adding Rust unit test which required fixing Make and adding
build-helper to reduce boilerplate code
    * I think this is a good idea, but should be added later.
  * Introduce cbindgen to avoid desync errors between Rust and C.
    * LIke other points above; This should be added later.
  * What should we call the crate that will be the new home for .c and
.h files in the root of Git?
