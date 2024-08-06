Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976951803A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958667; cv=none; b=LNfp8LfPsdqjInlw4FNbu+M/HgjyoylbgqDbGLqAMSLqDwt2nlB+kdF1r277HdveWA1WAfxwBCL+VBrwf+QejGJK5zXGcgheiUHIrIuXHQVTrogCTDQfFL3oI/ruE37NL92m75u1UwLbMXtn4pDxPczaXjP1GSMhuUt5FZDz7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958667; c=relaxed/simple;
	bh=AQnzizFGFfOl7045WRP7PXi5zvl1mIIXF/bpSF4AwXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3LIg8o3dovoWpBAYgZ/cTxLJZzPcbA7m6bznSai7XxPnybTXsWQ3HrMLIBMFIxkq6f9i93bUAVdStKghAIebGt679/ho9NuFijAspeIBLOJ0pRhK0NrVwHXl8nDC8rOfID02a9IP+wo1pfDAWKxAxJjwzqEhFjvL2cLQc9Wp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bDaAGnve; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bDaAGnve"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-690af536546so8787037b3.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958664; x=1723563464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVroDsdMsGQE63tSMgtYp3l1RZLDlSIT0DRgLmQ0xwY=;
        b=bDaAGnve0OkNcT/CCKJYk4nBJCbH5p/cUTGmYavijwaQ1O4eVr2jEDK9lG1f5h6taZ
         5rVu28PWb5FTb5ECO4wpVO+ZlgW3uHB94fqhI+wTaaE0BCBi1TWcUQMgEMZNvb8zjV05
         lKuPT1KdDVouWv/PRLIxn0Oo5EfuzP0LQEEt6ITDI5o+hutH9CJMBSsCSNB0CUTaOMCB
         AHAt5jEQ9uz6wQ2IRPXFQSPF/Yp92usLn2gcCo2DqkcoJ1zTFpEgj92tRFwyuuUiefo4
         TFWaNhQAAbUbj9xiu7ehesizQYFE+VDJW1zf9Uhh6JloK4jwRw35nOqP+JoC/9RNniMj
         9tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958664; x=1723563464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVroDsdMsGQE63tSMgtYp3l1RZLDlSIT0DRgLmQ0xwY=;
        b=kEnSnh96NYp0nk+e8XROERkJd0h0l/avKlu1ylN21G8/HrqfnOeM7cGdtPHpjBMsMz
         1ODnAZwIpW2Z52CQjwXr1v3/NGqju5gNRXcrPb4xtsAuzvK0sqKUHoI38lhrOPtI6/7s
         2+1OCM5cZRuNsYUziLjxPObRXUhIvj5cgzh552eu8quseH2zjqcmABnvAAxx1kLQ8zF9
         uUB5Gc3cA2tmWq2/izJlren+FpcJ15zegeo6jFkaz+MH0kaiqTM2Tp7C5ZhTsXl0GEtp
         1zeHTTewrKwDyrStZg+Rys9nGhc2/X5he1RWXlPcJ+9SzFqaW8HOnsr8fl/zhsqsFAp0
         DSkA==
X-Gm-Message-State: AOJu0Yz38lF5fSbtDoRuUwONP2PaW+0cUiP40q71UFXOdxJlya27ZM2j
	FEjFagkdxnXNemKcIiOTu9wUoG9g9ZzfAfjJ/6QW7bmYHf4QRXejK2CU0ku6P1MyOzZOkHCsgte
	l
X-Google-Smtp-Source: AGHT+IHl+QbsW+GrC9phJuRd9U3vkRSmAH/sUGP/yXyOGryBFKnNBFGjsQeAPBpdd0Y9ijDBNJiCoA==
X-Received: by 2002:a81:5c43:0:b0:62f:945a:7bb1 with SMTP id 00721157ae682-689637054a9mr165793827b3.42.1722958664357;
        Tue, 06 Aug 2024 08:37:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f418862sm15861567b3.27.2024.08.06.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:43 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/19] midx: remove unused `midx_locate_pack()`
Message-ID: <909d927c470f24c723ba067fce2016ab80b01885.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

Commit 307d75bbe6 (midx: implement `midx_locate_pack()`, 2023-12-14)
introduced `midx_locate_pack()`, which was described at the time as a
complement to the function `midx_contains_pack()` which allowed
callers to determine where in the MIDX lexical order a pack appeared, as
opposed to whether or not it was simply contained.

307d75bbe6 suggests that future patches would be added which would
introduce callers for this new function, but none ever were, meaning the
function has gone unused since its introduction.

Clean this up by in effect reverting 307d75bbe6, which removes the
unused functions and inlines its definition back into
`midx_contains_pack()`.

(Looking back through the list archives when 307d75bbe6 was written,
this was in preparation for this[1] patch from back when we had the
concept of "disjoint" packs while developing multi-pack verbatim reuse.
That concept was abandoned before the series was merged, but I never
dropped what would become 307d75bbe6 from the series, leading to the
state prior to this commit).

[1]: https://lore.kernel.org/git/3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 13 ++-----------
 midx.h |  2 --
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/midx.c b/midx.c
index 5e4e6f9b65..50f131e59a 100644
--- a/midx.c
+++ b/midx.c
@@ -466,8 +466,7 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
-		     uint32_t *pos)
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -478,11 +477,8 @@ int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
 
 		current = m->pack_names[mid];
 		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
-		if (!cmp) {
-			if (pos)
-				*pos = mid;
+		if (!cmp)
 			return 1;
-		}
 		if (cmp > 0) {
 			first = mid + 1;
 			continue;
@@ -493,11 +489,6 @@ int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
 	return 0;
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
-{
-	return midx_locate_pack(m, idx_or_pack_name, NULL);
-}
-
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
diff --git a/midx.h b/midx.h
index 46c53d69ff..86af7dfc5e 100644
--- a/midx.h
+++ b/midx.h
@@ -102,8 +102,6 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
-int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
-		     uint32_t *pos);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
-- 
2.46.0.46.g406f326d27.dirty

