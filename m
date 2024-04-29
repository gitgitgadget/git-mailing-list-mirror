Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABED178CC9
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423441; cv=none; b=GAtz3+zwP1d3IUMDPklWIpIL/lUMeP43/kr7bV9RXMK6agC0aYsiIhNcLYuFQpjOgcH2Zv//rfNU9SKP4LePjJDA3HPkDDG8pcGW47VKsdqYxoO6q9nD1P9ImD14DPVKnlnk4TQWvSdn6R2FuDNcmm8X3sptwpFX4Qq8UBS/h44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423441; c=relaxed/simple;
	bh=lfXWrOzhxJNC3jMCytXQzIXYiiVNQO1rGJ+IS7Uv5Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyM/kqKn+au92T6so4Cg6OZO3eGIcExB8pCVkzji1h5EP4poPepW9z5sc7yYSJzGLGNF6iKlCIRDo0o/EMubEr77Dqw5MFE6TqpHRetyd1zcVKkbhNly+L8+tJM9vaDUxmGx7FLGswdCeAgCi3YlL7FC6q+tn7vHvq8OTLXWLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vAb5c//6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vAb5c//6"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6a073f10e25so26626836d6.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423438; x=1715028238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQlkjKJe8kxy7uAvSD0ZpgVrwHZXTzknaiQ7fV9DxyM=;
        b=vAb5c//69TfYtW69fCWoI9ldisja0M96G/INXJ79waVczIfiQssrMQtiIhmpocKBWj
         hb8aimTvWNUkXwb3H/w7RWErCrsLWkjE6kuCH7UI2tan2x0RIEj8+IFhipUevVoli9IN
         ru+DhsbKNeFzjCbO4V4AxfD62u9vrPpTGkNxPlH0x1ikO+jn9+3Q8xqyj38Nigu2EaZp
         Ri514XCEPcHPTf5Mjrcul3xnHBbVmjpKxUgNjaGGV6+MN4IRcdFGCZZPwM15QWhxkBWa
         Q37EXVcWb94+ZJ2ugiw8c2lHqo41SWNQmmR3AabnsfceQgssn8Mmx01GMLsImZazwuLR
         k3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423438; x=1715028238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQlkjKJe8kxy7uAvSD0ZpgVrwHZXTzknaiQ7fV9DxyM=;
        b=hlzdss2ef+5hoCjEMxSVT5apY/+/yoIR/AqDF1nT7WsI1VkvQ6PxHe5cl+fgOd1Zfx
         QZ5yEyDtK2UdimtuOR0dyL7bJohqxnTDg54L8xtUA9NZwjoB19LmHfw/ijooYZkAjG8T
         OC3sTfy9b58dR6i4zU83/HYA93GkI857wxQWfsSnz3wue7idV7hboQ54MTMs4ShH3V/K
         RyIkOTseRAj6ulTejaeSJocbVvlvS/z3058uawdiY7ldeS2QMy4BnEeFji/fq8GmH963
         PBqI515jInY+ys9BkWuBUVBx8EBXOowgLqrvVI6zpEtKea82VBJFP4L7HGwybGesuiuf
         hRKw==
X-Gm-Message-State: AOJu0YwYptgAYEj2wcAkdimm+1Au7sDmfukJ0EzYrbG77MfV7ywdnsaC
	dpey+Z//J513LyliX1mXpO82TfFSxrjDU4KVIR1xIDzqvnhXGQPl1+NbmDVB7D65F5Vn2Vc+3b5
	HB5E=
X-Google-Smtp-Source: AGHT+IEuNXguoVl8r7OVuZ0bS+goCENH3a9iQPavmcnHQLqCi6WRuSx7xKQ+1CIkMs/+Y8XrEHVRHA==
X-Received: by 2002:a05:6214:21cd:b0:6a0:cc66:3c74 with SMTP id d13-20020a05621421cd00b006a0cc663c74mr5539866qvh.18.1714423438253;
        Mon, 29 Apr 2024 13:43:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id qd25-20020ad44819000000b006a0d991c638sm444052qvb.104.2024.04.29.13.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:57 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/23] pack-bitmap.c: read pseudo-merge extension
Message-ID: <5894f3d536980abbb4115aa842e27995e93326af.1714422410.git.me@ttaylorr.com>
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
2.45.0.23.gc6f94b99219

