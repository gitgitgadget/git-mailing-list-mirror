Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8D27FD52
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533273; cv=none; b=tGuQEzZH0IDlf+sXIMQ08K4omA2+c4xsxbwgYcoT/Ng51M8vAYssgHcIQ6dYFk5WS0ONASuu9Itm/eqHGJQovUJosmJow+ZZm5Nq5B9ThXCYEkBaZDaZVEngKcfeMF038eZzeWofmxwelveiKxCvKmHQMrkWyyLJITxv9pfj0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533273; c=relaxed/simple;
	bh=APIpYh/dXYFS3YBopsxUdo23EXEDeIjNsp6ygNs4mto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=fLisQc1EpCS6i3yLx/Obxqn7FeIkEUClZflUYjUBRZ7Fg2pqjkp2VxpEz+8np7cbHBiSfLHTGqIL1qZSyPNWqMSg5q3LUccHeBdVYalAS0R1QEKNrTzuy2iRcIfHd9R9bvSK4rZk3l+R8I+rNrehJwWf5E7n7TFgysSTKtJNp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMXFkpsw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMXFkpsw"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6d8751c88so626912185a.2
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769533271; x=1770138071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCsAy7+31JTs926Xb7UoEsDkluYijyxVV0cg50BbFNw=;
        b=bMXFkpswgm1+WnV94CPJUN1hfPK7auMq7hyVbSrYyEBM9/zvz7/GzijwgcAfoPR/qn
         x/Gz6fwQl1dmr3F2nIt2s0FfSkpcD9uIbc1H8wFzZAXhU1ALhkkcTPQn8CJtXOt2d4e8
         Wl8p9tC93ErZBC/J9vGCypoy9/mEJQRngKrp6NhUBNNsLUHuN9aGB4/QWe6U0gOVm5qd
         bBm63ExbZbC/3lk4QoyQ+ssh23wTiiXFm7hyL7PQDUYSlz6Fu+/thrO+N61YQ+gGzr40
         fm7uowTkHJ8IrUcQyMVzgPTDLD4V2NN41FOqoqbvcn2hzp6La9jilZfiXC+Fo8TvV3s1
         aHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769533271; x=1770138071;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCsAy7+31JTs926Xb7UoEsDkluYijyxVV0cg50BbFNw=;
        b=Rzyw3LAot8S9GRoCn7EEQQTF0kq4OOuteddW1Sqw8tfw4Q8mWxrPJS1O0+tiPj9T08
         FXqM+/Xmgi/NFYlXF2GfW9tEXLzAySs+E2+fpRETZDqjlp70flwmAIoTPOtNpRjmsCSc
         UyrGuUF0r55PYVG3rMqKl8EHsWJ0fUBqD+HvFKlK10Qs1oD3ewli0itJByjZbHAbtcpF
         ak/Qb+SEsBCOT4Q+VJLLYZwgm6djmeKpFbcfrIMi2wP2FpqRPqV+e6ahnYcnaga+dYPe
         Rj10E7ryZhVwzNprBg01ZGV009doWmXcJybzB+gcke5GYiRQrfn5uTGSVThn4xkz04IX
         l6aw==
X-Forwarded-Encrypted: i=1; AJvYcCXGDWlE/CVLyZt+bGhX0EHFhkJYjH8hsivchMa8pZwiy+7kgy/+kvyiEgwbGB4HqBmfegg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvC+lLSwL50TLSlS+3Ad1HbulLGjb2IqsBMngaeer3INv6Bg/
	sEx85clkg8i/vVS67FAst6puRpQeF6FYJ+A/EJGTypjGsPbA7EXzomkhsI0ROQ==
X-Gm-Gg: AZuq6aI2/K5cXCon/28SsjSl0YNzQjrUQeQlnP21OGrO6F9AcJfX9RjzdohFzG/z2Fj
	CAmN4Ox6HO2HolfBGco/AQJHDeGPc2lgOhD5hLNmKN1L5PfJSLgCBYyNjnoeqaY2NdDzs9vYeMS
	ZnsjoyydHNt6I0QtYTkRN2F76j+13kKGSxwEwjGUvQGOjsAxeTXW1WJVDjAWJXCQ5ZyFRjMQIVr
	92edKOSfz4pPOLyWIXBGjqvFQyGk35A9OD/YZoH3HxTU/3maI6ft5M+40errdvNm44SpOegADgJ
	fynZlaLH53q4ObrZjRAALZ/sE/ebaiFLokML4DlruB7WbzwidT1wkGMBqLToy4RT+KjxBP+onhB
	17RfuVqBu6JeiqRj5oKFNNf8pPnPWDoaJIqf75UAhpyq1mcNToM6ha4lPFGPQgmLbTj86EtzLW2
	5XEwXTSHSX98DqyNFwjDR28HcFIFQdmVLJc2pB1p42gaLh
X-Received: by 2002:a05:620a:29cc:b0:8c6:e223:3ee9 with SMTP id af79cd13be357-8c70b8f8f3dmr291449085a.54.1769533266943;
        Tue, 27 Jan 2026 09:01:06 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.77.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375b640sm643016d6.39.2026.01.27.09.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:01:06 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: gitster@pobox.com
Cc: cedricschwyter@bluewin.ch, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Alias 'list'-subcommands to 'ls'
Date: Tue, 27 Jan 2026 12:01:04 -0500
Message-ID: <3411428.b9nUPlyArG@daniel-desktop3>
In-Reply-To: <xmqqblh7nqmu.fsf@gitster.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Is there a "git somecmd" that allows "git somecmd ls" form, while

`git fast-import` comes close but isn't really it.

> these "git stash list", "git worktree list" subcommands take "list"
> and not "ls"?  If so, this change may make sense, but otherwise, not
> really.

We have a precedent of aliases how `git remote rm` is aliased to
`git remote remove`. Speaking of which, I'd also like an alias from
`git remote mv` to `git remote rename`.

> Since many CLI-tools make use of this alias and many programmers are
> used to it I thought I'd add it to git since I was missing such an alias.

Yes, I run into this once a week. `git-ls-files`, `git-ls-remote`, and
`git ls-tree` misleadingly imply that Git commonly writes "list" as
"ls". I'm accustomed to `npm ls` being accepted, and even `ip link ls`
ignores the extra subcommand. I perceive a command line convention to
alias subcommands to coreutils abbreviations e.g. `git rm`/
`docker container rm`/`docker container cp`.


