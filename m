Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3C24503F
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554207; cv=none; b=XTde+B1e/B758dQuoU1P4338PQBk7YRJHQhp1tBhnK3p/FwWuQIYri4eS42cejSDav3nf1roANz5+aHqb/4HX9DF0FxsLf67oOxM9eqa7IHrFGH51N0+059pSXl1YShwaxSNcQhYgwWotj25BCkNWfgTGjg2eaKM4+CnpvZNkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554207; c=relaxed/simple;
	bh=LFkE1XwPPaHXIXQ/hhz6rUYcAbxhkdF3zqh8UHgeSwc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=jipYHL8uK7A13PKwRJ1WeBChg/2Q4zh4dXoLa11e+YWQYcK/mVTjXC+acNIlGEsN8WYMsXazoiurSG02E0sJYTbWtkn//OzTn98Zc3z/omdlkjFl/ZDvokRLp685fFOEFk72aawpCHF4k/q0R2mziAermiLYHTJcW1Npc6XEXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X1LgLrEV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lw6RSCak; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X1LgLrEV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lw6RSCak"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BD6DEC018E;
	Thu,  7 Aug 2025 04:10:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 04:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554204;
	 x=1754640604; bh=sHLUGTWa+rdPq+vmYg8AIqU2MCVoLpJvj+4p7hHseag=; b=
	X1LgLrEV17253PaXS1Mfl5g2MmxLOIheKXbJuC2vM4XSRLNyZsSnKVHpUD2BfmpD
	hI1+44ivgF7jkHwCf1afwIZIptfF/p9gWYR0ZWMC0yl5jQoPe3SsgX5Yjtp1eH3D
	5rOhoQBgCTQqZqBEC81CQNeIqxsRG7pTPjuwBkwsNTWci81TP1E5gPzSYnLqOvTD
	GGrvg3IPGu79HGqyRrnhFfZFy1y/ha8aNQAg2CPw660s/eKRlZr9ObeVbt/0yDl6
	W5k1iK0cjfrQzzbG5V08VI04KpnwtPcZ3CYIFwPHOx4K+boalnMdlw5TC21qsWZT
	9TfLjl4mmvzIC792JqD76Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554204; x=
	1754640604; bh=sHLUGTWa+rdPq+vmYg8AIqU2MCVoLpJvj+4p7hHseag=; b=l
	w6RSCak3noKvdY0dHR+wS08bY3ebiaS5esJMYkOTg0H8t7Gwep2v/MJ3dnlH+LGZ
	NXJYGoQbzOUmNoG+Z4ooR+UuNCjwT7OGansSMU7B4TuLnBqc4Fzk9EyEpLMnIc3D
	+4CqU0xX0C2viu82xRsoQRkXej18jruIwMrikscj0sQ5qHnu8LD3BJnE+xfD6Gze
	bUuWPvVMO6V/RBqcTZuSybzKXwNbo5gZPZQ48t815KNxGhcT0/xapB4IcrQgsgPS
	criXi4O4ilpSlCeM3V2DUzF6mqPemm0NI7dsZLwzhu0C7l5+utOzYyop5yC/Nqf7
	Lb8ZnlUew1LBSJw4Dw8KA==
X-ME-Sender: <xms:W1-UaG0aOrB4vP3d8dN7LvUWybVQCdmFZt6OhrNNp6kdIlaVO884Rw>
    <xme:W1-UaMU2dVNkqojN-NpFUbPQqwQXrBB6y1fuDn84Q27KdXQYVzvYaYGljTB136H-H
    iCoN_3Z2OkPRc9eWg>
X-ME-Received: <xmr:W1-UaIXTgxRq5LimxW8qN8SVJBMT_vCVSzN7z6ENZOiQj4eE9ffSIxvtqDztnkQK47KeDqfhdTTtzFi6S3lNy41d5m0VWipLGUmE-rZPmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W1-UaDcJKOvmNELazYVEAws8UgPW7WkdnYWpqxTCS5QM_TkjFqGAgw>
    <xmx:W1-UaJXXmFMVyWRJ8dMTKa6v73sL1ZdSlyUrjkBCoWAQBkN3PKQ4eA>
    <xmx:W1-UaEey8krg84bmf_dVjjUEh06eHe-qaDmQWBGZ05Lp6vxo_Vdi4g>
    <xmx:W1-UaNNyJEQG4mphqYDOGk-u5GbhNOBCD0L1V0hVCxvlftcmhd8Qhw>
    <xmx:XF-UaLLM3j-oo4JJqI_BX0XqiKolZdm2XAt0pT_NnY_CA5ho8GA5YH1_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea279d2c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/9] midx: stop duplicating info redundant with their
 sources
