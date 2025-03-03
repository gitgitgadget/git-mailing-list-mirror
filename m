Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3F230278
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034697; cv=none; b=dunuOqfP5+cYuS2IUT1T7++J0p4LI/ZUOTXReR2k0MF1rJz5KL3YFDOoP6eqXzAfCa2pOwCyTtTWExZsKB78coaVtLqAY4mIQ5V7gFvKP8opvhlZHIRkdbrPAA4JLFRsaiYHU7B5S13bNEAHilU5zA+wMfsJFDISDP11D2qSjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034697; c=relaxed/simple;
	bh=jHPzeYdSQIca5Fhi0SKdsSZuQEFNxdYcyhgXovKQv38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1INfmb45lPnCejC01Fc6ppXzVUHygKHi3o9m36pfGjY3frw3hCxtQTSMvRZtE9ENSPnnQ7aQKW3kSk0/d3CyYofW7shoOMb1fbMRImnq2gIzgzlfSZX4F6/OVUjN8c7mEzFG6X1CEMqrtzaSXJvSnIHwMsuBs+zM3N0CLbO868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R+es+eau; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0RfKOGDo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R+es+eau";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0RfKOGDo"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AAE341382BB0;
	Mon,  3 Mar 2025 15:44:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 03 Mar 2025 15:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1741034693; x=1741121093; bh=9AVCoZl6N8sED0u1YAFu9
	sXBA5VoKOrSjE+WVYZDyIk=; b=R+es+eaugOTB+wGrMOuSAKwLJ499bmZKIRdlL
	roMSruLVN6/eBS5O2vZTJybiCQIleCyM4Nlc2xD4+9uPMVOiwz5QA2gHRBXuq0Ex
	/ZR6HaQjgv4DPXiIvmL4ca7HdHCFx+gYQ8YbA1D8TZRzPZ1s9kkqigNsCy8nGChH
	dHnsKnZipkh3z+vtG2IlGj5ZQRFeFyxbE/qQh+LuLl22TSF2MY+sDy4VFS00CYRZ
	0UaKb8ETZ0an7Ml5UZ5Hayj0YYGrqY6DD0OV+cGnqJfKXgSsZDuJ9R7il1bmXBwt
	qY1ARPZZi7E6VMC4Xfb8PdQQ0WqYYCxc1goiFujfrcil3hUgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741034693; x=1741121093; bh=9AVCoZl6N8sED0u1YAFu9sXBA5VoKOrSjE+
	WVYZDyIk=; b=0RfKOGDoKkPkPKvAmdct/RctpCv5mfVyVQ8FPr+hcJvj1XSnOY7
	jo9S6VAPAA/AzLLZ70zOX8foqUM8NknhA0kHV1GR8vme87TF1yo3HfTVe+0a4zgu
	mRbrcH+z/1CSQAqGnYeRH39usWZRXAFOdGINveayp/8grK0/6Xi1UifOM4qPtQ+9
	6PqkFtOs3At509GDisWzyhEfOVBey6KoODkU/v4RY5Thkndg+15HqE7WmzGgmk+o
	xRv4DOcj8ZHGFo7d0cW9dN8GAC5HCuy8a0R0tzbBupD8Yi4iuLTzoOUNm64t65N9
	y6DoIO5GEvUcR26oEYmeVSqklkukhO69zyg==
X-ME-Sender: <xms:xRTGZ-aCj0GlhVnnSP5D4TFgaSKPwYFnG_CF4fNSAvDKsa6Ho8Q5lg>
    <xme:xRTGZxZ8s0Ew1TyhxiMp8Ilfpv2donAVc8L4KZ07N3HuPgew6DYhhX6-fa45FlRga
    exXI8w8sBAtx3OBsg>
X-ME-Received: <xmr:xRTGZ4_xj6qdidkBAD1CiZM4tr_UiC99yAxxrC97NQaxLGpQPGlxXtHLRcvMezZPhdRHeprP-oaKu0hC2p0UdS4Q-3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhnghgv
    rhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefgfehkeelke
    fhtddtfeetkeefudfggeefgeetheefkeekudeitefhleetkeefjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrdgtoh
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:xRTGZwrAB-m6Gm7wgCD0NrN0q23YoA9Kdgd1Wc18IKw5Yf_pD-EVmQ>
    <xmx:xRTGZ5qEUSBHbTk60FWzAv_ySz1ymPV584h8fiEz_aV1s4zZqLr4-g>
    <xmx:xRTGZ-Rttkq18fqPJanILc1ZiPjp9YPe_-bGfbCdcEASDiUiMSAq6Q>
    <xmx:xRTGZ5ozNS8pfpD7EXaen8VFeWVdKyJOaSpYfmoAzs2JGCj7fVYHBQ>
    <xmx:xRTGZwUsYVMq1Jqugn_R6gKlbRlTCepRzrvraIBPzza1n_IQT07Hp8rw>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:53 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 00/34] misc *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:43:58 -0500
