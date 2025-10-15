Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20403306D3E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567242; cv=none; b=iUiqc5zE6AXVUCp/1ttdSpTNoufxCJpmHz4bN5LP23E8TJ5VnT90MOXm457WQlGWkTMkDxR+PJesbI7rOgHfcroh90Pf3NqXj7WWn0NznBFNl4geZ+S+LvELcWJ4b6EKd+UFBZ3ruNKg14katvlBWRunR+QtlfWMq5y+ZIcHuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567242; c=relaxed/simple;
	bh=LIntDsIIDT9s/CSCkKsOomwDLP7iE284+h01I5OLDvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7KxF5kRHNbkt6pjy3eSAu51AYXM6tDMM5leTPFh51PBGAEsEyJhV02uAf7E4AlklWUWafi44hXs3GTLlo6LGGAIponOnCgl41Gq+QkQOcW6QLprBF0KsLCkJfpoIoaBHn7/7YfKlcLKKyabupp9GdrLv9855FGGYh5zhJa+hnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mbOkRiHc; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mbOkRiHc"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-780fe73e337so1036497b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567240; x=1761172040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvib4/C29VT6ge1RO8BjFQDkq5S03y7zcj+ag+rmIRc=;
        b=mbOkRiHc11Vt7XEAZLsLvwK0uVqFLJPo9dXjY5uLrNlT1VcVDUoPwQdN1CPsddQFvR
         n1zh+5Mw9mwPZoQcVmTX2FO8rO+pBKh5wfQiiQqO+yywmfqv9Zs+6Z8xDluex9ueRGw+
         5/j/4WNtdOHu+kGYhxh251YcDBy53EzCTrA+363LInevwyPloPSaQ59sXcXbRZLfB4+x
         UUpiqLacbR4gYy912cm0UPEqGlurgMpoAdxjEHOIq+OkH4XFpgRMFPDRr15lhy9ymDxF
         XCXfY3+vIu8zpdXBu9j/OhM78a1I1S082GI17Qd15O7j0A6iQ1yMKISV1YfVvI7MF015
         F4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567240; x=1761172040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvib4/C29VT6ge1RO8BjFQDkq5S03y7zcj+ag+rmIRc=;
        b=l8WwoaSOTGEXrgKWkErRKOgiOPKYFKsgq4XU034Dsuzs9AZTHfwmwYDXbQPz8EaPXa
         RD6TKEhwMIgLI6C1bqeP/X9GsnBPgVcnAjCHxm6wvJQpWH5VFNvJoTbCfIXMfiXqOLhE
         AiBdwau2srR7jtYqlqf8pjCwUDAwQJlGsGyQv9oW4LhvN57CRKtM4QsgEJ4Yq9wmSUd2
         piYnfAfRIBtb4YtiIGVx58W9EUvmxwpoZCIxwlofsuOa5ImFBm+ttgAD/aCR32yyS8Wz
         6KyxVqXJ/hPzfGiJKwYJhyyzK+PISzjNzpYO961aWIr0ZNyOk4UInhFTs8z2813YKKxu
         MWWQ==
X-Gm-Message-State: AOJu0YxmreiXNyBsijAlH2cyfG2a9L2uP/p3gL2eIMKPQ5/UuQNSNeOK
	RWdXr6za8jv5s808l13NbYwgW0f8QN9rNPG1c6ANJEtrnUQr6xPbOhTi66pb9vjDyoOFqk34Q8g
	W1PH4Iyc1bg==
X-Gm-Gg: ASbGncs5VXRpp7wSkVMump6Ok3V7ef832GbRDcYWj7LRTZ8oL/3acZIt/UzDU76I9vf
	DlPXycuCZ4RLJtmmXz2D0xJ1+ncqX6/cVPF7+DdezmhUAi95sywpNh4uNRU/1lfgTmh2XxSZwz9
	SEhspNsUA84l5jLZ1edNwYc2FZ0F7gLe62M4pl/VLGswfv4AEO5BdgQw4sXdlOS6xf84PIQFKau
	uB4Rd9Q7ztxngIkkS/6h++2pj3Zwx2daUdbS+keXpDVMoVXtpiSwUaOqL/Q6bb0AO67of7J8bXf
	/6hg+/JB9VR+rjpujtoFuGKZKfrLYvpSDsapp5vO8R4wgIWXhrMgtFrphsBEnl6A1HdPXtnKTAT
	C26VpXUU21wZXETTSe5661qTPAs+t1pfCt40EWcCQwVGWIh3ZhMoeVllAQFG3+C2dkncDU5LbuR
	c1ncrr8XS43AfsNJZ4NdgXF7BA5f8MhPj7c21h7Xj1Y/K0/9SsVDvDUdFTpCqcrFPcJAM9L7EFG
	lYH5aMSNeRy6mUXiw==
X-Google-Smtp-Source: AGHT+IHBFmLSc82n3U9IX5hSxb09qzST300YcHPacNP//72DzsH9kN1tCydgRPCUU4yPlPKiAPLPuw==
X-Received: by 2002:a05:690c:4b06:b0:782:9c7b:d969 with SMTP id 00721157ae682-7829c7bfe92mr10758467b3.28.1760567239807;
        Wed, 15 Oct 2025 15:27:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c12888sm2601807b3.31.2025.10.15.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:19 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/49] builtin/repack.c: avoid "the_repository" in
 `cmd_repack()`
Message-ID: <fc2b686c49f581500e17209a40448671031a7f02.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

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
2.51.0.540.ga7423965ad8

