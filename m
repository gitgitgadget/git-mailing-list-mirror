Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF232F39CE
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160287; cv=none; b=uMBiKfCxyzNGwTPkyF+AZ+YlJKWjoVJpqVDBXyjLbj36WqV8B+85UcTg9LouW4OizefY+fK12FTXAem6ZQMvI4aRlDtCAsD+zVY5v1V2zZCUQAAtmTlLF2xA+nW1125zO/CCc0sIJm7h97bjGYfS3u8bRQzC+BLhUfIQ32KTTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160287; c=relaxed/simple;
	bh=FNmWU0xOyW2B69R1MMGazSDa5hM3f1881wZ20rhI/hk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=pjs2NG014Rc4WwBDPcZkQYdnNaI0kJA1JQT4A3j1F/xP4yVwZiqJC1cNFCGIsxgSRPhxgC96QBDVdmyNfddKD3EEAjJs9nHAbNDEH36k5mo1rVVoNqWRgf3gur7ErodZds5g+zEUjjWV9jfF/UM8mmxyIShdtMB52B/+wsquQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fxmQW2oT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxvdMC21; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fxmQW2oT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxvdMC21"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B4CA41D00110;
	Thu, 11 Jun 2026 02:44:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 02:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160285;
	 x=1781246685; bh=pR25EBJ+0w3ae9kvPB/bryrkZuAz0NMInpPZjGTzP6E=; b=
	fxmQW2oTjuJR4fsPHUSnzqu1MU3RFo16LqEXDdoHkv3Z9KybUcGqMrzUAvj7YgCY
	vOU7X2tMu24q0OixMZbjRo3EbqFhs7x+FEn7NpF+GRC/YhIR4Pp90jFrBom2sIVs
	HCBqvdosnq2aVLr2+L6n1ZK/ppcx3DRO7H+N8B+IngunoEJscf4L36vOy74epXjb
	xjvibZa0cjLySjmzO3cYS8hPY355yx1PTQ9NqewP7HrNvfcOYZ946tJJtCqEIlFw
	pnNL6RS9wt/E7nX5mKo3t5bz57u04oAhNGPHZD/OeA4zyftegBfNUlvsRryNU7IJ
	nkxO3/n/DIyV+QbFWua98g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160285; x=
	1781246685; bh=pR25EBJ+0w3ae9kvPB/bryrkZuAz0NMInpPZjGTzP6E=; b=K
	xvdMC21IqlSGDOgGzpFKaGdS96dlE8dYW3Fp9ye8xd2EZIKU4NRMN3NVj6hESMO7
	Gaw7HDxKFcS+qd4gOYSNeiCaFpasovpd8rdDXna9K/Z5a8dLNVeQyHnq5mnr01Un
	6qahBPTg+/92CIwCOzg3H7m0ZcvnTI3nZXvxLmaMgOJ/rY5paqz7BL8Iw1nWidiO
	kC1lo2G5/K+UWUSzU9DxMhvUJEwPcm5rlJnLNn2XQN/ViB0deOZgMTI7G6bODD14
	Ul7N1sBfM6TzUy/ebia/r1OQ+TfzrfqQJD+RDeBOEDAmGE7NqZYy+iUjMHJ1jT3z
	pVIH5ydhURn3dNB3km8RQ==
X-ME-Sender: <xms:XVkqaqtnVVPzuyF1KbdxYPi3X23pMiEkSI32d0EE8eezvkr5mzaLlQ>
    <xme:XVkqaldluOo0GiMkF_hT3EpHcT6XigLG86G5yrAmCM10jSQ0l9qqM6Dqy9YbCzH5R
    bsYdYc9jrXHkShXMZQvWrjMgvHgo2cTFelabdIafCb2RQTaLu2TlSg>
