Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4232FE05F
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992179; cv=none; b=BUYQ0lTdzMhdinEmn/JBRhhfJQcLs1ehLQFHBonx11fx4uYllhErEKDilaHi8k2Had3DlY8Pzx4J8K4Adc2gFVs6xNhB9W5q0OEARkpNOAXP7fYLcmItb5TlCsrbuaA/4/Gs7M8RPeKqKLRwSbwAAfr+tvQD8E+dBfK/jUyVHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992179; c=relaxed/simple;
	bh=GRMLjg3kuKp6G0nWD2jNkbngn3V8cU72BTFD+TMRKuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtABt5ECSoHH81TukKsezpjwD7XRbEkkCuPcq7kQU3Ie09/A63SsmercqlqiYH6FFNc3SUp0ylL3GCNSL7cfya9gtti6k47a3Wai7o19DAbAR6L79WEzZN19tfZbusLmHkBG7VKmWsixLck2DTRr/pAGiyU/FQZh4RqfQ2k/Q80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDCdSV6S; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDCdSV6S"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso755097f8f.2
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992175; x=1757596975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CiuSoTsQHzNMthZYgUQxo2ldnWeKDOmEpCQVmvbBbQ4=;
        b=GDCdSV6SfnmMY1UtkERRG9pOKThHJnDmnGuMuk/67Fd/WXze6SPv96ea24ptXUwGvx
         sadNB7z2z2RmjGCuP2RjYKX3mHzW5WTNLWVJTR9TsNxCVu5HeCkAHNVAL37UaRH2njFh
         aqrrbJpSeQDcUJXdMp/aUFc5b6Biw9/qTcGBFC/fcWYJ2xa6IvCc/LVs12/VB5T/z0rc
         tqcdB/qqHm5WamXyutlq0ms+RlXfD8CbaiVhZryasLofFMXwxq9xPseN9NTC9z8Zahid
         3ywVGbOwLpbFom6tPIutvNR4WESSnjLOE3tmoeuF273+0eGHOyH77Q7XvQvMKCT36oFt
         7hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992175; x=1757596975;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiuSoTsQHzNMthZYgUQxo2ldnWeKDOmEpCQVmvbBbQ4=;
        b=YZnyJ46dKYw6bE9cyMgNZzvV8YhFbrS2/jZb2WxzlJO8Yifse4ygsMbFFGzgR5VzBW
         c+Kfz9Blk9FOF+9O64dOQvnNXbV89xChoPgGu2goq495s4BsB2nSjDj+X8Ojc1rmNdrk
         bWbjxI0sO7UfzKEBPLc2ie6j+7yuU0oQuVuVf9LdBRZOqlPy2lOyS9qzYQQlgiYvNLZb
         YiDSnEqTdAnhjneDrej8ttgSIYzAcEKEnThEZBSX103o6zJMxn0wXqqtxHhpjF577Oke
         Wyp40z4Y64rvtQ5LR2hGEj1zvqd4QaD+7ntuNXqm+nLGBRX5PD4+D/cPVG1p9AvcIwdR
         sLsw==
X-Gm-Message-State: AOJu0Yx2OHX3cF4lcZGAjNofsbGOSSFdOa/FyIwfGw9w6rXslS4uMMsE
	FDXnUMWPeBLGcCXVmMUFqEdqHO8zrBX+pHLfhr4xwXeC7K3GyFUBQq5EQ9RMuQ==
X-Gm-Gg: ASbGnctuNTw5oNbf+iy3oYLnC30ZbUaUTqQj+SORQcC3bxrFex5Vvuut8khOkFEh2Y7
	RRiwF1V9SCnUw7sl05F+gEePlNWcckR4NIXYO9IztJvjmvGjod05n7QymQMHVdNTOeKwb15nN2y
	YUX6YNOpBmYOr+D9mDOGy84BOZ1AUdhBSSxsIuq9/lF6El2ZSjeMfE85GBXYrs8hQVto8cHior6
	VI9pK7dNYUVFtaamXxIBmd5LijwjNSOyp2QtVlGIP+u2IV+0705it78xNszbNLuMjHc1yaXiB6t
	XQaT7/HWBe427hkwhyEvwOCjdLmbX3dlZddNbWSUaK5sY6ZNaOFdoeKkeHpn1EpUyEhDfX8YY0/
	6Ml/rgpiC5zCTONL9rm7+zqsJR173C46oWHuuZAi5FWlnXtU=
