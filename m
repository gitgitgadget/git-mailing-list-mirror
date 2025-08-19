Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0523F421
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591581; cv=none; b=S5uc1RPaWMIGRgN+lrAbhaJjQkYIB041nFqYrBAFwke3BVlc++Qu5waf/SAi5/9n+sedTovGqAyOmW7ji8EB1g6oqGdN7lQ+ebwAbgypHlwbqd7DbjFxm1VE/l5PIyrhGH3Rsn+fKrnFU98FwRXXPf+gF+N6u7QKG1LCErEed1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591581; c=relaxed/simple;
	bh=zwTuCDCYhzd8TxJWwfCR8fawDIQtK3HkB2FynNOa2lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fDtslBSrcJPZtpFWVofn/pJzXL3E+QDMjNYrzuDv/W3ddMqWUfSPYjwcjtrdCsH9zMm2I6YY33F8ZESXKJODuhpAITsLG8TtV1x+VWQEfWmAxRewbWpnfnTvJg2uIfYQ4klHFAUbmpxgbtjkrW7o/yH7hmxXESVAYaN/78Cpwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Me4vcJ4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEBh20QT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Me4vcJ4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEBh20QT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85E787A027C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 04:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591578;
	 x=1755677978; bh=gWnxy0hwxq1/lPAi5Xk8aL1fQGjolQULq8iNOOuhCdI=; b=
	Me4vcJ4D9FhtkdgV/HICgDUPt3Fo3qD26T7MVQXCDXDWsUCvZniC5LMI6QJgvysc
	gsE3qq7oN+Okgsu3huDVbCovSLRIuyVK+uoEKDIzlGBFgV2DT3Cto8V235dchjH/
	B5TLL9Jn42ts/eI+w7lYl7hSV0RXPw3BIcsKFJlxyjUrEcGxbnyHnWLXFYXqDAWg
	Q9gKeyFtJ4NViIB1K6Ay6BlOmPL5FsO88OQkFBUc071unGFz0mI7PuUYb+whPW1g
	/9IxWlLCKBN/gnffr32bRZmgFwcHKMPFGxQtbZhjOZFQ5LyksDfxq3NaxbDoJ6I0
	puA7wJzXEosRdeOGHClvJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591578; x=
	1755677978; bh=gWnxy0hwxq1/lPAi5Xk8aL1fQGjolQULq8iNOOuhCdI=; b=h
	EBh20QTavkOG1dL4xSl3rK0UQxoKtguQscdWidWJL4niayi6OejQwhg+vqzpTxcV
	yFeg2ow8FzIai+UEy46UF4qv0MSU/euPxlvNoyCUAKnQI40Pu/CMU5MF6qVlvoDX
	zdpbWtumTbNFhklTp3Sr7GGM/dKHy/QNwnBbG61GmfPKlOlBzd0lQ3hd0qDFtPkI
	XPGzprvg59a0rLGUe7rtW0s59jOiTuVyfRcQZ+vCUJ6N50wjMiAGYBBoU29UUVrO
	1K2YFFsqCqTTf/XZPLaA4E0zshyvmhIuPNF9Ukof+vOC9BcTJgjbtVzbp6jkGh0n
	mA2PXLdPJq+qdZyyAMe/g==
X-ME-Sender: <xms:mjOkaFNGKb7ZQK-so-fjdv2T02gNsqlrDbvuwr1qcsB5ftgS53azYw>
    <xme:mjOkaJ_uZ1dPBrBCv8_YBDFBwW1XOGUrWelBW8OHeFJFnqyA3mW3WawCMBJnbpgqU
    LVqnTfq8wN0dK2ZNQ>
X-ME-Received: <xmr:mjOkaNr0rNxkV0E56skHpzKsIIZKad5WFZIUVi__mpPloMpGvep3hLp70nfD7LTBvzUg0JKTAOTocijvifaDDxElTC3ZqD8cnZXG0wD_716e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:mjOkaD4Svb_n2ndr9JTsUaX-KAXVY8eNoM0ykw0QR1VmYvf8AJ9fEQ>
    <xmx:mjOkaFNlt9j62tzOri8v7MgeF-XJiWjP3Fgc50WmpdbCZQWOUmS-yg>
    <xmx:mjOkaNO_oXyRa_GJjRLOiOjm8dpmcPrGjFpi7C2fqv-GPCjg7wj2WQ>
    <xmx:mjOkaF_eTQyVpSlWGMBgLJj0QHASQzoNW9reZ4rHNicIUXUVYX1jJQ>
    <xmx:mjOkaK1CaX-LMfVPmgBHNrUxDL2W6Nf2dOL0bTIr1bKWtNBr5HHGefF0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5740e1f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:30 +0200
Subject: [PATCH 01/16] packfile: introduce a new `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-1-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
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
 odb.h      |  2 ++
 packfile.c | 13 +++++++++++++
 packfile.h | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+)

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
index 3dfc66d75a..026ba9386d 100644
--- a/odb.h
+++ b/odb.h
@@ -83,6 +83,7 @@ struct odb_source {
 };
 
 struct packed_git;
+struct packfile_store;
 struct cached_object_entry;
 
 /*
@@ -128,6 +129,7 @@ struct object_database {
 	 *
 	 * should only be accessed directly by packfile.c
 	 */
+	struct packfile_store *packfiles;
 
 	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
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

