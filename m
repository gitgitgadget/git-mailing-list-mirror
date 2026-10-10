Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BE344D92
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791653084; cv=none; b=CZrB/ZHd6rFuEnfxl8W6OGxD6Nkdy/R5qvWwZTPuiZw3j1lQ7GGCsrotvHoADGx+1n/gnrL6bYax/oRrs1P79zLZ1YBxVchXQbmRvqIjwvq9vvENyiHoy5ANEYDmuYSL5OK6/2rjuZjXvmQ1JWRLiYWE+2+9ZKz/dkH8v/rmIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791653084; c=relaxed/simple;
	bh=9XO0z8u9rQt74yE8xUvTJrswCNpcQZtWej7XyyyWFKI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dFauZNTjC9pHMYGJDJ3cSd4kSAekIjwlGZfqgndzMCZAByR966baQFQ7NFrucTTzC3UoW+id+zPJkmqkE9bFMaTlMMzP0qwMwuz6GDFOZywPLOq3PQpPS8bZH3i9SUabhDvOukOiMWG84otaqIQ7sUqw+z+AYTpySXqVilwdKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjAtx0ww; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjAtx0ww"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f699fe49b3so640256b6e.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791653082; x=1792257882; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6A1LApuOCagUAOf1Bmpy4XsRUnNrzoYz6F6XH7YsuIo=;
        b=gjAtx0ww7erOm4Mpwjma864WJ3T06yaqwN9uV2nIu3PmWV76vAxJKpCtZapdDxxqhC
         jSY5Dfu0ukG/BSWKyI5fLk6WZDDC0NCaJFWjjcdLc111UwSWgdalklMyfppcu7kAQC25
         ZcX5CEjfcM9PryqNEp6PL2s00GXzoibezgdxVz2nbhvBIyfLBQKBhiZ+J872g8KMtwIm
         tpbQmlivb8xRufmxa6pNJ53mubWn/z12c0ouCfHA2iQvapkEI5q7aFojvD46mjQaXr3w
         DGTK0tX18UWrR4EbqKoMqvXXTnFf1QgbvkyXTW2Ezcn1qaEJnSKJMgRI3WT6IhmItajM
         x7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791653082; x=1792257882;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6A1LApuOCagUAOf1Bmpy4XsRUnNrzoYz6F6XH7YsuIo=;
        b=XYtMdkVQRzp0Van0lLVx3huLyupzNUsfWwCyUPG6u7zCk3kiN+RzzcOAS3QndDYoU2
         XsjlLZSOJ77hrX++w9aCM9RxlDHh3yRLbcQXOohpuoCuvpj3+IfP/nh8gFTVsv1iAy1Y
         uHCikC+FxayyDhhN5419gp1+bcBls2cD4faZufvMjD5OI7HyOWqRdgxk3Wx8uxU6eXM7
         VveH7swTP49KN4CmxbYl+Yi0N67dJ9mYK5b3PAS6YUwTVH6lPzhOfq56mz8hJBGPFNOb
         1DHM8zdsBKAeP9NQqLheXxIQ46+XM3KVMYqCLer2ISpN3EbNoXCRl5MinxWL2ltH3PaZ
         u02Q==
X-Gm-Message-State: AFq9FYIZN2dSM9YLy99ekD69KtNxnXBnigi7AJiZJUQjPFui2dOUWZsQ
	TATrZUOBRi0C429R1/XfV/VTtpTORuBzwo2zllgRYtm+XdxJIbUAroYs40VtchJIuAs=
X-Gm-Gg: AYBFou0hfvf6nIAtfjzIztBlodcSiUTdUR1bMS1BAhWOLmaKoO7jvYfps79wds9K3au
	cOZZ7AQM/SzQ8ECHJQSPRZxhSsgysWVf0jpDx6v4fhe8JbIQoJVI8adecGCt0hjylCEdULjCXfB
	bl+LQVdKyNd9FKrwmVJyiypZkyNCKSAwssMJAQ628olBebXR7CBa+XCJtue+eQ8oPdYltm4LEZC
	zoL7czl0vPipFd0ppoOV7rklMO635gjNDESLGVL6U8UxmcDVZfktBeMUqjsu70fZscsI15LZK/H
	vkEPXpwKINRGH6NJNrijZ8ahuDg6FTIJePnrUS/sIWh32wtlqQBQa+J4AKpGV+L89bfyeiq78ry
	DcjGOS8H49nmEvIi1EiCRRiDi7OdRv1ZPP6t2p8KJ/ehh60GKzRD8w7zyzJBdiMv2Wj3PBjNE1I
	KGQrc7XB0TEtm2CsC5i0tfrQ1ypAwGhBaZJyfDf7tMvFUHMbeCBW01ajVohr+t1mU6TzVcDiNWv
	A==
X-Received: by 2002:a05:6808:c1a9:b0:4f1:a873:6efc with SMTP id 5614622812f47-50c5759799amr4390489b6e.64.1791653081797;
        Sat, 10 Oct 2026 10:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([158.23.147.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c0248fbsm5784182b6e.15.2026.10.10.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 10:24:40 -0700 (PDT)
Message-Id: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 17:24:38 +0000
Subject: [PATCH] fast-import: fix lookup for new commits
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Marc Becker <becm@gmx.de>,
    Marc Becker <becm@gmx.de>

From: Marc Becker <becm@gmx.de>

Queries for commits created during the same 'git fast-import'  session
result in a crash:
    < reset refs/heads/newbranch
    < from <new-commit-oid>
    > fatal: not a valid commit: <new-commit-oid>

Getting file content for commit has no issue (working implementation):
    < ls <new-commit-oid> file-in-new-commit.txt
    > {file content}

During import, new objects may not (yet) be reachable via the ODB layer.
Try to resolve requested tag/commit via object cache first
to avoid crash and (eventually) improve lookup speed.

Signed-off-by: Marc Becker <becm@gmx.de>
---
    fast-import: fix lookup for new commits

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2252%2Fbecm%2Ffix-fast-import-commit-from-existing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2252/becm/fix-fast-import-commit-from-existing-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2252

 builtin/fast-import.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fbd919982c..4b93148551 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -292,6 +292,8 @@ static void fast_import_state_init(struct fast_import_state *state,
 	state->option = option;
 }
 
+static struct object_entry *dereference(struct object_entry *oe, struct object_id *oid);
+
 static void parse_argv(struct fast_import_state *state);
 static void parse_get_mark(struct fast_import_state *state, const char *p);
 static void parse_cat_blob(struct fast_import_state *state, const char *p);
@@ -2658,12 +2660,20 @@ static void parse_from_existing(struct branch *b)
 		oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
 	} else {
 		unsigned long size;
-		size_t size_st = 0;
 		char *buf;
+		struct object_entry *e = find_object(&b->oid);
 
-		buf = odb_read_object_peeled(the_repository->objects, &b->oid,
-					     OBJ_COMMIT, &size_st, &b->oid);
-		size = cast_size_t_to_ulong(size_st);
+		while (e && e->type == OBJ_TAG)
+			e = dereference(e, &b->oid);
+
+		if (e && e->type == OBJ_COMMIT && e->pack_id != MAX_PACK_ID) {
+			buf = gfi_unpack_entry(e, &size);
+		} else {
+			size_t size_st = 0;
+			buf = odb_read_object_peeled(the_repository->objects, &b->oid,
+						     OBJ_COMMIT, &size_st, &b->oid);
+			size = cast_size_t_to_ulong(size_st);
+		}
 		parse_from_commit(b, buf, size);
 		free(buf);
 	}

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
