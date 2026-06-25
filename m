Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A49378D68
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379214; cv=none; b=Q2T3pof5yS3zb1pP+cwCz9UtSTWij+H4pXLr5ea0L6Vj0uD5wmPAkcO3UrpPXhoFt8Km0xn6mLZMShBzfhWGq0I72uJeUv/liPaCsQIvopDtIUC/D6XOjS5vnrcf35yrHFp89ZxslQczUX3T8mLTcxVaLtVGmInSordA+hSpK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379214; c=relaxed/simple;
	bh=ZEBc06ZfCMzg8D5SVxbFnrG+HhdOKWtA89taXHDp8v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCZc/p/rq4uYrtbABKPEdG7DteyUzEQQdEDXtjerKzCv/gYfJNGmLIBiT4CboYGo96nPB2qX4GEApjbAsfoY00sDQcenMk15Xnv1Qy8DQWUiRrl0zKOOAdr9ueD7/GySUCiZOrHz8xLFoQu0tgADwJHCfrLNBkQVM3FGZpAbn60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OYfdi6u9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d030wf8l; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OYfdi6u9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d030wf8l"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76D347A0111;
	Thu, 25 Jun 2026 05:20:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Jun 2026 05:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379212;
	 x=1782465612; bh=INfx7H+liujI1MbiCb1gWHHn3BL/W5QAL8l5j8XBXiI=; b=
	OYfdi6u9FOB5nwU69qRhTssjFLYcSy0YoeREL7ZhnSdeVg77W3nZ1NUEICciFhhB
	OqGAYEoeQ5vxeMGZv3alL+BBBS3d73d1k079f/zOiXShMYvnRA2/ssig+gqzFfms
	1QnWcBOBkBmwcuQp2YYCZJYNdnbQNhKV6zx7O6L9H3Dy31LK1loSmW0mwuJdsUDI
	GXa31mUCVxIdcNysv20h7bJAt6xhgt6Y6Cjb++gFtNM67l2n81PagM1X6murVUPk
	D64EWA9PrRmhh+8jcBY+NFceb23G1nNh+cRcjvc6TwG37vaynWvW6RsttOYpQCeA
	H6ky5yaZFTQgZA9FG1Lw4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379212; x=
	1782465612; bh=INfx7H+liujI1MbiCb1gWHHn3BL/W5QAL8l5j8XBXiI=; b=d
	030wf8lRf18Ra1PB1nvc+xbxPUbLfI45t65SbCvHA18dwNALHzD5KVI6pW3+tyD/
	/50fwSPPvl+YrJU1IHouQG1JHSfqjjj8OVJCbosqpiIjVbmHrZ8irWRegpjklEb6
	LHKlx9SrDTOVOusQfTJV2BlIFWWY1sqNdDmB1xWbdohaunFJa3lSgyFGDFre4l1m
	LVjNfFAqlHcGVdGxIV6tAG6vhdZECcqXL+/abnNjYZnNB8ZOBFrnKw7Shchs+gnA
	S89Zc7L6/Elcn5rGrDfkkrdH5KqLJnG4GR9YXDrmO0BBamzplpI5TbkLMRxVyoVG
	8UyL+0PHgPX5M+NrNfZ3g==
X-ME-Sender: <xms:zPI8av1rtR6_2cXIFBN7FjNDmV0rAK3xQiScQ0iff6JyxBPPBoNZEA>
    <xme:zPI8alEJr2hLIbzXXHtPOUwFcz8VByT6LZ2uODk8-J4EoQMlVIHa2DgjbOcQx3t9a
    oPPxTWsIoErxJa3HiijXOeBDlOUenWSxqrATGl9PJ_Xj2XWt_VS-g>
