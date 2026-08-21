Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4239A070
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315520; cv=none; b=K+TkXdv77Nzd0KBkXFoCK7z4dDrTdxrwlL5EyZk9o9tu3KA63tIzbZ7bGw4VkvE8S2aIwHxjS5tbGsdF8hyH0udwv25fMm923gpgo1emEfva67yxu43ymtNx3mujo5bHkwT3HOsjjDFlL7YvHc9gYP7Z4m/7vcGzxsvepp1KS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315520; c=relaxed/simple;
	bh=r+0TZMqYZUgekDyKfzzX1RhX8nsFFAAN45cFdYPbHI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BewYDmEshY6EB6MaTPgRd5rtnh6rcm5v7bmDfX+OuYcoxQ+RRgC7vemy8u14c40jaxlxlxjeClqJB9M9EbgpPtXrFwiTLWLKLD0G/+AWckQhWiT+0S10VDVSgLPnYZZDWsaJI3t9BHXZrqu78sLl3AEr3UOX3Stv5qGkZYB0fqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hb6yMhyW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uass2mma; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hb6yMhyW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uass2mma"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 103A91D000A9;
	Fri, 21 Aug 2026 08:31:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 08:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787315517;
	 x=1787401917; bh=tzMq/7XUcSwNXEddIIYhnxeBH+2WxKouTbMRM76/RVU=; b=
	Hb6yMhyWVDBMgWSXl5eeLxYwQ9+fRdtp142xfvv2JLRdeIjGpq/dXjcovQmwHL6q
	o4QEVn2OjnGhYUKNd8yJMITjYbTL1DwyYORgjj2+FN6y5GC+ngcIw4aESaGQwXOv
	karoMXUAmb6D/jwA3EhzrF2jQoFFvevePpqDsR+PIn4EnZ6sPoj5ONpEBreefty6
	rsVm7WqajjqNxgXDUzo4TI3riURr5ROc6Eraf6YO1HZLKvPoa0tNHGfycJIfxj6u
	rJRAKwK2yxakXGU3GVLtyuzXJN/EUusF7UZHmLg0xu95rmsVMbqUCplqqiHUEqG3
	+1/RJFa0AqgNS2FJStqKtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787315517; x=
	1787401917; bh=tzMq/7XUcSwNXEddIIYhnxeBH+2WxKouTbMRM76/RVU=; b=U
	ass2mmasxez7xL4z7+iiduNApoIwb6IMYnf+sjR8Zc8JmDktJb/WoZdR0nYC908D
	1o+FcEQt/qfwmPd22L3yFdI2GnJIhnAB48cdYMM+9uf/255oEzzfZK9m61dC/lmZ
	Q9EYLAml9QFVDL7k6PjOXk/SQrgdMAzMBXJF7BzLgFPf2gNuF4cN4tJyvDyHT4yR
	xDXY9G7Vs+wYyv3SEpImg5Z3nExhWAbL2mloXU9VOkPcXCu3MhtOoqZlunnbppP/
	ucNpKsj40kT1VSZg9/G5ZydxvhpWuMZdPMODvZbh9OTT6tNwgX+opf6HJ0uOisc8
	iPGRLtyIf2Q/aWUD4Dmuw==
X-ME-Sender: <xms:PUWIaq0AbLVMAhRBnSYu0xNdKXiIFE6OtZK30jy7FD1QiBG4T3bbVg>
    <xme:PUWIajFXp8UzK8o2wp9_fRVxVnH7pJ42ddsV2omhln4BAvKscgfDOQtNGXblOheSF
    tFloQXCE58z7YrZUqeEy4-ThX_Y90CqhvLoMqYpchGd_Jg7zUk6K3c>
X-ME-Received: <xmr:PUWIaggcC5TveE-cDkN046NbUqReu2v63obDpOw9eWfJRb3YkM0pzyuiIAJ7O96Pi_e_5JKD2v7_HUDagAS5Ys-YlqJXi2_hx9QbzQbf2S5O>
X-ME-Proxy-Cause: dmFkZTFYXsaYZDZX10iFSkvawHQots3XUNG/EoMNY98euoXJyn68xBMAtVvdobfPPQpgil
    GZHNVOOd8icWUwEV5JLvLuFUUb/AbLA4mghosK9Nz3/fPE0DQ6r/pVXPayDEAeBpKpmEwQ
    0IDAepK7PT28lYM8VwIPmgAuievITnWYs8Or5rXhzBnc614yYfpiq7TJySW6aYC+gFsltg
    VAwneeuw585oMEncB9CIi41xPGMjP6sr5V3BRoappl3YAaFAiSgv1WTmF+TkBrWbEdSSDF
    0s3HC3cTFYi6IsJawVIfy+pxX+1ke9CC+7J1H4U/kl68eiMc7T3IVEKQqz3baWYK4VqlWZ
    v/bqRRSwF4xyQiH4Sc+Hmgzjrm8Ggn4i9dbqv+r/2uIIxU2q6CZKZFZwKLRu0Ppsc4/JGO
    IzRiaL2YT+44BmPzQYIa7Or2apq6kpjbrkMV7FxLvMgna2pm+WaXz81tWrDXsTcBsACMsS
    CedX3oSTfRXrCvgpqoHDYnQW91KWRl0uki/d7nk10og3xx7gcHj6XRd30L98hmb1AyWMWT
    pD65Mgll9rgwzno1WeRXRzNKOC7yTAqeaZqfDi7gY9GfUBl0UCuUbKW5E06Tfi5alV6Eh5
    NMnctEOE0/JictL9PgWI9sZLp2l91vqDWA7TMM+LMN3czV3+0NEy6k5qpDZg
