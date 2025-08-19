Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950EC311587
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591580; cv=none; b=DgnyczgN/UEdDVYyOP+qJNUwCRjAqt9dtU6xCtokduOuOhxDyrIPH5KOOqPC6hVPGVZnh8edRDUPdwSe+TvPUNr2tboR6MH177LL7fgfLjyAmji2T9YtpE9vB4hurQ3VG218v6+YI4dFs7lutcJMoLMBDXfwPWpxtdZBP/zHjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591580; c=relaxed/simple;
	bh=MxUZQcxacGnspCkzLbaykPYoZuDc/QJeZ4WpYkWYPSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MpO7UVbLxN8g8tIR69AiQZX+asS6aYb4W/DXLnOHdHozQkxlXRQOLWSmx8cl78m1upaRbBsOQQVHIMwupvKgWRLStpSNuOItwj4sz+2FBtHirTu3Tb0hncICrytBtSVYktpsU6hNx6a9vL84hhdtq0jwd0nZ/XOn8zSCmHloIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A36C/x0P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=asQLQ8vJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A36C/x0P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asQLQ8vJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 956877A027D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 04:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1755591575; x=1755677975; bh=rRajbdnGhC
	dZ9uMge9C5paU9IRuncp6H79Ea24nvv3Y=; b=A36C/x0P1/2lp5mlglXZnH4k1i
	4BjP/J2lzP3fB3Xy2qY6ubifc0tr198tglZk0MaQvr90yTMG0Ud627YLpooZPAFj
	Sv2DzbRcdOtwMcsMvfxIB+YRCknoPQv0xvQNqTD35FJX67Y6VnlPsIQJ8fBghTuG
	IzPlkt40tuIeuCgIQoMOgZhQOTfJ2GtGeepM4RE1eT9rUolpnpB7aFe4C1B+Z0k6
	IbLul4g17xq8sN8sWQ1KTpv1cmfdTPHUDME7q5KptKDZaoh+aRccv1E8A/BSI+wt
	EqQ8RQM3G6NospAeap2l2tz4r6m9IhKcIRvp0YXUYm3JyrBsVNi77QftkFow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755591575; x=1755677975; bh=rRajbdnGhCdZ9uMge9C5paU9IRun
	cp6H79Ea24nvv3Y=; b=asQLQ8vJjOZa5EYEDDcxBt15ld8tQiNrcfDsEQI74uDm
	ZwDk3kbH3cXPkUKCOemjemcaOWe3hSpNyQhilOLt8vOsgMqfSeAGPSi94lIdpmFX
	RKny08ycROwx9T/5/55WkaHn5IXifyzxyjrp3GJsKLAZO7rFG73PMBskbORM/Vcl
	wmRbdqB8jgzLS9iSMJwF3iZK6qFkGtgR5NxMKU5FTojc8GUXq2OFrxlXWq4nft2U
	H8s5tng4hLFNmrZIBs1ZdA/d9cmT8vz/GpRTEoyjiojgnXYedaCngqGTlFgpzrAW
	Vvr5EpAlM9LCuDCaLDFvJBWZ3QJMl4200R3Ez3swqA==
X-ME-Sender: <xms:lzOkaHbnEYxXyPQiKXtEajO5JW5TS7KyX4MecG3XUKcCloTmcIg9Iw>
    <xme:lzOkaIb8feqRgXewbQbNLbsgyrXidQ5NrhHmiWo-GavaJEtS-NPZdrUywdS3Dbgnh
    z2FjQlw-W7y9ZAgAg>
X-ME-Received: <xmr:lzOkaDVqgnDdL2sPBMSGw_-zPFTxCELoOhg1CoK-3_5PsyP-dRBVhfwsNfbxKOdl1RhXhEJI9fS6_Ib-oWzw8GBIQOYdkv5zA4EmyIIfplcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:lzOkaP3L85JObRmADunztmxwWVr9qW_-_2-OHM5UbrEdcP0Ims0Fow>
    <xmx:lzOkaKYV-s8JT5bhRe88Md5WJWKeW37wtAoghvMJx1dHi6fMOvyzRw>
    <xmx:lzOkaCpl9TQQYu5UzVYwUvwA4J-SgeCnf3qMpsPR3mpRCs9O5QZayw>
    <xmx:lzOkaGpuq4y2Cqng-Z6WtswYizUQYNGOG8pXX8ZRlTZVDiJGhoDxaA>
    <xmx:lzOkaCzqTVg41jiol4OYDUsK2aW0lhIDozpf3yeoi8Fp80dCB-xID7M6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f743096 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/16] packfile: carve out a new packfile store
