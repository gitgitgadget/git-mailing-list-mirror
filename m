Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A65AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhLHTnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhLHTnb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:43:31 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC9C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:39:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so2540906wmd.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g+T+mjVqcc4o8nN2AA9rZ1K1dmuvDQnwfIvCQEkaKPM=;
        b=nNPi2IlF4c/04GJOKUAoF+PFV54gm3qlk5KYizgizazWDURibBbcSz+B8r5ua+n/sy
         8SMgR6KZpCZKGOgY3NEFnHi4M1a0tCk0u+zdDxHRzIcg0ZxxcYG+Rkmkb8OjoZLn+Yxx
         MriprkmHXqU9Fy46+8MMcdhxzC21+Fjmu7mOpGTHoBn1M149KQGcZMbmHO+YObMpyvrO
         al2K5sMt+VFNhMUER+tDZtLR9rHN64toU6XNL9tdJMZ9VO8wonuU+oKKBQHLMuZ+xuCo
         mvxYTRSXotBAGejXmJF3CVloHbK4jZzY3Kc6y0aY34sr/rN0MxyKNkaqEeR/7wwjA0vD
         foEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g+T+mjVqcc4o8nN2AA9rZ1K1dmuvDQnwfIvCQEkaKPM=;
        b=5KfGgEzXAwCRD5Biq3ZYR/uaZVZtpNzsCslYf0ZmBpIs1yhIQRPn9THDjlF1ic8szy
         BA7pCO0s5Hzfys7PxYZjGcxsCutao3Avu4TqAv2BLuoNfjiWZ0EUlKVLeLpDGUITG8mJ
         yk+RAj+3y4D/38skLJvqpfJb9z+M0VVUp7Mjm5LKZrii68o/ghXgE32RmytkfrQ0KUn5
         AzlcP3gziV2fx0KvwF3YWINVHG0jdqBdRVfjQnFlqp/Fpj751+UgEW68XXefbqkinHaQ
         h4ql7Z93ZZyX+9OXzWe5fcNDSDpfvelWThvuqeJgNlYEe1kybxLQMko/E8k4kSwqOu7h
         KLfw==
X-Gm-Message-State: AOAM530+GUrHVEkLQMsCpoF1XQnpZbGiBHtDfYqwWkYwKFb5Rb59xya+
        WJHCopjiNeyp2HgUUXs83vdDnJRoARk=
X-Google-Smtp-Source: ABdhPJyD/T9tM9KRIPn2Szg/3U07OoRPRZUebC+dCdHVjkLV6JdzIH+NJoTaDIgV4ZfGWJHyMXk4xA==
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr809849wmm.7.1638992397258;
        Wed, 08 Dec 2021 11:39:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm3606733wrn.73.2021.12.08.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:39:56 -0800 (PST)
Message-Id: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 19:39:50 +0000
Subject: [PATCH v2 0/5] Sparse index: fetch, pull, ls-files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ld/sparse-index-blame (merged with 'master' due to an
unrelated build issue).

Here are two relatively-simple patches that further the sparse index
integrations.

Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
have been an integration much earlier in the cycle. They read the index to
look for the .gitmodules file in case there are submodules that need to be
fetched. Since looking for a file by name is already protected, we only need
to disable 'command_requires_full_index' and we are done.

The 'ls-files' builtin is useful when debugging the index, and some scripts
use it, too. We are not changing the default behavior which expands a sparse
index in order to show all of the cached blobs. Instead, we add a '--sparse'
option that allows us to see the sparse directory entries upon request.
Combined with --debug, we can see a lot of index details, such as:

$ git ls-files --debug --sparse
LICENSE
  ctime: 1634910503:287405820
  mtime: 1634910503:287405820
  dev: 16777220 ino: 119325319
  uid: 501  gid: 20
  size: 1098    flags: 200000
README.md
  ctime: 1634910503:288090279
  mtime: 1634910503:288090279
  dev: 16777220 ino: 119325320
  uid: 501  gid: 20
  size: 934 flags: 200000
bin/index.js
  ctime: 1634910767:828434033
  mtime: 1634910767:828434033
  dev: 16777220 ino: 119325520
  uid: 501  gid: 20
  size: 7292    flags: 200000
examples/
  ctime: 0:0
  mtime: 0:0
  dev: 0    ino: 0
  uid: 0    gid: 0
  size: 0   flags: 40004000
package.json
  ctime: 1634910503:288676330
  mtime: 1634910503:288676330
  dev: 16777220 ino: 119325321
  uid: 501  gid: 20
  size: 680 flags: 200000


(In this example, the 'examples/' directory is sparse.)

Thanks!


Updates in v2
=============

 * Rebased onto latest ld/sparse-index-blame without issue.
 * Updated the test to use diff-of-diffs instead of a sequence of greps.
 * Added patches that remove the use of 'test-tool read-cache --table' and
   its implementation.

