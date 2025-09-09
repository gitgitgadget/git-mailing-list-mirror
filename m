Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA4258EEB
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415792; cv=none; b=lV8UY4xmMxZ1ZlluFxVh1HaQitQGvhRMCY28bT/cxfQtztA6rr7klX1VlICS1zG8rziLo/v5thxBzO/RUMH4bLJxuucmvuedvJlV5CB6V0TgkK0GxtfPTkEXdI8PF+Y4LuaEAnJXrH2Yw13roAK+t0Cad7Msc9tOq6B/livM9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415792; c=relaxed/simple;
	bh=22+QitVvjbsG2WswWN2D9BK0xFIrfy9CUJyMzrdYi3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sk9VAahSbta5SpPMwgY9pv48SClLr/+8Fh7wkxoaqZ9vop0caO5xGpcHiX29kZ0VPl62J2Xlg5z7ieUswkgd1QvKQ9HlnObgKvoZgS96yaWPiaBHm6adstkQvoM/yZA3O0vPP23RVRJfrRuCE1U/wq1TjW10NlsOlvqaN9vM25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g1mIQCdE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LkaMwlHZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g1mIQCdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LkaMwlHZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87B7D140015A;
	Tue,  9 Sep 2025 07:03:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 07:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415789;
	 x=1757502189; bh=rZwWpjNn24tX/vftTjsusORKk/T5Kj7R97fkLLYZT68=; b=
	g1mIQCdEKozZC8JUMtYNjfMADhDs3J4EbvLc3ChIOpignTRThbQ/TiVES3ab9VFB
	oNt+1ZixOM8SrIkcfrkChH2nDFjpv2gu0LnYxyehbq0K9Jv4ad/f6UUIgQlVXI5L
	y5hDnBbVnqCvXIpDNr8l4DnYcl0HeJq4wH/hiV8zOH7PliVxTjfGcOxlAfT3bWrE
	mTIscxipneSTY/rAPe6dKu0p4crqKmsqMtxEaGEXs26KeaE1xXZdfYXQ5eIMtQc5
	odUCZwqKBDAYrWLmBZi75eQNiLmaUfMLHneoxQLVsH9YD4k7THEUnTojO5hh/OAR
	TBQLi5yIzGJXxFGPmLej7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415789; x=
	1757502189; bh=rZwWpjNn24tX/vftTjsusORKk/T5Kj7R97fkLLYZT68=; b=L
	kaMwlHZ5VkNvvhHW1efWjnVyTNjCuORysxPdX643Z2rmPP+HTz/RIfwvWhz9ffnq
	eK5BDm3uSmdnyceCaZcXUHH/464RRKAgc1YQhLp+TD4c4C2nh7ozjHqHLub0ZZK3
	pszAnQ4wXg0zuPG9IShcNbBU4YXK48zBlHXwg/iYQmzjHWF68MFvzSZBCluzcQhi
	gkUgS5MP2DikpQm+Zoa+xI5SvrWWGj6BmocEExeyt1dOKt/qITBQE2jnZzJA5JVT
	e9TvMsQIKnjwIvnYUW4c7kQr21vIB6A2rt7MOUAQEbPEGEbO06CMQkLwozouN64p
	z+yrtd+v0OkI/64nNowaQ==
X-ME-Sender: <xms:bQnAaFXuRsYQtaP8_bhM2NBEhRWdP_9UGXULi1IitPUggQc2aNmpzQ>
    <xme:bQnAaBFrwjV1INXBK9M9Zn57MdsGvN49_rET3lV8lcQq8B5eVc1Ox_OjoUDALeXNt
    6Ho36luv1ljdmi2Ng>
