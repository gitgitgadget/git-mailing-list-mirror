Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C52DC789
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959589; cv=none; b=RnrEKAhuWqPogeznerT6zm1FV6D+0oE2siIa2Yng4BUnQ6BUG9nPPs5GpD/9Muwjt4hkbB8zpJfSZ6MG+ZJF8gpa7C8ik7joK3xpPota4szVAJaWV5e97fiCiX4bZ1wWSIWsnui+LCBw6pZBkrsqyhKWWl7OHxHwgUmvxJWd0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959589; c=relaxed/simple;
	bh=TST1qn5/vstEvkToBUQEj3mUx6JBNQU7f2O+2Qn5s/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZew9KBvMm7jprzNu+i+6/CaeqPO659RnVMj7PmfGLtw4rm4dCN43AAOUS+E4Fo+nl4zWiLKUGYl392slB4EiEXzaprtxDwz+qQWBPG8yjyflvIWKYe+QBC4fo7pF5TuCSANuZVZRuZkkiajv0D0bsHajyRYeFwdFHidJapLsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZBffTm9o; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZBffTm9o"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896f632d206so1325426d6.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959586; x=1772564386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOaAm+WA6gpjURZou1b0NfilISkqWnJdPSKs/RYP8Yk=;
        b=ZBffTm9oAji7bb7/PgP/a58sLgydi5h984VCX9YlAmKqeXpPVXsSchxnm5fCeSJ9qd
         y5nkJm3rY1qvgkoLgp6BmW7/96jAUrTgfTMhABkJ3FifnQ2nZZY5yhG7uvms2xQnWsjm
         OS9+4QmSuwhK8+1R6J9cEyyuKR4m+4qY/Q1sxEZIq4GqQFx+zKOCGMKM6ac2zhyYiF1X
         dB5ofdRLFeJ5rXWtNlpnaAKzyqngQXXAlqs7iTzQXnysA6O1gU7vhJ3Ht2y4pEHP/7TA
         dLCXLMK+egItoncnj25uadkd2IS6PmoSCzRuY0Apu9UNH8fOo2/lAzdB5MgFILmA/PrT
         ZK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959586; x=1772564386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOaAm+WA6gpjURZou1b0NfilISkqWnJdPSKs/RYP8Yk=;
        b=lIOhjft7y1wsBY/VBami5J11CHLObISx20/ccb/lc4Iy+4hDNu3MhS8pSuqbCdIeIF
         cJcA1Qw5qc6VZ/Wy99AlX52ILPOFdDiCs//F7gWgaTWxJcDm1QlQgUjrEqI2JNg3lik0
         xD1QF9YLyWOmhcDhRCJotNmg3Lrix6epR/UAeo5TmzNGIoso3r0aYkRKPFQ2y4PcHSiO
         o61Vs0HaqeqoN7TcS7SFREhzwAO1RT5ADnYitMJP4WNd3dLUP+h3d2DVIsZtxUYKUEdd
         kfkDBWW7RLKp5vAjlv7Z+1Wgyc1FWwzJN4zS9p7WwQdPzdmuOoC+KkoMHLNWC7Yfc7h7
         /kng==
X-Gm-Message-State: AOJu0Yx8LQIFoQ7laXS7rIuSGnWtuRVJlHrYzIyJxea08aSf3TdvFUur
	77Bu9CsfwQJvdmDs/VeDgkAcWt65/n+SG0+gF4m8W+9g7QJhYAhdez6hOkK7US+kQDvn1yLBD0U
	yFq5CHqqCYg==
X-Gm-Gg: ATEYQzxY+lcF5WFk8wUcUFycgGIIooYwBzjOp2CImsaLhVIf8XwWxI8VUT/8X/YUeec
	I2PP14sBiBNmDPAELtCWu9NE5hRavEdVXFPNy+xVPGQhWb7IkaEIl7LXZbb9uErUvqVQttCL7FU
	La2eaHO0X5yTZYU7dQUTMxdca+03caqAp5OWPluzx3LZg2m8oTq0Rh6B8eorG4AEwe8OaFOEtMv
	19wyn7Lh41cLst7yvF/AUsNJu55CN6ICP7TSimAVLbAq2IcxitgKOQN4zbt06ZDlIXuXmzhVqkI
	xgUthJ3dG1Qzf5VI9NSHNsXCOnW2BwOaPk+3apPnDViycd28g69QRRMBh/nOZ+xXfF27QHqAwoT
	bHa2Nhc35CnHE6nyIpUvLl0ZtfesBoQg3uQF8TMy+ipl5u4s9Ur6TsJKxnNI3fZG1O4ExCGrASX
	8nRHTmgLX88h6oTGiq1Mk9Y1iLdJqxckUvwBPHkPvnD37Z8GFe9BxFOEwJkXAwU9XVNVt6MSvkL
	nugxW3//4tlOFs0j6rJJYqXvngbceKgYO+ytw6h
