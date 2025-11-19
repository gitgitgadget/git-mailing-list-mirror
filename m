Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CE329E44
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538696; cv=none; b=QNb3lJHh/mP4f3oVQIvzUcG7XvonR3Koozo7v8VF04b34AsdqMQSmY+QxBelc8Ed3tGVhXermOou5m7ma4bCANyFwuoTkrcR8bnmsR+TtN0Mtv0Bb4WcCtOiWT5+Yr+oaobUbQDv/FM5ReLpJgru/Me1EfhKD6d0cEaTZUpgyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538696; c=relaxed/simple;
	bh=xKi/62evDFg5pNFIP9EwCf3n+fszK5S4RtUt1Qbzcak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FVciPxP6G6I7B6p/lxOdOmB3LTFCZBoZ6q1P9NQkOpHnMA28PSJ+GOOmQQ6ESHqUL/PdhvmRHX4pBQAgPMUlaXTf7lLcjThOkSSSf69z6UGzUnaTeUHotRoAbyMfYj3B+2GoV66wGLGku/alw8c2lYcxTjJQlZxXA40CI9wbHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YrG80bJe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sz484F01; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YrG80bJe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sz484F01"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 806DB14001DF
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538694;
	 x=1763625094; bh=CiX2TH3qpj3zYx8Kx4T+ThgQ0aw54Iotx7KY6RSk6wg=; b=
	YrG80bJeWwrZ6CCpRGLhNFNgiVnVqQMJjNyqLd06gCpXVFODEBT9tUmcRq++R4ex
	eVPvF6w7nYEORxpcPR83IbeD7b0z/sdAO8c33aI0QhhLR0NPzl4CDw+dyO86xA8c
	TxMMhgOrnmiiigiEw9X/TzmuCY5qZAfMJ19FeDV7ynr/zvZ5zaqPcpHGGN48j4/r
	hhD71mMoGMqsvmh82ScnF0eRbaGkDI5pqgPLMGgz74lD6XUqWLwhhiItJJ5Kktls
	wKffh2xwaIjmpij5cFpetLN8+motwLk82lRA5w8sv8QbeJybCPLG98oxLVSpWcNB
	0F6d8f5OYe4Sfgypf1kL1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538694; x=
	1763625094; bh=CiX2TH3qpj3zYx8Kx4T+ThgQ0aw54Iotx7KY6RSk6wg=; b=S
	z484F01jqJBtur3Hy9PE5HO4/CcZN6IOwbkiZ4QbGkuR73DANizCcA1zj00E8725
	6Cw86ol1Ug7R/CdcSHNIH3XgLs77n3wKds3AzkxiQ6NEAdETqQa4tnx6nAjJEt20
	MEeSt0MpFgYYEJSlzOMSsYQeoe2i6enS80GIVFh5Uyi7WvcaaXjpfNYXn0RT02UE
	ImtAmy7V9SYaaOknrCEAWwjtv1tLBtp0U6vnyyZCJNmgas0c4tgIW4RwXhkyHjEo
	x1UZjVj1MgKgZTwIqovoqnBi6czOPTU5csc7cGi7VtXkdCRP9odAOO9DlyLL45rm
	EYRqYMjjfW2kr9/lKMDLw==
X-ME-Sender: <xms:BncdaVxEERKP1ZqOm1QyeJ75JzbvMNPye5Zky6RXiLc1ddo5zemkfQ>
    <xme:BncdacPXNKjm7xAxHaxluxFqTSLAV5NWZIp-W8Gvvu5XFCa8byxf7b5JyXA9bZF0H
    NDUa4cJykpEC609ugnWxaTYiRhQtZV9f2VAUqBXXUqMCcnRcu_i>
X-ME-Received: <xmr:BncdaU97P5YMQR72wipZ9ZKkjn3gqUZGd-t8iPP9dkHGcdbhLX4gHeegXRssQNHDo0P3pUiV3BlZeptrOIQwqGwsLc0n8K47fG98ozSslA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Bncdacr7GZkS2O2PBv7QVVbplXk3YJVvVOKEYq56tHzmrGre3ecQ2A>
    <xmx:BncdaW6mpHMceC9Wib0F3JLhs0ypkXveQIOmpg-K0LVfIfieGXD0mw>
    <xmx:BncdacOdtL1zVBeiMdUzkhoBrEgIVQYtONqs2HHVqfHJJh5IXlyOfA>
    <xmx:BncdaYNnZ6RobhoB1jiChD5R3u501hS6FngLMseOACpY3kHEQ5ULyA>
    <xmx:BncdabzRDE1UuQe9JC6jN0nEeq3sA5qvk54FAsH77jPozdnmj5CAkWMi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d5a2214 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:58 +0100
