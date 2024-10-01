Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130B82876
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775712; cv=none; b=O0shh/2XtalMTvgYH1ApCOXJjJmsd/ZsdMuEfRSztzef5akvSAC2A/KbXduOZwbgnA5D+ttt0FDWDTpbKKQJ61dB5Lfxd7HCwlJ4hudusVay0bVRoORqGpEX0RFk7KL0rm3zglaaXrYL/Bm89vPzcza+HPte30u6CfL/y2nA3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775712; c=relaxed/simple;
	bh=JofERKYrXHL8oEGm1PXJt93TvFDaNJM3QKEUHTYeQ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syr5Se84k1vPEfYRC37CTOh8y1nfJC0WHeym/nRBUgScOAM6OetXY+aSA7iI957RlnkUie1w83/I0wAo9l/+PNdrVJ1RrP5OgEE+hh4UUGIAdhflzyuIn/mva44BAChlaxnsAycSnoVz05orHc7iGqztDeel8yR+6qhKmTqoD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rNfU5m28; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkIUzINe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rNfU5m28";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkIUzINe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8566211408F7;
	Tue,  1 Oct 2024 05:41:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 05:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775708; x=1727862108; bh=PfaPFc5Aeu
	kpsbfblYYafL3C36E4aEeA+hkYeOckMBc=; b=rNfU5m28oMp3IwLN7Oa3ZPo4qQ
	d9BqD+V9QNXNWNWnXTSUgKYhTCDNPAH3Tx6DjVi4QGcNwn9WIftS1iz3Dk6xgrmp
	fESO7YTCwE0qIGXq+/W78taUq+Dpe9+0I05bVSOAxN1TTGkyrLQhRSrNW4v2NpFX
	03WQT7h38IB31NqeRsq6MMemOpD13xItZx1d81gpwg30FvqyLVRncVyP6j0Or5HI
	iYqSylDzFlCvN5VhOhsnbOVl12i/GLUwAbFOCkXvUwqxB+m3SFzqWcIDfQvyyhBq
	w/v24AESf9mi6MCSxJtFoE8QPrOTOaQUDbLJH0CZr4erepFaQ7fyTj7usuHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775708; x=1727862108; bh=PfaPFc5AeukpsbfblYYafL3C36E4
	aEeA+hkYeOckMBc=; b=mkIUzINew+LPXbGk7mpyuHLF2C2JbQmEWSlbTYJ/eVAN
	yNIgs+YNqSQSkfscggu5ol2SlgMZKVXh6zz1OmAnsHBCJmQozVLZ9ip81i3l9oE/
	/j2415gXQTZ/ltBZw8M9nIJPNaxsJn037a/dhsosqwHCoNdC8Y5FFy1yTqtWw0RA
	EWOAnUuhgs6ldLGwS63xurwtUYMyVXCnmwrfTjIyDL4+kAdJAOzYcmYwBtL3Zspm
	njRNbHpEILCgpkbOMu66noieayqhgIn8l7D2eiz1hO/BeSlixD7k35TzqTV6OQc5
	jY6sb0DuRYeSVMjxOxXOGzFwo9rfbaTiJ9IwZHGc/A==
X-ME-Sender: <xms:3MP7ZnHjY-PO1fclyQL0_Wi9jMwof7ieigzb6OGs7vwlmp4zzHyrKg>
    <xme:3MP7ZkV5AYJnguqlO8Dwc-6-KbCc5XRiYd9f2ozSCowL1pTizmTXoTlF0paRChlqz
    HkSDcQTy60DcJj5Bw>
X-ME-Received: <xmr:3MP7ZpL4kEZ2Yms3Xv3T7mdZRGtrJ1aBPXbh8G4x4R7CUI9AIRW80GQoFwVAiKfA12DA9xFOlUq_lRtnn83eOGz70SmXc4iaOX-AiHAgHzWtvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:3MP7ZlFuiFKIeP07ZG_SOIUfcUQ3mxIiSh5fEhKlcK-aLoYw3jPt1g>
    <xmx:3MP7ZtWCI-Rr7QD9JlEdjBWtwm9FLByAsoP5KYlG6VswvN6bJUrkHg>
    <xmx:3MP7ZgOv7N2nycM5x4RckwDlbl-WfiiVsrXln38kgFoo-rnSQt6ifg>
    <xmx:3MP7Zs3HZIZE0fM3rTYO-2FUCAx-KV9YWA5kOOUNOmz8kwaOksb7JQ>
    <xmx:3MP7ZjyjqHNOzb6z00bcBt-4KQ8X97f39qnDanGkTyfhgFoZ-JCzI9pn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:41:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7e5e914 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:40:57 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:41:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 00/25] reftable: handle allocation errors
