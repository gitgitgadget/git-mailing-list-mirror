Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606235A94F
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469765; cv=none; b=n+lIgVhUiE8nf+yiPM0zV1FHyHzw3LZxpQNtYTFF029yJig8NPPJfGjtkJuTjOYftOLw63pkNMs9j36c1UIfB1b/NbIyyT5CEP1+iMjg5DRzgi2Jd0iw7dbPOiLQSAe1/m/5wqzg8eGBmUvzmvE+bH4wwZ21w+n2Dmnz7mSb4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469765; c=relaxed/simple;
	bh=e9KG6CoKvGjdnPOxp4YROM5lTQzdFbzwl8WLffAk61Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TKuam6Y1Q8c+cxPsd6bUw81Ymm28pOQRoF3tnCKYCswnd0UMD/ybyTMflqhFCJDsQ19Ov5qdlgaj01cfsdSIhtlXw6201VS8kTAeF5eM6XU5TQoWnp33xpKACW3rUHwI3LheOWwZikqTCpoM6VHxPNg+yqqV76MiZjWF5qk7vhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RlLpMrmj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLJ502+P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RlLpMrmj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLJ502+P"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DDC1D1D000EE
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 04:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1768469762; x=1768556162; bh=DtyKsgCBhk
	tR40yd1eHtc+kyAnHE3rNS+UxSa6mDZvo=; b=RlLpMrmjZv17JuI6+tjWpduUbs
	Em+m/arfCelbbZebsHjnGja0asiQecc5mqHxQB+2W/cdKY3+Tr2+2/pvUXpGOSfI
	gmaiNKXDmjWnrvQjgYYpEnWs4lnFVfMICE4a4TdIitWbocAk2UAh9vBdTkQX2DJ8
	P2vjeY1cDaVE/mLRtVtEOR4UKsWHMl1c3YlYSpmUFFedlaxI0T2BnJ+BYhpRY4CF
	cVQsYPF3yRQtKDL9maKweEcDYQJ2vUi0tD7dSbYam3XiLVrHgG5PBuKC0nzK+Bxv
	GZ8yIVvcLe5lBQe4hqIFTpwFToIMz5SqKTw2VuqLZEyCwr7zt+l0pfI38Fbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1768469762; x=1768556162; bh=DtyKsgCBhktR40yd1eHtc+kyAnHE
	3rNS+UxSa6mDZvo=; b=fLJ502+Pxztfr8y+TQIRbj7/SeIsWtEC5pqHFFgl//2X
	QkgjlOKm+MHLO2/8vDzvXBee+EqiNhlPm9aVmHjPvpa4P9/bVU0Hz3t2KBjxEBja
	BJSVt/WTghxNZkEXL1tMqHzL4DTzRy9tYD9ysVnsCqvnXorCSV6ErXW+46ZrAAxQ
	AMW8883wBT9o88GvmGpEKHcLCCWQ7ca/pmWGc2JROw7X/pyJuLc7IE4rEXtxv7yC
	cWpwDFuDJVH9YyG43SQSkoYdfCuCvqvjrlo7hjFlU6Yo9Fz4RnR22JdFXjwuYSpZ
	CxPrhTFRJYqQRv+VQtxmzGPUla16LyVBHLD04nfPuA==
X-ME-Sender: <xms:ArVoaRbKHxrpAliVoc4o1QLAoud1ZMBtAbl1XDeZ2DW3W5fEbT5rtw>
    <xme:ArVoafXjALaAEei8k0n8DJPp9ozD-rJXiVowgBX0IbF0zKSJvaodTBGpQs4avnC_r
    5nzUgD9whDr4jaLdOmx8BdD2RTCsooBBnKb6C2KYNRJu1LSRcm8TgM>
