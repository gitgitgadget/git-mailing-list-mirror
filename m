Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD654F95
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116652; cv=none; b=XFua/3fxUz0/dmCCLM3PGTqM3giZ9NhF0xQdPYqmqbR3FLKzPbRPk8I51Iutc+6vHUOJ7vhKFps355zasR9aVQPA5E8FTkOEB93KrDmNz+DMJDIIailM2/xePu/hegPMhZa0hiqv9upi/pVmi8COwD2ZdZHAAs8WPh64a3YM9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116652; c=relaxed/simple;
	bh=h7C+6Tg/8jGCk+MJ1aIpJ2izP4e7CjTF8BaZgmbRnlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnFcEscM0nty2xlo00c7YO3qmCiWXEPXF/tzMl3TtIbSLFqMJJoLb1E4nkO2kBcH97/iHodOLEr7eU1JW2lhSmiIeuCMb/HloA58+bVKxrCami1oZK0ITxgPAr2mlGp0IL7hIN2yGxw36+BC/Gkdsbb9Mdscu+QqdEjyIv3q5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gswQIvaL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gswQIvaL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fbd1c26f65so28161495ad.2
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116650; x=1721721450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeREhiUlGPJyZ2z7ugsEkUx99dFa0IjdnGqusOzdaxk=;
        b=gswQIvaLI/zxUHpemBYtpAYbhwpaevi60c8KIV22kGPc2NpR2qgog0jlKGsg8kmQzh
         Pu2SyKryp8AiKrjKPDPBXOvfgLU2Q22BRPXgJfO5ErUakq+hxheeZhelVN3UAV7Qwiv4
         VxgL9oJ2jpH1JpgQrkZ/KKJq313LZXAS3WWN8P9vXebmfD4O0onLDFOcCSKuPbjWXHmB
         1v/Q8v9E6z5ahqFXE6UHftHHXf0vOfeDVc85ifmWtlZcx4TfwFQKIimDSYe1kWzX05Zs
         05g8IlM7t5lrtdRVEnHqAG5Xm9mQF+elnitKABiZFC96AKGeheLJKxHpkSi8jOvsq7SL
         TzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116650; x=1721721450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeREhiUlGPJyZ2z7ugsEkUx99dFa0IjdnGqusOzdaxk=;
        b=U6O/R9RU6QpKdGk+nJw8fmahvGxi+yy3YcInwmsKk2vExQmrI5aTtFF1UbvbY775xg
         eXrgsrr1+vbjLO/0Zn9iXGilKhCqy0sslvvBAaT8YfTYKBnFWJx4018Rc+8QqoWc8Pej
         RjDnx2dl+m8l5SajF6nnE6l5fTPiYzTrSC8WyK0CYb9A07nO6Veu+EPLKWxbqAtS7yav
         do9Bfg4bDOuBGSpt2szIndYF1wjNwqBlAoQi+Ezc5icjOceGBjM24L82t5Urpe5C6ydm
         uFEKS+/NoedtBr5luNWzC1cV4SiNgwR0no8ovs18DIbUyIoJaewr9q6WejI1peoQInpn
         iZAQ==
X-Gm-Message-State: AOJu0Yww7VKaYEaTg6kKkg7MiTWg3RYT7T0xnc2paOgsDuyo/cf3/U1t
	EYLyLFyefupQYANl86zN5hZ04fxBWClprGuoCSu6PJOjDxXcV/8++593BCsh
X-Google-Smtp-Source: AGHT+IGuivwtfSmmrgqO7qo9Xf1D74yvCiVmST4Naspn5A77cKXnab3GMf3cqHyYhqktX5kEjc+RQg==
X-Received: by 2002:a17:903:1248:b0:1fb:83c5:cf8a with SMTP id d9443c01a7336-1fc3caba2dfmr13898255ad.8.1721116649856;
        Tue, 16 Jul 2024 00:57:29 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc3a599sm53691435ad.232.2024.07.16.00.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:57:29 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 3/5] t-reftable-tree: split test_tree() into two sub-test functions
Date: Tue, 16 Jul 2024 13:18:15 +0530
Message-ID: <20240716075641.4264-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240716075641.4264-1-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com>
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
index 5df814d983..68b1b31176 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -26,13 +26,12 @@ static void check_increasing(void *arg, void *key)
 	c->last = key;
 }
 
-static void t_tree(void)
+static void t_tree_search(void)
 {
 	struct tree_node *root = NULL;
 	void *values[11] = { 0 };
 	struct tree_node *nodes[11] = { 0 };
 	size_t i = 1;
-	struct curry c = { 0 };
 
 	do {
 		nodes[i] = tree_search(values + i, &root, &t_compare, 1);
@@ -44,13 +43,29 @@ static void t_tree(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
 	}
 
-	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+static void t_infix_walk(void)
+{
+	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct curry c = { 0 };
+	size_t i = 1;
+
+	do {
+		tree_search(values + i, &root, &t_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	infix_walk(root, &check_increasing, &c);
 	tree_free(root);
 }
 
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(t_tree(), "tree_search and infix_walk work");
+	TEST(t_tree_search(), "tree_search works");
+	TEST(t_infix_walk(), "infix_walk works");
 
 	return test_done();
 }
-- 
2.45.GIT

