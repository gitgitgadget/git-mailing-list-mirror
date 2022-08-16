Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE049C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiHPPwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiHPPvr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 11:51:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B840571
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 08:48:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so17762917pjm.3
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XuMDwdnG22NVA5SGjrNhdEbBOMB7fOxuncIxAeB2u6U=;
        b=deKPeXIrccpI5e76uZ6s+18YCgMGltf/mda0jGIHGo33BVHx5TlScniEgUoGK8daJo
         NhSWB4QUnQ61RRoZS6PvWHmpQvS02xHXaHujyFOMeh0VyuuA+R01KDpxkkQLY2rMS8tB
         XBMaSf0ztIKv8PwI/oR2JdvHFkR7B66b88tNrkhonpewiaJYVcKxp/639swf8SZ5qDxl
         vuzHxPfY8VcSopR3yZm0sQZBNBXUHvOW+3jBeTF+pSaWxjcCNqXw8C7Kpx0/d+8sCa4w
         Lm39vlPqsXO+oO0RfIFGSL3/2Q6qgaycXpXGU/v0aSi1HtaosKwW2mNABvjDizMc/4x1
         426g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XuMDwdnG22NVA5SGjrNhdEbBOMB7fOxuncIxAeB2u6U=;
        b=fMS3TJTy3AA5UUdxQS0HsDeBgCAXkrvGISz5Bif2FFc3JaIANYHThsdegtjADhvu2N
         1w4p4bNc8Tkm/5mEyasUxiFwvfL4b8PrFzrhqey7uFhKsDG1jcSmxxxA7WCPes2CWXLq
         qxp5Vba0/53srrWYjcr9DlBkhhyO2nnHPtucQm3qjphVgc5EHyFxHAZlTUXrWT9agSPr
         dKDA+yB+gAMWib57VzyEfRNr402UkklovnByg49D23bS69q/8vHqU0/xnyZrcpyhplfQ
         5dWiejxI7z5o+a0XtNnenWdcfDjTcRE3u0rXdmuM/BdeL49zQECE/HxhscLhkChWkBt0
         lmHQ==
X-Gm-Message-State: ACgBeo33rfONQzqAUDaomJTA+0cehZ+qhZZIWqxMKAZSPdJtnaSHChcw
        zgqCFRYytngTA/hu+MV6N8DW
X-Google-Smtp-Source: AA6agR5UV7ui/414hZ9X3ebMvKS4WqUAFLpDAPeVHzdog2D3pIAq4G9ejCpyALOD6z6auQ0wp+0i+Q==
X-Received: by 2002:a17:90a:ca04:b0:1fa:9a6c:793c with SMTP id x4-20020a17090aca0400b001fa9a6c793cmr3173687pjt.113.1660664911380;
        Tue, 16 Aug 2022 08:48:31 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b0016cbb46806asm9279410plc.278.2022.08.16.08.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 08:48:30 -0700 (PDT)
