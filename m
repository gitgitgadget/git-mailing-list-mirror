Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396F1B532F
	for <git@vger.kernel.org>; Wed, 28 May 2025 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435062; cv=none; b=DgzeYwalpnQL/X6ZRxjxnFyH+KaYnb1ei17hQDHjxCswBRFr6ALNUeOJ+wtQ+VY5cj0hHxyJxhGcY9awQmZeob6nCgJq3GZAsG8NRJqL580Kzfsm9cujXgmR4DERvcXU3Rfc1g/EUlpfkFb04DD8Vpc5k9IqCBThzqMnpwzN2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435062; c=relaxed/simple;
	bh=Kyxsroo+s/obBm26esVury3/Z2onggXEzTW2hxEZK8c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RW33vhAQeCtiTjkXmvgmsgfe6o0Es1VjoxbZdYFHAFtPoVIpdEhOZYzHHZ2fo6gwZ3SbmKp15n9H1mrpTefJaeIVq9vKiYJovhQF8g48+tVSf5DFkqEaYWYCNvUX5l4+ph2uZnUrZUYQq3ExJZiAvb0HW87CqEudk5pzQ74F6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pq3U6Rxz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OV8xtTyQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pq3U6Rxz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OV8xtTyQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E68471383AEB;
	Wed, 28 May 2025 08:24:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 May 2025 08:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748435058;
	 x=1748521458; bh=5VOIAlzkvmy0MLZGoWcBACTPQJOcGOG6i2BFl8UYIwc=; b=
	Pq3U6RxzCk+keoFdhhUwnPmww4I60tS1wF5rxl52wSBlYVR95nHgiicNJyzGdjnD
	ezg/wMBet9vsQJezozwEZDCMf58oCTH2s9e8p3cPK0H/xzOjnyO4yjGLQT/7ofwR
	nbFxS4jkR+/RV3GdFgxbkS8dhmzw9AY9u7kCRBNMCjcazkyqnKQ2dJb8DOfrchut
	JBj/w88bgdaEb0HBt9XycsDKJfdXSmUzUf1j2zZqsJ4hxM1pF341uMMkfoW+RgFh
	nBfCnkveJCWiAwe14Sn2Zbe4UU6zlMzx/ji6FflhgWfqamUOkOsy3uIFkgT2KR/0
	MVuRq3TE+Bz9InUZLhrP0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748435058; x=
	1748521458; bh=5VOIAlzkvmy0MLZGoWcBACTPQJOcGOG6i2BFl8UYIwc=; b=O
	V8xtTyQdn/k+AkLWCB06xPPooX5vA+GUK7dlBeapM9ytecPIJpN5NMj99OnUySgK
	VlXxvymqI8YaJd/OZBMp6TFWrHnedhrF9TwYl+u6EA4wljDRNdvPER/OvwPlw24i
	xcq/8pj4RRpoE828HQv24tj5cQETawLXo6Ha3dsyGxCFL0Fadlo7KFDvdPkJMSPr
	LHf8wSj4WnEO0lrNxOu9y/CkhrEdcb95/I6mvPtFcttxPO6S6RQpA5Quo3DcyouE
	F5jLAvzaW2xqrusFgikgVrGpxdhrw3Eohw0ru60ATsmvJrmDp7ZGirOsNGnihuOz
	rJZEDnXShbjTvku8VF0cA==
X-ME-Sender: <xms:cgA3aNJfNhZcoed-6d3bTjw-jJDXVJ-cjEqzbqP1pKRdarHMtGkh1Q>
    <xme:cgA3aJKUywgWDs7v0OE6uFXRNXIhuNzjUnfWcRyxc_MnsSVs-FB_xMqjToHxHLcRY
    cQUBxHBEZHLgZ-cUg>
X-ME-Received: <xmr:cgA3aFvGITAE1qypmH4F49sqfysg5x_aHYykr75CfO9MD3mofb7Qsdq7erO80QS3o5x5440sspI-W7AI4Q4QzFCcRRhhsK4cBZK5hRJu1ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeeg
    tdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:cgA3aOaiXuGvXp5qzw2aSm8D1NhXK2T5Fgb8ih33T2i7U4s1g05nKg>
    <xmx:cgA3aEbE8dcTRZY49i-DkVZt-6zRYGWy0sPJgkAuj75S7cXeo9IxkA>
    <xmx:cgA3aCAStk00qlOBuU-8Yjmn6pwkwYEUhUfXeFsVKiHravI5tputOw>
    <xmx:cgA3aCYJ7JIFt0okOBIAApzFhsUUZDa5CHbJPcclf-yxaSn7MHPF-Q>
    <xmx:cgA3aNmGVwXhKXXgHpwXSqkVD2Tfd8OjB6PZLhM0FZuEPUn1Ue7pJ3io>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 08:24:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d00bc098 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 12:24:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] packfile: avoid access(3p) calls for missing packs
