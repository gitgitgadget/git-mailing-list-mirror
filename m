Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0433BE62A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823211; cv=none; b=rtcRV8R4D2/hhRmXPvuqywlTQ33p2zuL17nd8Prv18hDhQG6J1PVcKAjExMIB7sM7kNZjcR1e/DQ8cpRn47K15Wd6ViVXtcB+ZTqPfNZKy0Zcpy0xiqhISbSAl/s+yxKPdYDy4KQW7uMVDptjR1LtLpCrAGtWfFefDV/pYJpUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823211; c=relaxed/simple;
	bh=boRwqSp4Uy0PeMKkNj769fSDFehhm32noDhjApo6zLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+OcIjoPu9ikJM3W0/iWGHFFuQZy3eD1UYJbCZqIaR3goM5D7n9U2zoFk0r4PtmEVmZ0/+LJKp3Fcm+/EeLNvc+1QJdN1W/T1R+5TjX5yl0DvwRUVce/gKiMHHDty/ugnabe8qtkCgM9QDjjdLLU1kL+IOi5UtN+pCyISyK6kJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vxTCM5U3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oT8P2cTZ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vxTCM5U3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oT8P2cTZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F7AC1D001E2;
	Fri, 10 Apr 2026 08:13:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 08:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823209;
	 x=1775909609; bh=EoDR6uYhlYspVcJ6yZShc37oWy2VSLPRHsKKfrODoHI=; b=
	vxTCM5U3pbjQEr2NG4uonCBjLNHM/EUMBk1VJwcoPZ/gmlqxYYSZdiixny7+k5Qb
	nAMJ1isuH9l6+SZnY9fYdL+zHS7DI2Bgu913QOPt1/67k3vcv/pWU6bEYTYNIanw
	YfY8wK5T7D5peruTgddCxbhBNSUkPJxYJO8NXvZ8jFnyqgN0h0taXZYwZiyA0aAm
	2VVfIJXe8WrBBo1YT4IiZzdAp78hirj+l0ihGrprZBMWgemLU+YOP949m8j6EMKD
	oLslRcmJcRS1j2Y4DuqZ+DxF3kqqIqwy0ymgibr7XsnZg/qmE7Wcz+2o6dZlfw0W
	NIYtIjoCN4r58plFIg/2HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823209; x=
	1775909609; bh=EoDR6uYhlYspVcJ6yZShc37oWy2VSLPRHsKKfrODoHI=; b=o
	T8P2cTZP4UjJqqPXUWkXfYqKWVht/XFzmoFZlWx8Rs6vvKUYxTjxD8SJ095Pn1qa
	bF7lwsmQSpm4AqG0gPQ56/xHWsk+UjPSDUvvg4JZTWLVLPMKnReYnbNIfUOFTC3N
	B0oFP8zw2zkHaYr0NdEcJr8DV3Vlo4SJaHopico/hXElEGyp2xbLUun3bTRWbUSw
	3ngJHiDHu3KKKC1P5BUnFZi6S3rCcAgTqCFLzb3kpHYRaWnIyGUbGX52y2WZqO7j
	4qEQrauleNtylSgDt5HuvDXE0t/3GfLTn7zZ+Y7nYdfXTjBR76Vc+5PsqgD9yPTl
	rKHZfuV7jBtmdxQqBxliQ==
X-ME-Sender: <xms:aenYacortcpWNBX7v5s3J_zl4wgcPcozup-5jglV5QFB2EFU82wWZQ>
    <xme:aenYaaEYhVDJ1R3ikrWKKsnuUUcNNS3URfwRUexZQvyIYQ6FvUt-bY4mKZcbBRipI
    SaVf-xDEMni-S_FIHirGWzny5ebqKb-aEcN45wrymjKzDKRMuO1>
X-ME-Received: <xmr:aenYaekqtmMI9NJkC9CrwPEfSLOi3t-dVkGqlIHOpOScV_-RArYT0n-UIqQhNUwLjCByPhy5Z6WRpIl_FuR9PeCrvONBpHm5tKFzZVKSzJEdFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:aenYadketKSjC6eI265NC9oY18qHElME9SFzhIyrtzOad3Hnkbh07w>
    <xmx:aenYafuT1fxJnkVm1DUOUqZ0hTD-iRKyB8kvFny99qT8wsI-BfOJWQ>
    <xmx:aenYaQkF2akyI0qQ18xwwcnKfM51ueQn1pyUS9x3ZrX-zQK5aIXEOA>
    <xmx:aenYaatEDCwTQMZ-pKR9YylGo56WfjTRY2BwX9sQZHRnPxVlHpSOCQ>
    <xmx:aenYaSF2ivPV-D6rd3HZacumpsU5VPAltaYQFSJ-iqIeulvNWLLvh-Xs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16ef19cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:46 +0200
Subject: [PATCH v3 16/17] odb: generic in-memory source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-16-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
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
2.54.0.rc0.707.g0fbf48f4d6.dirty

