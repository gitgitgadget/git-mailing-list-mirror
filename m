Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CD192B79
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431827; cv=none; b=L/b174LndRPRq0L9noBWTaPOBUBFmbrGDKIATHuXcfFReFoXrAejg4VkamwDgd9uC0UAJkI9kzOYx0MNUYADQMZvBPHlgyM6MTimzS40IbsG6Wqmz7kH3X6ztMW5rYfV1FTR5w25QEv8q36fjiH9AtJ4AZULo4b/Olcx3gvygUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431827; c=relaxed/simple;
	bh=3KG8xDFhZJUU4MovgpJBEUuP4N3yK1BTDVlV9VHiBPQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QsQKl26/wVAhoOh+r5ra1kEXQJhzIYP5oAZNlX+1Iaijw7BL5lGzAzB2veHDpcVJMGky7UjVxUNGK/lLG9aQlQf5cRQ7Z+LFW7A6iTH1wjdGxEXBs953KsvsZuMEYILbcWK+jMLBeHhE48hH/D68GBxAxNrzWo6lgYgq0ZulSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIgaB2oS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIgaB2oS"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f629a7aaso634548266b.1
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431823; x=1730036623; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkHmyWoiMSddCJqaKc5Y1nrU9AE+aiKTBWZuJiNLgsA=;
        b=HIgaB2oSwV5DJO7QH+xcBSzbWVgWvWrodMEUTnaeopfxrNW79PHLL5F83UQy8CUMIS
         uehcOpVVwjcyPcHDBGIcVhECd4qM/fHzMX0qMcQ37c7t3+lCgBec3cowc8FBSn8CouCR
         2hDcMNa6pahieFn2CojsjEzgP6y0CYX6MUihnil2mF4dXfDbSjbmYTqxidrRaWF/pjzX
         GfL06LMxH3HBdWsUSFCuxZnT3ll6I1U1nS82Q8J+0pTnsaOIhdcxy9Gnk8KCO8Ah2qox
         FDzNp1RDGcaJqxo71c+1OzMS4zZiRk5z6X1GyHu5XuTol7rNOWSfps+rSdticzBYgbyW
         pMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431823; x=1730036623;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkHmyWoiMSddCJqaKc5Y1nrU9AE+aiKTBWZuJiNLgsA=;
        b=cKqsbpQ0XYSZF+x+sJbpE9hmUTPDdleoigiVsT86vk/ZF7yw8bhpQS2Ezln4QEa9SJ
         AeFHySIvxOAu9aKAwc1WARFR/2WyEeonPY0C/ugCrSa91wk+kFEI1Hsd08KolepiAcY7
         d21xanfednc5hzabMHNWMTCrLhkx9sMJ9qh8GpNR6pJoBZdQl4AypBp5Pn4evxgkTAvM
         y651SXrwrQdfW757+cHszp/8j/VfvK/BoDgq03wXOZrzVaGPpAuxHZEaWEynDq6DsQkQ
         KdRiqzRHRlIrlIcTS2JIgf/AAuHuMyAPJCoM1oRSD+GupzSdqnyVbgTIGYGdOZidK4Bz
         VD4Q==
X-Gm-Message-State: AOJu0YzyHklMr7m5bN2w2jeeZ+ONfh6na0aFJ3Srjwjb00Axn7jncRuC
	RmaWqQg0xTL4vVmeV8zucRvIRMm907AVkTt0sOHSL20Xyxb0RXWD1yp5pg==
X-Google-Smtp-Source: AGHT+IGcZngLaVcgtZ2loWLQTZHdgqZzmAqxgXCIK7cxl2OY/ni/KpzcezYPsG9XWMvnb13VsQJx3Q==
X-Received: by 2002:a17:907:e8b:b0:a8d:2281:94d9 with SMTP id a640c23a62f3a-a9a4cc3aa5fmr1366031666b.23.1729431823305;
        Sun, 20 Oct 2024 06:43:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f7606sm93170266b.78.2024.10.20.06.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:42 -0700 (PDT)
Message-Id: <73c8b61e87b1cada72fed695a450b0541bac19b8.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:22 +0000
Subject: [PATCH v2 09/17] pack-objects: update usage to match docs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The t0450 test script verifies that builtin usage matches the synopsis
in the documentation. Adjust the builtin to match and then remove 'git
pack-objects' from the exception list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.txt | 14 +++++++-------
 builtin/pack-objects.c             | 10 ++++++++--
 t/t0450/txt-help-mismatches        |  1 -
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index f2fda800a43..68d86ed8838 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -10,13 +10,13 @@ SYNOPSIS
 --------
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
-	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--cruft] [--cruft-expiration=<time>]
-	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse]
-	[--path-walk] < <object-list>
+		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
+		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
+		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+		   [--cruft] [--cruft-expiration=<time>]
+		   [--stdout [--filter=<filter-spec>] | <base-name>]
+		   [--shallow] [--keep-true-parents] [--[no-]sparse]
+		   [--path-walk] < <object-list>
 
 
 DESCRIPTION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 103263666f6..77fb1217b2e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -185,8 +185,14 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [-q | --progress | --all-progress] [--all-progress-implied]\n"
+	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
+	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
+	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
+	   "                 [--cruft] [--cruft-expiration=<time>]\n"
+	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
+	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
+	   "                 [--path-walk] < <object-list>"),
 	NULL
 };
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 28003f18c92..285ae81a6b5 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -38,7 +38,6 @@ merge-one-file
 multi-pack-index
 name-rev
 notes
-pack-objects
 push
 range-diff
 rebase
-- 
gitgitgadget

