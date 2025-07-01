Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250427703E
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372597; cv=none; b=gCAEMz8G1l1YsMqpayJLm5XihZfKb9Ja3lS8wxWEFiZwky4JLnfB4VzuaFA1Qf3MpuigA606HubEmKpPIEWyyhnivMhaIDhwvPbZcWbL6oy4VaLpuPZi7bU0TsPZqKK7EzOW7BNrElxXHmssvNrTvK3aAATOsOLyg/zmfAb7VYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372597; c=relaxed/simple;
	bh=4lDuxTk+cqAV3OodPCJWzyQCSLbwK4XH2M9F1Y4PYOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVVQr5hDy1Aer61ijupB+C0Pm5CMU0HciQzTS/sh+PE4ctW5SNrG+usfX8qALVh7m+HJf2/2a/sCqWl858w1C0dFwmnFwUCCfLf9nAtSj/8Yzk0rgPCb5FtPOYbkHrOe5XLTOZPI6IBc7vuyC0IG5wyYqvYi3XbnRsO4HTbp8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmXoIl4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nKeqMdYq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmXoIl4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKeqMdYq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 62B85EC04F6;
	Tue,  1 Jul 2025 08:23:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 08:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372595;
	 x=1751458995; bh=tktgRS5zKy+LyGQrVfTqP3fJOe/HA4smrqscZ1GAToc=; b=
	OmXoIl4LnKqfj48RaB/J120EQJOb9N6YC1aVdzREtw+SKqUE/VCPXg9HP3eC8FSj
	FZdK7+s9oehME8ZD3MAqwGERHBN221I4yUm3D4/x5ftD/0BR1jCmH5iEXsCHWVJk
	zX122CAKwJjVPG1EttLPYz1Tithkq+kqDVOefA8bLuxH1FpgPx2PEI4DpfYH8eDN
	lB6kaEyXKwkx98XbcbDiUo+MUDUlbdL9aqaUx5lBZd8ipiyxcQsyA87l2ec+0901
	3Lle6T98WFY5s6xSf3tsjo/viH9TcwftdVEabEx8+xzRtaq7F8erhJjwAhSGgkfE
	TMYBOGISxAC0dlVTkrdQgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372595; x=
	1751458995; bh=tktgRS5zKy+LyGQrVfTqP3fJOe/HA4smrqscZ1GAToc=; b=n
	KeqMdYqi22iTblkzSQZeJQ/NefauxnMkXKLxeOSIxuRzwgFSnj57BRAyT3jH/v8q
	O2/C0ZYP4dIhnpXI5VbkaPd5vfQ+szAhGigWL/g4FObFnimrV2SmiWiGDxRtt3L5
	juWef+QyOyLjOCwM85u+kYGKeGT2+wmSaMmIz83EAr7KGIh4T6z1fHimxcqL3RiR
	q0Gt1KE0XyfcQ99AXpZjVtqlkw0im9jKARJNZ9zu8UTtwpswfi3HznFymyjfI8Jp
	TVS53xOARJAxr0IWeHMI5tgWml9XupvWdrG2rHT3Gq+Kh5E4dHZWF6Nfl8L06fWY
	rjZ8riVof2Blhw6gE/ztA==
X-ME-Sender: <xms:M9NjaHmb83nFmw5S6yf_zNSQlzJkt58zLEmp823Qh-eIQUOpIMuUPA>
    <xme:M9NjaK0E6lMJh5Y7-W58ew2letCw799gIZZc8UUTMJrIU_mbWf0EAavLMikxDwqLD
    yG_rBrQEtppfLZusg>
X-ME-Received: <xmr:M9NjaNrDs0f_zPVJYSX2AXlM9KUVc6MVX_0uKRpPDMRNvSkYqwwsh50QwQZpaFYdpg2l9o332vkvDqKo_8DgRqOG5urOAlg8XwuogTgjWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepuddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:M9NjaPmrW-csIpbgd_mbvIKWqiHwV1sAxGQcAjgJI_RDloIbpQssYg>
    <xmx:M9NjaF2zWZKbbzfS0P4Fr24h0tGbdAmERc4GcXQH9ENXVmimWSRt7Q>
    <xmx:M9NjaOuI-WeRkzkMoOJowMytGRoFsjNPAQbdInmw3RctOde1FM6soA>
    <xmx:M9NjaJX_g-trNZNffytmk2U8X6T8Z61cpyg5x_ZnZQtY_n6T4vpxAg>
    <xmx:M9NjaHNIkFZYf1G__2Hjsr6nRjmKAc7s6hnvieGGwf9VHZ7Rkd9hCWDD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:23:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0256cb8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:23:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:28 +0200
Subject: [PATCH v6 16/17] odb: rename `pretend_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-16-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Rename `pretend_object_file()` to `odb_pretend_object()` to match other
functions related to the object database and our modern coding
guidelines.

No compatibility wrapper is introduced as the function is not used a lot
throughout our codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c |  3 ++-
 odb.c   | 18 +++++++++---------
 odb.h   |  6 +++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/blame.c b/blame.c
index 858d2d74df9..dce5c8d855c 100644
--- a/blame.c
+++ b/blame.c
@@ -277,7 +277,8 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	convert_to_git(r->index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_object_file(the_repository, buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
+	odb_pretend_object(the_repository->objects, buf.buf, buf.len,
+			   OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/odb.c b/odb.c
index ecb6711a27b..217903d7b14 100644
--- a/odb.c
+++ b/odb.c
@@ -863,21 +863,21 @@ int odb_read_object_info(struct object_database *odb,
 	return type;
 }
 
-int pretend_object_file(struct repository *repo,
-			void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid)
+int odb_pretend_object(struct object_database *odb,
+		       void *buf, unsigned long len, enum object_type type,
+		       struct object_id *oid)
 {
 	struct cached_object_entry *co;
 	char *co_buf;
 
-	hash_object_file(repo->hash_algo, buf, len, type, oid);
-	if (odb_has_object(repo->objects, oid, 0) ||
-	    find_cached_object(repo->objects, oid))
+	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
+	if (odb_has_object(odb, oid, 0) ||
+	    find_cached_object(odb, oid))
 		return 0;
 
-	ALLOC_GROW(repo->objects->cached_objects,
-		   repo->objects->cached_object_nr + 1, repo->objects->cached_object_alloc);
-	co = &repo->objects->cached_objects[repo->objects->cached_object_nr++];
+	ALLOC_GROW(odb->cached_objects,
+		   odb->cached_object_nr + 1, odb->cached_object_alloc);
+	co = &odb->cached_objects[odb->cached_object_nr++];
 	co->value.size = len;
 	co->value.type = type;
 	co_buf = xmalloc(len);
diff --git a/odb.h b/odb.h
index 2532c490461..e4c51f8c38e 100644
--- a/odb.h
+++ b/odb.h
@@ -282,9 +282,9 @@ void *odb_read_object(struct object_database *odb,
  * object in persistent storage before writing any other new objects
  * that reference it.
  */
-int pretend_object_file(struct repository *repo,
-			void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid);
+int odb_pretend_object(struct object_database *odb,
+		       void *buf, unsigned long len, enum object_type type,
+		       struct object_id *oid);
 
 struct object_info {
 	/* Request */

-- 
2.50.0.195.g74e6fc65d0.dirty

