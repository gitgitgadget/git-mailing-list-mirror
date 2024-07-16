Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3B249F5
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116645; cv=none; b=NFtQg/v0hRGaiwcfI1e7TykgzLPNrF73CwjRL42BWJLQhBwQR86qk7G2ubS80L3MPb3KgTr8ncxK7+sjB0ts9jaQ4TLvkjmG4nZm6rngALu0t13ycHOMybbYcXhOplRJ46hrlHuLUiVwk1AAHcoE7aP7NKbrrFqooQy/Fkxfsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116645; c=relaxed/simple;
	bh=FTpHkVI5dp0jdm9XblS8KlQJ38179+8AwHyjFmeCucA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOs1mEtF2G0KS4rA159ivJngpV8YIXkkTHRv1VLSwdkkPcBR1wQy7cvxYDU+HH+oWa54Ibbt45vCMOyFvdy6qd7mZnwzrGxb+iOIK8nw1Yz8lVgFOqw1bgisxMIT+yLXcgngPb2UTxzN1uhz1kuX35c9XWfXLfkNnU0QqAXz3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epF5SX7F; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epF5SX7F"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-75a6c290528so3230116a12.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116642; x=1721721442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TzV9pntqmHcjKi5EVYg/smdSZ5dPkh9zBdaZKGAKp0=;
        b=epF5SX7FVENjiZyFahICVOP7MHTxpdw6MEav5pw2lqPQI3tRLTW+7MTRCnmZtyTBz/
         X1jmFLw4pSCSNY/DtFDM/fWfBp6JScvkO1j3w1ZEVuHRXvP+vgiJ4kv7VuLFNb6AQWEg
         MPAaUI98Tn8j+s/LI0TYFX+pdTflM6JDIZbqZSodzQRv1DBjDg9G7jKYroo5aZJK65TV
         7BS5bX5XQZB7NHxlBj84G18bnC1aUFRJWaKzdx2xHaqhS8YFzHue/uY8enBIbhE0c+8p
         5R3L9ozZz1wL105X+AZWsWDr80KoOKDcE5BRfeekXAlxVzJIHZIBax12Ok55Kho4ra1l
         zRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116642; x=1721721442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TzV9pntqmHcjKi5EVYg/smdSZ5dPkh9zBdaZKGAKp0=;
        b=vgo0xoGj/+d2EtXvLFA/VrUwZwuOL+yKA/GO/mRqZWAP7wZfHZYt81BlqkeHjcpNeF
         p0CMrvyFv0gomVWKN4fHxPh8BXwKUfkkGbaMkSU0Ql8baelaEgAK6jIydc3xRpkVxBYX
         Pwh2h9SdSZQc4xpYVVIKj+i7I7ShieZCKRz60o7ARdNhLxbXfpm1aVmzNZ34HQ1w898f
         oSBjl+vr8eOjR+BifZRs4K6TBtckCko+9ZYMHVSmWNqc/iooFsKhiYdg3vdAE46yYgiQ
         ByINKdHHw84MxMfIzNwZSPEc3J55pZORAsmjpVdgLb73lxtG4hOOd0pCZjActWA+ZoBA
         GGjA==
X-Gm-Message-State: AOJu0YyvHjIPo1DfsIi03xgRoRi3YkiSU55gkqAl2KDqGwG6tIbfgE9Y
	iwAzaFwj/g6VgkqBDzb4qLoE0SunTjdR2TtKTo+PBmFkq0VqOmpaoWZJKNDR
X-Google-Smtp-Source: AGHT+IGOC+gjlNzA8F2+OOmGuGOxdLSysi58j5HxKj0fXDJzDzTm66ARP+n9bx5ytB8oNFGkALQ2jg==
X-Received: by 2002:a05:6a20:2448:b0:1c3:b1b8:e01c with SMTP id adf61e73a8af0-1c3f12b48f6mr1551844637.49.1721116641970;
        Tue, 16 Jul 2024 00:57:21 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc3a599sm53691435ad.232.2024.07.16.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:57:21 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [GSoC][PATCH v4 0/5] t: port reftable/tree_test.c to the unit testing framework
Date: Tue, 16 Jul 2024 13:18:12 +0530
Message-ID: <20240716075641.4264-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240612130217.8877-1-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/tree_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series is preparatory cleanup, the second patch
moves the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v4:
- Rename the tests to be in-line with unit-tests' standards

CI/PR: https://github.com/gitgitgadget/git/pull/1740

Chandra Pratap(5):
reftable: remove unnecessary curly braces in reftable/tree.c
t: move reftable/tree_test.c to the unit testing framework
t-reftable-tree: split test_tree() into two sub-test
t-reftable-tree: add test for non-existent key
t-reftable-tree: improve the test for infix_walk()

