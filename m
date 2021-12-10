Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6AFC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhLJPQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhLJPQu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:16:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC7C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so15472593wrw.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bECYZ/uhDdnhpfTRjA6PeL0JZAwFZQyUvUJT4i+A2Jc=;
        b=KA4PdN70GOzeWro15ywGfJc95NMpLeuwUMABgKQplvcN7LfG93z8Vro/i7bzTUy+7C
         5hM1eNjSE3KAxRARONwpXod84bYoFoo3E/JMS/yvgUt0zeKUtHXGXTrOtrQyS33P5k4Z
         1Vopb+vrvLflk88uM7EORLqoKYO+jBtNTBRPvdsG2WLZM6K6VSHKdvxfZ2dsCDctCIJY
         0siMuSnphYgy1923lmYicLw9fvJsXNeQir6nIeN2u3r0scxuHSWYZgQsw/2IEFj7lX8h
         tW7tF8pZ3YaFE58k3967bQJaAs/vwnILFtYxkDXmoeByhjCPv6pIEpv9TL1jQyyTh3bx
         3Ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bECYZ/uhDdnhpfTRjA6PeL0JZAwFZQyUvUJT4i+A2Jc=;
        b=BdH0pSWe3Ntiwez8JFojLFLNws8IQUqKnozVPJ1BZGEM5JkmiM/qminKm2n/4XpLhZ
         2qK27ViGhJfybIrc2LnfXi/Me+GE6voKhbHO3E47ayFqM+wG2BVGw+JnvA1BPx7iKNhP
         CBLzMxVwHKRu5EiXK2riVUeSVxKJnb3MD9G9FlhGImWIibYCkA+4upqsrT0Bxt6Lt/eX
         /j8zj3bghBvQUUMt+yskZBByqyVsmiKCqRsb15oEDpyIRy0d2zAg32GiOiC0G73L24F9
         0WuSu2uwnc+NL1Sb3svveJV2qJhhWj7ImxnlKSGgTc9zHug3cQiWvwPnmyCtqSWc5xw/
         tYpg==
X-Gm-Message-State: AOAM530FXLmgET2VWvOjuKA7LmRCWcqBV4zNbwlSZRZ1ExtdOy+zrAL9
        gmvtHp0MloI/iOzEg54tpHBrNNWAy6U=
X-Google-Smtp-Source: ABdhPJxYUkFanOC2JeBYRy/qdoWADzGfFKsmd9w3BbB538ekpJBv7k+838m2lfUW3VsuUa1NIzyiTw==
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr14138561wrg.571.1639149193692;
        Fri, 10 Dec 2021 07:13:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm3276425wmq.46.2021.12.10.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:13:13 -0800 (PST)
Message-Id: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:13:07 +0000
Subject: [PATCH v3 0/5] Sparse index: fetch, pull, ls-files
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


Updates in v3
=============

 * Fixed typo in commit message.
 * Added comments around doing strange things in an ls-files test.
 * Fixed adjacent typo in a test comment.

Derrick Stolee (5):
  fetch/pull: use the sparse index
  ls-files: add --sparse option
  t1092: replace 'read-cache --table' with 'ls-files --sparse'
  t1091/t3705: remove 'test-tool read-cache --table'
  test-read-cache: remove --table, --expand options

 Documentation/git-ls-files.txt           |   4 +
 builtin/fetch.c                          |   2 +
 builtin/ls-files.c                       |  12 +-
 builtin/pull.c                           |   2 +
 t/helper/test-read-cache.c               |  64 ++---------
 t/t1091-sparse-checkout-builtin.sh       |  25 ++++-
 t/t1092-sparse-checkout-compatibility.sh | 137 ++++++++++++++++++++---
 t/t3705-add-sparse-checkout.sh           |   8 +-
 8 files changed, 172 insertions(+), 82 deletions(-)


base-commit: 3fffe69d24e4ecc95246766f5396303a953695ff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1080%2Fderrickstolee%2Fsparse-index%2Ffetch-pull-ls-files-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1080/derrickstolee/sparse-index/fetch-pull-ls-files-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1080

Range-diff vs v2:

 1:  f72001638d1 = 1:  f72001638d1 fetch/pull: use the sparse index
 2:  58b5eca4835 ! 2:  b81174ba54b ls-files: add --sparse option
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
      +	git -C sparse-checkout ls-files --sparse >sparse &&
      +	test_cmp dense sparse &&
      +
     ++	# Set up a strange condition of having a file edit
     ++	# outside of the sparse-checkout cone. This is just
     ++	# to verify that sparse-checkout and sparse-index
     ++	# behave the same in this case.
      +	write_script edit-content <<-\EOF &&
      +	mkdir folder1 &&
      +	echo content >>folder1/a
      +	EOF
      +	run_on_sparse ../edit-content &&
      +
     -+	# ls-files does not notice modified files whose
     -+	# cache entries are marked SKIP_WORKTREE.
     ++	# ls-files does not currently notice modified files whose
     ++	# cache entries are marked SKIP_WORKTREE. This may change
     ++	# in the future, but here we test that sparse index does
     ++	# not accidentally create a change of behavior.
      +	test_sparse_match git ls-files --modified &&
      +	test_must_be_empty sparse-checkout-out &&
      +	test_must_be_empty sparse-index-out &&
 3:  5ffae2a03ae ! 3:  2a6a1c5a39c t1092: replace 'read-cache --table' with 'ls-files --sparse'
     @@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_unstaged () {
       			|| return 1
       	done &&
       
     - 	# Disabling the sparse-index removes tree entries with full ones
     +-	# Disabling the sparse-index removes tree entries with full ones
     ++	# Disabling the sparse-index replaces tree entries with full ones
       	git -C sparse-index sparse-checkout init --no-sparse-index &&
      -
      -	test-tool -C sparse-index read-cache --table >cache &&
 4:  b98e5e6d2bc ! 4:  f0143686754 t1091/t3705: remove 'test-tool read-cache --table'
     @@ Commit message
          t3705-add-sparse-checkout.sh.
      
          The important changes are due to the different output format. In t3705,
     -    wWe need to use the '--stage' output to get a file mode and OID, but
     +    we need to use the '--stage' output to get a file mode and OID, but
          it also includes a stage value and drops the object type. This leads
          to some differences in how we handle looking for specific entries.
      
 5:  f31a24eeb9b = 5:  9227dc54165 test-read-cache: remove --table, --expand options

-- 
gitgitgadget
