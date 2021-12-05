Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67336C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 19:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhLETiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 14:38:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57701 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhLETiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 14:38:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF90F173EED;
        Sun,  5 Dec 2021 14:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TuSy3DZCOm/SpMEA8tloaoNqqZr9l9EGLfiRi+
        m0RKU=; b=cxizxz5vVrYkbEN2Xn+jj6ZG5nMV7k6MxDMdFUHS3hTAElVsg0LsBq
        Rx7TkRvXL9SkPJWaL5bvHiiVCLn8DViL7g9J6n55zEptfFbYZgcbmQefhctgQelm
        xb0nZ7NlSwp44/dKPy2K5SCqqNmiDiuTv+hI8016TzjTQbJXiDyoo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C95F5173EEC;
        Sun,  5 Dec 2021 14:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD73A173EDB;
        Sun,  5 Dec 2021 14:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests: set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME only
 when needed
References: <pull.1089.git.1638524353230.gitgitgadget@gmail.com>
Date:   Sun, 05 Dec 2021 11:34:49 -0800
In-Reply-To: <pull.1089.git.1638524353230.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 03 Dec 2021 09:39:13
        +0000")
Message-ID: <xmqqbl1uluau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69EABF00-5602-11EC-BDF5-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> A couple of test scripts have actually been adapted to accommodate for a
> configurable default branch name, but they still overrode it via the
> `GIT_TEST_*` variable. Let's drop that override where possible.

Nice clean-up.  Will apply.  Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Drop GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME where possible
>     
>     We still set this variable in quite a couple of test scripts. Some of
>     them do not actually need it anymore, though.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1089%2Fdscho%2Ft3404-and-default-branch-name-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1089/dscho/t3404-and-default-branch-name-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1089
>
>  t/t1022-read-tree-partial-clone.sh | 3 ---
>  t/t1400-update-ref.sh              | 3 ---
>  t/t3201-branch-contains.sh         | 3 ---
>  t/t3203-branch-output.sh           | 3 ---
>  t/t3205-branch-color.sh            | 3 ---
>  t/t3404-rebase-interactive.sh      | 2 --
>  t/t5310-pack-bitmaps.sh            | 2 --
>  t/t5505-remote.sh                  | 3 ---
>  t/t5510-fetch.sh                   | 3 ---
>  t/t5526-fetch-submodules.sh        | 3 ---
>  t/t5703-upload-pack-ref-in-want.sh | 3 ---
>  t/t6300-for-each-ref.sh            | 3 ---
>  t/t6302-for-each-ref-filter.sh     | 3 ---
>  t/t7064-wtstatus-pv2.sh            | 4 ----
>  t/t9151-svn-mergeinfo.sh           | 3 ---
>  t/t9603-cvsimport-patchsets.sh     | 3 ---
>  t/t9902-completion.sh              | 3 ---
>  17 files changed, 50 deletions(-)
>
> diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
> index a763e27c7da..a9953b6a71c 100755
> --- a/t/t1022-read-tree-partial-clone.sh
> +++ b/t/t1022-read-tree-partial-clone.sh
> @@ -4,9 +4,6 @@ test_description='git read-tree in partial clones'
>  
>  TEST_NO_CREATE_REPO=1
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  
>  test_expect_success 'read-tree in partial clone prefetches in one batch' '
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 0d4f73acaa8..406f5938fbd 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -4,9 +4,6 @@
>  #
>  
>  test_description='Test git update-ref and basic ref logging'
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  
>  Z=$ZERO_OID
> diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
> index 349a810cee1..800fc33165a 100755
> --- a/t/t3201-branch-contains.sh
> +++ b/t/t3201-branch-contains.sh
> @@ -2,9 +2,6 @@
>  
>  test_description='branch --contains <commit>, --no-contains <commit> --merged, and --no-merged'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  
>  test_expect_success setup '
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 6e94c6db7b5..d34d77f8934 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -1,9 +1,6 @@
>  #!/bin/sh
>  
>  test_description='git branch display tests'
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>  
> diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
> index 6a521c1a3e5..0b61da92b37 100755
> --- a/t/t3205-branch-color.sh
> +++ b/t/t3205-branch-color.sh
> @@ -1,9 +1,6 @@
>  #!/bin/sh
>  
>  test_description='basic branch output coloring'
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 12eb2269576..0baa68e9b4f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -25,8 +25,6 @@ Initial setup:
>   where A, B, D and G all touch file1, and one, two, three, four all
>   touch file "conflict".
>  '
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index dcf03d324a2..b8a29950cc2 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -1,8 +1,6 @@
>  #!/bin/sh
>  
>  test_description='exercise basic bitmap functionality'
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-bitmap.sh
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index e6e3c8f552c..7ce1a28ef65 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -2,9 +2,6 @@
>  
>  test_description='git remote porcelain-ish'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  
>  setup_repository () {
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index a0faf0dd949..8c33755c267 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -5,9 +5,6 @@ test_description='Per branch config variables affects "git fetch".
>  
>  '
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-bundle.sh
>  
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 2dc75b80db8..840c89cc8b9 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -3,9 +3,6 @@
>  
>  test_description='Recursive "git fetch" for submodules'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
>  export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
>  
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index 220098523a6..9d6cd7d9864 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -2,9 +2,6 @@
>  
>  test_description='upload-pack ref-in-want'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  
>  get_actual_refs () {
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 9f2c706c12a..6aa9fb17ea3 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -5,9 +5,6 @@
>  
>  test_description='for-each-ref test'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 1537aa21798..1ce5f490e99 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -2,9 +2,6 @@
>  
>  test_description='test for-each-refs usage of ref-filter APIs'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  
> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> index 47fc21d9623..20a0d2afc2a 100755
> --- a/t/t7064-wtstatus-pv2.sh
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -4,10 +4,6 @@ test_description='git status --porcelain=v2
>  
>  This test exercises porcelain V2 output for git status.'
>  
> -
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>  
>  
> diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
> index 1fbe84feb16..c93a5beab25 100755
> --- a/t/t9151-svn-mergeinfo.sh
> +++ b/t/t9151-svn-mergeinfo.sh
> @@ -5,9 +5,6 @@
>  
>  test_description='git-svn svn mergeinfo properties'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./lib-git-svn.sh
>  
>  test_expect_success 'load svn dump' "
> diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
> index 0e9daa5768c..19f38f78f2b 100755
> --- a/t/t9603-cvsimport-patchsets.sh
> +++ b/t/t9603-cvsimport-patchsets.sh
> @@ -12,9 +12,6 @@
>  # bug.
>  
>  test_description='git cvsimport testing for correct patchset estimation'
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./lib-cvs.sh
>  
>  setup_cvs_test_repository t9603
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 518203fbe07..0f28c4ad940 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -5,9 +5,6 @@
>  
>  test_description='test bash completion'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./lib-bash.sh
>  
>  complete ()
>
> base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
