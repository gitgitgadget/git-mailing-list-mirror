Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129651CD0C
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591736; cv=none; b=l8W/gAFG5QNuouc18t4hHeXZg2zWqXBCXusBmm+n15S3GuLO9taHyYdciODfEuglRweRAezWH34Ri+Zgnt5oto9UTuYoTuto3criw5j8IKpdmmMwHK/kUss7LDAqddQzwKf6wmPP4JfvQt9Qliox34HokgLcDj90FcgEiB+Qg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591736; c=relaxed/simple;
	bh=Sg8zCek/5I9OX3ceeQd92PXLJDue6LZPoUcUSXdx71Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTyBVeU6aS6mvWbctqEN8StfcdgBik6tdRFyuX93D4eWTtH4S8vPQa6ihah8OBJSVS19cp8G5nTXVHyNs/6VlGNBUG62FQk12C5NXgBATEUrUmZyFCfva5w9Tw3yaVG8/36JMokhiK5ZnDePO0dqI6ZNQstV8pIQUHD4AI4WwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oEhLjIy0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oEhLjIy0"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee3fc6fbc1so6997857b3.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 05:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731591733; x=1732196533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wwClAEvBFzQW5CAsSD/dwakCr0/upzFWq71KvPHzp4=;
        b=oEhLjIy0NTi+Uv218S9t8bwtyHL6kUKTylE81AunULeyW4ESlHRQDbPHJoud/tt5JK
         qu05WwV0CqNlfCJmMwlGG4OJ/CkTBCkqbP1m7RrYFwr00QxRRMC02vg8RFwgnuyJ4vJ9
         IFKH4mhfrgeGpYnzDktHtrN5OirIjLnnAuWuIau7lM40hUcSEeUmNrivsb11khPhG0dK
         Nfo9/lfHLda4j5HZAVuD6OvcAM1iD+jDywPgod65MmK8yX9ansp0+ErRLC1Vlgo/weuq
         rUYpIafvuWGt3pHwoO252QqrbjGN0/JumD9hCwxH52o7oTjCD6bA7LlkZCgBbnLIkvQW
         fViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591733; x=1732196533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wwClAEvBFzQW5CAsSD/dwakCr0/upzFWq71KvPHzp4=;
        b=QYVwxz1S+aa0dGTCiGH/csZC6npMglnn9x4v/S7/Y8Erehk5x9U55QIAkVOo4V8neT
         Kgr5D5qD85IQ1+2XCHO+s/e9QXM+1sPPrepevgq50n8PjUlb2miiJuE9FERtEOHb9QgY
         QbqK6Z3sSZ2lZ1Bl5Zi9V9cVyM8IJFQOtgnfdVSyYq37Cccz+O+R6FGUCM2vtZZARQMT
         wL2XhJUAgXUc4EsbGA6SbnvTCHK/D8TL4AKPs6opoqI8MLlcKQIMNnThyyJXPBHoaIUl
         zxx5Q5j2JVFzRq+j2A9jfNgObDVJI6LtchiQQa2dL6fuMB1QHxMT8VwbrJkcH13P95VH
         ylfw==
X-Gm-Message-State: AOJu0YwkohZGzQRfbeOjNhD8gxeJ5UyKRjl6QqmiZzlbg+mfmVAiSSyU
	btiBFaKTQZ/ZkRAbB9Oj6XVzZnmj+g2ttxC3j37pdzWI23MCid0hscXqvfEtPfKUgdiE8A3Ho94
	06eI=
X-Google-Smtp-Source: AGHT+IHT1qlQBuISOO/hbtdUjBbsaQjNj3wmWj+FdkhYiwVaZR6WUCshyNnsqGsMS/ijl/KJBSrbhw==
X-Received: by 2002:a05:690c:3589:b0:664:74cd:5548 with SMTP id 00721157ae682-6ee3c53f67bmr34095527b3.1.1731591733573;
        Thu, 14 Nov 2024 05:42:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4400da83sm2370667b3.22.2024.11.14.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:42:13 -0800 (PST)
Date: Thu, 14 Nov 2024 08:42:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/2] pack-objects: only perform verbatim reuse on the
 preferred pack