X-Received: by 2002:a05:6214:761:b0:897:192f:6d34 with SMTP id 6a1803df08f44-899b38225f6mr16220586d6.29.1771959586357;
        Tue, 24 Feb 2026 10:59:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62ffdbsm110869706d6.43.2026.02.24.10.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:59:45 -0800 (PST)
Date: Tue, 24 Feb 2026 13:59:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/17] midx: introduce `midx_get_checksum_hex()`
Message-ID: <cc5c77830625997e141156fcc2bf86085254fe12.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

When trying to print out, say, the hexadecimal representation of a
MIDX's hash, our code will do something like:

    hash_to_hex_algop(midx_get_checksum_hash(m),
                      m->source->odb->repo->hash_algo);

, which is both cumbersome and repetitive. In fact, all but a handful of
callers to `midx_get_checksum_hash()` do exactly the above. Reduce the
repetitive nature of calling `midx_get_checksum_hash()` by having it
return a pointer into a static buffer containing the above result.

For the handful of callers that do need to compare the raw bytes and
don't want to deal with an encoded copy (e.g., because they are passing
it to hasheq() or similar), they may still rely on
`midx_get_checksum_hash()` which returns the raw bytes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c              | 6 ++----
 midx.c                    | 6 ++++++
 midx.h                    | 1 +
 pack-bitmap.c             | 3 +--
 t/helper/test-read-midx.c | 4 ++--
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 73d33752ef1..13171d7e9c4 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1151,8 +1151,7 @@ static int write_midx_internal(struct odb_source *source,
 		while (m) {
 			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
-				      hash_to_hex_algop(midx_get_checksum_hash(m),
-							m->source->odb->repo->hash_algo));
+				      midx_get_checksum_hex(m));
 				goto cleanup;
 			}
 			ctx.num_multi_pack_indexes_before++;
@@ -1520,8 +1519,7 @@ static int write_midx_internal(struct odb_source *source,
 		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-			keep_hashes[j] = xstrdup(hash_to_hex_algop(midx_get_checksum_hash(m),
-								   r->hash_algo));
+			keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
 			m = m->base_midx;
 		}
 
diff --git a/midx.c b/midx.c
index 1d072bd9931..bae45892323 100644
--- a/midx.c
+++ b/midx.c
@@ -24,6 +24,12 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
+const char *midx_get_checksum_hex(const struct multi_pack_index *m)
+{
+	return hash_to_hex_algop(midx_get_checksum_hash(m),
+				 m->source->odb->repo->hash_algo);
+}
+
 const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m)
 {
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
diff --git a/midx.h b/midx.h
index 62d6105195f..a39bcc9d03f 100644
--- a/midx.h
+++ b/midx.h
@@ -85,6 +85,7 @@ struct multi_pack_index {
 #define MIDX_EXT_BITMAP "bitmap"
 #define MIDX_EXT_MIDX "midx"
 
+const char *midx_get_checksum_hex(const struct multi_pack_index *m) /* static buffer */;
 const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m);
 void get_midx_filename(struct odb_source *source, struct strbuf *out);
 void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6307bbdf1e1..afc7fba0197 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2819,8 +2819,7 @@ void test_bitmap_walk(struct rev_info *revs)
 
 		if (bitmap_is_midx(found))
 			fprintf_ln(stderr, "Located via MIDX '%s'.",
-				   hash_to_hex_algop(midx_get_checksum_hash(found->midx),
-						     revs->repo->hash_algo));
+				   midx_get_checksum_hex(found->midx));
 		else
 			fprintf_ln(stderr, "Located via pack '%s'.",
 				   hash_to_hex_algop(found->pack->hash,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index b8fefb1a124..9d42c587564 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -34,7 +34,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		return 1;
 
 	if (checksum) {
-		while (m && strcmp(hash_to_hex(midx_get_checksum_hash(m)), checksum))
+		while (m && strcmp(midx_get_checksum_hex(m), checksum))
 			m = m->base_midx;
 		if (!m)
 			return 1;
@@ -94,7 +94,7 @@ static int read_midx_checksum(const char *object_dir)
 	m = setup_midx(object_dir);
 	if (!m)
 		return 1;
-	printf("%s\n", hash_to_hex(midx_get_checksum_hash(m)));
+	printf("%s\n", midx_get_checksum_hex(m));
 
 	close_midx(m);
 	return 0;
-- 
2.53.0.171.gde83996e422

