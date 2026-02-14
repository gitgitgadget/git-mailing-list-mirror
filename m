Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7B31A552
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108475; cv=none; b=AyCMuFxuh1FYnw5RDD/lUzjoSxTIouAceP0zcPTuA4XqR+zoGS6CRDQDcZ1l/wR0t1eHabiWhE6loSsnizvmwAxACDqUjO4Fpq0pmIHygAll+0ifp24Wccf8WnkAiOctXLW/bUl8LzSb5u2zvcPKeAEpPhevrfbBaV8pLhXciY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108475; c=relaxed/simple;
	bh=2mo/brGaLFdq2Sx8rerEVQCTmCyUiB/p75wW7EOa4Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulpAIcHxBvEueYZoNsXbLiaT2a19JFS3ysCQWSb6McCD9RzemJkf30I7lqfOc6oxnErr3lvN5sgwQqoNaVBnWY6KQncf6mSK6hcW7sPGX6myDyBafi4+QFXDNQ3w3DWSX0IHQCoW4PmjeebCCmCqAxvgHAW+aqS5xVizGpaBGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmRNaeIc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmRNaeIc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso15138145e9.0
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771108472; x=1771713272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNiEvjcrS7Gg+0fx0E3EZVax1QksvncI3zw9l0CURHg=;
        b=HmRNaeIcbcOkUWOs/+TOWy5PVHousN1FqoGwD9B2oOnO5o6kkeo6QEhcnEzcgJqRgh
         CHAlf8RxDuTzgQ+GuNKfALi5iwR0DwGbQwx5R2lRU62O0HnzBpPAy93gCqbVx1h7Gjl/
         5lKz3dh1etxsindo6FAnGHJaYsF/3+nVaufIrWl3/N+9ma91+Ckrv54BzwlAEBgeHwUC
         R6pQgNnjP+U3o/Oz3t89RZMBdsXOmrWdhfHA36t4rlPTWi0851aQReW1M+r+sYxXQB14
         zY9v9Z+CW+0oi+BVhNNHi2Ktm2rRQDkJBYXaVf49yz4G+o0J/EkzRH98+LBLRDg0Zdwa
         vjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771108472; x=1771713272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HNiEvjcrS7Gg+0fx0E3EZVax1QksvncI3zw9l0CURHg=;
        b=H1a8+opnYRUIEE8HplFQclJGaiXDX+A0kbxbBFSBg1GdgaPbqk6i84eyfuO28F3ze5
         VQFZfRGmV9DuKvtNjbiRKnovCLghfrz4+bXydHKXq7lP1UasK9/Y/f6cncmqiiU/umHr
         21TJcn2I+V3xIQDqFIVWrYOzQagF9mbd2TeDTgxilrHz9+VBMb93WXiAB654d97Oblp+
         6KGoFgayvZYEpXAr6Tc+scaJ5kxQHXPPbcyhPEYCXHP7aV88p0BkIjHxdp0rtQFrhMh7
         ilZcWxKs/3qX0GZCKpUcMJF+dqUF940f/kLN9ySl4zbcRm+JydUJgQhAPz+q0dnPF8EX
         imSA==
X-Gm-Message-State: AOJu0YyncLOh2rSNB4PK/1B++iEoT1YPVNGS1Sa4saC3ago75C4YvDdj
	sR37yp0F61VGNoqIeqoGgLC26jkXW54cUS/Qd2eoadlw159g2kINU9t85CqFTWAA
X-Gm-Gg: AZuq6aJtDDn2w4ZIbyS5jDjzwsbo7LpjdxpK+UM4GnJsKQBhe10liUd9EhBmb6WJIAh
	y0pt6mU6K+o/JyisJMp0JoSRoI5zh/57Xa362Wi6c2gRqLrvIpyVzqZ+npjNv41DCZ6Kp2VcJeF
	z6KtIz8GtbpLRqt8Pnu7NA62gd952ajvtsT7eoFJ7ZqdOr2MZweAHJT14eCPqZJA3hlnXLbmiuh
	exAyycHKzo3F0D9n/BaAKMea13Fbon0dj1wCmKD4iSsu3miHNiLSbWek2T7P1btoHI0+X8jEz8L
	eN7fVRcUTP7IXaiGJhKufeK08OD3JORRXPxx+sQt/hWGR5r6rWiUjEszfThBLB6OTQ/XjB2LJCp
	MdqBCxZdrXFEV8g/Typ66boKFRnPGHqyK94pw7g5Q3bmEWNckvC9fSZ+kQgxUFKrenJDsCnuY0L
	hLy9mrpa7AsfblwUTZg85bOsfTkMuzOYc=