Derrick Stolee (5):
  fetch/pull: use the sparse index
  ls-files: add --sparse option
  t1092: replace 'read-cache --table' with 'ls-files --sparse'
  t1091/t3705: remove 'test-tool read-cache --table'
  test-read-cache: remove --table, --expand options

 Documentation/git-ls-files.txt           |   4 +
 builtin/fetch.c                          |   2 +
 builtin/ls-files.c                       |  12 ++-
 builtin/pull.c                           |   2 +
 t/helper/test-read-cache.c               |  64 ++---------
 t/t1091-sparse-checkout-builtin.sh       |  25 ++++-
 t/t1092-sparse-checkout-compatibility.sh | 129 ++++++++++++++++++++---
 t/t3705-add-sparse-checkout.sh           |   8 +-
 8 files changed, 165 insertions(+), 81 deletions(-)


base-commit: 3fffe69d24e4ecc95246766f5396303a953695ff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1080%2Fderrickstolee%2Fsparse-index%2Ffetch-pull-ls-files-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1080/derrickstolee/sparse-index/fetch-pull-ls-files-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1080

Range-diff vs v1:

 1:  451056e1a77 ! 1:  f72001638d1 fetch/pull: use the sparse index
     @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: blame' '
     - 	ensure_not_expanded blame deep/deeper1/deepest/a
     + 	done
       '
       
      +test_expect_success 'sparse index is not expanded: fetch/pull' '
 2:  e42c0feec94 ! 2:  58b5eca4835 ls-files: add --sparse option
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
      +	test_all_match git ls-files &&
      +
      +	# With --sparse, the sparse index data changes behavior.
     -+	git -C sparse-index ls-files --sparse >sparse-index-out &&
     -+	grep "^folder1/\$" sparse-index-out &&
     -+	grep "^folder2/\$" sparse-index-out &&
     ++	git -C sparse-index ls-files >dense &&
     ++	git -C sparse-index ls-files --sparse >sparse &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	@@ -13,13 +13,9 @@
     ++	 e
     ++	 folder1-
     ++	 folder1.x
     ++	-folder1/0/0/0
     ++	-folder1/0/1
     ++	-folder1/a
     ++	+folder1/
     ++	 folder10
     ++	-folder2/0/0/0
     ++	-folder2/0/1
     ++	-folder2/a
     ++	+folder2/
     ++	 g
     ++	-x/a
     ++	+x/
     ++	 z
     ++	EOF
     ++
     ++	diff -u dense sparse | tail -n +3 >actual &&
     ++	test_cmp expect actual &&
      +
      +	# With --sparse and no sparse index, nothing changes.
     -+	git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
     -+	grep "^folder1/0/0/0\$" sparse-checkout-out &&
     -+	! grep "/\$" sparse-checkout-out &&
     ++	git -C sparse-checkout ls-files >dense &&
     ++	git -C sparse-checkout ls-files --sparse >sparse &&
     ++	test_cmp dense sparse &&
      +
      +	write_script edit-content <<-\EOF &&
      +	mkdir folder1 &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
      +	git -C sparse-index ls-files --sparse --modified >sparse-index-out &&
      +	test_must_be_empty sparse-index-out &&
      +
     -+	run_on_sparse git sparse-checkout add folder1 &&
     ++	# Add folder1 to the sparse-checkout cone and
     ++	# check that ls-files shows the expanded files.
     ++	test_sparse_match git sparse-checkout add folder1 &&
      +	test_sparse_match git ls-files --modified &&
     -+	grep "^folder1/a\$" sparse-checkout-out &&
     -+	grep "^folder1/a\$" sparse-index-out &&
      +
     -+	# Double-check index expansion
     ++	git -C sparse-index ls-files >dense &&
     ++	git -C sparse-index ls-files --sparse >sparse &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	@@ -17,9 +17,7 @@
     ++	 folder1/0/1
     ++	 folder1/a
     ++	 folder10
     ++	-folder2/0/0/0
     ++	-folder2/0/1
     ++	-folder2/a
     ++	+folder2/
     ++	 g
     ++	-x/a
     ++	+x/
     ++	 z
     ++	EOF
     ++
     ++	diff -u dense sparse | tail -n +3 >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	# Double-check index expansion is avoided
      +	ensure_not_expanded ls-files --sparse
      +'
      +
 -:  ----------- > 3:  5ffae2a03ae t1092: replace 'read-cache --table' with 'ls-files --sparse'
 -:  ----------- > 4:  b98e5e6d2bc t1091/t3705: remove 'test-tool read-cache --table'
 -:  ----------- > 5:  f31a24eeb9b test-read-cache: remove --table, --expand options

-- 
gitgitgadget
