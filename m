Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B53C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383624AbiFRAVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383234AbiFRAVH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B934559308
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g27so864459wrb.10
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BKlm205JGRDRHfyY2bKLwJl/MLPPButVvrByw19Bmm0=;
        b=EN4x4X2TqT1tA6DTR2aX8DDgsMLQ2K2q3EEalhhZN0PK+mfnUrIw+KBC6f8126We2W
         aq617JCi9ew0vjwBURkw7jzo4Xh8+T62xxfWZ9B5UhR7EDJDXnjwMl8G/iqDKkofU0rT
         xy82fKfqgEQGpa38B+15jm+zwe/dYMIAsADbSHpn29iUfmV45QiqBuswomQ0UTTm43Xc
         NkuHa7fZQ9BXTKSBYe6mmwwobHLP07PJYc2YpYlM/IhET6rWiSQBKwz9xYN+ZcNSlzOY
         3yqqrknjd1WDAyoTISKoY7MXjjIWKmjC2l0JzgEdqp8IJVZEIWyv3bzIKqhvKNLZbd/e
         oSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BKlm205JGRDRHfyY2bKLwJl/MLPPButVvrByw19Bmm0=;
        b=K8utmE2FPMhPUVkBmviPYMHuhsuMutf1foBeAGFht4ysFUAkiKT9qsoWjxP4Mq2iR+
         IHUatd6Q3rpcNq9N1f3019nP2S+YGr0TeGioB+/AY0kiEbV2A2i0DLJwXW3P0wxtiulK
         7Woefr3De+DqnOFZQGEX728rboJvnpY1f2Q4zCy9BILnyU7juOVhK4ztfXz/CdkKmQXe
         pz9TaXslwH/OUwiVuxTQNq0VJbXR4m3FSYzOZfqHE+WVXUUDpHUvZB/RJA4EspqZ6aDY
         7U+LeH0MRFbpRFlBW+oQc0tFAqhdiWLo1TfxKVxKvX8taLuAdpln5TP3bSrXjDB7GFeg
         evwQ==
X-Gm-Message-State: AJIora8IlGNLAmfYetKWGGL0Ljsn0Gy+iMMJdSLn9NkUy5Zj9VzHiSBt
        h5ARn1kD33wIrIQGK+RzOyx6DStEh4+fTA==
X-Google-Smtp-Source: AGRyM1uVWtnSeEOKsCzYn56tFD92k61FBA8DBH6O5dA92wm0oJSqwvxfo8MYcazAOBmf/RRLdBG7Gw==
X-Received: by 2002:a05:6000:1869:b0:211:7f25:89da with SMTP id d9-20020a056000186900b002117f2589damr11790273wri.696.1655511661742;
        Fri, 17 Jun 2022 17:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc3-20020a5d5c03000000b00213ba3384aesm5383887wrb.35.2022.06.17.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:01 -0700 (PDT)
Message-Id: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:43 +0000
Subject: [PATCH v7 00/17] In-core git merge-tree ("Server side merges")
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

