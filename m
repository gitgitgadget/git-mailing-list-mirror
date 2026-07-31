Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8454246762
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502571; cv=none; b=QO8M+eFFt1f1V9DuieeFfucGB0e+/LVEUFHDwBRfKMS+dAAMkow3EB7Ufpt+7/7A65fR1VuA3byf7nEkc6fhUk9xI5XwXwV+ubTAEfx3tk544sIE815Z5Smy8qqJkDLxpJSmEV2ZEbM3gncoGIBtPnXg9dlNORPN7sRjAPJixLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502571; c=relaxed/simple;
	bh=1MgITTJvRNeIbrlNNvp3lbgNpbC3F9cX5IICK5qzre0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9O7gwyJrb7M+3WrYmPG3hYxG15hhqSkLwO62NYs/2M4KV2DF6+VWz7NHKxloLeSiG40M3xLCyfu5U8MbKwPOIhxek82OaVixB5C1hPxfN8E7T97/DYwkDw+2C/khqOsn6+u5lYerxhTpIueVOOIO6OPmlonzQNtTjcX7DX8C/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XRStsGP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fm7dDVWu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XRStsGP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fm7dDVWu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17391140013C;
	Fri, 31 Jul 2026 08:56:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jul 2026 08:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785502569; x=
	1785588969; bh=iizRhslNuOccyU8PLqG52x+ytQ++6xB4bsqSDuvXbso=; b=X
	RStsGP2M18l1sUPQRBr0vBIpfwniV/eK11AvjdUsHKR6MAf+BWlQTXFwujENRyu4
	1h5ulhq/pfyroK0/NkwHzGte+4C2ZrXzY0Iu+r29VlHpTBCki+Tlbd2i3pfwGAS8
	2UTQnG1M1I6X035zocdK8H8MNwtGDDdH1JcobORxUi9awlvM14CZyGyk3ydZnFAg
	OI41aGTHNGm+KEK6HwWQScRDBVMEJNYSmQ0ZHuEOoQeQfxf5R28+DUPqEVMhrA1E
	YEjQPbLs28wAeCuEzLToLVqldFhEuchAhgD3YFeJ0+D4Lu/oMcmMndKblKM+rIM5
	zYibWwWG2DbGdMizpF82w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785502569; x=1785588969; bh=iizRhslNuOccyU8PLqG52x+ytQ++
	6xB4bsqSDuvXbso=; b=fm7dDVWuoXUOnhnXcHrDcBA8WzUxHZojmUjBUcriXK2+
	z4lM8/deqq/VSApdZrA7k02JK5BOoRM5fuW5Fsd0auA85fC06GXwSJGGjanhvdeD
	7sqEHKr+hZM3P3ycMAXHEX8oE5UpsJwj8J/ZMQuDUcTZsLgqthw61pPE1cVMW+XN
	AFQNKwBvKyZtZWhgyaCAIjOukpvOyH1D2/0eCesdbB8e+COWaIDUjoDuzvPGvN+k
	iheH2J5B15J03l60SgPaBIkN0pwRcq8X/3xlprrLeyKVq+g9TRspiADKPaLVUNrh
	eTMGmD31+gqNORsbqhsPJ7Z/t3X8gNULAD4GhmMWIw==
X-ME-Sender: <xms:aJtsaguNuImL58zA-1pTcIHFPg7umD0W0EBI_IhyMKzK-LDmVcJJ5Q>
    <xme:aJtsajePA9s6MRvHRZA29oyvSnCfLhhuldUgBIke6SSiRaOdmIAbqZsExKveGp_Ze
    pLyVs8LaIwH-mPUgC5FjY-LFCZOMzj3wpcU8i8-4Ldy2uwU5vWbnw>
X-ME-Received: <xmr:aJtsapZaLGAsn3Ik_2lWrGiQu8luW9tqJXcqxhjKi64bptuygGjuOYlJ9Ytq2SY5PLa3afysUJdoDzjRqYexlZSPlJoywGqQ5w>
X-ME-Proxy-Cause: dmFkZTECLFSpYtsUSb9UV01HiSesFA7T2eEiuGx0P1+UTioG+GHriqOCN+kKKOgfr3G+a6
    Faof1aDihWGmz2Agcrx8h1GOMx3YcKWVicIANjX5ebF5hWo6sZNk2Yek0hvjlMeNH45MlA
    vGPumDDSXEaxrVc4vSOse+MVecP4cw4pBMvrq2RKDJ7scs7EDRcKVzAqnXMmNs5Y/FNcU1
    e+R0NrUD3ppsm4YSX/XV2Cp0HXb+NPn1gUuyJ6jErjurNInygzR6SZq1Np88hsjW3Op9GZ
    CR+cWyzYVrsep1SzF+SxUZK765C9QgyJpz6vxfPlvK0Hn1DsN39ajxYHD5NiySa0pbqNWH
    Dg7UD1kioK+gEpJFi7rj6LiL4NTnvhZ+9GFwtsGx+PK8jhi3/3CUZLEbsTScUcS9ir+C7n
    Q/dI0YsOPsZnlMYNwHwbJsBBnlJUQ/jQHg7m3YWzU8Hsb0b7TiKD6Xwvs5E7GZvb8LHjz/
    sNkpslXH+0E0N74zQeaZ9WmF5QWxMCzRMhW0kdmFr7zaR/cO2xgqtH9Ogfp6tVBEixwPsk
    3MYLgYfqs/2a9rOCA2xYIjIEKESstmdzwFM6Mb5nBuReZDhsl7QuCpGFv8Hmm6AuTJ7E9f
    KiIfp8ZbqjUCjgwyrnmVif7MBSchwL6v40pESCDei/RKkisEVnWeNwmPacNg
X-ME-Proxy: <xmx:aJtsauWeZ4oBBUXv3TGWAR3yeMYInms-FNy5CRn5Hg6pB2ncxiqqpA>
    <xmx:aZtsajjjwgEr_IE9JeR14Ouv1TtoJ9EKk1iIy8owkIOShvMDUzg4jA>
    <xmx:aZtsakX6Vn2p6oVd7G7L6rTfVgF1exClydJAym6yGwL-goOayphnXw>
    <xmx:aZtsaiNAE-yDycyX867rMnj41H0bsua0MECw2aI455GAfjcAcQ6Q_A>
    <xmx:aZtsasH8h7g6Y1chQqplj-npkDMlCIie7VrCl8OQgMGQdqQyuc7KMnAu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 08:56:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 1/4] read-cache: reindent
Date: Fri, 31 Jul 2026 05:56:02 -0700
Message-ID: <20260731125605.3638938-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-599-g5cacd2ad51
In-Reply-To: <20260731125605.3638938-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260731125605.3638938-1-gitster@pobox.com>
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
2.55.0-599-g5cacd2ad51

