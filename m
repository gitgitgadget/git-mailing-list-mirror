Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9442558BB
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780701; cv=none; b=JmW1tBOzlEW0gdv9hQo7h0HgczaOU4IYQ5bljHITeoi3/vIPno+SOgqzYzdsWq+XTWFIya1ljJVSoHC71Myn/NPs7cTKSZIAiKOla8NU5P+cgcF4KTwIiV6RPH9Px04uJr9Lw0C+h3j2SsJFxC32Sn5r2AHuS1Y++b9DmWMC0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780701; c=relaxed/simple;
	bh=wosj2RHFDPsXy1Q8qWoeEFWWoOhjsuXkN7V/tE4ajnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koSfQlAVungAQjnbKvknCBWa8H4lcqoF2fIxc5TrlRTbZ52kTR0oTGxbRkmBWGpLTdstFYxDK5iP6DkSVKad0SAW84GkUXpo06b7neq9JHZyV3RK81Vz8cgcqmPwbxRKyP8pQz1H6/AG+4aHBnsq6+onCKDBG0evfgpeZHNUBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0qhfZEK; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0qhfZEK"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-260f057aa9bso6183593fac.2
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722780698; x=1723385498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bihLSuYEJeRgrOWRMwTi9dCSTkdxCLdCjmW2QHlGvFs=;
        b=V0qhfZEKu8SyjJvD7ToVGgh8JQHySCfhonykq9LmDqTVS3JZIo44kMDGgAjQwSpt4N
         BoKVV5EH/gBC2vP5veDDMHetiLduDcy8kJqRLHQlAWFLed3TnaUEM+qUH5CAhs9QbZZy
         6or/pAkpqi199w0bslgarKOU4h8lqod8DQyJjunvp1VjadTTQr1XvPgYR3MPbkXwKTGS
         NcqFZHnBNRPW+QZabN/O2v/Dv1nU9qwIy+qq+uRy96q85T6ZmxpdRuS3qy1qUOsSKus1
         7+DArmH4VhfSEzsQSy+nsW8cEGc8Pw2ezxpEorrRhNilrm4QCaIHBuIgoTgNWLpQdyiQ
         n5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722780698; x=1723385498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bihLSuYEJeRgrOWRMwTi9dCSTkdxCLdCjmW2QHlGvFs=;
        b=csT9Sswcl3x0m28hbO9k0My5yBiPT4+g5Th0XJ3QKVzxOqdR8hDYc4xEN181df7PNT
         Mq38O33jsxSoIsEpw6716T3UxB2esGIqnzqEqA7Ag67K/cPX5FDukBTd8sxqGOuX79Kv
         y1DsM4/LvwQbdLZa1UdzYd7In9x42DgdC+TzEyWBc7SUVFZRjBaMaUuzS0OM2Erggzgd
         o6F3ptao0ysqncfIEZj296IJeCpF/qow3/PaNkIPNtkV5mVQ4zH5b/TqIzS1DwsdDCAt
         NDxPYBYpQtB4Z5riu6cXzJ+IbEwk4h11ByEHAO+1+pGN27pbL0K1H/9kJKTlNVZIyVIi
         BPug==
X-Gm-Message-State: AOJu0YxAOpQ6T/7hZxV9XgQ3VsqxC+UdJqccn+CpnI0MpUxBnugKJCvt
	NEnq4eD2jNGVDAhFb/U/jfSjgLunGdSEW6nquJLifs8fJMPEU+4oKOjuZLc0
X-Google-Smtp-Source: AGHT+IGoe0T4atYeoJfCdFmCRCD13lapD2mzePJ/Z/eT0DGvNVzeVOwqT3ZzscB458twkVgx5Iv2bA==
X-Received: by 2002:a05:6870:3c07:b0:260:fdda:5068 with SMTP id 586e51a60fabf-26891ab181cmr10675271fac.4.1722780698203;
        Sun, 04 Aug 2024 07:11:38 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.183])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec269d2sm4125047b3a.17.2024.08.04.07.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:11:37 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 3/5] t-reftable-tree: split test_tree() into two sub-test functions
Date: Sun,  4 Aug 2024 19:36:47 +0530
Message-ID: <20240804141105.4268-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240804141105.4268-1-chandrapratap3519@gmail.com>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
 <20240804141105.4268-1-chandrapratap3519@gmail.com>
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

While at it, use 'func' to pass function pointers and not '&func'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 8b1f9a66a0..7cc52a1925 100644
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
 
 	/*
 	 * Pseudo-randomly insert the pointers for elements between
@@ -48,13 +47,29 @@ static void t_tree(void)
 		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
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
+		tree_search(&values[i], &root, t_compare, 1);
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