Message-ID: <cover.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Hi,

this is the fourth version of this patch series that converts the
reftable library to start handling allocation errors. This is done such
that the reftable library can truly behave like a library and let its
callers handle such conditions.

Changes compared to v3:

  - Fix some additional sites where we use strdup(3P)/free(3P) by
    accident.

  - Convert preexisting callsites of free(3P) to use reftable_free().

  - Introduce a REFTABLE_FREE_AND_NULL() macro and use it.

  - Ban standard allocators in reftable code "banned.h"-style.

Thanks!

Patrick

Patrick Steinhardt (25):
  reftable/error: introduce out-of-memory error code
  reftable/basics: merge "publicbasics" into "basics"
  reftable: introduce `reftable_strdup()`
  reftable/basics: handle allocation failures in `reftable_calloc()`
  reftable/basics: handle allocation failures in `parse_names()`
  reftable/record: handle allocation failures on copy
  reftable/record: handle allocation failures when decoding records
  reftable/writer: handle allocation failures in `writer_index_hash()`
  reftable/writer: handle allocation failures in `reftable_new_writer()`
  reftable/merged: handle allocation failures in
    `merged_table_init_iter()`
  reftable/reader: handle allocation failures for unindexed reader
  reftable/reader: handle allocation failures in `reader_init_iter()`
  reftable/stack: handle allocation failures on reload
  reftable/stack: handle allocation failures in `reftable_new_stack()`
  reftable/stack: handle allocation failures in `stack_compact_range()`
  reftable/stack: handle allocation failures in auto compaction
  reftable/iter: handle allocation failures when creating indexed table
    iter
  reftable/blocksource: handle allocation failures
  reftable/block: handle allocation failures
  reftable/pq: handle allocation failures when adding entries
  reftable/tree: handle allocation failures
  reftable: handle trivial allocation failures
  reftable: fix calls to free(3P)
  reftable: introduce `REFTABLE_FREE_AND_NULL()`
  reftable/basics: ban standard allocator functions

 Makefile                            |   1 -
 refs/reftable-backend.c             |  39 ++++--
 reftable/basics.c                   |  93 +++++++++++++-
 reftable/basics.h                   |  23 +++-
 reftable/block.c                    |  29 ++++-
 reftable/block.h                    |   4 +-
 reftable/blocksource.c              |  25 +++-
 reftable/error.c                    |   2 +
 reftable/iter.c                     |  22 +++-
 reftable/iter.h                     |   2 +-
 reftable/merged.c                   |  84 ++++++++-----
 reftable/merged.h                   |   6 +-
 reftable/pq.c                       |   9 +-
 reftable/pq.h                       |   2 +-
 reftable/publicbasics.c             |  66 ----------
 reftable/reader.c                   |  70 ++++++++---
 reftable/reader.h                   |   6 +-
 reftable/record.c                   | 174 +++++++++++++++++++-------
 reftable/record.h                   |   6 +-
 reftable/reftable-basics.h          |  18 +++
 reftable/reftable-error.h           |   3 +
 reftable/reftable-malloc.h          |  18 ---
 reftable/reftable-merged.h          |   8 +-
 reftable/reftable-reader.h          |   8 +-
 reftable/reftable-stack.h           |   8 +-
 reftable/reftable-writer.h          |  12 +-
 reftable/stack.c                    | 187 +++++++++++++++++++++-------
 reftable/tree.c                     |  42 +++++--
 reftable/tree.h                     |  21 +++-
 reftable/writer.c                   | 154 +++++++++++++++--------
 t/helper/test-reftable.c            |  10 +-
 t/unit-tests/lib-reftable.c         |   8 +-
 t/unit-tests/t-reftable-basics.c    |  11 +-
 t/unit-tests/t-reftable-block.c     |  24 ++--
 t/unit-tests/t-reftable-merged.c    |  16 ++-
 t/unit-tests/t-reftable-readwrite.c |  65 ++++++----
 t/unit-tests/t-reftable-stack.c     |   6 +-
 t/unit-tests/t-reftable-tree.c      |  10 +-
 38 files changed, 885 insertions(+), 407 deletions(-)
 delete mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-basics.h
 delete mode 100644 reftable/reftable-malloc.h

