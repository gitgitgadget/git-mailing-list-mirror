Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9F35B158
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962377; cv=none; b=sg43/5Knpk5VMJJJqtDweMJPMyEn/niOnwMRjhuFftRhbxid/jc7dfjuBQVvVGljbv3h1fkt4wih8fgt8WNSivhK3xntXd/tdnqWGuYR414EakPDfjFVllHy1zDmXtwy3WnUr+XtyVj9NxFn1hSFoykdllUJHrRbzb+YfdDfsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962377; c=relaxed/simple;
	bh=EqBtOfnlj+kmkeb1JL1MAGzNIl+SolIPB6hIDIiVv6A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HQu2CAtLpTD0Lp8xXB7AaJ8+zPP/zgqCCnWuQ5oykGWsCHOp/PCdGrINIpoWtBP9nhtZe2qOBqDElHJhlhEmTJtzDX1efG2HUCbMp4UZ+LKRbPw0o3kWl4cA0LC/OWevs1boG0Ku7JAEtmkAmeB+G0Jct5K0R1RTy6jC7S5LA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YEKsb8q+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HRGWoRBJ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YEKsb8q+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HRGWoRBJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC8D87A0177;
	Fri,  9 Jan 2026 07:39:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 07:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1767962375; x=1768048775; bh=NzLXUrYTZv
	k6dzXOTxMkKLAR1danTImZd696awV5HmE=; b=YEKsb8q+3mvtDbCcV4M8ZMA/hx
	zyCT2zmSSMTUlWldVpLUuR7k8zQWHFOcRp7slMyRVYih0psUzglAE72ciL/m5A1L
	kn8PQb4fDlgpFEmR4md72/B7eUO61ebnxHXzPAONNliPYCO3iydsuOg47bqWeTZ1
	G+i9lZ4dzdk1LuI6G34RufWWd41JetUQ7TM+V4waYoIi/IkLTukDVGseLkAktFUO
	NBWyxWEFNeuHkKaE2HXVxExy0LG9Ec0eIYvBgABpTE8BGjLsk4ZvOKVc+fwAy6lg
	T6NmXadRPnq1oaZgWzed1aJkuNdqd/DxWpEWJO6gEqYl9AMgaDY0uGQci4vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767962375; x=1768048775; bh=NzLXUrYTZvk6dzXOTxMkKLAR1dan
	TImZd696awV5HmE=; b=HRGWoRBJbQfXL/sW8DBFXe+nG0lsymWYh1bz7OyNkYSx
	fI1zjWOd1esX7/xbQqI7W230Bu0hOxkRh5mMHyJCzZ3omAWADyW9hk04QWOOJWL9
	Ibs4iyGiOPMaSHkcxpdOOAj7KcqEWUV7NlMs5AnC5Ra4DKQpIOANbK+djQk7ot/4
	TCERyXaYC2UXlkYp/KPRfHCEHB/HBJijLt+dsqmYGq9eZZGeWeN69lmofHaPkbs+
	gE9e6sEnbGoNOVgiVdPqooyT+S5D4h+lEXE8aM6+Hz1EAvetZwZlQiIKBL359Z/v
	YbqEiRHoCm9a8j+vimoL9jNU0F2cpYJ5U42fC2+xpg==
X-ME-Sender: <xms:B_dgaRjGBCoCGUbCdvx3YGGvprqIav40PDG_geuulYP8ZJ9U_XARMA>
    <xme:B_dgadff8027pwLy1fSsuaAb8u6ITIHRHjqrjEaiH_62zJe-3RYa-mSciZjSu_Xuj
    clyA-hyOv9Hp_1yAp07i94FamkTMg759e6rOp1zR7EzChoycStiVw>
X-ME-Received: <xmr:B_dgaeeAo0yr9FPMcWRXFchjMsf3gO5dp3d2k5fY71ONHzuH5CxuPXzsUBvVHhBpI9cRhoULCNp3fEaHheflajDBKukxMYTuPzLWna7DBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:B_dgaf_vK5ccEanBRRTYVdCosIymv6DcHTcqrkm-HU9DSo9-9f6bPQ>
    <xmx:B_dgaSnFyaKRHmEB2Oa9V0oK70l6ZYDk-r5IqbWHPWk8agO7kA_gCA>
    <xmx:B_dgaZ9JafHVFSSlXxvnEny6TtLb3MtABd_cdVMqMWliEwio7PDyIQ>
    <xmx:B_dgaYk8YJDWvt6fWQp0L5X5zQC-z1LLAEZNKQNfLGxrEDETW4ZnjQ>
    <xmx:B_dgaY6da5N3dxJxkE_UT2oy_OqEQRODUCGFJUNOiHrf8GrCPmlPWTgK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d0e6023 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/17] Fixes and improvements for ref consistency checks
Date: Fri, 09 Jan 2026 13:39:29 +0100
Message-Id: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAH3YGkC/xXLQQqAMAxE0atI1gbaKla9iriQmmoQqjQginh34
 /Iz8x4QykwCffFAppOF96RhywLCOqWFkGdtcMY1xpoOj00wUxQ8FcYbI18kaKn2rXeV9SGC2kM
 v/6B0GN/3A627JBpnAAAA
X-Change-ID: 20260109-pks-refs-verify-fixes-1e47872317cf
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains a bunch of fixes and improvements for ref
consistency checks. It is structured as follows:

  - Patches 1 to 4 contain a couple of cleanups for the consistency
    checks done by the "files" backend.

  - Patches 5 to 7 introduce checks for root refs for the "files"
    backend.

  - Patches 9 to 14 introduce infrastructure for shared checks with the
    "files" and "reftable" backend.

  - Patches 15 to 17 move some ref consistency checks that were still
    driven by git-fsck(1) into `git refs verify`.

Thanks!

Patrick

---
Patrick Steinhardt (17):
      refs/files: simplify iterating through root refs
      refs/files: move fsck functions into global scope
      refs/files: remove `refs_check_dir` parameter
      refs/files: remove useless indirection
      refs/files: extract function to check single ref
      refs/files: improve error handling when verifying symrefs
      refs/files: perform consistency checks for root refs
      fsck: drop unused fields from `struct fsck_ref_report`
      refs/files: extract generic symref target checks
      refs/files: introduce function to perform normal ref checks
      refs/reftable: adapt includes to become consistent
      refs/reftable: extract function to retrieve backend for worktree
      refs/reftable: fix consistency checks with worktrees
      refs/reftable: introduce generic checks for refs
      builtin/fsck: move generic object ID checks into `refs_fsck()`
      builtin/fsck: move generic HEAD check into `refs_fsck()`
      builtin/fsck: drop `fsck_head_link()`

 Documentation/fsck-msgids.adoc |   6 ++
 builtin/fsck.c                 |  46 +--------
 fsck.c                         |   5 -
 fsck.h                         |   4 +-
 refs.c                         |  43 ++++++++
 refs.h                         |  18 ++++
 refs/files-backend.c           | 230 ++++++++++++++++++++++++-----------------
 refs/reftable-backend.c        | 167 ++++++++++++++++++++++--------
 t/t0602-reffiles-fsck.sh       |  30 ++++++
 t/t0614-reftable-fsck.sh       |  44 ++++++++
 t/t1450-fsck.sh                |  10 +-
 11 files changed, 416 insertions(+), 187 deletions(-)


---
base-commit: d529f3a197364881746f558e5652f0236131eb86
change-id: 20260109-pks-refs-verify-fixes-1e47872317cf