X-ME-Received: <xmr:XVkqajZGDK5shoIw9iZFqmwsi_ORvxXtCFfVn9YUQrD_-1XwtQN6RVeF7hZw9uwUaIsU0j3UJskvFNJSYFC8wQDHrevGhrlsB5DJtn7FXG3j>
X-ME-Proxy-Cause: dmFkZTFTdjPNt/t4Fn75T9mFiDSFVqbvitIQ6ZflT1Y2SFxUtBr6JT90wQtddAQr21c/y2
    VzjDKMhyIC0gOh7v6S7VIdyjxbBzSctXrFcVO9WvrO+orR7ysJ23ibvtqwV/cdfcr6DNby
    rNj5WeLiGizb8XOCcVtcJBomYIDycMcEkMEo0TVZuNvVulZGL8mpXYp5t+H5cFWH5zvoWi
    olFp3oysHNBmI+SnwqSQBSSZXx9NPf1P+BhQlmtep55irMKkN6hmZTgYmN16O9a3indUX0
    w76AcVXzQ/Qfe+NU5Fg4zxFtqlAUH5NOYP/jhAVdYLW4GBS8Ds/nRmWmG/JBQm4qacnwkk
    lMJFGbEcliAE0TQhs1RJSK4rq0cMSgk+8KlGxsjpt4tafi6TJcCafic8JJW1/FQrgu+C63
    Mcj3V0EzELMWGubm+5zo0xDHqdJr6IvgfAFG+trKG6IcJWVwzJXPeNoKdd8MGDCBka6Ikm
    wM7A+jK68xC2RwfDAEIlvmBzVxutQiY/eLE3eLzBLQqqOzIW2tZTUUA4iTHuXSoAogorkg
    hCAvFWDcVs3vV6EPmDxaCeIMdgfDmT2wrND3RyCpC85FSjkMpi5WsbFiU3aIbBstf96KWi
    /T0F8LtIcvl4Ul/whLDjeA7/Ag1Yu5+E68gsoWhhWoKgIe81SPwneRYCBLjQ
X-ME-Proxy: <xmx:XVkqagWy8NcmBbfHjDpoG5ys0jE5qje6eZaFFCAl5Rmd65aWzxMCuQ>
    <xmx:XVkqatjHzo09RJBB2FLOfqe8CgD_SzTR8IqGRlkwAl_PojktTnMIyA>
    <xmx:XVkqamUST1HNSX1Kk4TyDs7yFAmP2dcjSe0qE-ubEYorwhIHgqHrsA>
    <xmx:XVkqasNF4g--LuUGxUQ3ENSJ1s6pkpUKJn2km3x9Lc6vKMS3d519vQ>
    <xmx:XVkqalelPUKfksBq-MMi7jdlETGz8ZUA7lZs2fKtme0wYfUxyq3xB2NJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:44:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ca1a884 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:44:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] setup: drop global state
Date: Thu, 11 Jun 2026 08:44:38 +0200
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFZZKmoC/4WOQQ6DIBQFr2JY9zeASpuueo/GBchHaa0QQNPGe
 PeiHqDLSSZv3kIiBouR3IqFBJxttG7MwE8FaXs5dghWZyacckErzkFV4F8RIqbJgw7OQzc4JQe
 ISSYEoVh5qSTqWiuSR3xAYz974NEcHCf1xDZtq5vR25hc+O4PZrZ5R0ww+i82M6BQa2NKxPZqq
 Lhn+2zfpFnX9QdgmhWs2wAAAA==
X-Change-ID: 20260422-b4-pks-setup-drop-global-state-6b1374aed5db
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series continues to refactor "setup.c", where the focus is to
drop remaining global state that we have in "setup.c". The most
important consequence of this is that we don't need to rely on
`the_repository` in `is_bare_repository()` anymore.

This series is built on top of 1ff279f340 (The 13th batch, 2026-06-09)
with ps/setup-centralize-odb-creation at 42b9d3dc9d (setup: construct
object database in `apply_repository_format()`, 2026-06-04) merged into
it.

