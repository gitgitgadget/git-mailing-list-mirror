Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232938B7A6
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681048; cv=none; b=W18Gdhr6obHgUUY6jGPvWcctC1/y09fqjkJYa5OjtkoyKG29gg3tWXa/Bt6XrAtv89zqTecRC8hMwNDp3rHtUsvgdVQN8WhAzkBZLZpcaD2PiUbQo265ysLKoRb+TjzRcqOEgWaDm/JeuJKD08Au+6vlIV/Vn4MoRVWQBlTG5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681048; c=relaxed/simple;
	bh=4+ks470SKqFyoygxm6UH4R11kVJw4F1ZCQrO5xCudb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bDo71sfRl6XHDCQKXdjSeUr0bh5bhgKV9wM9NIoIYDMa4jBuUy97cxL60oEkvOdOOuNf9KI3+oFyiJl4j8KRjAgv9X04iiWY57WBdwjODT/YTfiUA5ZYe1zTDDpSSz3NrEcUebfjqiOvS04NitlYHcIhsWlj3qkrFT5hq7a+ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LSNRcQtg; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LSNRcQtg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787681036; x=1788285836; i=l.s.r@web.de;
	bh=AWf5h/EjXFky4jNkByOwFHoJh9UfFxqM/fft2ONNTzY=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LSNRcQtgDFAonPY4sd2Or2Q1KbCxLp57z0UczblCSyGqf5X5n+kvnHLfGbN5XWb9
	 42OoEVeCdUMZW0Avq/10CqDMWE4t0n3TcRpZ9SZgjiB8fHqAEm1h7G+twswY+m+Pj
	 ddR1BHoO2kO9LemCSivyinXbKIo0S3yB6/fs3pJ22UCpFzI0DPsxVlcSRVCutu1qS
	 MBeHXromnzfPmd1TVp6/tFTUB+baBXPmMtDog5jBPDKqCGQ4JUXhLV2l4SAlcxcy9
	 yHZ0XngcdD2HZjfZB3qLlnw2WLvzhxDnPHTf4GxPXqYCAfoY0dsPQilzQyuUVF43V
	 mAHQ30KDOfJ12vbWdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1wNNp62DE0-00iWs4 for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 20:03:56 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 0/4] worktree add: worktree_basename() fixes
Date: Tue, 25 Aug 2026 20:03:46 +0200
Message-ID: <20260825180350.2099-1-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:olgKKAIu5ZmCo4aH/NxiGvds1ta5yUJLNf/sU3fFxn/kYL07V+h
 uzi1tlHZwZDy7c7GIi0qJUfwK135clG6zAOKyjQPPIs/XFZ9NYoGhyGUX241N8jc0YRXMax
 OjT8lUs1BXLO4q9Uy4OmTnxy2YdfgL/uI+wn66oToOtQkKePlqp0xKoCh/BpXI1N7VfmH2f
 Ua15XW1vl2d/brKRfMEHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V82q3ZyqwTc=;yKC6wAD2ETmatjP9LLWLkPH1Ek6
 +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
 uU3ioiQdT7p3AkApyLujaS6U5qfR7UQovrvWuU=

Here's my take on solving the issues addressed by [1].  I'd prefer a
reroll of that series, but in case it won't come we can use this one.

The first fix is the most important one, avoiding potential data loss.
The third one starts to accept paths with trailing path separators, the
fourth one simplifies the code.

  worktree add: don't read out of bounds in worktree_basename()
  worktree add: reject separator-only path
  worktree add: trim slashes when deriving branch name from path
  worktree add: let worktree_basename() return string copy

 builtin/worktree.c      | 33 ++++++++++++++-------------------
 t/t2400-worktree-add.sh | 17 +++++++++++++++++
 2 files changed, 31 insertions(+), 19 deletions(-)


[1] https://lore.kernel.org/git/pull.2187.git.1784978348.gitgitgadget@gmai=
l.com/

=2D-=20
2.55.0

