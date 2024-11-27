Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1F1991C8
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750557; cv=none; b=Y5M/sPOWJGIVP3rXLpvJSruVbZ5P4E9Ja5rUdn0zWJR3LhK790ahLPx5lZM1xu3IwFLTld9wifhsaatAd6rzUB4/10SY1MQD9ONq+Nb2AOnh+ZFxS2Gt60NeEpadtsJ6LAs9FxMdW4C/P0xEZU8k7TiclvgSS+vXzn60LcTIn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750557; c=relaxed/simple;
	bh=xWJzmReKNiOq3EBZ3LddoIvJdjNQx8spXBSE4Qh1vcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm4NuBFszK+gJNZSh57nHUE/dmFZYJGTFgtDiTYOpX3q7SmhZTiOQWsdYkHHySdBgmv2lIsfeLh7e4I8wwYBboqrjGxPpsyzxSj++tjUKePUBt+P1+qyUxhyoSEfRZP/PQXe65Z4ZJTuIFbc9JQy41HxmBzM0w39St2aYpKWXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NREPhJ22; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NREPhJ22"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so142796fac.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 15:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732750554; x=1733355354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0uAu+Y40SIGHl9Nv1g/lFR+LKAEcjOrqQRF49iJSnY=;
        b=NREPhJ22xsbKEhqknZ9F3z3ysObqzVZNundcxiiwMTlgQyF7BSbHLG5giVShghqgC7
         6PtP06gYlreNp7kQYvqBLQPOYDsjUTY3KlJnPKV44IaBf3RmzCbcWaOuzOqJxb44bbby
         ta4h3gqqDzZHzVk1Pw3mWWoPRUOyO1BQnHBQRArtxtOnKwon7KtbzE65Ri9c00MvKGkM
         ZzawyeKzNMgcYBhVv/sShTCvxL6b5qlJXNuelkIswrM4HYnKqeft70PFjcS6FyDIBIfV
         DRJL8OD25O5DIim4WeMY7hrtyJQX63dnEVkN4g/1+23WEgIY/VtRfPaTEHbysDO68lHh
         XQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732750554; x=1733355354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0uAu+Y40SIGHl9Nv1g/lFR+LKAEcjOrqQRF49iJSnY=;
        b=mWJSInWtVOZLpTk+nXTOzRwGM3hfcnKVzYCSY5rA7gKOXe/HSL4MxyYHV+O6VSg1iO
         VMbGPQGMqDFxv5kzlXn4p2VhbaCGrujRvIFYO5Bwd97W3Zwp3N8VId711FiCYtnfwGiE
         b/c3o4YceYUvEq4I0pjsmetMatu2piDdrRz6zvhv7e8zAHQLqmOaSpAQg5WXWuLIT+Kr
         ERDEjBIXfnkeXdvN1GXVbdDksGBd9APi+63dwAWPTTtL0OxTOu91Rm36cYT4h/pvSYVd
         Z4DECxnq3rm/0EgzWcJGUxKhcnEEqnodoRVEgyQu7c97e9AI9QwI70XBa2JcSB2f77Zg
         NE/w==
X-Gm-Message-State: AOJu0Yw0mPxP8ZQXOd6jUOrcbP/q4Ov+80A+ZueyMHK8MRY4hFm13R06
	CkGHZYYqcm0/co6HW94QvVOpRo/3Oa4shQZa+ske0HCyJREFTMj6QP5wvg==
X-Gm-Gg: ASbGncsY1Tsc/EJX9QypTHlWT39bpqKHsHWC/dGARzWzAZv2DmsvQgrlS+McAvxonZf
	4nxhbZT7pZVHCJtLHWVFij+6ldHVIdpu6hPZzXPuYRXmcOpMQEtIfZcdSord2JJrzihHnm3nn9O
	6Qxlq/tdF0z26u6RFVTOAnjFTuNyOjhrA8XHc68mCfojiHzc6dyymiiY1JJmqM7a+jOJwVIVfax
	41XV/zZDmGxSA8qwhE74Hm2ooSX2ItmZDxPJWMRYZDdduiqBULmtVQUtw==
X-Google-Smtp-Source: AGHT+IGrEF9wolC6Fe/OWWCZXOB97mSrb9iqbO8AehPqHv8so1/qNFh3mNdDNQxAfqxcf9lT5vTVTg==
X-Received: by 2002:a05:6871:c519:b0:29d:c870:74 with SMTP id 586e51a60fabf-29dc870066fmr3182199fac.27.1732750554438;
        Wed, 27 Nov 2024 15:35:54 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de8f31cefsm109260fac.2.2024.11.27.15.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:35:53 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/4] bundle: support fsck message configuration
Date: Wed, 27 Nov 2024 17:33:10 -0600
Message-ID: <20241127233312.27710-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127233312.27710-1-jltobler@gmail.com>
References: <20241127005707.319881-1-jltobler@gmail.com>
 <20241127233312.27710-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the `VERIFY_BUNDLE_FLAG` is set during `unbundle()`, the
git-index-pack(1) spawned is configured with the `--fsck-options` flag
to perform fsck verification. With this flag enabled, there is not a way
to configure fsck message severity though.

Extend the `unbundle_opts` type to store fsck message severity
configuration and update `unbundle()` to conditionally append it to the
`--fsck-objects` flag if provided. This enables `unbundle()` call sites
to support optionally setting the severity for specific fsck messages.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bundle.c | 13 +++++++------
 bundle.h |  7 +++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/bundle.c b/bundle.c
index 485033ea3f..4e53ddfca2 100644
--- a/bundle.c
+++ b/bundle.c
@@ -631,12 +631,12 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     struct unbundle_opts *opts)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
-	enum verify_bundle_flags flags = 0;
+	struct unbundle_opts opts_fallback = { 0 };
 
-	if (opts)
-		flags = opts->flags;
+	if (!opts)
+		opts = &opts_fallback;
 
-	if (verify_bundle(r, header, flags))
+	if (verify_bundle(r, header, opts->flags))
 		return -1;
 
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
@@ -645,8 +645,9 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
-	if (flags & VERIFY_BUNDLE_FSCK)
-		strvec_push(&ip.args, "--fsck-objects");
+	if (opts->flags & VERIFY_BUNDLE_FSCK)
+		strvec_pushf(&ip.args, "--fsck-objects%s",
+			     opts->fsck_msg_types ? opts->fsck_msg_types : "");
 
 	if (extra_index_pack_args)
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
diff --git a/bundle.h b/bundle.h
index 6a09cc7bfb..a80aa8ad9b 100644
--- a/bundle.h
+++ b/bundle.h
@@ -41,6 +41,13 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
 
 struct unbundle_opts {
 	enum verify_bundle_flags flags;
+	/*
+	 * fsck_msg_types may optionally contain fsck message severity
+	 * configuration. If present, this configuration gets directly appended
+	 * to a '--fsck-objects' option and therefore must be prefixed with '='.
+	 * (E.g. "=missingEmail=ignore,gitmodulesUrl=ignore")
+	 */
+	const char *fsck_msg_types;
 };
 
 /**
-- 
2.47.0

