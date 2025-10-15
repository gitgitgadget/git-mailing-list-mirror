Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BF30C635
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567280; cv=none; b=jfeJLqDpVwzbNqg1lu1yKPxj9696F6HQTvhklWSkJN4UYj2rvN/2GQGMgKDr1wufMhgiRp1MdtspMX70fnrAMwZO6QvUneVaycoMmEAOAUZAgUqMcL67Y88ycPQOblDl+/0i9eyrZYtpbye8iH79HwiQvyoExIEfzVY2ZwO9X+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567280; c=relaxed/simple;
	bh=5rjwfKwO76T4FG9TvWGFPKjXa6yGLLZGpeKPj72OznA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WULLAEBzeVTDx0JtmiWg0iVGfpMdojFFC3w+JhAKA0Vt2ZZ0KBOvya8RSfkJOmgfIAMmREXp9GERpBlJcfe+RjP/9Z06A5Eoe3KdR7OY5FfrPQ7Kxi/DQBA3TGJqf0b7l/n8x3o6j/JeVIiHZLcJBU4sR8UgnhwXr8Sch66kTnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iItMFAcN; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iItMFAcN"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63470a6f339so151623d50.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567277; x=1761172077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Et5yN+v8WCYAnVpEmyVIjMUuBxfJ8Xt+/9v8xKmrB2A=;
        b=iItMFAcN6ypBjefU9TwCAmpWpPSG0TMwY3tXk0sWs4R68kPH3MBIOv8Zj0qnVsOLWI
         h/hGkIm3Sclpj4jvhcJ0yDI/qsPdNUamQuSgm6ENl8dkV5BUalZRnjZyDbG/4lGAWZtI
         ropWcM5KAfOeHo50dQDAS5eB5o3Nr+wipNOYe9jTQO37wFEcoPS1gLClxB/Iqx5sQ688
         ckDZlH9aE1h6Lx81xqeMbkAugGPGcdyH+sJYa82dZ8Nk0YbJ6Pz8btPZxPjagp9Ucxx1
         PBR6D6fqWkrqhZCwy+Y7DdcVAhh1yHIa9X182QW5Y0Le1UylDmE2YE1rxA7EcKL9diH/
         oiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567277; x=1761172077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et5yN+v8WCYAnVpEmyVIjMUuBxfJ8Xt+/9v8xKmrB2A=;
        b=herCAftGU9Jhq46sIJckWe3/3w3pQHLrS0FBX/hiBFFCgsDglYtjn/rvjpoe0uZVeA
         wgveOpjVi3dpc9zvmwUZUtvNv8dLPRCV+c/yubB9blys8DSQK1eQMtGUBmqRmJJGg3+K
         lyv1hRZsn7LdXO1XqrgatBy7q2Ybr5+2Wbpl/vqQ6LzHtRAJ2JAPdks4r4+Xj7+X/g1h
         y4A/x9pW0hvcyjbWxnSC5WvtnNbQZrmmBvyPIoS0P4UtIFaijVOLtdxB9Ov+CbhWU3Yj
         xR2Oc+9kNTV8YEnFGCOUjb+ekYyYDYhhz/qJHxH/7jqQTrytw8jM0qeLfoUWFv2GFXJb
         wjZw==
X-Gm-Message-State: AOJu0Yx1e0DNxcdE6b5zZch3BHepF0Ea3BQck1J3SAt4D8hZsLJmQSxt
	kJofyMlbRI2EFBiAJgB1i9g0rJiWteOgmBn64BijbRFhWJkZyJrX60VMkiFVqRAkpx5w2HBtq5+
	LzCDq2b7D5A==
X-Gm-Gg: ASbGncu2o1ArO5OSb6tNAjpoWqmpQkT/KY7AY9r8DFSDS1UMHFoW1NuGqnBQ/ZMgT7H
	fbXNqiiktP5W2LCUvt9QPzQBmWUAwQp7Suf8mXsbZ3YXlvDGUBj5MDSxUMcQISZh2rZd+YdsVTE
	zEtiZGC7Lrx/yQlbYjCIpvuC7EeoVWOdU+NJ+u6LJ+mGzaE7cJsm6I6vJe9jciRpi3tEb6Sayit
	RFjAdH6iQ5j6NU/GXQP6w6lI3Tzor1G2znaqsnwe+qq74WejnLb1Sn6M+OktdwiaQNvOS3uXzB2
	9addSloxtP15OjEzQHyc4JcqhvO6asmAV2+b8gDsVBVtbkoFGAwW4z8IgEPq3gR48QxZnPUehWj
	Qf3qdVKQ49dtOVkHjWVjkCK0Y/xue9e6erL2GYbD3u6IDV+8njErBGWKvWBQoYcXQ2CaRorD5YH
	RERnFz3GwJdkWsltHBIgK0OsW4JZhfUCu5FeFDzHcl/tLZj/j/eEyoSA8pZLYDZQQoPRUdAKJED
	GRLSSUJDLxafw6RJw==
X-Google-Smtp-Source: AGHT+IHiKON+zQKC6QSO1c83n2QKzGzPF4B3XiHwFGXjCel0acxoaf743od07NIl80j9to9+kfnC3w==
X-Received: by 2002:a05:690c:4d0a:b0:781:64f:2b21 with SMTP id 00721157ae682-781064f34bemr339761237b3.67.1760567277512;
        Wed, 15 Oct 2025 15:27:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c12888sm2605787b3.31.2025.10.15.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:57 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 12/49] builtin/repack.c: pass both pack_objects args to
 repack_config
Message-ID: <a812bd3dcb36fe024bb4abc78f40f269c9c04635.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

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
2.51.0.540.ga7423965ad8

