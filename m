Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBD12BF14
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499639; cv=none; b=OYP+ZwaFEFsBQGruoMFdHDIjsTjunCfq9LWwD4z18yuHAb3fDYFnC1GReBfn55SeVNzevx0JTm1sLKkZ2VdukN2MDiqiMMOGmie+ubTXv2jbgZyyT4NEYjzgOla/jwsABLeMKCN+62GHGVie5O4p/fftkhRQKfTtaUdMpVZWUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499639; c=relaxed/simple;
	bh=7Ap27KEQ2CF+uaLPKSr20ozuzGNMkqH1p4V3Cegsr2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue6ihPsmwXz5kCVt4UPfjndp4ai8uCTG5LU0xySN0AH1DPkjxluU+wH6zZukco3sBaOjSM21NdC7hwBESYVqHNekCZQ0tJaVX+XK8Y8mgd5EYvZ1O+0LdldWbEGfEg73/NyNqYViG0Dl3Vg2uxeMrn6VjlZKsESzBV+1y7Q7HMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mmuJx35A; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mmuJx35A"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-794977cbd66so97785285a.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499637; x=1717104437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0dxg6n/02ukASUVOiwAGHAHdQCCh1PL8TcayfSPUME=;
        b=mmuJx35AZ18OMoj2g01vjoKVPwP5+q6MaoM1D0TCUjI8WSby/0zbf7ZflIUAKmo3BV
         xWFmOlD0ks4H46btpcplnPC1PsfFjvcZgYs47vAs+02vXHM36kOZwOhI1A/YIkn2EHEL
         H7hKbPIxIu5Gm35ShzoCtKo3u+/8plbXducWhxsqdd7jQv0suTBuyTTZCKBWfybCJSNK
         stSyHrqdlshZU09koT+XdHoR/LII/3qiMkl7XffAmXoAb/JRCiOd+3qEQDALnZvmivdp
         74FjXaSr8psDyyqjkQiVXOlyd4Y+Pe1sPCKYHfrPq2b0GBOYY3tEbdkTOHcDVzwNdyEV
         HnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499637; x=1717104437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0dxg6n/02ukASUVOiwAGHAHdQCCh1PL8TcayfSPUME=;
        b=n950JAeLnmerD1J0S7GfGLTFB8wDjUP6PV/wAZZvGtjGK4RhnRynwXUWTvhSIDPMO0
         5UfXLYMfaKpeip4ocMI604vFijN3xhkucvRnIJVk9i19S5OKMhue9ub9DOUBCWJLpFf3
         W/BZ9Po7hgDa5cu2XC0c3p4CFipT/Plzs5iJNMoAo9nYFig9zzj+DDwXwg2PzuG0oezI
         IpMgtR5+TerdIhd3hz3vLLdJRjDxPoYSxj2OowscKSVmNZCz7FBo+sGDJE73qBzAEOs+
         SDAGfwAwvS7LLWVd3YjPPthoV/nvbHkocbe9gtCtgoSaqQH8RN+zqOSL9LweSiCnWFua
         0JVw==
X-Gm-Message-State: AOJu0YyCoEC7JodosF6qMjXg4GhQe2L/yMtoFmI/N3V2QvZTZkSnP808
	P+HeodwqkXl4VvCdd1dT0z7XW8eRctLx2QghAZ0RwAcYr1d1AMCmu7i48JMq4ETB1Npag0EuE/B
	1
X-Google-Smtp-Source: AGHT+IG9bmzfsp7cAAhsLp3WfcpwKQa6sW39BrP04APkHlOadguHM4IWOzPtzZYqZcWc/+x76pw76g==
X-Received: by 2002:a05:620a:3709:b0:792:bf4d:6e8b with SMTP id af79cd13be357-794ab057a84mr53572485a.14.1716499636669;
        Thu, 23 May 2024 14:27:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd063f1sm2432785a.72.2024.05.23.14.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:27:16 -0700 (PDT)
Date: Thu, 23 May 2024 17:27:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 21/24] pack-bitmap: extra trace2 information
Message-ID: <9240b06a7d87e6321342a280daa74ed0e0948357.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

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
2.45.1.175.gcf0316ad0e9

