Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED62D8DBB
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769890957; cv=none; b=QBpucBDaRPePnu9jpdIEvspVMIYGf0URJMjT80bck6j79r3hoHopfnLAsab+jE9h9cHdP1MVKikD/Dasi8BR9c75JoZTjrlTZGZafecMbzn/FfQ2Lp8xBeyKMLSP+h/W88QSl2770RatBGMzg/FLfCBf4Stul4k4Jm9d+O+7qRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769890957; c=relaxed/simple;
	bh=RC+UJyLMZeNUg8d7jc5btPIYjeaDjtoxoPB4RY9KK/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WteQ0cBl4UarxaR39bxjaLGhL0IzNTY2u3P6juPlQivSEuAMu6xxMtqwwVhKwj5vZGoHC63hs1fkdbmezKRVSrXx4Wy6AbbmUJHPYMnXOuEDDdABHA+Astqx99kz/f5QAJj3PjVgphHF8v3umbR2mPa8FEgy8eYR1UYaIRrLm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS2w9HuO; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS2w9HuO"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-37fd6e91990so33353261fa.3
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 12:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769890954; x=1770495754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NDWrytkNnZDZSK4Kw3+Qp2KUA5VxFxYg11RseZRyZM=;
        b=HS2w9HuOD3Hf3F0Y7g23xAyQMVbYxHpY8ZUC3Mt6Vi/dyB0UK1SEUJTCEScEdad/Wo
         Ql0vDYD70BZiKSmpYoRHId0LQ7uyjPXJqnUGkvM2fmUZr68xn7sw5j/ujHa5Tildo8wi
         tNeU92uPXK8bHCPf2WozdgpzNmIAUCDxn6pVbWUgan4svv3lT45RRoMCgkxb7BpLigwj
         vLlGVkox2VS/2V+ySYTIFFT6kr+eEvW54gCiVYp+iMHwefquE/2hwbPl/yhJCMH5AJYl
         bYu1PN+sG5+eqd/8mXsCPvF19BDOq8bP+6D+edku2TIivCuEfLZxbtIjfIfHg3A64IPS
         WoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769890954; x=1770495754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NDWrytkNnZDZSK4Kw3+Qp2KUA5VxFxYg11RseZRyZM=;
        b=fiZyrMUmlgUZysa/NcCtQzPkNNvsqnQ1xqoke1N4Gb5tvZPDqyifX8wLm7leU80GTL
         acnReOYKoCkK+cf3C53gFyxPG86JAO108HsCFpm5EQkg/7M8JUnM0figCiBb31MB5lSZ
         wQJLeh7ZSSFMhBmLSxOUWaAKJznMS8K69xOF1a1SzZR0w7cS8gVlMiGvZKsM+1hMJ9QR
         2UwTPl8KnSrGEfSBUshv4Nx1DUalfkTZnMHOjutwdAtrPRX5TI2oTYNLBRwYOEm9qUwW
         L1G9yBDUdw/0t4Js7auDbiMsAQ8SMHc64vd+NjeMRJMMTjf7AAO06IYNU5g/t7F+Z6mP
         +5mw==
X-Gm-Message-State: AOJu0Yy48g+pdCGoUiG/zFIETMhoBPtdZpNqdwYMT2JAFQsgHrl/OqKO
	WkF0xLM41WUQcpjAUPaHm8xMOsGA8vKaes2Pjj6pI0KVCWfhG/iHe1qo
X-Gm-Gg: AZuq6aJ2DISv/4b2BqqrKvek27SmBIRDE/4+KTcQrGBTlIQeyiGS/mR+N8TygDypEbB
	OQ5WwC7214DJgTByIfkn8gII8aggkn3A89xtx30ypn27goRcVJrEOT6mVQOIzQ/CDLgDYSnxqow
	LcZfE1+uLUayMcbLIUu2KgL0eQgXGHAXclWEp+Gk5Qe/PzVszXNgVHZkyTiVAjv8TGNlLUcGFG/
	uM+7df4HeZi66shh6LYlewCnRq36mmJvv8DGwIF/937198lR8JGa3dU7aBqXu29b61g0y4ZLjfR
	eKlfM6HTqASDMDmo+tkJ7LVQ0pmtQVjEKmbX7er+pmzjRwWjCuo5a67lm9uuWY2tMfJ+rz+e5RV
	ze8rfL7JcwskkKmGDflMl+DymhgFXFh7NcMz+MtDZcu5zKXFxGgY3jAoigjRECP5CEWBs+BVWKZ
	g2ztwfhRLixX8i9UZtU6dY7uVVmFDvhqbI0yv7oOH082M/NJL9qsW8z7kExUYTu+WGiq43M2U=
