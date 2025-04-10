Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6D28134D
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284649; cv=none; b=lpV2GL8noGVdGgFjnWivzQ0CuWQZsgRh2EjfI/DSzcb37G2G94+swU1lkeAcD4rk6KCKcoWnm+QoywZvAhzibm9/zCH0yEiiGde2XpJzzhhfifFL7brrfn8gz0e6OXEKvvmTmWFPL0sTZPihjOa6wYjO3PL2nVsgJXKs1jQZSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284649; c=relaxed/simple;
	bh=F3Q69tFNbGxg+PEJ9V5jxC52Sl7UYCWNVH5idkt2h20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MY9eScQqoNgGRWd3jGYGZSVdWwfOORIAjRWcLJsFvHsLWMPeN9gcvsyQiwXHUeSB1nAk5MLZKjIAulZ4RhtS0Z9VeFDDMnWbSRUhWEffWwRPT7TYq0jsGN0jdCsRMQfJoBFd4Pam4/qW5Wfdd9/BKbr2FbUVhbu8cEP0JSGqGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS8kCm8K; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS8kCm8K"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso141695866b.0
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284645; x=1744889445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gd24CCdItEBTAAHxOfC6kXtEz1iXDr1nDOlouqc/Ro=;
        b=gS8kCm8KiRNeyjW6fUZFmc5gHv1cFzofeCXJADwFeQnlLQ8AAW7eCv66RILmLJNXv+
         LicQeykaMN1lLUNCNz2DISibfbF2742UcoJ3wlwK+hVWtoX9VcmO28c2QGJCQBqVicWP
         Gidh/OulNInc295KWYopaZgF++NFjWbZtpuoCLUmBW7i2VAHLYVI2dMl+PV8VL/o41qc
         QUfJcXa7S2jjeWJccXu3FmjvphADv6QYXoSVbsQP7LKuM4GF/pb+mPvu0dHFhHYNed1f
         /Ej2gJalyr7bD3jHdIY+TXQP/2SdPNPxGsKh3zNpny3zoNQBFWtvcUL/qTfzWOFw4r9o
         cFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284645; x=1744889445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gd24CCdItEBTAAHxOfC6kXtEz1iXDr1nDOlouqc/Ro=;
        b=UOVH7w6VJA6UJGOTUurHKDj1dmlQJEHlk9y2ctn9MLk2LPnxSf8nk3CPqmgzgk2qFW
         RmNzB51naQkLQK+guM4HDNm62M3GlnDuXNgeY42Tn+utrWu1pf98NdA94EdbPozUFeHu
         TmO7G8GxbAjochXvdjp+NNjSCJUgKwyKFAapOZcHB3enn/I1KQXHsYXe6MoCZIGyt1aj
         pNjvH7XCVuAlAFBNfsuhwyxSN3VYPJyqbOpgSU5dovWnX7AkT9SfLGqUDqo9QOGMfUbJ
         ZANTJY7rqJ9Z2vbnB3PT/SXRWNBB5iWkLQxlKW4/U/O2NAPknv1TKwcH1WGDjJ6Lq8Dw
         KRAw==
X-Gm-Message-State: AOJu0YxjoGn5joO5gbf/uDCnfbIM8U9ywNA9gyPdxlUAUcSgmy4VdYWr
	wbZJzCsItT3Sk9a4Q9DzvNFiEiJLpbdrb64Tu3KxP6cbokkBOtqQW+wo4c27
X-Gm-Gg: ASbGncsyOfugob+0Qj5r0PZ8JX/uLaixtQkAD/5ZR7To+rQlp04o/x6GfsBOXzcLkPF
	3KtYExF/jMr94pTTNeeIHDs/0WanpyGMP31cVV1Xl0fQNFMshtss8kCX7FOwFoKxZHuQVpAIyE4
	qE4BOclCqn0uNxrU3o4zujwl3pIouN8B5UzkFE7WVlmEo9Lde9dEIWRSnHFEf6ZdCs3Xw0yu4lP
	2b+Rx2KxDVLzZkGsMIKEYRem89oUpfeYn02w/IU1owrrSRMwyHV6CsIY89jgaZ9t/ofh/FbppXa
	c/MIb5V717quuS/wJREyOKQ53SD61eYj02Qcl5AfhRrTbg==
