Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728D2EFD80
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926475; cv=none; b=ZSMhlUEereISmMYEY6xBqyZ2jK9QzBRJdj9TF7BDp1/T1ygeu5qee8qun/2/Ab31ImdA2jOmyg0kc5vLQLEH1jUQke4z5IE/IOX6/o0mPU1IfKIovLj8Y+sbhAM/pjdo6DAh4TQ+gz+F8eXuc/Lqe061qlmSdxFqqpZg8Kbv6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926475; c=relaxed/simple;
	bh=22+QitVvjbsG2WswWN2D9BK0xFIrfy9CUJyMzrdYi3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FsOHKitPIqLWUIx/M0tFoKcwgyvwbk5vBb0P8iFiFXUYkP/S8qlmlL2qYtbhXLqvVhPBk9pQZcgHBQuUngRvSalIT0ooizGmfsZf1sbQpMlkiV0R2PA2+3QxpQ6RxhiQu/xkD3Jftv7EXKNIL2MSGasBavuzzq23c5axR/t27Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f5JmO20f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nmk3ME7j; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f5JmO20f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nmk3ME7j"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 116731400199;
	Mon, 15 Sep 2025 04:54:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 15 Sep 2025 04:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926472;
	 x=1758012872; bh=rZwWpjNn24tX/vftTjsusORKk/T5Kj7R97fkLLYZT68=; b=
	f5JmO20f8l0KWWgvNgS7uVI58EsGE67FMf6rs9nTsoCRZE1w70uiWJyrRwDZoABX
	iY06u6GsuW06DKl9BFitrghC/RXc6eqprj/qLGfvDrlUJVjQB6cbItB1rxavatsW
	CiZez+H+JfSfVRMjComI4DZTGQ2Kro6N+JHAjP6fXPzEsbklqZ3VsxvLvU/yITHr
	zdF5ixE85WRNAtBaacCmYWQliKgA2GuYbdp/0M4l/fYSGsB81dQp0xFyb1CmljPA
	k6OvX/nM0shbHIgGE2gtR07fAh2f8IrCvtTGrKJKqKkIcWb7dufW5qDk+pL6MrNT
	fE8/07a+vDd+2VLGnkuUpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926472; x=
	1758012872; bh=rZwWpjNn24tX/vftTjsusORKk/T5Kj7R97fkLLYZT68=; b=N
	mk3ME7jPv1y91FSQhcNvMiwy448TtnDaiLTARNUGdo9eysFKD9GLkhMA25OiN3R2
	lTOFrWB5aBNgXYfiGlTkIRAQ4bPoFIns3RLXmgRfH2H09YIWMiokn2AV8NHFzv12
	Wbe81S97CKLXTDnyyD+0qCEb8k2N6SH1dwdSh1XTd+0TtolZLEYIGpi8tEJRo9Sd
	VRHJEoajhwH7oUaZ6G7jXgX+ILOmUK8UGddQOpnTtyJbTlvvYJkWUuvOur16xUSj
	IadM+WDLBcqYgGEYwFHdngD2hU2E88YG5mLgQuANVQgynH/GcYfY3FIjZSdRlhor
	orA6j79rkxeCSqu+i4mbA==
X-ME-Sender: <xms:R9THaJhlMVDLjIOmKFftn8cOozqrRMWWfTqsmpOhpHr93_s07nrUcw>
    <xme:R9THaJhkgaHayxtORahFWLn7njTk_8qDjFKtS0-H1lDgW_kiWnlylbm_lWICjqWd8
    3rm34WDk1uON7P2ZA>
X-ME-Received: <xmr:R9THaPiOORbeU06NC9ZR84_Z4JyrrPJQlZjjCUSdNyEltbwvxXDBCNoh_6KVMEjc5ag2Z0ctjcNb4BNWPlcfMTrH32T9VXKqbONWcZnOFCD6JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R9THaJJsqj7AzyKfmRPPFgl6IHCfGjvjciBrm6haamBxy6_tSJufRw>
    <xmx:R9THaOG_r4KG76Gcwu4GwiUC8AZhUYE_tv-YhlAB37n_qRHNeYsdfw>
    <xmx:R9THaNQg3uK55iml7RJQRNLI9avZh_u6WbBvIgc7gOGaLAMd4aEfhg>
    <xmx:R9THaKez8zwnA-eQPtf7YpobSR_2kc1ER7BDbuU_SKWAGkkgFTz5Wg>
    <xmx:SNTHaMXykbrtPvHN8F0IJA_m2L3XS4K0MgwrkWuXGv8Eno5djjeTDmyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c1699ff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:19 +0200
Subject: [PATCH v5 01/15] packfile: introduce a new `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-1-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
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

