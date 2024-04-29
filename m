Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161A17B500
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423463; cv=none; b=F5CwM2pwug9Dc3MBpbtuxaK02lDFBrFyYY6UHSHgZvKUdogyjSlwaYPSyzB2cY/ztH8Kp3KJp9j2mLesXuDjtWFtuu13ld+YHUZ02TuRQdoQEiqE9qrWLueuTJi/oJD5WQCzFfbbhC3hoJ62D22tajbqgdoJswJrFxxeVgh9Aes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423463; c=relaxed/simple;
	bh=vquQ99UiSrPByaTwamfX8BS+fAcMmeMTNIJ07oLqQIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiDmlGrZWvHJGsJl8RoteuwGQZN8pKB6LPd+Vi2QodfddeimYPSCMI0bXOPut1Nl2/ooFEraHfdnQuMjsfMejyXfrOITLmmmZ+345CAMmv8MFjn+l+LtbJnmfBItHj0xE48Lxyjk0iX54aLXbr3JKG3pkUrl2CSUA6ONixXMI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=N81Eimfz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="N81Eimfz"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-790f4650f93so146710685a.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423461; x=1715028261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsjD1jUWCx5XOA4iwy+r90r2mQuzBCQ5x3rK9E5Y/v8=;
        b=N81Eimfz7N/LVkjKLoCT6gkGcqpwCb9AG0o738EZLC/p8B4v8affKTHNm+Dx8Yq9km
         0ENiQPy59s0k88ncn9dbjL+EKr2EP8OxMtU2hHOmtOtP/ZwGHWrZnDtUoVvwzNo2mVlr
         x30wHM+THLGHqO+YwyB6ObRhM3XaJbjMF2GSWzJqXe3SKZK76uZbIKRNjMGuOcaUpKam
         DLrrfljfo26UUc081+fiM8U9BzB8ZCg1BUVfW5lyeo6EaA5LGUVCUsyfTakRFGdwzeMB
         rHUYepcZ8cggXM6jJ1QyFsWxQoPEbE04FhAxYcYtOGgrqXGHteyr7iYhgc1wsTvaczq2
         rndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423461; x=1715028261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsjD1jUWCx5XOA4iwy+r90r2mQuzBCQ5x3rK9E5Y/v8=;
        b=G/XPXgL0yWVsx0sq9p9OHAYzW7S5JBiIZjTQP/h2Y9oskmspb+aUoEhOjQWTCzYjvB
         iYID2lQQI4ab+F61n3ebaKOY81w+kthrp0S9ixyZCFAw//Loo/KpMl3+Op7gz+pOByQh
         UeQpowzY7tjy9FlxkewKVspOdR+aNxIILhIyONgslxOT8kyqWeieEt4yadnCt8Sp1sUN
         IEH9lQrL0ZpimxGg8sp36RIepqWUe7ciWlnPclgZXDFjt/yGMi+GfRiGPHJEMASy5V6M
         OYnAAtAOCjcS59fS1l/Pv9YWODqRorL3ebdzxHiKFevEEgLrye1QNqw0wXlWLxXRf4QJ
         7RZw==
X-Gm-Message-State: AOJu0YzSkGkJD0CKSWr4JgneSp4Bv9iKOxQXgfNh7MAyixMH63GWbnxI
	+hfORpyYhwfQZvYASUyRBWFhtV3Z8e1a/e3x3hdlY86e9+bTZF8nLumndICK7K3w9tzt6pzhKPF
	hqxs=
X-Google-Smtp-Source: AGHT+IFRsxDPhQukwsRatPWjkbCZzUI81wGqrG64PdPDsUZYlqkTeRTWOAUHwIuFkrcrz0fsn/7WHQ==
X-Received: by 2002:a05:6214:1308:b0:69b:16d5:a8ac with SMTP id pn8-20020a056214130800b0069b16d5a8acmr15989279qvb.4.1714423460761;
        Mon, 29 Apr 2024 13:44:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l1-20020a0ce841000000b006a0cda0f4ddsm1353279qvo.34.2024.04.29.13.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:44:20 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:44:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/23] pack-bitmap: extra trace2 information
Message-ID: <5fac186df641f86814063c9df31f1184056a70ad.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

Add some extra trace2 lines to capture the number of bitmap lookups that
are hits versus misses, as well as the number of reachability roots that
have bitmap coverage (versus those that do not).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e61058dada6..1966b3b95f1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -116,6 +116,10 @@ struct bitmap_index {
 
 static int pseudo_merges_satisfied_nr;
 static int pseudo_merges_cascades_nr;
+static int existing_bitmaps_hits_nr;
+static int existing_bitmaps_misses_nr;
+static int roots_with_bitmaps_nr;
+static int roots_without_bitmaps_nr;
 
 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 {
@@ -1040,10 +1044,14 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 
 	partial = bitmap_for_commit(bitmap_git, commit);
 	if (partial) {
+		existing_bitmaps_hits_nr++;
+
 		bitmap_or_ewah(data->base, partial);
 		return 0;
 	}
 
+	existing_bitmaps_misses_nr++;
+
 	bitmap_set(data->base, bitmap_pos);
 	if (apply_pseudo_merges_for_commit_1(bitmap_git, data->base, commit,
 					     bitmap_pos))
@@ -1099,8 +1107,12 @@ static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
 {
 	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
 
-	if (!or_with)
+	if (!or_with) {
+		existing_bitmaps_misses_nr++;
 		return 0;
+	}
+
+	existing_bitmaps_hits_nr++;
 
 	if (!*base)
 		*base = ewah_to_bitmap(or_with);
@@ -1407,8 +1419,12 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 			object->flags &= ~UNINTERESTING;
 			add_pending_object(revs, object, "");
 			needs_walk = 1;
+
+			roots_without_bitmaps_nr++;
 		} else {
 			object->flags |= SEEN;
+
+			roots_with_bitmaps_nr++;
 		}
 	}
 
@@ -1975,6 +1991,14 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			   pseudo_merges_satisfied_nr);
 	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_cascades",
 			   pseudo_merges_cascades_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/hits",
+			   existing_bitmaps_hits_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/misses",
+			   existing_bitmaps_misses_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_with_bitmap",
+			   roots_with_bitmaps_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_without_bitmap",
+			   roots_without_bitmaps_nr);
 
 	return bitmap_git;
 
-- 
2.45.0.23.gc6f94b99219

