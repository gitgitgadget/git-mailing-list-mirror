Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5A18453A
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510322; cv=none; b=OeM/Kd3OXZBdOaQq4uXE+oD2Q0FANEIMOXFtuXqik/MAXBnkzeekUTAS1c89FtJFHVY77m9a+SrTmOAZg5IX8Zmi0XnfLWxojyGvWmoLnruJOx/BlLnWm5R3sm4llfaETzxrRxVgOmzdD9DDwS9Vd+K08/9g9wxrkYNg6/BybuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510322; c=relaxed/simple;
	bh=02Hx4KEDbyMSRB05guQawdc6XMKthm/YQiNGTKLjk2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJutZ/f2KDYqmnXgruUGfxtoiVVVqpzwJYM9z2OBJZfne4jeZcYVk6wnWeDLkKPeZivo6bY07XMcdAFGM7aR6vtE00c8X741EOZhsNewBxMdAcq9r4hYLhiCB6WF1STJShrPTCsafl1QDk5TrpcRuV0w1PKCwRosEDR8NgxrCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWR12I1E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWR12I1E"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fdd6d81812so57385395ad.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510320; x=1723115120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBjyQK4c9GNedWyDC9DEQEm8s3p3fKJOlisM4m/NMug=;
        b=MWR12I1Ej011PSWmVxVUnCFgN/Lb5h6Y4ISLecLVI2+RRJIti1rdwLRN3m+Jm/9pwn
         KDzDYDY/+bvgvUlwRd1EIhhpFtWIR8mJ5jg6voor2xAzMi2wNyV5crGxgm8jgKw85vHJ
         KYf888DnQOhlyfaJzDTTwugHOfS07skN5k/JqdN+6wIc4uUlKl8YeGP2cmsTwfilxk9+
         1YbX7uc7benqsTo0JJasF+UeFUkYaHCHgUc7W5od7e4RDpQOWpNTDRsZgqXgf2yipuS/
         vV8Oc6jh59VE1e5WM8eFhhd9sns10rh620q+vC9G5M5OYSZXOFhniEVxrGVK32QwR5yX
         ps8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510320; x=1723115120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBjyQK4c9GNedWyDC9DEQEm8s3p3fKJOlisM4m/NMug=;
        b=cfhn4EdvGkTpcAD/oVB+JB09zRsQ0yEg9eZ74GEEU52yTfqEpk75cNYZ6IvasSN9y/
         1RnFDi4U7djaKI+9WZlMZOiRt8jB4E8y/NQufurHK+p1tV/Y7U9ypVIoXGxKMkIehLjO
         BExsWC2ukJTCfQ9OkK87M/DlUR427yB9I4UE3qG2N6xILH6dPyH4ImTy8q2h5XFKA85F
         ccHrcK/MG1yKHSG7odgxC01151gxCCaFCIRmBI+Uw6oLLNlw6eAjxUBIlg54nb84hBz+
         oatl5NpMoZNqzE+/1mStcc/UeCZoG2b9XCeM7Jv12aOV+Sn+hiTgd2wk6DYFvSeFfgJ1
         5ytw==
X-Gm-Message-State: AOJu0YwPyvJQeQcraNtXKAHb4sQAr3gEShxNZFkUvDJpeK2BhyuW5bh5
	Ki2xEsReJSILGVHqXDChIxI0reUaGtqEwECqek2FWW2fX4Uv/qmNgLpnOA==
X-Google-Smtp-Source: AGHT+IHFovGH0m4FtryfA+Ogt7GGbJCYbffZpXIukmH112r3BKOxZY9IBFYTJrFaGoJnIhtYVmdtRA==
X-Received: by 2002:a17:902:cf12:b0:1fd:d73a:7cd1 with SMTP id d9443c01a7336-1ff4d25d400mr22803095ad.56.1722510319961;
        Thu, 01 Aug 2024 04:05:19 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:19 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v7 0/7] t: port reftable/pq_test.c to the unit testing framework
Date: Thu,  1 Aug 2024 16:29:41 +0530
Message-ID: <20240801110453.5087-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240725093855.4201-1-chandrapratap3519@gmail.com>
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
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

Hence, port reftable/pq_test.c to the unit testing framework and
improve upon the ported test. The first two patches in the series
are preparatory cleanup, the third patch moves the test to the unit
testing framework, and the rest of the patches improve upon the
ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v7:
- Fix a typo in patch 1
- Fix do-while style error in patch 6 and 7

CI/PR for v7: https://github.com/gitgitgadget/git/pull/1745

Chandra Pratap(7):
reftable: remove unncessary curly braces in reftable/pq.c
reftable: change the type of array indices to 'size_t' in reftable/pq.c
t: move reftable/pq_test.c to the unit testing framework
t-reftable-pq: make merged_iter_pqueue_check() static
t-reftable-pq: make merged_iter_pqueue_check() callable by reference
t-reftable-pq: add test for index based comparison
t-reftable-pq: add tests for merged_iter_pqueue_top()

Makefile                     |   2 +-
reftable/pq.c                |  29 +++-----
reftable/pq.h                |   1 -
reftable/pq_test.c           |  74 ---------------------
reftable/reftable-tests.h    |   1 -
t/helper/test-reftable.c     |   1 -
t/unit-tests/t-reftable-pq.c | 152 +++++++++++++++++++++++++++++++++++++++++++
7 files changed, 163 insertions(+), 97 deletions(-)

Range-diff against v6:

1:  acd9d26aaf ! 1:  91719cc47f reftable: remove unncessary curly braces in reftable/pq.c
    @@ Metadata
     Author: Chandra Pratap <chandrapratap3519@gmail.com>

      ## Commit message ##
    -    reftable: remove unncessary curly braces in reftable/pq.c
    +    reftable: remove unnecessary curly braces in reftable/pq.c

         According to Documentation/CodingGuidelines, control-flow statements
         with a single line as their body must omit curly braces. Make
2:  2e0986207b = 2:  2e5e72d5c5 reftable: change the type of array indices to 'size_t' in reftable/pq.c
3:  df06b6d604 = 3:  5db9e92f20 t: move reftable/pq_test.c to the unit testing framework
4:  40745ab18e = 4:  9334b1fe9e t-reftable-pq: make merged_iter_pqueue_check() static
5:  ee8432ac4a = 5:  9d8c33d1fc t-reftable-pq: make merged_iter_pqueue_check() callable by reference
6:  f5c30187e1 ! 6:  7a67861652 t-reftable-pq: add test for index based comparison
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
     +		merged_iter_pqueue_add(&pq, &e);
     +		merged_iter_pqueue_check(&pq);
     +		i = (i * 7) % N;
    -+	}
    -+	while (i != 1);
    ++	} while (i != 1);
     +
     +	for (i = N - 1; i > 0; i--) {
     +		struct pq_entry e = merged_iter_pqueue_remove(&pq);
7:  394540a789 ! 7:  5ac60563e4 t-reftable-pq: add tests for merged_iter_pqueue_top()
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq_record(void)
      		if (last)
      			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
     @@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
    - 	while (i != 1);
    + 	} while (i != 1);

      	for (i = N - 1; i > 0; i--) {
     +		struct pq_entry top = merged_iter_pqueue_top(pq);
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
     +		merged_iter_pqueue_add(&pq, &e);
     +		merged_iter_pqueue_check(&pq);
     +		i = (i * 7) % N;
    -+	}
    -+	while (i != 1);
    ++	} while (i != 1);
     +
     +	for (i = N - 1; i > 0; i--) {
     +		struct pq_entry top = merged_iter_pqueue_top(pq);

