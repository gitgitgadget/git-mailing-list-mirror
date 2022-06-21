Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF39C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 23:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355191AbiFUXap (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 19:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355060AbiFUXam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 19:30:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1713057A
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 16:30:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i15so13853223plr.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kkh8l+sK8Z5eM6uSM9/NkFAeHLXrtautib/FP6wWEYI=;
        b=CDQN1zmpY+CJ22CJpsE9glhhcAAzr6MKOM5aD5xiqIyAvuxoL/b5xtVviUpWsD/iwq
         KYbuNyQ3+rwGgJ7DWnUkbBRy08oudvgaEqsEeO0seNGz42os7X0E2hzq506N7XtcW6ly
         VMoQs2imyxokzZabmxA51xzTl87VxBQ7NPBWxBB8Gspov7lp/8aUdDTxIBkMugICG9eb
         6bg9Zlwe1yAlPf2eyvlvf+ztO4BmSP+viziGPi7IDPNHPy04+0lK4t6LHhC44NImogAA
         acu4rqgj/BpQaxv/fE8XdCpFZPV1yNzZfGOVe1Ipfm3gdHIC5Kv+C0FEkY8m64YXGVv7
         4blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kkh8l+sK8Z5eM6uSM9/NkFAeHLXrtautib/FP6wWEYI=;
        b=cFI3N2dJD3NNaOFO8DVzEtKV9JaCyQUXiTzwL82h/eV9WGjU4TwOVz4AXAE2KRDHRQ
         f0GoOwMXMoXxGtZQLj/5uBHkfygc0+NL/a/iaqxBV1wdofOxd4tBGczmo4WthglYZtf+
         q7lXSbWM+Hf+eis7PdUqtHK5w2dRypfRrfq4AHzTRiSHZOreNhH3WuayUd9vjfB07wtn
         fum19aCI7cdTh2XX5EydQPlBCeslrBq95ksRqsiFwRfPLAIoudEg4xAeng0wBBx4U4zq
         naJxjvAMrlgSxqSRIrnE1MZFPLVgA0S0Nw+2scaVhpH3xNS/6i850koI+v644E1SHeTr
         eJvA==
X-Gm-Message-State: AJIora+1S6T0TFLJU+lv/2+1iMlMl0zmnd6cciMur1Rwflo1s8IfALVW
        OjSbuwOntIYyOS8BJ2dpPGMl
X-Google-Smtp-Source: AGRyM1sTQCgozdHhnDQ6P+yqryj4K4eMe6hBfE+4hBEUKz4vxfuUMndK2BbNFkJl8X5ildXLqTJo4A==
X-Received: by 2002:a17:902:b597:b0:168:d8ce:4a63 with SMTP id a23-20020a170902b59700b00168d8ce4a63mr31590673pls.57.1655854240119;
        Tue, 21 Jun 2022 16:30:40 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id js15-20020a17090b148f00b001ec9d45776bsm5357053pjb.42.2022.06.21.16.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 16:30:39 -0700 (PDT)
Message-ID: <d3aa35e4-5bad-2bbb-2a25-d82064d6ec81@github.com>
Date:   Tue, 21 Jun 2022 16:30:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [WIP v3 0/7] mv: fix out-of-cone file/directory move logic
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> The range-diff seems a bit messy, because some of the changes are too big
> then I have to tune the --create-factor big enough to reveal these changes.
> 
> ## Changes since WIP v2 ##
> 
> 1. Write helper functions for t7002 to reuse some code.
> 
> 2. Refactor/decouple the if/else-if checking chain.
> 
> 3. Separate out the 'update_mode' refactor into a single commit.
> 
> 4. Stop using update_sparsity() and instead update the SKIP_WORKTREE
>    bit for each cache_entry and check it out to the working tree.

All of this looks great! My comments are all minor syntax nits - the
functionality is sound. Thanks again for working through this tangled mess
of a problem!

> 
> ## Limitations ##
> 
> At this point, we still don't have in-cone to out-of-cone move, which
> I don't think is too much a problem, since the title says this series is
> around out-of-cone as the <source>.
> 

While it would be nice to include in-cone -> out-of-cone here, I'm also
content with you moving it to a later series (the first couple patches in a
sparse index integration or as a standalone series; up to you). 

> But I think it worth discuss if we should implement in-cone to 
> out-of-cone move, since it will be nice (naturally) to have it working.
> 
> However, I noticed this from the mv man page:
> 
> "In the second form, the last argument has to be an existing directory; 
> the given sources will be moved into this directory."
> 
> I think trying to move out-of-cone, the last argument has to be an non-existent
> directory? I'm a bit confused: should we update some of mv basic logic to 
> accomplish this?
> 

I suspect this requirement is related to the POSIX 'mv' [1] (and
corresponding 'rename()', used in 'git mv'), which also requires that the
destination directory exists. I personally don't think this requirement
needs to apply to 'git mv' at all, but note that changing the behavior would
require first creating the necessary directories before calling 'rename()'. 

As a more conservative solution, you could do the parent directory creation
*only* in the case of moving to a sparse contents-only directory (using
something like the 'check_dir_in_index()' function you introduced to
identify).

I'm also interested in hearing what others have to say, especially regarding
historical context/use cases of 'git mv'.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/mv.html

> Shaoxuan Yuan (7):
>   t7002: add tests for moving out-of-cone file/directory
>   mv: decouple if/else-if checks using goto
>   mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
>   mv: check if <destination> exists in index to handle overwriting
>   mv: use flags mode for update_mode
>   mv: add check_dir_in_index() and solve general dir check issue
>   mv: update sparsity after moving from out-of-cone to in-cone
> 
>  builtin/mv.c                  | 244 +++++++++++++++++++++++++---------
>  t/t7002-mv-sparse-checkout.sh |  85 ++++++++++++
>  2 files changed, 264 insertions(+), 65 deletions(-)
> 
> Range-diff against v2:
> 1:  271445205d ! 1:  a08ce96935 t7002: add tests for moving out-of-cone file/directory
>     @@ Commit message
>      
>          Add corresponding tests to test following situations:
>      
>     -    * 'refuse to move out-of-cone directory without --sparse'
>     -    * 'can move out-of-cone directory with --sparse'
>     -    * 'refuse to move out-of-cone file without --sparse'
>     -    * 'can move out-of-cone file with --sparse'
>     -    * 'refuse to move sparse file to existing destination'
>     -    * 'move sparse file to existing destination with --force and --sparse'
>     +    We do not have sufficient coverage of moving files outside
>     +    of a sparse-checkout cone. Create new tests covering this
>     +    behavior, keeping in mind that the user can include --sparse
>     +    (or not), move a file or directory, and the destination can
>     +    already exist in the index (in this case user can use --force
>     +    to overwrite existing entry).
>      
>     +    Helped-by: Victoria Dye <vdye@github.com>
>     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## t/t7002-mv-sparse-checkout.sh ##
>     +@@ t/t7002-mv-sparse-checkout.sh: test_description='git mv in sparse working trees'
>     + 
>     + . ./test-lib.sh
>     + 
>     ++setup_sparse_checkout () {
>     ++	mkdir folder1 &&
>     ++	touch folder1/file1 &&
>     ++	git add folder1 &&
>     ++	git sparse-checkout set --cone sub
>     ++}
>     ++
>     ++cleanup_sparse_checkout () {
>     ++	git sparse-checkout disable &&
>     ++	git reset --hard
>     ++}
>     ++
>     + test_expect_success 'setup' "
>     + 	mkdir -p sub/dir sub/dir2 &&
>     + 	touch a b c sub/d sub/dir/e sub/dir2/e &&
>     +@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move files to non-sparse dir' '
>     + '
>     + 
>     + test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>     + 	git reset --hard &&
>     + 	git sparse-checkout init --no-cone &&
>     + 	git sparse-checkout set a !/x y/ !x/y/z &&
>      @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
>       	test_cmp expect stderr
>       '
>       
>      +test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
>     -+	git sparse-checkout disable &&
>     -+	git reset --hard &&
>     -+	mkdir folder1 &&
>     -+	touch folder1/file1 &&
>     -+	git add folder1 &&
>     -+	git sparse-checkout init --cone &&
>     -+	git sparse-checkout set sub &&
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>     ++	setup_sparse_checkout &&
>      +
>      +	test_must_fail git mv folder1 sub 2>stderr &&
>      +	cat sparse_error_header >expect &&
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
>      +'
>      +
>      +test_expect_failure 'can move out-of-cone directory with --sparse' '
>     -+	git sparse-checkout disable &&
>     -+	git reset --hard &&
>     -+	mkdir folder1 &&
>     -+	touch folder1/file1 &&
>     -+	git add folder1 &&
>     -+	git sparse-checkout init --cone &&
>     -+	git sparse-checkout set sub &&
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>     ++	setup_sparse_checkout &&
>      +
>      +	git mv --sparse folder1 sub 1>actual 2>stderr &&
>      +	test_must_be_empty stderr &&
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
>      +'
>      +
>      +test_expect_failure 'refuse to move out-of-cone file without --sparse' '
>     -+	git sparse-checkout disable &&
>     -+	git reset --hard &&
>     -+	mkdir folder1 &&
>     -+	touch folder1/file1 &&
>     -+	git add folder1 &&
>     -+	git sparse-checkout init --cone &&
>     -+	git sparse-checkout set sub &&
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>     ++	setup_sparse_checkout &&
>      +
>      +	test_must_fail git mv folder1/file1 sub 2>stderr &&
>      +	cat sparse_error_header >expect &&
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
>      +'
>      +
>      +test_expect_failure 'can move out-of-cone file with --sparse' '
>     -+	git sparse-checkout disable &&
>     -+	git reset --hard &&
>     -+	mkdir folder1 &&
>     -+	touch folder1/file1 &&
>     -+	git add folder1 &&
>     -+	git sparse-checkout init --cone &&
>     -+	git sparse-checkout set sub &&
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>     ++	setup_sparse_checkout &&
>      +
>      +	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
>      +	test_must_be_empty stderr &&
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
>      +'
>      +
>      +test_expect_failure 'refuse to move sparse file to existing destination' '
>     -+	git sparse-checkout disable &&
>     -+	git reset --hard &&
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>      +	mkdir folder1 &&
>      +	touch folder1/file1 &&
>      +	touch sub/file1 &&
>      +	git add folder1 sub/file1 &&
>     -+	git sparse-checkout init --cone &&
>     -+	git sparse-checkout set sub &&
>     ++	git sparse-checkout set --cone sub &&
>      +
>      +	test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
>      +	echo "fatal: destination exists, source=folder1/file1, destination=sub/file1" >expect &&
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
>      +'
>      +
>      +test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
>     -+	git sparse-checkout disable &&
>     -+	git reset --hard &&
>     ++	test_when_finished "cleanup_sparse_checkout" &&
>      +	mkdir folder1 &&
>      +	touch folder1/file1 &&
>      +	touch sub/file1 &&
>      +	echo "overwrite" >folder1/file1 &&
>      +	git add folder1 sub/file1 &&
>     -+	git sparse-checkout init --cone &&
>     -+	git sparse-checkout set sub &&
>     ++	git sparse-checkout set --cone sub &&
>      +
>      +	git mv --sparse --force folder1/file1 sub 2>stderr &&
>      +	test_must_be_empty stderr &&
> -:  ---------- > 2:  8065fbc232 mv: decouple if/else-if checks using goto
> 2:  80f485f146 ! 3:  e227fe717b mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
>     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>       
>       		length = strlen(src);
>       		if (lstat(src, &st) < 0) {
>     -+			/*
>     -+			 * TODO: for now, when you try to overwrite a <destination>
>     -+			 * with your <source> as a sparse file, if you supply a "--sparse"
>     -+			 * flag, then the action will be done without providing "--force"
>     -+			 * and no warning.
>     -+			 *
>     -+			 * This is mainly because the sparse <source>
>     -+			 * is not on-disk, and this if-else chain will be cut off early in
>     -+			 * this check, thus the "--force" check is ignored. Need fix.
>     -+			 */
>     +-			/* only error if existence is expected. */
>     +-			if (modes[i] != SPARSE) {
>     ++			int pos;
>     ++			const struct cache_entry *ce;
>      +
>     -+			int pos = cache_name_pos(src, length);
>     -+			if (pos >= 0) {
>     -+				const struct cache_entry *ce = active_cache[pos];
>     -+
>     -+				if (ce_skip_worktree(ce)) {
>     -+					if (!ignore_sparse)
>     -+						string_list_append(&only_match_skip_worktree, src);
>     -+					else
>     -+						modes[i] = SPARSE;
>     -+				}
>     -+				else
>     ++			pos = cache_name_pos(src, length);
>     ++			if (pos < 0) {
>     ++				/* only error if existence is expected. */
>     ++				if (modes[i] != SPARSE)
>      +					bad = _("bad source");
>     ++				goto act_on_entry;
>      +			}
>     - 			/* only error if existence is expected. */
>     --			if (modes[i] != SPARSE)
>     -+			else if (modes[i] != SPARSE)
>     ++
>     ++			ce = active_cache[pos];
>     ++			if (!ce_skip_worktree(ce)) {
>       				bad = _("bad source");
>     - 		} else if (!strncmp(src, dst, length) &&
>     - 				(dst[length] == 0 || dst[length] == '/')) {
>     + 				goto act_on_entry;
>     + 			}
>     ++
>     ++			if (!ignore_sparse)
>     ++				string_list_append(&only_match_skip_worktree, src);
>     ++			else
>     ++				modes[i] = SPARSE;
>     ++			goto act_on_entry;
>     + 		}
>     + 		if (!strncmp(src, dst, length) &&
>     + 		    (dst[length] == 0 || dst[length] == '/')) {
>      
>       ## t/t7002-mv-sparse-checkout.sh ##
>      @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'can move out-of-cone directory with --sparse' '
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'can move out-of-cone directo
>       
>      -test_expect_failure 'refuse to move out-of-cone file without --sparse' '
>      +test_expect_success 'refuse to move out-of-cone file without --sparse' '
>     - 	git sparse-checkout disable &&
>     - 	git reset --hard &&
>     - 	mkdir folder1 &&
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>     + 	setup_sparse_checkout &&
>     + 
>      @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'refuse to move out-of-cone file without --sparse' '
>       	test_cmp expect stderr
>       '
>       
>      -test_expect_failure 'can move out-of-cone file with --sparse' '
>      +test_expect_success 'can move out-of-cone file with --sparse' '
>     - 	git sparse-checkout disable &&
>     - 	git reset --hard &&
>     - 	mkdir folder1 &&
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>     + 	setup_sparse_checkout &&
>     + 
> 3:  04572e5e6b ! 4:  d0de7678e3 mv: check if <destination> exists in index to handle overwriting
>     @@ Commit message
>      
>       ## builtin/mv.c ##
>      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 
>     - 		length = strlen(src);
>     - 		if (lstat(src, &st) < 0) {
>     --			/*
>     --			 * TODO: for now, when you try to overwrite a <destination>
>     --			 * with your <source> as a sparse file, if you supply a "--sparse"
>     --			 * flag, then the action will be done without providing "--force"
>     --			 * and no warning.
>     --			 *
>     --			 * This is mainly because the sparse <source>
>     --			 * is not on-disk, and this if-else chain will be cut off early in
>     --			 * this check, thus the "--force" check is ignored. Need fix.
>     --			 */
>     - 
>     - 			int pos = cache_name_pos(src, length);
>     - 			if (pos >= 0) {
>     -@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 				if (ce_skip_worktree(ce)) {
>     - 					if (!ignore_sparse)
>     - 						string_list_append(&only_match_skip_worktree, src);
>     --					else
>     --						modes[i] = SPARSE;
>     -+					else {
>     -+						/* Check if dst exists in index */
>     -+						if (cache_name_pos(dst, strlen(dst)) >= 0) {
>     -+							if (force)
>     -+								modes[i] = SPARSE;
>     -+							else
>     -+								bad = _("destination exists");
>     -+						}
>     -+						else
>     -+							modes[i] = SPARSE;
>     -+					}
>     - 				}
>     - 				else
>     - 					bad = _("bad source");
>     + 				bad = _("bad source");
>     + 				goto act_on_entry;
>     + 			}
>     +-
>     +-			if (!ignore_sparse)
>     ++			if (!ignore_sparse) {
>     + 				string_list_append(&only_match_skip_worktree, src);
>     +-			else
>     ++				goto act_on_entry;
>     ++			}
>     ++			/* Check if dst exists in index */
>     ++			if (cache_name_pos(dst, strlen(dst)) < 0) {
>     + 				modes[i] = SPARSE;
>     ++				goto act_on_entry;
>     ++			}
>     ++			if (!force) {
>     ++				bad = _("destination exists");
>     ++				goto act_on_entry;
>     ++			}
>     ++			modes[i] = SPARSE;
>     + 			goto act_on_entry;
>     + 		}
>     + 		if (!strncmp(src, dst, length) &&
>      
>       ## t/t7002-mv-sparse-checkout.sh ##
>      @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move out-of-cone file with --sparse' '
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move out-of-cone file wi
>       
>      -test_expect_failure 'refuse to move sparse file to existing destination' '
>      +test_expect_success 'refuse to move sparse file to existing destination' '
>     - 	git sparse-checkout disable &&
>     - 	git reset --hard &&
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>       	mkdir folder1 &&
>     + 	touch folder1/file1 &&
> -:  ---------- > 5:  70540957b6 mv: use flags mode for update_mode
> 4:  4eeae40186 ! 6:  f8302f64e0 mv: add check_dir_in_index() and solve general dir check issue
>     @@ Commit message
>          instead of "bad source"; also user now can supply a "--sparse" flag so
>          this operation can be carried out successfully.
>      
>     -    Also, as suggested by Derrick [1],
>     -    move the in-line definition of "enum update_mode" to the top
>     -    of the file and make it use "flags" mode (each state is a different
>     -    bit in the word).
>     -
>     -    [1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/
>     -
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## builtin/mv.c ##
>     -@@ builtin/mv.c: static const char * const builtin_mv_usage[] = {
>     - 	NULL
>     - };
>     - 
>     -+enum update_mode {
>     -+	BOTH = 0,
>     -+	WORKING_DIRECTORY = (1 << 1),
>     -+	INDEX = (1 << 2),
>     -+	SPARSE = (1 << 3),
>     -+	SKIP_WORKTREE_DIR = (1 << 4),
>     -+};
>     -+
>     - #define DUP_BASENAME 1
>     - #define KEEP_TRAILING_SLASH 2
>     - 
>      @@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
>       	return last - first;
>       }
>     @@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
>       {
>       	int i, flags, gitmodules_modified = 0;
>      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 		OPT_END(),
>     - 	};
>     - 	const char **source, **destination, **dest_path, **submodule_gitfile;
>     --	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
>     -+	enum update_mode *modes;
>     - 	struct stat st;
>     - 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>     - 	struct lock_file lock_file = LOCK_INIT;
>     -@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 		if (lstat(src, &st) < 0) {
>     - 
>     - 			int pos = cache_name_pos(src, length);
>     -+			const char *src_w_slash = add_slash(src);
>     -+
>     - 			if (pos >= 0) {
>     - 				const struct cache_entry *ce = active_cache[pos];
>     + 	/* Checking */
>     + 	for (i = 0; i < argc; i++) {
>     + 		const char *src = source[i], *dst = destination[i];
>     +-		int length, src_is_dir;
>     ++		int length;
>     + 		const char *bad = NULL;
>     + 		int skip_sparse = 0;
>       
>      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 				else
>     + 
>     + 			pos = cache_name_pos(src, length);
>     + 			if (pos < 0) {
>     ++				const char *src_w_slash = add_slash(src);
>     ++				if (!check_dir_in_index(src, length) &&
>     ++					!path_in_sparse_checkout(src_w_slash, &the_index)) {
>     ++					modes[i] |= SKIP_WORKTREE_DIR;
>     ++					goto dir_check;
>     ++				}
>     + 				/* only error if existence is expected. */
>     + 				if (!(modes[i] & SPARSE))
>       					bad = _("bad source");
>     + 				goto act_on_entry;
>       			}
>     -+			else if (!check_dir_in_index(src, length) &&
>     -+					 !path_in_sparse_checkout(src_w_slash, &the_index)) {
>     -+				modes[i] = SKIP_WORKTREE_DIR;
>     -+				goto dir_check;
>     -+			}
>     - 			/* only error if existence is expected. */
>     - 			else if (modes[i] != SPARSE)
>     +-
>     + 			ce = active_cache[pos];
>     + 			if (!ce_skip_worktree(ce)) {
>       				bad = _("bad source");
>      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 				&& lstat(dst, &st) == 0)
>     + 			bad = _("can not move directory into itself");
>     + 			goto act_on_entry;
>     + 		}
>     +-		if ((src_is_dir = S_ISDIR(st.st_mode))
>     ++		if (S_ISDIR(st.st_mode)
>     + 		    && lstat(dst, &st) == 0) {
>       			bad = _("cannot move directory over file");
>     - 		else if (src_is_dir) {
>     + 			goto act_on_entry;
>     + 		}
>     +-		if (src_is_dir) {
>     ++
>     ++dir_check:
>     ++		if (S_ISDIR(st.st_mode)) {
>     + 			int j, dst_len, n;
>      -			int first = cache_name_pos(src, length), last;
>      +			int first, last;
>     -+dir_check:
>      +			first = cache_name_pos(src, length);
>       
>     - 			if (first >= 0)
>     + 			if (first >= 0) {
>       				prepare_move_submodule(src, first,
>     -@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 			else { /* last - first >= 1 */
>     - 				int j, dst_len, n;
>     - 
>     --				modes[i] = WORKING_DIRECTORY;
>     -+				if (!modes[i])
>     -+					modes[i] |= WORKING_DIRECTORY;
>     - 				n = argc + last - first;
>     - 				REALLOC_ARRAY(source, n);
>     - 				REALLOC_ARRAY(destination, n);
>     -@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 			printf(_("Renaming %s to %s\n"), src, dst);
>     - 		if (show_only)
>     - 			continue;
>     --		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
>     -+		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
>     -+		 	rename(src, dst) < 0) {
>     - 			if (ignore_errors)
>     - 				continue;
>     - 			die_errno(_("renaming '%s' failed"), src);
>     -@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - 							      1);
>     - 		}
>     - 
>     --		if (mode == WORKING_DIRECTORY)
>     -+		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
>     - 			continue;
>     - 
>     - 		pos = cache_name_pos(src, strlen(src));
>      
>       ## t/t7002-mv-sparse-checkout.sh ##
>      @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
>     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
>       
>      -test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
>      +test_expect_success 'refuse to move out-of-cone directory without --sparse' '
>     - 	git sparse-checkout disable &&
>     - 	git reset --hard &&
>     - 	mkdir folder1 &&
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>     + 	setup_sparse_checkout &&
>     + 
>      @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
>       	test_cmp expect stderr
>       '
>       
>      -test_expect_failure 'can move out-of-cone directory with --sparse' '
>      +test_expect_success 'can move out-of-cone directory with --sparse' '
>     - 	git sparse-checkout disable &&
>     - 	git reset --hard &&
>     - 	mkdir folder1 &&
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>     + 	setup_sparse_checkout &&
>     + 
> 5:  a3a296c3ef ! 7:  bc996931e2 mv: use update_sparsity() after touching sparse contents
>     @@ Metadata
>      Author: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## Commit message ##
>     -    mv: use update_sparsity() after touching sparse contents
>     +    mv: update sparsity after moving from out-of-cone to in-cone
>      
>     -    Originally, "git mv" a sparse file/directory from out/in-cone to
>     -    in/out-cone does not update the sparsity following the sparse-checkout
>     -    patterns.
>     +    Originally, "git mv" a sparse file from out-of-cone to
>     +    in-cone does not update the moved file's sparsity (remove its
>     +    SKIP_WORKTREE bit). And the corresponding cache entry is, unexpectedly,
>     +    not checked out in the working tree.
>      
>     -    Use update_sparsity() after touching sparse contents, so the sparsity
>     -    will be updated after the move.
>     +    Update the behavior so that:
>     +    1. Moving from out-of-cone to in-cone removes the SKIP_WORKTREE bit from
>     +       corresponding cache entry.
>     +    2. The moved cache entry is checked out in the working tree to reflect
>     +       the updated sparsity.
>      
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>     @@ builtin/mv.c
>       #include "string-list.h"
>       #include "parse-options.h"
>       #include "submodule.h"
>     -+#include "unpack-trees.h"
>     ++#include "entry.h"
>       
>       static const char * const builtin_mv_usage[] = {
>       	N_("git mv [<options>] <source>... <destination>"),
>     -@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     - {
>     - 	int i, flags, gitmodules_modified = 0;
>     - 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
>     -+	int sparse_moved = 0;
>     - 	struct option builtin_mv_options[] = {
>     - 		OPT__VERBOSE(&verbose, N_("be verbose")),
>     - 		OPT__DRY_RUN(&show_only, N_("dry run")),
>      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>       		const char *src = source[i], *dst = destination[i];
>       		enum update_mode mode = modes[i];
>       		int pos;
>     -+		if (!sparse_moved && mode & (SPARSE | SKIP_WORKTREE_DIR))
>     -+			sparse_moved = 1;
>     ++		struct checkout state = CHECKOUT_INIT;
>     ++		state.istate = &the_index;
>     ++
>     ++		if (force)
>     ++			state.force = 1;
>       		if (show_only || verbose)
>       			printf(_("Renaming %s to %s\n"), src, dst);
>       		if (show_only)
>      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
>     + 		pos = cache_name_pos(src, strlen(src));
>     + 		assert(pos >= 0);
>       		rename_cache_entry_at(pos, dst);
>     ++
>     ++		if (mode & SPARSE) {
>     ++			if (path_in_sparse_checkout(dst, &the_index)) {
>     ++				int dst_pos;
>     ++
>     ++				dst_pos = cache_name_pos(dst, strlen(dst));
>     ++				active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
>     ++
>     ++				if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
>     ++					die(_("cannot checkout %s"), ce->name);
>     ++			}
>     ++		}
>       	}
>       
>     -+	if (sparse_moved) {
>     -+		struct unpack_trees_options o;
>     -+		memset(&o, 0, sizeof(o));
>     -+		o.verbose_update = isatty(2);
>     -+		o.update = 1;
>     -+		o.head_idx = -1;
>     -+		o.src_index = &the_index;
>     -+		o.dst_index = &the_index;
>     -+		o.skip_sparse_checkout = 0;
>     -+		o.pl = the_index.sparse_checkout_patterns;
>     -+		setup_unpack_trees_porcelain(&o, "mv");
>     -+		update_sparsity(&o);
>     -+		clear_unpack_trees_porcelain(&o);
>     -+	}
>     -+
>       	if (gitmodules_modified)
>     - 		stage_updated_gitmodules(&the_index);
>     - 
>      
>       ## t/t7002-mv-sparse-checkout.sh ##
>     +@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move out-of-cone directory with --sparse' '
>     + 	git mv --sparse folder1 sub 1>actual 2>stderr &&
>     + 	test_must_be_empty stderr &&
>     + 
>     +-	git sparse-checkout reapply &&
>     + 	test_path_is_dir sub/folder1 &&
>     + 	test_path_is_file sub/folder1/file1
>     + '
>     +@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move out-of-cone file with --sparse' '
>     + 	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
>     + 	test_must_be_empty stderr &&
>     + 
>     +-	git sparse-checkout reapply &&
>     + 	! test_path_is_dir sub/folder1 &&
>     + 	test_path_is_file sub/file1
>     + '
>      @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move sparse file to existing destination' '
>       	test_cmp expect stderr
>       '
>       
>     -+# Need fix.
>     -+#
>     -+# The *expected* behavior:
>     -+#
>     -+# Using --sparse to accept a sparse file, --force to overwrite the destination.
>     -+# The folder1/file1 should replace the sub/file1 without error.
>     -+#
>     -+# The *actual* behavior:
>     -+#
>     -+# It emits a warning:
>     -+#
>     -+# warning: Path ' sub/file1
>     -+# ' already present; will not overwrite with sparse update.
>     -+# After fixing the above paths, you may want to run `git sparse-checkout
>     -+# reapply`.
>     -+
>     - test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
>     - 	git sparse-checkout disable &&
>     - 	git reset --hard &&
>     +-test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
>     ++test_expect_success 'move sparse file to existing destination with --force and --sparse' '
>     + 	test_when_finished "cleanup_sparse_checkout" &&
>     + 	mkdir folder1 &&
>     + 	touch folder1/file1 &&
> 
> base-commit: 4f6db706e6ad145a9bf6b26a1ca0970bed27bb72

