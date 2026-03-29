Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2B26A1A7
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820459; cv=none; b=XM2Hk3Gm9NrJAbcKDl+SVS5yL9oesyMW6Yl8bhSftcLhXogsLQ1eqZWPIQXm6wgFoGBJEyQQfRU1DkydFWsJQJvcsr76SS2WAZs9N2PAYHZa/I7w+9NiV/ucUz0ZcrkfA2rrNijcUXbCsqBgAG9vX1savd3uq579aC7l50Nr7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820459; c=relaxed/simple;
	bh=bW56ypfLsz26yPnPh7OAzURPyU5X0f0ag8vX0xeqSRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMEHAmnoE9n7cjsNJ8I2g0Wg0ZEF4ycMiiTZ1nMyS/DLCLBCIb5cD4OBc5S0c4xlt6ed9193MS8mnGh2xLhDlMxRHTM9CZhQnWFJw9VXLhx40WnybiztwXzTVSTJ3GL4ZdYu07QFMaEtuq6JI5M65yzElEGPnT6Vl+cwB0LFnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IiFKIAQZ; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IiFKIAQZ"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6500040ef85so2988822d50.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820457; x=1775425257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGHJ4CeHUScyeNVcDCRB2jqEhVQmYWTTbSbwDFSNpyM=;
        b=IiFKIAQZ6D1DehEKJqmFlbt4j7n0x4JD4yxBIOqHySQSpDhucJtQRSZGjm8SL7pDuH
         NMg7++92RlsUYcRUqP8/Flzl1XnhKAgK9mndV3igdXqU9+pJ5XMRQxCkOgM7nG4Nxkgf
         qZamvR0h4KSGIrMJb4kn44Bvjk+UhRRvIO1s6kgB04P5mkvGJhzSwYQTPuaxrmO25k91
         VehB60bzYyCiKunT6vkcc12e+GI/w//a6Uc7VXZMOlfO1suY5fTiYOUi78aR9H78/40h
         4CeNQgyzhIUJfPARQNBnEqjPSp8MOe+poOnIqHSvJ90uFQPIZuLNrckKUJontb0E7iKd
         f55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820457; x=1775425257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHJ4CeHUScyeNVcDCRB2jqEhVQmYWTTbSbwDFSNpyM=;
        b=o853CHhaJVlvgeLVDI3gRCs2kG2U5vcHI7Myr3GGHb5P3SKcKuR1t+Oad/Cq1wdXEf
         NHKiLsrfTqniqDy1a43iLbwwcThniJ2aFFBMvnLy8iGUulj7NJ8ToNkOJ7HtAzLzSp3k
         W/uYbk1CoGWlIVku4Ti6hOJlHFgQBUWwjn2dfLkkJwgK7Xys/hxY/hDCTDTfTDKTMlYD
         wMj/QBRaJauGQ71M6zPvxs4EkFOyk21sKGhb3i9puxnNvtjQ6eRxJbbfhd0tEAPXRmTj
         GxlG9e4Hd1pKT+qwVrDOBvLMzFZamelavFofX9anSbxq683fOnn11f7RNAhVSNs98D79
         oLHA==
X-Gm-Message-State: AOJu0YyYIEyY+t9j9gkFDZabC3VkmRduPlLdxsnW0odxeYr0xuqzqNf1
	preAIGX5i/9ffndf8SoAqeuCf2puEUM/iYTImAM1Br/fYC6q7ytLOsIb6g5BzNtPwY+ayNUFDXu
	XCZMmnT203Q==
X-Gm-Gg: ATEYQzxG9BE6BPtRPBw38RFVqBm3ZE8SU2ch0DFtXnG6gGjuaaQ28TWFEpOuaI1Fkk7
	fBM8hR0VrcjBurCvKAiJO2dNw06DzsuxYD9XHDpp8u/UelLy2HQBqpF+MLMPDafRw5NPrMen6VS
	kepg0SX+ryOeQWbTararX3WC2S83PTSNKNJDjSjQ16vsVHmOtBynIkl9zFbCnCFQxazxgZU8lU8
	+USXIwaB62qVKYq5ImU37gaxhLi5/AfYOp2zjDk4LVRK2rtG9Uj9vfNvD8SwvaMmQ5L4QCne6sD
	oyAQzt/39nBuKI1l6zecLIQm6GP57krY1NE54soB+M06EhwS8A4pKSqm56XtW5FrZECEcmiDfiM
	KwAMZ5XSRznNLnnRkQhffdRTgVePH9G58giXFKNLH7Xg8TSYJOOKcDWt44As1HbU2D+PMuxW7kn
	zKf+CsapheYeO2Mb0m9CZHgkLP8KrTkWbG8sw9AFXyIIBe1bYGj+3x49khwAmqDSiHB9Ee5Ad7H
	4sowLwsAxFPeS/VG9SGct65jbGyRQ==