X-ME-Proxy: <xmx:PUWIam9oJPPVmylmUzcUZUtZGHy_LXxl4glHRlAF64hl8Q2t_2DGqQ>
    <xmx:PUWIavqubq6aPvxq6MY0avut0vDqr14DFnoqaJDh44VMl2w4Z7OKtA>
    <xmx:PUWIat8HZW4ZjwAAgtxrd6x93tbxiodmfmfZhj8L8GNFsETPrI8WFQ>
    <xmx:PUWIarVmP0VLCorGOYn2FzHAdqI0NBW0rFA8oJdgt-CSiIa9OooGSg>
    <xmx:PUWIanl-ZlPbe8cM-JXGKdv9qScr3tz63Sy8YR-jM9KnwYgdWuo5QzK5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 08:31:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 391a32ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 12:31:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Aug 2026 14:31:44 +0200
Subject: [PATCH 1/2] fetch-pack: prepare for threaded fetching of packfile
 URIs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-pks-parallelize-fetching-packfile-uris-v1-1-0df52d9427ce@pks.im>
References: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
In-Reply-To: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
To: git@vger.kernel.org
Cc: Ted Nyman <tnyman@openai.com>
X-Mailer: b4 0.15.2

In the next commit, we're about to add the ability to parallelize
fetching packfile URIs. Refactor the code to prepare for this by
splitting the logic up into three explicit phases:

  1. Preparation phase, where we allocate the state that will be
     populated by the different threads.

  2. Fetch phase, where we fetch the packfile URIs. This is the part
     that will be parallelized, and we need to be careful to not access
     any shared state here.

  3. Aggregation phase, where we aggregate results from the parallel
     worker threads.

This should not result in a user-visible change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 148 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 54 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 626f799712..6aca0b2588 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1668,6 +1668,98 @@ static void do_check_stateless_delimiter(int stateless_rpc,
 				  _("git fetch-pack: expected response end packet"));
 }
 
