Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B42BFC7B
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155741; cv=none; b=FI+ctkovlx+UkSm/vCTzWZb3m1iX5VjvdgOTS9anlofjyIVEUCLjYuP/saDkc4tyk4DE5fxkI3DBOweszKKKzVD7q4Z+1cD8ae5L/nEV/9waoilr1gUiSTIiL8wZJZOgE/xpuW1l7u7ScX41rOhwYuUAUzMTuma0Dn+idemvRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155741; c=relaxed/simple;
	bh=XI7lKVHKtumTnxm++dShzYXkVhBm4cEENVKwksDp57c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jU3lbV4pCmEl5tAm8hJuRtwWSs3V7eHFqjjEJg9i86GbBbkHuZB0bgzGMfdFzuSgQcfJTN08j0PEvyR1H0lzRbS9P9+zxpmeXIl/pjz7aBnnixjVtVjRCEiDSnpG/adKrnhbXOavP4wrq7ow+aMJJMz/26L/RruwdNkgcgrY1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jhsFjyF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgFvx9xe; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jhsFjyF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgFvx9xe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F2987A0091;
	Mon,  3 Nov 2025 02:42:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 02:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155738;
	 x=1762242138; bh=No3j+gyTaBQKnX6yaS0fnjDTAvMi4PpwAMmaSisBj+U=; b=
	jhsFjyF0tNMZr4w+xAZyMUa7GxOydRwBRkp1Z+hPdwlHnPuMqaWiG4610JOXBQdS
	Yz6R/TQSnLczWX/BpvaNxl2Nu8HurLg43DVMsPt0lKrC3OID7W9bk7o4KmHw+NxF
	oTRp4v3RB28A6NNhV/YEZEjIvv0Mpq6mAeHE+0pGgaTO5WYzbU2HUnvlBxgGoZEG
	e6CvJOD3nx4ziKbEIGWdXWSS9Mz++MXbZy+xW/IdhAtbQHzpzZJppFS8zIYWU9cZ
	4lh2MKdTC1qPIc/bIqq1K44td5jUR3LYJTTLtV1K2n1SL8oX6lpc0G+01sgGI/3i
	CKbcrTyOZZqvMClE3TGLRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155738; x=
	1762242138; bh=No3j+gyTaBQKnX6yaS0fnjDTAvMi4PpwAMmaSisBj+U=; b=T
	gFvx9xerfxvX+Mdew1ASdKcGOrDAX7yXvUSsMW1tWNxCoH3zBvV8TkCGTqkWtq26
	rURqTThh23GVFIikT0rTH8r/LrDaqayDHtoeG60b0HpqVvmwiS7Di78rLM9GXhx7
	6I5ZJeikUY5s8B62quff1qWVeVzmZq9Bkdckf6tRRCjDJ4NCKyPUcykXPSDGppW0
	5yhXJZbbNmmEEnooBuLaibRDMn65mHMoLETigMpEq8JHEpbYxW1IqiAY6nRjIJmc
	4Vv+Te++mS7AwPL7wdA/JEimc3HgQ1udDJdMCk6Qm5h+nSGqOW0GuefJ6Vkh/upV
	AY+n4vxHkrGYnoKf3efGg==
X-ME-Sender: <xms:2lwIaTJn0cSZPgm3D06NpXOq9Y78eJw9G0WVkpyAdgj_YadWhx2TeA>
    <xme:2lwIaenTyR_e5MXreihoWgQVPb42KmtPoMtQ6rOYsXSqImuwU5_maJzRk0iiblRNa
    LgS74WOh_kmYdf6ioZlU28HgNZW9jP_3oMkKcAnQNrYeyr__TJ8sJY>
X-ME-Received: <xmr:2lwIaZGYnHp_ni0uILQRmZTovsyBD2UGXH9yjDHmEQZUC89p5TEnvwAfyAu7k_MJ6meI3jkClnKYmI3ebObIuulHlxFvtKsMXIeFG2iIr4wI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:2lwIaWG_NTKO9peYuO-3hXfG98lTX6huEHcNxtXDTB8Hxoyz7qG2Gw>
    <xmx:2lwIaeMdoaCGxXRHyaTsF5PGy8iaETYFIrbSrUWOsQzsUa6CAZMJzg>
    <xmx:2lwIadEsSZc257Y6kn8UK7OXylWTbHwSd9eTE5J3wBnCN6-pgORo9g>
    <xmx:2lwIadPk6iQYKv8O1GGdHuQY32i58ooHm-0Y5IUmlMu9zlTqWTfPug>
    <xmx:2lwIaWkbh2mRFaWpojtxurpEu7qlnKdZ3kps8LwS1PHG7nC1mjgXzWhG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55a9cb14 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:41:58 +0100
Subject: [PATCH v3 03/13] odb: adjust naming to free object sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-3-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The functions `free_object_directory()` and `free_object_directories()`
are responsible for freeing a single object source or all object sources
connected to an object database, respectively. The associated structure
has been renamed from `struct object_directory` to `struct odb_source`
in a1e2581a1e (object-store: rename `object_directory` to `odb_source`,
2025-07-01) though, so the names are somewhat stale nowadays.

Rename them to mention the new struct name instead. Furthermore, while
at it, adapt them to our modern naming schema where we first have the
subject followed by a verb.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index d2d4c514ae5..77490d7fdbe 100644
--- a/odb.c
+++ b/odb.c
@@ -365,7 +365,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	return source->next;
 }
 
-static void free_object_directory(struct odb_source *source)
+static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_clear_loose_cache(source);
@@ -387,7 +387,7 @@ void odb_restore_primary_source(struct object_database *odb,
 		BUG("we expect the old primary object store to be the first alternate");
 
 	odb->sources = restore_source;
-	free_object_directory(cur_source);
+	odb_source_free(cur_source);
 }
 
 char *compute_alternate_path(const char *path, struct strbuf *err)
@@ -1015,13 +1015,13 @@ struct object_database *odb_new(struct repository *repo)
 	return o;
 }
 
-static void free_object_directories(struct object_database *o)
+static void odb_free_sources(struct object_database *o)
 {
 	while (o->sources) {
 		struct odb_source *next;
 
 		next = o->sources->next;
-		free_object_directory(o->sources);
+		odb_source_free(o->sources);
 		o->sources = next;
 	}
 	kh_destroy_odb_path_map(o->source_by_path);
@@ -1039,7 +1039,7 @@ void odb_clear(struct object_database *o)
 	o->commit_graph = NULL;
 	o->commit_graph_attempted = 0;
 
-	free_object_directories(o);
+	odb_free_sources(o);
 	o->sources_tail = NULL;
 	o->loaded_alternates = 0;
 

-- 
2.51.2.1041.gc1ab5b90ca.dirty

