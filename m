Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E363B78D
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171479; cv=none; b=Yv+L1rcVC30PohiXG9jMFyT9OLD7RJVdRDBpvTq17zKAaDG/piGn429P9Dwq+uWY//yfGan8V+mlx7i4nl9HKalNGS4jGfK3jP3Lc8aEarILfg3NzjBWjjl9obluvzO4e+8Umu4HNuNN4untI1PLd3QgxKYpLQhsxTJpuja+bAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171479; c=relaxed/simple;
	bh=YpoQo59ec7J0Yx+hXT/p9Vu/+Lghtv3YJbf7z7qoeSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUKlfq733mizaNKLP03HhI2uGYyYRktxd21CBoOnl0+nDV2/wLE7aKdxcDd6qxTsZBex++lhuKkLGrXHB8g15ahzAwMysoG9mDtkB/Pb1da0mGE9wc4mbJwgkxXCFvlWVU0UokvNSYDohbAIoXvNmcfAkBL7ydDNPxGysI4T7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNUe+U/B; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNUe+U/B"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f9c1902459so1649672a34.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718171477; x=1718776277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+xlbCO+p4/KUvao3SeC3kNZobdUc6+q4rCdR8ptb/A=;
        b=UNUe+U/BQnAloDXYNzbZUtVKDtpohRSRA+lQhqymakIKqscbgsgD9gM/vTVxbCblSS
         6G4T19qhP47cTt7FIpli4I5y+L3MrW/qMWGU0UlAcgUf6Vrw0CzQBSB2a0eBYdOBMehM
         UO+aHtIw+PtuoGWq68UyTmbOoiGqFiRYvWOsTeGWFzYIg/8zpdFV41RzeLwcwNjmWJvU
         ni8CS4T41eNrF9N1HIlOtIt43XoFLnTFVILMedxBrRD4ko30Ltv1w+/pKg1tenW7FHwF
         SkQbmyASfPEAhDBe8PjEAklnGSOspkxFFY6eHcY1cj9OzB/xgNwxeRY7pUD5AswIu8GD
         Utag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171477; x=1718776277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+xlbCO+p4/KUvao3SeC3kNZobdUc6+q4rCdR8ptb/A=;
        b=fudc/ewvgznlkbFVK2E1hamgkAYLFDMORqlRhxAXC4yotvLMdqB7eVvzlfuB5h1hQQ
         OPQJxSJxTeuXGVBTZTDqWayJH85G0gs3Ho0SSZ9jsfvJmSejURwZfPMCwooOR+fdJ41m
         S0Xe/5+vLP60x/UtK2GTLc2VWM7heabQs1XNRcmW2eNZ6MUyC0C6GvHBKMHlFW6qFzYR
         tCFnDJAage5yvvNTTj+5SWmeJaeEdB96DIBWDKGV6eQd+b9YQqNnCkWbyHNWuo3uBh2g
         YqX1enGAzovUBCDOHfQrZvGP4Ha9xpWICclAgIZgZ3EekItbaFyPaRuOamzd4bPLRo4o
         1O9Q==
X-Gm-Message-State: AOJu0Yzjo/QX0YpOAOw9TaveGY4NPBmnV+FWzLUzCYD5srO8JSe4ONPa
	7WnOxOLS+X/BAbuBym5hwOXlUwE+sxVUyO92tszEkVh+BFVvsioVG2YjQBNA
X-Google-Smtp-Source: AGHT+IHUkQC7tw+e3NNNi6RL/QfTQvdnynEHx7A4kDeZFOIwl60h9iKV9Eq6gvF8Y7/bQsPWhERXDg==
X-Received: by 2002:a9d:7592:0:b0:6f9:94f4:c670 with SMTP id 46e09a7af769-6fa1c23813dmr839335a34.28.1718171476846;
        Tue, 11 Jun 2024 22:51:16 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6f78b8336a7sm1934114a12.73.2024.06.11.22.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:51:16 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/5] t-reftable-tree: improve the test for infix_walk()
Date: Wed, 12 Jun 2024 11:08:14 +0530
Message-ID: <20240612055031.3607-6-chandrapratap3519@gmail.com>
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

In the current testing setup for infix_walk(), the following
properties of an infix traversal of a tree remain untested:
- every node of the tree must be visited
- every node must be visited exactly only
and only the property 'traversal in increasing order' is tested.
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
 t/unit-tests/t-reftable-tree.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index f1adab4458..917a64a7d1 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -15,15 +15,14 @@ static int test_compare(const void *a, const void *b)
 }
 
 struct curry {
-	void *last;
+	void **arr;
+	size_t i;
 };
 
-static void check_increasing(void *arg, void *key)
+static void store(void *arg, void *key)
 {
 	struct curry *c = arg;
-	if (c->last)
-		check_int(test_compare(c->last, key), <, 0);
-	c->last = key;
+	c->arr[c->i++] = key;
 }
 
 static void test_tree_search(void)
@@ -51,6 +50,7 @@ static void test_infix_walk(void)
 {
 	struct tree_node *root = NULL;
 	void *values[11] = { 0 };
+	void *out[20] = { 0 };
 	struct curry c = { 0 };
 	size_t i = 1;
 
@@ -59,7 +59,11 @@ static void test_infix_walk(void)
 		i = (i * 7) % 11;
 	} while (i != 1);
 
-	infix_walk(root, &check_increasing, &c);
+	c.arr = (void **) &out;
+	infix_walk(root, &store, &c);
+	for (i = 1; i < ARRAY_SIZE(values); i++)
+		check_pointer_eq(values + i, out[i - 1]);
+	check(!out[i]);
 	tree_free(root);
 }
 
-- 
2.45.2.404.g9eaef5822c

