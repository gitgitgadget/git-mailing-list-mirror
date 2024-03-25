Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4A1448CB
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387494; cv=none; b=RS826Us78v93fLyt8EG0Gk0bV+kXwTwMwa97Vj3U1c68zsuy6BNfvfRGFIvjPx2R6uHPVQlnoUY4A7vVV1KrSo+gB3NDfvJS8DYiMskwwyGW7jND+OOe9Bu7jE2BZR96uVy63I+FADonhioFNV/o9C5hAYlYENub987m2Abz8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387494; c=relaxed/simple;
	bh=KM3C5PDylPZro2XYnIjfoxNQGrNjai2tiJPhElUxg+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEBlu75yTLhjvHmhFCaIrjvWBM4piT2W6VVt+WhqKpGGK40gyJRMSp6lOyu3JT249k5BWKf6ZI6dz8Wt3MPYoYz5oMfNGRlI8KvI5XccGDhHumwd2K+z2WTl5RiBh4X7DK5tifYf6sFDGMo/urhuMtLZ+eHkYwuRwGrGjc+wAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Mf/oc+v1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Mf/oc+v1"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-789f1b59a28so302298985a.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387492; x=1711992292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZoe6v6JANoWwVQsnBR8xjoHp7tsRd/vEy+SzRgfSNE=;
        b=Mf/oc+v1ZCTsG8hvDAG1iXYFCHf/uKtP+i3JaIzppsValYIVWVElp5nEXrhhCmgBWU
         Ljz8Dlm8DR7tfT6296BxDTUmwbii0NNCD0fb20zVu6dqnYQOVq0TZ90qBgdXQjicYQW9
         vz4Z5IGoGzxHUO/ErDLzHi3Q/KNl0B7q4SYP7col5H5KdzwTDctr2JpuGgQarhbQCRBJ
         +f5y2c7l524ijhB6UgIjW5UsM5HBUOYhVXqosUXFpo0cOXya/4ymtoSa6i8x0G9s47Tw
         JjKZNZHuvs9w+8jSW/KCu/W3I1yPY+HeS2NIqJAl+rDgoanX/YH1971+XrNU+txD56Ja
         On3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387492; x=1711992292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZoe6v6JANoWwVQsnBR8xjoHp7tsRd/vEy+SzRgfSNE=;
        b=UxWiHp08YiiBKrK4EJdEXBlB2obSF9cHAU9Zgq3bcjifcgYmi0WPvMRPyYZLZoOfNw
         vDxtj5zRIh7mNroNXrTS5c/LMd6nXG+EAc71iaOLeJjUScQ5ZMSpw1NvHUVg4OTh5xDt
         dQqhcWFQoBJLM8dCaN+JggR4D9W9Lgow0r3IwuSzFbWbthFwLlVe3NMdTnhQ7S86T2Cz
         2xbGYP6KXW6E70xZ7w75CqvGPSTkzOFYuGCbZR/K/M47zeuZZGREecCk1U9ZjgUB7hCi
         WljVVCZ0Iu5BqmQUBDmIK8RKwA835lq/Yh7yvVkFMOIkkcT2r7w8DzUJTVwx8+f4Myr5
         RRLA==
X-Gm-Message-State: AOJu0Yw3ki4hvjDnk5wYyG3eWvPfYjRFdb9xRcK67E97+z9f3Kq8YWet
	Y3Mccf22nIWd1OHlh0OwZ7nvBClyoh3imr7/lD8zpvL3vcXRy/NccHDTjKV7KorcRiOjkayZupf
	4tWo=
X-Google-Smtp-Source: AGHT+IGkV3qVUnZSLRIawD6t1DpVou/iqa1QWCcYVJ+AKhw/ZUvW1k5CQzsewDPxf9f0VeOFR9lBMw==
X-Received: by 2002:a05:620a:125b:b0:78a:3509:ccdf with SMTP id a27-20020a05620a125b00b0078a3509ccdfmr7723622qkl.65.1711387491738;
        Mon, 25 Mar 2024 10:24:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b17-20020a05620a04f100b00789f3c50914sm2300025qkh.33.2024.03.25.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:51 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/11] midx-write.c: use `--stdin-packs` when repacking
Message-ID: <736be63234baf7fc6df8259d9bb7298858b2bc74.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

When constructing a new pack `git multi-pack-index repack` provides a
list of objects which is the union of objects in all MIDX'd packs which
were "included" in the repack.

Though correct, this typically yields a poorly structured pack, since
providing the objects list over stdin does not give pack-objects a
chance to discover the namehash values for each object, leading to
sub-optimal delta selection.

We can use `--stdin-packs` instead, which has a couple of benefits:

  - it does a supplemental walk over objects in the supplied list of
    packs to discover their namehash, leading to higher-quality delta
    selection

  - it requires us to list far less data over stdin; instead of listing
    each object in the resulting pack, we need only list the
    constituent packs from which those objects were selected in the MIDX

Of course, this comes at a slight cost: though we save time on listing
packs versus objects over stdin[^1] (around ~650 milliseconds), we add a
non-trivial amount of time walking over the given objects in order to
find better deltas.

In general, this is likely to more closely match the user's expectations
(i.e. that packs generated via `git multi-pack-index repack` are written
with high-quality deltas). But if not, we can always introduce a new
option in pack-objects to disable the supplemental object walk, which
would yield a pure CPU-time savings, at the cost of the on-disk size of
the resulting pack.

[^1]: In a patched version of Git that doesn't perform the supplemental
  object walk in `pack-objects --stdin-packs`, we save around ~650ms
  (from 5.968 to 5.325 seconds) when running `git multi-pack-index
  repack --batch-size=0` on git.git with all objects packed, and all
  packs in a MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 4f1d649aa6..d341b9c628 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1474,7 +1474,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
 	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
 
-	strvec_push(&cmd.args, "pack-objects");
+	strvec_pushl(&cmd.args, "pack-objects", "--stdin-packs", "--non-empty",
+		     NULL);
 
 	if (delta_base_offset)
 		strvec_push(&cmd.args, "--delta-base-offset");
@@ -1498,16 +1499,15 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	}
 
 	cmd_in = xfdopen(cmd.in, "w");
-
-	for (i = 0; i < m->num_objects; i++) {
-		struct object_id oid;
-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
-
-		if (!include_pack[pack_int_id])
+	for (i = 0; i < m->num_packs; i++) {
+		struct packed_git *p = m->packs[i];
+		if (!p)
 			continue;
 
-		nth_midxed_object_oid(&oid, m, i);
-		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
+		if (include_pack[i])
+			fprintf(cmd_in, "%s\n", pack_basename(p));
+		else
+			fprintf(cmd_in, "^%s\n", pack_basename(p));
 	}
 	fclose(cmd_in);
 
-- 
2.44.0.290.g736be63234b
