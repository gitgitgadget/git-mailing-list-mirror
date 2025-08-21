Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33A2820A4
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761954; cv=none; b=cc8/U7BRMAQEZM6uSoh+FXOGPPkLgJhqpmlXcJq7lKx24CdDwzsDjKq6U0NSz7z4rJzLzzxvEKVk7tdaFhGfySLeqai59uRpwo5FEwc6jtLuB813Or8fguXW0TiECCF9Dp2E6JKcFNKvudOmnCIkdLgDvTooYrYdLHJ/v6qjJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761954; c=relaxed/simple;
	bh=KEy+QdewH+jvlmXwMwBh7Bug+xub34UUO9tBLFPLqb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rM51vNrXOYuw6EQIt/GefRAvbSisvlVsagDZg6auDI1aYFd+hVGkRG0c9PL5zKQOED9Fv3pJgHiyPIJDh4MCMJjZyGW49H9smSbDguMTisFpNZro5PW0TfOVR9XcQizzP4+OAHMa8zhNnPwaXrHcTOqxUI4TMcfFFVICFt3zpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iJ0LbMoB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MRJ7rJWw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iJ0LbMoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MRJ7rJWw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14AC414000B7;
	Thu, 21 Aug 2025 03:39:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 03:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761951;
	 x=1755848351; bh=OzWjF3T2fzeFRomTw8Ox/64qbyv2FBQnOYPkkpjf4gA=; b=
	iJ0LbMoBLMWjvW2tVZ6FhMZwHFsMEgL8xcGaODAlb4zN1QhBx6yJJYT1Hjk35TKY
	KkabFHEbPaNSS+XuUi07iBX+U4VChD9d7MfbzpNPKlYAxD3GBFR4jSZ8XxhGkxii
	MEy17ByF/iGKju79oKmu8abko0lQKpjiKgjbyjLNMry1K8L7ZnBEl6DTK3yn+O0E
	vCFrqUVIX3rOTijpwIzDpTGPlD7a7Np3+gOi2J2Ul2Kh5C2+ZbRrw1Np0W8D1M7e
	xHKv6/xSaGVfgsLLFMIqwZeplaj7WD6UoV5PXEbufD0+7iIXXnxwJyxoMt93s77o
	X6EDxsQISU0gXOi0b4VMmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761951; x=
	1755848351; bh=OzWjF3T2fzeFRomTw8Ox/64qbyv2FBQnOYPkkpjf4gA=; b=M
	RJ7rJWw/pZt2rv0kM54KCPyWOL8QtAyyzHWUC62PzE4cgu4fRQAqosIJ/m/g6XeG
	hp3b3yHhoFHRmuBLUkMnLm1vzroF1IVyNHtK5FDEgdje4sAtIX5BiN96wmtChRhu
	+iT0vcSiOWN4FYIPSo733FP1gBA0ILtcIi/fx6lYbYH98EFRKVkDdpAN7rf6KGN6
	fGobE7vGzt208N4Tk+9m5Cn8AXT1/znaxBwWYEjKr0C9cGP6q4wMdMmG3m/i9CSt
	bUWqmhp8SA4hL4tRn1ZH+aCFWzSZgCoU7x8HSG+d5n0hEU8EvXuvyCn4PurO+t3Z
	5nMAfKp2c39hPPqAn3Z/A==
X-ME-Sender: <xms:Hs2maIK6dOq9YfRfE8u3I2VkDy-5tSHausF_C_MkhnC6vJsrTW3OyA>
    <xme:Hs2maLY9mpPgJYe5b4fWZ-ayCRoWAAygne5a-XsGxIa0pKT09NSbftDpLCZT1DxYC
    YRzngyf7A_sfCzRig>
X-ME-Received: <xmr:Hs2maCJOsAwTNUDLccAJqvoFNbbfxf7Uic7s1MHHPRc52-j6T-KB4RzHjlTdmAzESAO40el3E8Y7Yv6hnUNCkuFphV9v2QoXdLizSBjqkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Hs2maBBM_brBL4yNbLhKYUDffy3htZ3xoqFPiO1QaeVevs7fLduDzQ>
    <xmx:Hs2maPpDgTnWrMcfefUaBnIjRKEy2RcQW04HjQS-sNVSHGqoaN0utg>
    <xmx:Hs2maEiXZ4MQ8LdTTtqQ-Pev7TnsyoN8okE-N0r_Hq4JQIXMpd1xSg>
    <xmx:Hs2maEDalE7eOGHcKdWbu9VdMRZ67lOPRKhJdvKCZx7914QPjBVEaw>
    <xmx:H82maNCHEOvBJ9K0OsQECMBnLoK-H0wIB2oi-92L66w80myHOemroNiZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd788f73 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:38:59 +0200
Subject: [PATCH v2 01/16] packfile: introduce a new `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-1-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
index 2a92a018c4..34b70d0074 100644
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
index 3dfc66d75a..08c3a01f3b 100644
--- a/odb.h
+++ b/odb.h
@@ -83,6 +83,7 @@ struct odb_source {
 };
 
 struct packed_git;
+struct packfile_store;
 struct cached_object_entry;
 
 /*
@@ -128,7 +129,7 @@ struct object_database {
 	 *
 	 * should only be accessed directly by packfile.c
 	 */
-
+	struct packfile_store *packfiles;
 	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
diff --git a/packfile.c b/packfile.c
index 5d73932f50..8fbf1cfc2d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2333,3 +2333,16 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
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
2.51.0.261.g7ce5a0a67e.dirty

