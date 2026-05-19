Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA2400E1A
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207175; cv=none; b=ZKw/HtQHso6avLIw/zgGnSFC26rZhLVQwFiAlDwOKxLBCqZAi3LAXXPQFEDBSVIkqGYWFDtn1aCUpYJOAKtP9XwKi+zzPieWCzKdC0RAQ76wBwUgfJJXhFhvzkWLtO4VrEdGHRZykCLieFIXEYGlP9mA9T50ohJEUewGOlUAd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207175; c=relaxed/simple;
	bh=5ludknjU9bx8sGbwLRtQucVaYAArn2UiUJKkgD5GnSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP8tKYXUrOH2aesnN/ZCXVfFcr0JG6vV3uTO/xVSTl2eR7b0cxgU7fMfOIGDGuTQ7vF6FXG6l6ev7yfCuYQS9Trk6sX43E2lGPsT39f6L5GQQoUb/9F8djb6ur8obdvfvZPCgTlkgIhcMOhw9bmc8c1hY4uAUBbAJa11+UT0sSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hIW7hVRl; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hIW7hVRl"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c37eafcbeso4152424d50.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207172; x=1779811972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvI2LadfSqDZo05T/HVPlbrxnMIWr6fsyCHVXtxQZ9Y=;
        b=hIW7hVRlR5zm5H8nwmUrB/UDFynm5NDppCWqVBoNUn+K9YnmOr9CcCxXM5VMvfWI5K
         MdqTSXgj9C4r5OGy+2jqG3PiRiBmgSv97XkQeFomfZ8umXyTjDToA7URbxshl7JUTQNZ
         yiDoSXVNl/KuT1s/Ub3SVs1/SxB3maPT+r2qn2h1FQnK/opN5Tw5MpbMjjXSGpbazh9n
         9cTgwNQlobmZ7pIw8Y/DmDlbKi/wFVJLGSv0WwHokvcsRhuKGp94cfTtMXrWXdVpHc3Z
         lTbdzMU7STOAWzX0cz+N+b4bP2XciUkfEEug0QE221PK+DCD/U44AlY7Pil3VA68IGrr
         QUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207172; x=1779811972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvI2LadfSqDZo05T/HVPlbrxnMIWr6fsyCHVXtxQZ9Y=;
        b=J8fU3LdFt8kTcnuE3ATnLy7y6qqSlazjWbfwNTjsI9MrW0Y++wqzlJ0rUMvVn6A8vu
         HqS/gX+Ai845L5K8Qe6XFmGP1ohwVDjsfaArdWzLPhGjA7UKgV0ushgZT0Slt3ZbCvmp
         sLTe0ESuNAKxf2aWmue5s/csORNwcedhX+wz9yWMSO+7X5MPb8XC/eWvZ0mCZVgGtOTz
         FLogt0MLeBBRN0UhDnVmvqxKSG2Ce1bFEDnWI0hZpZSpC8FHdW4f6cG1wErZZSbz3T5+
         1ulG5lJv0Ffq/Dk2ynqJq9IVUD5djhOg6e7mPuUWTGoxXvdq2C3+6tp5m9/s03fQEurz
         x17Q==
X-Gm-Message-State: AOJu0YxWPcb5jj5SLHdbj01XUlUtYs20pQUtxFFYpUGjx+sKxmTelRcg
	Qj5yzA1JHYLIfnNYLjrbUxH7Bqt3wYos8mUXNAVj2/g7ybyx+Rlu/8c81+AxFqq2+zSxHwlioMr
	eh3R2R0CUvQ==
