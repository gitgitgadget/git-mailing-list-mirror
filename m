Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5A17C7
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqr1LIzk"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286B7D57
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:10 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50906f941so73523211fa.2
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320367; x=1699925167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov6LLY1+9QU9T2oU59Rg82Xl3H1J8zky5ITUaLIF2TU=;
        b=Bqr1LIzkYzRCV6GFTvKBHdffJbi8tZP84u/HFpt69fOGXegXsxLhLErxxbpcJYuZ6Q
         yO4hGCgEXG8EBUV2L3U3wWbvnqNXuPe/Hst0G4ZgXnHRh51SnQRfKXhXw+A20HpJ7EjY
         lYNh+Y/w7AuHToUBlaHddAl7FhZ2FPWP0rcozR+RuRdJRdvt7lgkMeaKzdZCcGIHsKo8
         8vxP2J1L+B89EOBMgTfnAb+LC3oUSCKKR7kjomPnISaO8/dble+tFvjo98Z06bq6z9dl
         faEAHiTYnopO18i9voIHx1xkOSOIMGCuQDeKy2IRVRqzKwlHhVpAfKC6OxUGTxaaog1v
         6q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320367; x=1699925167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov6LLY1+9QU9T2oU59Rg82Xl3H1J8zky5ITUaLIF2TU=;
        b=cEKX9DI7tTpebBDM4VDMrT1RFN8CJX2Tmbt+6czc3ivjjd+fPgJKe4+N/5RMiANGE9
         JlRC/qPyOhr020mODeWXKkCHgyo1W5LsJKAMADQk6ykEgwEqmvR/wHBh04zpJtrCU986
         vlhcazZsVfFQsTgFY3js/aHGAAA/ml30jpCk+3TEyBUr+DnwIQuyNuB+rz34JYunRH2h
         0CrIivfpPBdjnWofLF3SjImhCqCrXNnzfqf/mE+Jqn+W7tAkxwzam5TSJkfyK4jTsItX
         pipPddwGlJO9sv4QjcZwA0xUVeO7tMhcH4TT/HgK/j2MvgooB5xluohzc+9kRlbzbQ40
         XYOA==
X-Gm-Message-State: AOJu0YxxghU93FQ66aBT6GmB3hUPH/yhQaG9uM8+dXEuJJhtgr4oHgMD
	NVA2CKjhDHuyJl/4eUTZ3Ix7QsfOhwc=
X-Google-Smtp-Source: AGHT+IGephHkD+q1hXgiRsGeqaZ2tO4KSn4zfoJdU59fVcAb0yjdjU5AYktlYJi0cRmLReoXC+Twdw==
X-Received: by 2002:ac2:4189:0:b0:509:5d4a:c53a with SMTP id z9-20020ac24189000000b005095d4ac53amr6143078lfh.28.1699320367372;
        Mon, 06 Nov 2023 17:26:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d68c1000000b0032da022855fsm897255wrw.111.2023.11.06.17.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:07 -0800 (PST)
Message-ID: <6c66445ee31dd4117e1384d8da7be81f401317b3.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:56 +0000
Subject: [PATCH 4/9] ref-filter.h: move contains caches into filter
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Move the 'contains_cache' and 'no_contains_cache' used in filter_refs into
an 'internal' struct of the 'struct ref_filter'. In later patches, the
'struct ref_filter *' will be a common data structure across multiple
filtering functions. These caches are part of the common functionality the
filter struct will support, so they are updated to be internally accessible
wherever the filter is used.

The design used here is mirrors what was introduced in 576de3d956
(unpack_trees: start splitting internal fields from public API, 2023-02-27)
for 'unpack_trees_options'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 ref-filter.c | 14 ++++++--------
 ref-filter.h |  6 ++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7250089b7c6..5129b6986c9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2764,8 +2764,6 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 struct ref_filter_cbdata {
 	struct ref_array *array;
 	struct ref_filter *filter;
-	struct contains_cache contains_cache;
-	struct contains_cache no_contains_cache;
 };
 
 /*
@@ -2816,11 +2814,11 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 			return 0;
 		/* We perform the filtering for the '--contains' option... */
 		if (filter->with_commit &&
-		    !commit_contains(filter, commit, filter->with_commit, &ref_cbdata->contains_cache))
+		    !commit_contains(filter, commit, filter->with_commit, &filter->internal.contains_cache))
 			return 0;
 		/* ...or for the `--no-contains' option */
 		if (filter->no_commit &&
-		    commit_contains(filter, commit, filter->no_commit, &ref_cbdata->no_contains_cache))
+		    commit_contains(filter, commit, filter->no_commit, &filter->internal.no_contains_cache))
 			return 0;
 	}
 
@@ -2989,8 +2987,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	save_commit_buffer_orig = save_commit_buffer;
 	save_commit_buffer = 0;
 
-	init_contains_cache(&ref_cbdata.contains_cache);
-	init_contains_cache(&ref_cbdata.no_contains_cache);
+	init_contains_cache(&filter->internal.contains_cache);
+	init_contains_cache(&filter->internal.no_contains_cache);
 
 	/*  Simple per-ref filtering */
 	if (!filter->kind)
@@ -3014,8 +3012,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			head_ref(ref_filter_handler, &ref_cbdata);
 	}
 
-	clear_contains_cache(&ref_cbdata.contains_cache);
-	clear_contains_cache(&ref_cbdata.no_contains_cache);
+	clear_contains_cache(&filter->internal.contains_cache);
+	clear_contains_cache(&filter->internal.no_contains_cache);
 
 	/*  Filters that need revision walking */
 	reach_filter(array, &filter->reachable_from, INCLUDE_REACHED);
diff --git a/ref-filter.h b/ref-filter.h
index d87d61238b7..0db3ff52889 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "string-list.h"
 #include "strvec.h"
+#include "commit-reach.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -75,6 +76,11 @@ struct ref_filter {
 		lines;
 	int abbrev,
 		verbose;
+
+	struct {
+		struct contains_cache contains_cache;
+		struct contains_cache no_contains_cache;
+	} internal;
 };
 
 struct ref_format {
-- 
gitgitgadget

