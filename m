Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74B4756B3
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275550; cv=none; b=eSkykp1Ue0iVnmc8w96fAM/w3jDl3MP5FPwCAPvRvuw9tnHK1SaCyndZb1mJYr94FxnKaV3fmCdAiXR65M0mDMO1IOWq1kY6BRNMC0oC8mXkiGDUK5zez3FKYNHq4l2zCReUcoHlPX8Daa/tpY43ECjxkoZbG+Ahvs9P9gmPfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275550; c=relaxed/simple;
	bh=LZgu80aGZOxOPivH+nARqr0SP40Zc6qrp8NC5SXhKmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIGY+mjOnjUSAY5ZAgyPsvnDwUpcN1rPgmnKYUeFJyA8sVPgC5KTY/JFHs2G6cqm+FnlfVSttm4BW1CcprN9XkXgHqcG5eycpzyGY0luFtN2tH6ZPkCKcpnK0S+0WGgo5E5pnMMwfSBV6Ar8lhwPgU6lHY9X/Nw+g6k/C6po4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UQJZgkWf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+MTqEXR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UQJZgkWf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+MTqEXR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A950D1D00149;
	Tue, 28 Jul 2026 17:52:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 28 Jul 2026 17:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785275547; x=
	1785361947; bh=eHk5rzm2r/610GyS6mkLrl+SZWMUYLGW53rK0oV9SzQ=; b=U
	QJZgkWfU9HKB5StjE6chZeQjlJd7QDL2H+L8ZHVF9YCTxuKoA1UOukLT+YiDJo81
	mE2aR8Tddol5qrfcvftexIoi4v1DYlMHTE8xP6WATNhQkLtTn3qornEOLq6eP6+x
	9SZqdHrvD9YH73iODWnSr9udurqrLE11bZrrXeHqZ43eI7nNGR7lLD8hpGlfLzSA
	TQnJqApqlK90KAa3eKUv819lM00wrJHqOLSsKa0N7/378HTV2VlRDm+rCC6vXcER
	i4p17VvfKsAWrOA9ZeXZZW7DjRNwMqoQjQgloKtq4Huc91EErbINvN7memWkc89h
	bFQLTdggr7eV5Ng18NfeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785275547; x=1785361947; bh=eHk5rzm2r/610GyS6mkLrl+SZWMU
	YLGW53rK0oV9SzQ=; b=a+MTqEXR9BGlB+cCq6sO/8x16g19WakUQlKJ+FuEvBCB
	7wK96rTPb3A3Rl1dCa3MhMxKW2zwZwZe0WziUghqz3Fa5NL6iZkeFYlolYOLJ9G5
	1y7eUb5D4UlduRRhCs0HB33Ml1p2rVK8V1xo3TH+XZ+gCHpE/Tt/JsYhLfwAz4OO
	haqhSNz20yXo0cgeHrCMQG1GsdLtX+i5ObnNWxEoVnvqGVIkhrM4fbW9MhpQJeIi
	BP39FWkwA2M0lkjR+Zl6opDB+oihxT2YFNwzgl3fBiwuqdhg+Ft0ZMrXEidU8tfU
	q8Jj6OKWujBrn5M02ICgLxrab1k0pE109cXwzRAOPQ==
X-ME-Sender: <xms:myRpauosh7kVYV07F_YgCiIFbAMDMraw7Nf3-X1vTgmpurRjVMClbQ>
    <xme:myRpair7M52dTqlGqar9R681d_BVoPRaTUqYDArfZ45_XVfM7FCPe1fGVCQN5BOf8
    -hI4NL6FKITeAQe2UQbYNsW2EuvHabUh272UrVMkntnXPnAuoPxnQ>
X-ME-Received: <xmr:myRpag2jys36XTWhCwIRkBnvyL_SIrBUuzs-4AO54YXIJixcyHMJGzVnaQgUccxjvkxdnDPgt2DXCPt0f7JFlQHS93uRAA71Xw>
X-ME-Proxy-Cause: dmFkZTFJ3B0lfd/c5BUcIK91mUYRgsN/tAgPTwSNjGI7153nfeszh1y2BIUqFotNEVsSzN
    H97AQOvf5SZLiQ6YEcSvMn1dRiPXaWJ94nO6mvNaqSMCpz3d2IPU3cPb+sh8mzDeZnTzaG
    0lRvViS9tvohxCNZFcxj6dNFpROXErihSqjAQCvl3tpOtVjMOt7zYjaZH4VtTx1fro5cBs
    nPvkfxNPpxz288kGK1MMnZrogzbGPM/Tm7Nft62wH0/3LtjIsKE2erW00Qkn2cYRH7Pxxg
    r9gdJ5ngvlJtNuBv7cb4Pf2JkNDcxDwptmJZMvak4XyN4USsoLIA7x8zDRwfIE0ULC0+jw
    aoGapHk3n9tR/QcXE+0ZXGIumsQ5/QS0cEz3jzxkXU6Bv2TBZRLLXrNzeIV/VmSCRbIgZJ
    5JoTauK8gpGG6EhrI8sNz95/QAcEj4ZWEW1TbH+BCYDj+S2TXoy/pGc5hKphuIQ//nSHSd
    MkyavVGdeejxhvnDj/l1ri8BaL270iUlePPziaQ8VDL98ZWXTAqgmjfHKgPQpYrN01hmog
    ZN/l8m7QQQqNb7lZPkFp2nxI1lH+rIz9jEZ5Z7wrnhyKvDiy3ututrVLXeSww8qk6nG32N
    wLx5rvQhSQlMg9NRcZrMOqhZdZEvTtpO/j5EqeM3KlGPmuzpoFyZTb9XH8UA
X-ME-Proxy: <xmx:myRpapBjm2vKrFzVQVdeT0vVgL1OXr93qrKm-V2xl0xesApXGwOlaA>
    <xmx:myRpagdCI_8COHRJaX5p0LIeCnrdeFBwt8TKQMSUkO7sf9yykdVlrw>
    <xmx:myRpamhSYd0RhtLSLouFQj0Xo_n_xdLqfrzy25btCwqlX_Re6kS4Zg>
    <xmx:myRpago57rWeJf3aOditlDFHR3__En27xipj38N90u08aQnSHTAHtg>
    <xmx:myRpaiD4luul7A9_voEaIlsifgM45o0vzsUXNckbkumvdvvOl3jymRIP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 17:52:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/4] read-cache: reindent
Date: Tue, 28 Jul 2026 14:52:19 -0700
Message-ID: <20260728215219.753678-5-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-594-g42d2bf033e
In-Reply-To: <20260728215219.753678-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
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
index 6fbab77225..ad77c0d5e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3924,32 +3924,33 @@ static int fix_unmerged_status(struct diff_filepair *p,
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
@@ -3963,28 +3964,29 @@ static int skip_submodule(const char *path,
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
@@ -3994,7 +3996,7 @@ static void update_callback(struct diff_queue_struct *q,
 		const char *path = p->one->path;
 
 		if (!data->include_sparse &&
-			!path_in_sparse_checkout(path, data->index))
+		    !path_in_sparse_checkout(path, data->index))
 			continue;
 
 		switch (fix_unmerged_status(p, data)) {
@@ -4003,8 +4005,8 @@ static void update_callback(struct diff_queue_struct *q,
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
2.55.0-594-g42d2bf033e

