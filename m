Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52717485921
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015952; cv=none; b=fbeP/N11Zrrfv3fN7eB7vEsAGKaTURoWH7Cu+RVLtdHzW19f3KVFNJ3XiN/Pf2MN+Cl2yT2bo6K7EWTBMv1UQ/IbBleI3uu+kp6bQzIsMEVI2hq2qatlIPwO6Urcmn9Z/6dHxLAJwZ8ZGNPiuRGwypq9oLNWNl53j81rvGi23oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015952; c=relaxed/simple;
	bh=dofEjBfP0c8Bsgo00oYmUmgi4waDRsdcQHWZfBKIGsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ3zYvKeWqfa5ZAEWzyPf5bZ/cqfJmmczy+UN6+Vi7N7O6fGqr3HA+R8cqZ2zhd6mdbyrazpCCwOZHMP/qDPmcM9XqfImx1/hHqKJyeLxKyfsK721DljRaskYJoamE9ZlgmhPoU6u/EfrydbqaDGmlI2Bq+SdQDuReAMm8VOFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdcM3lT5; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdcM3lT5"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so6292018eec.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792015950; x=1792620750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KwmNzAZI65BGwjhAKTseKyEfq5OdtZjtjdzwsDHcriU=;
        b=BdcM3lT5PIeciU9Z4zDGxVxPo7p0VhTqJi75a3W0DGdT5dh4HtQV1SEvBCSRM6Jn+I
         3Dr+ICI9tYgV3BfTDd6OwKQeoxVrK9xAYyt/xxb02w4yYeDJENt3ZTDvxwHgkNtQqJoK
         EcqDImgGuQr9U3sMu4C4e9+ChY7WGi04OBpFfAWPG2K8nvgHu/+FR8mhJYPiOh+FOIfm
         c+Y4Df5vK36GunZ3eB3OQDTZZfKFUrSLu9ZYrf08KorCseuad/uh2vVAnqpgV2kgIhOn
         z/8uNQ5hKFaBZIhDPz6cqdHepF0nKWv5zLW7h6TstLs0xtT9Tbz9No+iEi6IFme/23bz
         Vo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015950; x=1792620750;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwmNzAZI65BGwjhAKTseKyEfq5OdtZjtjdzwsDHcriU=;
        b=sVoHkuso89GEQQhn6SattldCRVmIPLkH/7UFb4KyotxHOd2068ivnM8SfR3kj4Jiur
         xoTZwWugKCKt9ttU5YyM4ROwYP+bgIpfNrtzU1YMTwlFXu3UY9aJYX5b2YGNhtimWH4z
         sDW/BEt+R1nBV9y6Oayu/MTZu0BviiRV6wANP1r/V6NXtzxH8wIm880U4GEhsBu7vPaJ
         2TahhuxIWVz4imfdhzWQCoocH9bf5uAgXnuu3b1NsKRbRkgMyxPH0Q88B/WUlytqWqro
         XMZMJVW0wutnU6cnHU/uDmh31s9XOrreK44n79IkkDy11E4oLYDA8FrXiQGkFrBoeb9I
         AOEg==
X-Gm-Message-State: AFq9FYLUoQaNbIUmRbdloV8NH7IwTuduX3ZAjqxnvvCnwGWwCX95iuBz
	/mII/1OwKShMHmt0+ZbAOi2hxRAnGODajX9JHOS56pHTcfEHXZDONsmA
X-Gm-Gg: AYBFou2RhlLwcIt9V1YNQ+CDYKJPgDMQPTbE1LHKoOdOS72A3vG5NtFExRoE52nLkPn
	SRYJyoPWfqJ47n7ujMG1O8IoXNORswj4Vam/vsVf1cN4B2rxflglkH4pwcCjtHPKfr53aIKp98s
	9TbMvGQCZc0HaKjfpTx2aJ4L6dumSshI0WVjF2mPX2JKi8xX9vkV/jnfoe9vRXsc+vo/hnVP0ep
	tnVAK+V4n0zSKyuqh3X+5LsgNnE7C1bn6t6QNd1XibpQ7xyBnUyxwKkCiUDy7w4fjUZKC+tVAMy
	VJHhDMqC93/HWb7F2Qcm5KGD6qMpayQaMg+e38xGNmxgJOfz52hG24I0UOEyTzGfRyM7x62wgUz
	RYlKK3ina8WS1lwfwU3T2YhdQfw/EBVEDjCVstK2IdZ6y9xbPwtx24utLCyIRBr92nRHq49zH2W
	2o971gX0Og6MgoSZiMTpFQF1SdXG5PZqZjHEU857MsPuDamjvD2NOPcAg83Z3iza6oRfzDoVltV
	QodDhBLqWkU/aHFGMm7+qfhJjPVZA+yANatehD9VglCt4n2vO5sBnJ4knzSOV/00Q==
X-Received: by 2002:a05:693c:62cc:b0:351:6f5c:5d16 with SMTP id 5a478bee46e88-3537e007cf7mr24603194eec.22.1792015949999;
        Wed, 14 Oct 2026 15:12:29 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm65863873eec.14.2026.10.14.15.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:12:29 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: Re: [PATCH 0/2] Add a way to wait for index lock
Date: Wed, 14 Oct 2026 15:12:24 -0700
Message-ID: <20261014221226.1693842-1-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqh5ipuuhk.fsf@gitster.g>
References: <20261013172315.2997446-1-quark.zju@gmail.com> <xmqqh5ipuuhk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 15:05:27 -0700, Junio C Hamano wrote:
> It is unfair to expect that the readers would guess what you left
> unsaid here, which probably is "we will introduce the third choice,
> which does such and such things, and it improves the situation in
> such and such ways because ...", before listing ...

Got it. I was trying to reduce duplication with commit message.
Will adjust going forward.

> > To minimize write race, if the index is read before locking, the
> > wait will be skipped, as if timeout is 0. Depending on the read/lock
> > order, some commands (e.g. add, rm, mv, checkout, restore, read-tree,
> > apply, update-index) respect the timeout. Some (e.g. reset, stash,
> > merge, rebase, cherry-pick, am) do not. I started with the simple and
> > common commands. If there is interest in other commands I can take a
> > look too.
>
> Is the above supposed to be the description of the proposed solution?

I thought it was the exciting key detail that is worth highlighting.
But it seems too tricky to grasp. Will adjust going forward.

> There are multiple parties (i.e., `git status` that needed to
> discard the result with "--no-optional-locks" and other end-user
> actions that do need to safely update the index) involved, and it is
> unclear whose actions many of verbs in your writing refer to in the
> above.  E.g., "if the index is read before locking, the wait will be
> skipped" for whom?  "git status" that wants to opportunistically

Scope "if the index ..." to a single process only:
- "who": the current process that calls repo_hold_locked_index (could be any
  command that calls this function)
- "if the index is read before locking, ...": within the current process,
  if the index is read (repo->index->initialized) before locking
  (repo_hold_locked_index), then use the old behavior (timeout=0).
- whether there is a separate `git status` process or not, whether that process
  has read/locked the index or not, are irrelevant to the above rule scoped to
  the current process.

> write out the result of refreshing?  End-user actions like "git add"
> that wanted to register new contents to the index?  Both?

Both are subject to the above rule. Today, `git status` always reads the
index before locking, so timeout=0, and its behavior is not changed.