X-Received: by 2002:a2e:bc0b:0:b0:37f:d17a:fa73 with SMTP id 38308e7fff4ca-38646716818mr26775991fa.36.1769890953486;
        Sat, 31 Jan 2026 12:22:33 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625fb17f5sm21072721fa.41.2026.01.31.12.22.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 12:22:33 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Sat, 31 Jan 2026 21:22:32 +0100
Message-ID: <20260131202232.9213-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqv7gh4mpw.fsf@gitster.g>
References: <xmqqv7gh4mpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> So in that sense, I do understand why somebody may find it useful if
> there is a handy short-hand for refs/remotes/origin/main (or
> whichever branch is pointed at by refs/remotes/origin/HEAD) in the
> above picture.  And refs/remotes/origin/HEAD already does have a
> handy short-hand, which is 'origin' ;-).

'git checkout origin' doesn't work without resulting in a detached head.

> As Kristoffer said in another message [*1*], I would too expect that
> people would not work on their 'main' (or have their 'main' track
> the upstream's 'main').  So the utility of the piping to sed we saw
> above is dubious, unless we are talking about quite different
> workflow, but I do not think of what that other workflow would look
> like that makes a neutral synonym for 'main' useful.

I don't work directly on the main branch.

However it serves and the only starting point for creating any new feature
branches. This is the command I use, and would be nice if it could be
simplified:

    git fetch --all
    git checkout $(git remote | rg '^(origin|upstream)$' | tail -n1)/HEAD -b new_branch

The main branch is used in my work frontend project for the app release
command, so there I do

    git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    yarn release

I think me as a non-hardcore Git maintainer spend more time in different
repos than you two do, so maybe the pain of switching between systems is
more pronounced. That's my motivation for unifying stuff.

Just for reference, iterating all forked open-source repos on my machine
these are the different upstream names I work with:

    99designs/gqlgen
    refs/remotes/upstream/master

    amplitude/experiment-react-native-client
    refs/remotes/upstream/main

    Antonboom/testifylint
    refs/remotes/upstream/master

    cli/cli
    refs/remotes/upstream/trunk

    datastax/python-driver
    refs/remotes/origin/master

    dependabot/dependabot-core
    refs/remotes/origin/main

    derailed/k9s
    refs/remotes/origin/master

    elastic/go-elasticsearch
    refs/remotes/upstream/main

    git/git
    refs/remotes/upstream/master

    gitgitgadget/gitgitgadget
    refs/remotes/upstream/main

    github-linguist/linguist
    refs/remotes/origin/main

    go-redis/redis_rate
    refs/remotes/origin/v10

    golang-migrate/migrate
    refs/remotes/upstream/master

    golang/go
    refs/remotes/origin/master

    golangci/golangci-lint-action
    refs/remotes/upstream/main

    gradle/gradle
    refs/remotes/origin/master

    Homebrew/brew
    refs/remotes/origin/main

    jwalton/gh-docker-logs
    refs/remotes/upstream/master

    Khan/genqlient
    refs/remotes/upstream/main

    kubernetes-sigs/controller-tools
    refs/remotes/origin/main

    kubernetes/kompose
    refs/remotes/origin/main

    kubernetes/kubernetes
    refs/remotes/origin/master

    ldez/usetesting
    refs/remotes/origin/main

    liushuangls/go-anthropic
    refs/remotes/upstream/main

    matryer/moq
    refs/remotes/upstream/main

    mhemmings/revenuecat
    refs/remotes/origin/master

    ohmyzsh/ohmyzsh
    refs/remotes/upstream/master

    prettier/prettier
    refs/remotes/origin/main

    RevenueCat/docs
    refs/remotes/upstream/main

    RevenueCat/purchases-ios
    refs/remotes/origin/main

    RevenueCat/react-native-purchases
    refs/remotes/origin/main

    sashabaranov/go-openai
    refs/remotes/upstream/master

    stretchr/testify
    refs/remotes/origin/master

    vektah/gqlparser
    refs/remotes/upstream/master


> Doesn't repo_default_branch_name() do the right thing without being
> noisy at all even in a repository without that configured, as the
> function will fall back to the built-in default?  While I do not
> think of a workflow in which a handy access to the value the
> function gives would be so useful that it deserves a short-hand, it
> would be a reasonable candidate of what to be called "@{default}",
> if it proves useful, I would think.

I'll play around with this a bit and see how it works. Thanks for the tip!


Harald
