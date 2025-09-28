Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F519C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097239; cv=none; b=VgITqlE6pjxuhkPdVP1/GDgDCb6Jx/J9yWTnU7GaGp68GIgCIBJuwFwNICLkQ9ZJ9FRxPHN3J2/akNOjpLUEiX5QmuMgSs4pwbArUT0KSrX+pgSYQZTH6hrEqrygal5jawQuKmCbx4JCsT8E0DrFgNmL8fe4dFmV6FEq13byCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097239; c=relaxed/simple;
	bh=Op9bLfGNJQZHGtDZ5S6cpvWMrfBpxpfA1WhfldqtpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqrBM9rrBhOf5qg3bKgItzqQ3ReWRKKcIYpd0vXU8YXC45JIFCLESI5vZTQvG49Lh+DoSTm18bVwj9DM9KovSvl5TuD6HWuK0qtYCg9NHREgSRnIKbJ2T6lvXj0hOatZCP6Jfxs+o6buZq+n3oJq6h3ird7yT/0n4K/39FwXyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bZCA04Fo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bZCA04Fo"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-72e565bf2feso40637427b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097237; x=1759702037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fwMXkD1zXlvbev0t+QX7XXpwQW6fW06+yvTVni3PWY=;
        b=bZCA04FoXZvC6Q2m7m2RqNpLa/o3T5ivu58rkDWaPhTQ3FG1dha9bSkQ+7BR/Aoi0D
         aIcLlNgcpTMqoe1TCnPxxOOZDAzyIStdewwVDzWlwmuY2/xA/3UdPksB0/QSBjbR+YDa
         S9z/+lT1kSOpvPyjIcVWxvzh5UFY9QmDBZuSyVvw5xU/cdF65YsJqy24Kziz1oLOgKqb
         Z6mgH3w/29YCX18ODLnQjkhRxgwaRnnEWa+pEfBedJNu/3INrTtIIrOGhwGoCVtILGrw
         tO99HvFAcLkNtHO679jX/c/TeQDosCRxuDRgzyA9SMpZkP35WyymhC0qzA1shGY4bcuq
         Oarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097237; x=1759702037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fwMXkD1zXlvbev0t+QX7XXpwQW6fW06+yvTVni3PWY=;
        b=VqcPFJiwlGAenFjcZkcnoXb5836Ab54V7ntEWIhi/pt1v3d3rtWw1GQcgY+7DAEZ2q
         YPxQ04Tj5HDMpLiPDWNqWrCMbhWd6+h8qQktjvq64ixR3AQVGYBC0KxyeR4Kcz8YPKah
         9Sh9LsfP6p1LKyePV36MFUwISpanfpg4jNNz6ACOGoI24BBjwcVc0lwRKkdc3bgRP1sN
         VK918xq9EhDEjDkhxs0KyawQN3nRG30lQc1awpIuE9Ggrgvf1Y3dHvIa+LthRIndPtLX
         APjiA01RCvINiS8lCM8UAEgZAX8QyybgDeNU4qXFH3XIyKj6p9oiYpKdAE+dTxh0AgFL
         oBzw==
X-Gm-Message-State: AOJu0YyCjjakNf7lDVmNHhGTc8F99qAETx3nduuzq5Aa0jvGePP0+gGv
	9hHZypoCs1oVtQ5NYUqwSzhT63+rjhmKAekHr8U1bSR7jei7507hZJ+J5AN1GgJGK9zHqJws2Y6
	nTbbhGRA14w==
X-Gm-Gg: ASbGnctGOMjMBGPWV/A+sfZHuLf9w0gIYR5d5BWw1wsYQrGfjZADzrdEJby+bAtzxzk
	JC5K2VEFo7i8S5ASRQbzie+vUC+C8FCFxzTR7RK6qlpihLtiDp1olSD/Taz7A67udk9SI81MnSw
	ZCi0U1a7kr4wPJZk8ojoO43znmgvp679eDkz+TnN53DLGHSUpAln/l/ez7I+1pGVakKUttXkrrL
	8b5C8eMraUaQyQ+Mulxjv9A4zIZBlkL0NX9QHJSmoM6EeLa+6fKCTNZbz3UpojmU1UoFehMCF02
	pZ/4SrKnFWwvypTMtRTo3h6eoiklfRBmRTqs315Dl4FjTOQWIf13LcgKRBxMGUsafvMDAThaSem
	dB2/buBMujW1O+Z23JyFUVhtVV15/6GbENSiHl7QKmWbV2lAKMtzyfcqhmnWKnQgDL9OkP3CC7R
	hBCQSe+0KvRiistjpKn3Cwbg0sbA==
