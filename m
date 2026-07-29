Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC641C5F1B
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345930; cv=none; b=Vp6FhS6CvOfg0rsrDfvBUYKKmmQgdnsdAMl8CNPmdeWKpTNDkHI1E+4zxiyymPXV8Vqw91FtKrj0mEHWQM9lGv8BWuBhjY2/U7cKHeVA4EueeMP5pFQTQuQC+CXNzR8fsUajVt0VaUx1Ahhrl8qEEo+iF5TKxxZgtVR49CkwjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345930; c=relaxed/simple;
	bh=nARRT/Du9jK3z+sHp5INAuFsk7C55bbXPTje+04dwvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7HbXksWurVTAOqdqYo1++RKvzZlk1xMVDsyNW1HLxde6nEMfSzl6Mb0l7cTvv5W+HWOB69MnH7WVCBw7BuHcMkmXaQjLhVMFp8KtldSJAKvVZmZGbL9rFYw8uZxtiINOvdSHIFrGO71q34K7eOt9z0YfnG8X8Vqq1JAWCghnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nuRIIron; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFMIhXrq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nuRIIron";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFMIhXrq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A71771D00056;
	Wed, 29 Jul 2026 13:25:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jul 2026 13:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785345927; x=
	1785432327; bh=nN4mVv1INZdsaS3jNVFOlRBlx90P4hBrgQqzA614coc=; b=n
	uRIIronJuhLDppyaRB3Vb533F1I9onseEqnUV7vkRvFli679IR/QXYxKSmQdozJZ
	qm8trDwlzGsAs7WvFy9vZVMGfCWXhx2qHRkB1wuaTTdHhgaNOdDXKlz0LV8mxeeO
	IL2scL3UMOKyxR4ZocuvHexQ239sKiRc7ZuCk9Hal6wGmCmMEEow5MGqwJXGKum3
	g5fFZCSwBf2AnJpqiRn6JzgVrbWoShy7U/QyhiGzM5td2Um0pWckPlItsy5g0oCZ
	j44aoGv4yJGnUgdiy6iVJLK5HAf6FchghWk7ASbo6FVECzUxt6Qn+oj0aq+OaoIS
	p+aqavnpSIvZqcqMvC2ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785345927; x=1785432327; bh=nN4mVv1INZdsaS3jNVFOlRBlx90P
	4hBrgQqzA614coc=; b=RFMIhXrqG0asp9KULjPpHem1uAvb4v8P5U4aYY/I17/3
	NsLYfmSzlXKWbopiTUbyK7OX3sn8abl2x3yppAIFwWjasl81GEMlYwXNRClrUZTb
	nvefG8/uEnqAtL4Kd5gjottGSSNK+AvzDvZQl4ne7N/QNDigjz8XVBetn6wbgWyL
	eiAKX7G+ZlI15cBuO0/hQRvwkTadu2iOsrW5HZj9Ok2zhYBhxRrFzv+KZI845jQB
	9TNhzCeWmw9ClJt35+fRT2mZGYYi54mG68Pw1tONTlJjtPFQqvRJrAwscyRQmZrP
	p7uMwBlcSi0Z+2OGOgKT2SbDUPKdCaxUcYFPIrDXqg==
X-ME-Sender: <xms:hzdqaiMwzXTjOX3rqTQH6HAs3CarjRZwWtt2QV8lbvg0AdP1bqWarQ>
    <xme:hzdqam-QdKcHnhvYxRkLVY5NqrmMylAAJL1pBrqCdFPUPauz_zz-EZP09SM0OqCIa
    tHsV_RfyOnetebsgjXbJbwCJ8rAnpZ9xqONFUaso8YljBOzrBGI4Q>
X-ME-Received: <xmr:hzdqam4vAqOp4ACpCC00otVmhX-AjoFhUjuvG3BzdEq4uLiErqZUAQrBzudBHbLhVHZEiaQXtH5VjoMBSG94sawcmfuxwogh5A>
X-ME-Proxy-Cause: dmFkZTGGjC09EifXiIGPzrhr12+xwP6qu/lo6FbJgfr+7e0F7A1od6yx+pyTl3GBSGeaUB
    kwsASOtzOqZcbLqHtvNLniBQ0s0du0m2BAtXxMZV8nqg5DKZkEzNisHHMXDmM3pfBxANKb
    IimaNrT3pUSHHr+oQdd2w1E2wofmj+erswEhZEXIf0h0cLf6bpXjLzAI02hOZE5NmoU/5w
    0TN83FvqLiJZWeo/z/wEWLVoz2J50c7GiOEQYqY9xbz4GrKNb9oHNnyK8MSGq3IuAtexZO
    nWsuRbwjXe5Kh/99zkcS8HhCkxtSi+O9wwgpErdE+EKBJA6YHG8jPRTac3p0YlJB+OCNUi
    VQDaQdeZ8ktwq4UtjHva8bKz1PMnMQaNkHPblzuufx2J17ZdOO8pagn1rtUb0/LPS4l/8u
    s0eyfLpAQQ+3MCXS6gLWBonTaJfnBa01vim15wdSXHCu0i2Pp/V6aQa7ZZyo/b2i0rCeuf
    BkLoRkst5fsBX4/P7elHqdi7FdNlHEmZyff9FPANTGadazS4UD6Dr4TckLbUcnP3VZ21rT
    fCLp+uU6ZdIZbqpU/JPNwSynEBX9TmpW6Qeg/WXA6lTBLeIo8lj3WiEKeqFLrgRXRsBQ2e
    QaX/d87ZEH5/02sWhNT/38wlb5u6F+ej8sd2EP8z4I/i5bw2tOB2WcToeN0g
