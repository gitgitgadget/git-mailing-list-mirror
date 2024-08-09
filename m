Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826A174EE7
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202021; cv=none; b=GEtL+Q6AW/tMTtCNHjOpD5vTG85H3K4fg00oa+LFZnBeY2WhYRrfkG6qpRkILtHFIEM0rQDtmFspwaolK6LrjQsoz1OMiXN53jW8RyobXbIEB03l9GD4MgPSRrN3saHn6iX0Mrg6dZlLJXy6Ngolf8zfJUWeb8Ga8WNhtz1M83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202021; c=relaxed/simple;
	bh=6/lcDYwUSrqDonnrlLMyRMGwfGxEIWFmC45Tyqo9W5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZh5XNDj+3GmycAsN3IaDSUYfmH0o1ZG7O95oI1NW+n2Ha+1cL70EM/EV0dmT1ZTb8MuTtNXK1DsZq+zALxHx5cYmOyXDlb50OnQqwISuiOI+3OEo/D3zW7eVojscJDlAJXbQUEozRIQ4A2nfOHMQyiJ6Q2kDoCJAQmdz3o/O50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXvSsbtH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXvSsbtH"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d18112b60so1285148b3a.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723202019; x=1723806819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVNulx++jp0GYbvlkzw4ErbKGTDMggKhJcHSKgGVOS8=;
        b=iXvSsbtHRBL2XlFijR04bF8qbMuuFhzlTXqEPjmBPx/tCdhhwOMzB3QgjW2ZmbkUwU
         F5hxn3K0Iuqk/7l+rxXi2gKRIRd35H7d8gKjmpIuiOLE79NulXPjliyOJZsa4fv+jUGk
         AZy7NmB/m42NGA7HnMA9Wz1/MKoHSm8MK/kXS3F+BsH/bc1EOP5EW1N4Aw+0VqvveYtX
         05vVJ7svfcoJbdxZxhUv8HvSswxcMPh66FKI5474DvwhPw0fujavMTRsA2Xlz0qfKdYX
         svvoKCMWoAwLOo4GgjJESNOx9lK3Merl8wxAZWurzphO9HEIoHygzxMVc1zNsdbATGsA
         0G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202019; x=1723806819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVNulx++jp0GYbvlkzw4ErbKGTDMggKhJcHSKgGVOS8=;
        b=nRxiXj9Ms2bfzgZzutm0jusF24nkcXxdImw3cJQEXXdu3VwMlVtiQyEtPgIWXh/DsN
         jNRhKajUp2/JaTxgBp9KiQLRGBEKPVAQS5Li3r63wk5Ac1BffAqmNN5P1erL7FK0vm9A
         HD/7Z8+XCWvBnMftU46yIKKzOvcUE0JIj7PDBkVqfdCn6tqG7odwcrHNDGQSX77sJSha
         lN9dgYK7mKL6EILbbksbM0T6Isl3Ot8TsgJq3+3BZ8Aebei0hhztn0zGnSvKCTsExLlb
         4jQZwRd3P8A58Ns6CHS02sy5w1/cQe4QDa+zufQdGRKLHyxpBSlxy40UpAMKWqdRSors
         OS9Q==
X-Gm-Message-State: AOJu0YwCp4KtQUNEgBoFs9LYcVWw23RYq3OeizNO/bSQNwXOMxkfI+ID
	Y93AqriF/HcPn6rykPzE7d+vAJIl6fQK0C4Nn6zsZ+BSYJUT2Y+h39Sityr+
X-Google-Smtp-Source: AGHT+IFlmPTKi2pZzTF+YNfG+iEEXIx5W2H9mzmkD7WVSobpj/XWrZ9/KBDyxi4VTDbmTUNuigx9YQ==
X-Received: by 2002:a05:6a00:c8f:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-710dcd5c792mr2111612b3a.9.1723202019139;
        Fri, 09 Aug 2024 04:13:39 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.199])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710cb2e74d1sm2490377b3a.171.2024.08.09.04.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:13:38 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v2 0/4] t: port reftable/readwrite_test.c to the unit testing framework
Date: Fri,  9 Aug 2024 16:35:40 +0530
Message-ID: <20240809111312.4401-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240807141608.4524-1-chandrapratap3519@gmail.com>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
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

Hence, port reftable/readwrite_test.c to the unit testing framework
and improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Drop the fifth patch (t-reftable-readwrite: add tests for print
  functions) of the previous series

CI/PR: https://github.com/gitgitgadget/git/pull/1770

Chandra Pratap(4):
t: move reftable/readwrite_test.c to the unit testing framework
t-reftable-readwrite: use free_names() instead of a for loop
t-reftable-readwrite: use 'for' in place of infinite 'while' loops
t-reftable-readwrite: add test for known error

Makefile                                                         |   2 +-
reftable/reftable-tests.h                                        |   1 -
t/helper/test-reftable.c                                         |   1 -
reftable/readwrite_test.c => t/unit-tests/t-reftable-readwrite.c | 440 +++++++++++++++++++++++-----------------
4 files changed, 218 insertions(+), 226 deletions(-)

Range-diff against v1:

1:  e4b01cd856 < -:  ---------- t-reftable-readwrite: add tests for print functions