Message-ID: <52b67242-5d91-5406-9c95-9d8ddc49c079@github.com>
Date:   Tue, 16 Aug 2022 08:48:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/9] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> ## Changes since PATCH v2 ##
> 
> 1. Rephrase the descriptions for clean moves to match the actual
>    implementation.
> 
> 2. Add test for moving to a file path <destination> with overwrite.
> 
> 3. Add test for moving a directory as <source>, with one of its file
>    overwrites file entry in <destination>.
> 
> 4. *with_slash -> with_slash, remove the dereference sign.
> 
> 5. Take care of in-to-out where <destination> is a file path, rather
>    than a directory, this is what point 2 is testing.
> 
> 6. Add a NEEDSWORK doc to address "out-to-out" moves.
> 
> ## Changes since PATCH v1 ##
> 
> 1. Change "grep -x" to ^ and $ in t7002 test, and remove some
>    useless "-x" (lines that are *not* ambiguous).
> 
> 2. Rename check_dir_in_index() to empty_dir_has_sparse_contents()
>    and add more precise documentation.
> 
> 3. Reverse return values from empty_dir_has_sparse_contents() to
>    comply with the method's name.
> 
> 4. Make some commit messages more natural/fluent/without typos.
> 
> 5. Split commit "mv: from in-cone to out-of-cone" to two commits,
>    one does in-to-out functionality, the other one does advice.
> 
> 6. Take care a few memory leaks (`xstrdup`s).
> 
> 7. Add a new way to recursively cleanup empty WORKING_DIRECTORY.
> 
> ## leftover bits ##
> 
> I decided *not* to solve these bits in this series but in a future 
> one, so things can be handled one at a time without exceeding my
> capability.
> 
> 1. When trying to move from-in-to-out, the mechanism assumes that
>    the <destination> is out-of-cone, and by cone-mode definition,
>    <destination> is basically an invisible directory 
>    (SKIP_WORKTREE_DIR). However, the dirty move mechanism materializes
>    the moved file to make sure the information is not lost, and this
>    mechanism brings the invisible directory back into the worktree.
>    Hence, if we want to perform a second move from-in-to-out, the
>    assumption that <destination> is not on-disk is broken, and
>    everything follows breaks too. 
> 
> 2. A logic loophole introduced in the previous out-to-in patch,
>    especially in b91a2b6594 (mv: add check_dir_in_index() and solve 
>    general dir check issue). Please detach your head to b91a2b6594
>    for context. Copy and paste: 
>    
>                     git switch b91a2b6594
>    
>    When moving from out-to-in, <source> is an invisible 
>    SKIP_WORKTREE_DIR. Line 226 uses `lstat()` to make
>    sure the <source> is not on-disk; then line 233-237 checks if
>    <source> is a SKIP_WORKTREE_DIR. If the check passes, line 236
>    jump to line 276 and try to verify <source> is a directory using
>    `S_ISDIR`. However, because the prerequisite is that the line 226
>    `lstat()` fails so we can go through the steps said above; and when
>    it fails, the `st` stat, especially the `st_mode` member, is either
>    an uninitialized chunk of garbage, or the result from previous
>    `lstat()`. In this case, `st_mode` *is* from a previous `lstat()`,
>    on line 205. This `lstat()` is testing the <destination>, which,
>    under the out-to-in situation, is always an on-disk directory.
>    Thus, by a series of coincidence, the `S_ISDIR()` on line 276
>    succeed and everything *looks* OK test-wise. But clearly the `st`
>    at this point is an impostor: it does not reflect the actual stat
>    situation of <source> and it luckily slips through.
> 
>    This needs to be fixed.
> 
> 3. A NEEDSWORK added to address "out-to-out" move.
> 
> ## PATCH v1 info ##
> 
> This is a sister series to the previous "from out-of-cone to in-cone" [1]
> series. This series is trying to make the opposite operation possible for
> 'mv', namely move <source>, which is in-cone, to <destination>, which is
> out-of-cone.
> 
> Other than the main task, there are also some minor fixes done.
> 
> [1] https://lore.kernel.org/git/20220331091755.385961-1-shaoxuan.yuan02@gmail.com/
> 

(Sorry for the slow response) 

The range-diff below looks good to me (w.r.t feedback on the last version).
I do still find patch 4 [1] a bit cluttered, but it's a minor point and
otherwise everything looks functional; I think this is probably ready for
'next'.

Thanks!

