Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3A32E729
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475099; cv=none; b=u2KTUmxBfoj72d/f6+KJfTyMzZG/Sd+2RcHfEKtypS1FAd1VMCwejXXGAy4QotqkEGD3UWi1elGyC6azXCCf4JHO85y14bJcd7RPSSZgoFsrZFqTLuZrHstDjW2A6L16ylFpNtj7c5ubDxN9JNGs5gmulGfJXVRuZ2Y+ojtEhg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475099; c=relaxed/simple;
	bh=Ib7Eq3n5iJfqLXxiLArVnQp9Z0emnG5ZnvSOmxdxVoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EWN6P2MBC2a3u2GUmw/5GGRjOtN+YAzZUDi5fceYuX78bJrUjj/8ZGgc5V+oyUMynAiOULBcm8ein01dUHnsp6jIJQPb7DwGM5jYLz2C+zG8rFiDArBJVw1U1pQtvN41P/WBnbfyJ35hF/A1mJygGzSoRR//EbKmNWOXWBV3HSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LUmBnkpU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zmpKwXG/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LUmBnkpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zmpKwXG/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1DA47A00BC
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:04:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 06:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1768475096; x=1768561496; bh=NAXpu+ry6Q
	pQ7W88suv3nRm/LejM/aG5/bNLJUP1CK8=; b=LUmBnkpUiRH5gYBOhk9vzH9n/L
	rFQRmv+nef4zT7Vv/K/k63LbMH0mqS6dTYtmA30E+jGE2x78fMGKsBfiNRK/BrO6
	PaGeMM1q0VnGURRu0WRc1XRHUjKy4EfHdrN3NwwEiNXZCRvSId0eSVaqUZoIqOFF
	jVj3kfnSzA7g9IG0kteb9+skC39EpHmSplI+IVs8GgdHrGWB1Y77fHKcBp1VJ2y+
	1EtGL1338oSs1J5NQnCKebx0h/icKXaPkg+UYRYJWkYRupZVHjehLpLXwAPperuq
	UvBBFg0zAZ23Y/rl4fxO/vfOUclFCG0pllVqmhh4Uo+BYWvTDqiOrQyFDCfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1768475096; x=1768561496; bh=NAXpu+ry6QpQ7W88suv3nRm/LejM
	/aG5/bNLJUP1CK8=; b=zmpKwXG/qo9D22aFeNXP7rnhZv2jbJAEpcdK89qxcKN0
	7EBtLfclEMtM/1wcyYYGLk8RndnzlkYjiHJXBn2bfEVjkfNjb8hlkKAt9Ms1iZBJ
	VPfzvrLTRDrRibL55WPGsM6cKjNUDIFE31HilHOFoJpXhKe+Wod7T2WBaOfI2QuJ
	o+1Hoq9RzlxZsHNyuEyh6SSwv/04Z+Pe3vYCLOXtz7nthwFS3XG5PbPowxxKg099
	oC4xAG2OuuQJJZQsh874ZuJ5z7MC1ywSlesI0h7eBJePvBDQRzFaeIc7e7NmbSC/
	E5l3M4K6vCUM1ljyhHoObvzqYUT6UakFijPhW29krQ==
X-ME-Sender: <xms:2MloaZh4Ei74bH1q6UX8Yj6BjmocIvUxfnewBJNqSMevKlU4-iiK7A>
    <xme:2MloaU_99diVp6oblJQAgbAcsnAJ5eiz2Clnru3BlOJ2v3ta4MEUG4Wb4L0FShHI-
    qbpP-0dsO8HJ71vNFvnNxcTB-fpS1W_7wMwzyAMpGZfpLWLVnwB0w>
