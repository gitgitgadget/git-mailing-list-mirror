Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887F1BD9F0
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728200; cv=none; b=fVOO12QmBYdyC20jU+iZrT68yFG32jI3IGIgSbJMYjq6NbF+p8Kh7BFYeTd3QnjB/26GuPaVFhybCxceJPHW62+0Sg0x5cGFN4dE0owP44n29s54NSO6ZlgIwEYx6/vU27jaomXPVubcEu9k+pXQSaqVNkRLH4riMcOZQlwjrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728200; c=relaxed/simple;
	bh=Bmm8wRobKFAM5gnag5DBwsUNk0Qr1dvlv8ON8vNr7r0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=l2z2X2dfINvMly0ZMF8m0+BKwewdxvXq3PZZD0iCgqY6dUBvtfksa0Fz1iiR4sn1voeLeFNalTFtqOJQVFJMvw/K6UenYAxPCSY9mue/AYBA4L0EgA6/+ehWpAa0s10x8R3XwELj7r+k18yU/yd4N2ElprqU5c4N7sIPeS1AsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pNc6WWXF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmLrfEz9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pNc6WWXF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmLrfEz9"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E265E1D00198;
	Thu, 17 Jul 2025 00:56:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 00:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728196;
	 x=1752814596; bh=G1iVh7+KvHJ81n8NY62aI+tMmYjeLqwdDB2/S4ZXHUM=; b=
	pNc6WWXF7PrzJgOvHHU2f7Jl7fsHgzfoe923AWZAU4OvUIp+WtLwEBX+ZXRGkrzq
	VlLlayd18bX9wwEHZDm17nblDv3mvgWol/zaLef6E3RytKcwAQirKo6xM+cL3rt8
	30FEmLXS7D9F6Ucn8re0fBxeOXSAc7o8gNqhaNpge59MHpmgHkhwK4KD+PcxPQel
	EYyJOfWTz0ywjrM3VFRWB8i6TjVth+uyujSHjJcfmLZtuviSq9Za2S2yhlL8H2Iw
	gOYMItwpiDrHAuyzp43eNVbhbFAr+aCTKVEpLQeh8tRoISu/H4LD4TX2vb3QCqP2
	UTNzQwLU73WDVGj/LkmCeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728196; x=
	1752814596; bh=G1iVh7+KvHJ81n8NY62aI+tMmYjeLqwdDB2/S4ZXHUM=; b=Q
	mLrfEz9YX6uGFt/JQQX+GVdKs0wlGaTgeW93DX0b2g12MFwmHz94vUUVUQobhrgQ
	4lj0Yg/QP+0zvd5oBYNxpmf8U1O0oM6dMyvxedYjPubz0GxmTAPDAqWRDWcx6rw1
	0eoUzfLqO9Rg2/Mcpgl7mNaf8qKhe+5xeg5eUF1mqbdW+p8LpjdxEohYxB0lOl8j
	xE2efPNO7qfsDY00bGkd/DcKac2CDazeJea4lcomKRepf7nQDSZwkpmuhaU/m9dV
	07lJIJ03+aZkIwwFk8BMuKDEcyIjiFriAqYcX82U0Z1B0oW7JRLpm+R8+BCF07Al
	vvArcz6twhylvviktt1yA==
X-ME-Sender: <xms:g4J4aLPS9x6wQKq0Whh7KSLg-6z_mfBtVwidxLQtxNkbEz-JoqPBqQ>
    <xme:g4J4aBcb6PC4MWpZQbUmAZ4RK3STT2IhHGm8HJ_OvXWOfIRZiudhpKZyc0aSDiTEz
    XifKOGfbcD4Rlqq9g>
