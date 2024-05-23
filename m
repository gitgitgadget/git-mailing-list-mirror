Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525018633
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482304; cv=none; b=V7aRvFaQvBmhxxsjJkVm5/d1/wzCOAuEn/qF0Embq4nKIA4lcWaz/S2fVtVPKXlWpVCNOcXALAujeKRuJLjdWMpXN335uGp0JKIvoh/NIEXuJm9ilq/ACKU4cX3pE6UR5S7f1Eh2WLSFfSyA4NCyoIZp2E+jTzRJxhCIDKpYcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482304; c=relaxed/simple;
	bh=dE/+cG9vCp1CP7435dVyoXKk/eQxQNVe/s6AVB6/8QI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW/khNnShapSTy1d217XcREm7Ic29Ho/mZkvM1UtBpqejD/mAADsE03fYFVmxzFfoFdR/9wnqL1s9EsUL6bWun4qENxWtYGsSgrV0MD5kaGm3LJCp1IVxwPgV21AV1E2t9ETZcHRK9yyDxM1w56Eq4vM2weeTPd1mFcvgNheCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WxGqtxm7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WxGqtxm7"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6a8691d724eso15808506d6.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482301; x=1717087101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=545QmfmwDNiPAOw6ahXSjCuxGWiceNxLOOVvFrCYxQQ=;
        b=WxGqtxm7ssKWnJ9J9Zz+dRQcRhdsAcX8tsQnsVRilFPXS7n7zZYY2KJFqF/Sm+UDKP
         aYBnv/i3lOxBpriHh25jd5LXbttE2vu4w0V7qpC/0SylPdvO233LmyLjjXPc+LNJLQmc
         fkUF9VYPdNGVRpMxEjNBv2YEQv51bjgWd2YMONu+2kgnpI45FrQFKBBvhWoxzRqxj+J9
         kZ59IQS7oIyYGOQZ3WEZ2VAtOd4azOKn42X22bMmWf9oY6hThn2nzmAVjSU7/ZTbTl8Z
         O3iZDn2aMI6/h99bHZ5TV5YQEYLs+zGWqPwD2v3/C0L0InVEfLBzsKPTXEIo6ZZbnqC2
         stqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482301; x=1717087101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=545QmfmwDNiPAOw6ahXSjCuxGWiceNxLOOVvFrCYxQQ=;
        b=GyaCFBqGKclJZeGpbA6miSw9aX0CNWcSQnip/GPOxNSu7O3dUKOM34BpNy4H2bvAPj
         rDomLNgH1GgAT1+sNpiVzbe3NAAa5M6cN5QlQRoLIjfWIHeOlDRZj4U88YFmyifg8azq
         0udgiE+kST3TsSTZ6oZTMFkt+lMz6axbpb3B+OZfZOFdONjm4HZLqYWQ+JXBUT0GWVDj
         qfYTE9C8AxeAh1qae1xW7522XDbmaQWS75uHBrb/XjK7/f+Uzo42+6WNP6Ywrk9Rj5Ef
         DTX4sP2s8FIOa5rsjm1df1nO9XVNxWKBHnx45zGLe1+UPuYH65kU3SG0BcpYEyXo926P
         OItQ==
X-Gm-Message-State: AOJu0YwBvoimjrr1P4mERkdBrx+Kcfqat1k5HXSRiN33GWawgWHsHkPk
	6oLrZGYhwW4bGoaAAr3penITqpiX1WtXA0UfnjVXaTDzmMQzpzF+8H9hf+D+oFS/3LVl/26m67T
	A
X-Google-Smtp-Source: AGHT+IGqriRKWww1T0QwRwDKBqaQlR72bYTHoodMdxcYaWUrYJpUoKPvFcL3xIX8KBiN7c0I429tVA==
X-Received: by 2002:a05:6214:4309:b0:6a0:d21b:c914 with SMTP id 6a1803df08f44-6ab808f321bmr65246336d6.51.1716482301055;
        Thu, 23 May 2024 09:38:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab9585fc19sm5142336d6.49.2024.05.23.09.38.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:20 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 6/8] midx-write.c: support reading an existing MIDX with
 `packs_to_include`
Message-ID: <61268114c6562ba882210fd94b3f336efcb5c486.1716482279.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716482279.git.me@ttaylorr.com>

Avoid unconditionally copying all packs from an existing MIDX into a new
MIDX by checking that packs added via `fill_packs_from_midx()` don't
appear in the `to_include` set, if one was provided.

Do so by calling `should_include_pack()` from both `add_pack_to_midx()`
and `fill_packs_from_midx()`.

In order to make this work, teach `should_include_pack()` a new
"exclude_from_midx" parameter, which allows skipping the first check.
This is done so that the caller in `fill_packs_from_midx()` doesn't
reject all of the packs it provided since they appear in an existing
MIDX by definition.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 9712ac044f..36ac4ab65b 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -101,27 +101,13 @@ struct write_midx_context {
 };
 
 static int should_include_pack(const struct write_midx_context *ctx,
-			       const char *file_name)
+			       const char *file_name,
+			       int exclude_from_midx)
 {
-	/*
-	 * Note that at most one of ctx->m and ctx->to_include are set,
-	 * so we are testing midx_contains_pack() and
-	 * string_list_has_string() independently (guarded by the
-	 * appropriate NULL checks).
-	 *
-	 * We could support passing to_include while reusing an existing
-	 * MIDX, but don't currently since the reuse process drags
-	 * forward all packs from an existing MIDX (without checking
-	 * whether or not they appear in the to_include list).
-	 *
-	 * If we added support for that, these next two conditional
-	 * should be performed independently (likely checking
-	 * to_include before the existing MIDX).
-	 */
-	if (ctx->m && midx_contains_pack(ctx->m, file_name))
+	if (exclude_from_midx && ctx->m && midx_contains_pack(ctx->m, file_name))
 		return 0;
-	else if (ctx->to_include &&
-		 !string_list_has_string(ctx->to_include, file_name))
+	if (ctx->to_include && !string_list_has_string(ctx->to_include,
+						       file_name))
 		return 0;
 	return 1;
 }
@@ -135,7 +121,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
 
-		if (!should_include_pack(ctx, file_name))
+		if (!should_include_pack(ctx, file_name, 1))
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
@@ -891,6 +877,9 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 	uint32_t i;
 
 	for (i = 0; i < ctx->m->num_packs; i++) {
+		if (!should_include_pack(ctx, ctx->m->pack_names[i], 0))
+			continue;
+
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
 		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
@@ -945,15 +934,7 @@ static int write_midx_internal(const char *object_dir,
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
-	if (!packs_to_include) {
-		/*
-		 * Only reference an existing MIDX when not filtering which
-		 * packs to include, since all packs and objects are copied
-		 * blindly from an existing MIDX if one is present.
-		 */
-		ctx.m = lookup_multi_pack_index(the_repository, object_dir);
-	}
-
+	ctx.m = lookup_multi_pack_index(the_repository, object_dir);
 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
 		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 		ctx.m = NULL;
@@ -962,6 +943,7 @@ static int write_midx_internal(const char *object_dir,
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
 	ctx.info = NULL;
+	ctx.to_include = packs_to_include;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);
 
 	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
@@ -978,8 +960,6 @@ static int write_midx_internal(const char *object_dir,
 	else
 		ctx.progress = NULL;
 
-	ctx.to_include = packs_to_include;
-
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-- 
2.45.1.217.g9bb58e2bf5a.dirty