X-ME-Received: <xmr:2Mloaes_SOWXjVIRk1q8E6tCJxzmV3WiqK9hL1UaZDDIAA3TuRKbzc9aH4FmDb_lnqQD1PHJ49q2z1s1fipPy0V7suyZkjIYzLBlL2Z1sX2gpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueek
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2MloaTbaSahphOhhRoMzPQoLMnWX-KP1TK7Ba0ifEunVh5HMQU9EXw>
    <xmx:2MloaWpia6Cf_xyGMTBv_kEG6Ihqt1rSpC-1UaQYQ6OFZfNy8_u0Zg>
    <xmx:2MloaQ8Qhy_MHXxFZ-yKo9xZ7XZc1aFTddnVk65Bwn80LaMyOxmJUA>
    <xmx:2Mload9ZwnNg-_p_ZxVwZxcUnXjSIPIDJobcnl7zuKk4nkn16c0WCg>
    <xmx:2MloaSgj4dBIfaDgaDtPlrySpdrTSSCJqVpUdgdISASpeFNMujcu3Aul>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:04:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7aa9e9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:04:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/14] odb: introduce `odb_for_each_object()`
Date: Thu, 15 Jan 2026 12:04:29 +0100
Message-Id: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3JaGkC/x3MywqAIBBA0V+JWTegQc9fiRY+xpyCDI0IpH9PW
 p7FvRkSRaYEU5Uh0s2Jw1Eg6wqMV8dKyLYYGtF0QsoWzz1hsBpdiEjKeAx6I3NhJ3Q/GEtidBZ
 KfUZy/PzneXnfD6Fk+pdpAAAA
X-Change-ID: 20260115-pks-odb-for-each-object-60b78cde09fd
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series introduces a generic `odb_for_each_object()` function
to iterate through objects and adapts callers to use it. The intent is
to make iteration through objects independent of the actual storage
backend.

The series is structured as follows:

  - Commits 1 to 2 do some cleanups for the for-each-object flags.

  - Commits 3 to 7 introduce the infrastructure for
    `odb_for_each_object()`.

  - Commits 8 to 13 convert a couple of callers to use the new
    interfaces.

  - Commit 14 drops now-unused functions.

The patch series is built on top of 8745eae506 (The 17th batch,
2026-01-11) with the following two series merged into it:

  - ps/read-object-info-improvements at b7f649ca93 (Merge
    remote-tracking branch 'junio/ps/read-object-info-improvements' into
    HEAD, 2026-01-15).

  - ps/packfile-store-in-odb-source at 1ff0e42d33 (Merge remote-tracking
    branch 'junio/ps/packfile-store-in-odb-source' into HEAD,
    2026-01-15).

Thanks!

Patrick

---
Patrick Steinhardt (14):
      odb: rename `FOR_EACH_OBJECT_*` flags
      odb: fix flags parameter to be unsigned
      object-file: extract function to read object info from path
      object-file: introduce function to iterate through objects
      packfile: extract function to iterate through objects of a store
      packfile: introduce function to iterate through objects
      odb: introduce `odb_for_each_object()`
      builtin/fsck: refactor to use `odb_for_each_object()`
      treewide: enumerate promisor objects via `odb_for_each_object()`
      treewide: drop uses of `for_each_{loose,packed}_object()`
      odb: introduce mtime fields for object info requests
      builtin/pack-objects: use `packfile_store_for_each_object()`
      reachable: convert to use `odb_for_each_object()`
      odb: drop unused `for_each_{loose,packed}_object()` functions

 builtin/cat-file.c     |  30 +++++++--
 builtin/fsck.c         |  57 ++++------------
 builtin/pack-objects.c |  47 +++++++-------
 commit-graph.c         |  46 +++++++++----
 object-file.c          | 120 ++++++++++++++++++++++------------
 object-file.h          |  21 +++---
 odb.c                  |  29 +++++++++
 odb.h                  |  43 ++++++++++--
 packfile.c             | 173 +++++++++++++++++++++++++++++++++----------------
 packfile.h             |  18 ++++-
 reachable.c            | 129 +++++++++++-------------------------
 repack-promisor.c      |   8 +--
 revision.c             |  10 ++-
 13 files changed, 420 insertions(+), 311 deletions(-)


---
base-commit: 1ff0e42d332523a11cc3d61b8d8463db5f9f14e8
change-id: 20260115-pks-odb-for-each-object-60b78cde09fd

