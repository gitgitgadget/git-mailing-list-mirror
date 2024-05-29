Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FD1CB31B
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023327; cv=none; b=f95kAnH6kKtX/gJEBk3AM/3lPZyzPJ5Wf1o5WPVPk/ITt+iTUTb79KQjxCq9EUQQlVgDcZt6Pfoo3A9gkxasr6dz+k2WNk4hjTWgEEwMvoa6eGoj3qiUM9LnGlLlwHEAdRw08IJ5tDel5L6zAEpJxzXkjX5dv62YLdyVjqIRpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023327; c=relaxed/simple;
	bh=IpXTMwUILuLFPACSIhLeVaJycwURNGnqr850stQJI/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN/iEH7EGB+5X7s8ReO+8jocvlYqnQa1c7A5+fx1RhimxYz3oPBqZC9KTNaMpCd4M82C0qTJ2wZCBOEz+XSBxGKjQIk/QRWF1v38rKfbBoAULd+ZCVQtwRfYQDYC8cdTwx3YUB/ll5Sx9QEj8A3mmwmz/uUm4hJHuGOl27CDqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cZPZKYY0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cZPZKYY0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-794e29c7775so23702685a.3
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023325; x=1717628125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4BDj1iFzT9mvQaAR3L1LF+fq7Hesr51hL9BkM3aDzZQ=;
        b=cZPZKYY00px46dB+8QSgufIcGmb7UhugsqIDu02HAqLldkQRR9uec6hBVYbeJgeBau
         whbJij9YIheVzsHLqYqLLGhXsyYHmASe+2ukjs9+cqVGSJIsa+WrOafhutTlnWU5rmeb
         TKqpJFVkaPHxh9NmiJbsFBW5yRcZjh5s4fVKdKCXjoAtoxn8puoIPQrP5xcZsBYDvJCm
         F45UQHq1CS5TmyI46UawP5I+2Hl92EpH+NmKycx2h59h9sqpGZbxHsr2bMwqbsnZoedQ
         gjfQlJMQoVatLEVK+cjfp6Z3vzfz+wRBQ9lEtHRPFH5Nd4/2EIkAVWI/XdMAD9Ye9rXw
         45Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023325; x=1717628125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BDj1iFzT9mvQaAR3L1LF+fq7Hesr51hL9BkM3aDzZQ=;
        b=oo5HcnuSIlhj8WcgTEXlcz5jnX01Myd4o9HbEublbvgL2mtF3JIzpBmsYFmUEUnpEP
         PZzJN0dI592MDgRGkJ3fl2xBWi48YhGNEVKJp/50reKFTObrM8ffkgQ1osXdUKghPRBG
         +Wh7QKRVQVB4WrUe2ymEie1QbUOGk4InLgqaCtXOK7hg5tCiYjmRfmRowLm21jkjBZWO
         SwkoydmB86T0HQYbIkVYrh1K2QEHCgHYIxVrKNvwApyyWDNsqvNOI1r/q+81GWCW7Sd7
         5Q18jKxobVbAcVMAoL2VaANXoqZagSiZ68HruLQ+qvLvwIHajjhpIzOpSMJWmB1or+/O
         ENqg==
X-Gm-Message-State: AOJu0YzGGgJGl7Leg//9cLhJcLZjEj4Q97FC++D4kR03F+g5x67MtSf8
	xtsQyS9ifTxFd0BencWkHEurhu+kngDK5u5LV3SlyEB8oZdFLf1LOoEOK2uVAlZoUBQ1ZL9zrVc
	KmaU=
X-Google-Smtp-Source: AGHT+IGy2AJAnVu4G6senu/LlX8um29g5SFmxnQTYLikCbUH7tdx7EE1sPeIriyMDiWFffZmxzWaYg==
X-Received: by 2002:a05:620a:284c:b0:794:bb6b:25db with SMTP id af79cd13be357-794e9dc5c41mr71496485a.33.1717023324780;
        Wed, 29 May 2024 15:55:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdbb69sm508975685a.67.2024.05.29.15.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:24 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] midx-write.c: reduce argument count for
 `get_sorted_entries()`
Message-ID: <9d422efe6e8eea13f48d3f52e4c69c94f8e72114.1717023301.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717023301.git.me@ttaylorr.com>

The function `midx-write.c::get_sorted_entries()` is responsible for
constructing the array of OIDs from a given list of packs which will
comprise the MIDX being written.

