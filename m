Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB0314B73
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007266; cv=none; b=QtfvXXObEtcqI/7/qgiCmRDg5gjPaP44pWugGWhyGZ3JR8scutXKYDTxYpvLBzoyYmM/LfhIKu2sjuMeL2VMUFWFB4ytQDVkVjPbni7FR2SE1FyuRt2UfevSrMXzwc3X6JaIFeOGNDmlxouGASeamiB+1C6v5VETvnlOd7cBaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007266; c=relaxed/simple;
	bh=JazYy0GFEK3d7jqXz0HVFu6yWBNpM2kgx5jNa0Oyd/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eDp4WdxMWd4pfXaYnFgMcMznrGYCXsWUGUsXPDMigyUKD1zj4RugIa6rwuSda0DWDzakfQnrnoiQuvA+Y0xab9J3hlmIxaR8gopgLEjp3kg2D2GAHeX4bIGogIUF7IdIGeSG3tyCAxhzHecm7de8NZ0Lwl6dDXnUNvsjx5Db4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AslRwrUX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7ZE40fu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AslRwrUX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7ZE40fu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EDB65EC01AF
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 07:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1774007263; x=1774093663; bh=al1mjF+tUB
	zuFnPhW28Oa6GiQEMufzxKkrkExbLJ4X8=; b=AslRwrUXVvzmbHNaREbHzh5GnT
	aj6Wn0J+AXNjRlzpsRfkzMH6HX7rkvO4fWlD97ay4mVd8MLKVihrgR5Ws8PJGl4X
	9iqhIclCfKtywy+FlNF8bNwPoV1NHrOvJEyuHgSoC/Jptt2r8JS3TgIPsWCj81bW
	EzAOxVIbP3L02XY/5wtDdgaFPXst9yruGefi1cWgt1QYLNf5wfYcJiQ0U0rSkq5e
	gjKZLf35fuEI2tXcF/EWsY1jiRGc6YsqyUOR2mzigOgdIXM0JL5/a+bFAJzBcy/c
	Gl7z9LN1a3sHYGqEO+tNWiZuUQ+YXCNBPdu3S85oORMlfn8bse3yx/5b8IEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774007263; x=1774093663; bh=al1mjF+tUBzuFnPhW28Oa6GiQEMu
	fzxKkrkExbLJ4X8=; b=Q7ZE40fuS0P/K3/rZBG/jlsJPYV5juczbup/cIRCBaBp
	/PUuPOjEKnJfOVFjP68ro7tnmRKFdw/NjgYcu1GRZUPPOFh0EvR/2nEJW+3hb622
	onPT2EVWbc1364fwvBAs9++TrBOj0Xss7xtCPes2XV2YL5NcsxB6h26FLTu3Et91
	WfFMHNDE6z4fFTR/aAe7hb/crLQ0/7YIDNMy4VZvk/KA5VfW5FkLzlT1HRmWjGtp
	9pVd4aIAECuxyFfchQHD/4AgcRfhrUbL9OFZxj7PlqTiwMxpcB4khzEiIlIwJAVG
	ON56hGvJUNiSIkuvSgjPu9L2ilLPZzp9YNq2ImODkA==
X-ME-Sender: <xms:3zO9adull7vroRn0pDvzMPkKtd1idN8PDmz39ms7R0_roUT9nan7qQ>
    <xme:3zO9adZ0GJXTYh5V60bqqb4ZwcSnJUotULgNDrtnQ1tzjzP_npMfuruL0uEC_iw7q
    3bh5rDUzThh6t80282T5T7n_3ktejUKolDLka_zkCWG3Rs0aXG0Nw>
X-ME-Received: <xmr:3zO9aWZuzDnX9djzspA0M7hIrWGE_pKKYg1A1sBeVYZJrbcDNMqf-9rkcFJ9npz2af3dDvPONRQTZKxowWU6ylN4ouZSYT1-RvdF2qSPL-oW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:3zO9aZUmuOm2h3VzPftjXLcq5yTRQDM3sqXEJX3Wn2Qu8wRUeDPvWA>
    <xmx:3zO9ad1Ak15NtK9nWGyW1zianSdhbqYnowRGcmUdIFJCPIE3qsYk9Q>
    <xmx:3zO9aQYZYMQ9g3K2I7oxQjMnolBMemY1TvmXqe65ipPAuJwI8zNB6A>
    <xmx:3zO9aQoV7Uc3Eoahk5WS1vKODPxRXmz6yvgeyUFs4Bu0V0FtWRk6jg>
    <xmx:3zO9aUdFh4W1I6mV3qMmcoEPNN142y2Ck5Ufd3-TDgx2kj3QRk6weiX2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74133105 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:47:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/14] fsck: drop use of `the_repository`
Date: Fri, 20 Mar 2026 12:47:05 +0100
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALkzvWkC/x3NywrCMBBG4Vcps3YgjaGIryIuNPlrhkITZuKN0
 nc3uPw252xkUIHRedhI8RKTsnaMh4Fivq0PsKRu8s5P7ugd3wPXxXi2uPBbWi7Pxi2DFbWYtKJ
 fDinFEE9I0wjqoaqY5fOfXK77/gPXCFawdAAAAA==
X-Change-ID: 20260320-b4-pks-fsck-without-the-repository-4ddc4c8ed61e
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series refactors "{builtin/,}fsck.c" to not depend on
`the_repository` anymore. These refactorings are mostly done to prepare
for upcoming changes where we'll make backend-specific fsck checks
pluggable.

Thanks!

Patrick

---
Patrick Steinhardt (14):
      fsck: drop `the_repository` in `fsck_walk()`
      fsck: drop `the_repository` in `fsck_finish()`
      fsck: refactor interface to parse fsck options
      fsck: drop `the_repository` in `fsck_set_msg_types()`
      fsck: stop relying on global state via `parse_oid_hex()`
      builtin/fsck: fix trivial dependence on `the_repository`
      builtin/fsck: stop using `the_repository` when snapshotting refs
      builtin/fsck: stop using `the_repository` when checking refs
      builtin/fsck: stop using `the_repository` when checking reflogs
      builtin/fsck: stop using `the_repository` with loose objects
      builtin/fsck: stop using `the_repository` when checking packed objects
      builtin/fsck: stop using `the_repository` when marking objects
      fsck: provide repository in `struct fsck_report_object`
      builtin/fsck: stop using `the_repository` in error reporting

 builtin/fsck.c           | 299 ++++++++++++++++-------------
 builtin/index-pack.c     |  15 +-
 builtin/mktag.c          |   7 +-
 builtin/refs.c           |   2 +-
 builtin/unpack-objects.c |   9 +-
 fetch-pack.c             |   4 +-
 fsck.c                   | 485 ++++++++++++++++++++++++++++-------------------
 fsck.h                   |  41 ++--
 object-file.c            |   5 +-
 pack-check.c             |   7 +-
 pack.h                   |   9 +-
 11 files changed, 520 insertions(+), 363 deletions(-)


---
base-commit: 7ff1e8dc1e1680510c96e69965b3fa81372c5037
change-id: 20260320-b4-pks-fsck-without-the-repository-4ddc4c8ed61e