X-Google-Smtp-Source: AGHT+IFTZw8FQl/YM/FuhOGqBD++WkkhRXFVMBUkd+wkxQoO9yvceEqZZkrgcHmFNMJ3hQ9DUHnlEg==
X-Received: by 2002:a05:6000:4312:b0:3cf:3f1:acc3 with SMTP id ffacd0b85a97d-3d1df631895mr17482091f8f.60.1756992174184;
        Thu, 04 Sep 2025 06:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d643dsm28278985f8f.26.2025.09.04.06.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:22:53 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] breaking changes: switch default initial branch name to "main"
Date: Thu,  4 Sep 2025 14:21:28 +0100
Message-ID: <cover.1756992089.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series switches the default branch name from "master" to "main"
when WITH_BREAKING_CHANGES is enabled. We have been warning that the
default name will change since 675704c74dd (init: provide useful advice
about init.defaultBranch, 2020-12-11) and the major git forges have all
switched their default branch name to "main", so I think it makes sense
to change the default branch name in git to match the wider ecosystem.

The first patch switches the default initial branch name to "main"
and the other three patches remove the last remaining instances of
GIT_TEST_DEFAULT_BRANCH_NAME=master from the test suite. Patch 2 is
quite large but is mechanically generated so it should be possible
to review it by checking that the changes can be reproduced. As this
series changes the default branch name it focuses on updating tests
that rely on the default branch name being "master", there are still
a number of tests that create a branch called "master".

Thanks to everyone who commented on V1, I have dropped the removal of
GIT_TEST_DEFAULT_BRANCH_NAME and the test changes related to that but
have kept the patches that remove GIT_TEST_DEFAULT_BRANCH_NAME=master.
The patches have been re-ordered so that the change to the default
initial branch name comes first. That patch now includes a test
for the default initial branch name and includes the changes to the
commit message and documentation suggested by Patrick and Junio. The
commit messages for the other patches have been reworded now that
GIT_TEST_DEFAULT_BRANCH_NAME is not being removed but the code changes
are the same.

This is an alternative to changing the branch name now as suggested in
https://lore.kernel.org<pull.1961.git.1756183921623.gitgitgadget@gmail.com

Base-Commit: f814da676ae46aac5be0a98b99373a76dee6cedb
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Finitial-branch-is-main%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/f814da676...c4d89c376
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/initial-branch-is-main/v2


