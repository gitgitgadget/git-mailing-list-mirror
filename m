Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD31C1F00
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328145; cv=none; b=qRvXWNl4FGAr1odqqnUqwpvlmhNcngSwz3DyhX9KKSyMiBsBR6wgehVTYP08f6GKC46m39h7C2maB83YjQfWHtTkFRNGecvlZiTWvEutlOJINA/ZLSGF8xlfwFLVW9fPLG+0xJ+PBVjWbOYd64oO3zbMjQlPPV3PLLFJSVXvYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328145; c=relaxed/simple;
	bh=KPXeDlsj+xMn4CFGcwuGXJ8p8P0attWwkrh4RvTV4r8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FSYIw2J0/bDFesr7J/WRZ75UGpgckRSyqi98hvsl+uLojjfzWSy4uXyrCx2d37UADGHjExazDW1yjzf14F3rTDFlVL9KnjLHQo+o5+iv3FZtcbBXOEEbYehb/200p/6GDhMsdQTGlnmZgA7lTWErNvkATES93tRC1cwEonf7s6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LpBcXSJj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcDBCfpI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LpBcXSJj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcDBCfpI"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 097A113801C3;
	Fri, 31 Jan 2025 07:55:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jan 2025 07:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1738328142; x=1738414542; bh=UuoqzfPN5G
	EEeBYDkYep4IhdqnFM+xqtypNssJqPm00=; b=LpBcXSJj5u9V8ww0++YF5llUma
	hR3uOnX7LUhIU1tviMcHx9ag72rS2Ugju7h8NwhsMf5nGipGeJiQlP+XC1dYlly1
	XqV6EvYBC0YibPWhsAB0Y2O2XXHvaTDLnASNRnbIitzbZ3ql1xuQ8gA9PRuhYV0e
	BhuCEd2LNA/cFxSrbpkpimqUgeDY6iz+KxgGbfW82Dyo2kH4qYxT/rPZQWj20f6k
	OJ8VSOMOWBAAeTtXsP6GxPMr3ayozZ99lIHDv8p5e5+c1szt18YYzeCYb9KN1Zjc
	UIYJUgLpQxK2cslkfRvAvISvMislzRQDY/FLSSlYUt7SlKLWN/xBaZA54ZDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1738328142; x=1738414542; bh=UuoqzfPN5GEEeBYDkYep4IhdqnFM
	+xqtypNssJqPm00=; b=UcDBCfpIlH64EOBotRK7PbK5SleP5ZLLcVuZ9ImITyVx
	1na+0FshZ2rpcLUNkifQkYCvQ8yQwztXNOSZar8HeXKmr/Azkg81yT8SRIR+kTGF
	ItDZd0ZxJYrvfUi1oBFzIvv8R+bS/Fg9NIaArn60hopi7/cNwHOcUS1mIlHt+YD7
	h2BW7twICSgEfH65JSEtnm8aS1PazGf3HWV6Hhvn/HEu+j91LqQ+WxKxEpa8CEiF
	/ltwfb5UiHOViDVj3ivcj7QcHvQ7GPqaMOKKFapPMtU6/fwnUAYi+cNK1lykTwcy
	XGMZAM8zdPhdib65Z/Yfs1e4A+zrTbwTlrGsZOLxbw==
X-ME-Sender: <xms:TcicZ3Gdas2QtiL3tDgFw2ZwfZ3XbP4dz06m-B4HAH_-NUla7tzgAQ>
    <xme:TcicZ0Wr-qnmmtDUJMiAh0yCFDLbEf7dJDZc3tdpgRqUmGWndxOBqWm4d9t86SsRS
    mVySiNLlFM2Y7RdNQ>
