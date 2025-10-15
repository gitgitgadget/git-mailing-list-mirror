Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3633090F1
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567248; cv=none; b=GLUG5JwxVzNXvN3ekJcX385SAQJ6RsjHgnHN2aKJbOfZ4C6lgr/tCJ0AfJwD8nxhYUh1n5sR6kL1w1n3PczoS3BlFAUbDKXraSu3zrh6vjo4Q50Hft0BZd8VAAe7PLVwi0gO8VPoimnjcRVZKeCmmPNarPyalzFFLdyoV6Cj39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567248; c=relaxed/simple;
	bh=w+/FDwOd2mgufculO2lRMtoyTwI4aIseVTKvrr/xuT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKs/Yp3Khw4oWIxREsJz4jQa1YDi9ccT7B5x5YTmvM7OlCPBtqZlaTvb3r/PG8gaSM3Va1gYhmuU+PrR4zzHeT1c/H4fNY6r29FK0r5KQDiXM9EBtBTuWuBdG8Ucw12NCq02ICr8pTVbrYlibZrr52okqwdhIrf0rkcxt+YVV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cKqoyJDL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cKqoyJDL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7501c24a731so780627b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567246; x=1761172046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PU2hfzCmPZXY6Dem7XkXu5WOb4174Rv2xLjwlWtxVaY=;
        b=cKqoyJDLQQm6yDwPRAsyQ+t0rBzIjKyV5D8GFihCvW0Ge54UuMbp1KD0YDQPvuvUXq
         94HOJAOZzM/drBgfUhrlsy9WexnRD3F023bOrt2nQqHifrgNEMPhl+B5pLOHeahEEoJa
         fQOxlBUSRE2uPU/ECBzeneHgKh4+dlnMDmVxciHuDvfMdSqnXDzOLS6nsvLCMvmVkkft
         EksiEqu6lnXsZgrhcPMGZEe43gA3YbbIfhuYxal4yp/oAzfrMzdj49hEMz0It00XzF/j
         PnM80UxcSF18kKY7NL+6mPpvtwGsbbE6Xgv8vbtIXxjzQxLFnnKqhB5ZNpuIIlwdYdtp
         JmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567246; x=1761172046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU2hfzCmPZXY6Dem7XkXu5WOb4174Rv2xLjwlWtxVaY=;
        b=ksa1fQkRbIZgfzZ2lBIWta4Wcnws44CkCk0+/2PwlUYpshpJ41a2GtyuVuVBuMaBx/
         OgdpnvXpbrzAZPIsY1FxZv7xIVJ6qedhKt2yAULKURLB/il5T96e1ntp7QQBFb56gqxm
         LE6NPG9AEil4gsJxi28yk13PekfMGICG31pKehxcY8HtNJR3QtN1njdW6wTKMZCsi8df
         Bt+7MgreyHTbt12cCzxTUKc2p2oZZe3+5roI/S6JVS3pxu9vd0JPcqvZP4PuXxznV3zL
         lWfHg8+fU2TPRPypdgrg2M9bks4HPPwBsFynKq6tvXt7T3xMzqteaLBLpyYZ/zqWIWcg
         LuAg==
X-Gm-Message-State: AOJu0YyJUqDC32kTFK1kLaDMCi51uW8toz4g3oqm3HdS+rq5Xqmui9xH
	I4LxFYju/ms/oU5hOuQvpCtp3qWbi+N+kbkhxkHLHGj9jXxiQ/Z8Te3D4ilAa4K9lRkoDSTLCqi
	4VtSL44GPCw==
