Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B33ED12D
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544832; cv=none; b=O72yWzIvnqRcxcqrQv03UDwqm5C93VdDzY7tHfB9FAqxS1fnqLGccMIfT2l/F27h28LF8RuT7sZ6gQWFFCQdXrJsve3pbq52EuUavx2oJhm6sYqsOTm2TdsyBzvOOFZ5WOX8X+m/wf9jpz4wcbbs83dYYulQHsd2L5PZxrcyMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544832; c=relaxed/simple;
	bh=/aojRqT3hYVkPIAqFFAb7QkILUCKESozLpoX1LVGGAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ05b2z7eC3oKqJ7NeU0l6yghmUhcuZabbZkfl/sI+3KK3LSTlojibUk7Ou9R6B7ABJvS3wvWsnmSNx/4wJux4QQiUa77FPeJSrWfQSM5Xae3wfEiSB9bomTuuzBcGmOfdFRcT/E1Juj7/EjbzpRwZkI0KRJ/D7gEmAn1vupdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=g7CbY5lU; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FlOHXlrD; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="g7CbY5lU";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FlOHXlrD"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=g7CbY5lUjlXo7bQS4DXTdrTViJNw14IHLLGcGJvxm63wBGxKeC24o0WHtbf8OkHy9tll5Ih18nBbMnbaWS2sCjvFaVMbpABhJ0zqjCE0joMa00U/lTHq6D3JCKp4y+xZEHJzX+ueK8s/culYshdHR1OK2vri0N55dWpTNcdXrfNRh4zDg6HLqt8TCcg+ysnDOtqfFGBD9hS3mnUi42XRC6AHMwjPlZBwvg8+WYzOi7hpNzZDu+RpI2muttEmF5B/bIHaQa78LJU+oj/DXZRWeyzlFapTGv1y0AhglLd7foA0skt+s9vSEIVhtX36oq9uWp5eO2V8slf+O0LgJVoadg==; s=purelymail2; d=malon.dev; v=1; bh=/aojRqT3hYVkPIAqFFAb7QkILUCKESozLpoX1LVGGAE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=FlOHXlrDMbHvZkvvw4823ObPkqljl+69nXFNdUuoZJwY2pNgCdAqNU58bbkUpycypggNGNzSShqzSavZRy7nsUx2Wt/firNHmy18yVBb8IDjKbsc7/vxdPkeroq2QF27tb1SPrnDBYvv0dZnCgN/AqcL/AosbZ3vv8jzHdJTEC8OF5kE/bZkKQULn9/NntQyux5lFTv0FoLpHzkrWfaKhuaOJmYt5lw0NMyGEP/VHWJkN7BEpGAFnJRmTjs+1gT/PiDCMhPtK1EG8HB19/udjvAfU8i8NOh9w/tSrxhFLSFwK+6HLyM61azfIao/n7Iaip7ry1/7AJIN2AXzmdlgmA==; s=purelymail2; d=purelymail.com; v=1; bh=/aojRqT3hYVkPIAqFFAb7QkILUCKESozLpoX1LVGGAE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1835461667;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Jul 2026 10:53:45 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v8 0/4] environment: migrate 'trust_executable_bit' and 'has_symlinks' into 'repo_config_values'
Date: Mon, 20 Jul 2026 18:53:31 +0800
Message-ID: <20260720105335.3202013-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717063559.1633567-1-cat@malon.dev>
References: <20260717063559.1633567-1-cat@malon.dev>
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

Changes since V7:

 - In commit 2/4, mark the 'struct repository' parameter of
 ce_mode_from_stat() UNUSED. In commit 3/4, drop it.

 - Don't check '!repo' in the getters, which lets the developers know
 there is a bug to fix when NULL is passed in. Callers should be
 responsible of passing non-null repos. Therefore, adjust the call in
 write_entry().

 Change back to check 'repo->initiaized' instead of 'repo->gitdir'.

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
 entry.c                |  3 ++-
 environment.c          | 23 +++++++++++++++++++----
 environment.h          |  8 ++++++--
 git-compat-util.h      |  4 ++++
 read-cache.c           | 15 +++++++--------
 read-cache.h           | 16 ++++++++++++----
 12 files changed, 76 insertions(+), 33 deletions(-)

--=20
2.43.0

