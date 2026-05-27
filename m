Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7F3B19AE
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911762; cv=none; b=JFMp/fuIhWmRroXzsyoANPADiJjk/Xez3MJSq2JSo6qfWKuiWCcTSxqDMat+B/nd+TEBXp9gaaRyFVN6N82Q87Aql1+P+HXqCQWSUS/Kn9ulPed/PZ5V/mPSRdGV1IfKDRQACP7ZZBP3CdS0DlVCaJgFN1i9pkr5f1Llr0v2q5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911762; c=relaxed/simple;
	bh=zcPhcI1Ds1VGBFFZUSkXggFU8ARDB27IdWIk7ZBapys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEKYGviJ+4l68eQsW1CAyUSy5NOjOw3HtrqVZ54lHI1XkzV1TTaFr5RkbDRxHguEbZhEwEYur7USLCbcI1h642QMPngPWaAQu/HPCY4ego636Gr4iZXO3QiPcafQSPUA0ZgVmjv3G6cvQOgQwA7oCdFX0NOyxKf+6DQ/Rg/UuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dXpuDEOv; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dXpuDEOv"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c52e49d978so125924987b3.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911760; x=1780516560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=52AIcRyiLy3xJ7sbhOInZ7Tw7/FoX9xb5w7ZzAL9qJU=;
        b=dXpuDEOv7Z2Ys4mqlPmNK7tV3bSUtSfl1dUeD0ZC37RXkx88MAtG5SPN+I6Hp3M8K8
         hMc1i2YmFYeJcD3apkJ/QUjjDDw8w0scxJ6yng5jKFVS9T23LCB/s9JENURneko8oRMU
         ZNxsMaKcnZy6GuAHdWVLm4A7HroJDiM1Gy3Qh5lrJ0Q56T8U47H9N4MKs9kIF7DyZ0G4
         ha3xhpN9bokwlYJooLhw5kHrSTVC6ZQb+WIRpbhG+r4dni9wL5mXPOV3DVjHYbyYG3P4
         zGubSqbuAqEEq9TXaxyJNzTmAqXwJBtMGdmlgP1U1JgQosbiWeLR2gegpSCoGun1kKgO
         qCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911760; x=1780516560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52AIcRyiLy3xJ7sbhOInZ7Tw7/FoX9xb5w7ZzAL9qJU=;
        b=Ljfabn6bQiewmajRK2vhH01Eygs00Mx7SVzmm24oLlluInP57ec7/dPRfJN8VWmus9
         Kxc6SfWfydtfQYiyLjtfX6o7IHnJbLrGaBxAb0cYueAdWw06SRg7kiS7n77aubBWIWzr
         TYOuykdS6ZgtS1OX6Rld2GRUalaExfgQnoU5e6UZr1BjWlb7AwyvdjoxpsK+5A8VHb7p
         qkycTVUH/4PjQgs+ZChyeu7yTFCVlNMhPtRrjrjeBlpNFfbj/NXv0QWBg+nAY+aHuCiQ
         ziawHcD9LmsKUONO4z5bpHjAj14qO1hMo8sU2s+b0k0ly4vR8yD+0O0GEkr00YZAZ0yw
         X6hQ==
X-Gm-Message-State: AOJu0YzB8qMN0L3p6aXw6wExQiHJouP7MhiXKUjB7OpEyIKni7KAb6V/
	dEp4JiI31eyfFbpBLjHKXhlPqklFT6bxio23uI3pIslscuoeZfGJpOkFqPA936WHaWxVdyGI/12
	+WYoKckU=
X-Gm-Gg: Acq92OHLyC/CU3WJSPN5eAHoj52xUsee6TBxdtiWZZEYyKPEWVNmDx8GTramHXPpI0i
	naJSo+xOyKoMvBXaJ9nPlEJxmofA9aJsWLZepcRk7fL+swOrMfXU4emf0q9tsSJco8dgsIIhJHY
	Qn97lS1hM6qihKI90slX9SLAE8TJZU7iPl5CVuirTj7LKaVoQ5dO1J5OMkDFHtT3PSJof9fTkfI
	haECfceS4ZOED+/TJFvRHdrBjlcZTKib23IoRSeebJbKqVRTElwBXLs6yTqZW8aPMXjvqOVe8iZ
	lBdH9CLxSL4Ei140Oy2SWIh6We7PzcgAsXsJdWr+F/mboWau/VIguDoZkba2TQVtxXhXHcOBAfC
	fvRNXe9ZzQ142TMhVQvEjFuSmGwF1JvZzILNlQxCXFZILM0HCHYmA7N1D76F/4mDztJ5/CwH6LC
	wkD98lceqTneNyOlF3ASk8xQ5zZb39zqsBHxT+Zcg2Q5BmcOgf9sUuF+mDdhPMkc/mVKVMRkNJl
	x1IVu7CXkIGMCWRVA/sqSUy/I3w+ozlj5U0T0KGdXJXB7oNswpJEgHDYc/Z688zPpaehSDox0UK
	1YhcEa3LbNbB1nj+8Wz6Ue9suN1EVcxmhGpczA==
X-Received: by 2002:a05:690c:6887:b0:7bf:dc60:ad14 with SMTP id 00721157ae682-7d3387835d1mr271564807b3.46.1779911760595;
        Wed, 27 May 2026 12:56:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c838e63sm79913027b3.48.2026.05.27.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:56:00 -0700 (PDT)
Date: Wed, 27 May 2026 15:55:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 4/8] pack-bitmap: consolidate `find_object_pos()` success
 path
Message-ID: <856aa3a6ab7e814490386fb0719072c4fad8be8d.1779911733.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
 <cover.1779911733.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779911733.git.me@ttaylorr.com>

Both sides of `find_object_pos()` report success in the same way by
setting the optional `found` out-parameter and return the resolved
bitmap position.

Prepare for adding more bookkeeping around object-position lookups by
storing the result in a local `pos` variable and sharing the success
return path between the packlist and MIDX cases.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 651ad467469..42ed22feacc 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -217,6 +217,7 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 				const struct object_id *oid, int *found)
 {
 	struct object_entry *entry;
+	uint32_t pos;
 
 	entry = packlist_find(writer->to_pack, oid);
 	if (entry) {
@@ -224,23 +225,22 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 		if (writer->midx)
 			base_objects = writer->midx->num_objects +
 				writer->midx->num_objects_in_base;
-
-		if (found)
-			*found = 1;
-		return oe_in_pack_pos(writer->to_pack, entry) + base_objects;
+		pos = oe_in_pack_pos(writer->to_pack, entry) + base_objects;
 	} else if (writer->midx) {
-		uint32_t at, pos;
+		uint32_t at;
 
 		if (!bsearch_midx(oid, writer->midx, &at))
 			goto missing;
 		if (midx_to_pack_pos(writer->midx, at, &pos) < 0)
 			goto missing;
-
-		if (found)
-			*found = 1;
-		return pos;
+	} else {
+		goto missing;
 	}
 
+	if (found)
+		*found = 1;
+	return pos;
+
 missing:
 	if (found)
 		*found = 0;
-- 
2.54.0.rc1.84.g1cf18622df7