X-Google-Smtp-Source: AGHT+IEM6NBVgfFvxbI3iEyX83HR/uMt3w0v6TZMdFuLPwlw7B7rWJW0U3gNYHbP3lUnOSB8FfmQaA==
X-Received: by 2002:a05:690c:4c0e:b0:771:36c9:241e with SMTP id 00721157ae682-77136c9291fmr93978047b3.4.1759097236762;
        Sun, 28 Sep 2025 15:07:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765c7ac669fsm22661527b3.58.2025.09.28.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:16 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 01/49] builtin/repack.c: avoid "the_repository" in
 `cmd_repack()`
Message-ID: <aa03aea8ed3d18a48774857dda9630ce553bc66d.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Reduce builtin/repack.c's reliance on `the_repository` by using the
currently-UNUSED "repo" parameter within cmd_repack().

The following commits will continue to reduce the usage of
the_repository in other places within builtin/repack.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index e8730808c5..305782b2c9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1247,7 +1247,7 @@ static const char *find_pack_prefix(const char *packdir, const char *packtmp)
 int cmd_repack(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       struct repository *repo)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
@@ -1344,7 +1344,7 @@ int cmd_repack(int argc,
 
 	list_objects_filter_init(&po_args.filter_options);
 
-	repo_config(the_repository, repack_config, &cruft_po_args);
+	repo_config(repo, repack_config, &cruft_po_args);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
@@ -1354,7 +1354,7 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
-	if (delete_redundant && the_repository->repository_format_precious_objects)
+	if (delete_redundant && repo->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
 	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
@@ -1376,7 +1376,7 @@ int cmd_repack(int argc,
 		die(_(incremental_bitmap_conflict_error));
 
 	if (write_bitmaps && po_args.local &&
-	    odb_has_alternates(the_repository->objects)) {
+	    odb_has_alternates(repo->objects)) {
 		/*
 		 * When asked to do a local repack, but we have
 		 * packfiles that are inherited from an alternate, then
@@ -1391,7 +1391,8 @@ int cmd_repack(int argc,
 	if (write_midx && write_bitmaps) {
 		struct strbuf path = STRBUF_INIT;
 
-		strbuf_addf(&path, "%s/%s_XXXXXX", repo_get_object_directory(the_repository),
+		strbuf_addf(&path, "%s/%s_XXXXXX",
+			    repo_get_object_directory(repo),
 			    "bitmap-ref-tips");
 
 		refs_snapshot = xmks_tempfile(path.buf);
@@ -1400,7 +1401,7 @@ int cmd_repack(int argc,
 		strbuf_release(&path);
 	}
 
-	packdir = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
+	packdir = mkpathdup("%s/pack", repo_get_object_directory(repo));
 	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
@@ -1439,7 +1440,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--reflog");
 		strvec_push(&cmd.args, "--indexed-objects");
 	}
-	if (repo_has_promisor_remote(the_repository))
+	if (repo_has_promisor_remote(repo))
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
 	if (!write_midx) {
 		if (write_bitmaps > 0)
@@ -1535,7 +1536,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(the_repository->objects->sources))
+		if (!get_multi_pack_index(repo->objects->sources))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -1618,9 +1619,9 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
-	if (get_multi_pack_index(the_repository->objects->sources)) {
+	if (get_multi_pack_index(repo->objects->sources)) {
 		struct multi_pack_index *m =
-			get_multi_pack_index(the_repository->objects->sources);
+			get_multi_pack_index(repo->objects->sources);
 
 		ALLOC_ARRAY(midx_pack_names,
 			    m->num_packs + m->num_packs_in_base);
@@ -1631,7 +1632,7 @@ int cmd_repack(int argc,
 					xstrdup(m->pack_names[i]);
 	}
 
-	close_object_store(the_repository->objects);
+	close_object_store(repo->objects);
 
 	/*
 	 * Ok we have prepared all new packfiles.
@@ -1688,7 +1689,7 @@ int cmd_repack(int argc,
 			goto cleanup;
 	}
 
-	odb_reprepare(the_repository->objects);
+	odb_reprepare(repo->objects);
 
 	if (delete_redundant) {
 		int opts = 0;
@@ -1704,18 +1705,18 @@ int cmd_repack(int argc,
 		if (!keep_unreachable &&
 		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
 		     unpack_unreachable) &&
-		    is_repository_shallow(the_repository))
+		    is_repository_shallow(repo))
 			prune_shallow(PRUNE_QUICK);
 	}
 
 	if (run_update_server_info)
-		update_server_info(the_repository, 0);
+		update_server_info(repo, 0);
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(the_repository->objects->sources,
+		write_midx_file(repo->objects->sources,
 				NULL, NULL, flags);
 	}
 
-- 
2.51.0.243.g16eca91f2c0

