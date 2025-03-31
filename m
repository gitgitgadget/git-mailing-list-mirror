Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395E1684B0
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410486; cv=none; b=OFEQAwIcjXd/e+f0tqxh5PCGYlPOqhGeJdpoD1dyXCuaLztmqj4yp6X7P4jA5nPFtedBpzAYFkXxIVzQmr08LLNZw+6Jb5S6nPTcH4enZXwlct/weAfn1k/tddi0n4eMA7aBqL6bduOkYa6ATVeaapEDcO9KbhPqry1t8ja9ifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410486; c=relaxed/simple;
	bh=rm/mgqB5yjjPGHkImb8o5nZDx7SVISCGnIzXt6+87Gc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cjLk5jx8PunJxGvzUjkgbmt5YjsqC9K07/xvxh3KGAR3VDeuwjdipn3iTS0TKcAX2YktzFoA/m/uvBtNgNqkc4aZIWbADqVbCMEQssyQrqUTNa5FXT2Dq4zygXg1odeKXJGZF8O6Tw3wetbFu6qjCVNHa6EW+2uI1ypVKwOvkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pVBz0yMp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLqz6N6p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pVBz0yMp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLqz6N6p"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFE381140109
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 04:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1743410483; x=1743496883; bh=d7+/OCZC5W
	X7BscYU3ikbtsc31AHQfyzFqF/rvduBok=; b=pVBz0yMpSlFT7RkJgmA1+ZAb7V
	+YroZ6KUsPoMVz1WRzunTf6Z0vwmD/M0BihEkkc7cqs+Nm7nbb6V84cNg6WjmeVB
	luDcr2C9F+70yKfoydug1np2hYXurm4LYj5hQOo6PRtnDRRrOY7NpQshlnNTp3IT
	lOukkGNgtbt8gSm/64iTX/fkJDV2AqO6lKBXtgHGtEL1GsKZj6XqvsuymGxzG7N4
	tj6z72TPIoclswkHa6LAMO5f094D9t5yLXxTUzbk2fFQ3MebQXlKO/hWUr+A5SmU
	mq4dq4m5ADsaqMrDfZExzVY4+0XxNdZD5JThghyFVsytq8NylWnRcd5Cxkow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743410483; x=1743496883; bh=d7+/OCZC5WX7BscYU3ikbtsc31AH
	QfyzFqF/rvduBok=; b=fLqz6N6pcmyARvfjqv7tLW/EOQL10yeEU2nD3OAClHct
	mhMxB0tkvX8Ms/Y8tMXCEDNCiU4dKraKMq+/HiWMcGq4vfCdeiht70U21uOlSvqx
	rylNxHl1vzQdiqU8qXuxeijVmw56vJxoq6i1n/bJbGKh+kLRlbUuskL52rBcG2mD
	WyihndzFIpvNAF97BmjTxgjTHDYsoZWDdAxLE+DQXkF7PB8nbrnHkt+d+9sRXKOj
	Bi4OI67tF/wkgT62JpGXV6CaxHGQxkEcjwSWdv73rwBh3/K1pUOwVlsTiUk09UfY
	W36HZqITefHwlpc1j5clefRD2B3MoYNvkizmrzLHrg==
X-ME-Sender: <xms:M1XqZ8DOaHAjvpgv5Qymp1U0wuSc6BWeLx_uIitbBIryDaQpV1sc9Q>
    <xme:M1XqZ-ijVmd42DafHxRe4VnlTiOx2N3hQBRDSwKxf0I78Z7XSAAY2iReR2FszEXJY
    zDmDFZf-HvxVKtKiA>
X-ME-Received: <xmr:M1XqZ_mRZhjmwKOCGxdPwdJC1SPqkmlJu29wg9Z2tlV4CW-uejPhkYxy90ulSFuf40mhVlH9AArqwBwPkeLoieP3jPGslW9FF6s1i5rvrrE4NC4L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektd
    etieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M1XqZyxJQU-fCxoosDZQ0b7AwwtQsFuGSkmo_v2OhtPv98xZ1DJ7Qg>
    <xmx:M1XqZxR0XT-nkWOJnwJdvoN9hcptkfAHPg1osbsyxTSCyLQmt0izhQ>
    <xmx:M1XqZ9YAa8zLP_z319yDLFwX-MmxhvMt2qHmtUIwUAXlQtErElmQxg>
    <xmx:M1XqZ6QwNfiBK5CbMeC9MjXmTGM-YxVu25Y5Ga000zL-p5JJgRnvsQ>
    <xmx:M1XqZwLOj8ad8lkOGaUqfObAuQ0eXREZbPdGfw2-a3Hu0FHYmuUnNUAW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7a7668f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/16] reftable: overhaul the API to expose access to
 blocks
Date: Mon, 31 Mar 2025 10:41:18 +0200
Message-Id: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC5V6mcC/y2MQQ6CMBBFr0Jm7SS0ZWG8inFRywcmklI7YEwId
 3eiLt/Pf28nRRUoXZqdKl6ismQDd2ooTTGPYOmNybe+c961XB7KFcMa7zO4LLPoJHnkEHxCcOf
 UI5LJxT7y/oavtx9XPDfrr//xOD7wz6lufQAAAA==
