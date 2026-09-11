Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09248987C
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133274; cv=none; b=SlMcIW67FKkxLKUT67a/UtETt8ay3s7XCP0nlTHVty5xFMD399oNj4IxtWhZbZIqiG5ihzo6e6kb/9HUu8r2wt2WAqiINhtB57hx8/jT1QpXB9jVZfWwrEBQEfz1IUPmDMmsPYITv9k+d73lSzLfNSF1uH6vzg4NGRxVR1priDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133274; c=relaxed/simple;
	bh=qvivQxp5QuBlQvET1DgHzPZhNBV0YR1Cze8j/9JnnTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jruFdfL1xXHGVFLjNoRHQ+xC1A5QF4JlZ3+d+VDbcVtm+CUDq7eX2fg5bu6kmLJuv36KyxDoCuzjCN1DlYe8/kMmofSsGj9miEqCHFt1T+K43c0zWm+lkA2tXdT4MeG0Lvn5p5xBdXvJ3zQrkIk5PVHbDTrqlWUKS5dXSVkvy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tsfcdt3K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkVNciUw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tsfcdt3K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkVNciUw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 09DEEEC0237;
	Fri, 11 Sep 2026 09:27:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 09:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133272;
	 x=1789219672; bh=hcV0kfQYQ84uAiy04/gnaIdOY5BmVpcuyNMYqyocLTQ=; b=
	tsfcdt3KmqjGatgfZBnTakoYwM2Nnprg4MUSwWytonkHGjDSiPr5/K3UUw/Xwwu3
	s5XYSHXUGDWBOHz7PQQUd9ACtGjFIsuAZxXmW0wX5wPaopJ/1U28jFYjLGqASfAD
	/VjuYH++dE4ZHomsbEA3NMjr99Eoea7OsH7u9jQmt3dG7LGJsYjT75rXOxlQN+J3
	LrlYxyScG0Ngun2V8e4wOUD5bXe45WSunBxa7XkKbqrve0VqEIZ5+g2YC87qDVDj
	F04iplGF+Q2eUjRZjDhYRFMt2DaPMkFSM8vVwn2LPKpzJHZfqSx9ipJZYxiJ3WmO
	7UMRW8veqnC/7xg4d1zN8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133272; x=
	1789219672; bh=hcV0kfQYQ84uAiy04/gnaIdOY5BmVpcuyNMYqyocLTQ=; b=P
	kVNciUwkEfD/iX/6pnSSJ0AMsRathCfm1+HgvGw0n4yWvQxkI8dXz5gLVYQ4FaNv
	/E1/pFl9RNykz/HMd1BefHGMvZe2Y+u0zjBH89KlqFw4TRzOvCPLhjYHXiaWT22t
	oXRcFvv9vTMMZbk5Txd9Zdth/bUjc4FM4fewi+IJWpaYZRaxlcpVBxEBp8qQq1S6
	uYfvXJIn7J8ttfEQnru6u0t1cAxNjka/at9FWxaie+GunxJXbC3G61tePaj/xu8Q
	GR6s7eveD1MTbSxUseoqBIrKHTu3nv4xeFPgFCj9fFigl9P1KUHrUmTaaZrAF5Xt
	aThtBbtNcAesiFvyFwjSg==
X-ME-Sender: <xms:2AGkatnNB5eVvMqKdPMP0Z73_XuSZWk_nUEYj8wjIseMGnffmte8Nw>
    <xme:2AGkagSTIfWd7rfu5593krsnQAGuLeCwE_Y3nfiqGsZYMsFOE_lsZEc5GYiIIo1DB
    RkUcKob4vRXwbO6a26YCluW-ijZU640KFMxLi9PQWE65izfXuOn4V8>
X-ME-Received: <xmr:2AGkahA5j72fr4MUa9Snqrq82KIyiSGm34TuqMdtkwGt0rOKOZon8cqYa5uBVEqGuSS1zQ>
X-ME-Proxy-Cause: dmFkZTECg8xxBicj1DZS8ANPYnoLkr6WmqZgUjMjlEg+sGzWjqLplREE0ffvvHBmWPAecg
    q+c7PBkoqu7i3P61nG0ccczl9tex8wqN0uqAIqkscV+NqvEU3KnvXs7k+hFS/VwVVQQ43c
    A5FpjBpUNGQKkA3B3tIA+qB36AOfSLZGPRcOW25ujcTxgOzqUBQduBQyZOZe5kUxdKiaJp
    l/OBoFl3wHXALaR6wymfPNH4IY2Krzm00t/d2XCLL8Dy/KaES604yZutrFoJEyqnQ1FLf9
    Fn5HVsaR+LB9rj6EHr0E8SreONR8SbYOhAQ3KEI0o4NHBdJmhZ3EPoIyEYihr4bhpRbSbQ
    aXceAujcNOhIv+KWy56V/PFG0MUOf0PqZYl8kBjcMrEXHO3g7ojr+FJ1v8wcwwGj5QboBz
    bvTvHGmog/z+N4FBtIxsK9hvq42PxfC7YM2fjLc4ahSV5NMbb9HmBE9F31sX5tzQXHeqxI
    WolA1sXK4nFEpRYBiTuRdpRiZtUxF3kvYVMeIlXZGaQHjOEQviVsXOpEZQPPpQB7PIie6O
    fsLbap4dpd8n45tLigMXLw0X/ylRynenRZqnrpLeTcBLql5f+t91mKL9Q+Uj2udQyYJ/7y
    tuqz+D0H8w1VmTyWuddhw8MKlvdvtrMB9pSeOWIDpZjrtVGJRViqZHe6GkEw
