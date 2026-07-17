Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111E2BDC26
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270182; cv=none; b=sPm5jU3BmwqGiKgEFOW3dW/dppoP46KhiLhLnbn2Ae0MIW5Vjwfy58/DrGTlPVL6pgDtcDkeyNhANUrnKYshK5TRV93T6OaMLJK/zf9ZytTEhx3U5Rj/lkKwc/4UgYH6GF31ewcG3fGKXOj1yUtutKscPGcxWIu05PIJma8ZmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270182; c=relaxed/simple;
	bh=Jim4ASB0DdQs3CwxI994JJ1V/neFuYXTht4qUgRdaFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlqpqpeCeu9l98TRLN5tKVC9MAr0kH0L9HNphs5VqeGgblSCNVp/Uy6Uo2uMMSRKHd+MBQLBySSZBqCH3zjyJ8IOiaoiD4d1A+gBSjopuOLhACelsEULWbYUPhufVDIrhuU3HvpbkWPr/GjHo89TbxJOn6uGozycGQtb/hMrf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=pbgbdrNn; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=lxwRE/6G; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="pbgbdrNn";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="lxwRE/6G"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=pbgbdrNnOTzms9SSf4CGkQX6itkJ/Rz/P9KkPKbvYBEgX0oDfdxHnkbI6pIV+rX1m07Ushj8V5c0Uky88ypxS+wV3GivWqVRKqGUpIoesIkPbQH6iOI2/jG97eE3hfMAK6S7hX6nthACZKpx91PBGjIHP2lI0Qe5ao4n5oKeTyU0m27ID6IXe7SembPsNqMCy5oQ4ffKq8rI6F5YajaLHBAl9H5S7jVPU4cmrPEkxa/FGxALrppJgtLlguhUsPB/gshMNiJawK3XUoM8m0485oi0DT78yLtWsU34ZNjcr0/AJH3mReJCNlUnxysweT1KLkbb/oeSMc/u2i1YLAKwrA==; s=purelymail2; d=malon.dev; v=1; bh=Jim4ASB0DdQs3CwxI994JJ1V/neFuYXTht4qUgRdaFk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=lxwRE/6G9LDc6cCwt9p95XK4EP6BtEJ8a504qSm6alefmjEM2Ewu/07V+CmMcPpe47MnGbSxWsAuGVzxoL2leCeem/uhC548gM6xTtzfYA4TLFsDakshrGozv4GOecT+tH+UhKGXN0/n/NieABmdZs6KIEymzisSt+ecsqxjuhmIMccpcCIcg8KQEEFFGvsK+bq/Yu2ur795haIB3lnBhHRF6BuEJ7V10Ka79F5HRX1Tn6ljOOO5+5eYwSYsDyYHzYy/xEUeiNDP6ks9TzZPvds6LAdBFxihdcZxtrUSk2NABeEG2Sb527su7rwU6Lvw4+PVyzey79veaT1ZJz4Bpw==; s=purelymail2; d=purelymail.com; v=1; bh=Jim4ASB0DdQs3CwxI994JJ1V/neFuYXTht4qUgRdaFk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 894201780;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 17 Jul 2026 06:36:12 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v7 0/4] environment: migrate 'trust_executable_bit' and 'has_symlinks' into 'repo_config_values'
Date: Fri, 17 Jul 2026 14:35:55 +0800
Message-ID: <20260717063559.1633567-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716084941.1101918-1-cat@malon.dev>
References: <20260716084941.1101918-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This series moves 'trust_executable_bit' and 'has_symlinks' into
'struct repo_config_values' to tie them to the specific repository
instance they were read from. Eager parsing is maintained because
these two flags are heavily consulted in hot paths.

Note: 'repo_config_values()' still does not support any struct
repository other than the_repository due to how deeply these flags
are accessed. In other words, this series of patches is laying
the groundwork for the eventual elimination of the_repository.

Previous related work:

[PATCH 2/6] config: add trust_executable_bit to global config [1]
[PATCH] Refactor 'trust_executable_bit' to repository-scoped setting [2]
(This previous attempt was unsuccessful because the target location
selected was 'struct repo_settings', which our analysis indicated
was not the optimal choice. For further details, please see: [3])

[PATCH 5/6] config: move has_symlinks [4]

RFC:

 - Is the locations of the newly introduced definitions/macros
 appropriate?

Changes since V6:

 - In commit 2/4, keep ce_mode_from_stat() static inline. Teach it to
 take a 'struct repository *' parameter instead.

 - In commit 4/4, reword the commit message.

Thanks!

[1] https://lore.kernel.org/git/837b5360b40f992351f489a0ae05fedf49884c6e.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20260301190017.53539-1-dronarajgyawali@gmai=
l.com/
[3] https://lore.kernel.org/git/xmqq1pht6nyx.fsf@gitster.g/
[4] https://lore.kernel.org/git/a154008619790f7a60f2bba91db7b0fe29e67e1a.16=
85716420.git.gitgitgadget@gmail.com/
[5] https://lore.kernel.org/git/xmqq7bokebct.fsf@gitster.g/

Tian Yuchen (4):
  read-cache: remove redundant extern declarations
  read-cache: pass 'repo' to 'ce_mode_from_stat()'
  environment: move trust_executable_bit into repo_config_values
  environment: move has_symlinks into repo_config_values

 apply.c                |  6 +++---
 builtin/update-index.c |  2 +-
 combine-diff.c         |  2 +-
 compat/mingw.c         | 17 +++++++++++++----
 compat/mingw.h         |  3 +++
 diff-lib.c             | 10 +++++-----
 entry.c                |  2 +-
 environment.c          | 27 +++++++++++++++++++++++----
 environment.h          |  8 ++++++--
 git-compat-util.h      |  4 ++++
 read-cache.c           | 15 +++++++--------
 read-cache.h           | 16 ++++++++++++----
 12 files changed, 79 insertions(+), 33 deletions(-)

--=20
2.43.0

