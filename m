Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41D19C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097281; cv=none; b=SeFNvZs323i8TETuBRDKAHZoEbd8eelWWr7uTKNonzSGc+QCW9TtSmsvLl4qWz2s332yHJVQNNd5Cl1QX7TQM3imDXOGw/1myUVNiBZuHBbuxfog3t4bI77KgGbDKYIw3yA3qtvvBbVvZb/uKwoCWq1U5LMNA6fHn31/rn3k0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097281; c=relaxed/simple;
	bh=mtciMcVvzVnreyTuALuQ/XRTH65JJHYljpJOOKg0FRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoN8AIGSVgjVWpXR0oSTqkpkIhtuTI69r3B28gWv0m9GrqgNpJAXhzWyRSEqbb5YY4hkxfMhNgSwm70TWCYZ+6biNJNv9ij5OOnXcJeQ7H4+9RKPrM3brEknSKZ2lZDwx7cgK1OEiY/3YkWzQbKSnkI7c/98W6bUinULGo8GiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PRGTuFjV; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PRGTuFjV"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d6014810fso40622987b3.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097279; x=1759702079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GiHRCLFfnWwp90CiOu9NuuxAAg+K4ct6A9+FY49gRU=;
        b=PRGTuFjVpdN/geet0byVgAMTsOR6v9fxZTCyC4optsy6/CQ2t/R3asQwsyxOEOOyeG
         SJDTNjG38V1g4vhRDIbHO3QS3Di+SGFaL5vD8Xxw5zDDCNU0XR0N/i2Inlh1yM934r3L
         GZ9MjcEkxZhsOHf2e4heYZj4LsIA1d9D1PKZBLGPzpImTTLxsoe2G3BYI6DmYIIL7Hbo
         xAlam7Z9XwhyG/5WIgOelprz4xA2nHRNERwO2tcOkO+Iaga6+fTvxYMxkBR3SSExrB/9
         5vmUoEUY/KQ/3VdA903m9eUWl9vR1SKVDV2ClK050K9uR8Y/K56l+xK5CrnZQIVgOrT/
         eU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097279; x=1759702079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GiHRCLFfnWwp90CiOu9NuuxAAg+K4ct6A9+FY49gRU=;
        b=Ep0aa4fbAphOG/+tgoHUaKXqBy6vywQy0p1MX8xT3jwUDD9IF+o5m17plt5cXqOcAM
         /LlKxu57nV8JnPfiJ+3TWr0jf40E6tGdXs+4qqdnkk2W84IN7dMmGIMD6iM4FGrCCVkf
         6j55ke7tIJHuJJgJyTu1+Kpe5bWB5ngLiy+7NH8qg/uLJevCCI02dWaX6y10sm94aET/
         JwZGc1luFx5ruqmE9f9ekwt0T9t5RrKFqvICtosi4yXOi5/4mYVBwvNmlTVf+cYpzTet
         ehjyNv3j6kBTA8gGXg3rRG62Dwsqys4933s6GiNy+z189A3d6RdHdAxjHI/GQYhsdFVM
         CORQ==
X-Gm-Message-State: AOJu0YwWLxNe36QZ8prb/22njMG5BgPRszmWyNqO551oDuLDxrJeK4OU
	lAtMfiJWFqgdEJb+mjy/lkcmdEOS7CUb2mVIvoYAFrUeremZJ6kSQbgVU8trXc0rlx8JITa42P2
	U3OvlYtk=
X-Gm-Gg: ASbGnctUlY8CngoUdWRLjgWLoFASJnQS6MvcV867XFP92aPPJuyyLiSw4a0xBJo72Bu
	tiKgc1BM1izLB0ozIB7/jFapAIaa3wtY0gM/dSOaSmVIFPZr/JG+fIW+kQhsz3CtmqZKvmj4L1J
	CK7uTceroXTMPYecUdlit48Id2XI0xvnRhBSuPWu/FwLwoQyrIOPoHYqkEaGQUVe+MQKOLG3QOg
	guk6rwzmPZMLksIwbkL8Y3dczX8qVrSVYpHV34/YJMDP8g+JgHZeZ0GJaSKjz4u15qBpvVCMqa2
	pGe2NhMGmKksybrochjDWLDRct6jpV4eA2UDV7ExUkPlpSBnpke9FryokYkrI323C2ukHm7baNE
	0Lj4miysQckipHMhsiT8x0m43T/Asz6HrB3xv+WqHWtuAMkFFIew2u8BTzFTldHZcUnNlKunwFe
	oSJl1CKC+TmiPAXaILMilwJjkZ8Q==
X-Google-Smtp-Source: AGHT+IH09TTt1LabI4vg8ZwcfiU6vm4qYP/trIPNyzn2HlnDPZXxCKdeXk7r6mNE8LevTsWu3ie6rQ==
X-Received: by 2002:a53:b106:0:b0:636:149a:f54e with SMTP id 956f58d0204a3-6361a87fa19mr13734429d50.37.1759097278936;
        Sun, 28 Sep 2025 15:07:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-637d39f36a7sm912783d50.1.2025.09.28.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:58 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 12/49] builtin/repack.c: pass both pack_objects args to
 repack_config
Message-ID: <75386eed60c80a52c42720e4918853ff05c5584c.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

A subsequent commit will remove 'delta_base_offset' as a static variable
within builtin/repack.c, and reintroduce it as a member of the 'struct
pack_objects_args'.

As a result, the repack_config callback will need to have both the
cruft- and non-cruft 'struct pack_objects_args's in scope. Introduce a
new 'struct repack_config_ctx' to allow the callee to provide both
pointers to the callback.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6dfcb3327e..af6de8d77a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -54,10 +54,16 @@ static const char incremental_bitmap_conflict_error[] = N_(
 "--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
 );
 
+struct repack_config_ctx {
+	struct pack_objects_args *po_args;
+	struct pack_objects_args *cruft_po_args;
+};
+
 static int repack_config(const char *var, const char *value,
 			 const struct config_context *ctx, void *cb)
 {
-	struct pack_objects_args *cruft_po_args = cb;
+	struct repack_config_ctx *repack_ctx = cb;
+	struct pack_objects_args *cruft_po_args = repack_ctx->cruft_po_args;
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
 		delta_base_offset = git_config_bool(var, value);
 		return 0;
@@ -1260,6 +1266,7 @@ int cmd_repack(int argc,
 	size_t midx_pack_names_nr = 0;
 
 	/* variables to be filled by option parsing */
+	struct repack_config_ctx config_ctx;
 	int delete_redundant = 0;
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
@@ -1343,7 +1350,11 @@ int cmd_repack(int argc,
 
 	list_objects_filter_init(&po_args.filter_options);
 
-	repo_config(repo, repack_config, &cruft_po_args);
+	memset(&config_ctx, 0, sizeof(config_ctx));
+	config_ctx.po_args = &po_args;
+	config_ctx.cruft_po_args = &cruft_po_args;
+
+	repo_config(repo, repack_config, &config_ctx);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
-- 
2.51.0.243.g16eca91f2c0