X-ME-Proxy: <xmx:2AGkanQvysbU0G_16lnujj3GzGToZgbECFZLCgCy08LVy_8WYfW0mg>
    <xmx:2AGkavrnCQxHefdGPzgu7y0JVp_-yvCzvjUdXAcEUsQRI2J6m4aJ_w>
    <xmx:2AGkapziq7etgPMpKpv-AS8Jgf8X31z5tfHXs-Uk8VLNv0QMoHOp-Q>
    <xmx:2AGkakKuaj9zdubH3sRWmuMFxY6zncfhnCtmDvvbe8A2O6BiPEmwTA>
    <xmx:2AGkapqhD6ErBDLuYp6XLa8ksubMFReuofNJNmxePTzQR7tm3AW0Q7FZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f6a60a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:33 +0200
Subject: [PATCH v3 09/10] builtin/fsck: move multi-pack index verification
 into the packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-9-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The checks for multi-pack indexes are hosted in `cmd_fsck()` directly.
These checks are obviously specific to the "packed" backend.

Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
this means that we now properly honor both "--connectivity-only" and
"--no-full". Furthermore, we drop the dedicated `ERROR_MULTI_PACK_INDEX`
bit and instead use the generic `ERROR_OBJECT` bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c              | 18 ------------------
 odb/source-packed.c         | 27 +++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 13 +++++++++++++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2f7d29aa56..7eaea340b0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -48,7 +48,6 @@ static timestamp_t now;
 #define ERROR_REACHABLE 02
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
-#define ERROR_MULTI_PACK_INDEX 040
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -1085,23 +1084,6 @@ int cmd_fsck(int argc,
 		}
 	}
 
-	if (repo->settings.core_multi_pack_index) {
-		struct child_process midx_verify = CHILD_PROCESS_INIT;
-
-		for (source = repo->objects->sources; source; source = source->next) {
-			child_process_init(&midx_verify);
-			midx_verify.git_cmd = 1;
-			strvec_pushl(&midx_verify.args, "multi-pack-index",
-				     "verify", "--object-dir", source->path, NULL);
-			if (show_progress)
-				strvec_push(&midx_verify.args, "--progress");
-			else
-				strvec_push(&midx_verify.args, "--no-progress");
-			if (run_command(&midx_verify))
-				errors_found |= ERROR_MULTI_PACK_INDEX;
-		}
-	}
-
 	free_snapshot_refs(&snap);
 	return errors_found;
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 2b5dc502f5..9f54a5e83a 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -14,6 +14,7 @@
 #include "packfile.h"
 #include "pack-bitmap.h"
 #include "progress.h"
+#include "run-command.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
@@ -897,6 +898,29 @@ static int verify_reverse_indices(struct odb_source_packed *source,
 	return res;
 }
 
+static int verify_midx(struct odb_source_packed *source,
+		       struct odb_fsck_options *opts)
+{
+	struct child_process midx_verify = CHILD_PROCESS_INIT;
+
+	prepare_repo_settings(source->base.odb->repo);
+	if (!source->base.odb->repo->settings.core_multi_pack_index)
+		return 0;
+
+	child_process_init(&midx_verify);
+	midx_verify.git_cmd = 1;
+	strvec_pushl(&midx_verify.args, "multi-pack-index",
+		     "verify", "--object-dir", source->base.path, NULL);
+	if (opts->flags & ODB_FSCK_PROGRESS)
+		strvec_push(&midx_verify.args, "--progress");
+	else
+		strvec_push(&midx_verify.args, "--no-progress");
+	if (run_command(&midx_verify))
+		return -1;
+
+	return 0;
+}
+
 static int odb_source_packed_fsck(struct odb_source *source,
 				  struct odb_fsck_options *opts)
 {
@@ -912,6 +936,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
 	if (verify_bitmap_files(packed))
 		ret = -1;
 
+	if (verify_midx(packed, opts) < 0)
+		ret = -1;
+
 	return ret;
 }
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..20b010c33b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -573,6 +573,19 @@ test_expect_success 'verify incorrect checksum' '
 		$objdir "incorrect checksum"
 '
 
+test_expect_success 'git fsck --no-full checks multi-pack-index, --connectivity-only does not' '
+	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 10)) &&
+	corrupt_midx_and_verify $pos \
+		"\377\377\377\377\377\377\377\377\377\377" \
+		$objdir "incorrect checksum" &&
+
+	test_must_fail git fsck --no-full 2>err &&
+	test_grep "incorrect checksum" err &&
+
+	git fsck --connectivity-only 2>err &&
+	test_grep ! "incorrect checksum" err
+'
+
 test_expect_success 'setup for v1-specific fsck tests' '
 	git -c midx.version=1 multi-pack-index write
 '

-- 
2.55.0.1074.ge7621b4bad.dirty

