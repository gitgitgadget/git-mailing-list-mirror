Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B434CFD0
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833711; cv=none; b=LR4ucXR985lTsI3JgWIo4LL5zSTQ8EFdTTA706FClUYCfjaehzy8xguPX5h2O1tufsYC/z7mjpw1hq/RVn4lFhOGjF31y3KOpE3xzVPVCRVDc3/rLDP0SQQO3LFudP6dKLLzFCZgmUxpezBkWB8LjEZfH+G8ySsYy7KAfWGfCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833711; c=relaxed/simple;
	bh=ORde0fdTcyXggqTNNk6zNTCVEag2mH6gRCQ9/9wuTjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBOM+U4RhbxBSiLbB+t36MSr2JW9tUc6WAmFJp/iRvbQudW2Sg2mRf6KrEay7uZjgYoU2asBWu9Two4ZMoMBXpj86t7BvQhUoQmNcZ+fBs0oboVs1wIGbjanLF7tWhwYM4mGmm/eN+sU1Tk/oSqkuYF+5Grq9O7YeNxRrUCHMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNc7Lqx8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNc7Lqx8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48375f10628so24569265e9.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833708; x=1772438508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpB7gxHYv1RCrBGJEiZQU1GK/+eaWL5POIje2U5zOks=;
        b=PNc7Lqx8cvy8+exDrSFp4a6xBARJyaj9WzIGGAaX3R3MUYAao3K0O8kwScMrjYFJ8C
         gzsP8UHYCpMUjjMrI2a7s7j64eK4NKdQ32YzjF4VgzzaMti+jUXQ4oFqd3Lp3c1QPQyw
         yQJAa64de1Rn/iqtDiUwXMei1ondQ2uJ5FYnnHTPsuRXFh64F4ch50NvO00O6Lb4mOHN
         v0vNKzvKuXwtm0Jwu8+KJYL1gpR4Z6ZFgr2m7Kxq+tM323P/tGd0OymoyDOQ/96Dke1K
         LyjJWWzg/qFPlyr22lBiJIELXYHtrje4bRz8+zCrhWVBb63JzynzGoSkr8T9cxbEWE7f
         bu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833708; x=1772438508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HpB7gxHYv1RCrBGJEiZQU1GK/+eaWL5POIje2U5zOks=;
        b=OTw9nG3iEAAuYE9h5jRDBueJ2U0+ht4YIEH6HO24TdmWpBxQicusZJ+cfTLox82OQx
         T6zZ+HOQvJR4iZD80TrqQgFbXitWHincU1t+0y5k/ZWWb1txJG0pzQDTzqNbPK/sDcTd
         Nrxq52s57GHQJXW1VBzxlUKvtTLnGO1+QLHKnxgJN5I1WB0acFp72C3WH03pYvmhSzBV
         ZTEzJP07gzT62LwBCL0t5OvTM+28wvJ8hGAcPHZepcTXHlbYVxPmjYH/1LQu8TlAXW/b
         ue3Oj5I88w84zD+sVDpMCZ9cTEezh14k7Mfq7OpyxG8WnyUkUOf6EKj0m8Qri1lr6tGl
         Tr/g==
X-Gm-Message-State: AOJu0YzybucJaf7ywZUmVZ/sSUfj3haqFDrBUUnVCMZeRYNGkR+88eRL
	yKHbwFEr0rYtBHkc0EZGXw1XyvlVhEgzS4ZtTZcv2JPZWxljouXx1Kyg
X-Gm-Gg: AZuq6aJiLhcF7GXnzPYcnE2hwQYrd4pGMjj80z0Lg5Ws3U8BfBtTbJ50MgXukAtkXkN
	Yf4mAX0Q1ugUBDjXcHujdaKnVywvbO5N5q64S2tqpnlGWqWJnEVk9vSx+YLJZD3yqdwTXIlHjb+
	sWVcl8Dtwa0/EZiMu/aFYZ9rNWta9WkAl0Ecr1cxpstn2bZgNqxLN1ZdqGdLGc04IOd2VH5p6ui
	iErvS71btzlTw1NyeLIcdMkuixoeEwvdLO4FWN4WZWihJoaE+grnRWgQaP9LJ6aRw7euPqfuMXK
	awXCVzHJJB2YZWaCv4wPENqyVy3Ct4InntCGLtfyw791DjHzLfBLrMmBTaIkBmxQLx2afxEDamj
	sBFUeXdSe7xBK4bDvCawrCuKqq7Nx6tsQFevuQH5CxS0Ni2zmkxB43Ra03tzOHZ2rhJ/pO5hNRS
	C+r9xt81cxNTjtJZcRyrS5WXRVqWOmmE8=
X-Received: by 2002:a05:600c:1d0e:b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-483a95bd940mr126050205e9.12.1771833707420;
        Mon, 23 Feb 2026 00:01:47 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:f529:6f94:a480:7bd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3db3369sm117333775e9.0.2026.02.23.00.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:01:46 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 23 Feb 2026 09:01:38 +0100
