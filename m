Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8B19C540
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420496; cv=none; b=uzCLdFnMGkA7I/rZt9C9Mu6nt9j0rIxzwWiov7J/pR8P4/IMs7x3TLhne/fpFatCQ5jx2f+nXvAqq8rVQkMBsTsCC2HG5OlLsaJB2U822mcVzpa8LGxUSHVgwER1oKjJxS/kwgN+CNfT9gyqE5Tvx9xKnFrNFPk423uXrcJ1/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420496; c=relaxed/simple;
	bh=kC2UWlPmsfij74klVd/gG7J1Lcmv43DE/Z22RtZwunA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idlKlj9nPrJutLW3EyqiV3R6nhrMC5OPTECMcz0DsL9PrhgjSm0sHefZNgxQGRdecYoWG2aWdf7i8YKqrd1i+r2v7RxSw8PIkjVE+TNLWjZtsAimbtTk6QjUuGf4J9Ir3iyV04qOkq4pxqlsEi63vVH+r2f6vVkwyTRzq0XhbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=M7/lRCMg; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="M7/lRCMg"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-646b8d2431dso96479d50.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420493; x=1769025293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkuvjrx5gwzZ8MbB2h1N8LtqA0UU/JBo62lsD7nA+1w=;
        b=M7/lRCMgfqo1SJGzXLDfVlGmJipw0Wz0deW9f4HueWt9FLHrAGXxxd/V81/AapcdDm
         utXs6xkKcfIwX/OfY6mJ/F2CT5PkFp3E1XKB2f6TlHBROA3pJF9ySJGPPAtWs7mFvRRv
         yIpojY9zMzH9SAcRR9jqXJ5l3H/w+us4ppK2sGHxS1w6euPcuFmcEmcbFS8dQ20aDXTS
         2pb8QB7X0yCsN0w+mObC9LoOonGa7nTHUra6IxgE6IpKnCOMUFe0SNAE7Jq5uiGJU4g0
         LsTKVfj5MMPcy6Wc9JWanKKPZpugXVAObmQrzYArrZ8/ysb5eI2XwkkrNX3KMT7cncpI
         baMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420493; x=1769025293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kkuvjrx5gwzZ8MbB2h1N8LtqA0UU/JBo62lsD7nA+1w=;
        b=TPHXaWS4oazgcd2lb/ZBzLjHEXRdUVj5IyYkqf8J40TFR3BLE6bskTZuiO3wvZJ29i
         cVFAXy8MPYp+w8A+KaVKiFma6QsehG3TZurcFUIxEvQ0AYzM3j52npRs7c+Y7RoGZvXf
         48RQV3GbwaF74y4unPTMSmU9SbaolFBLKtYHwaWUrb+rd9sJxH1/qFvlnojlTEw3YEBc
         QUcGlofkWe2U1zV3ub9XUq+k0FIxfjunR6krtYrwTBD/fr2Gj/L7DJP2yHR4kulaY206
         HoU4ud5h5UqlCVZlCi+K16C3QrgLKuzV090QXvNZxHNNI8HlwQAzAzr+vu+qqxgx/Yq2
         taQg==
X-Gm-Message-State: AOJu0YyuUmJsqKoB5jnczyYzHWfHLnAlV8IAnG1TOQrADGlhsFgKHnlo
	m9TVaQImDw1pSzy/jhIb2hMxSJVB/uxQMP+2RpIDvnGdOuWkCKlRFJ2X4cAeECJ7GzCJzWk0zNH
	Y9nI2kGBJUd1v
X-Gm-Gg: AY/fxX4JmhpnR+S8cUIapLWmGwWZhxLsftK8XNqYVV1HkADfVwM7ueDVoG+o5GsMJEq
	aIDt2ZAcj1zh1wNlbCd7IICLRFAEoiuBuQKsVwB+ixKW71CmXLS/TG7RxQnek81T8wV+tlzBjen
	UTE5lQkvzFNyykNIwBmLx/PX3SZasEOXDUcgeP4G19N0FtPneYkgO5CTBcXiHW+pYaYP2iPSUdv
	ueQeCrfSRkOwM4S329SlLhNA/+m9yQE0Z6pLr9KVYiiPb4xhrQsrTrDEYmRZQcHdWFUB+XLPUd+
	jC6DlJ3ZjpZNiXcl3eI5OIyBoWeDY9ueROFitwjloO9klX4oYEBf3vhiVtyNpXLCuXrw0oEQTto
	kC6TejPTuTLgZTdqsSgy4LmjFBw15LMPHSYhAxPGFsxIIpNp5TUCI+gSM1Jo1ee3iDASJoxE2Gn
	Nzv1SLEgEmpWEnRIU9REDB3jCTviOxPPFkkPVoWxhzZ4LZH3CXzokiXv21M19Q0j3eVe2TAKNDj
	JbuUq/J3OFTC6ptAzyoVoig5ljz