X-ME-Received: <xmr:ArVoaZmYLWNxO3GYhY4VRQD8ouR0HQq60VZNTBnYGbSYdQr1MK1Y503Qj7PjZicpHqQ-ZRs2LvPXY4VbC-VST4rJxx7WrqfPOZ6fX83RakmySw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:ArVoaUzwBPUjQ3q4DwY_dUKXUFJ0uJgTV5sUnQaxkEjrox-XyAWEKg>
    <xmx:ArVoaciNM9ImBEYzJeNpH9SrU_PdMYbIpTWT3uGyljmNmZvi316-XQ>
    <xmx:ArVoaRX7X7e_9GmZbKUlkpeAsIP9HRRzCZ-Hfy-a6bAiE6qGkYvChA>
    <xmx:ArVoaW3PzQuKF-a9PAQCU7BgMHPYclp4gHqj84arKMEPmUqPyc9Zlw>
    <xmx:ArVoab7qhQRgdKYZwmCQKKhp3xDLylFj2PHTOV3ArN94okI_coFK68qb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96c5a79b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 09:35:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] Rename commit list functions to conform to coding
 guidelines
Date: Thu, 15 Jan 2026 10:35:31 +0100
Message-Id: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOO0aGkC/x2NwQqDQAwFf0VybiCrtKX9FfEgJt0+qqtsVAriv
 3fpbeYyc5Bbhjk9q4Oy7XDMqUi4VDS8+xSNocWplvomQe68fJyHeZqw8ghfCytS5LhBbUQy52t
 QadREm4dS6SzZXvj+H213nj/eh4mecwAAAA==
X-Change-ID: 20260107-pks-commit-list-coding-guidelines-51d03de0d39d
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

I've been working with commit lists quite often recently, and every
single time I get bitten by the fact that a subset of its functions do
not conform to our coding guidelines. While most of the functions start
with `commit_list_*()`, three functions don't. This patch series fixes
this issue and renames the remaining three functions so that all of them
start with `commit_list_*()`.

Note that I'm adding compatibility wrappers for the old prototypes to
ease the transition and not make life hard for any in-flight patch
series. I've also dropped all changes that lead to conflicts with
"seen".

This series is built on top of 8745eae506 (The 17th batch, 2026-01-11).

Thanks!

Patrick

---
Patrick Steinhardt (3):
      commit: rename `copy_commit_list()` to conform to coding guidelines
      commit: rename `reverse_commit_list()` to conform to coding guidelines
      commit: rename `free_commit_list()` to conform to coding guidelines

 bisect.c                      | 12 ++++++------
 blame.c                       |  2 +-
 builtin/am.c                  |  2 +-
 builtin/commit-tree.c         |  2 +-
 builtin/commit.c              |  4 ++--
 builtin/describe.c            |  2 +-
 builtin/diff-tree.c           |  2 +-
 builtin/gc.c                  |  2 +-
 builtin/log.c                 | 12 ++++++------
 builtin/merge-base.c          | 14 +++++++-------
 builtin/merge-tree.c          |  4 ++--
 builtin/merge.c               | 16 ++++++++--------
 builtin/pull.c                |  8 ++++----
 builtin/rebase.c              |  4 ++--
 builtin/rev-list.c            |  2 +-
 builtin/show-branch.c         |  2 +-
 builtin/stash.c               | 12 ++++++------
 commit-graph.c                |  2 +-
 commit-reach.c                | 30 +++++++++++++++---------------
 commit.c                      | 16 ++++++++--------
 commit.h                      | 25 ++++++++++++++++++++++---
 contrib/coccinelle/free.cocci |  8 ++++----
 diff-lib.c                    |  2 +-
 fmt-merge-msg.c               |  2 +-
 line-log.c                    |  2 +-
 log-tree.c                    |  2 +-
 merge-ort-wrappers.c          |  2 +-
 merge-ort.c                   |  6 +++---
 notes-merge.c                 |  4 ++--
 notes-utils.c                 |  2 +-
 object-name.c                 |  8 ++++----
 pack-bitmap-write.c           |  6 +++---
 ref-filter.c                  |  8 ++++----
 reflog.c                      |  4 ++--
 remote.c                      |  2 +-
 revision.c                    | 36 ++++++++++++++++++------------------
 sequencer.c                   | 20 ++++++++++----------
 shallow.c                     |  4 ++--
 submodule.c                   |  4 ++--
 t/helper/test-reach.c         | 10 +++++-----
 40 files changed, 163 insertions(+), 144 deletions(-)


---
base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
change-id: 20260107-pks-commit-list-coding-guidelines-51d03de0d39d

