Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB52B9BC
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721350; cv=none; b=D6Q9QP0ZAD9qidvvsim43HqlxHDfUMObxO2FJ2cqLxeRwjMyxEGWkATR0j3CcI2Fji2R72NejuxODdY/3jRU9JOe3Rims7OGUrNaeB/fMA+njHDi+CV9UQJI5kt8NVchmdOE/+Ezt9mLxah9AnEz0ecISfbB0MGY0ldtXl5RdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721350; c=relaxed/simple;
	bh=C/Q2I9a8u+8/L3BDCN2Q200YkzuMkxLp+rtXy+6qgSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZkF55a/9bIKipdRQvme/oMn1QUYctRZsViZfj4dKpApFWJikz/urlOjQaw7wi5DT2n9UkxFlDKGcDxnCTsdHhVr2hJmnjLLZXDXW9eUELD9r6nCiQFupHSYMR/g37qR9zorOiizSm8rSyq6qdTxZyy9AhLcrlB0CsyzTLzUN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea7zaJkY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea7zaJkY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so2988731a91.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721348; x=1738326148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcxdWLahw0fIxmQoWB1haQp77SFUjIc3H0mwVlUx5go=;
        b=ea7zaJkYHBHBDwXBNcRa6xzdZS31H86KCCeqyX2LrZdPz9tpjQdKUK+tB6KvD4/Bo/
         vzTaxaWtaimp/67BFKkGyrNtZqjfo8wVM0+IYwWpHuJsYOz91vQv/qng7pyUgBaTogWY
         oeq4JrD/YWPFB3nT2b3O01qNhU4y5u7VmnttTjJnUjC9bj3UJZ4sWeYQfEYHx0nBsXgA
         jdnDJVv4D3LODkZPxhhYYlQsFY3T4Yswxh5gF17KxVRTDb/o19PTX5VsBCdzenYqEiLa
         bPM9HPrnFlTmS4anLhIk9SI/hJmeW7zcCokRztOiQXW4H/H6wBrbJQDEIRfx2iBNt9cn
         ux5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721348; x=1738326148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcxdWLahw0fIxmQoWB1haQp77SFUjIc3H0mwVlUx5go=;
        b=sm3HBJu/LAvbwHLT1XTs9uyLAr9/mloFq5rSq2xKhhcfkeLZKCe3IrAxMYhgG8vyp7
         rNssWO+ssegvLVX0ti6/+q4QOce12ppLl3DmzlNMMFy/Uf3dTqrx4hIvBnX/cwjlLGjS
         sIRCs8UC1e67W9pGtWaqQrNlrQo8VPJzpDlduwZmcFTmhrPZSDmo/Z/NJhsIpv65xf/3
         NhtnX3F1ayfnNshHziAjCg21ezNCW/n4Yf6Juu4gCOusScfAoLBRD0p9PaZV5tuP1qxq
         PJ0V5oF+tRzvKgiFitXMs6D5SgdmYARJjDAXaXHMmcTezXC8jFbTYy9DXY4Awlq5M8jN
         vVtA==
X-Gm-Message-State: AOJu0YzJUwhj7vQeTqYCWfqQFNIkkfcli4WXu+l9KMPLwswJ1hS5T6rq
	Iy0PiO2XqUUumtYYPOz/DENDpOUVG8R5+NyawR6m7J7OjgnwSH6lglWzvvH9nqU=
X-Gm-Gg: ASbGncvVSxhzyXXT0mXKfqDMXYfVR/4gxRtsMPMNYcxaL4TDZXAojN18Y1zrpXQxVeR
	R/Q5dtEv8V85kXZfe3ed/FVIlzsq8CRoTlZOD+U5eKLQSv7IYW+T7Sj20aH/ocxN1cW0V71B2Yt
	H073nxOgxZNZJ89a3yqEW/JIjbzkaweDvxYf8eAy5WLgZ75WpqXbHcCEaA3/g8v65S0nLV6DJax
	ScULApbqv2bei5yq+8UgrKviafLqjYTOUntsa0XBJIXaYCkcI90IpwgvWg1w542+XkpvvDXdPOC
	dTVxnfip/s9tNYQtjENFUAGqfG7XfQ==
X-Google-Smtp-Source: AGHT+IGCgRIGrmhMvui7DHHMozjoERjZ+eBX0KmFxn114yrcwk5JOrtqiB3VgrqvF63P6KHoYCBsKQ==
X-Received: by 2002:a17:90b:2803:b0:2f6:d266:f45e with SMTP id 98e67ed59e1d1-2f782c4bd8fmr44943454a91.2.1737721347811;
        Fri, 24 Jan 2025 04:22:27 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1dc56sm1685056a91.49.2025.01.24.04.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:22:27 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/6] version: replace manual ASCII checks with isprint() for clarity
Date: Fri, 24 Jan 2025 17:51:36 +0530
Message-ID: <20250124122217.250925-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250124122217.250925-1-usmanakinyemi202@gmail.com>
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the isprint() function checks for printable characters, let's
replace the existing hardcoded ASCII checks with it. However, since
the original checks also handled spaces, we need to account for spaces
explicitly in the new check.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/version.c b/version.c
index 4d763ab48d..6cfbb8ca56 100644
--- a/version.c
+++ b/version.c
@@ -2,6 +2,7 @@
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
+#include "sane-ctype.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -29,7 +30,7 @@ const char *git_user_agent_sanitized(void)
 		strbuf_addstr(&buf, git_user_agent());
 		strbuf_trim(&buf);
 		for (size_t i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
+			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
 				buf.buf[i] = '.';
 		}
 		agent = buf.buf;
-- 
2.48.0