X-Received: by 2002:a05:690e:11c4:b0:641:f5bc:694b with SMTP id 956f58d0204a3-64901b11096mr2849622d50.79.1768420493454;
        Wed, 14 Jan 2026 11:54:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b246fsm10802548d50.17.2026.01.14.11.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:53 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:52 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/18] midx-write.c: introduce `midx_pack_perm()` helper
Message-ID: <c11214a51f003cb45f5c48084f17b989b2cb5443.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

The `ctx->pack_perm` array can be considered as a permutation between
the original `pack_int_id` of some given pack to its position in the
`ctx->info` array containing all packs.

Today we can always index into this array with any known `pack_int_id`,
since there is never a `pack_int_id` which is greater than or equal to
the value `ctx->nr`.

That is not necessarily the case with MIDX compaction. For example,
suppose we have a MIDX chain with three layers, each containing three
packs. The base of the MIDX chain will have packs with IDs 0, 1, and 2,
the next layer 3, 4, and 5, and so on. If we are compacting the topmost
two layers, we'll have input `pack_int_id` values between [3, 8], but
`ctx->nr` will only be 6.

In that example, if we want to know where the pack whose original
`pack_int_id` value was, say, 7, we would compute `ctx->pack_perm[7]`,
leading to an uninitialized read, since there are only 6 entries
allocated in that array.

To address this, there are a couple of options:

 - We could allocate enough entries in `ctx->pack_perm` to accommodate
   the largest `orig_pack_int_id` value.

 - Or, we could internally shift the input values by the number of packs
   in the base layer of the lower end of the MIDX compaction range.

This patch prepare us to take the latter approach, since it does not
allocate more memory than strictly necessary. (In our above example, the
base of the lower end of the compaction range is the first MIDX layer
(having three packs), so we would end up indexing `ctx->pack_perm[7-3]`,
which is a valid read.)

Note that this patch does not actually implement that approach yet, but
merely performs a behavior-preserving refactoring which will make the
change easier to carry out in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 5c8700065a1..9d345fb4737 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -119,6 +119,12 @@ struct write_midx_context {
 	struct odb_source *source;
 };
 
+static uint32_t midx_pack_perm(struct write_midx_context *ctx,
+			       uint32_t orig_pack_int_id)
+{
+	return ctx->pack_perm[orig_pack_int_id];
+}
+
 static int should_include_pack(const struct write_midx_context *ctx,
 			       const char *file_name)
 {
@@ -521,12 +527,12 @@ static int write_midx_object_offsets(struct hashfile *f,
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
 
-		if (ctx->pack_perm[obj->pack_int_id] == PACK_EXPIRED)
+		if (midx_pack_perm(ctx, obj->pack_int_id) == PACK_EXPIRED)
 			BUG("object %s is in an expired pack with int-id %d",
 			    oid_to_hex(&obj->oid),
 			    obj->pack_int_id);
 
-		hashwrite_be32(f, ctx->pack_perm[obj->pack_int_id]);
+		hashwrite_be32(f, midx_pack_perm(ctx, obj->pack_int_id));
 
 		if (ctx->large_offsets_needed && obj->offset >> 31)
 			hashwrite_be32(f, MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);
@@ -627,7 +633,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
-		data[i].pack = ctx->pack_perm[e->pack_int_id];
+		data[i].pack = midx_pack_perm(ctx, e->pack_int_id);
 		if (!e->preferred)
 			data[i].pack |= (1U << 31);
 		data[i].offset = e->offset;
@@ -637,7 +643,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[data[i].nr];
-		struct pack_info *pack = &ctx->info[ctx->pack_perm[e->pack_int_id]];
+		struct pack_info *pack = &ctx->info[midx_pack_perm(ctx, e->pack_int_id)];
 		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
 			pack->bitmap_pos = i + base_objects;
 		pack->bitmap_nr++;
@@ -698,7 +704,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 		struct object_entry *to = packlist_alloc(pdata, &from->oid);
 
 		oe_set_in_pack(pdata, to,
-			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
+			       ctx->info[midx_pack_perm(ctx, from->pack_int_id)].p);
 	}
 
 	trace2_region_leave("midx", "prepare_midx_packing_data", ctx->repo);
@@ -1384,7 +1390,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 						      sizeof(*ctx.info),
 						      idx_or_pack_name_cmp);
 		if (preferred) {
-			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
+			uint32_t perm = midx_pack_perm(&ctx, preferred->orig_pack_int_id);
 			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
 					opts->preferred_pack_name);
-- 
2.52.0.457.gb599f1ad4b0