X-ME-Received: <xmr:bQnAaH0GRof4Bp_6-3xSQStBggAk6hkXNL0PG4wJ519XdAgL_Ofzj0JpV00JcEnuJ4Qvi_FLhhKGChahq6hDyAkSxvy74FdG83a3dtWwTCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:bQnAaDPO9hjsEKJcFvaxoh0kJbFjqe_l6_PFMxYzqJv6UAnpvjiyTw>
    <xmx:bQnAaG73V7MwtkCTzViE91UzfYf3qD8Tj8UOcb1olkHKwLmfiFhDzA>
    <xmx:bQnAaN11YjhOD0WXg87n82q3_ES6maoGx2B4MpsnosohhIhyMv2_AA>
    <xmx:bQnAaHz-_bwm15TiTnYhf5XJfk44EQspagDx4KuA9jSM3rn4r-vgHA>
    <xmx:bQnAaGZmIdJWH8666OOHXHke0-Hk0ebtn0gXiaTRXPQnrAwqXwSLsilH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb5f859c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:00 +0200
Subject: [PATCH v4 01/15] packfile: introduce a new `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-1-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Information about a object database's packfiles is currently distributed
across two different structures:

  - `struct packed_git` contains the `next` pointer as well as the
    `mru_head`, both of which serve to store the list of packfiles.

  - `struct object_database` contains several fields that relate to the
    packfiles.

So we don't really have a central data structure that tracks our
packfiles, and consequently responsibilities aren't always clear cut.
A consequence for the upcoming pluggable object databases is that this
makes it very hard to move management of packfiles from the object
database level down into the object database source.

Introduce a new `struct packfile_store` which is about to become the
single source of truth for managing packfiles. Right now this data
structure doesn't yet contain anything, but in subsequent patches we
will move all data structures that relate to packfiles and that are
currently contained in `struct object_database` into this new home.

Note that this is only a first step: most importantly, we won't (yet)
move the `struct packed_git::next` pointer around. This will happen in a
subsequent patch series though so that `struct packed_git` will really
only host information about the specific packfile it represents.

Further note that the new structure still sits at the wrong level at the
end of this patch series: as mentioned, it should eventually sit at the
level of the object database source, not at the object database level.
But introducing the packfile store now already makes it way easier to
eventually push down the now-selfcontained data structure by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      |  1 +
 odb.h      |  3 ++-
 packfile.c | 13 +++++++++++++
 packfile.h | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index 75c443fe66..a2289ea97d 100644
--- a/odb.c
+++ b/odb.c
@@ -996,6 +996,7 @@ struct object_database *odb_new(struct repository *repo)
 
 	memset(o, 0, sizeof(*o));
 	o->repo = repo;
+	o->packfiles = packfile_store_new(o);
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
diff --git a/odb.h b/odb.h
index 51fe8a5a92..33034eaf2f 100644
--- a/odb.h
+++ b/odb.h
@@ -91,6 +91,7 @@ struct odb_source {
 };
 
 struct packed_git;
+struct packfile_store;
 struct cached_object_entry;
 
 /*
@@ -136,7 +137,7 @@ struct object_database {
 	 *
 	 * should only be accessed directly by packfile.c
 	 */
-
+	struct packfile_store *packfiles;
 	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
diff --git a/packfile.c b/packfile.c
index acb680966d..130d3e2507 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2332,3 +2332,16 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	*len = hdr - out;
 	return 0;
 }
+
+struct packfile_store *packfile_store_new(struct object_database *odb)
+{
+	struct packfile_store *store;
+	CALLOC_ARRAY(store, 1);
+	store->odb = odb;
+	return store;
+}
+
+void packfile_store_free(struct packfile_store *store)
+{
+	free(store);
+}
diff --git a/packfile.h b/packfile.h
index f16753f2a9..8d31fd619a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -52,6 +52,24 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+/*
+ * A store that manages packfiles for a given object database.
+ */
+struct packfile_store {
+	struct object_database *odb;
+};
+
+/*
+ * Allocate and initialize a new empty packfile store for the given object
+ * database.
+ */
+struct packfile_store *packfile_store_new(struct object_database *odb);
+
+/*
+ * Free the packfile store and all its associated state.
+ */
+void packfile_store_free(struct packfile_store *store);
+
 static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
 				     const struct hashmap_entry *entry,
 				     const struct hashmap_entry *entry2,

-- 
2.51.0.450.g87641ccf93.dirty

