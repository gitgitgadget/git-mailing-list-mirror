Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A343BC668
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775029; cv=none; b=ShNrq7zybUXUewaT8+An/BQp1shV9qUonDBE20SdW2QjcfxNRx9DuQkZwgw48bcfGp1/7FxMRBS4K6ZFpBS5iANAr5XVOQ/UBqvPQO+J+RMVZsw+a1JswET2e8cYwAW3Dmx8vRwDIZUvaQg8rtwQ6l1h1Qk5kD3lFsoYR5+3eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775029; c=relaxed/simple;
	bh=gHRqMwxY7amDP0MgHk6QN9sW3E2wYIFjgG3CsvWu6oA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=SY4NyyHbhQVMDS2ADVHeZ71Ajhj5EBfPXXqHID9B6p7bmbPKeQgMQKDv01bj2J0t7cL8hW2dZWjRU6/l5s8KVJP6mODx3MJNq4A5qJfLpxxdBtADW+4X13jwT0YalksYdervpn6zU9RFO+IbyyftOKrFs8YXOJkSYk5qQ4E/gw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HKzd41qH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wEBJ4ZEd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HKzd41qH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wEBJ4ZEd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AD737A00CD;
	Tue, 26 May 2026 01:57:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 01:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775026;
	 x=1779861426; bh=7kt2DnI/xF7/VX0y7yCJ2PCUuTsyxoKS+ay3JodartQ=; b=
	HKzd41qHGl6sN6LNuN/hithq/JGWyh2+4lmDeuAFUWvntO0cwuCpgSexFZeGUtwT
	Eg1/7Nvyefx+yu6edaoDlmjKIyYL8pX07QjgjSEfml1CQ3LPE0E+ZiV7sq4OecfO
	OxFf+gPLbt4K0OArVhUAVyQlVZFwyhee3Lv2GrxkzpJl6+mIZDwbh1DoJkPSNzWK
	1lYi8PsamZ2J0E+KTabLSv13vu5Sw+AsbePbg74nxa+hdoOYZr+Z8nCvh++sp4qA
	gDrzVApmEgMipYLzBc5yyoubWEpmfWL8ne1d5A/y77mnzMhAHl8fox3YCAxKTRF9
	iQ7stK1YZMKeZ4C3SXrVhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775026; x=
	1779861426; bh=7kt2DnI/xF7/VX0y7yCJ2PCUuTsyxoKS+ay3JodartQ=; b=w
	EBJ4ZEdm7YXh0+1lr9bc99zSIEW3j4B861w9DOaCDGe2hjnA4K27Yac8X7O/KXx+
	CVYQeQvMsIw5khJZWtTAlyF4xatd3KiWC8shepuJFz7XzAmtOb0X+JwNoxWMOLIz
	YibbVFgJEUKWb3OiIwl+1qrtbHCFBoK9iKY/ru9tm3HMhYFuYzID4PbEGJfQRBYA
	bC8yoDC+eDJhs0xd+B9Qd5ovzB0JlOo1Dk5R18HjJu0PUN7vF3EO2lUHI/bGtuAS
	TwwFyPqj61hEXZLjQgguSSA2pyMJxx4lKBAxydD1IdcJzFAAFW8wBwjpo4NFumuJ
	G873PUKEjFHBfVHAHwm1g==
X-ME-Sender: <xms:MjYVagRVKPHa-k_tTHMdE_7VuKSsF6h8X3XUa1W2td6aOVNJPD1bTA>
    <xme:MjYValPCD3SXckK_ozGnCINNomQlD99YTStyQqBnbMkDvaGNbCCbl1d75cnZYjAUF
    nvvRoUJL9oT9C_ijd5QPtkZc0cLYmSGB_rptzitddxlPa9LwHe64iQ>
X-ME-Received: <xmr:MjYVarNXTuZu9jayXdQ3XcdFTGas-r8Vanzzg1fr0D2cbJsZsjy9mR_WYaTeKZ09VJtpu_AnSAt_QlK3d5-YQTT4Af47YbDsn3kZtyFVGg>
X-ME-Proxy-Cause: dmFkZTEhVbEASvIZTS/LZcpVqY/JqspQQk3iNeZ4BwTYnqqMZfSwetpTl5yOp91bnpN4uU
    1Rizq9BwZS9qlYtQ/JppxoM/gH4H7/PGUvc44rx21Xhj+XM9wKGa7TlUMk7q5a9AUBlqpH
    q/Ra2MM2y6J1p0iIah5itdXvoJ4mdqRe+vTzrzheJ3UMqJpDD0PKDWadITMR6NUvrJVvK/
    bxn8zOvqzWtYaTyUWuBtJVY4T2YkjPI3dltbiyPyLm1SLSGvetiJAKpNEewD0xVgQU+RLA
    9n9wI7RK04hghJ5M1/3XscLDIKZ3L4ENKvRTf7g9rRKaXqun2dvVfHAXQdu3PRg5krlBDK
    OuHbqGcVYZSNtG5yjRI1NxUDCF/RFXKlwB068BKLtojDHs/H7/cpNy3hHDzChs8xd72yD+
    53x9HvQqOTHQTn2QBr+uYPrudR1B6Y2LB1lAobq17Wu0+ZY9vFE1aE061qdBLzs6KzseRX
    GZ3OdrA2iLk5oFsxzP8HfB1GC2R8SCDPm6yX2SPbkOwUyDOILCFrw1u7wlAdG7fEp4AxYd
    gAI1aERCdNl0FqDJrQazYxVfNNA+YJohsi5pRwJU/6K7AHpFV+9AGhOwxJZ49CEN/lt2Fg
    AW4+LL8p+zHAiaRVtgacbKZqAtl6m1gq3+T3KRM1fPLhXBEa6+DFnExhfMXw
