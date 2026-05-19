Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154533BBAD
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206263; cv=none; b=ii0zsLiqLqet2PpiNZe/jB4vLbuLdCLjdJO5lQ7UcXf3zJbMLitzSf2JOKaUY/5zTrpOl0bpI7psGvptI5lcc5i7BlUoVLwWh8NkkIHi8CZoKkQwuHqFmAHtdVfcqrlPjr2U1Hp4o3DmIhcSbdGYHDTkjN3FPqGPd1wlSbSOKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206263; c=relaxed/simple;
	bh=1c9EFMeKiMcUFwFV1I9eeCnRivnWwymIe1a2+AsnIoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ2QxqS8xcXhCw6vRkD75ZrJzKRsLWGdroAMWkwzZImYMfJiEaZIVrgcywskYeFprM/lKNTFHO9GkokoHIhMZbEEmNMVOgPPrJO+IqKZNVLxuyGGoUachdqNovu+2BNiofvdXpU5VWW07WbcqLejdmqyFAPU8+z/sah3QpD/ciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=f0nLty6h; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="f0nLty6h"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7c307937816so30580597b3.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206261; x=1779811061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nIWkV8rMQ+k3LVYYUoZcEND7UFYPwejhU10oFNu8oJ8=;
        b=f0nLty6h/4dl0VFa7PK8fmhtbWRuFEVHQkJRrTZLqq5jKI+ot9x5LjMRbxaqF6gl0+
         RAPpC8pSguXuRsErr7JOBm/lapktbTGTG2Z2Q1qZ6OZ+rjxc8I2p/aZF64QOrELuS0lz
         KjCQDhzxIp+wLTo8AnHtAJECUf8Bo6Vfb5cndWhGnQ6To7ZZ/GdsQWPCiB/P2AYF5hR2
         KLt/rotIzdHsu+PrSWIPLyADEuuZ8KPsKJTX+ukDWCGY81tGatUduxQcIxzvpNlWDLyI
         ZqiXqdygbycgrFpSTtdu6bFFUbIMHvOZYdwVVdMfqgPRvdtj6jg+Lv6MuianQgBBQ1tf
         v32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206261; x=1779811061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIWkV8rMQ+k3LVYYUoZcEND7UFYPwejhU10oFNu8oJ8=;
        b=YcRbdo6rWLlOBtYV1d0C/+2V7V4yLY8Dv057DsS3vsnwCGaqvytC1MfCuLYK17sfi1
         qv6aE/g+psE654C6lGYmV2Ok4ye8mL83FetJhsCQL4vHE6Krwz+SbSWxbJbroeoMT6/y
         OmEzOCzukBVWU7DBw+jwmDO+3AcegOmg8h/7fDmuzvl9vcPvS5+byWVvq7XbP7uJbpWz
         kvYpL4dRgojtmDhMgC4CcrASgLEE1kxX8BZ4JLBGZu044RVg5HRbNK064aUg8EIsKJR0
         JGtIU5R4OajMkmIoLK6JHh/Ra1W55z7HqACtZDzLIVUYNl9pWpyvm13D/+9puXZTsq3A
         GzYg==
X-Gm-Message-State: AOJu0YxOWA00uYzgaoyAP6dICTB8b8XI1Twfw6kYVR04lQO1zHOkxWdq
	7pP63ZzHtWA2X23xbJbUVsdnP5l4w5v++5R3uA/h0hHDVjxJrktWuF3cbTr3PDkFbva11H8s2zh
	fA0bAalAD0g==
