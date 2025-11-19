Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8952E1730
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538450; cv=none; b=uh5Xuh/vEtR5MF7RvVJmU9zekCweaw2fcVrBOgAPvVRlMtCpuL2aIholK/KvWnBU5l1/6AWZKw2HeX9sj4GMlzk1QK2MqIam06gE0Y5rs30WE2Htgo/xyI+Q3aydCiOP2tghE8n2RamufVTokh8KHiZu9LqaIXUvpCP5vGQSrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538450; c=relaxed/simple;
	bh=KCCXdfUj0Mbj1+F3NnO5+FVe6i/CF+/8bY/+5X19yUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OKDe/GutX1tSG0qOptBUCbT9N6kt6RXwFTLR0tdTKgty/7RibJzQ5ap/a+cWc69AbcoU3/Jdurx0F739fBz6D9V2Idax2urt6s8E9zPXVJgFNm+La3/1/pJaAm7StaTf4m05dVI0dy0/SIO1ma8KXXAeGx/nSLJBCwHCjZUGRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FOnVjeQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSbWw1S5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FOnVjeQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSbWw1S5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 902F314001E6
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 02:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1763538445; x=1763624845; bh=NwBJb0M1fh
	9A7sM5igO3Fv55s5DQJ+oOmyDuqWSNK2Q=; b=FOnVjeQMinchOzqKM2kXxQMmAJ
	hTMOTrgYQOAj1/h5uoaoDEaA8FwkFMD/Jwl/1jSxaMnECQe1Arxccn7tZKNyIOSK
	OV+REK95+OHpjMtZvF9g1CTf5X7iuc/NcuL2N6DR5yu1P+XNwm2jR/2YdrBX4dRy
	8LrnQ2C0/TJ2wc1Vkw1R667wsLxHcf0eJV7YIV4tpcKQbWSB1oNKxDf8svkQxtiW
	yVKYxGVMJza+TUuDEPHmht2OJxcvwUNsua9px3ILC27Rk7JWn7d41D5/iPKu7oVD
	WATl0xxYwQ+rl2hmSovCqq0aK0nQe7vww/k1t+hZws5sHrSa1vvaXsCWggwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763538445; x=1763624845; bh=NwBJb0M1fh9A7sM5igO3Fv55s5DQ
	J+oOmyDuqWSNK2Q=; b=qSbWw1S5ipcEJqReD/TZvFZZNUM6VFjLXJyuO1DNBgrA
	mPdD4XfIzwVwViA7IRz0XWJykh3yJEDtSyYl2Mk+zYo1LGmdLi803zVl2nJwSfjZ
	h/mEt+cQYwx+VdR5jgGJSUbP+DNlCSnqz18/PNgfawRz4FMmRhSHpJR/E5xuiBwZ
	KiMCMVu4wilyA4jFK12s2DbmjFEMNoefy7eP3ihyqeE5bSbw3VeL+EsnpRUmSdMu
	KoIkS06ctDW+JATDSooNZyxeoidh7lmH7/MfTMwwT9gYoHC9oQ/zx6Uoq321iWpu
	u59wBbQYWheXyEemxYBNb6ZNvg6DXBMkcRDYuZcSBw==
X-ME-Sender: <xms:DXYdaaPZLu3i_dvMpdYDBl9ssESVAS6O26MrCfW5GbRzzSp0l024NQ>
    <xme:DXYdaf4wX7cB3Jn7mOfrsaA7CB0Sf4ivWAWhzQ8jo1Zojs1oletMjUjIQc2uK0rV9
    Ag1QEWUPUUYZJAA814kdqUss_hb-l2_Y9-_WANG7t3BF_IyYdTrZg>
