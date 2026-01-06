Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD61C3BF7
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682507; cv=none; b=QFAyuPrGI//UsWPfMa2oiXlFV8fobpGrRuqtw9un8QgBoDFAiR9h0SAKlsaOMBjbifmBImNyLu0ajBX8aVVZZbr4JCy0YShdvMLuIfBBpPBt7GPdbMiFBbeUY4XcE9AAqvY67Jxcne23EWJGRx2nqBWzCsDs79xZGyJpagQNbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682507; c=relaxed/simple;
	bh=RsFUCba8kHjlSgDI0tDtYcD5GyiM/GHcvR0A5wXYQXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=aKkbYf+xTBhV4RB353PhykedMWqZ1IBeWDu7gjA3Ndl66cK9s0ZbDcP4pOX3sWETpihTNbrJ+NR6BqPQO95CcP0CBBi9UO8/KTmZdzUrkWb4904Wq5bXmY5l1H9NntaSh7Xy45YL256Uru+vu9lzwdiD+f9QrYLOmMq6cMtGpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ER94LnJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eArk9HHW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ER94LnJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eArk9HHW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DA357A00F9;
	Tue,  6 Jan 2026 01:55:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 01:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682504;
	 x=1767768904; bh=GnOpCH9545pyg/xCWNK+NnCEWflBLtmP7uOSS1wZ7X8=; b=
	ER94LnJh1FzeLRycVjubNIt2h0eF7kcLrg2baFL9qj+nXjOpYqT6sFFA4wOsJwxU
	57BN/johbKqUq9UJ8qye0Hj5qIdj4tr91JiG6SBShBBJB+Duve7/CQvGpcHjA97V
	Aimbqqvg/APhUwylCN1tEJwFi/i5x8IpFZ4RAgibc9lhj3A1kS4AM8yp7IQ9IN53
	fZns0WYdQMW0cv2Z6mux0uWb6OLEviOOXQ7h9nJ6W+0cfUU6lx1fvcgu2D5Uut9C
	WJ+k2CiqcvGpnFntCcIcT92mYZJQ/42UmtI9/Zj00u+gb7tjVXUXgwk6ErX2phJ5
	wSTBNWlOvaZWZbDFuYs7eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682504; x=
	1767768904; bh=GnOpCH9545pyg/xCWNK+NnCEWflBLtmP7uOSS1wZ7X8=; b=e
	Ark9HHWnDs3IoJYvHIp6GmDvP2+EO0tZbMYe5XnwiXWXgr10Pvd2a4J7pbQaeI+u
	gu6VATBkAScQE+1+YlhBqHYFuOhNoOCJoX2vfflQXujGk/zLuTdjZhxS/jkOHhme
	rpcaDvMdS0V9kG4rzqGBHfn+7ptlVj2yPLzdhSN5tLTxyFKt88ERgp0sK+Gh6sbd
	s/aeHkY0qCVRnf6r69gkySUSMTr+6bYcANFarUe3iXqgjm6KV89Jb3WAm+51+nyr
	88tJZYNUqZx4f7YCdT9q/6SMi5ITMFCPUm9LMEMfLK0GSPDiV/4bpuNEBAc7/7cP
	qokkkoyRbxlhBn/scOCdw==
X-ME-Sender: <xms:yLFcaa1O7DjziEdAT-zfWHnR9hmpbHPD43itseQdHcLG-02mu0RGNw>
    <xme:yLFcaT_U9TOkvjaa75o7SwK9il4iyENW3zs8tOPiVBGT_RyB49Qg37lb615FNqbWt
    YWKpG8YzRJDLsQUu6UbG51PpvzkQFiewpqrSCVEuLKnhpGzqu0dpA8>
X-ME-Received: <xmr:yLFcabOLguu5Be5A9OKUMKhTn9Kr7_SSAkGQfvPiTnlwJsv6niSlg37qpl92cAlCr9163hbrYjYsD8wpuCczBkr5L2F_IvpjugDM0lSC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:yLFcaXd3vRhqUd7tcOX9vzQR2dU7d-wrjCMN707KLeDWsgdgIG0h7w>
    <xmx:yLFcaaWEykpj-9Nt1ubvsm9TjTM-4IExfFKjXkLjHY60y9eOHfqPhQ>
    <xmx:yLFcafgRfy0-_p20hc-JzuAnHl2_kPf19jwAlUFnzAG_JDt6NcnZvw>
    <xmx:yLFcaZ--GICfAYHcxrPWC4-4FBVFyQamqCf67qdBnYNtEZfr5DPP9Q>
    <xmx:yLFcaSinZuUd1HWBFnw1gqxa8YRer-rqNuj8iTzUe2e2K6fYxRQadil0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b33b6472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/7] Improvements for reading object info
