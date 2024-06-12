Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428017A938
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197375; cv=none; b=thNi4YWM5atIYLHWYpUMllOYcaWknpGmG1IxLmJgvzPeSf57ODCHnUNZJZ4wJj7Gq6CZOXNlbEaVU3CamYFiG2PJ5Vfgm8f5jeQ/IWDf5EL+cSfgWaJqKXt8vg34hLgKJlUmjovA1ERHQ7M8b/QDGtoBsZCXCQjdDabgFLG/R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197375; c=relaxed/simple;
	bh=Q7pMSyQP80ggGaKhyXA8swmOExRd8oyrTSo+6kokmpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eijjrGOaLI9Pop0UxKtsVT7au57UoR5NYYOk1bvZZZ6Y/3iNj9rYDzZ4Ke+kwXL1sjsYyatThl7u3C/k0tZb3hyo6N6StJj+5mVAMSOudH8kXA3K02T36VSMeT2qa3uWkvV8CdM0QOibrvM9OJgXQ49NoDRvIUEAWJLUmLbuFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3Jgfy7L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Jgfy7L"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so30037095ad.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197373; x=1718802173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r9XrWy8GhQ830TW4yLffFrj4/ysvD19t0QFptNnVMM=;
        b=A3Jgfy7LQKH4Jgx6dB+t1iadpZX2PoYhvqp6kzHd+8oCwfUUn/5mFOrcULXH8SfV5b
         E0MWOnEYQAE8bv2ANZLnL+wGg4+6lxj6RxZydHnP7BXmXqZ9Q4Ne6AGQKuNEGQjMzjgy
         3sUlQpvui6+bVNIsnDLiZcAzEfktsJtIGV6lQUInsTGymTz3NgAM8qi3lEt9Tt49igNE
         JIvg1WGQ81ujzKkv4E9kw+UM2SEvjHiwgHgBcjqln5YyTDIBYTRmLJORdP1pxg+k9Rek
         6dXMMWRcg5olHUJ8KSKO5jvib6G+qDpPKXIkQSvCpCDkqXDPONIMbqoT+yKloWV5RHx+
         Alww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197373; x=1718802173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r9XrWy8GhQ830TW4yLffFrj4/ysvD19t0QFptNnVMM=;
        b=DtH4K1BLuZ8Ugi2/EJFBCaiaQIzQwLOx10sdgGYU8G8at2GuY3jgEARGfaCnyJvLzs
         6ZkAvwirQJMunwM+NxkCkUYqQFt0ealytFv0OCrBgrmkreVzil2KkVYefuaR39O0NpVC
         vcChDSrm2uhH/RQz683pncpsOCCCtfWJ8i4xwMSxCLHbX5GyzlM2G9Re8zaSuvJz2sag
         8kOiLovx+9sHcQNcAGBuUokPWgkWw45GbEbCnpqUZPD6zqJbXE5zVOpV+LpSHRsQgsJH
         1qv7Py0ArJO1HnyW+32rNAov+rx8RmAOSWfp7VUwIfQhpXrQXKWneFZIwObMP7eqmRGg
         jGeg==
X-Gm-Message-State: AOJu0Yy4U4K0MiMZVYSQSH13eEsE/+f95tul3SqgvfjCgl3QQBd1RW4m
	eeWJH3OGFI02Zcs+uAiJOn2+89zbtD33SVE3EdZPSrfTaoP8GNe+JCww3LWoBmw=
X-Google-Smtp-Source: AGHT+IE215AAzYWca3Pn0CWLNhix2AZ5VNmS6KT0ng0/QZEkEuVZtG4D+nPCbWwTsCNeRojtGxeLuw==
X-Received: by 2002:a17:902:e844:b0:1f6:f9aa:e186 with SMTP id d9443c01a7336-1f83b716bafmr19777615ad.57.1718197373189;
        Wed, 12 Jun 2024 06:02:53 -0700 (PDT)
Received: from Ubuntu.. ([106.206.196.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7fd25fsm123942325ad.280.2024.06.12.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:02:52 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/5] t-reftable-tree: split test_tree() into two sub-test functions
Date: Wed, 12 Jun 2024 18:23:01 +0530
Message-ID: <20240612130217.8877-4-chandrapratap3519@gmail.com>
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

In the current testing setup, tests for both tree_search() and
infix_walk() defined by reftable/tree.{c, h} are performed by
a single test function, test_tree(). Split tree_test() into
test_tree_search() and test_infix_walk() responsible for
independently testing tree_search() and infix_walk() respectively.
This improves the overall readability of the test file as well as
simplifies debugging.

Note that the last parameter in the tree_search() functiom is
'int insert' which when set, inserts the key if it is not found
in the tree. Otherwise, the function returns NULL for such cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 208e7b7874..cb721b377a 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -26,13 +26,12 @@ static void check_increasing(void *arg, void *key)
 	c->last = key;
 }
 
-static void test_tree(void)
+static void test_tree_search(void)
 {
 	struct tree_node *root = NULL;
 	void *values[11] = { 0 };
 	struct tree_node *nodes[11] = { 0 };
 	size_t i = 1;
-	struct curry c = { 0 };
 
 	do {
 		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
@@ -44,13 +43,29 @@ static void test_tree(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
-	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+static void test_infix_walk(void)
+{
+	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct curry c = { 0 };
+	size_t i = 1;
+
+	do {
+		tree_search(values + i, &root, &test_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	infix_walk(root, &check_increasing, &c);
 	tree_free(root);
 }
 
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(test_tree(), "tree_search and infix_walk work");
+	TEST(test_tree_search(), "tree_search works");
+	TEST(test_infix_walk(), "infix_walk works");
 
 	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