Phillip Wood (4):
  breaking-changes: switch default branch to main
  t4013: switch default branch name to main
  t9902: switch default branch name to main
  t0613: stop setting default initial branch

 Documentation/BreakingChanges.adoc            |   5 +
 Documentation/git-init.adoc                   |  12 +-
 advice.c                                      |   2 +
 advice.h                                      |   2 +
 ci/run-build-and-tests.sh                     |   1 -
 refs.c                                        |  15 +-
 t/t0001-init.sh                               |  18 +-
 t/t0613-reftable-write-options.sh             |  20 +-
 t/t4013-diff-various.sh                       | 228 +++++++++---------
 ...ree_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...iff.diff-tree_--cc_--patch-with-stat_main} |   2 +-
 ...r => diff.diff-tree_--cc_--shortstat_main} |   2 +-
 ...diff.diff-tree_--cc_--stat_--summary_main} |   2 +-
 ...master => diff.diff-tree_--cc_--stat_main} |   2 +-
 ...e_--cc_master => diff.diff-tree_--cc_main} |   2 +-
 ...master => diff.diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.diff-tree_-c_--stat_--summary_main} |   2 +-
 ...t_master => diff.diff-tree_-c_--stat_main} |   2 +-
 ...-tree_-c_master => diff.diff-tree_-c_main} |   2 +-
 ...-tree_-m_master => diff.diff-tree_-m_main} |   2 +-
 ...-p_-m_master => diff.diff-tree_-p_-m_main} |   2 +-
 t/t4013/diff.diff-tree_-p_main                |   2 +
 t/t4013/diff.diff-tree_-p_master              |   2 -
 t/t4013/diff.diff-tree_main                   |   2 +
 t/t4013/diff.diff-tree_master                 |   2 -
 t/t4013/diff.diff_--dirstat_--cc_main~1_main  |   3 +
 .../diff.diff_--dirstat_--cc_master~1_master  |   3 -
 t/t4013/diff.diff_--dirstat_main~1_main~2     |   3 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |   3 -
 ...ff.diff_--line-prefix=abc_main_main^_side} |   2 +-
 ...master^_side => diff.diff_main_main^_side} |   2 +-
 ...mat-patch_--attach_--stdout_initial..main} |   2 +-
 ...at-patch_--attach_--stdout_initial..main^} |   2 +-
 ...e_--stdout_--numbered-files_initial..main} |   2 +-
 ...t_--subject-prefix=TESTCASE_initial..main} |   2 +-
 ...mat-patch_--inline_--stdout_initial..main} |   2 +-
 ...at-patch_--inline_--stdout_initial..main^} |   2 +-
 ...t-patch_--inline_--stdout_initial..main^^} |   2 +-
 ...--stdout_--cover-letter_-n_initial..main^} |   2 +-
 ...atch_--stdout_--no-numbered_initial..main} |   2 +-
 ...t-patch_--stdout_--numbered_initial..main} |   2 +-
 ... diff.format-patch_--stdout_initial..main} |   2 +-
 ...diff.format-patch_--stdout_initial..main^} |   2 +-
 ..._-m_-p_master => diff.log_--cc_-m_-p_main} |   2 +-
 t/t4013/diff.log_--decorate=full_--all        |   2 +-
 ..._--decorate=full_--clear-decorations_--all |   2 +-
 ...f.log_--decorate=full_--decorate-all_--all |   2 +-
 t/t4013/diff.log_--decorate_--all             |   2 +-
 ...f.log_--decorate_--clear-decorations_--all |   2 +-
 .../diff.log_--decorate_--decorate-all_--all  |   2 +-
 ... diff.log_--diff-merges=first-parent_main} |   2 +-
 ..._--diff-merges=off_-p_--first-parent_main} |   2 +-
 ..._--first-parent_--diff-merges=off_-p_main} |   2 +-
 ...g_--no-diff-merges_-p_--first-parent_main} |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...master => diff.log_--patch-with-stat_main} |   2 +-
 ...> diff.log_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...g_--root_--patch-with-stat_--summary_main} |   2 +-
 ...=> diff.log_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...root_-p_master => diff.log_--root_-p_main} |   2 +-
 ...log_--root_master => diff.log_--root_main} |   2 +-
 ...ter => diff.log_-GF_-p_--pickaxe-all_main} |   2 +-
 ...log_-GF_-p_master => diff.log_-GF_-p_main} |   2 +-
 ...{diff.log_-SF_master => diff.log_-GF_main} |   2 +-
 ...aster => diff.log_-IA_-IB_-I1_-I2_-p_main} |   2 +-
 ...log_-SF_-p_master => diff.log_-SF_-p_main} |   2 +-
 ...{diff.log_-GF_master => diff.log_-SF_main} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=0       |   2 +
 ...ount=2 => diff.log_-SF_main_--max-count=1} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=2       |   7 +
 t/t4013/diff.log_-SF_master_--max-count=0     |   2 -
 t/t4013/diff.log_-SF_master_--max-count=1     |   7 -
 ...iff.log_-S_F_master => diff.log_-S_F_main} |   2 +-
 ...cc_-m_-p_master => diff.log_-c_-m_-p_main} |   2 +-
 ...-m_--raw_master => diff.log_-m_--raw_main} |   2 +-
 ..._--stat_master => diff.log_-m_--stat_main} |   2 +-
 ...ter => diff.log_-m_-p_--first-parent_main} |   2 +-
 ...f.log_-m_-p_master => diff.log_-m_-p_main} |   2 +-
 ...ff.log_-p_--diff-merges=first-parent_main} |   2 +-
 ...master => diff.log_-p_--first-parent_main} |   2 +-
 .../{diff.log_-p_master => diff.log_-p_main}  |   2 +-
 t/t4013/{diff.log_master => diff.log_main}    |   2 +-
 ...iff.noellipses-diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.noellipses-whatchanged_--root_main} |   2 +-
 ...r => diff.noellipses-whatchanged_-SF_main} |   2 +-
 ...aster => diff.noellipses-whatchanged_main} |   2 +-
 ...t_master => diff.show_--first-parent_main} |   2 +-
 ...{diff.show_-c_master => diff.show_-c_main} |   2 +-
 ...{diff.show_-m_master => diff.show_-m_main} |   2 +-
 t/t4013/{diff.show_master => diff.show_main}  |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...> diff.whatchanged_--patch-with-stat_main} |   2 +-
 ...hatchanged_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...d_--root_--patch-with-stat_--summary_main} |   2 +-
 ...whatchanged_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...master => diff.whatchanged_--root_-p_main} |   2 +-
 ...ot_master => diff.whatchanged_--root_main} |   2 +-
 ...-p_master => diff.whatchanged_-SF_-p_main} |   2 +-
 ...d_-SF_master => diff.whatchanged_-SF_main} |   2 +-
 ...ged_-p_master => diff.whatchanged_-p_main} |   2 +-
 ...atchanged_master => diff.whatchanged_main} |   2 +-
 t/t9902-completion.sh                         |   6 +-
 t/test-lib.sh                                 |  11 +-
 107 files changed, 282 insertions(+), 244 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_--summary_master => diff.diff-tree_--cc_--patch-with-stat_--summary_main} (86%)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_master => diff.diff-tree_--cc_--patch-with-stat_main} (89%)
 rename t/t4013/{diff.diff-tree_--cc_--shortstat_master => diff.diff-tree_--cc_--shortstat_main} (65%)
 rename t/t4013/{diff.diff-tree_-c_--stat_--summary_master => diff.diff-tree_--cc_--stat_--summary_main} (71%)
 rename t/t4013/{diff.diff-tree_-c_--stat_master => diff.diff-tree_--cc_--stat_main} (76%)
 rename t/t4013/{diff.diff-tree_--cc_master => diff.diff-tree_--cc_main} (91%)
 rename t/t4013/{diff.diff-tree_-c_--abbrev_master => diff.diff-tree_-c_--abbrev_main} (83%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_--summary_master => diff.diff-tree_-c_--stat_--summary_main} (70%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_master => diff.diff-tree_-c_--stat_main} (75%)
 rename t/t4013/{diff.diff-tree_-c_master => diff.diff-tree_-c_main} (93%)
 rename t/t4013/{diff.diff-tree_-m_master => diff.diff-tree_-m_main} (96%)
 rename t/t4013/{diff.diff-tree_-p_-m_master => diff.diff-tree_-p_-m_main} (97%)
 create mode 100644 t/t4013/diff.diff-tree_-p_main
 delete mode 100644 t/t4013/diff.diff-tree_-p_master
 create mode 100644 t/t4013/diff.diff-tree_main
 delete mode 100644 t/t4013/diff.diff-tree_master
 create mode 100644 t/t4013/diff.diff_--dirstat_--cc_main~1_main
 delete mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master
 create mode 100644 t/t4013/diff.diff_--dirstat_main~1_main~2
 delete mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
 rename t/t4013/{diff.diff_--line-prefix=abc_master_master^_side => diff.diff_--line-prefix=abc_main_main^_side} (87%)
 rename t/t4013/{diff.diff_master_master^_side => diff.diff_main_main^_side} (89%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master => diff.format-patch_--attach_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master^ => diff.format-patch_--attach_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--numbered-files_initial..master => diff.format-patch_--inline_--stdout_--numbered-files_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master => diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master => diff.format-patch_--inline_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^ => diff.format-patch_--inline_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^^ => diff.format-patch_--inline_--stdout_initial..main^^} (95%)
 rename t/t4013/{diff.format-patch_--stdout_--cover-letter_-n_initial..master^ => diff.format-patch_--stdout_--cover-letter_-n_initial..main^} (96%)
 rename t/t4013/{diff.format-patch_--stdout_--no-numbered_initial..master => diff.format-patch_--stdout_--no-numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_--numbered_initial..master => diff.format-patch_--stdout_--numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master => diff.format-patch_--stdout_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master^ => diff.format-patch_--stdout_initial..main^} (96%)
 rename t/t4013/{diff.log_-c_-m_-p_master => diff.log_--cc_-m_-p_main} (99%)
 rename t/t4013/{diff.log_--diff-merges=first-parent_master => diff.log_--diff-merges=first-parent_main} (95%)
 rename t/t4013/{diff.log_--no-diff-merges_-p_--first-parent_master => diff.log_--diff-merges=off_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--first-parent_--diff-merges=off_-p_master => diff.log_--first-parent_--diff-merges=off_-p_main} (95%)
 rename t/t4013/{diff.log_--diff-merges=off_-p_--first-parent_master => diff.log_--no-diff-merges_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--patch-with-stat_--summary_master_--_dir_ => diff.log_--patch-with-stat_--summary_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--patch-with-stat_master => diff.log_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--patch-with-stat_master_--_dir_ => diff.log_--patch-with-stat_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--root_--cc_--patch-with-stat_--summary_master => diff.log_--root_--cc_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_--summary_master => diff.log_--root_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_master => diff.log_--root_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--root_-c_--patch-with-stat_--summary_master => diff.log_--root_-c_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_-p_master => diff.log_--root_-p_main} (98%)
 rename t/t4013/{diff.log_--root_master => diff.log_--root_main} (96%)
 rename t/t4013/{diff.log_-GF_-p_--pickaxe-all_master => diff.log_-GF_-p_--pickaxe-all_main} (90%)
 rename t/t4013/{diff.log_-GF_-p_master => diff.log_-GF_-p_main} (91%)
 rename t/t4013/{diff.log_-SF_master => diff.log_-GF_main} (86%)
 rename t/t4013/{diff.log_-IA_-IB_-I1_-I2_-p_master => diff.log_-IA_-IB_-I1_-I2_-p_main} (97%)
 rename t/t4013/{diff.log_-SF_-p_master => diff.log_-SF_-p_main} (91%)
 rename t/t4013/{diff.log_-GF_master => diff.log_-SF_main} (86%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=0
 rename t/t4013/{diff.log_-SF_master_--max-count=2 => diff.log_-SF_main_--max-count=1} (79%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=2
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=0
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=1
 rename t/t4013/{diff.log_-S_F_master => diff.log_-S_F_main} (86%)
 rename t/t4013/{diff.log_--cc_-m_-p_master => diff.log_-c_-m_-p_main} (99%)
 rename t/t4013/{diff.log_-m_--raw_master => diff.log_-m_--raw_main} (98%)
 rename t/t4013/{diff.log_-m_--stat_master => diff.log_-m_--stat_main} (98%)
 rename t/t4013/{diff.log_-m_-p_--first-parent_master => diff.log_-m_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-m_-p_master => diff.log_-m_-p_main} (99%)
 rename t/t4013/{diff.log_-p_--diff-merges=first-parent_master => diff.log_-p_--diff-merges=first-parent_main} (97%)
 rename t/t4013/{diff.log_-p_--first-parent_master => diff.log_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-p_master => diff.log_-p_main} (98%)
 rename t/t4013/{diff.log_master => diff.log_main} (97%)
 rename t/t4013/{diff.noellipses-diff-tree_-c_--abbrev_master => diff.noellipses-diff-tree_-c_--abbrev_main} (81%)
 rename t/t4013/{diff.noellipses-whatchanged_--root_master => diff.noellipses-whatchanged_--root_main} (96%)
 rename t/t4013/{diff.noellipses-whatchanged_-SF_master => diff.noellipses-whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.noellipses-whatchanged_master => diff.noellipses-whatchanged_main} (96%)
 rename t/t4013/{diff.show_--first-parent_master => diff.show_--first-parent_main} (92%)
 rename t/t4013/{diff.show_-c_master => diff.show_-c_main} (95%)
 rename t/t4013/{diff.show_-m_master => diff.show_-m_main} (98%)
 rename t/t4013/{diff.show_master => diff.show_main} (96%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_--summary_master_--_dir_ => diff.whatchanged_--patch-with-stat_--summary_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master => diff.whatchanged_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master_--_dir_ => diff.whatchanged_--patch-with-stat_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master => diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_--summary_master => diff.whatchanged_--root_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_master => diff.whatchanged_--root_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-c_--patch-with-stat_--summary_master => diff.whatchanged_--root_-c_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-p_master => diff.whatchanged_--root_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_--root_master => diff.whatchanged_--root_main} (97%)
 rename t/t4013/{diff.whatchanged_-SF_-p_master => diff.whatchanged_-SF_-p_main} (89%)
 rename t/t4013/{diff.whatchanged_-SF_master => diff.whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.whatchanged_-p_master => diff.whatchanged_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_master => diff.whatchanged_main} (97%)

Range-diff against v1:
1:  7c20f7693f4 < -:  ----------- t0018: switch default branch name to main
6:  487d1a33130 ! 1:  6986375dc37 breaking-changes: switch default branch to main
    @@ Commit message
         breaking-changes: switch default branch to main
     
         Since 1296cbe4b46 (init: document `init.defaultBranch` better,
    -    2020-12-11) "git-init.adoc" has advertized that the default name
    +    2020-12-11) "git-init.adoc" has advertised that the default name
         of the initial branch may change in the future. The name "main"
    -    is chosen to match the default used by the big git forge web sites.
    +    is chosen to match the default used by the big Git forge web sites.
     
    -    The advice printed when init.defaultBranch is not set is
    -    updated to say that the default will change to "main" in Git
    -    3.0. Building with WITH_BREAKING_CHANGES enabled removes the advice,
    -    changes the default branch name is "main" and removes support for
    -    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME. The code in guess_remote_head()
    +    The advice printed when init.defaultBranch is not set is updated
    +    to say that the default will change to "main" in Git 3.0. Building
    +    with WITH_BREAKING_CHANGES enabled removes the advice and changes
    +    the default branch name to "main". The code in guess_remote_head()
         that looks for "refs/heads/master" is left unchanged as that is only
         called when the remote server does not support the symref capability
         in the v0 protocol or the symref extension to the ls-refs list in the
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
      "reftable" format. Most importantly, alternative implementations of Git like
      JGit, libgit2 and Gitoxide need to support it.
      
    -+* The default branch name will be `main`. We have been warning that the default
    -+  name will change since 675704c74dd (init: provide useful advice about
    -+  init.defaultBranch, 2020-12-11). The new name matches the default branch name
    -+  used by many of the big git forges.
    ++* In new repositories the default branch name will be `main`. We have been
    ++  warning that the default name will change since 675704c74dd (init: provide
    ++  useful advice about init.defaultBranch, 2020-12-11).  The new name matches
    ++  the default branch name used by many of the big Git forges.
     +
      === Removals
      
    @@ Documentation/git-init.adoc: If this is a reinitialization, the repository will
     +(currently `master`, but this will change to `main` when Git 3.0 is released).
     +endif::with-breaking-changes[]
     +ifdef::with-breaking-changes[]
    -+(`main`).
    ++`main`.
     +endif::with-breaking-changes[]
     +The default name can be customized via the `init.defaultBranch` configuration
     +variable.
    @@ refs.c: static const char default_branch_name_advice[] = N_(
      );
     +#endif /* WITH_BREAKING_CHANGES */
      
    - char *repo_default_branch_name(struct repository *r, int quiet)
    +-char *repo_default_branch_name(struct repository *r, int quiet)
    ++char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
      {
      	const char *config_key = "init.defaultbranch";
      	const char *config_display_key = "init.defaultBranch";
    - 	char *ret = NULL, *full_ref;
    -+#ifndef WITH_BREAKING_CHANGES
    - 	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
    +@@ refs.c: char *repo_default_branch_name(struct repository *r, int quiet)
      
      	if (env && *env)
      		ret = xstrdup(env);
     -	else if (repo_config_get_string(r, config_key, &ret) < 0)
    -+#endif /* WITH_BREAKING_CHANGES */
     +	if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
      		die(_("could not retrieve `%s`"), config_display_key);
      
      	if (!ret) {
     +#ifdef WITH_BREAKING_CHANGES
     +		ret = xstrdup("main");
    -+		(void) quiet; /* Silence -Wunused-parameter */
     +#else
      		ret = xstrdup("master");
      		if (!quiet)
    @@ t/t0001-init.sh: test_expect_success 'advice on unconfigured init.defaultBranch
      	test_grep ! "hint: " err
      '
      
    --test_expect_success 'overridden default main branch name (env)' '
    -+test_expect_success !WITH_BREAKING_CHANGES 'overridden default main branch name (env)' '
    ++test_expect_success 'default branch name' '
    ++	if test_have_prereq WITH_BREAKING_CHANGES
    ++	then
    ++		expect=main
    ++	else
    ++		expect=master
    ++	fi &&
    ++	echo "refs/heads/$expect" >expect &&
    ++	(
    ++		sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
    ++		git init default-initial-branch-name
    ++	) &&
    ++	git -C default-initial-branch-name symbolic-ref HEAD >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'overridden default main branch name (env)' '
      	test_config_global init.defaultBranch nmb &&
      	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
    - 	git -C main-branch-env symbolic-ref HEAD >actual &&
    - 	grep env actual
    - '
    - 
    - test_expect_success 'invalid default branch name' '
    --	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME="with space" \
    --		git init initial-branch-invalid 2>err &&
    -+	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
    -+		git -c init.defaultBranch="with space" \
    -+			init initial-branch-invalid 2>err &&
    - 	test_grep "invalid branch name" err
    - '
    - 
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: then
    @@ t/test-lib.sh: then
     +	# transitory "git init" warning under --verbose.
     +	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
     +	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+else
    -+	# Unset the default branch name that is set in many test scripts
    -+	# before sourcing this file.
    -+	unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +fi
      
      ################################################################
2:  c445cf9c65e ! 2:  2a112a1b983 t4013: switch default branch name to main
    @@ Metadata
      ## Commit message ##
         t4013: switch default branch name to main
     
    -    In preparation for removing TEST_GIT_DEFAULT_INITIAL_BRANCH in Git 3.0
    -    switch the default branch name to main.
    -
    -    The changes here are purely mechanical replacing 'master' with 'main'
    +    Remove one of the last remaining uses of
    +    "TEST_GIT_DEFAULT_INITIAL_BRANCH= main" in the test suite. We have
    +    been steadily be converting tests from using "master" as the default
    +    branch name since the introduction of TEST_GIT_DEFAULT_INITIAL_BRANCH
    +    in 704fed9ea22 (tests: start moving to a different default main branch
    +    name, 2020-10-23) The changes here are purely mechanical replacing
    +    "master" with "main"
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
3:  d8a382a79eb ! 3:  f1bf01e1322 t9902: switch default branch name to main
    @@ Metadata
      ## Commit message ##
         t9902: switch default branch name to main
     
    -    In preparation for removing GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in
    -    Git 3.0 update the bash completion tests that rely on the default
    -    branch name being master.
    +    Remove the penultimate use of "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
    +    main" in our test suite. We have slowly been removing these ever since
    +    we started to switch the default branch name used in tests to "main".
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
4:  bbf79dd64fe ! 4:  c4d89c3761b t0613: stop setting default initial branch
    @@ Metadata
      ## Commit message ##
         t0613: stop setting default initial branch
     
    -    As the tests are all run in separate repositories, set the branch
    -    name to "master" when creating the repository for the tests where
    -    the result depends on the branch name. This is in preparation for
    -    removing GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in Git 3.0.
    +    As the tests are all run in separate repositories, set the branch name
    +    to "master" when creating the repository for the tests where the result
    +    depends on the branch name. This reduceds the number of tests that
    +    depend on the default branch name being "master" and removes the last
    +    instance of a test file using "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
    +    master".
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ t/t0613-reftable-write-options.sh: export GIT_TEST_REFTABLE_AUTOCOMPACTION
      test_expect_success 'default write options' '
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    ++	# Block sizes also depend on the actual refs we write, so we force
    ++	# "master" to be the default initial branch name.
     +	git init --initial-branch master repo &&
      	(
      		cd repo &&
5:  a46c0dd25a6 < -:  ----------- t1403: remove dependency on GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-- 
2.49.0.897.gfad3eb7d210

