Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E482B9A1
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698841; cv=none; b=LK4TMxWDODfn7fFGhvdrFxgsOdvdsWHVrkZb0Z+E8UWgmjkLJBH4Gxw21gSJdid6BPIamWGMxL/ArpicCRI9/NPyY05HEsZykI68j0CHVZRJMFYMUd/04y0mM2cq+up1NpT2VHGFmU6AEsErRPtnz7jahFKT04ppdamnO5nj620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698841; c=relaxed/simple;
	bh=6UQIqVQaXJcr5XUFaQpd/39WenwLQQsa5b4QX1WBZiw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NsOL8RWFHiTCkdpO7O6L6EbSpZA8u2w1PDCDRnfgSumEJpXQ+HZBIP0e7NlmnMhZWr0VniAKiiZheF1NcxpKLEDzXEYd2xooBzkGHEZJ+FgG5fJQqhUX0FkBGskzh+v8aXVlb5U0JJDdj7R6ffaw2x6t1uebFqt9SVq2EupsW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz; spf=pass smtp.mailfrom=klerks.biz; dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b=clz+kW0Z; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klerks.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b="clz+kW0Z"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3ea86377aso48703671fa.1
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1724698837; x=1725303637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6UQIqVQaXJcr5XUFaQpd/39WenwLQQsa5b4QX1WBZiw=;
        b=clz+kW0Z+BXBYAdPsQd2XP03PSaBQtE5rUDheA0sWqBgTLkzaiCjLksYbxd91tqHDs
         ByupG1Z7dWHXnn5SXdUqb823ZMxDiSS8R8rZ8zdV1cO7UdALi6yEV0WJYuULdYN6ZsaO
         Bygl6O6FidiuhPPHWmHVDmDYh5jhVD0PdhIzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724698837; x=1725303637;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UQIqVQaXJcr5XUFaQpd/39WenwLQQsa5b4QX1WBZiw=;
        b=XItMoOPVsRYnVx4tQ/L5+P9I0twr0XFv5UY8PMjUF3L/wANUnVQY/OweMr6ogP1Ofl
         7531TZ2RepWwJFKsvWXP5GWwznP+GoLPWTKVWe1bW0o9OeXCdzvUl2Dm7sTqZNzP3JG/
         qVg9DkZp97spAiMWvFsp2bPm/zwfiOp0HBYoEDSKKChehc7/cJTVZdoQdd0XwIy4Ta1x
         AxIayprq+/OyzclnLGwFpQoPhneKXy9UYNunBAKrIR0th4Tjx36HUs58w2Ltv6uN3NEy
         yxpTyUxSrstx5P6LOxdsYKM1o/z8HXpaMNrfLZ5OzW53iCe7F6NxG3Vh1QDUTlyIMkGJ
         V5vw==
X-Gm-Message-State: AOJu0YyXQE7fqCZGxWjHvKK2rvKT9jq2fzU+Sod32kzhQeR5+3xBlCYw
	6RpmZjdfi3iKwIg8U+tMX+/51sPCCIt328zOs4sUkmA+L/9bbc9AA7LoIOIe4Yv+cqYDix3QcLT
	uRaH2t7P42ZJqVSol5uWyoySCPL7WPKQenRBrt9DWqiGWpJ0+T4ct3In36A==
X-Google-Smtp-Source: AGHT+IHE35SVwW0ENmRLAkChcVH9djj6gy2VuBp0nNTIyeRBV9xLigtCR7803ese05frmeitZzHO15eE+HcjrsxoEc4=
X-Received: by 2002:a05:6512:4025:b0:530:ae22:a6ea with SMTP id
 2adb3069b0e04-5344e4fae9cmr211465e87.40.1724698836903; Mon, 26 Aug 2024
 12:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tao Klerks <tao@klerks.biz>
Date: Mon, 26 Aug 2024 21:00:24 +0200
Message-ID: <CAPMMpogApZ6VN9sYxgmtHCickkstM6HZq1teeAa+a2t1_BY0sQ@mail.gmail.com>
Subject: Can git log be made to "follow" in the same way as git blame? Why /
 in what way is "--follow" broken or limited?
To: git <git@vger.kernel.org>
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I've been working on a "git blame optimizer for partial clone repos",
following up on a thread with Derrick Stolee from 2021 (
https://lore.kernel.org/git/0b57cba9-3ab3-dfdf-5589-a0016eaea634@gmail.com/
), with the intention to pre-fetch all locally-missing blobs for a
given file in the history of a branch/commit, and it ended up being
much more complex to do that I expected, basically because "git log
--follow -- SOMEFILE" doesn't return all the commits containing
versions of "SOMEFILE" that "git blame" will end up visiting.

I thought this strange/interesting, because (as far as I can tell), as
long as there are no renames in the history of the file, "git log --
SOMEFILE", without the "--follow", *does* seem to return all the
commits containing unique versions of the file.

The only reference to this weirdness that I could find in the doc,
after ripping my hair out for a few hours, was in a note on
"log.follow" config, under the "git log" doc eg at
https://git-scm.com/docs/git-log : "This has the same limitations as
--follow, i.e. it cannot be used to follow multiple files and does not
work well on non-linear history."

What seems weird and interesting to me, is that whatever is going
"wrong" in "git log --follow" doesn't happen in "git blame". I
couldn't find an easy way to demo/prove it, but I found experimentally
that the set of blobs examined by "git blame" (and fetched
just-in-time if-needed in a partial clone) is larger than the set of
blobs in commits output by "git log --follow -- FILENAME", but not
larger than the set of blobs in commits output by "git log --
FILENAME" (for a file that has not been renamed).

You can see the strange effect that "--follow" has by comparing a run
with and without on "git.c" in the git project for example - a file
that was never renamed:

git log --pretty='%H' -- git.c | sort | uniq > ~/test1 # 717 commits
git log --pretty='%H' --follow -- git.c | sort | uniq > ~/test2 # 537 commits

You'll find that with "--follow", you get a couple extra commits, and
a whole bunch missing. You can try to fill them in with
"--full-history" etc, but while such options are *accepted*, they are
also completely and utterly *ignored*.

Insofar as this is a known issue... is there an intelligible reason
for it? Should be something we aspire to fix, or should the doc be
improved to make it more obvious what this option does and doesn't do?

Thanks,
Tao
