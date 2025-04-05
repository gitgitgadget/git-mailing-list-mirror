Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992551624DD
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891382; cv=none; b=ur3gPCRhURme+a3iIkwx2QBqdYmrt8ZLFcB1t+Odq+T2J8Auqa7X7P28MMBBxrUwdilxl2cfLgkfvm0vjM9ku9e2MKArM7YJHL3CDakIYPyAzTh31SDQv9VfyxIE8W4OKKcJL39WSy4kimErVz0QqUTbk5Vaq9G4QOnFDzU6AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891382; c=relaxed/simple;
	bh=6bJbf1ijLV2la6yTB3IT4NpqTBCRN+Ge/kQ2bu8iMek=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EkEtgKF1c7Kf4Uxm1G7PtK5VZ6vGQIPSJY/2NzG3OXPy15mt17LY0ItVN+ffoXEHU9yMb6i7JV2zJqkL5xOfI/peF1uP5/WOsf9jkK504/+U3BUPHAdTyEixQlctS/G9LGTlQthfsZkeZoogsLfnI4KeWz59L4dnIPA/73c2hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS1ByjGg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS1ByjGg"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c1efc4577so1724633f8f.0
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743891377; x=1744496177; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBI10z9zrxJTTGQCwE+mTXwX+GIsZOIZtrAyQ+/VNoM=;
        b=MS1ByjGgH6bbxL+/EC/QyOOGEZtp0r+duLscwppIFJh7NzNJ3g7EZd5BmXddW/dbep
         luBPHyI4fT/ukFwW1qgnYaa8pBrcenL88ejwb5vk2AnPG3vO/fNBpJtuKHKYIEu7vPa+
         qrJaM2xhilmct6gOAH7RZE4ASivcVVfyXyB/EkS5r/oSH2GpDdjHzRWFATjt9uJ3XrYh
         l9f1cLfG69MXefQPsQo49S96g8QIBYckQk98SZqNrgZqdr6VeaBW5UoKaJaisQUSSxa5
         FInCy6+WO5LcSJ3K9te85Hp4NwpbFAcbK8dMBdCPUY79Bqu3+ptShV2jKM0H3XMeCB+2
         rA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891377; x=1744496177;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBI10z9zrxJTTGQCwE+mTXwX+GIsZOIZtrAyQ+/VNoM=;
        b=BDM6uR1D1U+E6wIlVAKrNh9855NWB8uki0DPl72oT/LtsgRhAxuCP/3+UKIIb0J6p+
         JVRenuUWIA6+6IgiPeSlnN0hILRLnACuyxq1M0kd9F6hQKekKhSw/coscPBLkaweLTIr
         zWPuumiw/+YA97uU3QdAn46Z/34uRIv0tHuwJoTs4eomgKEvoyHzfj0EegtlbtwJpZ+P
         NifJ+K+7N3nxE3Ewjl/C8fw+UrlHQd0vlGIsbhw/pGLehzX7OpvE1/DVBLdK1mgEkcU1
         57i15mWfkQf9ipqMaPHTUOcaGmdLQnvqDcNezAqqB/N3s5mR4vJ2zb9CqsIw0ALmF2TF
         EvBw==
X-Gm-Message-State: AOJu0Yx5X34kTsG3xrFMWMsilPXEKzj+WVYUxyVNLEzntXWI0ipoPQrj
	TAsA95X15jamzRL7yoTN3RhKwjDf2o9fUcR3WZ/8bzeQEHzVZFLUPAPl4Q==