Sorry for the long delay. Much thanks to Johannes for tying up the loose
ends and making several improvements seen in this round. Note: rebased on
main (it's been 4 months since v6, and there were a few conflicts...).

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
 * Patches 7-15: add ability to include ls-files -u style of info in the
   output
 * Patch 16: support --allow-unrelated-histories
 * Patch 17: augment the manual with potential usage mistakes

== Updates Log ==

Stuff NOT included that reviewers brought up in various rounds (and which
might still be an open question):

 * Very generic (mode, oid, stage, filename) printing formatting[3]
 * Providing similar functionality for doing cherry-picks/rebases/reverts,
   i.e. a scheme for three-way merges with a specified merge-base[4]. That's
   being deferred to a future series. [3]
   https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0it3z7TPn_w@mail.gmail.com/
   [4]
   https://lore.kernel.org/git/CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com/

Updates since v6:

 * Significant merge-ort changes to support machine-parseable information
   about individual conflicts and the paths involved in each, rather than
   just a group of free-form output messages that may change over time. This
   includes 5 new patches, 2 written by Johannes (and with breaking out the
   other 3 from some work-in-progress changes I had including some fixes and
   improvements he added).

Updates since v5:

 * Used reverse_commit_list() to reverse a commit_list without extra
   allocations
 * Several documentation updates

Updates since v4:

 * Fixed double "is" in documentation.
 * Fixed a few small items with testcases

Updates since v3:

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

[There were also two submissions of a previous series; see
https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/]
[https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/%5D]

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

Elijah Newren (15):
  merge-tree: rename merge_trees() to trivial_merge_trees()
  merge-tree: move logic for existing merge into new function
  merge-tree: add option parsing and initial shell for real merge
    function
  merge-tree: implement real merges
  merge-ort: split out a separate display_update_messages() function
  merge-tree: support including merge messages in output
  merge-ort: provide a merge_get_conflicted_files() helper function
  merge-ort: remove command-line-centric submodule message from
    merge-ort
  merge-tree: provide a list of which files have conflicts
  merge-tree: provide easy access to `ls-files -u` style info
  merge-ort: store more specific conflict information
  merge-ort: optionally produce machine-readable output
  merge-tree: allow `ls-files -u` style info to be NUL terminated
  merge-tree: add a --allow-unrelated-histories flag
  git-merge-tree.txt: add a section on potentional usage mistakes

Johannes Schindelin (2):
  merge-ort: store messages in a list, not in a single strbuf
  merge-ort: make `path_messages` a strmap to a string_list

 Documentation/git-merge-tree.txt | 235 ++++++++++++++-
 builtin/merge-tree.c             | 187 +++++++++++-
 diff.c                           |  27 +-
 git.c                            |   2 +-
 merge-ort.c                      | 474 ++++++++++++++++++++++---------
 merge-ort.h                      |  32 ++-
 t/t4301-merge-tree-write-tree.sh | 240 ++++++++++++++++
 t/t6437-submodule-merge.sh       |   2 +-
 8 files changed, 1032 insertions(+), 167 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh


base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1122%2Fnewren%2Fin-core-merge-tree-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1122/newren/in-core-merge-tree-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1122

Range-diff vs v6:

  1:  4a7cd5542bb =  1:  8fb51817ed4 merge-tree: rename merge_trees() to trivial_merge_trees()
  2:  4780ff6784d =  2:  8e0a79fa1ad merge-tree: move logic for existing merge into new function
  3:  60253745f5c =  3:  baf0950bcb6 merge-tree: add option parsing and initial shell for real merge function
  4:  f8266d39c1b =  4:  697470e50ae merge-tree: implement real merges
  5:  6629af14919 =  5:  069af1ecc30 merge-ort: split out a separate display_update_messages() function
  6:  17b57efb714 =  6:  53c92a5d8d9 merge-tree: support including merge messages in output
  7:  4c8f42372dd =  7:  67a728d35f0 merge-ort: provide a merge_get_conflicted_files() helper function
  -:  ----------- >  8:  6419487e26b merge-ort: remove command-line-centric submodule message from merge-ort
  8:  7b1ee417f3d !  9:  c92b81e7366 merge-tree: provide a list of which files have conflicts
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
      +		string_list_clear(&conflicted_files, 1);
      +	}
       	if (o->show_messages) {
     - 		printf("\n");
     +-		printf("\n");
     ++		putchar(line_termination);
       		merge_display_update_messages(&opt, &result);
     + 	}
     + 	merge_finalize(&opt, &result);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       
       	/* Do the relevant type of merge */
  9:  f1231a8fbc8 = 10:  d7360f58f16 merge-tree: provide easy access to `ls-files -u` style info
  -:  ----------- > 11:  f523b08ab5a merge-ort: store messages in a list, not in a single strbuf
  -:  ----------- > 12:  6b47c0fdbd7 merge-ort: make `path_messages` a strmap to a string_list
  -:  ----------- > 13:  7eb70f77c81 merge-ort: store more specific conflict information
  -:  ----------- > 14:  662e97f2ed4 merge-ort: optionally produce machine-readable output
 10:  22297e6ce75 ! 15:  b314aa9c436 merge-tree: allow `ls-files -u` style info to be NUL terminated
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	if (!result.clean) {
       		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
       		const char *last = NULL;
     -@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     - 		string_list_clear(&conflicted_files, 1);
     - 	}
     - 	if (o->show_messages) {
     --		printf("\n");
     -+		putchar(line_termination);
     - 		merge_display_update_messages(&opt, &result);
     - 	}
     - 	merge_finalize(&opt, &result);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       			    N_("do a trivial merge only"), MODE_TRIVIAL),
       		OPT_BOOL(0, "messages", &o.show_messages,
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check conflicted oids and
      +
      +	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
      +	anonymize_hash out >actual &&
     ++	printf "\\n" >>actual &&
      +
      +	# Expected results:
      +	#   "greeting" should merge with conflicts
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check conflicted oids and
      +
      +	EOF
      +
     -+	cat <<-EOF >>expect &&
     -+	Auto-merging greeting
     -+	CONFLICT (content): Merge conflict in greeting
     -+	CONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
     -+	CONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
     -+	Auto-merging Αυτά μου φαίνονται κινέζικα
     -+	CONFLICT (content): Merge conflict in Αυτά μου φαίνονται κινέζικα
     ++	q_to_nul <<-EOF >>expect &&
     ++	1QgreetingQAuto-mergingQAuto-merging greeting
     ++	Q1QgreetingQCONFLICT (contents)QCONFLICT (content): Merge conflict in greeting
     ++	Q2Qwhatever~tweak1QwhateverQCONFLICT (file/directory)QCONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
     ++	Q1Qwhatever~tweak1QCONFLICT (modify/delete)QCONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
     ++	Q1QΑυτά μου φαίνονται κινέζικαQAuto-mergingQAuto-merging Αυτά μου φαίνονται κινέζικα
     ++	Q1QΑυτά μου φαίνονται κινέζικαQCONFLICT (contents)QCONFLICT (content): Merge conflict in Αυτά μου φαίνονται κινέζικα
     ++	Q
      +	EOF
      +
      +	test_cmp expect actual
 11:  db73c6dd823 = 16:  66df0c2e837 merge-tree: add a --allow-unrelated-histories flag
 12:  d58a7c7a9f6 ! 17:  70ea8281952 git-merge-tree.txt: add a section on potentional usage mistakes
     @@ Documentation/git-merge-tree.txt: with linkgit:git-merge[1]:
      +<<IM,Informational messages>> section has the necessary info, though it
      +is not designed to be machine parseable.
      +
     ++Do NOT assume that each paths from <<CFI,Conflicted file info>>, and
     ++the logical conflicts in the <<IM,Informational messages>> have a
     ++one-to-one mapping, nor that there is a one-to-many mapping, nor a
     ++many-to-one mapping.  Many-to-many mappings exist, meaning that each
     ++path can have many logical conflict types in a single merge, and each
     ++logical conflict type can affect many paths.
     ++
      +Do NOT assume all filenames listed in the <<IM,Informational messages>>
      +section had conflicts.  Messages can be included for files that have no
      +conflicts, such as "Auto-merging <file>".

-- 
gitgitgadget
