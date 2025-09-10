Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C021B9C5
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518166; cv=none; b=ou/z6opi8qodlY5wwmsLfczKxFE9clC47HAI/Zw/pAgdjn2wx6zE5azYWftDN6d4lUKryCW+p2YMRntuQNgmRf6Qf4x9i2fg0YxC0s4PElOAsk1HLzNs/05FSZSsvgByb6f/Xwt+JkCF4J9Ka/s2Lba9RnTEfFbj8rJMucaoMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518166; c=relaxed/simple;
	bh=hcgkFKDPJYwUdMQ/rbAZFJjVwXHguBP0LyaCov5j0uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5fXqfpzXUG99rdkAGw39j3cavoL9bTOZqcCDRP27n7cTII28WDuquCDPa6TEo9W2gPtuQeeic8VFuWmowlO/jdbbuvbfRpxYYKtWzT2+SKnNv4ILV5jXry4lE6a/JW2+SmlJdacvyxQEZsPIupBEEdd656EeulzL+C/oXkn/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5DnnGgp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5DnnGgp"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so2710263f8f.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518162; x=1758122962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/3c+/gQpR5SnC3BQQTdJBKXrORqhV1Y4LLXo85ROnsY=;
        b=h5DnnGgpjC+5Jup+WrwcvykGV1oUBIaGWHZ6HYYoA9sWaqHnJMmcAuPuYFH3Jq+qqi
         X9qYKhVTAdmjqDdVGzYcyVJN1f+nA2BQXGp7XLuLh29jS9xfQgPWBo95tFLnoVk0e1NP
         d02Ymmokwz4E9AJ6NkxFT0rJRG2mFG4UDyL2/avc+t1CvWe48F+WUFbvjspM7TgE5aHL
         pHO1J8rdQ3HmoiOL6ZMFkgqDWrJXecjENJtEmA/66zF7oHDeB9QT4STptdihb9Nq1l9v
         aHg5em5euRna09sCtCYv5EjH35jH1T4ZpIxkF6A03nsQyu9mdZ79w4mP8Q8b+tVfWq2e
         pWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518162; x=1758122962;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3c+/gQpR5SnC3BQQTdJBKXrORqhV1Y4LLXo85ROnsY=;
        b=aG/6jCiRQlqcLSq6VrX7+ZzGKYQrSQD3mw7mHCH+AfMd7kSIwb7gTTklV+9rgWuMiw
         jWYwASA1mChFmHNQUJNSo9W+pXBzn8uh9FCtgo1mY74l4TVQhFGfgJVgrczc1K0U6cFx
         8sVVRGI/w0rcqOLth3Nm9aHJr+At1gF8nRnHd/QEzZ1Z4ogiDSN9Wjg1EcCOoyNFMEdY
         2ZCadTkJJ0lSKs3KajxJ08Q/DaIw8aFcZZN4RA095D0jOonFsu/NwlOu+t2y/pw7vDsv
         u4/5Jto4x9BuN3xNa/ohaNPRTCxpsS8vifEenKRdbPqHsB/kXkltZdB24HQHa1NVrYlp
         RiCQ==
X-Gm-Message-State: AOJu0YwD2i+EwmkP/jbwPwm5JbKtZlVCVuQRS4AINz2uytWISI+9nuPf
	/BXRCnusJIS7RfrnUrKkg6hiAy+n2cK9IMbkg0StZPBkS7WFOau7DF+2TvU2PA==
X-Gm-Gg: ASbGnctyryj9HfYHmKUx8yXFv4p2Bmc+iah0QxngpG1/5hviw8DKNcl2Y0F6SJskYq1
	4ur0whhb6DywahgcFzN9qaOJBQs5GFNERApqrgnYHZw5Wuk+7mVx/ailcohTcfLcwMmZuQmSI/P
	PpnveKfo//rm2mLItavy4Or/HnrUKhrsOK5yOLSfAYV8MiGC6QHYkG1bskAo0fi5RSTz+E4fLpR
	hjA8+ZF4y0JOx0huAPiUfsP9o4j0kA0hbA4r+vXexzyIXBgX0qk0tx3rsPWZRXk/J2Le8XLzY1k
	IxHWma1jLTMrzY20mEgrvShwHB2B2eVY08SnIhTWHl2C159a47lu9Z4hYZIgZ5833MMQxZp2Epj
	87QupDqqN/QwhxOwXGEeFYwbhwHax2i6W2kxK5NdeYvFZ
X-Google-Smtp-Source: AGHT+IE11ydZWCuj73EsvTVQD36FG4EMLy9aTy2xRlt1U7lf36Z56CWa9j+KDYv3Txyq2CQ0Xw0m7g==
X-Received: by 2002:a05:6000:18a4:b0:3cc:8d94:1108 with SMTP id ffacd0b85a97d-3e641e3cffemr12296334f8f.22.1757518161804;
        Wed, 10 Sep 2025 08:29:21 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f188sm7137107f8f.48.2025.09.10.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:29:21 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/4] breaking changes: switch default initial branch name to "main"
Date: Wed, 10 Sep 2025 16:28:59 +0100
Message-ID: <cover.1757518141.git.phillip.wood@dunelm.org.uk>
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

Changes since V2:
Patch 1: reworded documentation
Patch 3: fixed typo in commit message
Patch 4: added helper function to initialise repository

I'm still on the fence about the suggestion to add some advice on how
to rename the branch after it is created in order to help users who
are following tutorials using "master" rather than "main". One the
one hand I can see that would be helpful, on the other it is pretty
annoying to everyone else. If it turns out that we want to add it we
can always do so at a later date.

