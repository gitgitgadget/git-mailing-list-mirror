Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5482D9494
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840878; cv=none; b=U9HRa4iT5uSAGmkCUblRD4N+8Y4oWd1F3sarBt1jRyvzpE7Nlhb9VePjtTmnVkAtR0ane2kqXjbmEi79k7LS7FllP7wPMsIk/TChDAdVnYnEEnOWEsRjDTeXu2+Bw2jhclEIiKdrY3Kwvdv6K+LD99db+JxelFAcaf9mLFGPz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840878; c=relaxed/simple;
	bh=L+Kpt82mgQ/ot3Ry0ArzLMpALGkiU0yMN8idatUXQbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LP5O2l+Yw++W1Zitesy8V7Tw7ujM7at7yhyh3YzMvN2uOS+Rj6PmYuc61hBvIYgLCJRTilvba8tT94wTmD7E80Xln0HJISxqdXiOw9j3grZmt+DTNErXhc9DmwXTkwErIF5mLwFKVCVp8iwtnX8uh1SPIDjBhAgt9EBSTGq5VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M4hnEfLk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v/g+Dn1d; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M4hnEfLk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v/g+Dn1d"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C2AA5EC003D;
	Tue,  7 Oct 2025 08:41:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 08:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840875;
	 x=1759927275; bh=WNvDNEsi76a9IqicjGzzBvJffKjHHdmPggHJ7sM/RlI=; b=
	M4hnEfLkVCkFTdKnVhhKmObBOaIAoCtIs1GhokxFRPkVlv05pm/UaKqwagt+FhQy
	Fg+cCBmQeY2C8eB7s2L/VaASCEE56JySCC5Gn/+eX/Gf+LFutiNnLoug6BDX9gM5
	A9ZN8Rq/YdpEOowTlDjFdYCRrhw+bD3R/nIWk1fmbSfzqR3zdgVFFHCzQeWK55kL
	Y/WiomFt7iXX/8NFNxoR5VXEWn3ZafZ1KIeY6c98ozuLRq4LgSnqRQmfW5uUPU1Y
	qDkhKcI5auzTJNc5iWTlKEnrO22OsjIA66ibBtZJLPbJFusW7JFJ4DK1qrjvtZaG
	pIRp/DvoELQ0bQmpAGgltQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840875; x=
	1759927275; bh=WNvDNEsi76a9IqicjGzzBvJffKjHHdmPggHJ7sM/RlI=; b=v
	/g+Dn1daQgBfm3Sh9i3DPefLnvP55+SEp5a/2gbeN6o20TW8YLhHfL8+ZTHzLv83
	qnzFiLgGyB4VeDwuqA8KT8UhHvhtjfoK5ypkMq/bLTUjxB9fNxGxxMFLc6u4apcz
	/oJZX7VFPrrtjyTT0Fd5dIP7jKx7HkQewJyBQd0EUR/NGdca43+IS+QCTTmRyO8G
	VKdAL/BWbF+qCzuf6qg4jGox5jalGiYZwncurdVGJaZwgv34DerB3oWNl0eVAjIG
	1isHurq9En6r9pSLjaWHWOXMBdrdRUc1gJjXVUyHl6oYOiLqKKGuw3kO0+Y4P2B/
	NtDHcNRB7U5kvLF4ezUUg==
X-ME-Sender: <xms:awrlaNuYfXT3vmHy_FccEExp9NmrUrNCoNeRzSi9iWO6wjKEU4GKwg>
    <xme:awrlaMd2Rh1-0rbOXtOn-T9oEwBiwwTVGc-BIvWr5rkmO3t0PO-k047ons7q5JXvq
    dt51iKJzUwPZyyvTT07yGooPZvCa1bvsOENB4UDDJxGRSdQ72bY>
X-ME-Received: <xmr:awrlaOZSdAukAPaVEW_nNnpEbx_17wuSrrR-1DKOtK9VgXiHxanLgcjb5W-9dn6K4Bn9-U7Z4qcOXOxI1yVEk0qCa2AQNuv3qUjZYoPmWew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:awrlaPU45GoXa-0CtNJhtOBhzPkqOSbVG-Z4YLiyyy7806WDNCYJeQ>
    <xmx:awrlaAjc-m_1h36qHomijQf0LplYixAO83FQczIwwf0_1VpbKz-8dA>
    <xmx:awrlaNXKdnRrzVY5YIJVt0mJJrdIZKIaZzEfz3qcRgEwen-pl8A1Gg>
    <xmx:awrlaHNtwN4aAlJuMWjRGMJkieIGgGDXD--I6skMiyDccaFzapvmZA>
    <xmx:awrlaF0r_r8jbcfVmwyhJToISlN1SY2gw-76K-zFNoyUEhWnc_EVZmUZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:41:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b32fb45d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:41:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:41:07 +0200
Subject: [PATCH 1/6] object-name: convert to use
 `packfile_store_get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-pks-packfiles-convert-get-all-v1-1-428227657a89@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When searching for abbreviated or when trying to disambiguate object IDs
we do this in two steps:

  1. We search through the multi-pack index.

  2. We search through all packfiles not part of any multi-pack index.

The second step uses `packfile_store_get_packs()`, which knows to skip
loading any packfiles that are indexed by an MIDX; this is exactly what
we want.

But that function is somewhat problematic, as its behaviour is stateful
and is influenced by `packfile_store_get_all_packs()`. This function
basically does the same as `packfile_store_get_packs()`, but in addition
it also loads all packfiles indexed by an MIDX. The problem here is that
both of these functions act on the same linked list of packfiles, and
thus depending on whether or not `get_all_packs()` was called the result
returned by `get_packs()` will be different. Consequently, all callers
of `get_packs()` need to be prepared to see MIDX'd packs even though
these should in theory be excluded.

This interface is confusing and thus potentially dangerous, which is why
we're converting all callers of `get_packs()` to use `get_all_packs()`
instead.

Do so for the above functions in "object-name.c". As explained, we
already know to skip any MIDX'd packs in both `find_abbrev_len_packed()`
and `find_short_packed_object()`, so it's fine to start loading MIDX'd
packfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index f6902e140d..4e62bfa330 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
+	for (p = packfile_store_get_all_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -805,7 +805,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
+	for (p = packfile_store_get_all_packs(mad->repo->objects->packfiles); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 

-- 
2.51.0.764.g787ff6f08a.dirty