X-Gm-Gg: Acq92OEfo7fGbnZj3rlVjUKWZ9gdpM0qjA27mMO+PyXzgwXJS9t9mE7FfuZX02lpNA3
	SXW2bqxbU7R56l2rxnzpZou6ZRglyEdrWoEDTVGypfYq0HguqYvDzoj6k+FZspEo6zM4bo+ASEP
	j+0d8TeCiOkOFD6TauxBqdCFtdVujDyeNmA43QgBqJEUCx4z0Us31CZZ6DLk+AjDfy7aG8wK5Vh
	2nozU35fQOyjDlCy8yx/iVXXXXnT22mKsWopkIliDw3ny+1GP1P6eDQhdeY/lLSiTSJqv+dAhgw
	KDgl2N4HDM+rY/+JVA1uU3dBqsZs94EqxjfAqFyD4TIAZn76OkDUBRHOXbFvGjkyJzkeZJgHJWg
	dpDyKoFqYJVPWVH5r4e9urXU5nadvbEEmVMQvH+ZFLhdqHL3ivlsi+OsHKJewBqfB9rorD4PvoO
	H9c+ae9HX+aaQDnYbyUs2vBQwkMqM7OprLawlc+t99um3XaqM2AZnwypVAHzVotH81mI9Yyfo7D
	X+14sC9/EBcEl0oeKwX6Wb+UWIuJ1DyUspaA55Xm1N2dBSfRMS12METUxlFEmLyX9vpqihcZ8It
	xofKEdw3PwsHlnX+
X-Received: by 2002:a05:690c:7106:b0:7b8:3b51:c9b2 with SMTP id 00721157ae682-7c95c7ee0f9mr223601727b3.23.1779206261060;
        Tue, 19 May 2026 08:57:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18b056sm39037497b3.46.2026.05.19.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:40 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 01/16] midx-write: handle noop writes when converting
 incremental chains
Message-ID: <ead11e610c8c619de08cfd2736c12daeb2f45e20.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

When updating a MIDX, we optimize out writes that will result in an
identical MIDX as the one we already have on disk. See b3bab9d2729
(midx-write: extract function to test whether MIDX needs updating,
2025-12-10) for more details on exactly which writes are optimized out.

If `midx_needs_update()` can't rule out any of the obvious cases (e.g.,
the checksum is invalid, we're requesting a different version, or
performing compaction which always requires an update), then we compare
the packs we're writing to the packs we already know about. If there are
an equal number of packs being written as there are in any existing
MIDX layer(s), then we compare the packs by their name.

This comparison fails when we have an incremental MIDX chain with
at least two layers, since we do not recursively peel through earlier
layers, instead treating the `->pack_names` array of the tip MIDX layer
as containing all `m->num_packs + m->num_packs_in_base` packs.

Adjust this to instead look through the MIDX layers one by one when
comparing pack names. While we're at it, fix a typo above in the same
function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                            | 18 ++++++++++--------
 t/t5334-incremental-multi-pack-index.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index a25cab75aba..9328f65a201 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1152,7 +1152,7 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 
 	/*
 	 * Ensure that we have a valid checksum before consulting the
-	 * exisiting MIDX in order to determine if we can avoid an
+	 * existing MIDX in order to determine if we can avoid an
 	 * update.
 	 *
 	 * This is necessary because the given MIDX is loaded directly
@@ -1208,14 +1208,16 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 			BUG("same pack added twice?");
 	}
 
-	for (uint32_t i = 0; i < ctx->nr; i++) {
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, midx->pack_names[i]);
-		strbuf_strip_suffix(&buf, ".idx");
+	for (struct multi_pack_index *m = midx; m; m = m->base_midx) {
+		for (uint32_t i = 0; i < m->num_packs; i++) {
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, m->pack_names[i]);
+			strbuf_strip_suffix(&buf, ".idx");
 
-		if (!strset_contains(&packs, buf.buf))
-			goto out;
-		strset_remove(&packs, buf.buf);
+			if (!strset_contains(&packs, buf.buf))
+				goto out;
+			strset_remove(&packs, buf.buf);
+		}
 	}
 
 	needed = false;
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 99c7d44d8e9..c9f5b4e87aa 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -132,4 +132,20 @@ test_expect_success 'relink existing MIDX layer' '
 
 '
 
+test_expect_success 'non-incremental write with existing incremental chain' '
+	git init non-incremental-write-with-existing &&
+	test_when_finished "rm -fr non-incremental-write-with-existing" &&
+
+	(
+		cd non-incremental-write-with-existing &&
+
+		git config set maintenance.auto false &&
+
+		write_midx_layer &&
+		write_midx_layer &&
+
+		git multi-pack-index write
+	)
+'
+
 test_done
-- 
2.54.0.175.g8bd0ec98dc3