V2 Cover letter:

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
https://lore.kernel.org/git/pull.1961.git.1756183921623.gitgitgadget@gmail.com

Base-Commit: f814da676ae46aac5be0a98b99373a76dee6cedb
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Finitial-branch-is-main%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/f814da676...353328c61
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/initial-branch-is-main/v3


Phillip Wood (4):
  breaking-changes: switch default branch to main
  t4013: switch default branch name to main
  t9902: switch default branch name to main
  t0613: stop setting default initial branch

 Documentation/BreakingChanges.adoc            |   6 +
 Documentation/git-init.adoc                   |  12 +-
 advice.c                                      |   2 +
 advice.h                                      |   2 +
 ci/run-build-and-tests.sh                     |   1 -
 refs.c                                        |  15 +-
 t/t0001-init.sh                               |  18 +-
 t/t0613-reftable-write-options.sh             |  24 +-
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
 107 files changed, 287 insertions(+), 244 deletions(-)
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

Range-diff against v2:
1:  6986375dc37 ! 1:  441bc5f9bcb breaking-changes: switch default branch to main
    @@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the e
      "reftable" format. Most importantly, alternative implementations of Git like
      JGit, libgit2 and Gitoxide need to support it.
      
    -+* In new repositories the default branch name will be `main`. We have been
    -+  warning that the default name will change since 675704c74dd (init: provide
    -+  useful advice about init.defaultBranch, 2020-12-11).  The new name matches
    -+  the default branch name used by many of the big Git forges.
    ++* In new repositories, the default branch name will be `main`. We have been
    ++  warning that the default name will change since 675704c74dd (init:
    ++  provide useful advice about init.defaultBranch, 2020-12-11).  The new name
    ++  matches the default branch name used in new repositories by many of the
    ++  big Git forges.
     +
      === Removals
      
2:  2a112a1b983 = 2:  f1a778e76c3 t4013: switch default branch name to main
3:  f1bf01e1322 ! 3:  8e32712a158 t9902: switch default branch name to main
    @@ Commit message
         t9902: switch default branch name to main
     
         Remove the penultimate use of "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
    -    main" in our test suite. We have slowly been removing these ever since
    -    we started to switch the default branch name used in tests to "main".
    +    master" in our test suite. We have slowly been removing these ever
    +    since we started to switch the default branch name used in tests to
    +    "main".
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
4:  c4d89c3761b ! 4:  353328c6189 t0613: stop setting default initial branch
    @@ Metadata
      ## Commit message ##
         t0613: stop setting default initial branch
     
    -    As the tests are all run in separate repositories, set the branch name
    -    to "master" when creating the repository for the tests where the result
    -    depends on the branch name. This reduceds the number of tests that
    -    depend on the default branch name being "master" and removes the last
    -    instance of a test file using "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
    -    master".
    +    As the tests are all run in separate repositories, set the branch
    +    name to "master" when creating the repository for the tests where
    +    the result depends on the branch name. In order to make it easier to
    +    change the branch name in the future a helper function is used. This
    +    reduces the number of tests that depend on the default branch name
    +    being "master" and removes the last instance of a test file using
    +    "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master".
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## t/t0613-reftable-write-options.sh ##
    @@ t/t0613-reftable-write-options.sh: export GIT_TEST_REFTABLE_AUTOCOMPACTION
      
      . ./test-lib.sh
      
    ++# Block sizes depend on the actual refs we write, so, for tests
    ++# that check block size, we force the initial branch name to be "master".
    ++init_repo () {
    ++	git init --initial-branch master repo
    ++}
    ++
      test_expect_success 'default write options' '
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    -+	# Block sizes also depend on the actual refs we write, so we force
    -+	# "master" to be the default initial branch name.
    -+	git init --initial-branch master repo &&
    ++	init_repo &&
      	(
      		cd repo &&
      		test_commit initial &&
    @@ t/t0613-reftable-write-options.sh: test_expect_success 'default write options' '
      	test_config_global core.logAllRefUpdates false &&
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    -+	git init --initial-branch master repo &&
    ++	init_repo &&
      	(
      		cd repo &&
      		test_commit initial &&
    @@ t/t0613-reftable-write-options.sh: test_expect_success 'disabled reflog writes n
      test_expect_success 'many refs results in multiple blocks' '
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    -+	git init --initial-branch master repo &&
    ++	init_repo &&
      	(
      		cd repo &&
      		test_commit initial &&
    @@ t/t0613-reftable-write-options.sh: test_expect_success 'tiny block size leads to
      	test_config_global core.logAllRefUpdates false &&
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    -+	git init --initial-branch master repo &&
    ++	init_repo &&
      	(
      		cd repo &&
      		test_commit A &&
    @@ t/t0613-reftable-write-options.sh: test_expect_success 'block size exceeding max
      test_expect_success 'restart interval at every single record' '
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    -+	git init --initial-branch master repo &&
    ++	init_repo &&
      	(
      		cd repo &&
      		test_commit initial &&
    @@ t/t0613-reftable-write-options.sh: test_expect_success 'restart interval exceedi
      	test_config_global core.logAllRefUpdates false &&
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    -+	git init --initial-branch master repo &&
    ++	init_repo &&
      	(
      		cd repo &&
      		test_commit initial &&
    @@ t/t0613-reftable-write-options.sh: test_expect_success 'object index gets writte
      	test_config_global core.logAllRefUpdates false &&
      	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    -+	git init --initial-branch master repo &&
    ++	init_repo &&
      	(
      		cd repo &&
      		test_commit initial &&
-- 
2.49.0.897.gfad3eb7d210

