Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B368286D
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025083; cv=none; b=eQu/vy7WRi0o1E9Td9rcsUZwEyZMAbzxZjdbP9QIHD2X0736vviSTHgDAbr7vPxXCikYaKLn70yvMi/WfStoLymTF2Ofch6caDhRIW/3JMaip38gZyt+fJUXMlo07T8WoZyL1wh5qgQWLKI/cMH63Nr5SjferhrRYYCOJt7nnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025083; c=relaxed/simple;
	bh=xhZm38eTIVGbBmJjbcFwdU9ZnTINB83vGBzNZm8N60M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QINtJ4eDi7EENW1ieM85jFjacL4737lvDy2pni5BZgJWCzgG65mygpSp3qNacEbnNk26C7+2HUfD5JY8aSZvmZQKCjqSiYmEV8j9PFNirE7NwZfv3wncYfJcKiOXYRKwgVcEbItFFTMrZXe5Ze9YkfJfOwgUx7rpzWxKdFEo5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+XO1pxU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+XO1pxU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7041ed475acso1783432b3a.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025081; x=1718629881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l83l6wi8W6kYRfLZQ1wsLN3/MI123r7fe3T4ILFe3vQ=;
        b=W+XO1pxUZBAl7T5kfS+93eR+Zwe8Sekwc85bZ3aVHMErMEU3Sow50/f1Sz1aWbbuSg
         gQK06YIrplh32Vc2ttBEm6Ac4lCi9ASjzrX8BdufbFawPRdCzljkGOPc7fBwWZX+mPG/
         gzCuFXpWntsn4jBnqJUptB5S4WqHzBoo7tZFS0HamzAAzb8+BqTayIUxdeV4jpzvqdlF
         8MjuHZmlqPcpU68PdDxY4UYC19Wax9U1+DOQBUwMp+C2Daa278ar84Ziz+F6vEHNKUeu
         KFgnpsSF7qycUf2NiCd76XYlQNDW1anaoLT1orByDCpROUZ40OG+3YYhRD9NmwFc2TZk
         /ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025081; x=1718629881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l83l6wi8W6kYRfLZQ1wsLN3/MI123r7fe3T4ILFe3vQ=;
        b=umY0Etge2l2i2j/288bAydf1rDkCT2GmN6eIkzuRf1/hs4hjHdgfbUEWrNi5UVmM9v
         CVjX6pgDxJK08WAVLl2vRk5TZd1C5YWxjcNJhW/Unt4BJ9gu9UsADYBuOJbwYp/w4k2e
         FnZ85ihjqSRIpEuatmkvTundhAM75yzJ/omPUz/wpPmda86Xe9XdhYot1bjcjtiTmGeM
         CNl85Rih6FQjd3aqvyWDVbYyF6QAQsqu4nNe1B4U5uDlmmB6MOTgsggDKc10cfIzNNfp
         sQSThnGEdirfrwnh6FmWYv9ZHmseHYeJYwKWcelp82hfjqPxOWGxOlPbpbTAcyYLVsCa
         OdXA==
X-Gm-Message-State: AOJu0YxgN3V6Q0xA5aHi3Xa0PjodRhgWvPZNbKIaDEnHLskfUvZrcEvO
	hOEYeQl1c64W5ACANfs9aZBWNkRerQ6tQn0ZJtkX3ut+x4Fa7IkOiiZpl91d
X-Google-Smtp-Source: AGHT+IGJHo0wR8s2p05zMh4YBIT4tVEFwsnsDcR/WXumoTFKm3/x8AGP+RGuMseAxMl7Egj1h8ychw==
X-Received: by 2002:a05:6a00:218d:b0:705:9b04:70f with SMTP id d2e1a72fcca58-7059b04094bmr2023016b3a.30.1718025081381;
        Mon, 10 Jun 2024 06:11:21 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70599bcac14sm1378516b3a.1.2024.06.10.06.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:11:20 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] t-reftable-tree: split test_tree() into two sub-test functions
Date: Mon, 10 Jun 2024 18:31:30 +0530
Message-ID: <20240610131017.8321-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240610131017.8321-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
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

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 208e7b7874..78d5caafbe 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -26,7 +26,7 @@ static void check_increasing(void *arg, void *key)
 	c->last = key;
 }
 
-static void test_tree(void)
+static void test_tree_search(void)
 {
 	struct tree_node *root = NULL;
 	void *values[11] = { 0 };
@@ -44,13 +44,29 @@ static void test_tree(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
-	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+static void test_infix_walk(void)
+{
+	struct tree_node *root = NULL;
+	void *values[13] = { 0 };
+	struct curry c = { 0 };
+	size_t i = 1;
+
+	do {
+		tree_search(values + i, &root, &test_compare, 1);
+		i = (i * 5) % 13;
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

