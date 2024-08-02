Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17C1E2126
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600868; cv=none; b=P2lQtRGMFhEss3FviVQY1Ww2gIMpBUqGrYSgWZN7h6kgwrygmS7YZfWtsbJsH0amvMo5G39CLhqaaUZzUS21Ln1kJZbYj/EDIkegP9WyIk5Rx5E4BAy9aDLsN2Kj0TjeGPI0PBCJ9cfGY98AgCTuM5HtjMuPO2JI0Vjl39J54iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600868; c=relaxed/simple;
	bh=v9H8YpAr/Gl0TD3yhWCpo1Ma7jYBHKcjCbIvyOmJvlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS8HcgASsG4JdozebCZc9H1S90kphs1BWVFrGCP9dLhotyT5lDK8YqZQhmL42h9FhMOVvcSiN+g7udFs4V9DekMWCQ2wHUz/h5+U0fJFL4KPvtrPFujbworto+/bExIRMe39ABhf9ZzPzjBaXDC8OIdX4IOUijkinln14Nfo6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaYwiGbu; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaYwiGbu"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-268a9645e72so44315fac.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722600865; x=1723205665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O86vV2VTlPOdDNlcheDH1I47j3TI7EKZ9RfUzI+gcHI=;
        b=CaYwiGbuXufQbivDy6+OAN7jjny9Z+fVx+1lI32rbyRoPf8/upDJSH8vSYrvbomAHj
         Rc3Jz3aB+fK7QvZdNGJxr6FkVy/P9lBhTamj07F9radhleSLzryuoCjvoORgdGBiPb91
         1I9GtShbEP9tSvo0Xsm/SPo1BLvjRnO1ZjwR38cMeOCAcbvhqPGoi4JuvMD2cjqlTTwc
         TRerZgfiLjGxTf5/uT08d0xpR9z91TBJffuu9mQfTAdsjhuMN+1jb9xXrVA6wNVoCUdM
         xorzV5uFKy9O0ABObMHGpzQ8nM7ZxycdIbDJ1C9HxXuUPKuO35Wac/oEwx8pyJ4/sIsl
         F9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722600865; x=1723205665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O86vV2VTlPOdDNlcheDH1I47j3TI7EKZ9RfUzI+gcHI=;
        b=l/EL5U0fFrw4OPm10SgExc3oGAFBzA6WGWbZDKzJAx02qSjJLp04g8oqnCs7IKjeGE
         KhSfSBQ3DnJbIiP/u23tBmVkVXADg6FaSnu9Ukl6Kvad3+uYp71Mh9H3arP3/6nOyi67
         aSRPKONtw+DtGDGAFbSlb8MSPFeoW6vCJ7x3/EFh1fZfx19ajY52QAr8bGkJubQHoYJt
         Qa/9hpzoYwM+q1vQnDBdUbXa+vSnZYoDwNGZovQxCx64DCh6sALJNCAROKiI4CiQuzvB
         lH4fwCF6W05jckgcyyNr48N4sAcWafW+ZsyDIRHgxVPxnfxHtDGHp30wsdqVsHczZp8i
         AAGQ==
X-Gm-Message-State: AOJu0Yx8R7VezKrHP4p/JHUiGBqUk4sR4uYrAF5jsW7+t1Sed9AGPm7/
	ETSUulE6TBMOeN2UkIKnEPfsQNKHxX1ZAds3D/MrWGCGTKVEVGIBcoQ4Wg==
X-Google-Smtp-Source: AGHT+IE76P66O5cp/WeyJuELU5cGOHbfXF3/FFQfWVtFTYwwgHDfRWXlnBS9NeCRxluvy5324uBbdw==
X-Received: by 2002:a05:6870:2247:b0:260:f6c3:7c78 with SMTP id 586e51a60fabf-26891afd63bmr4006707fac.17.1722600865375;
        Fri, 02 Aug 2024 05:14:25 -0700 (PDT)
Received: from Ubuntu.. ([106.213.168.25])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec16034sm1294534b3a.15.2024.08.02.05.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:14:24 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v6 0/5] t: port reftable/tree_test.c to the unit testing framework
Date: Fri,  2 Aug 2024 17:38:03 +0530
Message-ID: <20240802121318.4583-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240722061836.4176-1-chandrapratap3519@gmail.com>
References: <20240722061836.4176-1-chandrapratap3519@gmail.com>
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
Changes in v6:
- Fix a style issue in a comment introduced in patch 3

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

Range-diff against v5:
1:  59d5c17d5e ! 1:  501ea6c05d t-reftable-tree: split test_tree() into two sub-test functions
    @@ t/unit-tests/t-reftable-tree.c: static void check_increasing(void *arg, void *ke
      	size_t i = 1;
     -	struct curry c = { 0 };

    - 	/* pseudo-randomly insert the pointers for elements between
    - 	 * values[1] and values[10] (included) in the tree.
    +-	/* pseudo-randomly insert the pointers for elements between
    +-	 * values[1] and values[10] (included) in the tree.
    ++	/* Pseudo-randomly insert the pointers for elements between
    ++	 * values[1] and values[10] (inclusive) in the tree.
    + 	 */
    + 	do {
    + 		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
     @@ t/unit-tests/t-reftable-tree.c: static void t_tree(void)
      		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
      	}
2:  c1ce79916b = 2:  ecadc1833e t-reftable-tree: add test for non-existent key
3:  d1a5ced526 = 3:  cda7509281 t-reftable-tree: improve the test for infix_walk()

