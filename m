Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F417A309
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371150; cv=none; b=Chh+JKsdhAdtWCdkNi24TMaz1OGWk/vVxNzz5a0qeArRkqiQqUdoPwPnXOPfKelKaJlMhOOGoqSr/32iXvKo58MOFw6PZWLgMmXspN+WUx14LONfP60keCpChqmG8i+aC2XhuerwrHK3xRC0e+k46BJsi3R0s+N2s/yQ5rdHyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371150; c=relaxed/simple;
	bh=QMC4SRxUTpq/Gl7atM7jtMX7+noc+daBKj/csqN9OMU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=eNabGCIXmYW158VA7esw7PDlzmH/ZetI9szz2gxtfT9E3dMBM1qOlGkICabpCuex6J75dc8ro3GRyBq6v9lTtIvzFS+zFZxwuKLJGEvMql5O4YFOX/sIlZAzi2VzvTXfVZBulgl0AlqUm6OxxnP8ulDN3k3lv8AXoG7ItZXoOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PBhLt8Jy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qn8ZcF8b; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PBhLt8Jy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qn8ZcF8b"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A48C140003B;
	Wed, 10 Dec 2025 07:52:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Dec 2025 07:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765371146;
	 x=1765457546; bh=dYHMILsai18/m97iJ4lKVMsn1BZZ5r6W/il1ZKjbT30=; b=
	PBhLt8Jy9g81Z72dT3YO+uKGzbgpU1k6P68nAtNn04Rq+vYBKD64cmYKeWAKqO9B
	2dedFqxOxYJqv2CacL/JpHL7TL526K8vzNWr+ebobaWdplkLapxty+OJo1Sl0fWl
	VrVUu5yWrGHNLeUbkA0jbsfFtN2KJbekR4KT+IW36aXY4E48oQnfGwfSVNveaL4V
	DFDVhJpk1rQljPZpryKCWNPpYN3KHy85YvdVvZURg1615YaWWNoGUpIHRpxp7mOt
	8HHAagu2WX9yGhy+iS0tSb/6ntinhWWexhl6Tu06omIxYFCGCjRPyJxtUSXxKaJR
	tq18+t11sn78MR0VL4/R6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765371146; x=
	1765457546; bh=dYHMILsai18/m97iJ4lKVMsn1BZZ5r6W/il1ZKjbT30=; b=Q
	n8ZcF8b844v21W9ptH8EMpWb3mdAAkHePVevy3w1ckf5sI/ERHLHg485d2kZOmhO
	fCEyHxVeeBrpBMN73WkHUedFZR7PI0L1kZB9eAiI8mxLpqG/Na2z/cnIqqpun0aH
	PxCJYEtb1yRVoBeq3RIhi0EEkUjVFepBjMVWa4zqdzavZ27zgHkMnXKkO4XXjaUv
	fSTdu4kHZ6oh8z5W6XG0XZBbAjVApsjoC5XwxOYU/K0F1y5zu7jRcSQSyi4q9kJt
	a2GS9TmXFfCRgokrYAceKJVVJ/uRu9RDattAaVZFPXfrQIKFCl//xL8UoCOWQHKh
	2s9MRVkgeNvIyYaDc4FZA==
X-ME-Sender: <xms:CW05aVXBR0F9TL_gnBNFKVmuVNL1bYUKjOotfrv8uNG684gH6XfX_Q>
    <xme:CW05adCmbeVXubvF2uJ3-jDjDl7Ck7FjP32Wd00TZ3-XVSSJ-nnE_isPfOrUoJ6p-
    exc6zxBQvDJZr1LMpjGrneyuprWgeeBxmqbljZx9yjcGXJNTbyR2Q>