Changes in v2:
  - Improve documentation for some aspects of `check_repository_format_gently()`.
  - Link to v1: https://patch.msgid.link/20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      builtin/init: stop modifying global `git_work_tree_cfg` variable
      builtin/init: simplify logic to configure worktree
      setup: remove global `git_work_tree_cfg` variable
      builtin/init: stop modifying `is_bare_repository_cfg`
      environment: split up concerns of `is_bare_repository_cfg`
      environment: stop using `the_repository` in `is_bare_repository()`
      treewide: drop USE_THE_REPOSITORY_VARIABLE

 attr.c                  |  4 ++--
 builtin/bisect.c        |  2 +-
 builtin/blame.c         |  2 +-
 builtin/check-attr.c    |  2 +-
 builtin/fetch.c         |  2 +-
 builtin/gc.c            |  2 +-
 builtin/history.c       |  2 +-
 builtin/init-db.c       | 44 +++++++++++++++++++++++++-----------------
 builtin/repack.c        |  3 +--
 builtin/repo.c          |  2 +-
 builtin/reset.c         |  2 +-
 builtin/rev-parse.c     |  2 +-
 environment.c           | 10 +++-------
 environment.h           |  6 ++----
 git.c                   |  2 +-
 mailmap.c               |  6 ++----
 refs/files-backend.c    |  2 +-
 refs/reftable-backend.c |  4 +---
 repository.c            |  1 +
 repository.h            |  7 +++++++
 setup.c                 | 51 +++++++++++++++++++++++++++++--------------------
 setup.h                 |  6 ++++++
 transport.c             |  4 ++--
 worktree.c              |  4 ++--
 24 files changed, 97 insertions(+), 75 deletions(-)

Range-diff versus v1:

1:  0281a4bca9 = 1:  96b71f5223 builtin/init: stop modifying global `git_work_tree_cfg` variable
2:  6fdc8d77e8 = 2:  a51c0ff79d builtin/init: simplify logic to configure worktree
3:  ce31595ff5 ! 3:  e06393ddc5 setup: remove global `git_work_tree_cfg` variable
    @@ Commit message
         Refactor the code so that we instead use the worktree configuration as
         discovered via the repository format. Drop the global variable.
     
    +    Note that in `check_repository_format_gently()` we now have to free the
    +    candidate work tree variable. This change is required to retain previous
    +    semantics: before we essentially had an implicit `else` branch where we
    +    set `git_work_tree_cfg = NULL`, but we were able to elide that branch
    +    because we already knew that it would be `NULL` anyway. Now that we use
    +    the candidate work tree directly to populate the repository's work tree
    +    though we have to clear it to retain those semantics.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## setup.c ##
4:  6a69dc853c = 4:  628ed54c8c builtin/init: stop modifying `is_bare_repository_cfg`
5:  afa2d8bbda ! 5:  02ceaf4a20 environment: split up concerns of `is_bare_repository_cfg`
    @@ setup.c: static int check_repository_format_gently(const char *gitdir,
     +		 * dictate bareness; it is inherited from the main worktree.
     +		 */
     +		candidate->is_bare = -1;
    ++
    ++		/*
    ++		 * Furthermore, "core.worktree" is supposed to be ignored when
    ++		 * we have a commondir configured, unless it comes from the
    ++		 * per-worktree configuration.
    ++		 */
      		FREE_AND_NULL(candidate->work_tree);
      	}
      
6:  04849a2cb5 = 6:  a08aef5685 environment: stop using `the_repository` in `is_bare_repository()`
7:  78191c7557 = 7:  f93f6599df treewide: drop USE_THE_REPOSITORY_VARIABLE

---
base-commit: f5a08a09a0fdf0fc2a355eba7979e2cfd65659e5
change-id: 20260422-b4-pks-setup-drop-global-state-6b1374aed5db