X-ME-Proxy: <xmx:hzdqat1OzaOKRS5fuTwttT5dL6e4JFi5Bbs8eByerevKbtXdyEazbA>
    <xmx:hzdqatCfx3bEiyWqm_zWgr_6CO0MK4Em5_a0_mwK5vMx7jqiqycSMg>
    <xmx:hzdqav3W6z1RvulV-Fi9SFchYFniAUNYCOvz-OiMghDxVObR4bUvbw>
    <xmx:hzdqanuKYrOc30Bawg0JL8DOBPLvE6D3tmkt_NOIi5qHoYl2O-ylhw>
    <xmx:hzdqatkL5LeJLFZ3bsmLjUVxnAcC_1CvGxd05nxuFZHG8DeMNnfuMSaB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:25:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/4] read-cache: reindent
Date: Wed, 29 Jul 2026 10:25:21 -0700
Message-ID: <20260729172524.4022621-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-609-g9a17695db7
In-Reply-To: <20260729172524.4022621-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260729172524.4022621-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I do not know how this happened without anybody noticing, but a few
months ago we added a16c4a245a (read-cache: submodule add need
--force given ignore=all configuration, 2026-02-06), and almost all
lines the patch added were incorrectly indented.

Reindent these lines so that they play better with surrounding lines
in the same file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 70 +++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 38b55323dd..58c378414a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3910,32 +3910,33 @@ static int fix_unmerged_status(struct diff_filepair *p,
 }
 
 static int skip_submodule(const char *path,
-						struct repository *repo,
-						struct pathspec *pathspec,
-						int ignored_too)
-{
-    struct stat st;
-    const struct submodule *sub;
-    int pathspec_matches = 0;
-    int ps_i;
-    char *norm_pathspec = NULL;
-
-    /* Only consider if path is a directory */
-    if (lstat(path, &st) || !S_ISDIR(st.st_mode))
+			  struct repository *repo,
+			  struct pathspec *pathspec,
+			  int ignored_too)
+{
+	struct stat st;
+	const struct submodule *sub;
+	int pathspec_matches = 0;
+	int ps_i;
+	char *norm_pathspec = NULL;
+
+	/* Only consider if path is a directory */
+	if (lstat(path, &st) || !S_ISDIR(st.st_mode))
 		return 0;
 
-    /* Check if it's a submodule with ignore=all */
-    sub = submodule_from_path(repo, null_oid(the_hash_algo), path);
-    if (!sub || !sub->name || !sub->ignore || strcmp(sub->ignore, "all"))
+	/* Check if it's a submodule with ignore=all */
+	sub = submodule_from_path(repo, null_oid(the_hash_algo), path);
+	if (!sub || !sub->name || !sub->ignore || strcmp(sub->ignore, "all"))
 		return 0;
 
-    trace_printf("ignore=all: %s\n", path);
-    trace_printf("pathspec %s\n", (pathspec && pathspec->nr)
-									? "has pathspec"
-									: "no pathspec");
+	trace_printf("ignore=all: %s\n", path);
+	trace_printf("pathspec %s\n",
+		     ((pathspec && pathspec->nr)
+		      ? "has pathspec"
+		      : "no pathspec"));
 
-    /* Check if submodule path is explicitly mentioned in pathspec */
-    if (pathspec) {
+	/* Check if submodule path is explicitly mentioned in pathspec */
+	if (pathspec) {
 		for (ps_i = 0; ps_i < pathspec->nr; ps_i++) {
 			const char *m = pathspec->items[ps_i].match;
 			if (!m)
@@ -3949,28 +3950,29 @@ static int skip_submodule(const char *path,
 			}
 			FREE_AND_NULL(norm_pathspec);
 		}
-    }
+	}
 
-    /* If explicitly matched and forced, allow adding */
-    if (pathspec_matches) {
+	/* If explicitly matched and forced, allow adding */
+	if (pathspec_matches) {
 		if (ignored_too && ignored_too > 0) {
 			trace_printf("Add submodule due to --force: %s\n", path);
 			return 0;
 		} else {
 			advise_if_enabled(ADVICE_ADD_IGNORED_FILE,
-				_("Skipping submodule due to ignore=all: %s\n"
-					"Use --force if you really want to add the submodule."), path);
+				  _("Skipping submodule due to ignore=all: %s\n"
+				    "Use --force if you really want to "
+				    "add the submodule."), path);
 			return 1;
 		}
-    }
+	}
 
-    /* No explicit pathspec match -> skip silently */
-    trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
-    return 1;
+	/* No explicit pathspec match -> skip silently */
+	trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
+	return 1;
 }
 
 static void update_callback(struct diff_queue_struct *q,
-							struct diff_options *opt UNUSED, void *cbdata)
+			    struct diff_options *opt UNUSED, void *cbdata)
 {
 	int i;
 	struct update_callback_data *data = cbdata;
@@ -3980,7 +3982,7 @@ static void update_callback(struct diff_queue_struct *q,
 		const char *path = p->one->path;
 
 		if (!data->include_sparse &&
-			!path_in_sparse_checkout(path, data->index))
+		    !path_in_sparse_checkout(path, data->index))
 			continue;
 
 		switch (fix_unmerged_status(p, data)) {
@@ -3989,8 +3991,8 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (skip_submodule(path, data->repo,
-								data->pathspec,
-								data->ignored_too))
+					   data->pathspec,
+					   data->ignored_too))
 				continue;
 
 			if (add_file_to_index(data->index, path, data->flags)) {
-- 
2.55.0-609-g9a17695db7

