Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191311D54B
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197367; cv=none; b=fowch3Z4OC/EMTr1G2B0ZPnrAJOSFIa5hqo/ilRPzh5cE7/ujJIYRakQ7LOjk00IG7p7YCog1neeXCo6Kpidnt2MIfNw6moZcwXUOg6VJIP0f42zZ9V/Oje3JmHxpZi+f8YmqzYFqDpPwR2UazwOQLe2ku4DTgXv5QxE7MpLY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197367; c=relaxed/simple;
	bh=eVQGg8EHajoE+Eu8hn9F7IiRWjreUuqiIeYxYMfyI/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opqZKHwMhjpw+l5G+7fR0OYMAATPtDXIJ3bljz1L2hM+zQPl+6JZ3otC2i6cY9RJs9kVzo8FFc6x3UI4hMsopFML4Dcs/LeRN2wENP4JGsj6E3IPcDczaVNLdzt50EPHoaDC5NvMHl70+99aO7aDVjuEM3Zk9usdElUdQlv7Zc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJNRiaSH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJNRiaSH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6fada63a6so31821145ad.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197365; x=1718802165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmSAHVsaAEh2faGN2xQ43aOdmVmxyRmZXfxxtDxYkZE=;
        b=lJNRiaSHqbCUW0IFFjVQ5KHvDdtIxXeWDK7TELcb53F1G2CXW/sDeC7hqNrZTX5yUR
         SZmi/SGKc5mrYGG9/w+Lmj278BLyL2UYr1+kpE1PWffZtuQj+Y1kecc9MzUhkfoyqAgp
         0ri5PxuGOMjF9f4pwhyW+qae9Tcd/2zi/w8fbkO8krQHIAMeEm/w0PdTGnB3JO8rfESR
         Fo5dbeAiHpx+7Y/fVGv+cdlJaOOunclGH+o/YQffg847zQzvy54ghca3dedOfNoj71qm
         OR+xe+V24RjdwUUENWp9QtkfSD7gqwmFYbfqIiVBPOxpaH0IunXp0cDJ8VTeFX7oUL4D
         6f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197365; x=1718802165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmSAHVsaAEh2faGN2xQ43aOdmVmxyRmZXfxxtDxYkZE=;
        b=LIb4MMayy1hfo7IvbXKDHc8ooDXNGwfSZiWUsowZoQEn/MvCfRB8Jcc1yCj7HLNfn8
         QnYv0rvS7U6fNIh3ZyLP57j6ZB7Sz+zjaPj2QmUOKam/JMQ8m9VzQZWBuEnCoelh89Ae
         pyCy3zUjMnXP1sN59eXoW50sjD3BOzFmif34DfG5Au3BdkQlSqenBFemmxVcr0fjsoHX
         ECgYBIT2q5eLRiX9+i5BGRwClsuwad5i7e9K/c0nxs1TpFUlBcFgHRNaJlnJb9aeZM96
         O/6vktN7SGKzZ4pSl2bLxTNcoI9/NAvRwJWww2vTApnlPHHPVeDrQm0EZr4UVnaFwUks
         YMTg==
X-Gm-Message-State: AOJu0Yw+YYTn919WiJtDDuNo9dl2W4lSkWAzBQ7H9XJ7rZdrWxxVWA8J
	MeYEGEVmwVNoZhsCr3RQEUDlo6jwCnEu3jO4goUV1iWEPpS4lkcSS8PCRf2wzn8=
X-Google-Smtp-Source: AGHT+IFZ2evIi8E4akIVJ1pr0LWtW2MYWPhbd4Lfm1c/zGYB/apLvVpO8X5zQp+gyh0742nZQCr/5A==
X-Received: by 2002:a17:902:ed15:b0:1f8:393e:8b88 with SMTP id d9443c01a7336-1f83b74fb9fmr19451525ad.67.1718197364574;
        Wed, 12 Jun 2024 06:02:44 -0700 (PDT)
Received: from Ubuntu.. ([106.206.196.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7fd25fsm123942325ad.280.2024.06.12.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:02:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v3 0/5] t: port reftable/tree_test.c to the unit testing framework
Date: Wed, 12 Jun 2024 18:22:58 +0530
Message-ID: <20240612130217.8877-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612055031.3607-1-chandrapratap3519@gmail.com>
References: <20240612055031.3607-1-chandrapratap3519@gmail.com>
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
Changes in v3:
- Fix a typo in the commit message of the fifth patch
- Add a check for number of input & output elements in the fifth patch
- Small refactor changes

CI/PR: https://github.com/gitgitgadget/git/pull/1740

Chandra Pratap(5):
reftable: remove unnecessary curly braces in
t: move reftable/tree_test.c to the unit testing
t-reftable-tree: split test_tree() into two sub-test
t-reftable-tree: add test for non-existent key
t-reftable-tree: improve the test for infix_walk()

Makefile                       |  2 +-
reftable/tree.c                | 15 +++--------
reftable/tree_test.c           | 60 -------------------------------
t/helper/test-reftable.c       |  1 -
t/unit-tests/t-reftable-tree.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
5 files changed, 86 insertions(+), 72 deletions(-)

Range-diff against v2:
1:  3010c8f01a ! 1:  44800ad205 t-reftable-tree: improve the test for infix_walk()
    @@ Commit message
         In the current testing setup for infix_walk(), the following
         properties of an infix traversal of a tree remain untested:
         - every node of the tree must be visited
    -    - every node must be visited exactly only
    -    and only the property 'traversal in increasing order' is tested.
    +    - every node must be visited exactly once
    +    In fact, only the property 'traversal in increasing order' is tested.
         Modify test_infix_walk() to check for all the properties above.

         This can be achieved by storing the nodes' keys linearly, in a nullified
    @@ t/unit-tests/t-reftable-tree.c: static int test_compare(const void *a, const voi
      struct curry {
     -	void *last;
     +	void **arr;
    -+	size_t i;
    ++	size_t len;
      };

     -static void check_increasing(void *arg, void *key)
    @@ t/unit-tests/t-reftable-tree.c: static int test_compare(const void *a, const voi
     -	if (c->last)
     -		check_int(test_compare(c->last, key), <, 0);
     -	c->last = key;
    -+	c->arr[c->i++] = key;
    ++	c->arr[c->len++] = key;
      }

      static void test_tree_search(void)
    @@ t/unit-tests/t-reftable-tree.c: static void test_infix_walk(void)
      {
      	struct tree_node *root = NULL;
      	void *values[11] = { 0 };
    -+	void *out[20] = { 0 };
    - 	struct curry c = { 0 };
    +-	struct curry c = { 0 };
    ++	void *out[11] = { 0 };
    ++	struct curry c = {
    ++		.arr = (void **) &out,
    ++	};
      	size_t i = 1;
    ++	size_t count = 0;

    -@@ t/unit-tests/t-reftable-tree.c: static void test_infix_walk(void)
    + 	do {
    + 		tree_search(values + i, &root, &test_compare, 1);
      		i = (i * 7) % 11;
    ++		count++;
      	} while (i != 1);

     -	infix_walk(root, &check_increasing, &c);
    -+	c.arr = (void **) &out;
     +	infix_walk(root, &store, &c);
     +	for (i = 1; i < ARRAY_SIZE(values); i++)
     +		check_pointer_eq(values + i, out[i - 1]);
    -+	check(!out[i]);
    ++	check(!out[i - 1]);
    ++	check_int(c.len, ==, count);
      	tree_free(root);
      }