X-Received: by 2002:a05:690c:660f:b0:795:254a:b433 with SMTP id 00721157ae682-79bddcb9cd7mr106716787b3.6.1774820456704;
        Sun, 29 Mar 2026 14:40:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cbac53763sm26170877b3.49.2026.03.29.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:40:56 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:40:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 02/16] midx: use `string_list` for retained MIDX files
Message-ID: <1391552dfc6624374bed89b25d1892d9b9d080f9.1774820449.git.me@ttaylorr.com>
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

Both `clear_midx_files_ext()` and `clear_incremental_midx_files_ext()`
build a list of filenames to keep while pruning stale MIDX files. Today
they hand-roll an array instead of using a `string_list`, thus requiring
us to pass an additional length parameter, and makes lookups linear.

Replace the bare array with a `string_list` which can be passed around
as a single parameter. Though it improves lookup performance, the
difference is likely immeasurable given how small the keep_hashes array
typically is.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 53 +++++++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/midx.c b/midx.c
index 81d6ab11e6e..d322743f2db 100644
--- a/midx.c
+++ b/midx.c
@@ -758,8 +758,7 @@ int midx_checksum_valid(struct multi_pack_index *m)
 }
 
 struct clear_midx_data {
-	char **keep;
-	uint32_t keep_nr;
+	struct string_list keep;
 	const char *ext;
 };
 
@@ -767,15 +766,12 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 				const char *file_name, void *_data)
 {
 	struct clear_midx_data *data = _data;
-	uint32_t i;
 
 	if (!(starts_with(file_name, "multi-pack-index-") &&
 	      ends_with(file_name, data->ext)))
 		return;
-	for (i = 0; i < data->keep_nr; i++) {
-		if (!strcmp(data->keep[i], file_name))
-			return;
-	}
+	if (string_list_has_string(&data->keep, file_name))
+		return;
 	if (unlink(full_path))
 		die_errno(_("failed to remove %s"), full_path);
 }
@@ -783,48 +779,45 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 void clear_midx_files_ext(struct odb_source *source, const char *ext,
 			  const char *keep_hash)
 {
-	struct clear_midx_data data;
-	memset(&data, 0, sizeof(struct clear_midx_data));
+	struct clear_midx_data data = {
+		.keep = STRING_LIST_INIT_DUP,
+		.ext = ext,
+	};
 
 	if (keep_hash) {
-		ALLOC_ARRAY(data.keep, 1);
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hash, ext);
 
-		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
-		data.keep_nr = 1;
+		string_list_insert(&data.keep, buf.buf);
+
+		strbuf_release(&buf);
 	}
-	data.ext = ext;
 
-	for_each_file_in_pack_dir(source->path,
-				  clear_midx_file_ext,
-				  &data);
+	for_each_file_in_pack_dir(source->path, clear_midx_file_ext, &data);
 
-	if (keep_hash)
-		free(data.keep[0]);
-	free(data.keep);
+	string_list_clear(&data.keep, 0);
 }
 
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
 				      char **keep_hashes,
 				      uint32_t hashes_nr)
 {
-	struct clear_midx_data data;
+	struct clear_midx_data data = {
+		.keep = STRING_LIST_INIT_NODUP,
+		.ext = ext,
+	};
 	uint32_t i;
 
-	memset(&data, 0, sizeof(struct clear_midx_data));
-
-	ALLOC_ARRAY(data.keep, hashes_nr);
 	for (i = 0; i < hashes_nr; i++)
-		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
-				       ext);
-	data.keep_nr = hashes_nr;
-	data.ext = ext;
+		string_list_append(&data.keep,
+				   xstrfmt("multi-pack-index-%s.%s",
+					   keep_hashes[i], ext));
+	string_list_sort(&data.keep);
 
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);
 
-	for (i = 0; i < hashes_nr; i++)
-		free(data.keep[i]);
-	free(data.keep);
+	string_list_clear(&data.keep, 0);
 }
 
 void clear_midx_file(struct repository *r)
-- 
2.53.0.729.g817728289e1.dirty