X-ME-Received: <xmr:CW05aezuzI_QJy7JM7E0osppMH2_Di2ujfVjE5pZb6P0sx_PvjjM12rHF2z1ycoBj7qHAndhFp0tx47ZyjQpn2JtROfAAdZYiqr3fdFC9aMi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhe
    dtheefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:CW05aSBGRCv0NRcBE5gefXmRo69aRwfSbo6u57ghId4s6dy0qpG_-A>
    <xmx:CW05aTYX9JJnwZzotBsewaASAbJqMl3ZDUSUUrBkKmhTIlOsgeinSQ>
    <xmx:CW05aSjnISNLcocy15ZrSI9UV-g1-a7JzPyLKEDsh2hp3EJFLwnwSQ>
    <xmx:CW05ad5l0KFRmfivAmLBIT1xytM6JmFi6pxFUpBMRdgbJ7kSRyVf1A>
    <xmx:Cm05aWDJxFCGvHp2QjgHTzBlf23rZ3VKozd7v0VzWtNDzDIDPOu38JHJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 07:52:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f82238e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 12:52:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] builtin/repack: avoid rewriting up-to-date MIDX
Date: Wed, 10 Dec 2025 13:52:17 +0100
Message-Id: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFtOWkC/4WNQQ6CMBBFr0Jm7Zi2SABX3MOwwHaQCZE2U4Ia0
 rtbuYDL9/P/+ztEEqYI12IHoY0j+yWDORVgp2F5ELLLDEaZShvVYJgjxpkDLt4HFHoJr4Rl4+p
 RaVu3toK8DUIjvw/vrc88cVy9fI6bTf/Sf8ZNo8JLqVxl3H1oR9Xl3pmf0KeUvjmbfhW3AAAA
X-Change-ID: 20251208-pks-skip-noop-rewrite-38d7f01c79c5
In-Reply-To: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces logic to avoid rewriting the
multi-pack index in case it's up-to-date already. This is especially
relevant in the context of geometric repacking, where we may decide to
not write any new packfiles, but we'd still rewrite the multi-pack
index.

This is a follow-up for the discussion that happened at [1].

Changes in v2:
  - Move the logic to skip writing updates into `write_midx_internal()`.
    We already had some logic there to skip no-op rewrites, so we only
    extend that logic now to handle the "--stdin-packs" option. This
    also has the added benefit that we know to strip bitmaps in case the
    write is a no-op.
  - I don't handle the case anymore where the preferred pack is
    changing. We didn't do so in the preexisting checks either, so I
    decided to drop this for now. This _can_ be considered as a bug, and
    if anyone thinks it is then I'll extend these checks.
  - Adapt the tests to use git-multi-pack-index(1) directly.
  - Link to v1: https://lore.kernel.org/r/20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im

Thanks!

Patrick

[1]: <20251025191550.GA279793@coredump.intra.peff.net>

---
Patrick Steinhardt (3):
      midx: fix `BUG()` when getting preferred pack without a reverse index
      midx-write: extract function to test whether MIDX needs updating
      midx-write: skip rewriting MIDX with `--stdin-packs` unless needed

 midx-write.c                | 113 ++++++++++++++++++++++++++++++++++++--------
 midx.c                      |   2 +-
 pack-revindex.h             |   3 +-
 t/t5319-multi-pack-index.sh |  64 +++++++++++++++++++++++++
 t/t7703-repack-geometric.sh |  35 ++++++++++++++
 5 files changed, 195 insertions(+), 22 deletions(-)

Range-diff versus v1:

1:  11258a799b ! 1:  88ba93d3a5 midx: fix `BUG()` when getting preferred pack without a reverse index
    @@ Commit message
         The function `midx_preferred_pack()` returns the preferred pack for a
         given multi-pack index. To compute the preferred pack we:
     
    -      1. Look up the position of the first object indexed by the multi-pack
    -         index.
    +      1. Take the first position indexed by the MIDX in pseudo-pack order.
     
    -      2. Convert this position from pseudo-pack order into MIDX order.
    +      2. Convert this pseudo-pack position into the MIDX position.
     
    -      3. We then look up pack that corresponds to this MIDX index.
    +      3. We then look up the pack that corresponds to this MIDX position.
     
         This reliably returns the preferred pack given that all of its contained
         objects will be up front in pseudo-pack order.
2:  baf307b521 < -:  ---------- builtin/repack: don't regenerate MIDX unless needed
-:  ---------- > 2:  9bd320b2cf midx-write: extract function to test whether MIDX needs updating
-:  ---------- > 3:  f594865c12 midx-write: skip rewriting MIDX with `--stdin-packs` unless needed

---
base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
change-id: 20251208-pks-skip-noop-rewrite-38d7f01c79c5

