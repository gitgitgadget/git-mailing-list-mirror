Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CFFC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7033E6101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhJLOc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbhJLOcz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 10:32:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FDCC06161C
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 07:30:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so67420573wrd.13
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZbdTjPo558N/Qat9RyOXvS6B+u9XVJwMIttcEprHBc=;
        b=eorcnjqsUdztSHMSGJihFDpA7hkoTwRk01IyXjJgWXthb06W8Ov47HllLG7TNKKUDn
         QoX9V+YX2FuzaslIDrbE4IPbsqJlpKeU3ymgtIh83jWkyk3M+HzxdRR/DdyDvnObLH3T
         VMjRIvBOMMNqreRhe3cgQrtBGcsv0rVZf8CQ7DoqbbQplQrsSiggoWuvdbB+IQ2RQ/Pf
         hU0sT7PkrDq5bAZ0qRWur0hwEn2KzCjt1dHdlY7r0UOrnpckzY5v46cHb56EHt4Ce7LU
         knDFwI2/HobPLoUdGShvvDeUClV9jVb01pyIF9hmG1ragRDD0rnTLsLk8/+D0/6CfhY3
         +0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZbdTjPo558N/Qat9RyOXvS6B+u9XVJwMIttcEprHBc=;
        b=a8ywgb7kBkkHQCvq0RfIs0OQSpLx5tUXtF9pR0VMJD+ve7MvzIJwXyU931Ll8eDjOJ
         7iEKGZ3tqe4q8X3hLo47jzF+hx/oFoR+WOxk/pUqlCiMgkVAjjwgdZAlXsr2GYmwgvar
         csgac6pnOuywKi40qZTTsjJx2FFgRuR1GyX/wWviS5XmxM/vjQCzFU0YU1w9OXlHT/4l
         mhOJMIBsqOnJenfAq5WfziidRqE/B1sZteLf5ADnVU8ZGEcHFgie55PL5u+pfad67jeK
         +ayfGP34SmrtFiSBxhPKQrD5vwyYGXjro2SbzDlh9vHeVka7rsqYh14lqVlFRuqDCCpZ
         zZUQ==
X-Gm-Message-State: AOAM531IxBCmEMVhgoglCwQ8YGrubaNWX4IVVY3/V7ltWvvulOqhII/k
        0/uEdUIx77UWrlcWH1elYe6Gajlzrdyi9Q==
X-Google-Smtp-Source: ABdhPJzhuq/IHRXB2SkjvjIt7zwVgLOe50QwwqSXHn19fFpG8gSkDJ9AaYqb8ZgzAjxwv3GjaOpNxg==
X-Received: by 2002:adf:ff86:: with SMTP id j6mr28680691wrr.59.1634049052044;
        Tue, 12 Oct 2021 07:30:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm3149791wmi.1.2021.10.12.07.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 07:30:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] commit: fix duplication regression in permission error output
Date:   Tue, 12 Oct 2021 16:30:47 +0200
Message-Id: <cover-v2-0.2-00000000000-20211012T142950Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <patch-2.2-56b20f6024b-20211009T133354Z-avarab@gmail.com>
References: <patch-2.2-56b20f6024b-20211009T133354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2 of a series that fixes duplicate permission output whe we write
trees. Before:

    $ git commit -m"add another one"
    error: insufficient permission for adding an object to repository database .git/objects
    error: insufficient permission for adding an object to repository database .git/objects
    error: Error building trees

After we only emit that "insufficient permission" line once.

The only change since v1 is to make 1/2 and 2/2 flip a
"test_expect_failure" to a "test_expect_success".

