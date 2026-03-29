Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E92FF153
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820474; cv=none; b=USIt0a+Na+t7JTc/qNrYDiIe65RgSLr25hoRtJHqbc3vOByFl3rOUd/rWIP7Pi9LvMiVIuw+uQHBXfO4kaGBgAa/toZ9jcNE/Ks4pBU/tdGNIUwOgL4pJ0eiBWMb2Y6EpjH2ALXtw1tqvHlImFW+r7mwDd7JWauJhutTh1f3Yrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820474; c=relaxed/simple;
	bh=olXPEj8RBMy6g61AUe5JDfHG/RNUgusqv4PQcCyKYC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVtBHeUwoIk4qQja68/nC9vysPnkwhsR2AY4da34trsrZVZQVhb3X1RHNoT69qNg9Sy7pEgn8o5gl3knwfoA+IxY8d4l7G6dd0WfMJEuAm/ltywBisZn9Sjky669gL8HZQ6K/+muWXv0FWSepCuxsSQ7RSN5v7vs5Msjqp6vw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BuK6JLlE; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BuK6JLlE"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501c4857b2so524184d50.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820472; x=1775425272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DWXJOUVqEKuGBigJTup/Pma71DzlKb0bt4Sj6/35nU=;
        b=BuK6JLlE/Fuqe8gJRSi3por9oVuNjz/3Zv8shzN+GKNY2Y8XeRAr2EySvumFZ5AmbU
         HcTbCcJ5fgwSDZ9dpwHHVqz8uUVZoAR0IqkN33UY7zzwkmAdTNzssdaABi7KYx1fqM4r
         IU4HUQ+/47SqQ2qEWa1F96Qam9ahdFLJsiasGE7sGsR8NEtSyf5ltupDP9c7c4Yq0bL7
         yOPf5ikGMpMnS3HXblKLrQQrcEXZmmm2bUcglCgbntVOpF6aL0ouxeNKUUYzJFx0QQkm
         IO4kdLGFy9nAhI11Ovc3L3NtV32Il2JoCBM+RpXMrMI2EHx+tmzNQxq+rudPZINiDPy3
         1yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820472; x=1775425272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DWXJOUVqEKuGBigJTup/Pma71DzlKb0bt4Sj6/35nU=;
        b=CPjm972lhlyfhxW3UnrkYrf/H2q1qbobKN+Tm8mDDPlBY+aOhNlFPg9JQqic9iSVQw
         KhVQBPc6PExXBmhvTIOYDujeCpLpzq2F56X2PFJguIsezl8X7P9Xk+XB6AjTyyJtzO/U
         NmaCBzWTvzH1bU3Se+pUYF/nOUaPITgTi/11MwIzYT7e/OTOq8BBeaFBbSWEpXe4vATg
         XmOSSEjdYL4FpNJRpCTw2tbZxW+9G0+JrwAvHVosIB+yoNGClQ3URMDbmL6pfX7AYPDp
         n9yDIwXIrDtPuvmSWIJ0X0mbdUcVD24KW50KHzhRRkZ8zvIUTP0r6+yjjlJLPDmQ6OlE
         h+RA==
X-Gm-Message-State: AOJu0Yx3xzIns9G31DeZK/5jCg4NtJ/OYbOxtEEuNR3teHsnHcmN9ScS
	n7l1d5LguYaZymvTTiOsXoMV47l1teYgML8YfRuX1QkfGYGXldqFTuCZJoltOtthdVoziHcYQBx
	x10Ty+dpsIA==
X-Gm-Gg: ATEYQzwbJQgd+Fiq51ayiVIPTKXw0rc9I5gxLFcMQWrLMr4sDobFfbz84QuPqbLs9jX
	1X7ZiQqCd40wWt03iJCPCVuD8Gg2df3gXkkJsA6YEH37B9YbHOyDjLW0OTvvl6DNj0orI8kmu6M
	himixTyAr4a6JGU6KD6fdI6AoqFCVs/VyfF3vd7FnaAUZuJLFB/4/zfQypK51W65/jzqsT4uHxZ
	MxHVs3xitZmsSRcBPkYl3035o7fLrwW1wduOm/K4evVajIbAhvpOBQ4f2kGmO97aq3FC1hPDCV6
	GpyNf7CdOz3uxBK4XXzN6hyo8cuJXJXIi7XrfjlIquyP1ZIylG7FWuCJmjOdZq11lO4O0H9xxmx
	oCqh9I/c7wfQAMdDvHCOlIk177HlDyka93hfeRN9MwYNpuhGv5441lMN7H48V9QhmTnZARSz4vP
	3oriTVa+pFUUDMZ0e5VqdSVbev16pyrGRyNVhPD/+BKmA7T0xmMc/2D6JEJDMsBLRecLTEC4dFs
	KjVxM+6pIhygMYoCH94ZOgwwrFEiQCiZeihJMnr
X-Received: by 2002:a05:690e:14cd:b0:64f:fc0d:6240 with SMTP id 956f58d0204a3-64ffc0d6391mr8972619d50.62.1774820471980;
        Sun, 29 Mar 2026 14:41:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65019b581e9sm998787d50.4.2026.03.29.14.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:11 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 08/16] midx: expose `midx_layer_contains_pack()`
Message-ID: <6af23849f1d499e7a23d1ef4a70ac3d29748e1ce.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

Rename the function `midx_contains_pack_1()` to instead be called
`midx_layer_contains_pack()` and make it accessible. Unlike
`midx_contains_pack()` (which recurses through the entire chain), this
function checks only a single MIDX layer.

This will be used by a subsequent commit to determine whether a given
pack belongs to the tip MIDX layer specifically, rather than to any
layer in the chain.

No functional changes are present in this commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 6 +++---
 midx.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index e6b1fbe37d7..7d23338aa3a 100644
--- a/midx.c
+++ b/midx.c
@@ -667,8 +667,8 @@ static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
 		      m->pack_names[*(const size_t *)b]);
 }
 
-static int midx_contains_pack_1(struct multi_pack_index *m,
-				const char *idx_or_pack_name)
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -709,7 +709,7 @@ static int midx_contains_pack_1(struct multi_pack_index *m,
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	for (; m; m = m->base_midx)
-		if (midx_contains_pack_1(m, idx_or_pack_name))
+		if (midx_layer_contains_pack(m, idx_or_pack_name))
 			return 1;
 	return 0;
 }
diff --git a/midx.h b/midx.h
index e4a75ff2bef..f211a38b9e7 100644
--- a/midx.h
+++ b/midx.h
@@ -119,6 +119,8 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid, struct pack_entry *e);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
 int prepare_multi_pack_index_one(struct odb_source *source);
 
-- 
2.53.0.729.g817728289e1.dirty

