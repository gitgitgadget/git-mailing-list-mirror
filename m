Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F4364BE
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921620; cv=none; b=JUQuXGI3ivQGXLwS1licy3wZmFxztiJHw3tzOqa0onOAOGFko9SJ2380PY0C3SxIyzMki7BejoJnwCGgf53THT5PWiZOufSbyyxh2MaNHuoMuFGa7S7gfOJd2E1jFGd/9YHCQCePLCh/bWaQtWHE4FdVxsMjX6w0WnsRk2IiKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921620; c=relaxed/simple;
	bh=/FNRoSS+uxKrJosvuRSRVe2Cw+yrHpVI374SoUJDmUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HU60EPrYEZdZU4sqWdBMrrcZWjbBcMrXb38pAHxfhHyYRh0JTE3X+kIQUwdLn5HYZd5p0wQ6yladf+sIp6Wt1HSzLXQus376j0TQ+XHb6kfe5ZrLcs1CXhWL+puvviLlhoeHmXPtoFPfDeSODQklKquilLSgq0sAxmE69YmEWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDlWicRm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDlWicRm"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so112715066b.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710921616; x=1711526416; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FNRoSS+uxKrJosvuRSRVe2Cw+yrHpVI374SoUJDmUU=;
        b=nDlWicRmFsrpaxd3hObx4Mrfoa/2yEk9M1C55OqblQKcO5TostXISDLsP6pEiN+MIU
         E246EDmd54fHEfsBja7BziFb4EGUO8xnABnSO2/rrKaENoCqQeF0q+yyTMrFBCGsd9dh
         eZRBa21csjljwW2gtGM7EwyaT/3aLGsaOggse60zbeYxBGFJcek3R8gsPgyXSW1tBrA5
         hfQfnjqTl3nouQt8M/KZJfPuNTeY91V43FOufp577mbqm6yDF9NZelk5ca3Bd7yUCZSv
         zn/CgLqn3pqOaNnJs5iJANwKdCk4ReK3deCQnE/BqeqdNO3dddydOg0pTxHUpdL7w6+B
         9tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710921616; x=1711526416;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FNRoSS+uxKrJosvuRSRVe2Cw+yrHpVI374SoUJDmUU=;
        b=asFcjlfYmLk6/Frc1Q0hcQMVQnPvdDQ2DYVhfUG2T/ai7rKAKdqevOOHbBNxOgHRdn
         nPL/UGZekvsDB8goHC5pxjuhOqFCZaa+O5Xnk4Alt9nZTv7zyLtU3MR98OcZw8jtJs2M
         f10Ki71qMBp7BLLNmcYoLHRWfpxnNQ3yq0b3btLdCOeVnGg2lyxryWpzbo40iSD2qwwO
         vZEDpuWkrllcHfW28xJMKxgYlQ6nEu/YVuMPItXVXvdejFZHlYSha6C8MGuE6dU8Bx/I
         Q7hnRVxGCg0m4KEPQttMDacRsXkritPE1NG8c+IAKO9yLfeBx7QILR0517xsGCGTatRx
         g2Yw==
X-Gm-Message-State: AOJu0Yww3/Dyx/mTcZ5YIpJE8kRT+zmJSi1ixbe3U0LxHfXXZ8h1JIP0
	b5I1bI+7ZDcSKrVp2U1lEKiCqzR6Ip627vYwYJJ5xXk3JEQZF8HP8nZKpwMEumDn8I748se7Zwo
	htb9EopUvuidiLCszl2vypsZaZ+VcuGon/6s=
X-Google-Smtp-Source: AGHT+IElblKx4BzFa6G3YUHuK6UptyFl7c9Az0C6j9NuGDzsL7v8LGcDdd/T6Bvsfha2kcG4e18wLInazfkj+8BcxO8=
X-Received: by 2002:a17:906:c7d4:b0:a46:dd1f:7dc6 with SMTP id
 dc20-20020a170906c7d400b00a46dd1f7dc6mr4076475ejb.24.1710921616076; Wed, 20
 Mar 2024 01:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Hickford <matt.hickford@gmail.com>
Date: Wed, 20 Mar 2024 08:00:00 +0000
Message-ID: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
Subject: Feature request: highlight local worktree in `worktree list`
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. `git branch` lists branches. It highlights the current branch with
an asterisk and (for me) the colour green. This is handy for quick
reading.

`git worktree list` lists worktrees. It would be neat to highlight the
local worktree.

Another idea: `git branch -v` shows the commit subject and
ahead/behind counts for each branch, eg. "[ahead 1, behind 1] avoid
RegexReplace". It would be neat for `git worktree list -v` (or
similar) to show the commit subject and ahead/behind counts.
