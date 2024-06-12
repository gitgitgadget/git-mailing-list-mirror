Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B117B4F9
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197381; cv=none; b=kapouqszo1lBcmGDi8M+Rh4mnLnhrzebkAM4RVPxcVrA3rfOuzhYxdy7jMIImrthOqJ9ZSwu6/8RkfuUwdrAKDG36GVem0ZUPuNPePfFmxmKI47h5gTWFF79RZz3roOJnjRcYT7ga41snMZKYR7nWYg7+Ttepob5VSbMQcN4TMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197381; c=relaxed/simple;
	bh=yX2T3elDEVRqBCMX8TyAPaCGbctUnnI/YTPaZ895czs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMeRPZnOPmJS3Mm1BqDrO4RF+t1j03Vp3e98CppuzLq+5uTAbVPY7wA84rEibiDWxTXhIQ7xhIa6JoG2y0ZBQ0k24k+0gHDNGBMfOO68DEG4WAZs1QlIxeb1yZAgCC+cb19Io/KokGmHfXvM+QsFp8B4BhmRdkhuB5hVNJ+l8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgYNxiMo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgYNxiMo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f7028196f2so28225305ad.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197379; x=1718802179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu1WY0FKnfrUCF7ffjbGaaeh3Ox0MGFf9/paH5Qp8yY=;
        b=OgYNxiMonleQbjMFj0PP1PZbKvPZ6WFxXwv7O3z6FDV0l7PuVf3o5hIvWN9a8xEx4M
         6mNhB8vrJb6Sbeu7U2VMS/kx/lqwCplFRq6bKK4UMPxMHzN+FX8iax9oHecP6CiDLdgo
         PK2M2Q+ucqxKkv+dTrEVHGUgrdmQla81Tb5GtjPvAtV0uPpbpaiOzI+ogtrmZU8XxOrY
         xRoDDsrs4XXoSG7NOYq7M21dXrvUxr6uwG8m87B/wWRHc+dAYTHTTIgkjcM2uqvxojsN
         uuDaRec6d+HPGGpcet4Df+kJT0Nh2e76goXVCHTgoHsSuP7w5p36cGjkmmgikD06gXw8
         tpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197379; x=1718802179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu1WY0FKnfrUCF7ffjbGaaeh3Ox0MGFf9/paH5Qp8yY=;
        b=NJpgNSJNQyvDaTE+omrygqz5TRhwcTALtjW9manQr+5Kkd4Pq1fH4EJQPTPE5chtl5
         A3t+pUCfcruP1+tEFhS/rU30UfkFZH9hvg6Bjyf1KRAatPgx4p+WoNtj7RHUdvjKusqW
         RFkcttiHRJwP0mn/pW9a+MHrDR28qCdl/NtnlXGBL2bnP0NhUachHBfFFTb5EIT3h3Qz
         t4vg6ekRcM7SofqiJg9Fuffjc/IsMf9aU7fHtaMCS+q7tSFf5Dcq7VFth8d69jTksUTc
         MZvCmUx5l/0IkwERIcyIKtNiO3JDiyzZE2PZmqrOzxDlcp1Y0xxKQYvavvsnxj9mRhEE
         pXlQ==
X-Gm-Message-State: AOJu0YzumE97lMamaq2fDFm/CgbVs/JdpGcJhc51Q3JElkDCuBxl3Z1h
	91fcGYNHF2715qUU1mZ+lZVlWAQGDxsMcvtA8uAZXKZFwK/ESewjUgZjwrz2tJU=
X-Google-Smtp-Source: AGHT+IE29qH/uLuUtOnfcN0SJrFpWcqgkdqJq34vBIczCDfX1/6nRDUutj8tW5NAxvPyvDS75Adw9g==
X-Received: by 2002:a17:902:d512:b0:1f8:3c47:9d9d with SMTP id d9443c01a7336-1f83c47b2f7mr17290115ad.38.1718197378851;
        Wed, 12 Jun 2024 06:02:58 -0700 (PDT)
Received: from Ubuntu.. ([106.206.196.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7fd25fsm123942325ad.280.2024.06.12.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:02:58 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/5] t-reftable-tree: improve the test for infix_walk()
Date: Wed, 12 Jun 2024 18:23:03 +0530
Message-ID: <20240612130217.8877-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612130217.8877-1-chandrapratap3519@gmail.com>
References: <20240612055031.3607-1-chandrapratap3519@gmail.com>
 <20240612130217.8877-1-chandrapratap3519@gmail.com>
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
index f1adab4458..79c6bfd49a 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -15,15 +15,14 @@ static int test_compare(const void *a, const void *b)
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
-		check_int(test_compare(c->last, key), <, 0);
-	c->last = key;
+	c->arr[c->len++] = key;
 }
 
 static void test_tree_search(void)
@@ -51,15 +50,24 @@ static void test_infix_walk(void)
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
 		tree_search(values + i, &root, &test_compare, 1);
 		i = (i * 7) % 11;
+		count++;
 	} while (i != 1);
 
-	infix_walk(root, &check_increasing, &c);
+	infix_walk(root, &store, &c);
+	for (i = 1; i < ARRAY_SIZE(values); i++)
+		check_pointer_eq(values + i, out[i - 1]);
+	check(!out[i - 1]);
+	check_int(c.len, ==, count);
 	tree_free(root);
 }
 
-- 
2.45.2.404.g9eaef5822c