X-ME-Received: <xmr:DXYdaW571oMkU862xXwHIwg05cLwu9YbO4uiS85ddET_Yo3806wNOrF71rEPIOy7baNrsDqZ9H5qh_qixoolAvoxVmlNJRfukT25BNrzbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:DXYdaf3iFGsIcnQUeus0hW2ZDc1J5fK24dLUZwvnA9kqXkRjui5HuA>
    <xmx:DXYdaSXpNKQ8XyeEigudawOYFOkYRPIIAGQRBPj6xpYCKFhtGD9F3Q>
    <xmx:DXYdaa5vxTkqtmiPRiV4MNFD0jZaGFC9hL1GVziuUz6sQpkIITB4ww>
    <xmx:DXYdaZLqzeKcFQVtM5QuFbKHqJbJPmSXZ0z-hi_LqF7UI7CESBuzGQ>
    <xmx:DXYdaa_rq3YJtgAkOWpFAaqOuxpdQ665G6r7eTjUDgpH_lDW4DVZzvbt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b40b13b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/18] Refactor object read streams to work via object
 sources
Date: Wed, 19 Nov 2025 08:47:00 +0100
Message-Id: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPR1HWkC/x2MQQqAIBAAvxJ7bkGjMPpKdNBca4ks3Igg/HvSa
 ZjDzAtCiUlgqF5IdLPwEYvouoJ5tXEhZF8cGtV0WiuDrsVzEzy8w0TWo1wFOxqyJihStg8tlPh
 MFPj5x+OU8wdmp0GgaAAAAA==
X-Change-ID: 20251107-b4-pks-odb-read-stream-7ea7f0e0a8f4
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

the `git_istream` data structure can be used to read objects from the
object database in a streaming fashion. This is used for example to read
large files that one doesn't want to load into memory in full.

In the current architecture, all the logic to handle these streams is
fully self-contained in "streaming.c". It contains the logic to set up
streams for loose, packed, in-memory and filtered objects. This doesn't
really play all that well with pluggable object databases, as it should
be the responsibility of the object database source itself to handle the
logic.

This patch series thus revamps our object read streams: instead of being
entirely contained in "streaming.c", the format-specific streams are now
created by the ODB sources. This allows each source itself to decide
whether and, if so, how to make objects streamable.

This overall requires quite a bit of refactoring, but I think that the
end result is an easier-to-understand infrastructure that is an
improvement even without pluggable object databases.

This series is built on top of v2.52.0 with ps/object-source-loose at
3e5e360888 (object-file: refactor writing objects via a stream,
2025-11-03) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (18):
      streaming: rename `git_istream` into `odb_read_stream`
      streaming: drop the `open()` callback function
      streaming: propagate final object type via the stream
      streaming: explicitly pass packfile info when streaming a packed object
      streaming: allocate stream inside the backend-specific logic
      streaming: create structure for in-core object streams
      streaming: create structure for loose object streams
      streaming: create structure for packed object streams
      streaming: create structure for filtered object streams
      streaming: move zlib stream into backends
      packfile: introduce function to read object info from a store
      streaming: rely on object sources to create object stream
      streaming: get rid of `the_repository`
      streaming: make the `odb_read_stream` definition public
      streaming: move logic to read loose objects streams into backend
      streaming: move logic to read packed objects streams into backend
      streaming: refactor interface to be object-database-centric
      streaming: move into object database subsystem

 Makefile               |   2 +-
 archive-tar.c          |  10 +-
 archive-zip.c          |  16 +-
 builtin/cat-file.c     |   4 +-
 builtin/fsck.c         |   5 +-
 builtin/index-pack.c   |  12 +-
 builtin/log.c          |   6 +-
 builtin/pack-objects.c |  20 +-
 entry.c                |   4 +-
 meson.build            |   2 +-
 object-file.c          | 179 ++++++++++++++--
 object-file.h          |  42 +---
 odb.c                  |  29 +--
 odb/streaming.c        | 299 ++++++++++++++++++++++++++
 odb/streaming.h        |  70 ++++++
 packfile.c             | 199 ++++++++++++++++--
 packfile.h             |  17 +-
 parallel-checkout.c    |   5 +-
 streaming.c            | 561 -------------------------------------------------
 streaming.h            |  21 --
 20 files changed, 784 insertions(+), 719 deletions(-)


---
base-commit: 899e578b5b7c020aec806bd694adf2563f62843c
change-id: 20251107-b4-pks-odb-read-stream-7ea7f0e0a8f4