Ævar Arnfjörð Bjarmason (2):
  unwritable tests: assert exact error output
  commit: fix duplication regression in permission error output

 cache-tree.c          |  5 +++--
 cache.h               |  1 +
 object-file.c         | 20 ++++++++++--------
 object-store.h        | 10 +++++++--
 t/t0004-unwritable.sh | 47 +++++++++++++++++++++++++++++++++++++++----
 5 files changed, 67 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  a5ef8ea47f4 ! 1:  74bc5568c88 unwritable tests: assert exact error output
    @@ Commit message
         of these error messages twice, let's assert what the output from "git
         commit" and friends is now in the case of permission errors.
     
    +    As noted in [1] using test_expect_failure to mark up a TODO test has
    +    some unexpected edge cases, e.g. we don't want to break --run=3 by
    +    skipping the "test_lazy_prereq" here. This pattern allows us to test
    +    just the test_cmp (and the "cat", which shouldn't fail) with the added
    +    "test_expect_failure", we'll flip that to a "test_expect_success" in
    +    the next commit.
    +
    +    1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/T/#u
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0004-unwritable.sh ##
    @@ t/t0004-unwritable.sh: test_expect_success setup '
      	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
      	chmod a-w .git/objects .git/objects/?? &&
     -	test_must_fail git write-tree
    ++	test_must_fail git write-tree 2>out.write-tree
    ++'
     +
    ++test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
    ++test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
     +	cat >expect <<-\EOF &&
     +	error: insufficient permission for adding an object to repository database .git/objects
     +	fatal: git-write-tree: error building trees
     +	EOF
    -+	test_must_fail git write-tree 2>actual &&
    -+	test_cmp expect actual
    ++	test_cmp expect out.write-tree
      '
      
    - test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository' '
    + test_expect_success POSIXPERM,SANITY,!SANITIZE_LEAK 'commit should notice unwritable repository' '
      	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
      	chmod a-w .git/objects .git/objects/?? &&
     -	test_must_fail git commit -m second
    ++	test_must_fail git commit -m second 2>out.commit
    ++'
     +
    ++test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
    ++test_expect_failure COMMIT_OUT 'commit output on unwritable repository' '
     +	cat >expect <<-\EOF &&
     +	error: insufficient permission for adding an object to repository database .git/objects
    -+	error: insufficient permission for adding an object to repository database .git/objects
     +	error: Error building trees
     +	EOF
    -+	test_must_fail git commit -m second 2>actual &&
    -+	test_cmp expect actual
    ++	test_cmp expect out.commit
      '
      
      test_expect_success POSIXPERM,SANITY 'update-index should notice unwritable repository' '
    @@ t/t0004-unwritable.sh: test_expect_success setup '
      	echo 6O >file &&
      	chmod a-w .git/objects .git/objects/?? &&
     -	test_must_fail git update-index file
    ++	test_must_fail git update-index file 2>out.update-index
    ++'
     +
    ++test_lazy_prereq UPDATE_INDEX_OUT 'test -e "$TRASH_DIRECTORY"/out.update-index'
    ++test_expect_success UPDATE_INDEX_OUT 'update-index output on unwritable repository' '
     +	cat >expect <<-\EOF &&
     +	error: insufficient permission for adding an object to repository database .git/objects
     +	error: file: failed to insert into database
     +	fatal: Unable to process path file
     +	EOF
    -+	test_must_fail git update-index file 2>actual &&
    -+	test_cmp expect actual
    ++	test_cmp expect out.update-index
      '
      
      test_expect_success POSIXPERM,SANITY 'add should notice unwritable repository' '
    @@ t/t0004-unwritable.sh: test_expect_success setup '
      	echo b >file &&
      	chmod a-w .git/objects .git/objects/?? &&
     -	test_must_fail git add file
    ++	test_must_fail git add file 2>out.add
    ++'
     +
    ++test_lazy_prereq ADD_OUT 'test -e "$TRASH_DIRECTORY"/out.add'
    ++test_expect_success ADD_OUT 'add output on unwritable repository' '
     +	cat >expect <<-\EOF &&
     +	error: insufficient permission for adding an object to repository database .git/objects
     +	error: file: failed to insert into database
     +	error: unable to index file '\''file'\''
     +	fatal: updating files failed
     +	EOF
    -+	test_must_fail git add file 2>actual &&
    -+	test_cmp expect actual
    ++	test_cmp expect out.add
      '
      
      test_done
2:  56b20f6024b ! 2:  e6cd47355d5 commit: fix duplication regression in permission error output
    @@ object-store.h: int hash_object_file(const struct git_hash_algo *algo, const voi
      			       const char *type, struct object_id *oid,
     
      ## t/t0004-unwritable.sh ##
    -@@ t/t0004-unwritable.sh: test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository
    +@@ t/t0004-unwritable.sh: test_expect_success POSIXPERM,SANITY,!SANITIZE_LEAK 'commit should notice unwrit
    + '
      
    + test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
    +-test_expect_failure COMMIT_OUT 'commit output on unwritable repository' '
    ++test_expect_success COMMIT_OUT 'commit output on unwritable repository' '
      	cat >expect <<-\EOF &&
      	error: insufficient permission for adding an object to repository database .git/objects
    --	error: insufficient permission for adding an object to repository database .git/objects
      	error: Error building trees
    - 	EOF
    - 	test_must_fail git commit -m second 2>actual &&
-- 
2.33.0.1567.g7b23ce7ed9e

