Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06113A41F
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228366; cv=none; b=GZMctpuQJX7guKELDuvwsYLjf+ZnQmMUP839n84/jC9OTE7Yt+4n56wAmhEWJtRw0EYby5zdeZTjVIxIsT+p85m62xWJ03Al7pVrYOKUbju5PCPkhtgyukI/3fYToWsewNOiqT7UqLz3YpTllxIX2YzHgN8fcaCwyMSBpafuARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228366; c=relaxed/simple;
	bh=45a3xo8Fr025WMVtPJYL6klSVsfB59V3FAUhqlJ/OzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PchNP5b+yb/hGxn//oQfzuOW6auzjXUka9NOLOfXaZ4YU9Gc1q7GsoJwr9mLaQqW67fOUyihbS0le47pFvMwyP4ePyIUGosakQnP0YT32n4H5vz2wLGQl8fx9J2zq0rU0lnGtBFD1zGVIfCib3JqsLqd8J7wARNktd2EqDXtRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRzOKyDT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRzOKyDT"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86a0b5513aso407316366b.1
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725228363; x=1725833163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqGkYLe8Xv+bCj5XHTNWlZ/rG/Y6JRRI8w/qfX37cEM=;
        b=XRzOKyDTwAUHDRB/s8ubI7bDw6Esu5G3iEvyL+qGkGjc1kj5LOjarqKkl6AiwechDI
         hCZTqdaMqTURZuwnFSEKxy/h3k0My1nSrH3qWsdUT5jftu+zniGl7NcsKbQkQEovWUzo
         15GjDh7gcq3CPWvXHvYMFsMGuSssvZ5wCrIHS2WBbN8Xvdf/q4JAYrxMBZqCqpVY+R65
         C1XkkTv2O0lbI12KybwDHO6iyluEq1QsGpLFfP1SFJDiTJ/AIS+kzorP8i2c/PbX2Dr+
         bbJ098Q19AJfqCT1wxphqJ5q1VzrU23Xwgo5I6rgRgoCbQXz6NCrZkOlStnmEukjdL6E
         vvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725228363; x=1725833163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqGkYLe8Xv+bCj5XHTNWlZ/rG/Y6JRRI8w/qfX37cEM=;
        b=H53RR7kedazrPSFemnTItIW0ijXO9JgpiLgRh1FFmjni+5HTWit7Cg5r7fXPWM+pTS
         S1U9H0ykINwmhHobp1teI53mO4sDtV9ekbkS2UMD9TYaB39IzEb+rliXFdlqCkpDRXn5
         Q4CNpo6+wiYN3CdMCdjyJIv+to1SkGwitbbtx2/15f9l3yySl6bGF/6pl8A12250vZpg
         4lFJ2N0oFiT2BDae+6H5wbY7WT8yfSZSS7hDdQ3ZBF562J/xuCGAuGtMpMMDIvGx2TkF
         7CMM3eHaleZt3Y4n/R+691yGaYp4Iz8tjxdXSU9x16wmF6MjDdGPA1nUxBo1CSLJwAAA
         eTkQ==
X-Gm-Message-State: AOJu0YxiILTLXmirIekEVU4pD4GGZg/fKJuGV0o5FFw7Bz8RTeL2EFme
	o3p2d8B4XkUn4GNsq1FRohbX6zpmsXpFKHPm5P86TcHeY2n4pmK6OUacaGOVqDXtIOWGWFF0Dbb
	Sysyo5yJ2tAvdbVrgLmKmM36wNOLYJ9Gf
X-Google-Smtp-Source: AGHT+IFayBRnqLBJZei7pf+trU+ed2FHviDDJjeEMHBSknb+USmRV2NAyuFod3h0xzWAlP12WJa6cRw+7bf1ou872M4=
X-Received: by 2002:a17:907:7f10:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a897f83ad82mr779075366b.20.1725228362676; Sun, 01 Sep 2024
 15:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmSY1F4UB2QSjN8XKY7Kwx6FL8SOrz_OadZ4u8XYDpZfBg@mail.gmail.com>
 <61a4fcc1-1dd8-48a4-a1d4-0201232c9b26@gmail.com> <xmqq1q23pegz.fsf@gitster.g>
In-Reply-To: <xmqq1q23pegz.fsf@gitster.g>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Mon, 2 Sep 2024 10:05:51 +1200
Message-ID: <CANrWfmSgAB_7fLYE1sjYjq+HtjaW-UKne6KezATWkipr2MjFbA@mail.gmail.com>
Subject: Re: `git rebase (--no-fork-point) --onto=<newbase> [<upstream>
 [<branch>]]` leaves HEAD detached and *HEAD not moved when <branch> is
 exactly `HEAD`
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Phillip Wood @Junio C Hamano
I finally got it. Thank you both for your explanation!

On Mon, Sep 2, 2024 at 3:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > "git rebase <upstream> <branch>" is designed to switch to a different
> > branch before rebasing it. If you do not want to switch branches you
> > should use "git rebase <upstream>".
>
> Correct.
>
> > "<branch>" is expected to be a
> > branch name, not a symbolic ref to the branch like "HEAD".
>
> I question the correctness of this, though.  The "what to rebase"
> argument can be any arbitrary commit-ish, and if it is a name of a
> local branch, that branch is rebased.  If it is not, the HEAD is
> detached and that detached HEAD state is rebased.  The latter is
> handy when you are unsure if you want to really touch the branch.
> i.e. "git rebase master topic^0"---this way you'd end up on a
> detached HEAD that shows what would happen if you really rebased
> "topic" branch, but if you do not like the result, you can just
> discard the state by e.g., checking out some branch, and you do not
> even contaminate the reflog of the "topic" branch with the record of
> this failed exeriment.
>
> I have a mild suspicion that the "rebase" command might have changed
> its behaviour since the days back when it was implemented as a shell
> script, when the "what to rebase" argument is HEAD, as the most
> natural implementation to do this "optionally first switch to it
> when the argument is given" in the scripted Porcelain is to actually
> run "git checkout HEAD", which should be a somewhat noisy no-op.
> Apparently today's "git rebase" does not work that way and seems to
> detach HEAD instead and then rebases it.  As you said, that is the
> behaviour most users are familiar with and it is probably too late
> to change, even if (I didn't check) an ancient version of "rebase"
> did not work that way and instead rebased the current branch.
>
> Thanks.
>
