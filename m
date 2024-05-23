Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7CD128807
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499620; cv=none; b=TEXp1USbzausr+ZFtHQq8keiPdz68SrYouxktwwGaJeGKjDHO0YYbRLD7g1c2680EASBncE/l9miGseLZiciseQdOJaWPcjznvjKW9DEZttp7415Cp20zA+kc4LQ3zZyw09COt2w7Z38r2H2X/rGL2SX4QaIr43lWYG21cSiOLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499620; c=relaxed/simple;
	bh=Ayb/a+SMRANBR1ZiKPhvtui3V1wY4+opEJor5SJiQ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFutQgbD7H45hacGsthsXYOwXQIZGsmsd/V4xV7/ZVVT6gcvHXYHASWJsXvBiW8Y29tDfo32Lo4zmuYTGwfrsqzYYPkVJMsfi93BKwbtG4B0LJYhPgc7KQBpeIdKpy0t+hsgFnFQHv2p1Afq/JBlFN35E3eHkep304W8bE4GS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CSRot3au; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CSRot3au"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ab9d01cbc4so1478206d6.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499617; x=1717104417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uWGIB5ySfjI8LPLNonCagCjxEOlE+8mvLD+0Julcas=;
        b=CSRot3auV7hY9JGLUh3520zi/oE29nH4REiE1mqGxdWVwZev/H4yNewLdzeZobyhTu
         VyeM4q9awwCrW/G/Aeqldzl4xVcI9IYDR6Ik24GLxwTQ5myRqqiesYi7ZLj+dzNvCSDi
         fB2XWZuEfPiDBALOH0u9Cq0/LzLoZi1OMxT5LrygBiewJZElVbGpiq2uDooOaayXU0LE
         9BwdYPaft7kUNgrXIEdWuQ1yS3rAlJf0iq8ux99SDBUnpgzs0bUoZOM/5bzbl5dOLW7I
         jIRkqZOZOqdAG+rT0ISRa2nRHhfRdd/w1kJTL8ekk6tw2sFA0pQZ6NTdA6iF58z0Y5On
         ZnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499617; x=1717104417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uWGIB5ySfjI8LPLNonCagCjxEOlE+8mvLD+0Julcas=;
        b=dkeHqxWPY03/lQ1qMvMT1TW/8IDqsfzdNyM8GvBgmZgypPvlxQS0J4Kja2bFwY8Qfs
         fUdwFIjEEfG/8qr0WmVIQg38MbRGYmXVEOn3SBnZuZp+rse42yDOWTN+doLmY14BYbcu
         QyJCOu+NekudjjWgzH3bEulCwj9xhA+ymYQT75O9xIPxByYpoRgHFq7FbgAfezobQX3H
         pIQfbiKEaePLBxeYtAFjLr1yW3bhv88bG/7QDAJ5sJP1ixcfsd2JaSXfVgtC/I9gcIgQ
         sc/hLMlX+Z+3qrPFz0e003PLYipNgxmfojKutpoF+S/JypfMRfsymk4Cbqr5kIy2Brd5
         K/9g==
X-Gm-Message-State: AOJu0Yx4kG/KCijyynwIj3rJFoiQSPJbt/UStxG3NMK6sGeOJHxC3Q+i
	+CYarVWa4y9qlloyGl9b1Qn8iJgxjqvqMKuqxx3dYr9tP5eF/az0OBI9XkiL1f63Km9wJk5s4U8
	u
X-Google-Smtp-Source: AGHT+IG0z0GOzossSoOLovVKbV80sUAL3eBkEz8CgK8whnn2hR/u/ZCjP6eJPhFqXouOuDgxp+WbJQ==
X-Received: by 2002:a05:6214:4a81:b0:6aa:8aef:dfae with SMTP id 6a1803df08f44-6abcdaa9e5fmr4652306d6.55.1716499617172;
        Thu, 23 May 2024 14:26:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070f4b7dsm609046d6.67.2024.05.23.14.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:56 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 15/24] pack-bitmap.c: read pseudo-merge extension
Message-ID: <fa7a948964c9d1a787ef1d9ba0d5202c099a36be.1716499565.git.me@ttaylorr.com>
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

Now that the scaffolding for reading the pseudo-merge extension has been
laid, teach the pack-bitmap machinery to read the pseudo-merge extension
when present.

Note that pseudo-merges themselves are not yet used during traversal,
this step will be taken by a future commit.

In the meantime, read the table and initialize the pseudo_merge_map
structure introduced by a previous commit. When the pseudo-merge
extension is present, `load_bitmap_header()` performs basic sanity
checks to make sure that the table is well-formed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3519edb896b..fc9c3e2fc43 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -20,6 +20,7 @@
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
+#include "pseudo-merge.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -86,6 +87,9 @@ struct bitmap_index {
 	 */
 	unsigned char *table_lookup;
 
+	/* This contains the pseudo-merge cache within 'map' (if found). */
+	struct pseudo_merge_map pseudo_merges;
+
 	/*
 	 * Extended index.
 	 *
@@ -205,6 +209,41 @@ static int load_bitmap_header(struct bitmap_index *index)
 				index->table_lookup = (void *)(index_end - table_size);
 			index_end -= table_size;
 		}
+
+		if (flags & BITMAP_OPT_PSEUDO_MERGES) {
+			unsigned char *pseudo_merge_ofs;
+			size_t table_size;
+			uint32_t i;
+
+			if (sizeof(table_size) > index_end - index->map - header_size)
+				return error(_("corrupted bitmap index file (too short to fit pseudo-merge table header)"));
+
+			table_size = get_be64(index_end - 8);
+			if (table_size > index_end - index->map - header_size)
+				return error(_("corrupted bitmap index file (too short to fit pseudo-merge table)"));
+
+			if (git_env_bool("GIT_TEST_USE_PSEUDO_MERGES", 1)) {
+				const unsigned char *ext = (index_end - table_size);
+
+				index->pseudo_merges.map = index->map;
+				index->pseudo_merges.map_size = index->map_size;
+				index->pseudo_merges.commits = ext + get_be64(index_end - 16);
+				index->pseudo_merges.commits_nr = get_be32(index_end - 20);
+				index->pseudo_merges.nr = get_be32(index_end - 24);
+
+				CALLOC_ARRAY(index->pseudo_merges.v,
+					     index->pseudo_merges.nr);
+
+				pseudo_merge_ofs = index_end - 24 -
+					(index->pseudo_merges.nr * sizeof(uint64_t));
+				for (i = 0; i < index->pseudo_merges.nr; i++) {
+					index->pseudo_merges.v[i].at = get_be64(pseudo_merge_ofs);
+					pseudo_merge_ofs += sizeof(uint64_t);
+				}
+			}
+
+			index_end -= table_size;
+		}
 	}
 
 	index->entry_count = ntohl(header->entry_count);
-- 
2.45.1.175.gcf0316ad0e9

