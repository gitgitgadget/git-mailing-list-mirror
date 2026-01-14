Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037134EEE9
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420468; cv=none; b=Dn2+bU/KQ6xtGCKZKqQhBdp3WuO2xH7Yu4fD9P+ex9BJo4G/QxNZdHdXVmPNg2P7cMQsalAZXPpUmxVLCgi7T+1DH9MwWYDXsVXxhEOq9W0T1fknNv3PQcFx/jgB9ns5CiyXQuURPs/majxqPgWaxRNy7WzQaO0wEzNPzeZG6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420468; c=relaxed/simple;
	bh=02W8olZAKXRa1KaO9il8qreZykST6lQwEBwlm7zxVyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nyd+2QTfWxSyJxqTDfARadN1cM5x/Bi26T6TzHvPgmPIh0VzFON+LpO4fBmiTzl1TOronrWHezHsOkXWTkf+l2+rY+tCzcjuSIx3fwieAlb+X0+/82+C4+HrXGLO93Y4EQn5f5DmjSb5ArU/e+pu5CBaoYM2ZwQ/8hgp1l/Eqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GV1IkUC8; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GV1IkUC8"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64661975669so88385d50.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420466; x=1769025266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOklXQcO/0Sxv6PqZ3w7eoYD00vSfxVXmAC1MNWeb4s=;
        b=GV1IkUC8BpwD0dDAXucXUlY73PiLBqOgUUbXwXQGBvp/6FRfi+2PIQJdc/BN3Iz2oU
         aKsukkHjBMYmI0ouZUG7RE5NN+vkZPzAm/V2orvxbhMowm9ZwAGN4s6W37VfAiRKcipO
         SOchHnllUpbKK02FxJgwEEYfXPK/I2NGMWEaRFw+2EfuA4gSiha9Jh1qNte6W1ZNS4Mg
         P2Ao2P/rNjJ4poUdzj4AufU3jcGSziguGfStXQJpaLv5Kz11Pz5D2HM9FpXSeqfLAJG1
         TZeg1fWk/lMlzGdJlFw37Ib5ILSCHBCZEDSgIVCfbKaIkSEdpMBJFVk8jNKGJy2/lTu/
         PC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420466; x=1769025266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOklXQcO/0Sxv6PqZ3w7eoYD00vSfxVXmAC1MNWeb4s=;
        b=fUu0QW6dopibbwsa44lYpTerHqWqHQY6K8wWtv+L0MaJlOL0utqQ+7lN48Ehkksz7t
         UbmhWv8jYHHBxzf8HvPgUAZrifK+TBntjkSw//sh8/bfSx+y7yYgZS1FU+4/F3xPWRl+
         HCXOxiKxmCsiedILPK8ZVNxuMEHgnhQ4LaPkmfUMvrNUSBNRapeqyEJzOAzvXABufT2g
         LLIWQ2UdwHy4A1pyzw5fIwlcvNgoBF5Y7XQMGNhuQMXjDaxcYyYoMiYk9SCxtix5wn1K
         44stBLeiBGIGJj+aDgs9/sTVAA//0M+JJYF/UgNlDgxvWD76u4dZpyDaxji2oY8voqhG
         FeqQ==
X-Gm-Message-State: AOJu0YwCf5ysNSPj8BNYg3sjGsfAN+E52qjAR8okwNevTw3SgQ5GT4o8
	DDbxRzwANMD2sUrDiQYVniQFdZn7nYKsyTmGoPCaryD0BTn9tyQp3TOkHlMo+3litFvxgn621V/
	66Zprhh3JtA==
X-Gm-Gg: AY/fxX60rogl3YrtAwFN8JXeuFGR23PUSHbOxqgYrvzk8eV7qWBCbaAjWTeV6/2sWsI
	PNopK84B93KTZ5miYbnhUWrX9fBebsegWRXgl64YdB5tbQ8pc8igZac6nlWI3JQmDMHsZ4Az/dR
	MQ9aq4tCDn81W9fJlwW0iD8Dq6ZP1JWo0RAL+KAa+b4u2jPhTnKuSAgs9OBPX94L/wndBLzeqmd
	Ii5i7zWjKDtU5bvhG8mYnfyfMHAobIjaDw8HtesrtY40cBk/sqdO+KHnwfDFOjwcpN8BJ9YcGoa
	oHKpeZ0+1BD3mnyVLFYkdMGUKq3zAl/6OgOksK5apDg7TfIJTpbXX3jwqG+l1MMYJEM/A0vlYT2
	4WW5kJDSWtA6AIqixJ+8LscRWLriyjC+zlG7nL8jmVbf+CiWOxQsmLKT6VWKXNEs2HIIGkuoFK8
	aq/C1gRZGWlEd2nT3ZWFkDvRq2rg5HiQDlwmdn3OCxt3PjPi7ZNx1/35c6TgY4dUkExNKOx6b+f
	IRRfzBbR9zxa965Xw==
X-Received: by 2002:a05:690e:11c4:b0:644:53d2:a698 with SMTP id 956f58d0204a3-64901ac05demr3069850d50.34.1768420465850;
        Wed, 14 Jan 2026 11:54:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d4fasm10857544d50.15.2026.01.14.11.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:25 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/18] midx: introduce `midx_get_checksum_hex()`
Message-ID: <25b628fda97cb4c31319ebe1585b9136bb0a57af.1768420450.git.me@ttaylorr.com>
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
index 554bdfc505b..19ef230d3fd 100644
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
index 90ae63e6804..b688531fd2f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2820,8 +2820,7 @@ void test_bitmap_walk(struct rev_info *revs)
 
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
2.52.0.457.gb599f1ad4b0