X-ME-Received: <xmr:g4J4aAtd_4tWUL4FJapXPDsYK30hcW59XT1h-pDqLzTMYvLjLh-lvwWUPeBX3PFWole8c1RmpwK8XQt7bpy8JXBfLuPxy6Jg_b7iWyu1pM1L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g4J4aKk8jI4hP9suBh1255F-8Lr8OkDBmzIJCmQx1B3etBeg1AAzyA>
    <xmx:hIJ4aKwD_i2bi9Zcbn5aajK6uSgxoSk63kEUGlqH6ZsBEPVQ2SSzrQ>
    <xmx:hIJ4aENgPa2ZP-uYmeHioary3nJjTkFo38ShWI66yr7cFptLiUf0tA>
    <xmx:hIJ4aOpv07aC4EK-d8sgF5Spfskdidc7bNyVZYUxdFU2386QHfGpdQ>
    <xmx:hIJ4aO5vmC3x549iXy7aJl0Oa4p5lmKIG4LQatWKTBCMm6FEPbVURSyC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:56:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 915ff771 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:56:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] object-file: get rid of `the_repository`
Date: Thu, 17 Jul 2025 06:56:26 +0200
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHuCeGgC/5WNTQ7CIBCFr9LM2jEUoaSuvIfpwtZBxp/SAKmah
 rtLewOX38t731sgUmCKcKwWCDRzZD8WkLsKBncZb4R8LQxSSC2MaHF6RPT9nYaElp+Eb4/JEQa
 afOTkwxdbq2p5UIMyykDxTIEsf7aPc1fYcVx72+Vcr+k/9rlGgY1spOm1NsLYU9ns+QVdzvkH3
 /91mc8AAAA=
X-Change-ID: 20250709-pks-object-file-wo-the-repository-9f41234c4747
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this patch series refactors "object-file.c" to get rid of the dependency
on `the_repository`. In many such cases this is done by passing in a
`struct odb_source`, which prepares us for eventually converting this
into the "loose" object source with pluggable object databases.

The patch series is built on top of a30f80fde92 (The eighth batch,
2025-07-08) with "ps/object-store" at 841a03b4046 (odb: rename
`read_object_with_reference()`, 2025-07-01) merged into it.

Changes in v2:
  - Two small typo improvements.
  - Drop the last three patches from this series that move some global
    config into repo settings. Those cause a change in behaviour, and
    fixing that is a lot of effort that falls outside of the scope of
    this patch series.
  - Link to v1: https://lore.kernel.org/r/20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (16):
      object-file: fix -Wsign-compare warnings
      object-file: stop using `the_hash_algo`
      object-file: get rid of `the_repository` in `has_loose_object()`
      object-file: inline `check_and_freshen()` functions
      object-file: get rid of `the_repository` when freshening objects
      object-file: get rid of `the_repository` in `loose_object_info()`
      object-file: get rid of `the_repository` in `finalize_object_file()`
      loose: write loose objects map via their source
      odb: introduce `odb_write_object()`
      object-file: get rid of `the_repository` when writing objects
      object-file: inline `for_each_loose_file_in_objdir_buf()`
      object-file: remove declaration for `for_each_file_in_obj_subdir()`
      object-file: get rid of `the_repository` in loose object iterators
      object-file: get rid of `the_repository` in `read_loose_object()`
      object-file: get rid of `the_repository` in `force_object_loose()`
      object-file: get rid of `the_repository` in index-related functions

 apply.c                  |  11 +-
 builtin/cat-file.c       |   2 +-
 builtin/checkout.c       |   2 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |   4 +-
 builtin/fsck.c           |  16 +--
 builtin/gc.c             |  10 +-
 builtin/index-pack.c     |   2 +-
 builtin/merge-file.c     |   3 +-
 builtin/mktag.c          |   2 +-
 builtin/mktree.c         |   2 +-
 builtin/notes.c          |   3 +-
 builtin/pack-objects.c   |  34 ++++--
 builtin/prune.c          |   2 +-
 builtin/receive-pack.c   |   4 +-
 builtin/replace.c        |   3 +-
 builtin/tag.c            |   4 +-
 builtin/unpack-objects.c |  15 +--
 bulk-checkin.c           |   2 +-
 cache-tree.c             |   5 +-
 commit.c                 |   4 +-
 http.c                   |   4 +-
 loose.c                  |  16 +--
 loose.h                  |   4 +-
 match-trees.c            |   2 +-
 merge-ort.c              |   7 +-
 midx-write.c             |   2 +-
 notes-cache.c            |   3 +-
 notes.c                  |  12 +-
 object-file.c            | 306 ++++++++++++++++++++++-------------------------
 object-file.h            |  65 ++++------
 odb.c                    |  10 ++
 odb.h                    |  38 ++++++
 pack-write.c             |  16 +--
 pack.h                   |   3 +-
 prune-packed.c           |   2 +-
 reachable.c              |   2 +-
 read-cache.c             |   2 +-
 tmp-objdir.c             |   2 +-
 39 files changed, 333 insertions(+), 295 deletions(-)