> Shaoxuan Yuan (9):
>   t7002: add tests for moving from in-cone to out-of-cone
>   mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
>   mv: free the with_slash in check_dir_in_index()
>   mv: check if <destination> is a SKIP_WORKTREE_DIR
>   mv: remove BOTH from enum update_mode
>   mv: from in-cone to out-of-cone
>   mv: cleanup empty WORKING_DIRECTORY
>   advice.h: add advise_on_moving_dirty_path()
>   mv: check overwrite for in-to-out move
> 
>  advice.c                      |  19 +++
>  advice.h                      |   1 +
>  builtin/mv.c                  | 159 ++++++++++++++++++++----
>  t/t7002-mv-sparse-checkout.sh | 226 +++++++++++++++++++++++++++++++++-
>  4 files changed, 378 insertions(+), 27 deletions(-)
> 
> Range-diff against v2:
>  1:  a8c360c083 !  1:  8134fa5990 t7002: add tests for moving from in-cone to out-of-cone
>     @@ Commit message
>          Such <source> can be either clean or dirty, and moving it results in
>          different behaviors:
>      
>     -    A clean move should move the <source> to the <destination>, both in the
>     -    working tree and the index, then remove the resulted path from the
>     -    working tree, and turn on its CE_SKIP_WORKTREE bit.
>     +    A clean move should move <source> to <destination> in the index (do
>     +    *not* create <destination> in the worktree), then delete <source> from
>     +    the worktree.
>      
>          A dirty move should move the <source> to the <destination>, both in the
>          working tree and the index, but should *not* remove the resulted path
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing
>      +	test_cmp expect actual
>      +'
>      +
>     ++# This test is testing the same behavior as the
>     ++# "move clean path from in-cone to out-of-cone overwrite" above.
>     ++# The only difference is the <destination> changes from "folder1" to "folder1/file1"
>     ++test_expect_failure 'move clean path from in-cone to out-of-cone file overwrite' '
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>     ++	setup_sparse_checkout &&
>     ++	echo "sub/file1 overwrite" >sub/file1 &&
>     ++	git add sub/file1 &&
>     ++
>     ++	test_must_fail git mv sub/file1 folder1/file1 2>stderr &&
>     ++	cat sparse_error_header >expect &&
>     ++	echo "folder1/file1" >>expect &&
>     ++	cat sparse_hint >>expect &&
>     ++	test_cmp expect stderr &&
>     ++
>     ++	test_must_fail git mv --sparse sub/file1 folder1/file1 2>stderr &&
>     ++	echo "fatal: destination exists in the index, source=sub/file1, destination=folder1/file1" \
>     ++	>expect &&
>     ++	test_cmp expect stderr &&
>     ++
>     ++	git mv --sparse -f sub/file1 folder1/file1 2>stderr &&
>     ++	test_must_be_empty stderr &&
>     ++
>     ++	test_path_is_missing sub/file1 &&
>     ++	test_path_is_missing folder1/file1 &&
>     ++	git ls-files -t >actual &&
>     ++	! grep "H sub/file1" actual &&
>     ++	grep "S folder1/file1" actual &&
>     ++
>     ++	# compare file content before move and after move
>     ++	echo "sub/file1 overwrite" >expect &&
>     ++	git ls-files -s -- folder1/file1 | awk "{print \$2}" >oid &&
>     ++	git cat-file blob $(cat oid) >actual &&
>     ++	test_cmp expect actual
>     ++'
>     ++
>     ++test_expect_failure 'move directory with one of the files overwrite' '
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>     ++	mkdir -p folder1/dir &&
>     ++	touch folder1/dir/file1 &&
>     ++	git add folder1 &&
>     ++	git sparse-checkout set --cone sub &&
>     ++
>     ++	echo test >sub/dir/file1 &&
>     ++	git add sub/dir/file1 &&
>     ++
>     ++	test_must_fail git mv sub/dir folder1 2>stderr &&
>     ++	cat sparse_error_header >expect &&
>     ++	echo "folder1/dir/e" >>expect &&
>     ++	echo "folder1/dir/file1" >>expect &&
>     ++	cat sparse_hint >>expect &&
>     ++	test_cmp expect stderr &&
>     ++
>     ++	test_must_fail git mv --sparse sub/dir folder1 2>stderr &&
>     ++	echo "fatal: destination exists in the index, source=sub/dir/file1, destination=folder1/dir/file1" \
>     ++	>expect &&
>     ++	test_cmp expect stderr &&
>     ++
>     ++	git mv --sparse -f sub/dir folder1 2>stderr &&
>     ++	test_must_be_empty stderr &&
>     ++
>     ++	test_path_is_missing sub/dir/file1 &&
>     ++	test_path_is_missing sub/dir/e &&
>     ++	test_path_is_missing folder1/file1 &&
>     ++	git ls-files -t >actual &&
>     ++	! grep "H sub/dir/file1" actual &&
>     ++	! grep "H sub/dir/e" actual &&
>     ++	grep "S folder1/dir/file1" actual &&
>     ++
>     ++	# compare file content before move and after move
>     ++	echo test >expect &&
>     ++	git ls-files -s -- folder1/dir/file1 | awk "{print \$2}" >oid &&
>     ++	git cat-file blob $(cat oid) >actual &&
>     ++	test_cmp expect actual
>     ++'
>     ++
>      +test_expect_failure 'move dirty path from in-cone to out-of-cone' '
>      +	test_when_finished "cleanup_sparse_checkout" &&
>      +	setup_sparse_checkout &&
>  2:  725a83c575 =  2:  cc5f2770de mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
>  3:  1d4a0c16a6 !  3:  1780f36825 mv: free the *with_slash in check_dir_in_index()
>     @@ Metadata
>      Author: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## Commit message ##
>     -    mv: free the *with_slash in check_dir_in_index()
>     +    mv: free the with_slash in check_dir_in_index()
>      
>     -    *with_slash may be a malloc'd pointer, and when it is, free it.
>     +    with_slash may be a malloc'd pointer, and when it is, free it.
>      
>          Helped-by: Derrick Stolee <derrickstolee@github.com>
>          Helped-by: Victoria Dye <vdye@github.com>
>  4:  1f35f0eb34 =  4:  d935bd8d7a mv: check if <destination> is a SKIP_WORKTREE_DIR
>  5:  17a871a06b =  5:  26f29df8c8 mv: remove BOTH from enum update_mode
>  6:  32b9f85aa1 !  6:  2169b873f7 mv: from in-cone to out-of-cone
>     @@ Commit message
>          Change the behavior so that we can move an in-cone <source> to
>          out-of-cone <destination> when --sparse is supplied.
>      
>     +    Notice that <destination> can also be an out-of-cone file path, rather
>     +    than a directory.
>     +
>          Such <source> can be either clean or dirty, and moving it results in
>          different behaviors:
>      
>     -    A clean move should move the <source> to the <destination>, both in the
>     -    working tree and the index, then remove the resulted path from the
>     -    working tree, and turn on its CE_SKIP_WORKTREE bit.
>     +    A clean move should move <source> to <destination> in the index (do
>     +    *not* create <destination> in the worktree), then delete <source> from
>     +    the worktree.
>      
>          A dirty move should move the <source> to the <destination>, both in the
>          working tree and the index, but should *not* remove the resulted path
>          from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.
>      
>     +    Optional reading
>     +    ================
>     +
>     +    We are strict about cone mode when <destination> is a file path.
>     +    The reason is that some of the previous tests that use no-cone mode in
>     +    t7002 are keep breaking, mainly because the `dst_mode = SPARSE;` line
>     +    added in this patch.
>     +
>     +    Most features developed in both "from-out-to-in" and "from-in-to-out"
>     +    only care about cone mode situation, as no-cone mode is becoming
>     +    irrelevant. And because assigning `SPARSE` to `dst_mode` when the
>     +    repo is in no-cone mode causes miscellaneous bugs, we should just leave
>     +    this new functionality to be exclusive cone mode and save some time.
>     +
>          Helped-by: Derrick Stolee <derrickstolee@github.com>
>          Helped-by: Victoria Dye <vdye@github.com>
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>       		} else if (argc != 1) {
>       			die(_("destination '%s' is not a directory"), dest_path[0]);
>       		} else {
>     + 			destination = dest_path;
>     ++			/*
>     ++			 * <destination> is a file outside of sparse-checkout
>     ++			 * cone. Insist on cone mode here for backward
>     ++			 * compatibility. We don't want dst_mode to be assigned
>     ++			 * for a file when the repo is using no-cone mode (which
>     ++			 * is deprecated at this point) sparse-checkout. As
>     ++			 * SPARSE here is only considering cone-mode situation.
>     ++			 */
>     ++			if (!path_in_cone_mode_sparse_checkout(destination[0], &the_index))
>     ++				dst_mode = SPARSE;
>     + 		}
>     + 	}
>     + 	if (dst_w_slash != dest_path[0]) {
>      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>       		const char *src = source[i], *dst = destination[i];
>       		enum update_mode mode = modes[i];
>     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>       		if (show_only)
>       			continue;
>       		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
>     -+		    !(dst_mode & SKIP_WORKTREE_DIR) &&
>     ++		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
>       		    rename(src, dst) < 0) {
>       			if (ignore_errors)
>       				continue;
>     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>      +		if (ignore_sparse &&
>      +		    core_apply_sparse_checkout &&
>      +		    core_sparse_checkout_cone) {
>     ++			/*
>     ++			 * NEEDSWORK: we are *not* paying attention to
>     ++			 * "out-to-out" move (<source> is out-of-cone and
>     ++			 * <destination> is out-of-cone) at this point. It
>     ++			 * should be added in a future patch.
>     ++			 */
>      +			if ((mode & SPARSE) &&
>      +			    path_in_sparse_checkout(dst, &the_index)) {
>      +				/* from out-of-cone to in-cone */
>     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>      +
>      +				if (checkout_entry(dst_ce, &state, NULL, NULL))
>      +					die(_("cannot checkout %s"), dst_ce->name);
>     -+			} else if ((dst_mode & SKIP_WORKTREE_DIR) &&
>     ++			} else if ((dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
>      +				   !(mode & SPARSE) &&
>      +				   !path_in_sparse_checkout(dst, &the_index)) {
>      +				/* from in-cone to out-of-cone */
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing
>       	test_when_finished "cleanup_sparse_checkout" &&
>       	setup_sparse_checkout &&
>       
>     -@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
>     +@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move directory with one of the files overwrite' '
>       	test_cmp expect actual
>       '
>       
>  7:  449dba3853 =  7:  78a55e2a46 mv: cleanup empty WORKING_DIRECTORY
>  8:  875756480e =  8:  43ce1c07ec advice.h: add advise_on_moving_dirty_path()
>  9:  cd5d30505b !  9:  2e7c6a33c2 mv: check overwrite for in-to-out move
>     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>       		}
>       
>      +		if (ignore_sparse &&
>     -+		    (dst_mode & SKIP_WORKTREE_DIR) &&
>     ++		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
>      +		    index_entry_exists(&the_index, dst, strlen(dst))) {
>      +			bad = _("destination exists in the index");
>      +			if (force) {
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move clean path from in-cone
>       	test_when_finished "cleanup_sparse_checkout" &&
>       	setup_sparse_checkout &&
>       	echo "sub/file1 overwrite" >sub/file1 &&
>     +@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
>     + # This test is testing the same behavior as the
>     + # "move clean path from in-cone to out-of-cone overwrite" above.
>     + # The only difference is the <destination> changes from "folder1" to "folder1/file1"
>     +-test_expect_failure 'move clean path from in-cone to out-of-cone file overwrite' '
>     ++test_expect_success 'move clean path from in-cone to out-of-cone file overwrite' '
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>     + 	setup_sparse_checkout &&
>     + 	echo "sub/file1 overwrite" >sub/file1 &&
>     +@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move clean path from in-cone to out-of-cone file overwrite'
>     + 	test_cmp expect actual
>     + '
>     + 
>     +-test_expect_failure 'move directory with one of the files overwrite' '
>     ++test_expect_success 'move directory with one of the files overwrite' '
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>     + 	mkdir -p folder1/dir &&
>     + 	touch folder1/dir/file1 &&
> 
> base-commit: c50926e1f48891e2671e1830dbcd2912a4563450