Message-ID: <d73b8fe2d63c8ad08ad0c4ffeffb5ee2509b2d50.1731591708.git.me@ttaylorr.com>
References: <cover.1731518931.git.me@ttaylorr.com>
 <cover.1731591708.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731591708.git.me@ttaylorr.com>

When reusing objects from source pack(s), write_reused_pack_verbatim()
is responsible for reusing objects whole eword_t's at a time. It works
by taking the longest continuous run of objects from the beginning of
each source pack that the caller wants, and reuses the entirety of that
section from each pack.

This is based on the assumption that we don't have any gaps within the
region. This assumption relieves us from having to patch any
OFS_DELTAs, since we know that there aren't any gaps between any delta
and its base in that region.

To illustrate why this assumption is necessary, suppose we have some
pack P, which has objects X, Y, and Z. If the MIDX's copy of Y was
selected from a pack other than P, then the bit corresponding to object
Y will appear earlier in the bitmap than the bits corresponding to X and
Z.

If pack-objects already has or will use the copy of Y from the pack it
was selected from in the MIDX, then it is an error to reuse all objects
between X and Z in the source pack. Doing so will cause us to reuse Y
from a different pack than the one which represents Y in the MIDX,
causing us to either:

 - include the object twice, assuming that the caller wants Y in the
   pack, or

 - include the object once, resulting in us packing more objects than
   necessary.

This regression comes from ca0fd69e37 (pack-objects: prepare
`write_reused_pack_verbatim()` for multi-pack reuse, 2023-12-14), which
incorrectly assumed that there would be no gaps in reusable regions of
non-preferred packs.

Instead, we can only safely perform the whole-word reuse optimization on
the preferred pack, where we know with certainty that no gaps exist in
that region of the bitmap. We can still reuse objects from non-preferred
packs, but we have to inspect them individually in write_reused_pack()
to ensure that any gaps that may exist are accounted for.

This allows us to simplify the implementation of
write_reused_pack_verbatim() back to almost its pre-multi-pack reuse
form, since we can now assume that the beginning of the pack appears at
the beginning of the bitmap, meaning that we don't have to account for
any bits up to the first word boundary (like we had to special case in
ca0fd69e37).

The only significant changes from the pre-ca0fd69e37 implementation are:

 - that we can no longer inspect words up to the end of
   reuse_packfile_bitmap->word_alloc, since we only want to look at
   words whose bits all correspond to objects in the given packfile, and

 - that we return early when given a reuse_packfile which is not
   preferred, making the call a noop.

In the future, it might be possible to restore this optimization if we
could guarantee that some reuse packs don't contain any gaps by
construction (similar to the "disjoint packs" idea in very early
versions of multi-pack reuse).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c      | 101 +++++++++++++++---------------------
 t/t5332-multi-pack-reuse.sh |   2 +-
 2 files changed, 44 insertions(+), 59 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 08007142671..f413344e90c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1100,78 +1100,64 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 
 static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 					 struct hashfile *out,
