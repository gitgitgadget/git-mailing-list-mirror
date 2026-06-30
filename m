Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0873F20E7
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820077; cv=none; b=Jj2+Rt2Kz8K6ylCOvpz9CdDX/9ICez6aOEkbyG7aPeI4QBaO2ktPmTdWnLfDKcvRfQF811EmpU42HPifbs0WWlmZWU5hPl1QCCGQfujKWlY5wWzFN+HunHvx3WmRIC6ROspbdDCyUYbnKSVTQxTcEv9LVRVdt45sdGa2BM9iBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820077; c=relaxed/simple;
	bh=FoVpYbKZB/dl70MIUlsOdWjqwh0faLjYD5v8g7loeDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tbp5cL82H28v5bvvovjVq8c8C2aVSG9nCRktisF8cQXXh7OwbxbtznjINS+A3bvKkdlG071b9OHh7mXTEo8a9AMkzfQZyzCE/akNtKCFtuU0uPSziasXvez175KnQC2UPxNPspoItGWDNMUxhcpeSCCBl7/1DMl7ScGWnrc61Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vtikWobC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PKvhzAKr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vtikWobC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKvhzAKr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DFB831D000CC
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:47:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 07:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1782820075; x=1782906475; bh=WjE3wCE9qO
	KHaz32VsSgdqpVIKwxdpx5FoOJjTXg6hU=; b=vtikWobCsLb9XkkRGSTIzWh8y1
	rWS1gom4kFePGHtaGL1aJEWZtQURgKL7u2c6v+rg86cS9UaHy4qQZlofvtZWKqmO
	7p1QNKTlFPgtfsP+b2Gj37AExNq0xR+yc5UE/w0xyB7MigxHM+6nh4xuCC9PRp5Q
	BvtYxmYZ1BvMk2tdHhg96Yi32BFXB4OQM6IvnjGENzP6hewMSG89KboUAypWeywl
	lh0gpTr3l3RUKLyPltmThZDJjnUu8bJ7P9ZrvfYESDxozI6fuNR3u7HKroC51iaa
	C7svC2y84xPqESCR4UeyvUOHTqOmtGB05GddLltKNZeZlvd5WTyOP2bY9d2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782820075; x=1782906475; bh=WjE3wCE9qOKHaz32VsSgdqpVIKwx
	dpx5FoOJjTXg6hU=; b=PKvhzAKr6O6NlekbAts0Z90bWeFB8HMPwndZpTnuvEF1
	+yevm7PlGLOWm2Sqg5swwaVXSZUYZNVa9AtLlEOyiW7AGC6U7v9Pqo3geE1/QCZ4
	cS0RR2JGukemWHogdRKBMC6igSapFL+FJbzyF85rI4l2X4Y14xnIzruWgcCPPlvh
	AR9oQzd40sL6ny2KwCdYHNQwySv/QN/yRP0uea5JbBxA8Uc2lpCv9iMCA3ogba21
	zNo4OqZrtoaUAFX3mLmk8jn8G+reB/mTDekvaqNDdA3eVJCqg5GGxHgB4jOIZNA5
	3zp+cedVPK3Hru47rJyeTZ5qXes4SNCFs47ULo63vg==
X-ME-Sender: <xms:66xDaqsy5-IRCNIGriQLF1Ve4WCCb7Rmef_lcqzngckCFjBuyknP4w>
    <xme:66xDamZJOvr61OUF1ccNzy1zlC5KmMU1Am7WlPiNiYjPRINdLWQ14PveOAwdEE0hi
    kOACZpN2eoitGNCwiYO2B8IEMdpzEgzljfs67ep81WWYdHt79eN>
X-ME-Received: <xmr:66xDarZP7YKStMIw4s0LLfP-fL9V1-3kIXMyP2T1nbQoIEWiDqxkfOMI0nK-Kj6mRC5l3aR5YaGto-_GDjX-3QPsXYrlMR064yrMSDNUvI8dPA>
X-ME-Proxy-Cause: dmFkZTGgD0i3S4axFQXtEXojBYqEua9pGVU8IhhGkt9Z0i6Cz0FmafMLxS5/fru76CBSPi
    gD6567VCsFHxvPCrUa0CTNPCaNBG7lBEvtILvMJ/eqmlZd+O48Xgni3BPxc0ATwEKUVHz3
    hqtZB2zF3fV7/RTvBfuK7bCGw3PJmTxWM5H9kn6o0m2yx8bfIuiuZkCbnYVsu/myWsN6tD
    u//YjZZ4ka8xNklec/4DRwPTgRBlYYzFzm0WzYkZBdk7OR0q8s2OVLnsA8jrpnNHbW+xk6
    rIFTejx8JUv6Fp7GY5EkVbR4C9pMLUpKn79tjJKNWMU9nLVFD3LXb/JcWx6+Z6aiTn+uOe
    cIE5zZUoOOLJ5m/2VxzQOnb6aIB1za+QAAnZXJRBYijqRGJ7WP0tjggj2kqLQq8f32CVLK
    gk2iYws+Xw8E/1Jc2xfid9q1dHMANKpHyQLgWqiXZnf0uE7xgfrCDYOi+5Sg+fWAQu0NVU
    HKznl5O6Cpb6xZ6d12PGDnx7lIyf/Zk0GwAzlPMnRTLo7xdn15cb26ayamnmjc5GrIFtzv
    L6ay/qmVJVOO0NmqIgc9jHPQruH++ddsvtyfwrKGEEtuAa1ooyZLq7XZp7c4DiZVXl7ZUC
    XnAvaYdf6o8JBjJGOgcRvJefcuK5aUESFDPzfGsjrGA8zU/jxUHqJ0HThm0w
