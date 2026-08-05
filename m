Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DF46F488
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935631; cv=pass; b=ezUOv3e+nKTIHYDePZlvi2DFxMrQxMh0ko6Wz240newj1O6mnYj1i02ycmDsy1tDawJZV5ZDrFXUSuVgDQ5sXBdulq+yxkNA1dPYsfqUUxT0weamJmCHoQnI+MA3JcLA3Y2+XvxV2NxAcxDyu2j4cOglx2fytzU0JUU+rbhHlRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935631; c=relaxed/simple;
	bh=Ryq4fSPwv1rFp+ozap+75VLnRWB1kvyMPtk11bMX9NM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ao58fzWMm5SFB86iKCRXCV6Fpw1UzhXlSokxxghoR4DWoy++MG2ruh0vf5aG9xacNyhasu8/wKF8TZ6KMWDelCdhsKfZIr0h7P0RaWicjKbtkMY8LKLOrvaVRORo22+uuqsWEN9bT/FXu5maDEk4Y4FUqBuPe/Xg/f+zLZZd5oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc9q1h8A; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc9q1h8A"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c998fd549a8so728962a12.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 06:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785935629; cv=none;
        d=google.com; s=arc-20260327;
        b=VaX8L0o80oyR/6tg8HiUvIgKQra+ITPuJ6bhxhi5HDI+60DDIZyt+lfOcZPMhAfJDi
         Vl3176/MBp0Rg0L19dFJBBEW1fAAEHp+VHEK2T+sQ8llXwN/GS40O/HvFJULLujAcbyF
         y3jhOByb768GjfakEeQdKoEj/c3l3u43ezkh3NjN2cHztyCPXxZMQr7cRW56dkHX0fyz
         99Aa0whAEhgv9rnRU7Ri0/3Vvfdv4OaHDkK5sV+uzhccM6jPkYDNt/anPCircH9tTO2d
         d8/uGpd4191DFyri8GQtjcPJdBOiaUArDqGpwGHPwpVju91hcTXLMB7ZWL1jEmjJdykt
         K7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=B1Gz7H4QZMHymNR1a14SLI7Nk1L0aBIZsGKf+bcPuJk=;
        fh=WfJB1YkHjfxkSMCsogHMbYc3pvCTmQRpLXh1eGJSZoM=;
        b=EmeGN124Qnsc2WnlfcuXxzIAWqheIL68qNv3ffq2NzhmFtRFmZDUYTLBkXmxejhWVL
         c1AfDJZVVd119B4mW7EV5Z2SYehPQ1nYsf45BnAklLIqF48jG2WwU1uZWpr9QMbgVdcS
         mAu3Z8lvF+98s48LK03WTGvZpx3/wHdbkD9YnYCHXa2oGlIDASZM/iRLXQLVdCFdtVLK
         3PoREiOO3/W1ftflTS9j90MapG9cxcs0gOQMFr8nyttiy6DZb5z9Dlt0LNoDlaH4NAZT
         JRGrGLA2RPLkx3DGbHHQAPmJpgN1Rv04sVzWw+Y0HB9pqAL0mJ+tylKChiGIdNtZqDiu
         HUnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785935629; x=1786540429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1Gz7H4QZMHymNR1a14SLI7Nk1L0aBIZsGKf+bcPuJk=;
        b=bc9q1h8AQACxy0hY/HaAIWE3zPcJBodNfBLay5wuwqwZaHKtn6lfsuEs5z2XRcgU8I
         i/19edI0/+BWQpuRhYe0iLM5eYKNY19XmO5lptmPXU1Y7xduMJZCQN0ZocraSYtrc6a3
         950e8b2HRmWcSFM8ALkzGTclvgCdoQgmM0pwlBtuLCEIQKLgLtx30ZTX9wvmbG7ydOTb
         EdQbiZ9ztYC2OwtjZfo2q+Adhpvx/Y0m+gCmcUBcQMGlSrivLXjPsxn37LQwkQkv1lsS
         UIfhwfAMsai2amQl80WqPBIyz9RB6rNX98ovETHmBK1DOh6cOvh41w6x6IWT4x8gZxEB
         SV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935629; x=1786540429;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B1Gz7H4QZMHymNR1a14SLI7Nk1L0aBIZsGKf+bcPuJk=;
        b=XznmPP0p36RR+3wheoN8WP1tcHo0ExQiaf39nl9H70vLKd3B3EzQDNdK4OIUnTMZU4
         BvD/CZ2p4dDnRNgtf16MYuL3SmlRzHOVwIAUpUaLppo4W6zTbDhR3Q/0Th/HZUilxjFS
         Qad8FekhojCvv+bC345vO/9zVe7UQacpOqsOiElf9SoAuBx0p380aUNkFkwkMryvad9x
         Wf7YYnkpsy3Qd3ZKNKxRHCXVZh7WY4eib0D3YtGLCGmmAdYhtTf2WwUn1JDxWZHbEdKC
         4aTGu+RznlSUwU0+3rHx2gyiXi66tRBGkYZqTjW7DBb23lxu0XfsZClO/Nzjo0PB8qgv
         oxuw==