Date: Tue, 06 Jan 2026 07:54:56 +0100
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCxXGkC/52Nyw6CMBBFf4V07Zh2eBVX/odxQWGQ0UBJSxoN4
 d8tJLo2Ls9N7jmL8OSYvDgli3AU2LMdI6SHRDR9Pd4IuI0sUGKuUOVgMpgeHmxrwFHdgjV3amb
 gsbPAw+RsoIHG2YMkmSrqNJYtiqibHHX83FOXa+Se/Wzday8Hta2fiP49EhRI0KrRaaGzCg2d4
 +/Ig9gKAf+1YrQWSClllSzRNF/ruq5v9ZAzNTMBAAA=
X-Change-ID: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains various small improvements for reading object
info for either loose or packed objects. These improvements were split
out of a larger patch series where I'm about to introduce a new generic
`odb_for_each_object()` function.

Changes in v3:
  - Fix a commit message typo.
  - Fix a function comment missing some words.
  - Link to v2: https://lore.kernel.org/r/20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im

Changes in v2:
  - Rebase the series on top of master with jc/object-read-stream-fix
    merged into it. I've also evicted the patch that fixes the same
    underlying issue.
  - Improve the commit message that drops OI_DBCACHED to explain why
    this is a safe refactoring.
  - Link to v1: https://lore.kernel.org/r/20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      object-file: always set OI_LOOSE when reading object info
      packfile: always declare object info to be OI_PACKED
      packfile: extend `is_delta` field to allow for "unknown" state
      packfile: always populate pack-specific info when reading object info
      packfile: disentangle return value of `packed_object_info()`
      packfile: skip unpacking object header for disk size requests
      packfile: drop repository parameter from `packed_object_info()`

 builtin/cat-file.c     |  3 +--
 builtin/pack-objects.c |  4 ++--
 commit-graph.c         |  2 +-
 object-file.c          | 19 ++++++++++++----
 odb.h                  |  8 +++++--
 pack-bitmap.c          |  3 +--
 packfile.c             | 61 ++++++++++++++++++++++++++++++--------------------
 packfile.h             |  7 ++++--
 8 files changed, 68 insertions(+), 39 deletions(-)

Range-diff versus v2:

1:  8b6b891c2f = 1:  9efc7d00c1 object-file: always set OI_LOOSE when reading object info
2:  b83dd3d689 = 2:  efd29f0e27 packfile: always declare object info to be OI_PACKED
3:  6815b23dd7 ! 3:  1448cd37b3 packfile: extend `is_delta` field to allow for "unknown" state
    @@ Commit message
     
         Prepare for this change by introducing a new enum that encodes the
         object type. We don't use the "unknown" state just yet, but will start
    -    to do so in the next commit.
    +    to do so in a subsequent commit.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
4:  ec18d71d07 ! 4:  8eb063df04 packfile: always populate pack-specific info when reading object info
    @@ Commit message
         inconsistent object info depending on whether the info was populated via
         `packfile_store_read_object_info()` or `packed_object_info()`.
     
    -    Fix this inconsistecny so that we can always assume the pack info to be
    +    Fix this inconsistency so that we can always assume the pack info to be
         populated when reading object info from a pack.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
5:  cc0694bb0f ! 5:  33582ef5e0 packfile: disentangle return value of `packed_object_info()`
    @@ packfile.h: void release_pack_memory(size_t);
      
     +/*
     + * Look up the object info for a specific offset in the packfile.
    -+ * success, a negative error code otherwise.
    ++ * Returns zero on success, a negative error code otherwise.
     + */
      int packed_object_info(struct repository *r,
      		       struct packed_git *pack,
6:  98eee570b8 = 6:  42ec9b8170 packfile: skip unpacking object header for disk size requests
7:  9c9e71d7b2 ! 7:  03bc55e74f packfile: drop repository parameter from `packed_object_info()`
    @@ packfile.c: int packfile_store_read_object_info(struct packfile_store *store,
      ## packfile.h ##
     @@ packfile.h: extern int do_check_packed_object_crc;
       * Look up the object info for a specific offset in the packfile.
    -  * success, a negative error code otherwise.
    +  * Returns zero on success, a negative error code otherwise.
       */
     -int packed_object_info(struct repository *r,
     -		       struct packed_git *pack,

---
base-commit: 7df68b50e49b6a1b576abb19b2e5d457749bc28b
change-id: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2