Subject: [PATCH v8 3/6] refs: move out stub modification to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-kn-alternate-ref-dir-v8-3-0509c132a203@gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4830; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ORde0fdTcyXggqTNNk6zNTCVEag2mH6gRCQ9/9wuTjo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmcCWdw0HlMlnmxCWvYVBxDbxY+IA5JTfEfL
 B81ZDJhA4DY44kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnAlnAAoJED7VnySO
 Rox/UtQL/R21a+7mQkXAglkhy5T+l8RNgzoXsxGzM309mEOLXquas4uSIfNnRlmem3xxYQPLqc5
 z5vwvYXNVFJBFCGTlODw78RbYOZNcMC8/9o10N4YTDSh0dlIT/9UOZd2VjPMFT4v6NRMx+CFOWe
 EW9g5WmwnZ6h0Y+9jH3x7K8fcKHUnc7eJv0aezYYRntNuB9HT3iJNs8JrPi0qeAGH58pguCQvCm
 AxjuRgUxWwSYaYVVsjshXWGD1P8w3+jZkbuJa3QscoO5npKIBp/tU10AzDq+RGm+m8/nM+jKTrW
 O3Fy5iHmtrw0VulyElnnr3hQbxoLISv3p8Yj6l5WHifnAcBmp4shQm5BvP9IlOVkHnxJsWxNXWI
 roeya+s2E96X5CEY+5AOgjokY+m/oo+AMHvgL7I073+3KdFEFzmdXJEdll1/E5TPYMEpy6cWHIv
 mrwxbV9KEAOgbFq21jCvjPdo987RD6UHSZO9xKarj4SsFop6aJGj3A3zQJOQUH0Og6ANeG8Z024
 9o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When creating the reftable reference backend on disk, we create stubs to
ensure that the directory can be recognized as a Git repository. This is
done by calling `refs_create_refdir_stubs()`. Move this to the generic
layer as this is needed for all backends excluding from the files
backends. In an upcoming commit where we introduce alternate reference
backend locations, we'll have to also create stubs in the $GIT_DIR
irrespective of the backend being used. This commit builds the base to
add that logic.

Similarly, move the logic for deletion of stubs to the generic layer.
The files backend recursively calls the remove function of the
'packed-backend', here skip calling the generic function since that
would try to delete stubs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 refs/files-backend.c    |  6 +++++-
 refs/reftable-backend.c | 27 ---------------------------
 3 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/refs.c b/refs.c
index 77b93d655b..c83af63dc5 100644
--- a/refs.c
+++ b/refs.c
@@ -2189,12 +2189,55 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
 /* backend functions */
 int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
 {
-	return refs->be->create_on_disk(refs, flags, err);
+	int ret = refs->be->create_on_disk(refs, flags, err);
+
+	if (!ret &&
+	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+		struct strbuf msg = STRBUF_INIT;
+
+		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
+		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
+		strbuf_release(&msg);
+	}
+
+	return ret;
 }
 
 int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
 {
-	return refs->be->remove_on_disk(refs, err);
+	int ret = refs->be->remove_on_disk(refs, err);
+
+	if (!ret &&
+	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_addf(&sb, "%s/HEAD", refs->gitdir);
+		if (unlink(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete stub HEAD: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs/heads", refs->gitdir);
+		if (unlink(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete stub heads: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs", refs->gitdir);
+		if (rmdir(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete refs directory: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+
+		strbuf_release(&sb);
+	}
+
+	return ret;
 }
 
 int repo_resolve_gitlink_ref(struct repository *r,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 240d3c3b26..d3f6423261 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3700,7 +3700,11 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
 		ret = -1;
 
-	if (ref_store_remove_on_disk(refs->packed_ref_store, err) < 0)
+	/*
+	 * Directly access the cleanup functions for packed-refs as the generic function
+	 * would try to clear stubs which isn't required for the files backend.
+	 */
+	if (refs->packed_ref_store->be->remove_on_disk(refs->packed_ref_store, err) < 0)
 		ret = -1;
 
 	strbuf_release(&sb);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d8651fe779..6ce7f9bb8e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -491,9 +491,6 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
-	refs_create_refdir_stubs(the_repository, refs->base.gitdir,
-				 "this repository uses the reftable format");
-
 	strbuf_release(&sb);
 	return 0;
 }
@@ -519,30 +516,6 @@ static int reftable_be_remove_on_disk(struct ref_store *ref_store,
 			    strerror(errno));
 		ret = -1;
 	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
-	if (unlink(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete stub HEAD: %s",
-			    strerror(errno));
-		ret = -1;
-	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
-	if (unlink(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete stub heads: %s",
-			    strerror(errno));
-		ret = -1;
-	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
-	if (rmdir(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete refs directory: %s",
-			    strerror(errno));
-		ret = -1;
-	}
 
 	strbuf_release(&sb);
 	return ret;

-- 
2.53.GIT

