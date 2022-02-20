Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590DC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiBTGzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiBTGzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9083586F
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h6so21514311wrb.9
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6X/CBJxHlkf+fR6uPtzWdoFXxs6t6PWORpk5ObtRFJE=;
        b=gojk46zo4xkFgDwlkjHAPvMz4ICIclymEWWCg9+GTqpX2ADh7JeFQdMDYdIMzfVkfM
         sVVA6/KjpRTFwI/GBGvN10qzNMe3QUYw8xGVMzkRkRbIzRaxf/tmBrf0ozZReN6ou1hA
         bybkJnijpD1ixRRjvzcssn5KkEvYc3a4+zEGgSM+u8UfmR0CjDPbtU7n+9JCpz04yXMj
         8vBNAFGi4UrZlXrqp9s2dJVlx/Ncpm4pklhIB+WHtWT1JxkvleFdi8qD+UtGSewH68KG
         PPdowmqJWMvryWFs+lllxAZRvmH4IrjrJRafKTyyrlP7EoolSlWisF/+Zz/aCWBHzXKW
         uhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6X/CBJxHlkf+fR6uPtzWdoFXxs6t6PWORpk5ObtRFJE=;
        b=Exs93W/xUzE4/Cm+eQnAF/3IGFI88RiykkYFQBMtdoGlxZWWb269vuxOYjsUtNrqbm
         tnvbUJtfItUV1ZJPRRCnpul7tZ0skMUeX1STFuB3DSsfKPdXBnmAMDgTs7ISDFF1G8Zj
         qOAWZdRwL1ue4d1HT+7nbf8C7UhAIru3/dQ43Rs93F7lCm2i4rbQbMa4Ex4aYS2ZkRrL
         OLOP94CBAdH8xRZDWxl8sgsLCROmCiJeqDkDYgQ4QSVRDixs4TkCw7NQU60IAiXHXY8A
         wLPsDnTWWXYcZurT9bCrydOofZzYJJTd5YAOUhsfsDZ4r5D+V/26fl5hmgIvC3mHQiK0
         VyOg==
X-Gm-Message-State: AOAM531l8IAAQwsbkBF41VlZ+V05Qt+ff+I6+Q0tI/utSbHWE9Jux9G6
        QlxtPr4c95T81fAi7p2gayntktn/buA=
X-Google-Smtp-Source: ABdhPJw+L2K/WbPrTeNL8z1FFFgdRNsow8Qdwm8s0LQINuuBYe+7pwnugmissI6HxkM/or/Hggspeg==
X-Received: by 2002:adf:fe43:0:b0:1e4:a213:b876 with SMTP id m3-20020adffe43000000b001e4a213b876mr11531697wrs.513.1645340083565;
        Sat, 19 Feb 2022 22:54:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm21662584wri.88.2022.02.19.22.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:43 -0800 (PST)
Message-Id: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:30 +0000
Subject: [PATCH v5 00/12] In-core git merge-tree ("Server side merges")
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Basic Summary ==

This series introduces a new mode to git merge-tree allowing it to perform
real merges (three-way text content merges, recursive ancestor
consolidation, rename detection, proper directory/file conflict handling,
etc.) and write the result as a toplevel tree. It doesn't touch the working
tree or index, and doesn't create any commits or update any refs. It could
be used to do merges when in a bare repository (thus potentially making it
of interest to Git hosting sites, i.e. "Server side merges"), or for doing a
merge of branches that aren't checked out.

It does not handle similar functionality for cherry-picks, rebases, or
reverts; that is also of interest, but is being deferred for a future
series.

== Quick Overview ==

 * Patches 1-2: preparatory cleanups
 * Patches 3-4: implement basic real merges
 * Patches 5-6: include informational messages ("CONFLICT" messages and
   such) in output
 * Patches 7-10: add ability to include ls-files -u style of info in the
   output
 * Patch 11: support --allow-unrelated-histories
 * Patch 12: augment the manual with potential usage mistakes

== Updates Log ==

Many thanks to the many reviewers who provided good feedback on the most
recent round -- Junio, Ævar, Josh, Emily, and perhaps some others I've
forgotten from review club.

Updates since v4:

 * Fixed double "is" in documentation.
 * Fixed a few small items with testcases

