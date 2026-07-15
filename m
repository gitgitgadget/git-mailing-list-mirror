Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2A33DEE6
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096562; cv=none; b=RTG63PJaZB4xtYj8xI8Z7jJcKd0KMZPYVAx7KldDXneNuMq+WWviLBRpLVoQ52UYYmGjtC9Y6MkwvK690smHgT7aLC9XzuKdYCZXilkjtJjHNYen1znZ2/CDa4lb5k8+T8JrL1cNibyw3BhPzfbtQLitpBT1LqQiTYkhusacL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096562; c=relaxed/simple;
	bh=n4WCm3rjtqExfSOrI4ZnOQ1QGkAQszKrlIiVHX76jJo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=odBBMC10iVgJPqOEYL1zCiO4CGKgWYQD9rr/XTZ8nYQziMpi8GnPjXDIfsyPn7V5lb32J2a3jNeBQW8lWqd0fkCzA4v0OTH739jH0bqf2JvZ/yYCwJitFf+FSfwPASM4bydZJukbbEJAtReF0suoydVEepyKSt3detfdIbxL4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LOPSXFR+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTRHz6/d; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LOPSXFR+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTRHz6/d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0739F7A013B;
	Wed, 15 Jul 2026 02:22:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jul 2026 02:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096559;
	 x=1784182959; bh=ZZkGwQwp7r7BRaCMexNebv8Tgy+v25dn7ZGOeATiP5E=; b=
	LOPSXFR+/uMnNKWWmXfamiQgL5FZNp4cPZu7UPERDqTMIYojhWG7iJmp8ESCihan
	VgXyNiZkaFQiAeCV6VP/6pxAPAv4gT6GAkldSOgbIwtf3q93hLUl+r2msIWiGWXB
	1BiBlMQeGF0l3FCSKMaeRt/0b6xXAcgMXgSxxsAIRPSwFFQgpwSS7Au6YeHshGaZ
	aS1VJnsZjJnyWxSZRKHPnl2UtGdTqiZdTL6ExOzYgLWuKAd3m6HSHZA/iVLlEsep
	HTm5bbODUHJI5CALcBlz/lwEA26ejLBEZGhB3Y1GD5NkvBs2D39WfF2yF2zDXxjI
	u3zS1w5Q6gQiXjeTrJsG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096559; x=
	1784182959; bh=ZZkGwQwp7r7BRaCMexNebv8Tgy+v25dn7ZGOeATiP5E=; b=j
	TRHz6/dTRw7auDLwMSAsfNWQv8k8B+KyP2JF0xRjk5GROqPsNVkrszDQXM+24Y8W
	ZPemIRuo+AqKg2VVLnOm8MH8C3xLEJ8xksIy7sGzSl0u/dwCnx+HjwQErK0S/jzN
	U5m7vAksqCt7RKFL1lKJTekw8ep5gmdNyiU1xUUHwRnvsUjNBu2ML6tXaDEZWyXZ
	NHnASsQwBMQfgT9ss5AuqslajHyU6ViSpnxObCJ2kbcFP8JB9TgAsFeIYEMOVEYV
	GKvRD3Wti1TiVkYh/lhlIF6OP/fIqSuZLlltRg0HtYwUwpJK0REiIWhWQO3lxmMJ
	Grjgn24+iXDuNtZB8hEqg==
X-ME-Sender: <xms:LydXakK5E5aI3TX_2a6KeLRqIPLfClokN2zY2fcbIOU0CKVlJpH4qQ>
    <xme:LydXan1uIJsR4WfdU-A2Qbv3gH63z9MaKS1a_E_5tIMJHkYT24iTb9nqMRBlQrO8z
    aBab9Hqxkii3ZmxgGYlQDSsNOHiJpKgAOowSQD4qT9ez4bjYn7A5g>
X-ME-Received: <xmr:LydXauizErr4FIav5AQBfhPmKrM9Wcaobolv6B4_qznQn948dOFCDdGTATeiqeMKBmQNWzktuHXPcvn37itzCQdhr6VlJu9iGGXDlg6umIk>
X-ME-Proxy-Cause: dmFkZTFxdLMkd/VaIWD9oNSIZc6ApmKEfUAjcwfutUtze41N1O3ZKbfugdgKbRNa3kd+E3
    fTyDFSGRH5tNLfj7tVPzsBh4tsIH6RtiHvKekKjHG7zXK2gnC5zxuky7UCWC+1y56osOhs
    Q4fW0YPPUznDHD5PMq0YcRejrUJpDiL96NiuH5V5ou6ebXKHa1/eGps3z9YhdOShc16qRl
    7SYCcg7r8qL2p0UO2hzxmKhgRtYjYrT+vVLDJroB8+kF/UU529XqeiZIH7QZvBSwr4dbpc
    IPSwqFvBm4qPP7yeahbsR+qRMWfdJe3xKtl3EYIfjQrxeBsxqIWZ8/QlbhrU5/48oFYXR1
    1O90Xzv9XE72kwVxSIoQeeAUkjjM7FBvTTNVpjKAEBfIDxZTY9unDeuVPFSofOr/peANip
    CJKwZDZFQmocV2TBfwkKpPk3PZx+U0yrJQfLHB7im/MnHCqnYCH/04zpD8OetHb9B104nP
    Ms11B7aJAmUHsNEDJFo9CUATlHiVa4mNG2uI8F3LEkiCcQO8FPj/3spGfC3LaPtG3RiV7v
    60Fz1KHuiKOn6nvOWaSmVZx/O12fMg24K8Nech/i7VQlHlPyS31f8pD/9+C9ubujkgV4gs
    5zJWkME7ptsNi9eNFxOuZYTvUaYxgQMu603su+viszjyeCBKt7ovh+BdnEmA