Date: Thu, 07 Aug 2025 10:09:50 +0200
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5flGgC/5WNQQ6CMBBFr0Jm7ZhaIKAr72FY0M5UJgolLRAM4
 e5WbuDy/fz//gaRg3CEW7ZB4EWi+CGBPmVgu3Z4MgolBq10qSp9RVPg+IrYC61ITPP4FttOjNH
 Pwab24Dw663KrauOozCGZxsBO1uPl0STuJE4+fI7T5fJL//MvF1RYFTUZzdTmprynyVl6aPZ9/
 wIK3KfN0wAAAA==
X-Change-ID: 20250729-b4-pks-midx-deduplicate-source-info-fcf3c08bfd53
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is a follow up to the recent patch series that started
to move the MIDX into its object source. It refactors the MIDX subsystem
so that we always read and write them via an ODB source. This ultimately
allows us to store a pointer to  the owning ODB source in the MIDX and
thus dedup some redundant information.

This series is built on top of e813a0200a7 (The fifteenth batch,
2025-07-28) with ps/object-store-midx at ec865d94d46 (midx: remove
now-unused linked list of multi-pack indices, 2025-07-15) merged into
it.

Changes in v2:
  - Fix a comment typo.
  - Introduce another commit that simplifies the calling convention for
    `link_alt_odb_entry()`.
  - Link to v1: https://lore.kernel.org/r/20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      odb: store locality in object database sources
      odb: allow `odb_find_source()` to fail
      odb: return newly created in-memory sources
      odb: simplify calling `link_alt_odb_entry()`
      midx: drop redundant `struct repository` parameter
      midx: load multi-pack indices via their source
      midx: write multi-pack indices via their source
      midx: stop duplicating info redundant with its owning source
      midx: compute paths via their source

 builtin/commit-graph.c      |   4 ++
 builtin/multi-pack-index.c  |  31 +++++++---
 builtin/pack-objects.c      |   2 +-
 builtin/repack.c            |   7 ++-
 midx-write.c                | 116 +++++++++++++++++--------------------
 midx.c                      | 135 +++++++++++++++++++++-----------------------
 midx.h                      |  42 ++++++--------
 odb.c                       |  43 ++++++--------
 odb.h                       |  16 ++++--
 pack-bitmap.c               |  15 +++--
 pack-revindex.c             |  14 ++---
 packfile.c                  |  13 ++---
 repository.c                |   1 +
 t/helper/test-read-midx.c   |  31 +++++-----
 t/t5319-multi-pack-index.sh |   8 +--
 15 files changed, 239 insertions(+), 239 deletions(-)

Range-diff versus v1:

 1:  38e145e1e8 !  1:  d61e0702df odb: store locality in object database sources
    @@ odb.h: struct odb_source {
      	struct multi_pack_index *midx;
      
     +	/*
    -+	 * Figure out whether this is the local alternate of the owning
    ++	 * Figure out whether this is the local source of the owning
     +	 * repository, which would typically be its ".git/objects" directory.
     +	 * This local object directory is usually where objects would be
     +	 * written to.
 2:  bdf2e55514 =  2:  5f0a422b17 odb: allow `odb_find_source()` to fail
 3:  6e11c5ecb5 =  3:  698f8793fd odb: return newly created in-memory sources
 -:  ---------- >  4:  6fd1530502 odb: simplify calling `link_alt_odb_entry()`
 4:  52b0e420d1 =  5:  90d9dbb3f7 midx: drop redundant `struct repository` parameter
 5:  b1c200817a =  6:  2c4d45d912 midx: load multi-pack indices via their source
 6:  9b064ce6b2 =  7:  d4d7ccab0e midx: write multi-pack indices via their source
 7:  0553fb6b8a =  8:  9a6ce9872c midx: stop duplicating info redundant with its owning source
 8:  13c480bac9 =  9:  b814e2f328 midx: compute paths via their source

---
base-commit: ee2fd3d4b224c8145eeff04101ea6075560973e1
change-id: 20250729-b4-pks-midx-deduplicate-source-info-fcf3c08bfd53