X-Gm-Message-State: AOJu0YyNzx9Uo7qJc/kMgakjUa/Pko91vQQl2WYAxfDwTVgH+x6b4syU
	KPvQKqQO+FLZ+PVI54cMT2Ol3ZUmGaTDJE9+chXf7ssu5DlAb0AuKq20Yoa9gB82Rt0ZZK/qUJX
	14BcpQ8JGTYqAL1wBOTRheYkhIT1S7uQG6MDbXK5jCA==
X-Gm-Gg: AR+sD13cUWz67d2KkuRcsADx2z6mK3OxV0h4+PfrdkL1hIVdLMHd6ubvZo+S2imG9De
	NoEqlh1w8RXrWMscDVn5Bg4sIEJdxdET/GEWLNalT0DHVm28Fcdu+lZhcysi7yEOgjvrQ6apMSv
	vrZPZM5YzLvgg1c3+7B8UDx/EvM8GEHvByPa7+zy3kuCqbJR6Qh+E6VxzGDONXoUJLfwiOD0F3s
	2JJTgx+722kJ9pYoHkZvcDOeNldEbDXv3vGC1JQyRvBRBI4j0ExGjlcJX3kdIRRXbaQmIkLEkTJ
	IsXs/FpWr+Htmkz0itKWrJYGX7In9LwZaxxoffdzyaThGcXlHTr/DueklNhjdciQz0CkMWT1o4J
	OR3ilZsShMYys14QgpD4WEfi4a4pSsXOG73LYyq/yOsj53LeB+yso9NRjBOl3g9OUCQU6aWEWlb
	GsgKG22B3rpf/AJa7US9gJyyfvGsIE
X-Received: by 2002:a05:6a21:2293:b0:3c3:994f:b4f5 with SMTP id
 adf61e73a8af0-3cb85eefa11mr9096916637.28.1785935629256; Wed, 05 Aug 2026
 06:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 5 Aug 2026 09:13:37 -0400
X-Gm-Features: AUfX_mx3v8ZiIHtIBUKTP-5V9BuPADORQqIm859XQltlo6zdLBEqH8NJG65po-4
Message-ID: <CALnO6CDh6kbL5KH=Nt00ksZCaDbJAnjbepU_tyRTcbGekSyeMg@mail.gmail.com>
Subject: =?UTF-8?Q?BUG=3F_git_rebase_=2Dx_=22git_commit_=2D=2Damend_=E2=80=A6=22_loses_no?=
	=?UTF-8?Q?tes?=
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sigh=E2=80=A6 I haven't minimized a reproduction case here yet, but maybe
someone can tell me how I'm holding it wrong.

I have a local branch with notes in refs/notes/benknoble/commits (in
particular, the tip commit has a note). I forgot to adjust my author
email before creating some of these commits, and I wanted to adjust it
to match the mailmap patch I just sent out, so I ran

    git rebase -x "git commit --no-verify --no-edit --amend
--author=3D'$(git config get user.name) <$(git config get user.email)>'"

Upon checking (much) later, I discovered the note was missing! It had
not been rewritten. And yet:

    git config get --all --regexp --show-names --show-scope notes | column =
-t
    global  format.notes      true
    global  notes.rewriteref  refs/notes/commits
    local   core.notesref     refs/notes/benknoble/commits
    local   notes.rewriteref  refs/notes/benknoble/commits
    local   notes.displayref  refs/notes/origin/amlog

So I would have expected the notes to get rewritten?

- Running "git commit =E2=80=A6 --amend =E2=80=A6" (author change and all) =
rewrites the notes
- Running "git rebase -x echo" rewrites the notes (well, it has
nothing to do right now, so it doesn't modify anything; however, I'm
99.9% convinced that when I did a plain rebase earlier today the notes
were preserved, just like they are all the time)

It's just the combination that loses them :/

--=20
D. Ben Knoble