X-Gm-Gg: ASbGnctpeT8XeFQGSGuIXXiD420sR3cQ8NIaSDNZjg4wxdEyYyCf8/qf14FWr3MWstQ
	w6hImEq/lcyY5wKL1tpsxhBegqqEflCjU2kP6Btst5qGe9UDRdwuIrP9WVLX9kACOujToubJnjG
	gs4Jho6xJ6yojUMjYnnoyGxKGiSQeHawp1iYP3DAXDbNqerJBZlbt/iR9m6+9Jfzs9VUDelO2WE
	XKG1vLE86TkggISqI91wPp01JOoS29c4GBbowR2a48hwB2s3Gm3+7IZuoo2j+a/QTzUHEsZnK+y
	+Dt6DMWGmpe+mEhcxzmGkf6G1RfDuyLUx87NpPWykVoAZw==
X-Google-Smtp-Source: AGHT+IHl2If98IZEHKgdYoYVCTwr6H+lBrDOx+j4rPuaSxIuFe0hi1gUgKpfPVd7GbP04PCZHVcb/w==
X-Received: by 2002:a5d:6d8b:0:b0:391:489a:ce12 with SMTP id ffacd0b85a97d-39cba9324c4mr6276996f8f.26.1743891377436;
        Sat, 05 Apr 2025 15:16:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bf258sm83601125e9.23.2025.04.05.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:16:16 -0700 (PDT)
Message-Id: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 22:16:06 +0000
Subject: [PATCH v2 0/8] Debug merge-recursive.[ch]
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v1:

 * fixed a couple of typos in commit messages

Original cover letter:

As a wise man once told me, "Deleted code is debugged code!"

This series does some preparation, then moves the code shared between
merge-recursive and merge-ort from the former to the latter, and then debugs
the remainder of merge-recursive.[ch].

Series overview:

 * Patches 1-5: Preparation; switch remaining callers of
   merge-recursive.[ch] functions to merge-ort equivalents, and add sole
   remaining missing feature (diff-algorithm selection)
 * Patch 6: Nuke merge-recursive.[ch]
 * Patch 7-8: Cleanup testsuite; we don't need GIT_TEST_MERGE_ALGORITHM
   anymore

While the diffstat might look large, the non-test code changes are actually
pretty small. The drivers of the big diffstat are:

 * We move a significant chunk of shared code from merge-recursive.[ch] to
   merge-ort.[ch], without modifying it
 * We delete (the remainder of) merge-recursive.[ch]
 * We rip out all the temporary GIT_TEST_MERGE_ALGORITHM stuff designed to
   let us reuse tests between recursive and ort

