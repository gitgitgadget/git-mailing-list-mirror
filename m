Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A861D45F3
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054053; cv=none; b=cHjB5A+0nlHDBH5R5tA4SqyPWFMekhfUohOU9PDEkHbHEO6KLA4GzEHnOE+d1P4mE4Wm+D5fPb6eF2ccxiQX5/wCXgWwyn7epdalphzqOlKbxhlJ4d1iMYfjQ0dcdCFX65xJA18KNfPsQKYCTXQ/h7JrF10T1FaT5/blgm3J94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054053; c=relaxed/simple;
	bh=9YbjvI4hGd+e6sdw9C9jANSx0jJXrDpspzhu1UGyt2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmjT26oZL/Q+0RzecXVXi4g4F3ZPrpxzxaMEuj0OZSIU6FQyvLZm9mQgvNPHVnr2tNmK1wkoOZtpB56B6577FwbfUgQQo8np9XopXmEhRpB/xvX7Y01rhQTXYdsoZblkBAOsHH33ZT4p50IqB0En7F3yPyd8WyS1mZArKJufLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KFo2EwNA; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KFo2EwNA"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e38c1ac8e3cso258045276.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054050; x=1732658850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5L3fFST7B7xqNhSQalGhHKw6KaVjM0T8RAk9FLVaUhU=;
        b=KFo2EwNA20tisgq2iNqfI8LbP+UZ3Oq0gvbzIlavA/i227S2LHpcq7huCZwaIWZ5JS
         s90N0eiBS5E6JhfKLPRVPwuyYJnVY0Nx/WQ8v55EK5MDm3RvGwN3u5zj7ExQSf3te+wL
         HnRzfjwb7qyt9qz/p1y3lAMp4Epr+ovikOBjU0wbRwHOa45BKduXnN5QMb2c1O+/2MSL
         satsjrcGSHgNla55RcfgI+jumMSUC53bNP5ujkMwNDOVfeP4OobwDdLtoGTyweX6dT1b
         G6qXeh+4NR1CX+wRrHXlEmbUQDWPMIINrFMIDQvSqvQppXiHXZHrvXcOwMN+t3AE2uuZ
         pYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054050; x=1732658850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L3fFST7B7xqNhSQalGhHKw6KaVjM0T8RAk9FLVaUhU=;
        b=hvpkcinbXFT1Zma5WIByZUBuU1uFnCJd/IAwGun93r47ewaJgaPLcKVrFABQnX4rDB
         5WEa53Lip+k9zXU4SfRTNjYkan/gxd/bJUzIJQvWQ29n4MJ76rgV8lowXEesTGT4LoSH
         JZmb64phyk86szo6aCMhXYDBGIotyXNdPSsd5GZLqPNjaYl6aG1faMBFmFBHwP6INKp4
         ldikye9Hv67TjS+MEVUYFvgjxyr0N4OlgO8lfcjHM5rI3GJsLiLbekc35B5D932otAb2
         qOLqSp0tT7jOXIi+qUx2V9kVjFI3DZc6/mQRGm9r1HBVRqV6WvQgHG8x5T1Yy5bWEAKW
         Z4hg==
X-Gm-Message-State: AOJu0YwS2CF4i5jlANM8+9MZ2ZdGCD5gdccVutccBfQ0P6s80kABz5LJ
	gLwEzZtUspR3c6/7t67NFi1Im9bSgnvXzZmdvEEbWYT2IOYmK+Ik9EC38oi85a+KCefnGR/NfPO
	E
X-Google-Smtp-Source: AGHT+IHDah3pAOL+Vd4TlxdOEogwbJ92R5hDSc2w3pBkmUin9hWQcRvhL9rY6nzsu4Jog8EUmNUmFg==
X-Received: by 2002:a05:690c:6e06:b0:6ee:4855:45de with SMTP id 00721157ae682-6eeaa34f47cmr45520617b3.9.1732054050515;
        Tue, 19 Nov 2024 14:07:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee713422f4sm19383017b3.78.2024.11.19.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:30 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/13] pack-bitmap.c: teach `bitmap_for_commit()` about
 incremental MIDXs
Message-ID: <16259667fb4d7534458bb458afd6cefe032c3b6f.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

The pack-bitmap machinery uses `bitmap_for_commit()` to locate the
EWAH-compressed bitmap corresponding to some given commit object.

Teach this function about incremental MIDX bitmaps by teaching it to
recur on earlier bitmap layers when it fails to find a given commit in
the current layer.

The changes to do so are as follows:

  - Avoid initializing hash_pos at its declaration, since
    bitmap_for_commit() is now a recursive function and may receive a
    NULL bitmap_index pointer as its first argument.

  - In cases where we would previously return NULL (to indicate that a
    lookup failed and the given bitmap_index does not contain an entry
    corresponding to the given commit), recursively call the function on
    the previous bitmap layer.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 41675a69f68..e3fdcf8a01a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -946,18 +946,21 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit)
 {
-	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
-					   commit->object.oid);
+	khiter_t hash_pos;
+	if (!bitmap_git)
+		return NULL;
+
+	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
 	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *bitmap = NULL;
 		if (!bitmap_git->table_lookup)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 
 		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
 		if (!bitmap)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 		return lookup_stored_bitmap(bitmap);
 	}
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
-- 
2.47.0.301.g77ddd1170f9