Range-diff versus v1:

 1:  c150744a648 =  1:  4fc36ad30ae object-file: fix -Wsign-compare warnings
 2:  5cdc43d3d27 !  2:  c5ad1d12618 object-file: stop using `the_hash_algo`
    @@ Commit message
         anymore, either by deriving it from already-available context or by
         using `the_repository->hash_algo`. The latter variant doesn't yet help
         to remove the global dependency, but such users will be adapted in the
    -    following commits to not use `the_repository` anymore, either.
    +    following commits to not use `the_repository` anymore.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 3:  8e63fb2d760 =  3:  76478623aa7 object-file: get rid of `the_repository` in `has_loose_object()`
 4:  14153d37df4 =  4:  ee7b31c95cd object-file: inline `check_and_freshen()` functions
 5:  70abad2d817 =  5:  4b7407f17b7 object-file: get rid of `the_repository` when freshening objects
 6:  5fc03ab39da =  6:  40a7c009c7b object-file: get rid of `the_repository` in `loose_object_info()`
 7:  9a07f6a27df =  7:  9568d7e996e object-file: get rid of `the_repository` in `finalize_object_file()`
 8:  739008ad578 =  8:  cf974b8b48d loose: write loose objects map via their source
 9:  f2f00d6f566 !  9:  fec51b64457 odb: introduce `odb_write_object()`
    @@ odb.h: enum for_each_object_flags {
     +	WRITE_OBJECT_PERSIST = (1 << 0),
     +
     +	/*
    -+	 * Do not print an error in case something gose wrong.
    ++	 * Do not print an error in case something goes wrong.
     +	 */
     +	WRITE_OBJECT_SILENT = (1 << 1),
     +};
10:  84411e2a8fc = 10:  ece58da8182 object-file: get rid of `the_repository` when writing objects
11:  f051bfbada1 = 11:  a76d5f24040 object-file: inline `for_each_loose_file_in_objdir_buf()`
12:  3754b37207a = 12:  70e60db13f6 object-file: remove declaration for `for_each_file_in_obj_subdir()`
13:  be855be5c0e = 13:  77ec9b765dc object-file: get rid of `the_repository` in loose object iterators
14:  6cb7f6bc040 = 14:  b091f019d01 object-file: get rid of `the_repository` in `read_loose_object()`
15:  8ddb96c9f30 = 15:  3982420285b object-file: get rid of `the_repository` in `force_object_loose()`
16:  d885f70f58d = 16:  21272b2644b object-file: get rid of `the_repository` in index-related functions
17:  1640212fe06 <  -:  ----------- environment: move compression level into repo settings
18:  36496f2c42c <  -:  ----------- environment: move object creation mode into repo settings
19:  8760509c0bb <  -:  ----------- object-file: drop USE_THE_REPOSITORY_VARIABLE

---
base-commit: f0228c39bf2fe539583cd594671039f05765bc9b
change-id: 20250709-pks-object-file-wo-the-repository-9f41234c4747

