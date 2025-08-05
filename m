Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184125C807
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386097; cv=none; b=gzYQN1xXgU5jgRb6zPHnOxhLWZa4/wxVdYWhvWKojbQcn/M/bDRD7uez+yKSZYFIK4JFI6VI7m32870VNR261AM90ZLQ4Jfmodhzym+pAGlIOMWi6yeBAvv9c53eviuHrBWcwwbcl4It80DOu0ajnfw9GxgtcmQ7Dn72F16/608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386097; c=relaxed/simple;
	bh=CwArQ90oaw3PTbyc8POTlrPoxg7J/w0L9FDh8UrBCGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1GikDKYFhJVBOMOT8bNjhptxj9MMW4ZmruQakMfUzlJLq8pT3dGpuRPIaZZyUzhkFKPT4E9t/9U6rCTuGCq/qGrYaJAic2aXrqlU3p+5rWm0bh80fX5Zp7kSFVFyMAsstmPRjdBez6L64FCi2qGO4+ylTsI2gMrcyzECV2BLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZWZHpb/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZWZHpb/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bc5e68d96so4348025b3a.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 02:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754386095; x=1754990895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w53E/sZ2DTQr4T2OZmw6YtW6XhZATJTKpY+7NleAxAg=;
        b=DZWZHpb/lkX3zDuwcYS5LkVfRC64VfaISJbOmXHrIJW/5jWp3DcXI/6XVMdZAh943i
         VvBBvNEyIYp2NOD2+03+misDlIGv40XVB6RQuTxL+cjpej9oy+3zS1Ph9XYYXoGsFrN4
         mErKw5i6I+OMtRlT4WCaJGbQTuw8/ucDdPEPBi1Dh9WUH8diRGEdJ53CAxmrBNofhYfR
         96i7g94FS6LlI2Dzda25uv2Q2kcShiI4MWYIwuRcVOd4gMXNQp2/9o6v7T7kBGo0bWMS
         zpa6wLNGsVtHI9azBMVqqTZS1X/L4VuTWypAuenpHxOUv0GZgMdTBvTfKHhyeK7yJ9qh
         oVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386095; x=1754990895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w53E/sZ2DTQr4T2OZmw6YtW6XhZATJTKpY+7NleAxAg=;
        b=GSx9Vtf+zJd5rspI1sHhJMA3G2uJe4j17fAj8L3LS+FQ1kGi5yv9C8eM6kMX3F9vLs
         id8l6MYftmBk33d36WP+Ez2iFRn0HvLe1Gfx/IEkUleg2/00VsO74Rseqq+zKcIKzxDP
         nXTHyYNlbJ/Umrxp5Gg/Wc0R7lDyXP/0lYzxt3QyWA7yWWuOpLaCjJddSQ49JBktQOpO
         koO3KUh1PzANKe5MzHRg0qHsdn7nmXUl3+y3IlTYBezo6RO12i0KPVhEspEbBaGxF0yO
         96Xv9BbTVJ8HTgPIyhQQnUXonnt3v6nyV75ELXKBC88QFAFPImqUVddMfPbHvH03wnSm
         gOWw==
X-Gm-Message-State: AOJu0YyFYuN7r91BzKVhNiJaV+jNOAtMUOM1qJUhq5ICtNW7luFYY37k
	oYwlDfDF7S1gI/NNLaTTCWvBI+kUn9YfLsoep1RW7VyqR5kIGzWVjaYtcZHOUqOc
X-Gm-Gg: ASbGncvj0Dcgl4f5YmbBfS1QQu3jBbO9RngeF79oMPo7W2k/3qP6FrSL/Xc6CaK41n2
	GgYKelwqA1yh5Hg9x3Fgz7U/97gdjc2alkxIPVHuBCLksH/WFtyd0A44EbhuD/fNVXEMO3Cc7wt
	BRT/Btx13YS2pxKk9SW2jQ7WynR362Zy6BNY4IRT8Vx7CGpbIqPFFoMctqsLGSTjnzIdziPsyxp
	FR81IBE/kZx/F6g+Yjjy1Lgh1c9ewN5y0VeMB6GdIawpU1jBr36KbGtAjpru4U0EtScshVaCVN9
	5Xeea1pZ2kgXrroKRUcZowAB/z4mG/YzB68BgL4Zncu2NoxvX53RJghz1kv4fMR2pdOjNF6Fsli
	eZXMqcaB6PD8kawY8bQY=
X-Google-Smtp-Source: AGHT+IHQheePvQ5yqYz5bIZ3Y+BSWpclmCDXd/3ay/SZjzNEX/td45D6IDj7u+LL8uwNSKb/ATXXqQ==
X-Received: by 2002:a05:6a21:9989:b0:23f:fd87:4279 with SMTP id adf61e73a8af0-23ffd8750a0mr12374678637.8.1754386094916;
        Tue, 05 Aug 2025 02:28:14 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm12465691b3a.58.2025.08.05.02.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:28:14 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Aaron Lipman <alipman88@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC][PATCH v6 2/6] builtin/for-each-ref: align usage string with the man page
Date: Tue,  5 Aug 2025 14:57:54 +0530
Message-Id: <20250805092758.5321-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805092758.5321-1-meetsoni3017@gmail.com>
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
 <20250805092758.5321-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage string for `git for-each-ref` was out of sync with its official
documentation. The test `t0450-txt-doc-vs-help.sh` was marked as broken
due to this.

Update the usage string to match the documentation. This allows the test
to pass, so remove the corresponding 'known breakage' marker from the
test file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/for-each-ref.c       | 15 ++++++++++-----
 t/t0450/adoc-help-mismatches |  1 -
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8b5fe7b65e..fe62f07861 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,12 +9,17 @@
 #include "strbuf.h"
 #include "strvec.h"
 
+#define COMMON_USAGE_FOR_EACH_REF \
+	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
+	"                         [(--sort=<key>)...] [--format=<format>]\n" \
+	"                         [--include-root-refs] [--points-at=<object>]\n" \
+	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
+	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
+	"                         [(--exclude=<pattern>)...] [--start-after=<marker>]\n" \
+	"                         [ --stdin | <pattern>... ]"
+
 static char const * const for_each_ref_usage[] = {
-	N_("git for-each-ref [<options>] [<pattern>]"),
-	N_("git for-each-ref [--points-at <object>]"),
-	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
-	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
-	N_("git for-each-ref [--start-after <marker>]"),
+	"git for-each-ref " COMMON_USAGE_FOR_EACH_REF,
 	NULL
 };
 
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index 06b469bdee..2c6ecd5fc8 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -17,7 +17,6 @@ fast-export
 fast-import
 fetch-pack
 fmt-merge-msg
-for-each-ref
 format-patch
 fsck-objects
 fsmonitor--daemon
-- 
2.34.1

