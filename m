Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAF15AD9E
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834295; cv=none; b=Ay5eId3ob6Bf1UYEI7OFaTXZ/uDIedMtLLRLUShxMRtw2raobBqo2pA7ZEDnr6m/g6v0PXxOBtYwlB90UyANgPwXiuCFAMbBhMwvkrf1/7/1/YUO1XDVPraPVJYr/SQn0hzXbgxUoFDKEZuYTp9LbrzKM66x5zlTiM7vDioTeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834295; c=relaxed/simple;
	bh=Y3uGIenf3VzNzcILgOt57Fdj/xN4aa5LA6kSN4497Ug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DUUz62QuPB+m6p4s2iyHRKUID9yo5N/CIO6uNE02pYedw6yTvsNINo2asKiMLhtWrXgQ0LW6WkNF7hvmQ4xQVkE9FHNNVkCiEW4GAKVt2oGUb+03uIJLdI0zjb20ACYjUrM08YH/4ZaxXM8efHv2aG7fe0fnW32bf0rNBqlCSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2Y1TsOl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Y1TsOl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421798185f0so2741555e9.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834290; x=1719439090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urh7rNdpn2o/o6whqr985oqkaAGHqzZf69s+OZ65PsE=;
        b=G2Y1TsOlTWF8AjXKmOKN0L3JahfzX05a8jRTW0iU+BqWeD/uLmBDg2/9EcgIgWOk3z
         z5pK3lP7S7RbF7vMUPwbWzOOJwRu0dpcLVvE5ixA1bNoYDrfLZzcYOglUixdTjd+ITJt
         qqWd0TkEd8CxjauRhEwyGiwhmjEp0El3FvU2eul+0LM4D6273J2a/+bRxj3UVF58fw55
         xnFs/KRwz+PFOHL8kEGoog70FPDDRA56ZQu72+AwwbFPBRnXCK7BCnEuWu4TC+N7mW0e
         2e/39DAYBJoV81aGAWEM0aZYEH9FzbSbQaBegm+Zv6T7SjrA5K3aCabYrHnsLyoexaWM
         zF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834290; x=1719439090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urh7rNdpn2o/o6whqr985oqkaAGHqzZf69s+OZ65PsE=;
        b=nLBCIwzq01q2ba+hAZhHrxYweKx4c+qV/C7sIzBwNP9i6sv2fE87Txr0QgWdD/8nq7
         vuyftHfBtLKxsTmcyaK6v6W7xfLfJr61/E3CFsF4JXiNgi0McAh8T0VJBPn6SOTGElpJ
         uywt/yjugT9OMg3Nvvxdzd94K5OE26ZwLSdV2fH033J7yWZbbvAl8T2b61ovFGQfxB+f
         X7QoIXbPuexCCEL/+LbZUIC7iRsEirg5+5fzhM0j+C9EfOJBNUvnaUiVekEA2v8OWul/
         qxqkCIiQVouVAlzEQbSmqEkOguxsUlddab6C+EPzi+NgTk83im09yRHhZZEhpSmZVEpR
         yorQ==
X-Gm-Message-State: AOJu0YwU9I9rqEA+RxZcbhv4IDocvXzi2ldkNbWrOAZCfri6ANM3nrQ+
	5Agns92rQBegfpu+wKhmAIWsy739i7Ea7JLMo/qUrk0Hc4++igEGpBkriQ==
X-Google-Smtp-Source: AGHT+IGbQ0/FYciYuJ1xOQVFyBO1lWkbM3iB7z0mEY9VvTTqUO370koc6LuQmMWx4q4maksFL3pbmg==
X-Received: by 2002:adf:ef02:0:b0:355:161:b7e6 with SMTP id ffacd0b85a97d-36317b8321emr2667290f8f.41.1718834290300;
        Wed, 19 Jun 2024 14:58:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-364999e27c4sm465311f8f.57.2024.06.19.14.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:09 -0700 (PDT)
Message-Id: <4558f35e7bf9a1594510951ee54252069bdcfc5b.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:50 +0000
Subject: [PATCH v2 02/17] mktree: rename treeent to tree_entry
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Rename the type for better readability, clearly specifying "entry" (instead
of the "ent" abbreviation) and separating "tree" from "entry".

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 8b19d440747..c02feb06aff 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -12,7 +12,7 @@
 #include "parse-options.h"
 #include "object-store-ll.h"
 
-static struct treeent {
+static struct tree_entry {
 	unsigned mode;
 	struct object_id oid;
 	int len;
@@ -22,7 +22,7 @@ static int alloc, used;
 
 static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
 {
-	struct treeent *ent;
+	struct tree_entry *ent;
 	size_t len = strlen(path);
 	if (strchr(path, '/'))
 		die("path %s contains slash", path);
@@ -38,8 +38,8 @@ static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
 
 static int ent_compare(const void *a_, const void *b_)
 {
-	struct treeent *a = *(struct treeent **)a_;
-	struct treeent *b = *(struct treeent **)b_;
+	struct tree_entry *a = *(struct tree_entry **)a_;
+	struct tree_entry *b = *(struct tree_entry **)b_;
 	return base_name_compare(a->name, a->len, a->mode,
 				 b->name, b->len, b->mode);
 }
@@ -56,7 +56,7 @@ static void write_tree(struct object_id *oid)
 
 	strbuf_init(&buf, size);
 	for (i = 0; i < used; i++) {
-		struct treeent *ent = entries[i];
+		struct tree_entry *ent = entries[i];
 		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
 		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
 	}
-- 
gitgitgadget