X-Gm-Gg: Acq92OH4dUVU1hOzU4qv//QuX0ozgWsCmNyoWmEo1MAnUOs27LbLzTkkkn6tZfMRFX7
	XrmjHSYTeB7qGMbv15DCPdU31qb8RLegx8aFbgKoYBcg2YmpOrvhTkVudmpj1nYvIHJXChmT5fi
	v3102AY1jp/cA6tbqJfu/8N2H/3phZXkmABCyJ3xt6gJ36bFeHcpRGfeJ0hYE2X/RSSkdSpXLmS
	E60wrapwLpkDS3iYP6lRtDlPobzv/xHHOgU6FBUvbnakHKT4g3EJKdBikr6YSm0tmWjnkTvzYrm
	YIX+yzXYW5Kj4EfXMPTirPABsaD0Vc3nbAtVU6jHvahgYkAi/u79U8nD2uDmEnKVJ1BHu0XWKTf
	qHEpymTd73TZjUo+W6J2utrnApgLsKdTOL+kWQvHv4YdneS5pO/R7JoxnOnXO7XbU9KAPLH/YqJ
	iEotVq0a9+jjxCrWU6VXewftB3FoC3hV1hzefcum8t/B6Alw952b3tQlwWJrJ7C/4OYJtQI+jIB
	Nx1M7WLlUZp+7lkO3lar/+xpMcDWg5+zAmw9WpTHCvszywHzoApyprJ5DyDHYvok/m+kZpt3csk
	xBAemuJaFQli3+43
X-Received: by 2002:a05:690e:1541:10b0:654:1261:8b3f with SMTP id 956f58d0204a3-65e226df33cmr16350157d50.16.1779207171666;
        Tue, 19 May 2026 09:12:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db69f26sm8023440d50.17.2026.05.19.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:51 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 6/8] pack-bitmap: sort bitmaps before XORing
Message-ID: <b0a4f31353a7053ab37b6d8c8f22c69bcfadfe50.1779207127.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779207127.git.me@ttaylorr.com>

Reachability bitmaps may be stored as XORs against nearby bitmaps, up to
10 away. However, when callers provide selected commits in an arbitrary
order, the writer may miss good ancestor/descendant pairs and produce
much larger bitmap files without changing query coverage.

Sort the selected bitmaps in date order (from oldest to newest) before
computing XOR offsets, leaving pseudo-merge bitmaps alone (which we will
deal with separately in following commits).

On our same testing repository from previous commits, this change shrunk
our selection of 1,261 bitmaps from ~635.46 MiB to 176.4 MiB for a
~72.24% reduction in the on-disk size of our *.bitmap file. The time to
generate the smaller bitmap file decreased by ~3.69 seconds, though this
is likely mostly noise.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4b6fb07edd7..66282ea14b5 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -327,11 +327,40 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 	return 0;
 }
 
+static int bitmapped_commit_date_cmp(const void *_a, const void *_b)
+{
+	const struct bitmapped_commit *a = _a;
+	const struct bitmapped_commit *b = _b;
+
+	if (a->commit->date < b->commit->date)
+		return -1;
+	if (a->commit->date > b->commit->date)
+		return 1;
+	return 0;
+}
+
 static void compute_xor_offsets(struct bitmap_writer *writer)
 {
 	static const int MAX_XOR_OFFSET_SEARCH = 10;
 
 	int i, next = 0;
+	int nr = bitmap_writer_nr_selected_commits(writer);
+
+	if (nr > 1) {
+		QSORT(writer->selected, nr, bitmapped_commit_date_cmp);
+
+		for (i = 0; i < nr; i++) {
+			struct bitmapped_commit *stored = &writer->selected[i];
+			khiter_t hash_pos = kh_get_oid_map(writer->bitmaps,
+							   stored->commit->object.oid);
+
+			if (hash_pos == kh_end(writer->bitmaps))
+				BUG("selected commit missing from bitmap map: %s",
+				    oid_to_hex(&stored->commit->object.oid));
+
+			kh_value(writer->bitmaps, hash_pos) = stored;
+		}
+	}
 
 	while (next < writer->selected_nr) {
 		struct bitmapped_commit *stored = &writer->selected[next];
-- 
2.54.0.rc1.84.g30ce254312c