Elijah Newren (8):
  checkout: replace merge_trees() with merge_ort_nonrecursive()
  builtin/merge-recursive: switch to using merge_ort_generic()
  merge-ort: enable diff-algorithms other than histogram
  sequencer: switch non-recursive merges over to ort
  merge, sequencer: switch recursive merges over to ort
  merge-recursive.[ch]: thoroughly debug these
  tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
  builtin/{merge,rebase,revert}: remove GIT_TEST_MERGE_ALGORITHM

 Documentation/merge-strategies.adoc           |   51 +-
 Documentation/technical/sparse-checkout.adoc  |    2 -
 Makefile                                      |    1 -
 builtin/checkout.c                            |   10 +-
 builtin/merge-recursive.c                     |    4 +-
 builtin/merge.c                               |   23 +-
 builtin/rebase.c                              |    5 -
 builtin/revert.c                              |    2 -
 ci/run-build-and-tests.sh                     |    1 -
 merge-ort-wrappers.h                          |    2 +-
 merge-ort.c                                   |  162 +-
 merge-ort.h                                   |   60 +-
 merge-recursive.c                             | 4079 -----------------
 merge-recursive.h                             |  132 -
 meson.build                                   |    1 -
 sequencer.c                                   |   58 +-
 t/lib-merge.sh                                |   13 -
 t/t1092-sparse-checkout-compatibility.sh      |    2 -
 t/t2501-cwd-empty.sh                          |    2 -
 t/t3512-cherry-pick-submodule.sh              |    5 -
 t/t3513-revert-submodule.sh                   |    4 -
 t/t4069-remerge-diff.sh                       |    7 -
 t/t4301-merge-tree-write-tree.sh              |    7 -
 t/t5572-pull-submodule.sh                     |    5 -
 t/t6400-merge-df.sh                           |   14 +-
 t/t6402-merge-rename.sh                       |  125 +-
 t/t6404-recursive-merge.sh                    |   21 +-
 t/t6406-merge-attr.sh                         |    7 +-
 t/t6416-recursive-corner-cases.sh             |  194 +-
 t/t6421-merge-partial-clone.sh                |    7 +-
 t/t6422-merge-rename-corner-cases.sh          |   31 +-
 t/t6423-merge-rename-directories.sh           |  517 +--
 t/t6424-merge-unrelated-index-changes.sh      |    8 +-
 t/t6426-merge-skip-unneeded-updates.sh        |    4 +-
 t/t6428-merge-conflicts-sparse.sh             |    2 -
 t/t6430-merge-recursive.sh                    |   46 +-
 t/t6434-merge-recursive-rename-options.sh     |   16 +-
 t/t6436-merge-overwrite.sh                    |   17 +-
 t/t6437-submodule-merge.sh                    |   65 +-
 t/t6438-submodule-directory-file-conflicts.sh |    5 -
 t/t6439-merge-co-error-msgs.sh                |    2 +-
 t/t7402-submodule-rebase.sh                   |    7 +-
 t/t7602-merge-octopus-many.sh                 |    9 +-
 t/t7610-mergetool.sh                          |   40 +-
 t/t7615-diff-algo-with-mergy-operations.sh    |    2 -
 t/test-lib.sh                                 |    2 -
 46 files changed, 538 insertions(+), 5241 deletions(-)
 delete mode 100644 merge-recursive.c
 delete mode 100644 merge-recursive.h
 delete mode 100644 t/lib-merge.sh


base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1898%2Fnewren%2Fendit-quote-debugging-unquote-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1898/newren/endit-quote-debugging-unquote-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1898

Range-diff vs v1:

 1:  0e150ee9065 = 1:  0e150ee9065 checkout: replace merge_trees() with merge_ort_nonrecursive()
 2:  44be41da6c5 ! 2:  b093d74968b builtin/merge-recursive: switch to using merge_ort_generic()
     @@ Commit message
            adaptation from merge_recursive_internal(); see 8119214f4e70
            (merge-ort: implement merge_incore_recursive(), 2020-12-16).
      
     -    * t6436: This test is built entirely around rename/delete conflicts,
     +    * t6434: This test is built entirely around rename/delete conflicts,
            which had a suboptimal handling under merge-recursive.  As explained
            in more detail in commits 1f3c9ba707 ("t6425: be more flexible with
            rename/delete conflict messages", 2020-08-10) and 727c75b23f ("t6404,
 3:  3945c471b0c = 3:  cf774437123 merge-ort: enable diff-algorithms other than histogram
 4:  39ff4860fcd = 4:  6203589ac17 sequencer: switch non-recursive merges over to ort
 5:  91398ffd1e1 = 5:  8821f22d5ea merge, sequencer: switch recursive merges over to ort
 6:  6ef536cdbcd = 6:  770f611c2b6 merge-recursive.[ch]: thoroughly debug these
 7:  0b6bcd225dc ! 7:  a6501ee85fa tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
     @@ Metadata
       ## Commit message ##
          tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
      
     -    Both of these existed to allow use to reuse all the merge-related tests
     +    Both of these existed to allow us to reuse all the merge-related tests
          in the testsuite while easily flipping between the 'recursive' and the
          'ort' backends.  Now that we have removed merge-recursive and remapped
          'recursive' to mean 'ort', we don't need this scaffolding anymore.
 8:  3abcfe6faf0 = 8:  d1dea986646 builtin/{merge,rebase,revert}: remove GIT_TEST_MERGE_ALGORITHM

-- 
gitgitgadget
