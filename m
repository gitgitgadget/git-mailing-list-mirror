Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61FF274B32
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047745; cv=none; b=mAsg0F4D8sP/+3N79jLYi/TBt4rvdB7C4IWVXgpfuRysAsTpnKRTHK63/rEUOrjzwI6VcSsbyrRn2hBDjiJn7/hFtxmh0BoJCcTmFWieCDsPvhUEoXgckykj35yBBWAGkxN3tKq//V1yc+0Od06Mpip++NTIfjjhes01mrHpL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047745; c=relaxed/simple;
	bh=eeJTAmhwNOFWFQIpkZ8mNDeaIum7bankSk6Sdf3HfRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHN/6q2kplVlhML/dPALMCol4jDBiPIWIgwMBwFF9dXYjAn2+AH0/WlnALil6BNHmpcjRDycZymDN3Rd4JPhSqFwWGHpUa+GRPQ1Qh64/oqXRAmH5UdOUEcdHhE0d4tP1pPdNsXpi+0VnJRVFUNrCq+bunkRbdrgF5xU9D0p4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mnnmXR4e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkO+cTsy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mnnmXR4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkO+cTsy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E825C14000E4
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 03:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047742;
	 x=1752134142; bh=B+W1966kNGQ4iS43djiXqI7EsqcHZ26Eo7/yCHsevNs=; b=
	mnnmXR4eTVy2xvDG+e7OW3aoWKm9gBIov67YX71dU2EVirrLe6lQjYw+X2QPQ3Hi
	JwP1kwewI2d2Xm8OpEWzZuRyS58Lsg9kFj+sTsey/49btUSb1W8rL+1iFNqagiB+
	Vd7UQ1mKQgao+HzGj63K08DZOTBUrA42FkrmHGeYXqYAm9kUEqVwylLXbIiInE//
	nJOtwsIjl6hqOQsmRVke4p8Y1dvKQgzJbYiFo7nwgeRqt/5NkMBri2W6B0RBAAao
	jtHOMyKwcc1meYO9ymarJ9gdtpNK9thbtzmua9N08Ed6tHaD7vsyl57yTFQmyjmc
	JoPeJL0v+MrA7QSI0XRvhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047742; x=
	1752134142; bh=B+W1966kNGQ4iS43djiXqI7EsqcHZ26Eo7/yCHsevNs=; b=N
	kO+cTsyq7IzlQe5uTa8CL9Qf6PAZ8o8sRlKnFDcHqTJfsW9o0Mrp6Hu1CKBPCJBB
	f81ykQethM41EDY1XlYAXSlBS3/6JhQwSC9so9XhtAfkK3Z4g6V3aE7MqFXe98Y7
	2juVyma20VjWTa5RVh+4TDauWV/eJVLgJf8Juarvp795ipvm0XhBKFjhdEx6IIUX
	33efWt9buLRazwHcwiADnzOMJceSeeH/rfH7TIAlt4z/+/uTvSUYqLslVSe9AZKk
	G8JM+/QN7OMt1MJgFSRXtJ4w8FtzHk9Y9r8nd29FeD+1JiRNS0U4ryD7yVRSRUkx
	uRlQ2/X7Vvf+6t0wEmB8Q==
X-ME-Sender: <xms:fiBuaNSjrwb3Uy7zlX5NPwz4iUrGYLMCZ6dPHOjLpQEFProqQ4A41w>
    <xme:fiBuaIykiwFwvzkrKrLiNW2S9B6IvYpSs3Qk3kPmFxSEl1JEh4FFh2WIT_zNicl09
    4bgNJjUW6JX_O8aSQ>
X-ME-Received: <xmr:fiBuaMNY0J884GDiOW2Fz3GO9zeZPG5QGBUlccKv0BvPzE2Ezn9b7ZKy2MsHdm0yAndEqSKtUxSrUUFrAYthBDwfbNk5YZefy083y3YUzxLFMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:fiBuaHPyXcrdxNFoJDNVT92-fwZqk8ItRsVFDzsBUwbGxZh0urWiMQ>
    <xmx:fiBuaOR5go9hzLMNXB84hx9TzfS_P0yvnVMntnDgK0j7jfG8ZmvtNA>
    <xmx:fiBuaJDHP3lzDocci9CopA2uy__coDKvsCb07t9CjYgUDRSxWadE-A>
    <xmx:fiBuaNj3xp4JtnFXIpoKT5t1DkIyPHxQsLKOvDWa9IqQ1pQCXsdYpw>
    <xmx:fiBuaCKaBuyl9soXY2f-FW-9fZIvP1ugJlPMIQIKxVVFotx_ihu9QpzO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc72b035 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:56 +0200
Subject: [PATCH 8/8] midx: remove now-unused linked list of multi-pack
 indices
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-8-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In the preceding commits we have migrated all users of the linked list
of multi-pack indices to instead use those stored in the object database
sources. Remove those now-unused pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 16 ++--------------
 midx.h     |  2 --
 odb.h      |  7 -------
 packfile.c |  1 -
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/midx.c b/midx.c
index 6d3a166fa01..27623e8cbb7 100644
--- a/midx.c
+++ b/midx.c
@@ -726,7 +726,6 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 int prepare_multi_pack_index_one(struct odb_source *source, int local)
 {
 	struct repository *r = source->odb->repo;
-	struct multi_pack_index *m;
 
 	if (source->multi_pack_index_loaded)
 		return !!source->multi_pack_index;
@@ -735,19 +734,9 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	m = load_multi_pack_index(r, source->path, local);
-	if (m) {
-		struct multi_pack_index *mp = r->objects->multi_pack_index;
-		if (mp) {
-			m->next = mp->next;
-			mp->next = m;
-		} else {
-			r->objects->multi_pack_index = m;
-		}
-		source->multi_pack_index = m;
-	}
-
+	source->multi_pack_index = load_multi_pack_index(r, source->path, local);
 	source->multi_pack_index_loaded = 1;
+
 	return !!source->multi_pack_index;
 }
 
@@ -840,7 +829,6 @@ void clear_midx_file(struct repository *r)
 			source->multi_pack_index = NULL;
 			source->multi_pack_index_loaded = 0;
 		}
-		r->objects->multi_pack_index = NULL;
 	}
 
 	if (remove_path(midx.buf))
diff --git a/midx.h b/midx.h
index b1626a9a7c4..c4192c92d44 100644
--- a/midx.h
+++ b/midx.h
@@ -35,8 +35,6 @@ struct repository;
 	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
 
 struct multi_pack_index {
-	struct multi_pack_index *next;
-
 	const unsigned char *data;
 	size_t data_len;
 
diff --git a/odb.h b/odb.h
index b39534dd55b..8ff523a33de 100644
--- a/odb.h
+++ b/odb.h
@@ -124,13 +124,6 @@ struct object_database {
 	struct commit_graph *commit_graph;
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
 
-	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c and midx.c
-	 */
-	struct multi_pack_index *multi_pack_index;
-
 	/*
 	 * private data
 	 *
diff --git a/packfile.c b/packfile.c
index 3eeec20906b..453a38395bb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -375,7 +375,6 @@ void close_object_store(struct object_database *o)
 		source->multi_pack_index = NULL;
 		source->multi_pack_index_loaded = 0;
 	}
-	o->multi_pack_index = NULL;
 
 	close_commit_graph(o);
 }

-- 
2.50.1.327.g047016eb4a.dirty

