Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657E1366
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670975; cv=none; b=Vc8x4MLAVo3wYokB8r57ymZKxPM/BAUjKDUq6w1FYdzd9FKSruF7uW0AyTKisMjXfLJflADjFe6Go9+Th7jGjegnWQnSOxN/4IjFWmRFHHGUVGMss/XeZkRfrs+xg0orogyWr+vFqBMGA/gUV1pKhBqOWrW+9Szwxr4ipIx+sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670975; c=relaxed/simple;
	bh=tTGs3UwDxrPv9Z/OM/koyduDipcUZ/0WdvNVuYxCM6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGQOX6G8m3MzWx1SVDFw7iVmW95wEvTrwdlGE70EN+Wv4Rs2z4MAYr7Uti3nATs+9DcPKquD5GDqsUXpMLxZUE28OKSiaB15Far/VKInW5JtJ/HhQ4kosVyRSvN80AnRhqXJM/AaYIdANk8feb1bd6lpVXXEmN55M59eIUX0toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T16Ct6As; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T16Ct6As"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-70df213542bso253397a12.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670973; x=1721275773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haRYTXByZXcA1Nc2wfCK3DYYeF2zAYOstxNO7FTJX8w=;
        b=T16Ct6As2sD/Ldj0RkWOlwJISQAc/EGuSA3ABXpjJr9TY/xlaQka61lCEoLNV4PrZd
         k71tDPD50zkGiG07gaawNjM3m/FbBUxLy73p1EoLvjFB1g1C4OeE0PMbD/AA4mbV2p68
         Vn7OzlWiy+nwCl+KlEdXPwA+5lYFPOUf6nytSP+rarczGP2GwIPpV9HJit0BnXmRnFV+
         mjB1e8rY3ow6+htSmpv2cL6PXWpvfnrFKdJt13MnRqjagKAu60mgRL83KOCOLTN1zFNh
         6MvjflQi8/1ORr9VVlNv854XvV3of7J3AmZ5SovZxBh82jW9NlOHgSrwx60G1pOWBzex
         bzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670973; x=1721275773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haRYTXByZXcA1Nc2wfCK3DYYeF2zAYOstxNO7FTJX8w=;
        b=T28ScaKJQcoth3SRNwUc8Mvl7UsAbaUfM/3QVMJc3Eo9q/zMJCtvMGgXGwrc3eGjps
         wiyql6oojKwNfcFcyAZO1lqin/jhFyd3PTcl4/rUGbZyYdTSGhmdnyDlMEXg27BcfK4f
         4HZKGtjnyBTtpnS978MxQmq15OQBpwYTS3aUNzJl1qMA4Ir+SDgZBjKZ64+q0CMl6daw
         I6b7nQO3Ohr9fzU/7oUUX9cfqbFUh7+W/0cxqkDeYOZslg3i9G0WdXJrJQSDzSodsOYY
         2FdBTKER++tkJC1BsdDMlib5VJ3D33NPsstXcKhVapDxNww+GRB7FXQuNq7UJdHhQnaR
         rV4g==
X-Gm-Message-State: AOJu0Yywae0tg++w1qKRIUE3ZKEGqrrQja0TUHtFSTZCmVS+C0UXTygP
	jo08SXwv8eSInvxE0URVZ6lKBqCeQC0oEw6ruZkPHYzHTnSZCaW0Exx8aSv+
X-Google-Smtp-Source: AGHT+IERBvgSITWQAHOxOvbxgFtTKJdcyGMtRdVJ5Aa/bP3HmJZLHg0zzIDX+zZJE1FfU7T/SDk0WQ==
X-Received: by 2002:a05:6a20:2588:b0:1be:ffe4:b2a2 with SMTP id adf61e73a8af0-1c298203941mr8499311637.7.1720670973099;
        Wed, 10 Jul 2024 21:09:33 -0700 (PDT)
Received: from Ubuntu.. ([106.206.206.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6abf738sm40808595ad.198.2024.07.10.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:09:32 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [GSoC][PATCH v3 0/7] t: port reftable/merged_test.c to the unit testing framework
Date: Thu, 11 Jul 2024 09:28:29 +0530
Message-ID: <20240711040854.4602-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
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
reftable/merged_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series moves the test to the unit testing framework,
and the rest of the patches improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v3:
- Remove merged_test_main() from reftable/reftable-tests.h
- Fix a typo in patch 7

CI/PR: https://github.com/gitgitgadget/git/pull/1755

Chandra Pratap (7):
[PATCH 1/7] t: move reftable/merged_test.c to the unit testing framework
[PATCH 2/7] t: harmonize t-reftable-merged.c with coding guidelines
[PATCH 3/7] t-reftable-merged: improve the test for t_merged_single_record()
[PATCH 4/7] t-reftable-merged: improve the const-correctness of helper functions
[PATCH 5/7] t-reftable-merged: add tests for reftable_merged_table_max_update_index
[PATCH 6/7] t-reftable-merged: use reftable_ref_record_equal to compare ref records
[PATCH 7/7] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR

Makefile                                                   |   2 +-
t/helper/test-reftable.c                                   |   1 -
reftable/reftable-tests.h				   |   1 -
reftable/merged_test.c => t/unit-tests/t-reftable-merged.c | 202 +++++++++++++++----------------
4 files changed, 103 insertions(+), 103 deletions(-)

Range-diff against v2:
1:  0d71deffad ! 1:  9c9fbaf75c t: move reftable/merged_test.c to the unit testing framework
    @@ Makefile: REFTABLE_OBJS += reftable/writer.o
      REFTABLE_TEST_OBJS += reftable/record_test.o
      REFTABLE_TEST_OBJS += reftable/readwrite_test.o

    + ## reftable/reftable-tests.h ##
    +@@ reftable/reftable-tests.h: license that can be found in the LICENSE file or at
    +
    + int basics_test_main(int argc, const char **argv);
    + int block_test_main(int argc, const char **argv);
    +-int merged_test_main(int argc, const char **argv);
    + int pq_test_main(int argc, const char **argv);
    + int record_test_main(int argc, const char **argv);
    + int readwrite_test_main(int argc, const char **argv);
    +
      ## t/helper/test-reftable.c ##
     @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
      	tree_test_main(argc, argv);
2:  a449e2edcf = 2:  08c993f5f6 t: harmonize t-reftable-merged.c with coding guidelines
3:  20fb20bb59 = 3:  fa3085bd9b t-reftable-merged: improve the test t_merged_single_record()
4:  617f668b08 = 4:  d491c1f383 t-reftable-merged: improve the const-correctness of helper functions
5:  bf51af687f = 5:  ee9909f7ce t-reftable-merged: add tests for reftable_merged_table_max_update_index
6:  e2b8f6b3fe = 6:  5ce16e9cfc t-reftable-merged: use reftable_ref_record_equal to compare ref records
7:  b606d67ee7 ! 7:  d090e9ca5b t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
    @@ Commit message
         t-reftable-merged: add test for REFTABLE_FORMAT_ERROR

         When calling reftable_new_merged_table(), if the hash ID of the
    -    passsed reftable_table parameter doesn't match the passed hash_id
    +    passed reftable_table parameter doesn't match the passed hash_id
         parameter, a REFTABLE_FORMAT_ERROR is thrown. This case is
         currently left unexercised, so add a test for the same.