Date: Tue, 19 Aug 2025 10:19:29 +0200
Message-Id: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEzpGgC/x3MwQrCMAyA4VcpOS8Qay3TVxk7xJppmLSlGSKMv
 bvF43f4/x1MmorBze3Q5KOmJXecBgfpxfkpqI9u8OQvNFLEe8C6GlZO66JvMbStNEEOgSONic/
 XCD2uTRb9/sfTfBw/xW0M32gAAAA=
X-Change-ID: 20250806-b4-pks-packfiles-store-a44a608ca396
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

information about a object database's packfiles is currently distributed
across two different structures:

  - `struct packed_git` contains the `next` pointer as well as the
    `mru_head`, both of which serve to store the list of packfiles.

  - `struct object_database` contains several fields that relate to the
    packfiles.

So we don't really have a central data structure that tracks our
packfiles, and consequently responsibilities aren't always clear cut.
A consequence for the upcoming pluggable object databases is that this
makes it very hard to move management of packfiles from the object
database level down into the object database source.

This patch series introduces a new `struct packfile_store`, which is
about to become the single source of truth for managing packfiles, and
carves out the packfile store subsystem.

This is the first step to make packfiles work with pluggable object
databases. Next steps will be to:

  - Move the `struct packed_git::next` and `struct packed::mru_head`
    pointers into the packfile store so that `struct packed_git` only
    tracks a single packfile.

  - Push the `struct packfile_store` down one level so that it's not
    hosted by the object database anymore, but instead by the object
    database source.

Thanks!

Patrick

---
Patrick Steinhardt (16):
      packfile: introduce a new `struct packfile_store`
      odb: move list of packfiles into `struct packfile_store`
      odb: move initialization bit into `struct packfile_store`
      odb: move packfile map into `struct packfile_store`
      odb: move MRU list of packfiles into `struct packfile_store`
      odb: move kept cache into `struct packfile_store`
      packfile: reorder functions to avoid function declaration
      packfile: refactor `prepare_packed_git()` to work on packfile store
      packfile: split up responsibilities of `reprepare_packed_git()`
      packfile: refactor `install_packed_git()` to work on packfile store
      packfile: always add packfiles to MRU when adding a pack
      packfile: introduce function to load and add packfiles
      packfile: move `get_multi_pack_index()` into "midx.c"
      packfile: remove `get_packed_git()`
      packfile: refactor `get_all_packs()` to work on packfile store
      packfile: refactor `get_packed_git_mru()` to work on packfile store

 builtin/backfill.c          |   2 +-
 builtin/cat-file.c          |   2 +-
 builtin/count-objects.c     |   2 +-
 builtin/fast-import.c       |   8 +-
 builtin/fsck.c              |   8 +-
 builtin/gc.c                |  12 +-
 builtin/grep.c              |   2 +-
 builtin/index-pack.c        |  10 +-
 builtin/pack-objects.c      |  22 ++--
 builtin/pack-redundant.c    |   4 +-
 builtin/receive-pack.c      |   2 +-
 builtin/repack.c            |   8 +-
 bulk-checkin.c              |   2 +-
 connected.c                 |   4 +-
 fetch-pack.c                |   4 +-
 http-backend.c              |   4 +-
 http.c                      |   4 +-
 http.h                      |   2 +-
 midx.c                      |  26 ++--
 midx.h                      |   2 +
 object-name.c               |   6 +-
 odb.c                       |  37 ++++--
 odb.h                       |  34 ++---
 pack-bitmap.c               |   4 +-
 pack-objects.c              |   2 +-
 packfile.c                  | 293 ++++++++++++++++++++++++--------------------
 packfile.h                  | 111 ++++++++++++++---
 server-info.c               |   2 +-
 t/helper/test-find-pack.c   |   2 +-
 t/helper/test-pack-mtimes.c |   2 +-
 transport-helper.c          |   2 +-
 31 files changed, 354 insertions(+), 271 deletions(-)


---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250806-b4-pks-packfiles-store-a44a608ca396