X-ME-Proxy: <xmx:LydXaoV5ZvW1fVFbX_dNV0ChbPIjsiJKofvR5a5FS9S-yxHdJ7iZDg>
    <xmx:LydXatUK4VDkPpHRw843MK767rlLG7UZ0CeUcj_PzXqy01P5N36DCQ>
    <xmx:LydXaogZGeEh9oSwcxh1kjl0hDNy6AZ6LVFLf9_nt52pnMTdCobmyA>
    <xmx:LydXaoaFCOxN3nfce7fSGHcQ3EG22N4nmG-6HnIPHHiXb3t6gpsjKg>
    <xmx:LydXalCNHkP4_wAHdBWH87MB-9bbQku7zFoxx8oqUwLDWA4lou7f-8QB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2385b44d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/9] odb: introduce object filters to
 `odb_for_each_object()`
Date: Wed, 15 Jul 2026 08:22:30 +0200
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOTQ7CIBAF4KsY1o4BpsXqynsYF0AHi38YqI3G9
 O7SGqOuunzJm+/NkyWKnhJbz54sUueTD5ccivmM2UZf9gS+zplJLhVf8gquxwShNuBCBNK2gWA
 OZFtw/tRSBIGyUk5jKbFmGblGcv4+Dmx375xu48WgDo3GpzbEx/hBJ4beZ2w1NdYJ4FBJR1wUR
 kiDm3yw8Gc2LHXyxxJ80pLZwlzUK2uFKvWfhb8WTlqYLYNWlVYVgi+/f/V9/wL0NM19cwEAAA=
 =
X-Change-ID: 20260708-pks-odb-for-each-object-filter-13286fa3523d
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

this patch series introduces object filters to `odb_for_each_object()`.
The intent of this is to make `git cat-file --batch-all-objects` work
with pluggable object databases. Right now it doesn't because it reaches
into internals of the "packed" backend to efficiently handle bitmapped
objects.

The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
info fields, 2026-07-02) merged into it.

Changes in v4:
  - Fix references to an old function name in commit messages.
  - Link to v3: https://patch.msgid.link/20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im

Changes in v3:
  - Weave Peff's patch into the patch series.
  - Link to v2: https://patch.msgid.link/20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im

Changes in v2:
  - Add another patch to drop the `_1()` prefixes that aren't required
    anymore.
  - Change the approach in `open_bitmap_for_source()` to also use a
    `found` boolean instead of a confusing integer.
  - Add some more explanations to commit messages.
  - Link to v1: https://patch.msgid.link/20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im

Thanks!

Patrick

---
Jeff King (1):
      pack-objects: drop unused return value from add_object_entry()

Patrick Steinhardt (8):
      odb/source-packed: improve lookup when enumerating objects
      pack-bitmap: mark object filter as `const`
      pack-bitmap: allow aborting iteration of bitmapped objects
      pack-bitmap: iterate object sources when opening bitmaps
      pack-bitmap: drop `_1` suffix from functions that open bitmaps
      pack-bitmap: introduce function to open bitmap for a single source
      odb: introduce object filters to `odb_for_each_object()`
      builtin/cat-file: filter objects via object database

 builtin/cat-file.c     |  76 +++--------------------------
 builtin/pack-objects.c |  11 ++---
 builtin/rev-list.c     |   2 +-
 odb.h                  |  12 +++++
 odb/source-packed.c    |  77 ++++++++++++++++++++++++++---
 pack-bitmap.c          | 129 +++++++++++++++++++++++++++----------------------
 pack-bitmap.h          |  10 +++-
 7 files changed, 175 insertions(+), 142 deletions(-)

Range-diff versus v3:

 1:  2d4bc229ac =  1:  30cf75ce12 odb/source-packed: improve lookup when enumerating objects
 2:  dfa942f6da =  2:  735eb8ad5c pack-bitmap: mark object filter as `const`
 3:  9bfba42b27 =  3:  a1f32c5ea6 pack-objects: drop unused return value from add_object_entry()
 4:  405c77bad3 =  4:  acb0aad580 pack-bitmap: allow aborting iteration of bitmapped objects
 5:  70e68f10aa =  5:  199db72f4c pack-bitmap: iterate object sources when opening bitmaps
 6:  08ba2c1db3 =  6:  69d5882b57 pack-bitmap: drop `_1` suffix from functions that open bitmaps
 7:  d410cfa4e2 !  7:  a1eabafebd pack-bitmap: introduce function to open bitmap for a single source
    @@ Commit message
           - With multiple sources, each source would enumerate the same bitmap
             another time.
     
    -    Introduce a new function `prepare_source_bitmap_git()` that only opens
    -    bitmaps belonging to the given object source.
    +    Introduce a new function `prepare_bitmap_git_for_source()` that only
    +    opens bitmaps belonging to the given object source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 8:  e0df97e318 !  8:  6ef9885006 odb: introduce object filters to `odb_for_each_object()`
    @@ Commit message
         So in the end, this alternative would only limit us artificially.
     
         Implement the logic for the "packed" source. Note that we use the new
    -    function `prepare_source_bitmap_git()` to open the bitmap: as the
    +    function `prepare_bitmap_git_for_source()` to open the bitmap: as the
         backend operates on a single object source, we must only use bitmaps
         that belong to that specific source. Otherwise we might yield objects
         that are not part of the source at all, and with multiple sources we
 9:  e866b1f4b8 =  9:  104da65906 builtin/cat-file: filter objects via object database

---
base-commit: 3c8e2790f2ce15e8b5d4b4e6ced711b12649f32a
change-id: 20260708-pks-odb-for-each-object-filter-13286fa3523d