X-Google-Smtp-Source: AGHT+IF2++oCAKdyzgKeWc2ntEThXiqSk6Og4VIbqzrmiQLm/HI+Z1sBe2Z3P1VNfcBiz23zMu3srg==
X-Received: by 2002:a17:907:60d4:b0:ac3:8aa0:9d70 with SMTP id a640c23a62f3a-acabd4cd902mr202971666b.51.1744284645401;
        Thu, 10 Apr 2025 04:30:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9936:e3af:b877:72d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3553sm260230666b.29.2025.04.10.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:30:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 10 Apr 2025 13:30:32 +0200
Subject: [PATCH v2 2/4] meson: move headers definition from
 'contrib/coccinelle'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-505-wire-up-sparse-via-meson-v2-2-acb45cc8a2e5@gmail.com>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=F3Q69tFNbGxg+PEJ9V5jxC52Sl7UYCWNVH5idkt2h20=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf3q+KPGedGEM4qMU3/O+adKftUPiA5DPIjo
 rRHs/jwyHFVyIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn96viAAoJED7VnySO
 Rox/Ho0L/0zkVcrP+lUjWe3EPYedb4AQ7sXJbtUx2qBecHmV2T8iWZxDhvmoO7GXbTjIadGG21f
 gCGvKxkzcAMJh2dy1JEzwbb0eX9uxN3DAyjyZu1qa3fFRwDiNXXpfbE2Go0FS9ElWlj69tmsyWr
 AEWMPa40yKnOq4Yc8KpOHDlcA0AiP4gE6XL0w+B7DiVvqLzbZ4sMr8sJVs36fVNBw+pbf6G2qdV
 oGCrvhc5J6+TqqTjeXwylxsXboCsXb5xmsTvyKVqivUuj8QOr88tyUvwtFbksaZtsH4QDMhM/cy
 WoXDOboP3c17XBkBCy5pjVq9Svz4OJcYaUFKLn+r6tsfx4s4Vtxb5iJfFOBu2IrXL2TRtVKiUNL
 hFrrpe/7y2Q4vroKQmCsfPQuOZ+R53pa/moQrIgV+uBoMQRnOj0AUJKlOrQN5+l+S7ZQGcEXXhg
 iizkJneg68LZni+o8FKVcmYTooO1k0ESfqNYDNmVsgpgQtKs00ZI/AOqWtVzNbq5MJkGv0UjwT6
 +Q=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The meson build for coccinelle static analysis lists all headers to
analyse. Due to the way meson exports variables between subdirs, this
variable is also available in the root meson build.

An upcoming commit, will add a new check complimenting 'hdr-check' in
the Makefile. This would require the list of headers. So move the
'coccinelle_headers' to the root meson build and rename it to 'headers',
remove the root path being appended to each header and retain that in
the coccinelle meson build since it is specific to the coccinelle build.

Also move the 'third_party_sources' variable to the root meson build
since it is also a dependency for the 'headers' variable. This also
makes it easier to understand as the variable is now propagated from the
top level to the bottom.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 17 +----------------
 meson.build                    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 03ce52d752..32568c5103 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -8,21 +8,6 @@ if not spatch.found()
   subdir_done()
 endif
 
-third_party_sources = [
-  ':!contrib',
-  ':!compat/inet_ntop.c',
-  ':!compat/inet_pton.c',
-  ':!compat/nedmalloc',
-  ':!compat/obstack.*',
-  ':!compat/poll',
-  ':!compat/regex',
-  ':!sha1collisiondetection',
-  ':!sha1dc',
-  ':!t/unit-tests/clar',
-  ':!t/unit-tests/clar',
-  ':!t/t[0-9][0-9][0-9][0-9]*',
-]
-
 rules = [
   'array.cocci',
   'commit.cocci',
@@ -61,7 +46,7 @@ foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files',
 endforeach
 
 coccinelle_headers = []
-foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+foreach header : headers
   coccinelle_headers += meson.project_source_root() / header
 endforeach
 
diff --git a/meson.build b/meson.build
index e98cfa4909..790d178007 100644
--- a/meson.build
+++ b/meson.build
@@ -633,6 +633,28 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
+third_party_sources = [
+  ':!contrib',
+  ':!compat/inet_ntop.c',
+  ':!compat/inet_pton.c',
+  ':!compat/nedmalloc',
+  ':!compat/obstack.*',
+  ':!compat/poll',
+  ':!compat/regex',
+  ':!sha1collisiondetection',
+  ':!sha1dc',
+  ':!t/unit-tests/clar',
+  ':!t/unit-tests/clar',
+  ':!t/t[0-9][0-9][0-9][0-9]*',
+]
+
+headers = []
+if git.found()
+  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+    headers += header
+  endforeach
+endif
+
 if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif

-- 
2.48.1