Message-ID: <20250303204443.360595-1-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a follow-up to <Z8Ni0EyQYgD8uWJ0@teonanacatl.net>, this
series aims to fix a good number of the remaining references
to renamed *.txt files in our tree.

The first patch fixes an actual issue, where we were
skipping all the tests in t0450-txt-doc-vs-help.

Todd Zullinger (34):
  t0450: *.txt -> *.adoc fixes
  .gitattributes: more *.txt -> *.adoc updates
  doc: remove unneeded .gitattributes
  Makefile: update reference to technical/racy-git.adoc
  README: *.txt -> *.adoc fixes
  CodingGuidelines: *.txt -> *.adoc fixes
  MyFirstContribution: *.txt -> *.adoc fixes
  MyFirstObjectWalk: *.txt -> *.adoc fixes
  howto/new-command: update reference to builtin docs
  technical/partial-clone: update reference to rev-list-options.adoc
  doc: *.txt -> *.adoc fixes
  advice.h: *.txt -> *.adoc fixes
  apply.c: *.txt -> *.adoc fixes
  builtin.h: *.txt -> *.adoc fixes
  config.c: *.txt -> *.adoc fixes
  contrib/long-running-filter: *.txt -> *.adoc fixes
  diff.h: *.txt -> *.adoc fixes
  diffcore.h: *.txt -> *.adoc fixes
  fsck.h: *.txt -> *.adoc fixes
  list-objects-filter-options.h: *.txt -> *.adoc fixes
  object-name.c: *.txt -> *.adoc fixes
  parse-options.h: *.txt -> *.adoc fixes
  pseudo-merge.h: *.txt -> *.adoc fixes
  refs.h: *.txt -> *.adoc fixes
  setup.c: *.txt -> *.adoc fixes
  simple-ipc.h: *.txt -> *.adoc fixes
  t/helper/test-rot13-filter.c: *.txt -> *.adoc fixes
  t6012: *.txt -> *.adoc fixes
  t6434: *.txt -> *.adoc fixes
  trace2.h: *.txt -> *.adoc fixes
  trace2/tr2_sysenv.c: *.txt -> *.adoc fixes
  transport.h: *.txt -> *.adoc fixes
  unpack-trees.c: *.txt -> *.adoc fixes
  xdiff: *.txt -> *.adoc fixes

 .gitattributes                                |  6 +--
 Documentation/.gitattributes                  |  1 -
 Documentation/CodingGuidelines                |  4 +-
 Documentation/MyFirstContribution.adoc        | 24 ++++-----
 Documentation/MyFirstObjectWalk.adoc          | 12 ++---
 Documentation/gitattributes.adoc              |  6 +--
 Documentation/howto/new-command.adoc          |  2 +-
 Documentation/technical/api-simple-ipc.adoc   |  2 +-
 .../technical/hash-function-transition.adoc   |  2 +-
 Documentation/technical/partial-clone.adoc    |  2 +-
 Makefile                                      |  2 +-
 README.md                                     | 14 +++---
 advice.h                                      |  2 +-
 apply.c                                       |  2 +-
 builtin.h                                     |  2 +-
 config.c                                      | 16 +++---
 contrib/long-running-filter/example.pl        |  2 +-
 diff.h                                        |  2 +-
 diffcore.h                                    |  2 +-
 fsck.h                                        |  2 +-
 list-objects-filter-options.h                 |  2 +-
 object-name.c                                 |  2 +-
 parse-options.h                               |  2 +-
 pseudo-merge.h                                |  2 +-
 refs.h                                        |  2 +-
 setup.c                                       |  2 +-
 simple-ipc.h                                  |  2 +-
 t/helper/test-rot13-filter.c                  |  2 +-
 t/t0450-txt-doc-vs-help.sh                    | 50 +++++++++----------
 ...t-help-mismatches => adoc-help-mismatches} |  0
 t/t6012-rev-list-simplify.sh                  |  2 +-
 t/t6434-merge-recursive-rename-options.sh     |  2 +-
 trace2.h                                      |  2 +-
 trace2/tr2_sysenv.c                           |  2 +-
 transport.h                                   |  2 +-
 unpack-trees.c                                |  2 +-
 xdiff/xdiff.h                                 |  2 +-
 xdiff/xpatience.c                             |  2 +-
 38 files changed, 94 insertions(+), 95 deletions(-)
 delete mode 100644 Documentation/.gitattributes
 rename t/t0450/{txt-help-mismatches => adoc-help-mismatches} (100%)

-- 
2.49.0.rc0