Range-diff against v3:
 1:  8c99ecc325 =  1:  94eaef3ae5 reftable/error: introduce out-of-memory error code
 2:  4dcdf1d48e =  2:  fe55051cb7 reftable/basics: merge "publicbasics" into "basics"
 3:  21fa9b15d9 =  3:  b1a10d41d3 reftable: introduce `reftable_strdup()`
 4:  f6ad92ffd0 =  4:  fd9141e985 reftable/basics: handle allocation failures in `reftable_calloc()`
 5:  922783708d !  5:  bdfddbebce reftable/basics: handle allocation failures in `parse_names()`
    @@ reftable/basics.c: void parse_names(char *buf, int size, char ***namesp)
     +			if (!names)
     +				goto err;
     +
    -+			names[names_len] = strdup(p);
    ++			names[names_len] = reftable_strdup(p);
     +			if (!names[names_len++])
     +				goto err;
      		}
 6:  d4676e8a6a =  6:  756a32c285 reftable/record: handle allocation failures on copy
 7:  874e6a1c20 =  7:  ca64971e7b reftable/record: handle allocation failures when decoding records
 8:  42bc57fd00 =  8:  fc2f113cba reftable/writer: handle allocation failures in `writer_index_hash()`
 9:  9edd1d84cd !  9:  0ed99e0bdf reftable/writer: handle allocation failures in `reftable_new_writer()`
    @@ reftable/writer.c: reftable_new_writer(ssize_t (*writer_func)(void *, const void
      	strbuf_init(&wp->last_key, 0);
      	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
     +	if (!wp->block) {
    -+		free(wp);
    ++		reftable_free(wp);
     +		return REFTABLE_OUT_OF_MEMORY_ERROR;
     +	}
      	wp->write = writer_func;
10:  d4004a7f43 ! 10:  8dfbfd9286 reftable/merged: handle allocation failures in `merged_table_init_iter()`
    @@ reftable/merged.c: reftable_merged_table_min_update_index(struct reftable_merged
     +			reftable_iterator_destroy(&subiters[i].iter);
     +			reftable_record_release(&subiters[i].rec);
     +		}
    -+		free(subiters);
    -+		free(mi);
    ++		reftable_free(subiters);
    ++		reftable_free(mi);
     +	}
     +
     +	return ret;
11:  b2bd142021 = 11:  7b592a6c6b reftable/reader: handle allocation failures for unindexed reader
12:  9b5fd52862 = 12:  ceed838265 reftable/reader: handle allocation failures in `reader_init_iter()`
13:  0f3e3d1585 = 13:  1e997a5766 reftable/stack: handle allocation failures on reload
14:  c88645a251 = 14:  40d4d81378 reftable/stack: handle allocation failures in `reftable_new_stack()`
15:  92ad4fc934 = 15:  6aaae4baa6 reftable/stack: handle allocation failures in `stack_compact_range()`
16:  19acebd919 = 16:  103a59ef0a reftable/stack: handle allocation failures in auto compaction
17:  620658bffc = 17:  6799d299fe reftable/iter: handle allocation failures when creating indexed table iter
18:  48047dd4c9 ! 18:  c7e54d71d7 reftable/blocksource: handle allocation failures
    @@ reftable/blocksource.c: int reftable_block_source_from_file(struct reftable_bloc
     +	if (fd >= 0)
     +		close(fd);
     +	if (err < 0)
    -+		free(p);
    ++		reftable_free(p);
      	return 0;
      }
19:  08685605ba = 19:  92d39b9021 reftable/block: handle allocation failures
20:  a66937b7af = 20:  3416004e0d reftable/pq: handle allocation failures when adding entries
21:  c291114553 = 21:  a363930488 reftable/tree: handle allocation failures
22:  20f50c446a = 22:  28661500ff reftable: handle trivial allocation failures
 -:  ---------- > 23:  228cc81263 reftable: fix calls to free(3P)
 -:  ---------- > 24:  1c66f6ef8d reftable: introduce `REFTABLE_FREE_AND_NULL()`
 -:  ---------- > 25:  764961e6f0 reftable/basics: ban standard allocator functions
-- 
2.47.0.rc0.dirty

