Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F17199B8
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629193; cv=none; b=CjgPF9WTigCAMvW1b3ODcm60PZGjCLo9qDFhDuZoVREdv86mSxtEZ8TaOGKqxzM4D10+YdT35mgDarbOjjtRjFS0/d+GzU0QHpoKqLvcYSLRXi57k5Qd+MQ00Q+zhdLKhtadP3+CNr9quwiOlHk2e4iD+FHi4XRPtMHdUgHAqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629193; c=relaxed/simple;
	bh=oK7G4tie52Mf2Ja8/jfPrZ3dZXGRCiAqu5vkLd7QnMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ig6+zrA73cZz/bTw3F9Xi+cuWamGOYqdeoxDSlqslYJS2qsbExiMRAwIAoSrg8qsmDyDuvtDmc89lsdjXtcL0AP9KKkAq6ibygNWTpsskQMYnyUxGKm1GkaP1vOF1ASux9hFjqzmzdzAXvYAQ3/L19//gvvuwAqHKmsSBtIGGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF7qyV+K; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF7qyV+K"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d333d5890so85449b3a.0
        for <git@vger.kernel.org>; Sun, 21 Jul 2024 23:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721629191; x=1722233991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etwOXNaKfnUlohRB/w327d+jKqCAx6BI8Yc8u2vmvzo=;
        b=GF7qyV+K1FWbHlPbqvj/6JIgZu2yNsF8mszc3PAPydyZzNETW3rfgMwrq0wzx7FnVX
         iBM+kADkGxfvo7ddsxURsNFmZWTf4OrH260FkpNnH/kvvsKOrbLgcdqQTe90ZlKL1nIB
         UYfmeFsLTKttZV484lHyWAvlyVvhYZ5P+s5BuSNTV1U6u1B3iX9Z2zp0k/BAeRI4LuxD
         WTAQDjS00Qu82BUYW60zEZEbVNBsY6iD+mFNsOoCFxOwBolZlqrQS6oxJ+Kym+Dcxyjt
         aN5sU3YS0FsGmCBUi2tcXJFMCboXvfK4B4e8sReJ5SadUjOmmsZd5PWrrEtWq+0kXuYe
         GdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629191; x=1722233991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etwOXNaKfnUlohRB/w327d+jKqCAx6BI8Yc8u2vmvzo=;
        b=QIr9Y9OZznlAW8f4RF+9mHQ5yMhSsdUxAkY5aKWsp6eiFwSzKMMpJm79Ogygw0kMec
         zIAYp2C6DlFG/gtWL/xrC2rjnTWVn1Jo9AJhhptcQUIq9mds7RJEUTkPBAjyKzouE9Jz
         QQAi/6U6E1IVGVdEHvXlA4GwJbdYWWreuOJKhpX0/SviSMLdbNdZuwBjCNKeTApR+nRd
         bHMOvD6EW0ZIC2WvW0qfmoH2Z9XCXxfwk+3/U9n5i/62lW7zO5ZBcANtIG2l3XdUjb0c
         IFS0Rtew2fwSleKautZH3FcKzGPYLYpmLm5C0A2RP9tl8IC4ET+qldEacBvWImq2BOQz
         NfQw==
X-Gm-Message-State: AOJu0YwX7WEIQVEib/nECChyjaY5ZhwUt4hJqidMxEBptOkeb0F+diJx
	F6tdd+OeLGd2WtFsXj3sFHlsrmq4TCdnTucHlPgSDF5Wqqu/EnZofUAT4WEtvtM=
X-Google-Smtp-Source: AGHT+IE+6tPuDEWInY/OYyBorpE2tLXZO4qa4UOT6CwkOpEAH8w9M6YPxxSGhbiPc3tw9wJEuxLrLQ==
X-Received: by 2002:a05:6a21:e93:b0:1bd:24f9:1124 with SMTP id adf61e73a8af0-1c4228c3782mr9575008637.27.1721629191100;
        Sun, 21 Jul 2024 23:19:51 -0700 (PDT)
Received: from Ubuntu.. ([106.220.63.154])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f31a73csm46362885ad.143.2024.07.21.23.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:19:50 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v5 5/5] t-reftable-tree: improve the test for infix_walk()
Date: Mon, 22 Jul 2024 11:27:58 +0530
Message-ID: <20240722061836.4176-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240722061836.4176-1-chandrapratap3519@gmail.com>
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
 <20240722061836.4176-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for infix_walk(), the following
properties of an infix traversal of a tree remain untested:
- every node of the tree must be visited
- every node must be visited exactly once
In fact, only the property 'traversal in increasing order' is tested.
Modify test_infix_walk() to check for all the properties above.

This can be achieved by storing the nodes' keys linearly, in a nullified
buffer, as we visit them and then checking the input keys against this
buffer in increasing order. By checking that the element just after
the last input key is 'NULL' in the output buffer, we ensure that
every node is traversed exactly once.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 6cd35b0ea0..d7d530f2f7 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -15,15 +15,14 @@ static int t_compare(const void *a, const void *b)
 }
 
 struct curry {
-	void *last;
+	void **arr;
+	size_t len;
 };
 
-static void check_increasing(void *arg, void *key)
+static void store(void *arg, void *key)
 {
 	struct curry *c = arg;
-	if (c->last)
-		check_int(t_compare(c->last, key), <, 0);
-	c->last = key;
+	c->arr[c->len++] = key;
 }
 
 static void t_tree_search(void)
@@ -54,15 +53,24 @@ static void t_infix_walk(void)
 {
 	struct tree_node *root = NULL;
 	void *values[11] = { 0 };
-	struct curry c = { 0 };
+	void *out[11] = { 0 };
+	struct curry c = {
+		.arr = (void **) &out,
+	};
 	size_t i = 1;
+	size_t count = 0;
 
 	do {
 		tree_search(&values[i], &root, t_compare, 1);
 		i = (i * 7) % 11;
+		count++;
 	} while (i != 1);
 
-	infix_walk(root, &check_increasing, &c);
+	infix_walk(root, &store, &c);
+	for (i = 1; i < ARRAY_SIZE(values); i++)
+		check_pointer_eq(&values[i], out[i - 1]);
+	check(!out[i - 1]);
+	check_int(c.len, ==, count);
 	tree_free(root);
 }
 
-- 
2.45.GIT