X-ME-Proxy: <xmx:66xDaqX15axW4JkADykUEPhpCFWmHewRLCUQsPMtkKzfMRVdPHVIHg>
    <xmx:66xDaq3K3GP0sOF6t8zAa4lLn_GkwSofWCLrQkPHOldYZwXo8MZPiQ>
    <xmx:66xDapamQIJzMo30GKfPDiyao0YDpWOGLxAxWvypvGbgKgYb3zLLGw>
    <xmx:66xDalq7eEASxmL4zJsvGMglk3awHc47oScEHVItweDCniwW6Dgg_w>
    <xmx:66xDalf4BkOZKer5MZ3TMa3ZR1ePlfAyIDXgE1Eu2P1rdAQUqfNhdp3m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:47:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1d51710 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:47:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/13] setup: split up repository discovery and setup
Date: Tue, 30 Jun 2026 13:47:39 +0200
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANusQ2oC/y3NywrCMBCF4Vcps3YgF2iDryIuajK1UyUNmbQop
 e9u1C4/DvxnA6HMJHBuNsi0svAcK/SpAT/28U7IoRqMMq1qtcP0EBQqS0JJTy4YWPy8Un5jH8O
 xhG4w1lntlPVQSynTwK/fy+X6tyy3iXz5pmHfPw2UCzqHAAAA
X-Change-ID: 20260618-pks-setup-split-discovery-and-setup-d7f23831803c
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series is the next set of refactorings to simplify how we
configure repositories in "setup.c".

The setup of the repository is essentially happening in two phases:

  1. We discover the location of the repository as well as its format.

  2. We then use this information to configure the repository.

So far so sensible. In our code base though these two phases are quite
intertwined with one another, as we continue to repeatedly call
`set_git_dir()` and `set_work_tree()` on the repository as we discover
its locations. This makes it hard to follow the logic, and it basically
leaves us with a partially-configured repository.

This patch series splits this up into two proper phases that are
completely separate from one another. The first phase now populates a
`struct repo_discovery` structure, without even having access to any
repository. The second phase then takes that structure and configures
the repository accordingly.

Ultimately, the motivation of this whole exercise is that eventually we
can unify configuration of the repository into `repo_init()` instead of
having bits and pieces thereof distributed across "repository.c" and
"setup.c".

This series is built on top of v2.55.0 with the following three branches
merged into it:

  - ps/refs-onbranch-fixes at d6522d01df (refs: protect against
    chicken-and-egg recursion, 2026-06-25).

  - ps/setup-drop-global-state at 1ceee7431b (treewide: drop
    USE_THE_REPOSITORY_VARIABLE, 2026-06-11).

  - jk/repo-info-path-keys at 3ac28d832a (repo: add path.gitdir with
    absolute and relative suffix formatting, 2026-06-24).

Thanks!

Patrick

---
Patrick Steinhardt (13):
      setup: rename `check_repository_format_gently()`
      setup: mark bogus worktree in `apply_repository_format()`
      setup: unify setup of shallow file
      setup: split up concerns of `setup_git_env_internal()`
      setup: introduce explicit repository discovery
      setup: embed repository format in discovery
      setup: move prefix into repository
      setup: drop static `cwd` variable
      setup: propagate prefix via repository discovery
      setup: make repository discovery self-contained
      setup: drop redundant configuration of `startup_info->have_repository`
      setup: pass worktree to `init_db()`
      setup: mark `set_git_work_tree()` as file-local

 builtin/clone.c        |   8 +-
 builtin/init-db.c      |  34 ++--
 builtin/repo.c         |   8 +-
 builtin/rev-parse.c    |   5 +-
 builtin/update-index.c |   4 +-
 common-init.c          |  20 +++
 git.c                  |   2 +-
 object-name.c          |   4 +-
 repository.c           |   1 +
 repository.h           |   8 +
 setup.c                | 419 ++++++++++++++++++++++++++-----------------------
 setup.h                |   7 +-
 trace.c                |   4 +-
 13 files changed, 283 insertions(+), 241 deletions(-)


---
base-commit: b340fc4c4f3850656b726ff757b42d2020215378
change-id: 20260618-pks-setup-split-discovery-and-setup-d7f23831803c

