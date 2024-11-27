Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67D1CABF
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669206; cv=none; b=L8VlMKKsTZTeQ6NV1Rp9GT6sBE+FzTJeUO2dMkh6BqTCFR2WffNDRSr2gmN/jUy+LL/bkppRjMq1n3eJzCpomVrFKU882CJOJxHa0hwTs6LbEZh1GzOpkNqEgUorqfafYFheg2EXyY2DQK700EX5B/ywc6Pcf1MY7HJB5Wf1qxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669206; c=relaxed/simple;
	bh=gt7FClhwvs3MXi64ghUf0AKFzkmVf/aXt/WnhRE8M8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqaIkoN3qjDQhDA6cRqXCn45l4mbr0MR3u8z8yV69wvXnNfy4+737MOLcq4tAZPXAAjBhXLEGO70YgvL9lzfgwZWxFBqllCYOydfvfOepSALKf7HlzCtsT7WiwGS8FwaU9F8Dqbq6Q3nNG5CxMXyX0tpw5vTpusBNvbX3lhbm5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRwMZmO9; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRwMZmO9"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f1e573f35bso1142881eaf.2
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 17:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732669203; x=1733274003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChM6nVL0/dKyPT0QsYV6ZWG8CR1rZfDNM/cS2ZQC/44=;
        b=nRwMZmO9bNxQE7EOBoxtVJjGiyFfgKNZwQZeahXU3bh7o46U/S6PsGU5W0abhuLXAE
         BFeHwb+pFdbxex+Nyse+CTmSGez0my6jube0RcHr0yGyjzPYRhnGmr2AZZgxemriXH73
         Qf42rvJfwP25dt9a3iGbwdkJPaAJuQwd9CzxL+StuUm5MGu64UE0LuUVDw+3Qs2X+iiS
         DwbUsUz5W1VV++dWFzykeI48CbxssR0xgs+soLRwyCIKIJeKjtw7+v3sbiwIW70JWT99
         OVUYfX/wVLyV9Sy34/VATzbwDeC1nXhgSdwomya3wlGwndCn4fGgKsowwwHpJyIjwmJf
         RAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732669203; x=1733274003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChM6nVL0/dKyPT0QsYV6ZWG8CR1rZfDNM/cS2ZQC/44=;
        b=seyp/wDWHPttcBG5tA8yNvUBpqoLXw8vbyxoMPRo7luScO11YzP7f1slW9fsAx7lMZ
         cHCDFA0ytcTaq4jl4O4vgEkygD35OKYlnXOaSp/QnXDewcMw34KDhiV7iZoNci437oeg
         NwEpLLxCXX1sONSNFREcQzoN3yO+7GGcl2gCR2wFRwQdG6dX+VYsR2Y0OsWZcpO5k5yW
         SKpK6BLYEJym4wKNSy0l10vlsy9zUqY8o6m7CjYMQ2IwG0d/+svwBW9dSoidYd9A5gyC
         FoWfWnB/3GaF3omPNs9hKwW374hfhMQxCV2L+X+O/IBuEqIDNGf4deazZGaGDGI/LS7P
         cVUA==
X-Gm-Message-State: AOJu0Yy1u1XrbQRY+rWNSUIAA9j/qUnzEtZ67FlT+rnM9aV0zg65PR/W
	NtSm88A5OT2CKuoYRb4gLq0tbUVkeju8udsBsyzv6zJXEhROHajFBCYZgg==
X-Gm-Gg: ASbGncss6ea5FVBaj6nIWlm0HISgkUshLPgE2WphKNF8jEfgJ5DmK6imQ3zAXA16QLr
	sPfvo068hPOILsqzfT8LBtqU8qr8O57eW1t4LvNwylf0s9eWpM+uQYcqp5lqe2hc17P1+n/XXC8
	wbbaHqtWsDUQqc7E0K9/ZGt4nKDksaSv4D54noW31QgeDcHihQEoQPTKdeg9R4KjmwtFOgB5NJD
	mf4uFfdQ5WL1Utkpv7otmW2vHSkOSPlQSBNeEFZlCJ/XQ+uXhIZUL//0A==
X-Google-Smtp-Source: AGHT+IFFjVCOKmI0oxRRhsMTXrPtXPgZ3dzq7NfI++4cRX8rhDjbo8eLb9U8PJkqXwPnu1dxzpg2Yg==
X-Received: by 2002:a05:6830:441e:b0:71d:625e:cf2c with SMTP id 46e09a7af769-71d65cbca86mr1334826a34.17.1732669203420;
        Tue, 26 Nov 2024 17:00:03 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0378d26esm3316643a34.31.2024.11.26.17.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:00:02 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/4] bundle: support fsck message configuration
Date: Tue, 26 Nov 2024 18:57:05 -0600
Message-ID: <20241127005707.319881-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127005707.319881-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241127005707.319881-1-jltobler@gmail.com>
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
index 6a09cc7bfb..df17326b09 100644
--- a/bundle.h
+++ b/bundle.h
@@ -41,6 +41,13 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
 
 struct unbundle_opts {
 	enum verify_bundle_flags flags;
+	/**
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