Updates since v3 (or v5, if you include the rounds at
https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/):

 * Dropped previous patches 5, 6, and 8 of the old series; they weren't
   being used and opened a can of worms[1]
 * [Patch 3] Restructured argument checking, including using an enum
 * [Patch 4] Restored the extended paragraph about the deprecated form of
   git-merge-tree, mentioned write-tree in plumbing commands, and a few
   other small fixups to the documentation
 * [Patch 4] Also provide an example of a clean merge rather than just a
   conflicted one
 * [Patch 6] Fix the incompatible arguments check and add some tests for it
 * [Patch 6] Introduce an anonymize_hash() shell function to make tests
   easier to read (less repeated sed)
 * [Patch 9] Rename --exclude-modes-oids-stages to --name-only; no short
   option for now
 * [Patch 10] When -z passed, the tree in the first section should have a
   trailing NUL rather than trailing newline [1]
   https://lore.kernel.org/git/CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com/

Stuff NOT included that reviewers brought up in earlier rounds:

 * Very generic (mode, oid, stage, filename) printing formatting[2]
 * Always printing 3 stages for each filename with conflicts[3]
 * Attempting to group conflict stages by logical conflict rather than by
   affected target filepath[4]
 * Providing similar functionality for doing cherry-picks/rebases/reverts,
   i.e. a scheme for three-way merges with a specified merge-base[5]. That's
   being deferred to a future series. [2]
   https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0it3z7TPn_w@mail.gmail.com/
   [3]
   https://lore.kernel.org/git/CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com/
   [4]
   https://lore.kernel.org/git/CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com/
   [5]
   https://lore.kernel.org/git/CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com/

Updates since v2:

 * Improved patches from Dscho for the diff_warn_rename_limit() handling
 * Add a -z option for NUL-terminated conflict info lines (so that filenames
   do not have to be quoted)