-					 off_t pack_start,
 					 struct pack_window **w_curs)
 {
-	size_t pos = reuse_packfile->bitmap_pos;
+	size_t pos = 0;
 	size_t end;
 
-	if (pos % BITS_IN_EWORD) {
-		size_t word_pos = (pos / BITS_IN_EWORD);
-		size_t offset = pos % BITS_IN_EWORD;
-		size_t last;
-		eword_t word = reuse_packfile_bitmap->words[word_pos];
-
-		if (offset + reuse_packfile->bitmap_nr < BITS_IN_EWORD)
-			last = offset + reuse_packfile->bitmap_nr;
-		else
-			last = BITS_IN_EWORD;
-
-		for (; offset < last; offset++) {
-			if (word >> offset == 0)
-				return word_pos;
-			if (!bitmap_get(reuse_packfile_bitmap,
-					word_pos * BITS_IN_EWORD + offset))
-				return word_pos;
-		}
-
-		pos += BITS_IN_EWORD - (pos % BITS_IN_EWORD);
-	}
-
-	/*
-	 * Now we're going to copy as many whole eword_t's as possible.
-	 * "end" is the index of the last whole eword_t we copy, but
-	 * there may be additional bits to process. Those are handled
-	 * individually by write_reused_pack().
-	 *
-	 * Begin by advancing to the first word boundary in range of the
-	 * bit positions occupied by objects in "reuse_packfile". Then
-	 * pick the last word boundary in the same range. If we have at
-	 * least one word's worth of bits to process, continue on.
-	 */
-	end = reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr;
-	if (end % BITS_IN_EWORD)
-		end -= end % BITS_IN_EWORD;
-	if (pos >= end)
+	if (reuse_packfile->bitmap_pos) {
+		/*
+		 * We can't reuse whole chunks verbatim out of
+		 * non-preferred packs since we can't guarantee that
+		 * all duplicate objects were resolved in favor of
+		 * that pack.
+		 *
+		 * Even if we have a whole eword_t worth of bits that
+		 * could be reused, there may be objects between the
+		 * objects corresponding to the first and last bit of
+		 * that word which were selected from a different
+		 * pack, causing us to send duplicate or unwanted
+		 * objects.
+		 *
+		 * Handle non-preferred packs from within
+		 * write_reused_pack(), which inspects and reuses
+		 * individual bits.
+		 */
 		return reuse_packfile->bitmap_pos / BITS_IN_EWORD;
+	}
 
-	while (pos < end &&
-	       reuse_packfile_bitmap->words[pos / BITS_IN_EWORD] == (eword_t)~0)
-		pos += BITS_IN_EWORD;
+	/*
+	 * Only read through the last word whose bits all correspond
+	 * to objects in the given packfile, since we must stop at a
+	 * word boundary.
+	 *
+	 * If there is no whole word to read (i.e. the packfile
+	 * contains fewer than BITS_IN_EWORD objects), then we'll
+	 * inspect bits one-by-one in write_reused_pack().
+	 */
+	end = reuse_packfile->bitmap_nr / BITS_IN_EWORD;
+	if (reuse_packfile_bitmap->word_alloc < end)
+		BUG("fewer words than expected in reuse_packfile_bitmap");
 
-	if (pos > end)
-		pos = end;
+	while (pos < end && reuse_packfile_bitmap->words[pos] == (eword_t)~0)
+		pos++;
 
-	if (reuse_packfile->bitmap_pos < pos) {
-		off_t pack_start_off = pack_pos_to_offset(reuse_packfile->p, 0);
-		off_t pack_end_off = pack_pos_to_offset(reuse_packfile->p,
-							pos - reuse_packfile->bitmap_pos);
+	if (pos) {
+		off_t to_write;
 
-		written += pos - reuse_packfile->bitmap_pos;
+		written = (pos * BITS_IN_EWORD);
+		to_write = pack_pos_to_offset(reuse_packfile->p, written)
+			- sizeof(struct pack_header);
 
 		/* We're recording one chunk, not one object. */
-		record_reused_object(pack_start_off,
-				     pack_start_off - (hashfile_total(out) - pack_start));
+		record_reused_object(sizeof(struct pack_header), 0);
 		hashflush(out);
 		copy_pack_data(out, reuse_packfile->p, w_curs,
-			pack_start_off, pack_end_off - pack_start_off);
+			sizeof(struct pack_header), to_write);
 
 		display_progress(progress_state, written);
 	}
-	if (pos % BITS_IN_EWORD)
-		BUG("attempted to jump past a word boundary to %"PRIuMAX,
-		    (uintmax_t)pos);
-	return pos / BITS_IN_EWORD;
+	return pos;
 }
 
 static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
@@ -1183,8 +1169,7 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 	struct pack_window *w_curs = NULL;
 
 	if (allow_ofs_delta)
-		i = write_reused_pack_verbatim(reuse_packfile, f, pack_start,
-					       &w_curs);
+		i = write_reused_pack_verbatim(reuse_packfile, f, &w_curs);
 
 	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
 		eword_t word = reuse_packfile_bitmap->words[i];
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index d87ea0ae19b..e9d80186ec6 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -259,7 +259,7 @@ test_expect_success 'duplicate objects' '
 	)
 '
 
-test_expect_failure 'duplicate objects with verbatim reuse' '
+test_expect_success 'duplicate objects with verbatim reuse' '
 	git init duplicate-objects-verbatim &&
 	(
 		cd duplicate-objects-verbatim &&
-- 
2.46.0.421.g159f2d50e75