X-Gm-Gg: ASbGncvDxgi4jAQlLBxjr+4l/JMWG5YQQ2jftFS0TW5JIADPT1x2u21MQtLl45ALWxP
	ZicJUG6+pGhzRnGW+hmVarEhyap5lDbrScPjfrIqBfMYTlHt/FFLCsm8fTHH+k26HahT0Oqz1Fy
	pbLlMMk0/EHM30QqEPNfVcK5nZy0N0B1seoV9xnfR8ZfHdf3pKQ3g+9J6WhceQ+oHaWn0HxQxN0
	SQdAh7eYGEqBkPh8cDWU3uhgZxigG52Au7JJ30ypKhNT4wyYQnrtdlAuJ7f81HX4xJ8oZFnbV97
	Tqv7QZSlwjvGL4u0KANcMj4xqZq3ocKDN5gGRR12eo8CLthn5+IQ415ZhSjqAUoLS4FYAnQr7U8
	eP5Sje8je9AU6BkRlJ/0/kvUzGGRcSXL7bZHiTP6i/wIZw0RUg/y35PRhgruKA+38lZoJjucuE5
	2S/x3z2kGTE1a/xwlGb6fl/nlSD/rVFSgWVTxu2lPMVXuolF/IV8KbF0TBBlxvyyjcyoAeDXL96
	pic+2Q=
X-Google-Smtp-Source: AGHT+IGmwrQqxWmR6ZjaAqT8xAmSZ10OZuS2DPOQ0+r1dFWZSF6A3bQFUww+mqll2VTDTPKU9dSJlQ==
X-Received: by 2002:a05:690c:6702:b0:77f:a47e:e7c7 with SMTP id 00721157ae682-780e15f62e1mr313351147b3.49.1760567245873;
        Wed, 15 Oct 2025 15:27:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c11e39sm2576267b3.35.2025.10.15.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:25 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/49] builtin/repack.c: avoid "the_repository" when
 taking a ref snapshot
Message-ID: <ff72cd499bb6430b51db01989f67d9384aa2057b.1760567210.git.me@ttaylorr.com>
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

Avoid using "the_repository" in various MIDX-related ref snapshotting
functions.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 7223553bed..113f5fc67f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -771,6 +771,7 @@ static int midx_has_unknown_packs(char **midx_pack_names,
 }
 
 struct midx_snapshot_ref_data {
+	struct repository *repo;
 	struct tempfile *f;
 	struct oidset seen;
 	int preferred;
@@ -784,13 +785,13 @@ static int midx_snapshot_ref_one(const char *refname UNUSED,
 	struct midx_snapshot_ref_data *data = _data;
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!peel_iterated_oid(data->repo, oid, &peeled))
 		oid = &peeled;
 
 	if (oidset_insert(&data->seen, oid))
 		return 0; /* already seen */
 
-	if (odb_read_object_info(the_repository->objects, oid, NULL) != OBJ_COMMIT)
+	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
 		return 0;
 
 	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
@@ -799,11 +800,12 @@ static int midx_snapshot_ref_one(const char *refname UNUSED,
 	return 0;
 }
 
-static void midx_snapshot_refs(struct tempfile *f)
+static void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
 {
 	struct midx_snapshot_ref_data data;
-	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
+	const struct string_list *preferred = bitmap_preferred_tips(repo);
 
+	data.repo = repo;
 	data.f = f;
 	data.preferred = 0;
 	oidset_init(&data.seen, 0);
@@ -817,13 +819,13 @@ static void midx_snapshot_refs(struct tempfile *f)
 
 		data.preferred = 1;
 		for_each_string_list_item(item, preferred)
-			refs_for_each_ref_in(get_main_ref_store(the_repository),
+			refs_for_each_ref_in(get_main_ref_store(repo),
 					     item->string,
 					     midx_snapshot_ref_one, &data);
 		data.preferred = 0;
 	}
 
-	refs_for_each_ref(get_main_ref_store(the_repository),
+	refs_for_each_ref(get_main_ref_store(repo),
 			  midx_snapshot_ref_one, &data);
 
 	if (close_tempfile_gently(f)) {
@@ -1397,7 +1399,7 @@ int cmd_repack(int argc,
 			    "bitmap-ref-tips");
 
 		refs_snapshot = xmks_tempfile(path.buf);
-		midx_snapshot_refs(refs_snapshot);
+		midx_snapshot_refs(repo, refs_snapshot);
 
 		strbuf_release(&path);
 	}
-- 
2.51.0.540.ga7423965ad8