Updates since v1 (or v3 depending on how you count; thanks to René, Ævar,
Christian, Dscho for very helpful feedback):

 * New patch from Dscho allowing diff_warn_rename_limit() to print somewhere
   other than stdout (I hope he's okay with me including his Signed-off-by)
 * Now prints filenames relative to prefix, much like ls-files
 * Renamed --exclude-oids-and-modes to --exclude-modes-oids-stages and gave
   it a -l shorthand; I'm wondering if I should just drop this option,
   though.
 * And numerous cleanups, in lots of areas:
   * Multiple parse-options cleanups
   * Lots of commit message cleanups
   * Wording tweaks to the "Description" section of the manual
   * Several small code cleanups
 * I dropped the RFC label

Updates since original submission v2 (thanks to Christian, Dscho, Ramsay,
and René for suggestions and comments):

 * Significant changes to output format:
   * Flags no longer take a filename for additional output; they write to
     stdout instead.
   * More information included by default when there are conflicts (no need
     to request it with additional flags, instead flags can be used to
     suppress it).
   * Provide (mode, oid, stage, file) tuples -- i.e. ls-files -u style of
     information -- when there are conflicts. Add a flag to only list
     conflicted files if that's preferred.
 * Much more thorough manual for git-merge-tree.txt
 * Renamed option from --real to --write-tree
 * Accept an optional --trivial-merge option to get old style merge-tree
   behavior
 * Allow both --write-tree and --trivial-merge to be omitted since we can
   deduce which from number of arguments
 * Document exit code when the merge cannot be run (so we can distinguish
   other error cases from conflicts)
 * testcase cleanups: test_tick, early skip of test when using recursive
   backend, variable renames, etc.
 * various minor code cleanups
 * Add a new --allow-unrelated-histories option (with same meaning as the
   one used in git merge)
 * Rebased on top of en/remerge-diff to avoid a small conflict

Updates since original submission v1 (thanks to Johannes Altmanninger and
Fabian for suggestions):

 * Fixed a bad patch splitting, and a style issue pointed out by Johannes
   Altimanninger
 * Fixed misleading commit messages in new test cases
 * Fixed my comments about how commit-tree could be used to correctly use
   two -p flags

Elijah Newren (12):
  merge-tree: rename merge_trees() to trivial_merge_trees()
  merge-tree: move logic for existing merge into new function
  merge-tree: add option parsing and initial shell for real merge
    function
  merge-tree: implement real merges
  merge-ort: split out a separate display_update_messages() function
  merge-tree: support including merge messages in output
  merge-ort: provide a merge_get_conflicted_files() helper function
  merge-tree: provide a list of which files have conflicts
  merge-tree: provide easy access to `ls-files -u` style info
  merge-tree: allow `ls-files -u` style info to be NUL terminated
  merge-tree: add a --allow-unrelated-histories flag
  git-merge-tree.txt: add a section on potentional usage mistakes

 Documentation/git-merge-tree.txt | 204 ++++++++++++++++++++++++--
 builtin/merge-tree.c             | 189 ++++++++++++++++++++++--
 git.c                            |   2 +-
 merge-ort.c                      | 109 +++++++++-----
 merge-ort.h                      |  29 ++++
 t/t4301-merge-tree-write-tree.sh | 238 +++++++++++++++++++++++++++++++
 6 files changed, 709 insertions(+), 62 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh


base-commit: ea5df61cf358d3c831189e2f04863abc2157e3e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1122%2Fnewren%2Fin-core-merge-tree-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1122/newren/in-core-merge-tree-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1122

Range-diff vs v4:

  1:  4a7cd5542bb =  1:  4a7cd5542bb merge-tree: rename merge_trees() to trivial_merge_trees()
  2:  4780ff6784d =  2:  4780ff6784d merge-tree: move logic for existing merge into new function
  3:  60253745f5c =  3:  60253745f5c merge-tree: add option parsing and initial shell for real merge function
  4:  d7b51da94e6 !  4:  7994775a934 merge-tree: implement real merges
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +conflicting stages to the standard output in a semi-diff format.
      +Since this was designed for higher level scripts to consume and merge
      +the results back into the index, it omits entries that match
     -+<branch1>.  The result of this second form is is similar to what
     ++<branch1>.  The result of this second form is similar to what
      +three-way 'git read-tree -m' does, but instead of storing the results
      +in the index, the command outputs the entries to the standard output.
      +This form not only has limited applicability, the output format is
     @@ t/t4301-merge-tree-write-tree.sh (new)
      +. ./test-lib.sh
      +
      +# This test is ort-specific
     -+if test "${GIT_TEST_MERGE_ALGORITHM}" != "ort"
     ++if test "$GIT_TEST_MERGE_ALGORITHM" != "ort"
      +then
      +	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
      +	test_done
     @@ t/t4301-merge-tree-write-tree.sh (new)
      +'
      +
      +test_expect_success 'Clean merge' '
     -+	git merge-tree --write-tree side1 side3 >RESULT &&
     ++	TREE_OID=$(git merge-tree --write-tree side1 side3) &&
      +	q_to_tab <<-EOF >expect &&
      +	100644 blob $(git rev-parse side1:greeting)Qgreeting
      +	100644 blob $(git rev-parse side1:numbers)Qsequence
      +	100644 blob $(git rev-parse side1:whatever)Qwhatever
      +	EOF
      +
     -+	git ls-tree $(cat RESULT) >actual &&
     ++	git ls-tree $TREE_OID >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'Content merge and a few conflicts' '
      +	git checkout side1^0 &&
      +	test_must_fail git merge side2 &&
     -+	expected_tree=$(cat .git/AUTO_MERGE) &&
     ++	expected_tree=$(git rev-parse AUTO_MERGE) &&
      +
      +	# We will redo the merge, while we are still in a conflicted state!
      +	test_when_finished "git reset --hard" &&
     @@ t/t4301-merge-tree-write-tree.sh (new)
      +
      +	# greeting should have a merge conflict
      +	git show ${expected_tree}:greeting >tmp &&
     -+	cat tmp | sed -e s/HEAD/side1/ >expect &&
     ++	sed -e s/HEAD/side1/ tmp >expect &&
      +	git show ${actual_tree}:greeting >actual &&
      +	test_cmp expect actual
      +'
  5:  58a5594aeb6 =  5:  e0f95e094cf merge-ort: split out a separate display_update_messages() function
  6:  fa55cb4d644 =  6:  90c4adecb23 merge-tree: support including merge messages in output
  7:  f3ad7add515 =  7:  12e2351092a merge-ort: provide a merge_get_conflicted_files() helper function
  8:  6058190d1b1 =  8:  5bb7d3725ad merge-tree: provide a list of which files have conflicts
  9:  435f66ea699 !  9:  3c2ca198cec merge-tree: provide easy access to `ls-files -u` style info
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content merge and a few conflicts' '
     - 	expected_tree=$(cat .git/AUTO_MERGE) &&
     + 	expected_tree=$(git rev-parse AUTO_MERGE) &&
       
       	# We will redo the merge, while we are still in a conflicted state!
      +	git ls-files -u >conflicted-file-info &&
 10:  5f253e298b3 = 10:  6e89e17693a merge-tree: allow `ls-files -u` style info to be NUL terminated
 11:  e706cf31c6e = 11:  6ddd5ffde9c merge-tree: add a --allow-unrelated-histories flag
 12:  c279236ab65 = 12:  7abf633b638 git-merge-tree.txt: add a section on potentional usage mistakes

-- 
gitgitgadget
