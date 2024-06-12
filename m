Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462D1EB45
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171467; cv=none; b=qz5MNOwKSP6ujQfTME3iKo502qLDmzl3T6XdNwTkj28CcvsUYyK7V+6/wauF+EWg/aKhXcLebifkjr7g3llLgrcQU652wUqgxTWTybK2lk4zKSbaDgIvhAblThZVhoXKkuMWZ57Kz0Jil/gkB1ym8TR8g1UlbA743gFO3cC+eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171467; c=relaxed/simple;
	bh=Vg8lr4/Bm+hHi8Pl4iOuphqxbznv+5JAh8YSrO08Rjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpNixcluxQ1TyLatBNj+5zee+cNkwqoPIX7RG57hv+eK+sglEjQ4+nKXemUJV5WLpPAop4BZiAKLqz7Ny7D6I8mJxxVUlku8E1e7m85sW5zNcqHlIrgFS0SBsTfQKZZotPfmqCOCDi+5A258vJrRkjUPkJ1d8EQOHcFyLNk3N3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF39fdaQ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF39fdaQ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a2a6a5ccfso23562837b3.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718171464; x=1718776264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4X3e3Z7MOsPGcx9grwDTf7tmbLprv2+NFWd/pBK21s=;
        b=PF39fdaQXsnXqXeR7MEam8L+8ZjO3fUmt3OHxDOgQ1FPAtXIogxQTODfLj8NjXm5f5
         SLbueYkZo4m1GK4wV0+1m9nCvySuiM8kFRo/Yku4+CbxnGFWxGlI9PLuBclHDS62OdcX
         j2SZVrVNaiduP5ECRL6ienac208GwSXSaDHVppezUgI8tkrEQeVr8wEHsneQmdC2ByYK
         8fVYDthE/djM49DkKurVk2chFg4BDmTcYEBxeuxsyLMqBDp3rjoHg3rJvsw7VzuHs5Wy
         lUm9uDQvHAQx+Iw7BSl2MV8yOvE+OQhXRjOTKlPyi6ajS76750JS61g0gzOV5+V6BnP/
         Z0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171464; x=1718776264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4X3e3Z7MOsPGcx9grwDTf7tmbLprv2+NFWd/pBK21s=;
        b=cSDoVr4yc8fUGWh41JjDbdmg3E9FnI+IeIiAyYjP/DKsNxHmogLY7N0dqrdHy+y6Wc
         X8ky62yRvuJ+aZQfyWCzTjXfNmzY7yp4kneIdqhIdguLbH1HPT/LH23zlULXKESNi5oV
         F2Twk//22nl2tdCCcbqqH7bD8KZpqa60WX2xap6sLewxypU9O/yJlomHiEHYbEF9m+Au
         8t9UBTEMfeT1wjjrhbbCCUq2pwv9kLeOKXFxp1odilDh7kTidppnqZIZIUmScp0GBzq7
         l/+4AHWulti9bMsZKsn5BZwj44NFsLZF8F6X5oLczHXaKFp+h4QkNRFCs1ciq5TvUZJ6
         arkA==
X-Gm-Message-State: AOJu0YwqyRAtZZbOWUmcweU7vsR9M0epxKThpUN3kPL+BoS5wmOWrWKV
	VSQRKhMoFIq1ByR+hMd2a2zEodDpI8cVfM8GvboKnpcODMHc/JbWNH8GkpG+
X-Google-Smtp-Source: AGHT+IEcvLjVhKB2mL/BCfWnHDpk7mE9R93XxB0qoo/jCTN0xnMZYsO0R5ZZlkfW7yfhNWTaiojqCw==
X-Received: by 2002:a81:6fd5:0:b0:615:8c1:d7ec with SMTP id 00721157ae682-62fba375d32mr8510137b3.33.1718171464471;
        Tue, 11 Jun 2024 22:51:04 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6f78b8336a7sm1934114a12.73.2024.06.11.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:51:04 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/5] reftable: remove unnecessary curly braces in reftable/tree.c
Date: Wed, 12 Jun 2024 11:08:10 +0530
Message-ID: <20240612055031.3607-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612055031.3607-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
 <20240612055031.3607-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/CodingGuidelines, single-line control-flow
statements must omit curly braces (except for some special cases).
Make reftable/tree.c adhere to this guideline.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/tree.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/reftable/tree.c b/reftable/tree.c
index 528f33ae38..5ffb2e0d69 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -39,25 +39,20 @@ struct tree_node *tree_search(void *key, struct tree_node **rootp,
 void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
 		void *arg)
 {
-	if (t->left) {
+	if (t->left)
 		infix_walk(t->left, action, arg);
-	}
 	action(arg, t->key);
-	if (t->right) {
+	if (t->right)
 		infix_walk(t->right, action, arg);
-	}
 }
 
 void tree_free(struct tree_node *t)
 {
-	if (!t) {
+	if (!t)
 		return;
-	}
-	if (t->left) {
+	if (t->left)
 		tree_free(t->left);
-	}
-	if (t->right) {
+	if (t->right)
 		tree_free(t->right);
-	}
 	reftable_free(t);
 }
-- 
2.45.2.404.g9eaef5822c

