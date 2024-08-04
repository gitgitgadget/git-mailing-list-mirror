Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED7364A4
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780691; cv=none; b=oWI20W405qvu9KuXLRYc+9DuSnJSZH6Aiu+SKy7Q0j6sAE6sc0My1c4kODEayUIhpu+SEOnk2Q82aDOG/b/PQflH0NyKbXdpuCuAYh6ffmISVRwOhMk0PN0Yet4S4lkVfD/9LY05Ie2+B4nbEvRBAnyDiUtSmBJ8P2v59MuXY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780691; c=relaxed/simple;
	bh=GelzL7tK3IDbyQQc18N9yANhh7UzOBEAx01yf91B/u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+XEhVbCd0/tTc31BL0nFj612ZPYnzDYEayefA70qyFucryTclHcjxRzWIbFwCx/q4Aai9sHmE1HL/FQN2nYwhHkZsLENF0CWWEJL+I51530aGsSmeMRkXpCdinaSqxZ+qTAesXRFKpCnUcUSiSWeM/9UbMrXj5fUPy6R8oxtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SygcPVYB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SygcPVYB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d399da0b5so8319530b3a.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722780689; x=1723385489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze7XLMS7NDqIVYNX6huYU0UVXtRyLQPEBNPP4PU6DQ8=;
        b=SygcPVYBrCYkCdjhnrchlCK7XN9fk4xBPN1UbSHYbdTE18jpwbhAJx0LIpNx1sd0Wg
         ZCShy8rC5/c237+iHAxD6eEd10tjiU9TDdWyc+fXHPpvRJLpf8W6+4+HBzG3I1FvOJbO
         BCf9pp7Bzxb/2nYqWLjtG7d/UkKLaTW49Rjay7uwu79V6FNm9lLaYbYxcbduld8LRFiP
         DjoiB1TNmd+rNfRfwW+0KRBqBQApUFNHn08bTFjgMd19S43pkyjVMbNA0yfLOtuE7WyH
         +E9BDa2DeizFcDQJmb0VrlZZ1kh5sT0uElNWedUdT4C+jzBx8onfIrsSGhBp5VqeZsuV
         wZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722780689; x=1723385489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze7XLMS7NDqIVYNX6huYU0UVXtRyLQPEBNPP4PU6DQ8=;
        b=BevUehHss1KywokYGW0c1mjyLW8tH5ss8R/kdck3uLmEHIEcEhXhlmqHaI69SKl8hb
         iP7rOqiZM+VxegUvHcwoeyq9Cz/PhFO9PHpA+Wg4O8+kTXHtx/4BolxIiibznircYI/F
         rfLhVtCVm++zZIxiJyzuzw5py/PSjQRKMSFgUd2lIasNCVBeShkEXim0riIxogg75egF
         2zBzLrvADXcP7VEGwRSTaAASywJZOIt0tDsJil5r3dF1+DOtV+4SRrTLMogkXD0SJpi4
         ZFqnV/LOtBieq+wDJJSkjPV3DNVnb6AX14z9d68pR3lwN5LJK/5XyEiaz8165YprvAGv
         vvkA==
X-Gm-Message-State: AOJu0YySA6RgodSVlDpqKpZ5Ra9aNC+w5pzRuHHUfGGE8M/UtetakHzz
	Q8qr4jYy2E53a6T7QrSIi64lRjj5ACcTkB58VpMecwSF0UJubWCcmgsBfPE3
X-Google-Smtp-Source: AGHT+IGpRnF98E4I7Tu+g0amZU51pnqNPl6p3fdfuU/QvXhkRE1yel4z9jwvWdQJ8nT9UA6L0+0TPg==
X-Received: by 2002:a05:6a00:1887:b0:70c:f1fa:d7a3 with SMTP id d2e1a72fcca58-7106cfab41bmr11806410b3a.12.1722780688769;
        Sun, 04 Aug 2024 07:11:28 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.183])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec269d2sm4125047b3a.17.2024.08.04.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:11:28 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v7 0/5] t: port reftable/tree_test.c to the unit testing framework
Date: Sun,  4 Aug 2024 19:36:44 +0530
Message-ID: <20240804141105.4268-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240802121318.4583-1-chandrapratap3519@gmail.com>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/tree_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series is
preparatory cleanup, the second patch moves the test to the unit
testing framework, and the rest of the patches improve upon the
ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v7:
- Fix style issues in a comment introduced in patch 3
  of the previous series

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
t/unit-tests/t-reftable-tree.c | 83 +++++++++++++++++++++++++++++++++++++
6 files changed, 89 insertions(+), 73 deletions(-)

Range-diff against v6:

1:  d4a45e602c = 1:  d738bf57e2 reftable: remove unnecessary curly braces in reftable/tree.c
2:  9148e740e8 ! 2:  f090ace685 t: move reftable/tree_test.c to the unit testing framework
    @@ t/unit-tests/t-reftable-tree.c (new)
     +	size_t i = 1;
     +	struct curry c = { 0 };
     +
    -+	/* pseudo-randomly insert the pointers for elements between
    -+	 * values[1] and values[10] (included) in the tree.
    ++	/*
    ++	 * Pseudo-randomly insert the pointers for elements between
    ++	 * values[1] and values[10] (inclusive) in the tree.
     +	 */
     +	do {
     +		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
3:  f73ad11238 ! 3:  22256e77b3 t-reftable-tree: split test_tree() into two sub-test functions
    @@ t/unit-tests/t-reftable-tree.c: static void check_increasing(void *arg, void *ke
      	size_t i = 1;
     -	struct curry c = { 0 };

    --	/* pseudo-randomly insert the pointers for elements between
    --	 * values[1] and values[10] (included) in the tree.
    -+	/* Pseudo-randomly insert the pointers for elements between
    -+	 * values[1] and values[10] (inclusive) in the tree.
    - 	 */
    - 	do {
    - 		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
    + 	/*
    + 	 * Pseudo-randomly insert the pointers for elements between
     @@ t/unit-tests/t-reftable-tree.c: static void t_tree(void)
      		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
      	}
4:  edb02d2e84 = 4:  0d04daad28 t-reftable-tree: add test for non-existent key
5:  6aecd4e374 = 5:  80d4aa2a66 t-reftable-tree: improve the test for infix_walk()