The singular call-site for this function looks something like:

    ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr,
                                     &ctx.entries_nr,
                                     ctx.preferred_pack_idx);

This function has five formal arguments, all of which are members of the
shared `struct write_midx_context` used to track various pieces of
information about the MIDX being written.

The function `get_sorted_entries()` dates back to fe1ed56f5e4 (midx:
sort and deduplicate objects from packfiles, 2018-07-12), which came
shortly after 396f257018a (multi-pack-index: read packfile list,
2018-07-12). The latter patch introduced the `pack_list` structure,
which was a precursor to the structure we now know as
`write_midx_context` (c.f. 577dc49696a (midx: rename pack_info to
write_midx_context, 2021-02-18)).

At the time, `get_sorted_entries()` likely could have used the pack_list
structure introduced earlier in 396f257018a, but understandably did not
since the structure only contained three fields (only two of which were
relevant to `get_sorted_entries()`) at the time.

Simplify the declaration of this function by taking a single pointer to
the whole `struct write_midx_context` instead of various members within
it. Since this function is now computing the entire result (populating
both `ctx->entries`, and `ctx->entries_nr`), rename it to something that
doesn't start with "get_" to make clear that this function has a
side-effect.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 591b79bcbf..15965ceb70 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -299,21 +299,16 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
-						  struct pack_info *info,
-						  uint32_t nr_packs,
-						  size_t *nr_objects,
-						  int preferred_pack)
+static void compute_sorted_entries(struct write_midx_context *ctx)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
 	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
-	struct pack_midx_entry *deduplicated_entries = NULL;
-	uint32_t start_pack = m ? m->num_packs : 0;
+	uint32_t start_pack = ctx->m ? ctx->m->num_packs : 0;
 
-	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++)
+	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++)
 		total_objects = st_add(total_objects,
-				       info[cur_pack].p->num_objects);
+				       ctx->info[cur_pack].p->num_objects);
 
 	/*
 	 * As we de-duplicate by fanout value, we expect the fanout
@@ -323,26 +318,26 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	alloc_objects = fanout.alloc = total_objects > 3200 ? total_objects / 200 : 16;
 
 	ALLOC_ARRAY(fanout.entries, fanout.alloc);
-	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
-	*nr_objects = 0;
+	ALLOC_ARRAY(ctx->entries, alloc_objects);
+	ctx->entries_nr = 0;
 
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (m)
-			midx_fanout_add_midx_fanout(&fanout, m, cur_fanout,
-						    preferred_pack);
+		if (ctx->m)
+			midx_fanout_add_midx_fanout(&fanout, ctx->m, cur_fanout,
+						    ctx->preferred_pack_idx);
 
-		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
-			int preferred = cur_pack == preferred_pack;
+		for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
+			int preferred = cur_pack == ctx->preferred_pack_idx;
 			midx_fanout_add_pack_fanout(&fanout,
-						    info, cur_pack,
+						    ctx->info, cur_pack,
 						    preferred, cur_fanout);
 		}
 
-		if (-1 < preferred_pack && preferred_pack < start_pack)
-			midx_fanout_add_pack_fanout(&fanout, info,
-						    preferred_pack, 1,
+		if (-1 < ctx->preferred_pack_idx && ctx->preferred_pack_idx < start_pack)
+			midx_fanout_add_pack_fanout(&fanout, ctx->info,
+						    ctx->preferred_pack_idx, 1,
 						    cur_fanout);
 
 		midx_fanout_sort(&fanout);
@@ -356,17 +351,16 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						&fanout.entries[cur_object].oid))
 				continue;
 
-			ALLOC_GROW(deduplicated_entries, st_add(*nr_objects, 1),
+			ALLOC_GROW(ctx->entries, st_add(ctx->entries_nr, 1),
 				   alloc_objects);
-			memcpy(&deduplicated_entries[*nr_objects],
+			memcpy(&ctx->entries[ctx->entries_nr],
 			       &fanout.entries[cur_object],
 			       sizeof(struct pack_midx_entry));
-			(*nr_objects)++;
+			ctx->entries_nr++;
 		}
 	}
 
 	free(fanout.entries);
-	return deduplicated_entries;
 }
 
 static int write_midx_pack_names(struct hashfile *f, void *data)
@@ -1060,8 +1054,7 @@ static int write_midx_internal(const char *object_dir,
 		}
 	}
 
-	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
-					 ctx.preferred_pack_idx);
+	compute_sorted_entries(&ctx);
 
 	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
-- 
2.45.1.321.gbcadaf92783

