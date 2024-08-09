Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDE15EFD0
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231757; cv=none; b=IIIvApLSR4j28uUdPQdTIONoN+hrQmEyUOj3ycvZ1/lkhgwe/GOUO4++0/TA9R2UtMVpwI77unNEv6rRlB/UNrFig2U//8tek8U2xQkBJPvgenkX98s6b7fxRDiZ4Df786AfCGLm/CDNaFHJ5sNL20K7atUQdUo3gpqeEQrLmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231757; c=relaxed/simple;
	bh=EDq0dsW+TpYDAqQ3saXhJE8ru90VDD9cDg4QEre0WNQ=;
	h=MIME-Version:From:To:Subject:Message-ID:Date:Content-Type; b=hHFyLn4UQTdfR8QhXt4f7kJuaZaOcQLwI9v4gPLMpyu8/Nvahk0B85vpdrGU3ZpAPOnYdO6sDR6eyy/0o0N3kjfUaZNArUhHVajmfx2eiagvgyi7ec/eXjrSQ5GhT43cpg9RwBuod+vSFofhs9RebAi7BcrGMGCC3+Etx+y61uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoIDHaLx; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoIDHaLx"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70943713472so1037224a34.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723231754; x=1723836554; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PoGx6x2M9y3i5XZNz1y5NsRV7iAKPPjLn+M8+M6Q3Wo=;
        b=CoIDHaLxPpQ8vud2nLdZeerdk0YR6ajbanuFZ8I2vhNyoSAVIa5ULScF2/bl9Z2bQ8
         wRghleO2u+BEmYrQ8yHwWcpw9KKQv1vMA9SVSGmhAH+/JPHYQNWZ3yzeynvNWIvb6T8Z
         O7dvMLe34WDaLrYMpZyEcWCdsKdx8PgFBjbMr18IBM0NOZTRFPHs6oimeSE3jibkvQpj
         JPjXgwEvFYT5xtUw1XB6jznxvlRpVNLNifvlaipIfNgCV+GvbH1Ut+WXTYWF+cpeHj/y
         8TOPwRj5gbA+cTibxsUH6dspvBt7kOxxPteyWjNncz1Br0oioU2M+C0JIsROf/KvB/mZ
         TcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723231754; x=1723836554;
        h=content-transfer-encoding:date:message-id:subject:to:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoGx6x2M9y3i5XZNz1y5NsRV7iAKPPjLn+M8+M6Q3Wo=;
        b=k2sgThX9ou+IXF+lNJ8zK/TG7acPjfmOJqpv6ywWZHgYlWmHUTdJ+rEgqqjmfD4HWc
         nZKRhCVO6vBZSn7QBOO5UJzW79WM5DqOr/kw2VLMRvPm2wrx4nhqXwjwMu+IVsLNgFfw
         LSreqfFpZgtD/oc8FS3FVkKikOJEUqR3PeBbbt4K40Mg2rqhmqKEloIMYpuBkph+oGKS
         ItUK60vYUgJgXi5NJjziB+mbErQ7XotPytsKh6Av2YsvarZ+sfrRLL3roxwqwRr8aLpS
         OL0B4cQBeGuNIm12IYzvZ7uv3YtWznrwwghE02R5Vr4YmPJRHzrtJfcvTJJ2JnBkl0kB
         I39A==
X-Gm-Message-State: AOJu0YyvACHmD1wmyqfSZta2gdCegqsddpJxvVQ93zCmpXpbs/R7uWsw
	lVSyT4Ft7NdGmNXVVkBoTpw777tQ35Y8DTqdUJhRp2iox0EPuw7/hzac5w==
X-Google-Smtp-Source: AGHT+IGzAL+ec/cB8kWBNfmBSsflbka31IRPiXmhV6jYSughU0Kf+Ow2ADkwWRxVBSVXKT/tCHzG6A==
X-Received: by 2002:a05:6830:3685:b0:70a:9876:b781 with SMTP id 46e09a7af769-70b7c482597mr2955132a34.34.1723231754287;
        Fri, 09 Aug 2024 12:29:14 -0700 (PDT)
Received: from zivdesk (syn-024-241-228-214.res.spectrum.com. [24.241.228.214])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca76a01fd9sm89246173.97.2024.08.09.12.29.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <git@vger.kernel.org>
Subject: [BUG REPORT] `--autostash` rebase + pre-rebase error ends in corrupt
	 state
Message-ID: <17ea26263cf57664.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 9 Aug 2024 19:29:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

If you perform a rebase using `--autostash`, and the pre-rebase hook
exits with a non-zero exit code, your worktree is left in some sort of
invalid state. This is reproducible with the following script:

    git init --initial-branch main
    echo -e '#!/bin/sh\nexit 1' > .git/hooks/pre-rebase
    chmod +x .git/hooks/pre-rebase
   =20
    git commit --allow-empty -m "initial commit"
   =20
    git switch -c feature1 main
   =20
    touch a.txt
    git add a.txt
    git commit -m "add a"
   =20
    git switch -c feature2 main
   =20
    touch b.txt
    git add b.txt
    git commit -m "add b"
   =20
    echo "content" > b.txt
    git rebase --autostash feature1

At this point, `git status` indicates that you are rebasing and
`__git_ps1` also shows simply `(|REBASE)`. However, attempting to `git
rebase --abort` or `git rebase --continue` gives "warning: could not
read '.git/rebase-merge/head-name': No such file or directory", and does
not appear to change the worktree state.

You're able to recover from this by using `git rebase --quit` and then
resetting to the commit you were on before attempting the rebase.

This issue only occurs if there is actually some modification to stash;
the presence of `--autostash` by itself does not trigger it.

If the above script is adjusted to make no uncommitted modifications,
and rebase without using `--autostash`, then the rebase is simply
aborted as expected when the pre-rebase hook fails.

I've reproduced this in the following OS/git version combinations:

- Gentoo Linux, git v2.46.0
- MacOS Sonoma 14.5, git v2.46.0
- Windows 11, git 2.44.0.windows.1

--=20
Thank you,
Brian Lyles