+struct fetch_packfile_uri_result {
+	struct oidset gitmodules_found;
+	char packhash[GIT_MAX_HEXSZ + 1];
+	bool created_keep;
+};
+
+static void fetch_packfile_uri(const char *uri_with_hash,
+			       const struct strvec *index_pack_args,
+			       struct fetch_packfile_uri_result *result)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	const char *uri = uri_with_hash +
+		the_hash_algo->hexsz + 1;
+
+	strvec_push(&cmd.args, "http-fetch");
+	strvec_pushf(&cmd.args, "--packfile=%.*s",
+		     (int) the_hash_algo->hexsz, uri_with_hash);
+	for (size_t j = 0; j < index_pack_args->nr; j++)
+		strvec_pushf(&cmd.args, "--index-pack-arg=%s",
+			     index_pack_args->v[j]);
+	strvec_push(&cmd.args, uri);
+	cmd.git_cmd = 1;
+	cmd.no_stdin = 1;
+	cmd.out = -1;
+	if (start_command(&cmd))
+		die("fetch-pack: unable to spawn http-fetch");
+
+	if (read_in_full(cmd.out, result->packhash, 5) != 5 ||
+	    (memcmp(result->packhash, "keep\t", 5) &&
+	     memcmp(result->packhash, "pack\t", 5)))
+		die("fetch-pack: expected pack or keep then TAB at start of http-fetch output");
+	result->created_keep = !memcmp(result->packhash, "keep\t", 5);
+
+	if (read_in_full(cmd.out, result->packhash,
+			 the_hash_algo->hexsz + 1) != the_hash_algo->hexsz + 1 ||
+	    result->packhash[the_hash_algo->hexsz] != '\n')
+		die("fetch-pack: expected hash then LF in http-fetch output");
+	result->packhash[the_hash_algo->hexsz] = '\0';
+
+	parse_gitmodules_oids(cmd.out, &result->gitmodules_found);
+
+	close(cmd.out);
+
+	if (finish_command(&cmd))
+		die("fetch-pack: unable to finish http-fetch");
+
+	if (memcmp(uri_with_hash, result->packhash, the_hash_algo->hexsz))
+		die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
+		    uri, (int) the_hash_algo->hexsz,
+		    uri_with_hash);
+}
+
+static void fetch_packfile_uris(const struct string_list *packfile_uris,
+				const struct strvec *index_pack_args,
+				struct oidset *gitmodules_found,
+				struct string_list *pack_lockfiles)
+{
+	struct fetch_packfile_uri_result *results;
+
+	/* Initialize the data. */
+	CALLOC_ARRAY(results, packfile_uris->nr);
+	for (size_t i = 0; i < packfile_uris->nr; i++)
+		oidset_init(&results[i].gitmodules_found, 0);
+
+	/* Perform the fetches. */
+	for (size_t i = 0; i < packfile_uris->nr; i++)
+		fetch_packfile_uri(packfile_uris->items[i].string,
+				   index_pack_args, &results[i]);
+
+	/* Aggregate results. */
+	for (size_t i = 0; i < packfile_uris->nr; i++) {
+		struct fetch_packfile_uri_result *result = &results[i];
+		const struct object_id *oid;
+		struct oidset_iter iter;
+
+		if (result->created_keep) {
+			char *lockfile = xstrfmt("%s/pack/pack-%s.keep",
+						 repo_get_object_directory(the_repository),
+						 result->packhash);
+			string_list_append_nodup(pack_lockfiles, lockfile);
+		}
+
+		oidset_iter_init(&result->gitmodules_found, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			oidset_insert(gitmodules_found, oid);
+
+		oidset_clear(&result->gitmodules_found);
+	}
+
+	free(results);
+}
+
 static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
@@ -1692,7 +1784,6 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct object_id common_oid;
 	int received_ready = 0;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
-	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
 	const char *promisor_remote_config;
 
@@ -1853,59 +1944,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
-	for (i = 0; i < packfile_uris.nr; i++) {
-		bool created_keep;
-		int j;
-		struct child_process cmd = CHILD_PROCESS_INIT;
-		char packhash[GIT_MAX_HEXSZ + 1];
-		const char *uri = packfile_uris.items[i].string +
-			the_hash_algo->hexsz + 1;
-
-		strvec_push(&cmd.args, "http-fetch");
-		strvec_pushf(&cmd.args, "--packfile=%.*s",
-			     (int) the_hash_algo->hexsz,
-			     packfile_uris.items[i].string);
-		for (j = 0; j < index_pack_args.nr; j++)
-			strvec_pushf(&cmd.args, "--index-pack-arg=%s",
-				     index_pack_args.v[j]);
-		strvec_push(&cmd.args, uri);
-		cmd.git_cmd = 1;
-		cmd.no_stdin = 1;
-		cmd.out = -1;
-		if (start_command(&cmd))
-			die("fetch-pack: unable to spawn http-fetch");
-
-		if (read_in_full(cmd.out, packhash, 5) != 5 ||
-		    (memcmp(packhash, "keep\t", 5) &&
-		     memcmp(packhash, "pack\t", 5)))
-			die("fetch-pack: expected pack or keep then TAB at start of http-fetch output");
-		created_keep = !memcmp(packhash, "keep\t", 5);
-
-		if (read_in_full(cmd.out, packhash,
-				 the_hash_algo->hexsz + 1) != the_hash_algo->hexsz + 1 ||
-		    packhash[the_hash_algo->hexsz] != '\n')
-			die("fetch-pack: expected hash then LF in http-fetch output");
-		packhash[the_hash_algo->hexsz] = '\0';
-
-		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
-
-		close(cmd.out);
-
-		if (finish_command(&cmd))
-			die("fetch-pack: unable to finish http-fetch");
-
-		if (memcmp(packfile_uris.items[i].string, packhash,
-			   the_hash_algo->hexsz))
-			die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
-			    uri, (int) the_hash_algo->hexsz,
-			    packfile_uris.items[i].string);
-
-		if (created_keep)
-			string_list_append_nodup(pack_lockfiles,
-						 xstrfmt("%s/pack/pack-%s.keep",
-							 repo_get_object_directory(the_repository),
-							 packhash));
-	}
+	fetch_packfile_uris(&packfile_uris, &index_pack_args,
+			    &fsck_options.gitmodules_found, pack_lockfiles);
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 

-- 
2.55.0.822.g20453c30eb.dirty