X-Received: by 2002:a05:600c:1e1d:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-48373a15f1bmr101167405e9.1.1771108472461;
        Sat, 14 Feb 2026 14:34:32 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ffee:e476:e6e4:b574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm83591645e9.10.2026.02.14.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:34:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 14 Feb 2026 23:34:17 +0100
Subject: [PATCH v6 4/6] refs: move out stub modification to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-kn-alternate-ref-dir-v6-4-86a82c77cf59@gmail.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com, 
 ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4858; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2mo/brGaLFdq2Sx8rerEVQCTmCyUiB/p75wW7EOa4Ho=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmQ+HK4s8GvItUacfkFLauxH/kIvGE889m9X
 LRe4mhK4bMkPYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpkPhyAAoJED7VnySO
 Rox/RxgL/id3ou1O4US2R1gurwn5SlkX9kXR/Ex+Ngzry70Hq2SMHNpjXlnI2VSDObiT5q5oPze
 sHtp5fi74FP7tym/SL/iXW9AHR1pwPPlSv42IfArZQsuGkIQL+6kVKLLYhnKCq2Tt4B95qPaZQt
 CEHOgaDL7Xp53wlXWaoo2TPv8v4oEQQs4yaCtVAsHif4o9pBEB2N7A+bh61l9gTDzFUJG6vIjhr
 O9q29uashmpdKqP22pIEUk1aEaweXWeRE8+03v3aUcQrgby74mW/JkqOHf2Xu2uJUs+c/ahYGgw
 vcM/4YFK6Ca3xKCpFk8HeTLdJ8CzkayINd+cr6ra/SILaZ1Q49iXK27QNK2XkLvF6taiE3v3dej
 UPHW0z3TxikGXzKe5D/1aPJgII0aISnKz7mOn2QEAE4VuyHu5w0j5Iag4fI4niaVQNg1cM5cU0C
 lL9dFdtjLmfnq+w/sciBybyErk5Xomj/ikMzUZwqHt3yZTYf6cAnInjUEf7LPAmmnFcWZjf4P+8
 no=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When creating the reftable reference backend on disk, we create stubs to
ensure that the directory can be recognized as a Git repository. This is
done by calling `refs_create_refdir_stubs()`. Move this to the generic
layer as this is needed for all backends excluding from the files
backends. In an upcoming commit, we'll also need to extend this logic to
create stubs when using alternate reference directories.

Similarly, move the logic for deletion of stubs to the generic layer.
The files backend recursively calls the remove function of the
'packed-backend', here skip calling the generic function since that
would try to delete stubs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
 refs/files-backend.c    |  6 +++++-
 refs/reftable-backend.c | 27 --------------------------
 3 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/refs.c b/refs.c
index 11d028232b..a24602c9bf 100644
--- a/refs.c
+++ b/refs.c
@@ -2190,12 +2190,59 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
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
+	if (!ret) {
+		enum ref_storage_format format = ref_storage_format_by_name(refs->be->name);
+		struct strbuf sb = STRBUF_INIT;
+
+		/* Backends apart from the files backend create stubs. */
+		if (format == REF_STORAGE_FORMAT_FILES)
+			return ret;
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
index b40d6feb1f..9cde3ba724 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3707,7 +3707,11 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
index 964b0b50fc..0e220d6bb5 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -495,9 +495,6 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
-	refs_create_refdir_stubs(the_repository, refs->base.gitdir,
-				 "this repository uses the reftable format");
-
 	strbuf_release(&sb);
 	return 0;
 }
@@ -523,30 +520,6 @@ static int reftable_be_remove_on_disk(struct ref_store *ref_store,
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
2.52.0

