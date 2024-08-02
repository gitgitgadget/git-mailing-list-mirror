Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A581E3CAE
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600876; cv=none; b=uWLrQCip3V1vBWYy8EijXJgf9QyQRjxuM2TaP2RGM5MEGklqw3nh3nzqDX+6JvrOnGyZ4CHQaSvN1Buke+5ekRNWycA1cG/9S7Bz84h5qneQUQEoqejqh87lQbkb7h6MBNOai68OAZWuq39DXBJeuxS65jYmpZfOHGnoCZctVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600876; c=relaxed/simple;
	bh=buQm7Sc9GzCvvG7QsgAQgd1LOKkOrctLPFh6uzuuO8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huEFUfTgQss4osDGSq9gLMtwTT+ZKdUMbx+f5KVoA+aV3KPl5D4bwXKAHnLwqfEUUlCzd8go7gyKmW9uIs38UctGcKf8wYT114sZo4NHkh2mo4i3enfS7mlIdZwBOM6A809sOfjaBp8uNdS8ERt1S+yfV2fXVlwChY2Oq1rjZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL0aAt3A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL0aAt3A"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7104f939aaaso2527605b3a.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722600874; x=1723205674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/UxxA4EGpStxMUWOVlz1KPcsKx8pXFlEu4F7KDbbIw=;
        b=WL0aAt3ACk10pgOmyJonE0DOH0MHTDhwBvpCXtTY7PK5pkK4Z6rGTWjTkEgAiaSzjN
         3cPtYpVvWrhGFjUKIstUBmo2zBu6njNRx35FMIl/itynxKB8w1SWUTwu+qQ0cemXEWhN
         QICqZ8eiNBVyrQH1hps2l/rRVVM9vHb4fOiGF9TwGL16RbHb9yYUkvDSxzYA6Bk3sidG
         rJCWiW9BE6K6zdVsHZmfILsNbUrvbkmhkGP3y90JyRk2pPVcAWHbnhhd0FgLzcZTO1te
         AJ7xdsZiB2tpFMB4IgZvAEsDW/kym7uykwvUkJqHo/8WHlQBsEv+XpWHqV99by5cnIMN
         rKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722600874; x=1723205674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/UxxA4EGpStxMUWOVlz1KPcsKx8pXFlEu4F7KDbbIw=;
        b=F+cFKzYCkLy4gCqyzYjFhA/LLHAJLMqHW6BZY6zXqbLUdWsN6WL0ARUPPs/nWYWbQI
         ka+pX0ocIcOX9LmC9kKOWRW/17n7B7YxLmJh8tVOVpzEpXH4zq7oDaSI5ad+q7nkW5sL
         WyLwmFs/ODRGZ0+2cC4a8Tmytg/3+tU8+/+Fm8a8YuGbsrLM+kCV1ZJkvFuyJ4y70tQo
         nzZlVSsSqwRiaMrVN67W8S8DK24tjfUys2+Ogc//Wip79YmZxvScYpaZ/Fpg/IGLY42J
         SPT96vYPDd1LaHlf78g1z9ea3CsraHyDVz+cDW85fmrpyfkoAs/OhvQ0sMBSrwdeeJL/
         2GFw==
X-Gm-Message-State: AOJu0YxwlvUbD1wpEb4xGFcE7xkC2eAbvR8EozkN0WtUldJeMAyrZYSK
	3Q65Gryz8EiTge1cA6Ll9myegMyPo6vorQM6bloDxaDfnpKqN5VgSEsbcQ==
X-Google-Smtp-Source: AGHT+IG0bHJlgrfTIoO6XAZ7KY7eSMQbCB8jBN6WfzzHqifVOXJSggDB8EEArqAxbWhhF/LavrjmNQ==
X-Received: by 2002:a05:6a00:1891:b0:70e:98e2:fe3c with SMTP id d2e1a72fcca58-7106cf95394mr4884613b3a.2.1722600874105;
        Fri, 02 Aug 2024 05:14:34 -0700 (PDT)
Received: from Ubuntu.. ([106.213.168.25])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec16034sm1294534b3a.15.2024.08.02.05.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:14:33 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 3/5] t-reftable-tree: split test_tree() into two sub-test functions
Date: Fri,  2 Aug 2024 17:38:06 +0530
Message-ID: <20240802121318.4583-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240802121318.4583-1-chandrapratap3519@gmail.com>
References: <20240722061836.4176-1-chandrapratap3519@gmail.com>
 <20240802121318.4583-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-tree.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 08f1873ad3..5efe34835e 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -26,16 +26,15 @@ static void check_increasing(void *arg, void *key)
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
 
-	/* pseudo-randomly insert the pointers for elements between
-	 * values[1] and values[10] (included) in the tree.
+	/* Pseudo-randomly insert the pointers for elements between
+	 * values[1] and values[10] (inclusive) in the tree.
 	 */
 	do {
 		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
@@ -47,13 +46,29 @@ static void t_tree(void)
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