X-ME-Received: <xmr:zPI8ak7Lexd7TawIP824biZ-SZbNlqcyJ1wH7NS0PSoojO1lUuXVVqpLZx2Ex9Z0LO1j4rSkcqVqKy56JM48vL5pzh1Ga2Mm-swYATMjsQ>
X-ME-Proxy-Cause: dmFkZTFJny8F8bT1vobP8mT/gHA8dRfG54tdLYssF9mGrBAZ33fvzfK1eqPxa29sDtYAhN
    5tkjpw8eG7f8oUYXwWxFvXTfK5hurMwltmfD04NzD/ZqkQDnNm5LG5e+36110BPFzMSHq2
    HQfiw4sPCG9XizI+bbWfQ70k6NFeQGil+Q4g9AnIT5X8yKcTuUqmWhXByog3KGvZ/ni4kX
    k9V/L/9g4/bQonvKK8Brc7cK3ZOQt+0LqTZPmn4ByHyhrpuP3EGvOEGRCSWZpe6rchkvz9
    cVZP4E7MkYqSCORu71W7wFgpoNuZR9ZptCacni39b4NdZsabOObv28iAAOaljK7R002Qkn
    c2iPcgJ735Ikze6vJk8X5Qd20QU78UH2mwtNPq4UjbId0Q///fwSKiBSuOUt3to7tMLTzF
    DVH1V3o5E/tMkO9+jnMLltsuzFQ5dEnac1K4OqozeVNtKYy1hjNIj0e7/6gCqool1KQUVZ
    S1JmH4HHnRhG0SuKyZE4qP/Gf0D3sR3VvyDgIEIITtC6BgGFDXmYnokibCQYkGFeM+9QcM
    7LIzZK7j7ogWbFyGofaJkLg4tQ8qE0aD5EWb8qbc29f9XHi4v5sZ6vIzzY3Cra2XHeUiL3
    2M8jZlCPDv4A3Xo5vV2sYpoi5/SVcy+udo+ibf7nLXDp4X9jdW7EyODg74Vg
X-ME-Proxy: <xmx:zPI8ajuyZSFzH4TzpjOya6SZKPpoZboAQzCkoBK9emD7sLL82S2PLQ>
    <xmx:zPI8at4aE7wC12upR3Rx1WDeAgtJY3U9HQ7DMmSgBZxO6kgfTttYEA>
    <xmx:zPI8amUyhNXwlVw3Uhl4gbJLyvkhqceg4V5CggbwHTdxerlrCusPig>
    <xmx:zPI8an9Gl0Gw1iw5QXnzinY84gziy8cOPRqqdVZyUa5rKNAnuhNB3Q>
    <xmx:zPI8auPS8pjkvuliSWwGiXoUKbPsQxq6kb_e-LG7a1DeK_LsK-e2LnDM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01ee8648 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:19:59 +0200
Subject: [PATCH v6 01/11] setup: inline
 `check_and_apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-1-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We have two callsites of `check_and_apply_repository_format()`. In a
subsequent commit we'll want to adapt one of those callsites to change
the order in which we read and apply the repository format, at which
point the helper function will not really be a good fit for us anymore.

Inline the function to both of the callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..a9db1f2c23 100644
--- a/setup.c
+++ b/setup.c
@@ -1788,32 +1788,6 @@ int apply_repository_format(struct repository *repo,
 	return 0;
 }
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(repo),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt,
-					      enum apply_repository_format_flags flags)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strbuf err = STRBUF_INIT;
-
-	if (!fmt)
-		fmt = &repo_fmt;
-
-	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, flags, &err) < 0)
-		die("%s", err.buf);
-	startup_info->have_repository = 1;
-
-	clear_repository_format(&repo_fmt);
-}
-
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1887,9 +1861,17 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
+		struct repository_format fmt = REPOSITORY_FORMAT_INIT;
+		struct strbuf err = STRBUF_INIT;
+
 		set_git_dir(repo, ".", 0);
-		check_and_apply_repository_format(repo, NULL,
-						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
+		check_repository_format_gently(".", &fmt, NULL);
+		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+			die("%s", err.buf);
+		startup_info->have_repository = 1;
+
+		clear_repository_format(&fmt);
+		strbuf_release(&err);
 		return path;
 	}
 
@@ -2820,6 +2802,7 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2846,9 +2829,10 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt,
-					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
-
+	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+		die("%s", err.buf);
+	startup_info->have_repository = 1;
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
@@ -2904,6 +2888,7 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
+	strbuf_release(&err);
 	free(original_git_dir);
 	return 0;
 }

-- 
2.55.0.rc1.745.g43192e7977.dirty

