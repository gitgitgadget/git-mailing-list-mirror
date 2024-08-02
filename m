Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F731E2894
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600882; cv=none; b=mIa6Ern2oq6GhU6R1pEA7mRXiW2mI4oeWfYAbzPS/d3rCuR5TAXr/LTm/70CjyI7fX7cPYiAbNrR/wbZM2OeZq00h/rVxdK5wFqakcW2wJf0ENNmBvI44KMLVtYMgBstQlQU4oSg1c1XXuLU5p1N0xEykgXecG8RVetWQE9iMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600882; c=relaxed/simple;
	bh=rBLKAjtFxN8DKti51KQgMEWIp/RCSEInBpSItBXHs5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCbY3JcT2VlV7MvWybqGEf5YdG8aliPZ0xfuMi94JuZ2M0jnT+L4V8GySYdJl4pllRzgB03BZvrY+hkQsOqyDfOj9xyCSVsO72d+79tq15aIG1uJAw40LH2551cIFRWPUCX0CmAlIPSa4TcoelLbheAZOc2bQ6U1M9/966nUlCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU3n0kIe; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU3n0kIe"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-250ca14422aso4829026fac.0
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722600880; x=1723205680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx034VJcb6DVhEb+/mmsRZDQbDF35hOkLKmMRWrVtJc=;
        b=PU3n0kIehuoXTA4fPFbxTar6q+6ptGfCxv5deAlQAqKc4K1jPcePOXxSSH/IZPlC7k
         uSb9ZGTJsc1ZtVY8Ee4AY4YHBd1SvmFi/D66rE8YHnV2eSicVkkQjXFKQ+DI6BqrtDcs
         PgqxxSqPs7c4Svp2kGv+ZSJxqv1LkLmDONI5OPqj2jsYLKXm6Psj6L7QKNmgnbjWEEEL
         L7K+b2bIe/IvWWFOhP3gNzd6BqYKWIbacukS5mMSEpYJVW1zPs/G3U5Z0AbKiIHhsIGh
         LwqoY5nln7NaUWbPcev/ECxsaJJTLOrisace9KH98Q4B3qtHFm9/nwPYryWn3PtM7D2f
         JGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722600880; x=1723205680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx034VJcb6DVhEb+/mmsRZDQbDF35hOkLKmMRWrVtJc=;
        b=v10/EM75TmriRPanP1ydoJJiejF3T6A1XGZAl/J9PYJ4YM4T51DR1lSOL4YCCQqQ9V
         6ZGjqZ8I1cjAkhKAQiZgka0hPVF0VQ35TsqEUk9O+1PXg3ckvRlckleZZBQ7n+YOcmzg
         6DcMaKcJuSgLfh3TsVm9imxk6r2oXciFrIJyA9noxylKgyEvLWMWJy4lt2yfaRBZEoxb
         clcA8Z1T99/X/B/UfYh/sleJOrRKgBgUFvFbPDfZxh0pb/C/eyjRBpAJ49NlmubU7Zbb
         F3p5rjJkf5Mp0TJayyA7kp1sr9MS/W8xrNMyKw8WL2ka6bZEBnWoka9W5eD2bOcHcCGs
         1e2w==
X-Gm-Message-State: AOJu0Yx+d8KDJ/BDXah+7wjFjCkSpPJUsCHGHFpsphHBokbdSup+y4kl
	5JTP21NVQj3NrOL0FE86JOrb6cAZDKu2G4LZFjyTxTKsqjrfq0YeL+Nd7A==
X-Google-Smtp-Source: AGHT+IEWV4ripFTxnBxNCXiSLtSNpeoy2HPP4Ec7bFMQibWCSb9+BQCcrYmldZiWrlAI0B8HBzl++A==
X-Received: by 2002:a05:6871:14b:b0:25e:e6d:5247 with SMTP id 586e51a60fabf-26891b1ceb8mr4071392fac.14.1722600879978;
        Fri, 02 Aug 2024 05:14:39 -0700 (PDT)
Received: from Ubuntu.. ([106.213.168.25])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec16034sm1294534b3a.15.2024.08.02.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:14:39 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 5/5] t-reftable-tree: improve the test for infix_walk()
Date: Fri,  2 Aug 2024 17:38:08 +0530
Message-ID: <20240802121318.4583-6-chandrapratap3519@gmail.com>
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
index 0f00a31819..2fc6a34008 100644
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