X-Change-ID: 20241210-pks-reftable-polishing-332ce318cdea
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series is a bigger overhaul of the reftable API. This
overhaul has two main motivations:

  - The reftable library is now standalone and can be used by code bases
    other than Git, like libgit2. This patch series thus renames a
    couple of subsystems to have more intuitive names before we gain any
    new users.

  - Some of the data of reftables isn't accessible at all via public
    interfaces. Most importantly, it is not possible to access
    individual blocks in a table. While users shouldn't need that access
    most of the time, an upcoming usecase that Git itself has is to
    implement consistency checks for the reftable backend. Here we'll
    want to read through blocks and their respective records one by one
    to ensure that they are sane and then iterate through records
    contained in these blocks.

The patch series is structured as follows:

  - Patch 1 is a trivial global refactoring to fix formatting of the
    license headers. They have been annoying me for far too long.

  - Patches 2 to 8 consolidate and rename a couple of data structures:

      - `reftable_reader` becomes `reftable_table`, as it is used to
        access an individual table.

      - `reftable_block` becomes `reftable_block_data`, as it is only a
        simple container for the underlying bytes.

      - `reftable_block_reader` becomes `reftable_block`, as it is used
        to access an individual block.

    Overall, the data structures are now called after what they provide
    access to compared to the rather generic previous names. This is
    also in line with other data structures like `reftable_merged_table`
    and `reftable_stack`.

  - Patches 9 to 13 refactor the block interface so that it can expose a
    generic `reftable_iterator`, granting generic access to all of its
    contained records.

  - Patches 14 to 16 refactor the table interface to expose a new
    iterator over its contained blocks.

  - Patch 17 refactors `reftable_table_print_blocks` to be implemented
    on top of these new iterators. This allows us to move it out of the
    library codebase into the test helper.

The series is built on Git v2.49.0 with ps/reftable-sans-compat-util at
8f6a2dbe340 (Makefile: skip reftable library for Coccinelle, 2025-02-18)
merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (16):
      reftable: fix formatting of the license header
      reftable/reader: rename data structure to "table"
      reftable/blocksource: consolidate code into a single file
      reftable/block: simplify how we track restart points
      reftable/table: move reading block into block reader
      reftable/block: rename `block` to `block_data`
      reftable/block: rename `block_reader` to `reftable_block`
      git-zlib: use `struct z_stream_s` instead of typedef
      reftable/block: create public interface for reading blocks
      reftable/block: store block pointer in the block iterator
      reftable/block: make block iterators reseekable
      reftable/block: expose a generic iterator over reftable records
      reftable/table: add `reftable_table` to the public interface
      reftable/table: introduce iterator for table blocks
      reftable/constants: make block types part of the public interface
      reftable/table: move printing logic into test helper

 .../howto/recover-corrupted-object-harder.adoc     |   4 +-
 Makefile                                           |   4 +-
 compat/zlib-compat.h                               |   4 +-
 git-zlib.h                                         |   2 +-
 meson.build                                        |   2 +-
 reftable/basics.c                                  |  12 +-
 reftable/basics.h                                  |  19 +-
 reftable/block.c                                   | 284 ++++++++-----
 reftable/block.h                                   |  85 ++--
 reftable/blocksource.c                             |  67 ++-
 reftable/blocksource.h                             |  39 +-
 reftable/constants.h                               |  18 +-
 reftable/error.c                                   |  12 +-
 reftable/iter.c                                    |  36 +-
 reftable/iter.h                                    |  18 +-
 reftable/merged.c                                  |  42 +-
 reftable/merged.h                                  |  16 +-
 reftable/pq.c                                      |  12 +-
 reftable/pq.h                                      |  12 +-
 reftable/reader.h                                  |  67 ---
 reftable/record.c                                  |  52 +--
 reftable/record.h                                  |  12 +-
 reftable/reftable-basics.h                         |  10 +-
 reftable/reftable-block.h                          |  74 ++++
 reftable/reftable-blocksource.h                    |  29 +-
 reftable/reftable-constants.h                      |  18 +
 reftable/reftable-error.h                          |  12 +-
 reftable/reftable-iterator.h                       |  12 +-
 reftable/reftable-merged.h                         |  18 +-
 reftable/reftable-reader.h                         |  72 ----
 reftable/reftable-record.h                         |  12 +-
 reftable/reftable-stack.h                          |  12 +-
 reftable/reftable-table.h                          | 115 +++++
 reftable/reftable-writer.h                         |  12 +-
 reftable/stack.c                                   | 188 ++++-----
 reftable/stack.h                                   |  16 +-
 reftable/system.h                                  |  12 +-
 reftable/{reader.c => table.c}                     | 463 +++++++++------------
 reftable/table.h                                   |  29 ++
 reftable/tree.c                                    |  12 +-
 reftable/tree.h                                    |  12 +-
 reftable/writer.c                                  |  34 +-
 reftable/writer.h                                  |  12 +-
 t/helper/test-reftable.c                           |  81 +++-
 t/meson.build                                      |   2 +-
 t/t0613-reftable-write-options.sh                  |   9 +
 t/unit-tests/t-reftable-block.c                    | 218 +++++++---
 t/unit-tests/t-reftable-merged.c                   |  86 ++--
 t/unit-tests/t-reftable-pq.c                       |  10 +-
 t/unit-tests/t-reftable-reader.c                   |  96 -----
 t/unit-tests/t-reftable-readwrite.c                | 106 ++---
 t/unit-tests/t-reftable-record.c                   |  40 +-
 t/unit-tests/t-reftable-stack.c                    |  66 +--
 t/unit-tests/t-reftable-table.c                    | 205 +++++++++
 54 files changed, 1638 insertions(+), 1274 deletions(-)


---
base-commit: bc705c20b9a88abaff0f379bab6d545f012656af
change-id: 20241210-pks-reftable-polishing-332ce318cdea