Subject: [PATCH 10/13] odb: handle initialization of sources in `odb_new()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-10-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The logic to set up a new object database is currently distributed
across two functions in "repository.c":

  - In `initialize_repository()` we initialize an empty object database.
    This object database is not fully initialized and doesn't have any
    sources attached to it.

  - The primary object database source is then created in
    `repo_set_gitdir()`.

Ideally though, the logic should be entirely self-contained so that we
can iterate more readily on how exactly the sources themselves get set
up.

Refactor `odb_new()` to handle both allocation and setup of the object
database. This ensures that the object database is always initialized
and ready for use, and it allows us to change how the sources get set up
eventually.

Note that `repo_set_gitdir()` still reaches into the sources when the
function gets called with an already-initialized object database. This
will be fixed in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 14 +++++++++++++-
 odb.h        | 15 ++++++++++++++-
 repository.c | 20 ++++++++------------
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index ccc6e999e7..88b40c81c0 100644
--- a/odb.c
+++ b/odb.c
@@ -1034,15 +1034,27 @@ int odb_write_object_stream(struct object_database *odb,
 	return odb_source_loose_write_stream(odb->sources, stream, len, oid);
 }
 
-struct object_database *odb_new(struct repository *repo)
+struct object_database *odb_new(struct repository *repo,
+				const char *primary_source,
+				const char *secondary_sources)
 {
 	struct object_database *o = xmalloc(sizeof(*o));
+	char *to_free = NULL;
 
 	memset(o, 0, sizeof(*o));
 	o->repo = repo;
 	o->packfiles = packfile_store_new(o);
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
+
+	if (!primary_source)
+		primary_source = to_free = xstrfmt("%s/objects", repo->commondir);
+	o->sources = odb_source_new(o, primary_source, true);
+	o->sources_tail = &o->sources->next;
+	o->alternate_db = xstrdup_or_null(secondary_sources);
+
+	free(to_free);
+
 	return o;
 }
 
diff --git a/odb.h b/odb.h
index 99c4d48972..41b3c03027 100644
--- a/odb.h
+++ b/odb.h
@@ -159,7 +159,20 @@ struct object_database {
 	struct string_list submodule_source_paths;
 };
 
-struct object_database *odb_new(struct repository *repo);
+/*
+ * Create a new object database for the given repository.
+ *
+ * If the primary source parameter is set it will override the usual primary
+ * object directory derived from the repository's common directory. The
+ * alternate sources are expected to be a PATH_SEP-separated list of secondary
+ * sources. Note that these alternate sources will be added in addition to, not
+ * instead of, the alternates identified by the primary source.
+ *
+ * Returns the newly created object database.
+ */
+struct object_database *odb_new(struct repository *repo,
+				const char *primary_source,
+				const char *alternate_sources);
 
 /* Free the object database and release all resources. */
 void odb_free(struct object_database *o);
diff --git a/repository.c b/repository.c
index 455c2d279f..5975c8f341 100644
--- a/repository.c
+++ b/repository.c
@@ -52,7 +52,6 @@ static void set_default_hash_algo(struct repository *repo)
 
 void initialize_repository(struct repository *repo)
 {
-	repo->objects = odb_new(repo);
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
@@ -160,29 +159,26 @@ void repo_set_gitdir(struct repository *repo,
 	 * until after xstrdup(root). Then we can free it.
 	 */
 	char *old_gitdir = repo->gitdir;
-	char *objects_path = NULL;
 
 	repo->gitdir = xstrdup(gitfile ? gitfile : root);
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
-	expand_base_dir(&objects_path, o->object_dir,
-			repo->commondir, "objects");
-
-	if (!repo->objects->sources) {
-		repo->objects->sources = odb_source_new(repo->objects,
-							objects_path, true);
-		repo->objects->sources_tail = &repo->objects->sources->next;
-		free(objects_path);
+
+	if (!repo->objects) {
+		repo->objects = odb_new(repo, o->object_dir, o->alternate_db);
 	} else {
+		char *objects_path = NULL;
+		expand_base_dir(&objects_path, o->object_dir,
+				repo->commondir, "objects");
 		free(repo->objects->sources->path);
 		repo->objects->sources->path = objects_path;
+		free(repo->objects->alternate_db);
+		repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	}
 
 	repo->disable_ref_updates = o->disable_ref_updates;
 
-	free(repo->objects->alternate_db);
-	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

