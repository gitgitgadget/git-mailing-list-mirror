Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C755661
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530250; cv=none; b=keBfmoGnl1MWVqoGGIclOdCseg6MjTIGAQcYDPjbvL2g8N9Zwn9UdiO2xGUInBHFJe6U1C3g89w5V/vmVDqRKol2Yprs/2seN5fSp/kLmSUZAEBZpo9NYpz8N+/H2P1RAejkrA8b0VC3/Gq1mZ0WghPMvlNtzLWEgOsEGWM2wkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530250; c=relaxed/simple;
	bh=YzHPKtu4+vjtiYsYPqqIb2GgfjGica/hqf/PwPHV0Ec=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bg4CmbLnTHVxP8ous/S/dnDH1SXlMfqHZ17AwqG1tQQ7wzYv2OTYpIBc3MHxrW3bpc3Yb1RDDP/AjFoDkAK0gZXc3xF/+v9RW56z/YBw4LAts280bTn5ia420INK6BP9aWTAzORRyMeiClYbsUI3nSSLuYM/03xKrzR73qcdAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bbDQxBYX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgxDMqbm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bbDQxBYX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgxDMqbm"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id C7BA0138FD3F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 02:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1723530245; x=1723616645; bh=ehPCOF9fVIczAjNPaTAIZ6SJwOS2bZSS
	Sqe+8zzlt9M=; b=bbDQxBYXUEOKT6oXdBOSGQvApnbcT1irKgB6C9o+aobJQQcF
	tKZ7Db9MBXNXDmgjYjvH2tfhUj4IsYiaS+ZxFk4RBwW3KprGKRTHMCzL74kzaK08
	z8Y65/xMZBEbsgak8PCU6lrWew6K4AcTJ+89oLw83gdiMmFLCKchZoY9ZyTIKorV
	U/nnYkgn3F4iHE90p0InVmmuk1u9MDS29qk4SEMNZ5FZ2JDEZ9YTqE03Tnii2DyV
	W50kfraT3pPwaWQceAfufFsT+jNh2yR9gAJNyX3/4PLe828biD6SHF5Bnn8gQJiv
	MDLinw65akbJvhQTG9HRCngKkfjYzkTdD/Od3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1723530245; x=1723616645; bh=ehPCOF9fVIczAjNPaTAIZ6SJwOS2bZSSSqe
	+8zzlt9M=; b=HgxDMqbmiAEoyYt36wFx8kfSqn/rMeWBlnnzGQZbmEEhK7kySxX
	WSPuVdR1Af6T5MBe3gH62rBeiUK5c4MFCi2gJ7zk+bD/gTT5IPvnr8pc4tY1DW8t
	GnoUUWx+5K1a4ZIKE9ZIzT9sQ7nYipvsNh3fdnH1gvqrp7uutzu2EQ/JUSkRFHRC
	55MCav2GusxvuTOW4QnIg0D4sNufOQ24JnSRTmmHxL8RTYiNe855eUkWxpPgLQ1H
	fK7AvnflTJJMnxXo54sq4S9pgSJz0rnn7OOQscWLrFfcqNoAF8iJ/iDBs2t3gZex
	U5fTXj3Uep7J9D/c69MRk5PBPKAzOsxicdw==
X-ME-Sender: <xms:Bfy6Zr_awgnCorjWv3AA-agHL-bwmy1lSGFgexU28IHl706h70cHgQ>
    <xme:Bfy6ZnvZiMrOn9ba2OVoiNJ1tzSY5vdRm_TsP3kYmwTK_EiOlbrvSE07N5J89kbn5
    BJWtZ42GMFRSTQyMw>
X-ME-Received: <xmr:Bfy6ZpBzbU5eLUmu16o5yTtbyHwLNy3mm_S63-W7ANy5yK70iRw2GU2WlIuY4djBrINbZbiVYeJbez7leDN02T3z125iOEDz8atDHpIUsOeCGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedufefgiedvvddtge
    ffudeuhfevkeffveeghedtffeiveefffeufeefffevledtteenucffohhmrghinhepphhk
    shdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Bfy6ZncAEWi905BvlWFG7mtCWmzcCTz8UQhASRWQijny9dZtIfp6ng>
    <xmx:Bfy6ZgPhn3ERi4kgG9GKjYcdtDf-YVGXlwpee-u38_6QbkUGFwNnXw>
    <xmx:Bfy6Zpkc5o7lTJ563AZ1vJuLXo-ksuNSe4NGweBSfGyKaJQS3jSRHQ>
    <xmx:Bfy6Zqs0VRODm3mlQW9-HCeVacchN4FmYCto9Fmdbk7sIrSAbB54yw>
    <xmx:Bfy6Zq0DBQ_fmKSmjNLvEZpYG4zqIpcpbHEfKLm5dWjYPp13u6w_T4ny>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d8e06af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:23:46 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/10] reftable: drop generic `reftable_table` interface
Message-ID: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series performs some simplification of the reftable library
by dropping the generic `reftable_table` interface. The intent of this
interface is to abstract away whether the underlying table is either a
single reftable, or a merged reftable. Arguably though, it is not needed
anymore starting with my recent refactorings [1] that made the reftable
iterator itself seekable, as that now provides such a generic interface
already.

So this patch series rips out the `reftable_table` interface, both to
remove unused clutter, but more importantly to make the reftable library
easier to understand overall. There is also a tiny performance gain of
1-3% by requiring one less vtable function call. But while that speedup
is consistent, I didn't include any benchmarks as it is rather close to
noise and not the primary motivation of this patch series.

Patrick

[1]: <cover.1715166175.git.ps@pks.im>

Patrick Steinhardt (10):
  reftable/merged: expose functions to initialize iterators
  reftable/merged: rename `reftable_new_merged_table()`
  reftable/merged: stop using generic tables in the merged table
  reftable/stack: open-code reading refs
  reftable/iter: drop double-checking logic
  reftable/generic: move generic iterator code into iterator interface
  reftable/dump: drop unused `compact_stack()`
  reftable/dump: drop unused printing functionality
  reftable/dump: move code into "t/helper/test-reftable.c"
  reftable/generic: drop interface

 Makefile                         |   2 -
 reftable/dump.c                  | 111 ---------------
 reftable/generic.c               | 229 -------------------------------
 reftable/generic.h               |  37 -----
 reftable/iter.c                  | 127 ++++++++++++++---
 reftable/iter.h                  |  30 +++-
 reftable/merged.c                |  72 ++++------
 reftable/merged.h                |   4 +-
 reftable/reader.c                |  70 +---------
 reftable/reader.h                |   4 +
 reftable/record.c                | 127 -----------------
 reftable/record.h                |   4 -
 reftable/reftable-generic.h      |  47 -------
 reftable/reftable-merged.h       |  26 ++--
 reftable/reftable-reader.h       |   9 --
 reftable/reftable-record.h       |   8 --
 reftable/reftable-stack.h        |   3 -
 reftable/stack.c                 |  94 ++++++-------
 reftable/stack_test.c            |  29 ++--
 t/helper/test-reftable.c         |  47 ++++++-
 t/unit-tests/t-reftable-merged.c |  17 +--
 21 files changed, 281 insertions(+), 816 deletions(-)
 delete mode 100644 reftable/dump.c
 delete mode 100644 reftable/generic.c
 delete mode 100644 reftable/generic.h
 delete mode 100644 reftable/reftable-generic.h

-- 
2.46.0.46.g406f326d27.dirty

