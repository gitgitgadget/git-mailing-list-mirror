Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762891805A
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629188; cv=none; b=rb5FUkRrAQrVxaMSNcDtbEfbxuKl72spch6tlo5mXFkz06t3rf4urP32caU5iEefM9rPJ8f8ghlkUGGipdiy9GHc9Kdnf9f9BHdY6mg3GqiYZ/AMgVokg9IRXW9ITYX9+N4IUQAjLZ5z8JzMlHS0ewUqCbjwU+02XOjttyiXXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629188; c=relaxed/simple;
	bh=fStEPHID7xWFZ60pLbk+mQYRMmUDALwefONhmqcufPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQusJnmoYG4LVS1FXIs/idVhuToX01URzfv/eT0OZzoNhphklrOoDPqL6of1ZzPQ118wH4EEIN36e5/uPyQx4Bsttc8JlqLJHbp7uOe1LmiDj4bo7MzEWsa2wF43lxx3bc3r8y5ujNVfGmz6x62dyHEi/qAU3hKipHi04UPPQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYEjkZZw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYEjkZZw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd78c165eeso13428495ad.2
        for <git@vger.kernel.org>; Sun, 21 Jul 2024 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721629186; x=1722233986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTl0pqmzGK8MaW59+NZjF70fraW3oqa4jEe3gPNb+4k=;
        b=fYEjkZZwk/Y5QSRjvcV+fbsp5mxpoFOV7BPqPlzqQfrGIHr65GY1DJq2OOwnVPc3DY
         +P+JFPTvS+/8Ah5LVH9eA4lV/Dit9uiNeY9LpkBQk8Z3EzKgu3h/iKc+6O9DBImIzbUB
         sCzzIZBT1nxy1zMN01VV99BB7kDxcNeviZyHzViMGUU5QSap2dKNXDouwg2Rs5berDFO
         ifoDkD2Fams8n6Y5prJGT0/2enc3uCiPVv6U3SECao17jbnY9JcMWxZzj1SbHHSwRu1N
         a2Mo/iwBLBTrFrTYucn2xpwL8Jm5Q1riQW/mK9YhFY8kDqGLyREzfwBMkxsZtWn7Lsuy
         /z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629186; x=1722233986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTl0pqmzGK8MaW59+NZjF70fraW3oqa4jEe3gPNb+4k=;
        b=O7X29vgOu5QsVFcBJB8p2HqrTEZD6Pkw5BCr8LN//ZTyQqD6vdvlut1VOOijRYfAd5
         V/eeW306cb/UrHfkT5Rs96c1sWU3sicvT8r+SvUPL+1IxLvaG5Azt+lyDt4XGnAZjcwk
         oyu6OeWtCBlg+cIyUgvVIQQxbQtwxJEnqVoGPgvHzjz8NAkoNuyWgUILp1D+PfnRRK5d
         fOp4GGfffZI1E3msEv8+L44fvnRGwhHt5iRVt/VOWMj69CRpK/2drSKYEWzYHSA0QkaD
         Acb9DBSA/10k6+1pfi6RkwpX+e8oKKObJsI4ridR6VYynvCg9Dk41yvgIDZM124wP/wG
         5lIQ==
X-Gm-Message-State: AOJu0YyxEosshtJucnc2Wsq4XA5ppcdHxi3gZrqsi+wGDXk4hm8neDn3
	eIbP4upgkNnpZ7oElYjeSWJ9LVqgUo0fq5aSWBX+oIs4xhULVZXI2xuHbIU0Tm8=
X-Google-Smtp-Source: AGHT+IHI4tNTDqFJEka2Zs4mGMnOJKVnVL1DA34S8o/dxnTcLw8k8i8W7PMfDmEC2tCGRKiQt6nP2g==
X-Received: by 2002:a17:902:f68d:b0:1fc:2ee3:d46f with SMTP id d9443c01a7336-1fd7451535amr51801435ad.11.1721629186298;
        Sun, 21 Jul 2024 23:19:46 -0700 (PDT)
Received: from Ubuntu.. ([106.220.63.154])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f31a73csm46362885ad.143.2024.07.21.23.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:19:45 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v5 3/5] t-reftable-tree: split test_tree() into two sub-test functions
Date: Mon, 22 Jul 2024 11:27:56 +0530
Message-ID: <20240722061836.4176-4-chandrapratap3519@gmail.com>
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
index 08f1873ad3..07c6c6dce5 100644
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
 
 	/* pseudo-randomly insert the pointers for elements between
 	 * values[1] and values[10] (included) in the tree.
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