X-ME-Received: <xmr:TcicZ5JCl0bqX-ddaVUixy_ExrX7xjE5eDexDG96tKliVjxsmLhG0queEalhwXBVpfmiNsZC0Fb5AM7JyLrTb2n8O3Fv7eX_1sU26zeqzyBGzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:TcicZ1HwsTOFPPSZ3K3V0gNp6h3Oksppk3W_NjaQ8S8DVit9s6B3qw>
    <xmx:TcicZ9Xcm-WFOX82v06aHbhIiwRQyoMBq4JZ_7sMN_zZZ6gjXZRPfw>
    <xmx:TcicZwMBB5e0Ojm6HIy44mFh8r9ATg1QsIOEp-6S3x1UK0NM_5eh2A>
    <xmx:TcicZ82xRZRNgXIS_CcIopaS5c86Ye3q1pmEFtzLsHb99xce0JutEw>
    <xmx:TsicZwRkn7lpko9eCglOkUi7l8ErPN1OJpkwBJr8VMIuF6EzcRyfPvao>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 07:55:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ef70964 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 12:55:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] hash: introduce generic wrappers to update hash
 contexts
Date: Fri, 31 Jan 2025 13:55:27 +0100
Message-Id: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDInGcC/x3MSwqEMAwA0KtI1hNo/SB4lWEWMU1tEKo0ZRDEu
 0+Z5du8G0yKisHS3VDkq6ZHbvCvDjhR3gQ1NEPv+sn5weM64rkbJrKEfOQqV8WgRbgi0UwcAw2
 0MrTgLBL1+ufvz/P8AKRi5iVsAAAA
X-Change-ID: 20250131-b4-pks-hash-context-direct-aa7acfda3abc
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series introduces a couple of generic wrappers to update hash
contexts. Instead of updating contexts via function pointers provided by
the hash algorithm, we now remember the hash algorithm in the context
itself. As a result, subsequent calls that update the hash don't need to
remember which algorithm they used:

    ```
    struct git_hash_ctx ctx;
    struct object_id oid;

    git_hash_sha1_init(&ctx);
    git_hash_update(&ctx, data);
    git_hash_final_oid(&oid, &ctx);
    ```

This was discussed in [1] and [2].

The series is built on top of master at 3b0d05c4a7 (The fifth batch,
2025-01-29) with tb/unsafe-hashtcleanup at 04292c3796 (hash.h: drop
unsafe_ function variants, 2025-01-23) merged into it.

Thanks!

Patrick

[1]: <Z3fhK1ACzJfVehM2@pks.im>
[2]: <Z4jyZCAwqOjZ-u2U@pks.im>

---
Patrick Steinhardt (4):
      hash: convert hashing context to a structure
      hash: stop typedeffing the hash context
      hash: provide generic wrappers to update hash contexts
      global: adapt callers to use generic hash context helpers

 builtin/fast-import.c      |  16 +++---
 builtin/index-pack.c       |  19 ++++---
 builtin/patch-id.c         |  14 ++---
 builtin/receive-pack.c     |  18 +++----
 builtin/unpack-objects.c   |  13 +++--
 bulk-checkin.c             |  10 ++--
 csum-file.c                |  16 +++---
 csum-file.h                |   4 +-
 diff.c                     |  34 ++++++------
 diff.h                     |   2 +-
 hash.h                     |  43 +++++++++++----
 http-push.c                |   6 +--
 http.c                     |   6 +--
 http.h                     |   2 +-
 object-file.c              | 130 +++++++++++++++++++++++----------------------
 pack-check.c               |   6 +--
 pack-write.c               |  16 +++---
 read-cache.c               |  26 ++++-----
 rerere.c                   |  18 +++----
 t/helper/test-hash-speed.c |   8 +--
 t/helper/test-hash.c       |   6 +--
 t/unit-tests/u-hash.c      |   6 +--
 trace2/tr2_sid.c           |   6 +--
 23 files changed, 224 insertions(+), 201 deletions(-)


---
base-commit: 16b8e620c866ddbff7e33cc47b9772541285da7f
change-id: 20250131-b4-pks-hash-context-direct-aa7acfda3abc