Makefile                       |  2 +-
reftable/reftable-tests.h      |  1 -
reftable/tree.c                | 15 +++-------
reftable/tree_test.c           | 60 ----------------------
t/helper/test-reftable.c       |  1 -
t/unit-tests/t-reftable-tree.c | 80 +++++++++++++++++++++++++++++++++++++
6 files changed, 86 insertions(+), 73 deletions(-)

Range-diff against v3:
1:  ffabd3e411 = 1:  2be2a35b7f reftable: remove unnecessary curly braces in reftable/tree.c
2:  17937233fb < -:  ---------- t: move reftable/tree_test.c to the unit testing framework
-:  ---------- > 2:  de49698ea7 t: move reftable/tree_test.c to the unit testing framework
3:  c3992091db ! 3:  c733776054 t-reftable-tree: split test_tree() into two sub-test functions
    @@ t/unit-tests/t-reftable-tree.c: static void check_increasing(void *arg, void *ke
      	c->last = key;
      }
      
    --static void test_tree(void)
    -+static void test_tree_search(void)
    +-static void t_tree(void)
    ++static void t_tree_search(void)
      {
      	struct tree_node *root = NULL;
      	void *values[11] = { 0 };
    @@ t/unit-tests/t-reftable-tree.c: static void check_increasing(void *arg, void *ke
     -	struct curry c = { 0 };
      
      	do {
    - 		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
    -@@ t/unit-tests/t-reftable-tree.c: static void test_tree(void)
    - 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
    + 		nodes[i] = tree_search(values + i, &root, &t_compare, 1);
    +@@ t/unit-tests/t-reftable-tree.c: static void t_tree(void)
    + 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
      	}
      
     -	infix_walk(root, check_increasing, &c);
     +	tree_free(root);
     +}
     +
    -+static void test_infix_walk(void)
    ++static void t_infix_walk(void)
     +{
     +	struct tree_node *root = NULL;
     +	void *values[11] = { 0 };
    @@ t/unit-tests/t-reftable-tree.c: static void test_tree(void)
     +	size_t i = 1;
     +
     +	do {
    -+		tree_search(values + i, &root, &test_compare, 1);
    ++		tree_search(values + i, &root, &t_compare, 1);
     +		i = (i * 7) % 11;
     +	} while (i != 1);
     +
    @@ t/unit-tests/t-reftable-tree.c: static void test_tree(void)
      
      int cmd_main(int argc, const char *argv[])
      {
    --	TEST(test_tree(), "tree_search and infix_walk work");
    -+	TEST(test_tree_search(), "tree_search works");
    -+	TEST(test_infix_walk(), "infix_walk works");
    +-	TEST(t_tree(), "tree_search and infix_walk work");
    ++	TEST(t_tree_search(), "tree_search works");
    ++	TEST(t_infix_walk(), "infix_walk works");
      
      	return test_done();
      }
4:  99a0ed484e ! 4:  f1a9325bb3 t-reftable-tree: add test for non-existent key
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
     
      ## t/unit-tests/t-reftable-tree.c ##
    -@@ t/unit-tests/t-reftable-tree.c: static void test_tree_search(void)
    - 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
    +@@ t/unit-tests/t-reftable-tree.c: static void t_tree_search(void)
    + 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
      	}
      
     +	check(!tree_search(values, &root, &test_compare, 0));
5:  4fce9a8bd8 ! 5:  c6b7a3d646 t-reftable-tree: improve the test for infix_walk()
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
     
      ## t/unit-tests/t-reftable-tree.c ##
    -@@ t/unit-tests/t-reftable-tree.c: static int test_compare(const void *a, const void *b)
    +@@ t/unit-tests/t-reftable-tree.c: static int t_compare(const void *a, const void *b)
      }
      
      struct curry {
    @@ t/unit-tests/t-reftable-tree.c: static int test_compare(const void *a, const voi
      {
      	struct curry *c = arg;
     -	if (c->last)
    --		check_int(test_compare(c->last, key), <, 0);
    +-		check_int(t_compare(c->last, key), <, 0);
     -	c->last = key;
     +	c->arr[c->len++] = key;
      }
      
    - static void test_tree_search(void)
    -@@ t/unit-tests/t-reftable-tree.c: static void test_infix_walk(void)
    + static void t_tree_search(void)
    +@@ t/unit-tests/t-reftable-tree.c: static void t_infix_walk(void)
      {
      	struct tree_node *root = NULL;
      	void *values[11] = { 0 };
    @@ t/unit-tests/t-reftable-tree.c: static void test_infix_walk(void)
     +	size_t count = 0;
      
      	do {
    - 		tree_search(values + i, &root, &test_compare, 1);
    + 		tree_search(values + i, &root, &t_compare, 1);
      		i = (i * 7) % 11;
     +		count++;
      	} while (i != 1);