X-ME-Proxy: <xmx:MjYVatus9G0k38_ztivNvO816RKbrpsGL_TtZKP_VRHD7Qzzc72FAA>
    <xmx:MjYVatXWv1Kch2qWQDm6G548kAMomXgvOxb0DCUgboTYNrZU9hndzw>
    <xmx:MjYVattXn2N9uGKQ9ZduPxWQkjwosMSpJWUw3zZhTkjWS2r2X3hsiQ>
    <xmx:MjYVahU0fummeDsnDh_kHJmg5GAHzCQVkBWnuzdIbRZRfaYyk0Rmag>
    <xmx:MjYVatXVMcCPWwA9Z7D2G6pNmZn5mNqRKnZNh0qcLAzl6s_XvYCt8XIO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc789478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] setup: centralize object database creation
Date: Tue, 26 May 2026 07:56:55 +0200
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACc2FWoC/42OTQ6CMBBGr0K6dkxbQMSV9zAs+jPIqPykLUQl3
 N2CHsDlS755b2bm0RF6dkpm5nAiT30XQe4SZhrVXRHIRmaSywPPRQk6g+HuwWMYBzDYBace9Eb
 orQbjUIUogDQrSpOntRbCsqgaHNb03DKX6st+1Dc0YXWvi4Z86N1r+2MS6+6XlOK/5CSAQy1Sb
 qUq8KjwHG/21LJqWZYPqEQYYucAAAA=
X-Change-ID: 20260519-b4-pks-setup-centralize-odb-creation-3479c53fb11d
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series refactors the logic for how we discover and
configure repositories. Most importantly, this involves the following
two steps:

  1. We unify the logic to apply the repository format, which is
     currently open-coded across multiple sites. These sites have
     already diverged, where some repository extensions are not
     consistently applied.

  2. We then centralize creation of the object database to happen at the
     same time we apply the repository format.

The end result is that we apply the repository format exactly once, and
that's also the point in time where we can finalize the setup of the
repo's data structures as we know about all details of the repo at that
time. Ultimately, this makes it trivial to introduce the "objectStorage"
extension, even though that's not part of this patch series.

The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
`the_repository` in `init_db()`, 2026-05-19) merged into it.

Changes in v2:
  - Commit message improvements.
  - Link to v1: https://patch.msgid.link/20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
      setup: drop `setup_git_env()`
      setup: deduplicate logic to apply repository format
      repository: stop initializing the object database in `repo_set_gitdir()`
      setup: stop creating the object database in `setup_git_env()`
      setup: stop initializing object database without repository
      repository: stop reading loose object map twice on repo init
      setup: construct object database in `apply_repository_format()`

 commit-graph.c  |   4 +-
 environment.h   |   8 +---
 refs.c          |   3 +-
 repository.c    |  40 +++++------------
 repository.h    |   3 --
 setup.c         | 130 +++++++++++++++++++++++++++++++-------------------------
 setup.h         |  19 +++++++++
 t/t0001-init.sh |  10 +++++
 8 files changed, 117 insertions(+), 100 deletions(-)

Range-diff versus v1:

1:  dd1fcc7096 ! 1:  14521d16e6 t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
    @@ Commit message
         t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
     
         In subsequent commits we'll rework how we set up the repository. This is
    -    a somewhat intricate and thus fragile sequence, there's many things that
    +    a somewhat intricate and thus fragile sequence; there's many things that
         can go subtly wrong, and there are lots of interesting interactions that
         one can discover.
     
         One such discovered edge case was the interaction between git-init(1)
    -    and the "GIT_OBJECT_DIRECTORY" enviroment variable. When set, the
    +    and the "GIT_OBJECT_DIRECTORY" environment variable. When set, the
         behaviour is that the object directory should be created at the path
         that the variable points to. This behaviour is documented as such in
         its man page:
    @@ Commit message
           directory is used.
     
         Curiously enough though we don't seem to have any tests that exercise
    -    this directly, and thus a subsequent commit inadvertently broke this
    -    expectation.
    +    this directly, and thus a subsequent commit inadvertently would have
    +    broken this expectation.
     
         Plug this test gap.
     
2:  b150ecc19f = 2:  9c099e511b setup: drop `setup_git_env()`
3:  9a638f22e8 = 3:  3bbddc1021 setup: deduplicate logic to apply repository format
4:  60f4647bc2 = 4:  5f531305b2 repository: stop initializing the object database in `repo_set_gitdir()`
5:  6d4013ac62 = 5:  57e1de3a36 setup: stop creating the object database in `setup_git_env()`
6:  f4465744a1 = 6:  944dbaeaf8 setup: stop initializing object database without repository
7:  4b6c61be63 = 7:  2eb5646afc repository: stop reading loose object map twice on repo init
8:  54e3a338e5 ! 8:  5322ce123e setup: construct object database in `apply_repository_format()`
    @@ Commit message
         variables GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES into
         the repository format, as well. This allows the caller more flexibility
         around whether or not those environment variables are being honored, as
    -    we do do want to respect them in "setup.c", but not in "repository.c".
    +    we want to respect them in "setup.c", but not in "repository.c".
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     

---
base-commit: 3398daa441965513c48744305d33bd36404547d6
change-id: 20260519-b4-pks-setup-centralize-odb-creation-3479c53fb11d

