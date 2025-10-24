Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2E37160
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299799; cv=none; b=aFDk3qmPlGjjv7Y7+KgWTATXSPeScO7nYr12rJP702/9sfB6D/zOdeEnzWijAKWz6XfGlBuMMkQKr4oNBKl3TuhB0vDO0jseeU0fkjQ4kav39xBPLwRZGhLA7gvb9vJhEh2hIXn0iCyNTWi9FNrO4PKBb6NklO1v15joAPQmw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299799; c=relaxed/simple;
	bh=YjWfzMePKNBp3OL+q7gye3jQahavqLEbpxRK2IYNVjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZXIKxFeajCh0IT7Q9bhObJHSjAl+AL/ht/PNVS5RWPUMtwMZ42qYVjVk1Q0lSqeZmXxoNq43NOs4y17tRfmyVjoaa65Sxylrc2Ud6u9kMaGVeaxzjn+3TZrTbHgVhmPqfrigMxCDP30I1voAKdO7dAb2vinEQi+jzDfMJP3hO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GHPDB7ro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XmWJ939O; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GHPDB7ro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XmWJ939O"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BF26EC0292
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 05:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299797;
	 x=1761386197; bh=O8LqV9oNnQHrT05xqWf8pPbDb25v5om/cOYgMn03jCs=; b=
	GHPDB7ro7FHJ/sIEqh1QBKzOwPl/gB462vZU+fwpSmIDa3ZVPkJ/p5zonstbNc8O
	aVUKlJShLx4f9bVXDnlYq+IhL6X6fC/4vL2/8KtZ3JuAZ5EcriCjDISD82BC/10C
	zTEY4j3nip4GG7xWvkpiSNkCXpTegSVgwBnhbfQ92z9vvbQHCa00Pj/eaREuuQn2
	6TWkVO5pG0U5MvTqK2UjrqvE2VgdIwuoQbfTImzNyMJrRr2fbpjMQfmLLbEFmAsz
	D4zwcpCXxCiGNldpklqotEgveo569DxoI6U0KMjXUAS/aJS1fsGmA30g+zePAwI7
	mW9cwU6ZpL4cRICxklPSOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299797; x=
	1761386197; bh=O8LqV9oNnQHrT05xqWf8pPbDb25v5om/cOYgMn03jCs=; b=X
	mWJ939OUOVTYlvNEMsOetnsn62PXNV/kUMQN++oHZE6Rwt4MVi+Z8qw4yCpcDgZx
	QfgVkARaRi+zYm5pQ5X7DfuC8YzuLs3/eK86qGruC5KyuF1Cy/HxojcnPhmYWKuG
	w2W3vf2nMfGxYx+hTKLe53V96bKzhQogLI7q+CQ2NsUk0I/jpREvW9raxzxjQm66
	R26CoUFd8GSZIGH4yVfSuYDeUYGY5dM4d33wwGe6BK49YRzcBYPQAOMgUoOczmB0
	+P9w2dYO7nQIsb7+AsPjlkZ6c2+2AJ3kWk1Gdji5zTiaDyks1OvE076scwpb8gqi
	BUp3TIquBKXk/LhJffaRw==
X-ME-Sender: <xms:VE37aPtEESuaD9mCQGjb8SWq2FfcRChtmwWI6Zv1B6LrtWQpQoUK3A>
    <xme:VE37aHb1V8L8d4GcJBpqp8aZqePMc8W1Xzql1PBqoRMhg7Lpez0ZGMxtOPtOwwLky
    XzFMWypUJd4E3QGVjgz3FRuppBeB7qhsBUWvhtxRzB1a0x2n4vV>
X-ME-Received: <xmr:VE37aIby5d41t7tYTw6Jwt4aW4kz7ZWOd_eyxvr8dpJ919IFmJ1WPljMI6KUdVlOeEASclywEo5bHf3zt5JCXL29WJvMMQuAPdtiVGfDsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:VE37aDUoyq8v-1Sc7FGXMN4Cs9h971tQWwHZ-3lLN7QAuIUJ-smxCw>
    <xmx:VE37aP2xMyH2JQRBYa1fonTiWtlvBVqszucK2nVdimrOf-u92JB-xQ>
    <xmx:VE37aKYD09G9UE4eOTCiqg4jtZQy6ZNnnNyL5qMQac5Oxdd5L-ZsFw>
    <xmx:VE37aCq7Jkzdz1ekDZVaIREVPP7466RmUn-ZUKTBCdTTh-ATkfI9wQ>
    <xmx:VU37aOfunLC3yfS65qbRZqCqUZfELFMEnykdaaNQUQhDtVFh4Izn5N4i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3cbac65d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:09 +0200
Subject: [PATCH 10/13] object-file: rename `has_loose_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-10-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Rename `has_loose_object()` to `odb_loose_source_has_object()` so that
it becomes clear that this is tied to a specific loose object source.
This matches our modern naming schema for functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  4 ++--
 object-file.c          |  6 +++---
 object-file.h          | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5bdc44fb2de..c09cb342ee9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1716,7 +1716,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		 */
 		struct odb_source *source = the_repository->objects->sources->next;
 		for (; source; source = source->next)
-			if (has_loose_object(source, oid))
+			if (odb_loose_source_has_object(source, oid))
 				return 0;
 	}
 
@@ -3980,7 +3980,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			int found = 0;
 
 			for (; !found && source; source = source->next)
-				if (has_loose_object(source, oid))
+				if (odb_loose_source_has_object(source, oid))
 					found = 1;
 
 			/*
diff --git a/object-file.c b/object-file.c
index d9724e3105f..979aee32de0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -99,8 +99,8 @@ static int check_and_freshen_source(struct odb_source *source,
 	return check_and_freshen_file(path.buf, freshen);
 }
 
-int has_loose_object(struct odb_source *source,
-		     const struct object_id *oid)
+int odb_loose_source_has_object(struct odb_source *source,
+				const struct object_id *oid)
 {
 	return check_and_freshen_source(source, oid, 0);
 }
@@ -1161,7 +1161,7 @@ int force_object_loose(struct odb_source *source,
 	int ret;
 
 	for (struct odb_source *s = source->odb->sources; s; s = s->next)
-		if (has_loose_object(s, oid))
+		if (odb_loose_source_has_object(s, oid))
 			return 0;
 
 	oi.typep = &type;
diff --git a/object-file.h b/object-file.h
index cc723c9baec..8e0f38d413f 100644
--- a/object-file.h
+++ b/object-file.h
@@ -51,6 +51,14 @@ void *odb_loose_source_map_object(struct odb_source *source,
 				  const struct object_id *oid,
 				  unsigned long *size);
 
+/*
+ * Return true iff an object database source has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
+int odb_loose_source_has_object(struct odb_source *source,
+				const struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -66,14 +74,6 @@ const char *odb_loose_path(struct odb_source *source,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
-/*
- * Return true iff an object database source has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-int has_loose_object(struct odb_source *source,
-		     const struct object_id *oid);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:

-- 
2.51.1.930.gacf6e81ea2.dirty