Date: Wed, 28 May 2025 14:24:09 +0200
Message-Id: <20250528-pks-pack-avoid-stats-on-missing-v3-0-4cbd0e14bed8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkAN2gC/43NTQ6CMBCG4auQrh3TH2vRlfcwLgoMMCEUwpBGQ
 7i7hYVxp8t3knm+RTBOhCyu2SImjMQ0hBTmkImy9aFBoCq10FJbadUZxo5h9GUHPg5UAc9+Zhg
 C9MRMoYEcTeGss7aspUjKOGFNz33h/kjdEs/D9NoHo9qu/9tRgQLUWJ+q3F1yb27p40i92OCov
 zAtf2MaJBhjSquVqwtpP9i6rm9XvBu4GAEAAA==
X-Change-ID: 20250516-pks-pack-avoid-stats-on-missing-8e3b75755cf0
In-Reply-To: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch addresses an issue we have recently seen in our production
systems due to a stale MIDX. The MIDX contained entries for packfiles
that didn't exist anymore, which caused Git to repeatedly look up those
packfiles. Each missing packfile resulted in four repeated syscalls:
three access(3p) calls to check for supporting data structures, and one
call to stat(3p) to check for the packfile itself. The first three calls
are essentially wasted though when the stat(3p) call itself fails, which
is being fixed by this patch.

I doubt that the patch matters in almost any repository, but given that
the refactoring is trivial I thought to submit the patch regardless of
that. Another step would be to introduce a negative lookup cache -- but
that would be a bit more involved, so I decided against it for now as I
don't want to introduce complexity for dubious gains.

Changes in v2:
  - Drop the patch that reorders syscalls and add a comment explaining
    why the order is important.
  - Add a negative lookup cache for indexed packfiles.
  - Link to v1: https://lore.kernel.org/r/20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im

Changes in v3:
  - Use a macro to hide away the `(void *)(intptr_t)-1` magic.
  - Link to v2: https://lore.kernel.org/r/20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      packfile: explain ordering of how we look up auxiliary pack files
      midx: stop repeatedly looking up nonexistent packfiles

 midx.c     | 12 ++++++++++--
 packfile.c | 11 +++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

Range-diff versus v2:

1:  cf601a63e98 = 1:  c4087674967 packfile: explain ordering of how we look up auxiliary pack files
2:  e3108f7ce48 ! 2:  2fa98231464 midx: stop repeatedly looking up nonexistent packfiles
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## midx.c ##
    +@@
    + #include "pack-bitmap.h"
    + #include "pack-revindex.h"
    + 
    ++#define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
    ++
    + int midx_checksum_valid(struct multi_pack_index *m);
    + void clear_midx_files_ext(const char *object_dir, const char *ext,
    + 			  const char *keep_hash);
     @@ midx.c: void close_midx(struct multi_pack_index *m)
      	munmap((unsigned char *)m->data, m->data_len);
      
      	for (i = 0; i < m->num_packs; i++) {
     -		if (m->packs[i])
    -+		if (m->packs[i] && m->packs[i] != (void *)(intptr_t)-1)
    ++		if (m->packs[i] && m->packs[i] != MIDX_PACK_ERROR)
      			m->packs[i]->multi_pack_index = 0;
      	}
      	FREE_AND_NULL(m->packs);
    @@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
      
      	pack_int_id = midx_for_pack(&m, pack_int_id);
      
    -+	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
    ++	if (m->packs[pack_int_id] == MIDX_PACK_ERROR)
     +		return 1;
      	if (m->packs[pack_int_id])
      		return 0;
    @@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
      
     -	if (!p)
     +	if (!p) {
    -+		m->packs[pack_int_id] = (void *)(intptr_t)-1;
    ++		m->packs[pack_int_id] = MIDX_PACK_ERROR;
      		return 1;
     +	}
      
    @@ midx.c: struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
      				   uint32_t pack_int_id)
      {
      	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
    -+	if (m->packs[local_pack_int_id] == (void *)(intptr_t)-1)
    ++	if (m->packs[local_pack_int_id] == MIDX_PACK_ERROR)
     +		return NULL;
      	return m->packs[local_pack_int_id];
      }

---
base-commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
change-id: 20250516-pks-pack-avoid-stats-on-missing-8e3b75755cf0

