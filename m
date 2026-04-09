Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA45437D107
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719517; cv=none; b=S2M7PjZ47AWRI9xjFr0j2rqQc5r/6dyX50sV4tlLaFeIEjMMcTpLNlAMiOQNIy3AOcaUGxAqTa1OUv7aFq+QeW/pVQ2Top++DxkEHafRU65nJJAYLBI/O6PHHVwJLkr9AkUx71Fog1h7LUHpgTi/+wd1ui8M8bNs6SweE2L3kqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719517; c=relaxed/simple;
	bh=ZnX6/AqWsGH/aSHIwGk2iuQDCDQJE4DNSJ5J87iHqkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mq2hQZU4RZtdVAWfigAFMVc1/nxOT/PD5tDe0wJfGnC0gna48bNqP+fdyoXKb6EZ9Zbri2T+PsB047KW8pXyGNrM4mLwqSFBGcNCVteen1dKuzdKOXkqHsSATf1ruuQR/3qLu3OnNVSczd6XSF5YmKhBXcndftpxHtufMB3Eox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vo9VDndl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZUfadb96; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vo9VDndl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZUfadb96"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 07EA0EC0477;
	Thu,  9 Apr 2026 03:25:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 03:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719516;
	 x=1775805916; bh=lKYdtQ2dtsBi4tJV9sGf1GzGoXuVrv3+S3AqWOxIwgQ=; b=
	Vo9VDndlIZIL7uUbcVP96kNrOQK88qUVvtkBd2UHwg2MDN0sE4tM59waY9d4QZhR
	8JXceeKsMond7TuPr89Hor+vvD5wk9uHlxpgmPACSzgxkiSI+5nHRw3bEiGy/aMu
	/7qi8emRhNpCPx+Lp9P3/DleRj9u6Ir5MPm+E0ZQd7V2GeoCk0szuk8iDzsuw+H0
	K9+OT2WYsnMN9WX7q/g7ySNn4E7mtAQLxoENSUg5CZBYqYBcBhOYQ2k5A74Oe3cF
	t2A6nf8MZIdZzIV63KHpRd/KdsG8UHISKz30VIWUUGM3Llr7dZkPhGioOOJ2ub/E
	DY6ysgXfMSPYiYvstFdT1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719516; x=
	1775805916; bh=lKYdtQ2dtsBi4tJV9sGf1GzGoXuVrv3+S3AqWOxIwgQ=; b=Z
	Ufadb96FFREGIEwbwyxXL81+WpVfTddJPkfpW79yGFC69JU/Ix+gZHL98icdGqFp
	tuvGzOh4n46APZV4jd6aCrLjtZuTonfrLufh+S/jhvqYTszq+pU86hBw+b/F3VBK
	4SymEy4X5RrfS9/Es2Goqa4znHCryGzI5/NBVpN6/mHoEjrJ1ISE79GRvCFBwAc8
	6PACb8AyZLsl2mKZMtdcjDgYVwo3QmRHc1+VJMhxth1WE1KfyVnpO784GlwKGPaW
	QQ7jrvsGo4w0gfprHPaUun+bh/4l9CPU8nwL3K4t+Kj8sph1+JBpexo6bM7oS8Z/
	SR2JveknUAQVvJF+fdxwQ==
X-ME-Sender: <xms:W1TXacHu7C8hmbfW2FyO3Eb2YRPBLp8NSYFv5cQ5FcKp6QhXJHhWsg>
    <xme:W1TXacwFIXBByFj8A6aqfw2PI4KG1rlhjtu-H7qFvBXRj4x7VBx-MjQg9smwJhDw7
    v7rUSVujc5jsLrgHDeCGetzrNjr-iRTKeZRkDgiVySPeF9xIiJeqg>
X-ME-Received: <xmr:W1TXaTjI0t3gDU369Wh3g2pslloj5iG0Y70h9hfLoTG73-GYhE_RuHmrpMSUuN8VzZtgUut7i1G7uYGgVs4-4cZxL5zMqxtShUeuuC_4mC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:W1TXaXwTDN8Pxi80j3PWeDJopJ-aCvuSKH3PK5bh4O-BRw0gbBjJsA>
    <xmx:W1TXaWIvV7oPY78ycwfZCNInV8Oml3ExYxyhFu-Bcb1YwdBhUxCtHA>
    <xmx:W1TXaeS5mmCkAGd6ihgMkO_2j9EwdEs6ArmkqiT1UcgSFw9pBIch-Q>
    <xmx:W1TXaeoH56gqQ7Ski8FdkOvzAIZFdmrJq7oLregoYiffLeCIEfU3eA>
    <xmx:XFTXaQxnV5ZPT6IRV4hAyEH9D7C7J93bfYn6O4izwj5lRynrzVYj61N5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:25:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79ddbfef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:25:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:38 +0200
Subject: [PATCH v2 17/17] odb: generic in-memory source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-17-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Make the in-memory source generic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 8 ++++----
 odb.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index 24e929f03c..965ef68e4e 100644
--- a/odb.c
+++ b/odb.c
@@ -560,7 +560,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	if (is_null_oid(real))
 		return -1;
 
-	if (!odb_source_read_object_info(&odb->inmemory_objects->base, oid, oi, flags))
+	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags))
 		return 0;
 
 	odb_prepare_alternates(odb);
@@ -737,7 +737,7 @@ int odb_pretend_object(struct object_database *odb,
 	if (odb_has_object(odb, oid, 0))
 		return 0;
 
-	return odb_source_write_object(&odb->inmemory_objects->base,
+	return odb_source_write_object(odb->inmemory_objects,
 				       buf, len, type, oid, NULL, 0);
 }
 
@@ -1020,7 +1020,7 @@ struct object_database *odb_new(struct repository *repo,
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
 	o->alternate_db = xstrdup_or_null(secondary_sources);
-	o->inmemory_objects = odb_source_inmemory_new(o);
+	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
 	free(to_free);
 
@@ -1045,7 +1045,7 @@ static void odb_free_sources(struct object_database *o)
 		o->sources = next;
 	}
 
-	odb_source_free(&o->inmemory_objects->base);
+	odb_source_free(o->inmemory_objects);
 	o->inmemory_objects = NULL;
 
 	kh_destroy_odb_path_map(o->source_by_path);
diff --git a/odb.h b/odb.h
index c3a7edf9c8..73553ed5a7 100644
--- a/odb.h
+++ b/odb.h
@@ -81,7 +81,7 @@ struct object_database {
 	 * to write them into the object store (e.g. a browse-only
 	 * application).
 	 */
-	struct odb_source_inmemory *inmemory_objects;
+	struct odb_source *inmemory_objects;
 
 	/*
 	 * A fast, rough count of the number of objects in the repository.

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

