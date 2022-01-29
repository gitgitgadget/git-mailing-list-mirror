Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76DC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353003AbiA2SHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbiA2SHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D907C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:17 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso10619131wmj.2
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RFevl3IDGcEtSfXYHjDsocaGuFShmRxf21r/rmordIY=;
        b=OvNZIa6aVnWep7J4hs1u64cXST6z2ZNtODFZDlSF4shctsscDTJhEkFULTcl7TLAne
         q//JKi6z+qmcWUqlGI/1tzpFucH4FvvMbX4EXeZeJeQVzzDeOaATggwY93wrABhytGBG
         MZitFAr8VF/vDNXNk4GeS2DGWs6YQh3sMII1CrNxzkhfnAV6SZ/axH+k8Rdp+99FyPvw
         XZvzWSZAXsaDzZX1PJHX4oa+lPRWodaEvmQ1poSpo6yDLmVISbgyxqr6ZO1hiKmvNiqL
         GEjvfOCgFc5ZTwjSXg7gK71mZ+AMqJ8gK4JDvwQnAaiMwytbRZOnPt6+eBr2rlU9Fe4B
         5Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RFevl3IDGcEtSfXYHjDsocaGuFShmRxf21r/rmordIY=;
        b=3/jzY9aFacM7i37Wr+2ClAWFhqLWXBg9jO/cTfJPb/dHehUl71BFiL2T36zrXE9TbL
         R8eljtnTY9W8qN65ikzGSEdBvjNFVxmynB+eCWHdv/7NA6I7mBHe+uQs3iJJxLuTSqO6
         Uunn+KcVv/+44GBauC4C1aonKIcZ13Vj6gP6neIevhU4B2sOxu0iFhupqIAyAEEB+VP7
         la+nJEBhPB44ckZcOj/U9gw1Du5K3uIsn1VuBiNtCTquDiqlFfisFz2wqMAZ8+VbZeBU
         BuwyRgHJOWpetLIaC40XeURpwSefflP1OS2NKp9zvUQEo2nzwE4APqfLRiv5kf4K+WGW
         qMsw==
X-Gm-Message-State: AOAM5329NfYxfekfkYPPPck2xEtHeGJTTeQYboTFs4mwkGUgv8aoZqKa
        PIUqlYGifnHaOvFVmLMitnr6bfdV8Tc=
X-Google-Smtp-Source: ABdhPJxkkSMsKjnVPO57B8hRdiC7Tl+Cg+JW67sQsF6fmR1FjyrKukI/sa5nBK+MBOP4LorlFqpslg==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr20456154wmk.113.1643479635199;
        Sat, 29 Jan 2022 10:07:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm941443wmq.24.2022.01.29.10.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:14 -0800 (PST)
Message-Id: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:00 +0000
Subject: [PATCH v2 00/13] In-core git merge-tree ("Server side merges")
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: Depends on en/remerge-diff

(Note2: This is a continuation of my series at [0], but I can't change the
base repository for a pull request in GitHub so I had to open a new PR and
that makes it look like a new series. [0]
https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/)

== Basic Summary ==

This series introduces a new mode to git merge-tree allowing it to perform
real merges (three-way text content merges, recursive ancestor
consolidation, rename detection, proper directory/file conflict handling,
etc.) and write the result as a toplevel tree. It doesn't touch the working
tree or index, and doesn't create any commits or update any refs.

== Updates Log ==

Stuff NOT included that reviewers brought up in the last round:

 * Very generic (mode, oid, stage, filename) printing formatting[1]
 * Always printing 3 stages for each filename with conflicts[2] [1]
   https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0it3z7TPn_w@mail.gmail.com/
   [2]
   https://lore.kernel.org/git/CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com/

Updates since v3 (which looks like v1 due to the re-submit; thanks to René,
Ævar, Christian, Dscho for very helpful feedback):

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

Updates since v2 (thanks to Christian, Dscho, Ramsay, and René for
suggestions and comments on v2):

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

Updates since v1 (thanks to Johannes Altmanninger and Fabian for suggestions
on v1):

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
  merge-ort: allow update messages to be written to different file
    stream
  merge-tree: support including merge messages in output
  merge-ort: provide a merge_get_conflicted_files() helper function
  merge-tree: provide a list of which files have conflicts
  merge-tree: provide easy access to `ls-files -u` style info
  merge-tree: add a --allow-unrelated-histories flag
  git-merge-tree.txt: add a section on potentional usage mistakes

Johannes Schindelin (1):
  diff: allow diff_warn_rename_limit to write somewhere besides stdout

 Documentation/git-merge-tree.txt | 179 ++++++++++++++++++++++++++++---
 builtin/merge-tree.c             | 162 +++++++++++++++++++++++++---
 diff.c                           |  20 ++--
 diff.h                           |   3 +-
 git.c                            |   2 +-
 merge-ort.c                      | 109 ++++++++++++-------
 merge-ort.h                      |  30 ++++++
 merge-recursive.c                |   3 +-
 t/t4301-merge-tree-write-tree.sh | 164 ++++++++++++++++++++++++++++
 9 files changed, 603 insertions(+), 69 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh


base-commit: ea5df61cf358d3c831189e2f04863abc2157e3e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1122%2Fnewren%2Fin-core-merge-tree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1122/newren/in-core-merge-tree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1122

Range-diff vs v1:

  1:  4a7cd5542bb =  1:  4a7cd5542bb merge-tree: rename merge_trees() to trivial_merge_trees()
  2:  4780ff6784d =  2:  4780ff6784d merge-tree: move logic for existing merge into new function
  3:  65fdae9ddba !  3:  63f42df21ae merge-tree: add option parsing and initial shell for real merge function
     @@ builtin/merge-tree.c: static int trivial_merge(int argc, const char **argv)
       }
       
      +struct merge_tree_options {
     -+	int real;
     -+	int trivial;
     ++	int mode;
      +};
      +
      +static int real_merge(struct merge_tree_options *o,
     @@ builtin/merge-tree.c: static int trivial_merge(int argc, const char **argv)
      +		NULL
      +	};
      +	struct option mt_options[] = {
     -+		OPT_BOOL(0, "write-tree", &o.real,
     -+			 N_("do a real merge instead of a trivial merge")),
     -+		OPT_BOOL(0, "trivial-merge", &o.trivial,
     -+			 N_("do a trivial merge only")),
     ++		OPT_CMDMODE(0, "write-tree", &o.mode,
     ++			    N_("do a real merge instead of a trivial merge"),
     ++			    'w'),
     ++		OPT_CMDMODE(0, "trivial-merge", &o.mode,
     ++			    N_("do a trivial merge only"), 't'),
      +		OPT_END()
      +	};
      +
     -+	/* Check for a request for basic help */
     -+	if (argc == 2 && !strcmp(argv[1], "-h"))
     -+		usage_with_options(merge_tree_usage, mt_options);
     -+
      +	/* Parse arguments */
      +	argc = parse_options(argc, argv, prefix, mt_options,
     -+			     merge_tree_usage, 0);
     -+	if (o.real && o.trivial)
     -+		die(_("--write-tree and --trivial-merge are incompatible"));
     -+	if (o.real || o.trivial) {
     -+		expected_remaining_argc = (o.real ? 2 : 3);
     ++			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
     ++	if (o.mode) {
     ++		expected_remaining_argc = (o.mode == 'w' ? 2 : 3);
      +		if (argc != expected_remaining_argc)
      +			usage_with_options(merge_tree_usage, mt_options);
      +	} else {
      +		if (argc < 2 || argc > 3)
      +			usage_with_options(merge_tree_usage, mt_options);
     -+		o.real = (argc == 2);
     ++		o.mode = (argc == 2 ? 'w' : 't');
      +	}
      +
      +	/* Do the relevant type of merge */
     -+	if (o.real)
     ++	if (o.mode == 'w')
      +		return real_merge(&o, argv[0], argv[1]);
      +	else
      +		return trivial_merge(argv[0], argv[1], argv[2]);
  4:  05bd17686e1 !  4:  02c29f920d0 merge-tree: implement real merges
     @@ Commit message
      
          The only output is:
            - the toplevel resulting tree printed on stdout
     -      - exit status of 0 (clean) or 1 (conflicts present)
     +      - exit status of 0 (clean), 1 (conflicts present), anything else
     +        (merge could not be performed; unknown if clean or conflicted)
      
          This output is meant to be used by some higher level script, perhaps in
          a sequence of steps like this:
     @@ Commit message
          preliminary implementation, but subsequent commits will add that
          ability.
      
     +    This also marks the traditional trivial merge of merge-tree as
     +    deprecated.  The trivial merge not only had limited applicability, the
     +    output format was also difficult to work with (and its format
     +    undocumented), and will generally be less performant than real merges.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
       [verse]
      -'git merge-tree' <base-tree> <branch1> <branch2>
      +'git merge-tree' [--write-tree] <branch1> <branch2>
     -+'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2>
     ++'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
       
       DESCRIPTION
       -----------
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +Performs a merge, but does not make any new commits and does not read
      +from or write to either the working tree or index.
      +
     -+The first form will merge the two branches, doing a full recursive
     -+merge with rename detection.  The rest of this manual (other than the
     -+next paragraph) describes the first form in more detail -- including
     -+options, output format, exit status, and usage notes.
     -+
     -+The second form is deprecated; it is kept for backward compatibility
     -+reasons but may be deleted in the future.  It will only do a trivial
     -+merge.  It reads three tree-ish, and outputs trivial merge results and
     -+conflicting stages to the standard output in a semi-diff format.
     -+Since this was designed for higher level scripts to consume and merge
     -+the results back into the index, it omits entries that match
     -+<branch1>.  The result of this second form is is similar to what
     -+three-way 'git read-tree -m' does, but instead of storing the results
     -+in the index, the command outputs the entries to the standard output.
     -+This form not only has limited applicability, the output format is
     -+also difficult to work with, and it will generally be less performant
     -+than the first form even on successful merges (especially if working
     -+in large repositories).  The remainder of this manual will only
     -+discuss the first form.
     ++The second form is deprecated and supported only for backward
     ++compatibility.  It will likely be removed in the future, and will not
     ++be discussed further in this manual.
     ++
     ++The first form will merge the two branches, doing a real merge.  A real
     ++merge is distinguished from a trivial merge in that it includes:
     ++
     ++  * three way content merges of individual files
     ++  * rename detection
     ++  * proper directory/file conflict handling
     ++  * recursive ancestor consolidation (i.e. when there is more than one
     ++    merge base, creating a virtual merge base by merging the merge bases)
     ++  * etc.
     ++
     ++After the merge completes, it will create a new toplevel tree object.
     ++See `OUTPUT` below for details.
      +
      +OUTPUT
      +------
     @@ builtin/merge-tree.c: struct merge_tree_options {
      +
      +	parent1 = get_merge_parent(branch1);
      +	if (!parent1)
     -+		help_unknown_ref(branch1, "merge",
     ++		help_unknown_ref(branch1, "merge-tree",
      +				 _("not something we can merge"));
      +
      +	parent2 = get_merge_parent(branch2);
      +	if (!parent2)
     -+		help_unknown_ref(branch2, "merge",
     ++		help_unknown_ref(branch2, "merge-tree",
      +				 _("not something we can merge"));
      +
      +	init_merge_options(&opt, the_repository);
     -+	/*
     -+	 * TODO: Support subtree and other -X options?
     -+	if (use_strategies_nr == 1 &&
     -+	    !strcmp(use_strategies[0]->name, "subtree"))
     -+		opt.subtree_shift = "";
     -+	for (x = 0; x < xopts_nr; x++)
     -+		if (parse_merge_opt(&opt, xopts[x]))
     -+			die(_("Unknown strategy option: -X%s"), xopts[x]);
     -+	*/
      +
      +	opt.show_rename_progress = 0;
      +
     -+	opt.branch1 = merge_remote_util(parent1)->name; /* or just branch1? */
     -+	opt.branch2 = merge_remote_util(parent2)->name; /* or just branch2? */
     ++	opt.branch1 = branch1;
     ++	opt.branch2 = branch2;
      +
      +	/*
      +	 * Get the merge bases, in reverse order; see comment above
     @@ builtin/merge-tree.c: struct merge_tree_options {
      +		commit_list_insert(j->item, &merge_bases);
      +
      +	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
     -+	printf("%s\n", oid_to_hex(&result.tree->object.oid));
      +	if (result.clean < 0)
      +		die(_("failure to merge"));
     -+	else if (!result.clean)
     -+		printf(_("Conflicts!\n"));
     ++	puts(oid_to_hex(&result.tree->object.oid));
      +	merge_finalize(&opt, &result);
      +	return !result.clean; /* result.clean < 0 handled above */
       }
       
       int cmd_merge_tree(int argc, const char **argv, const char *prefix)
      
     - ## t/t4301-merge-tree-real.sh (new) ##
     + ## t/t4301-merge-tree-write-tree.sh (new) ##
      @@
      +#!/bin/sh
      +
     @@ t/t4301-merge-tree-real.sh (new)
      +. ./test-lib.sh
      +
      +# This test is ort-specific
     -+test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort || {
     ++if test "${GIT_TEST_MERGE_ALGORITHM}" != "ort"
     ++then
      +	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
      +	test_done
     -+}
     ++fi
      +
      +test_expect_success setup '
      +	test_write_lines 1 2 3 4 5 >numbers &&
  -:  ----------- >  5:  6fb4f4580a5 diff: allow diff_warn_rename_limit to write somewhere besides stdout
  5:  095aa266c2b !  6:  28368c03898 merge-ort: split out a separate display_update_messages() function
     @@ Metadata
       ## Commit message ##
          merge-ort: split out a separate display_update_messages() function
      
     -    No functional changes included in this patch; it's just a preparatory
     -    step to allow the printed messages to be handled differently by other
     -    callers, such as in `git merge-tree --write-tree`.
     +    This patch includes no new code; it simply moves a bunch of lines into a
     +    new function.  As such, there are no functional changes.  This is just a
     +    preparatory step to allow the printed messages to be handled differently
     +    by other callers, such as in `git merge-tree --write-tree`.
     +
     +    (Patch best viewed with
     +         --color-moved --color-moved-ws=allow-indentation-change
     +     to see that it is a simple code movement.)
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
      +
      +	/* Also include needed rename limit adjustment now */
      +	diff_warn_rename_limit("merge.renamelimit",
     -+			       opti->renames.needed_limit, 0);
     ++			       opti->renames.needed_limit, 0, stdout);
      +
      +	trace2_region_leave("merge", "display messages", opt->repo);
      +}
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      -
      -		/* Also include needed rename limit adjustment now */
      -		diff_warn_rename_limit("merge.renamelimit",
     --				       opti->renames.needed_limit, 0);
     +-				       opti->renames.needed_limit, 0, stdout);
      -
      -		trace2_region_leave("merge", "display messages", opt->repo);
      -	}
  6:  e3ef17eb46f !  7:  593d0c00b57 merge-ort: allow update messages to be written to different file stream
     @@ merge-ort.c: void merge_display_update_messages(struct merge_options *opt,
       		struct strbuf *sb = olist.items[i].util;
       
      -		printf("%s", sb->buf);
     -+		fprintf(stream, "%s", sb->buf);
     ++		strbuf_write(sb, stream);
       	}
       	string_list_clear(&olist, 0);
       
     + 	/* Also include needed rename limit adjustment now */
     + 	diff_warn_rename_limit("merge.renamelimit",
     +-			       opti->renames.needed_limit, 0, stdout);
     ++			       opti->renames.needed_limit, 0, stream);
     + 
     + 	trace2_region_leave("merge", "display messages", opt->repo);
     + }
      @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
       	}
       
  7:  2f296aeeefb !  8:  d0d30e92ecd merge-tree: support including merge messages in output
     @@ Commit message
          When running `git merge-tree --write-tree`, we previously would only
          return an exit status reflecting the cleanness of a merge, and print out
          the toplevel tree of the resulting merge.  Merges also have
     -    informational messages, ("Auto-merging <PATH>", "CONFLICT (content):
     -    ...", "CONFLICT (file/directory)", etc.)  In fact, when non-content
     -    conflicts occur (such as file/directory, modify/delete, add/add with
     -    differing modes, rename/rename (1to2), etc.), these informational
     -    messages are often the only notification since these conflicts are not
     -    representable in the contents of the file.
     +    informational messages, such as:
     +      * "Auto-merging <PATH>"
     +      * "CONFLICT (content): ..."
     +      * "CONFLICT (file/directory)"
     +      * etc.
     +    In fact, when non-content conflicts occur (such as file/directory,
     +    modify/delete, add/add with differing modes, rename/rename (1to2),
     +    etc.), these informational messages may be the only notification the
     +    user gets since these conflicts are not representable in the contents
     +    of the file.
      
          Add a --[no-]messages option so that callers can request these messages
          be included at the end of the output.  Include such messages by default
     @@ Documentation/git-merge-tree.txt: git-merge-tree - Perform merge without touchin
       [verse]
      -'git merge-tree' [--write-tree] <branch1> <branch2>
      +'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
     - 'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2>
     + 'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
       
       DESCRIPTION
     -@@ Documentation/git-merge-tree.txt: than the first form even on successful merges (especially if working
     - in large repositories).  The remainder of this manual will only
     - discuss the first form.
     +@@ Documentation/git-merge-tree.txt: merge is distinguished from a trivial merge in that it includes:
     + After the merge completes, it will create a new toplevel tree object.
     + See `OUTPUT` below for details.
       
      +OPTIONS
      +-------
     @@ Documentation/git-merge-tree.txt: be used as a part of a series of steps such as
      
       ## builtin/merge-tree.c ##
      @@ builtin/merge-tree.c: static int trivial_merge(const char *base,
     + 
       struct merge_tree_options {
     - 	int real;
     - 	int trivial;
     + 	int mode;
      +	int show_messages;
       };
       
       static int real_merge(struct merge_tree_options *o,
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     - 		commit_list_insert(j->item, &merge_bases);
     - 
       	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
     --	printf("%s\n", oid_to_hex(&result.tree->object.oid));
     -+
       	if (result.clean < 0)
       		die(_("failure to merge"));
     --	else if (!result.clean)
     --		printf(_("Conflicts!\n"));
      +
      +	if (o->show_messages == -1)
      +		o->show_messages = !result.clean;
      +
     -+	printf("%s\n", oid_to_hex(&result.tree->object.oid));
     + 	puts(oid_to_hex(&result.tree->object.oid));
      +	if (o->show_messages) {
      +		printf("\n");
      +		merge_display_update_messages(&opt, &result, stdout);
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       		NULL
       	};
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			 N_("do a real merge instead of a trivial merge")),
     - 		OPT_BOOL(0, "trivial-merge", &o.trivial,
     - 			 N_("do a trivial merge only")),
     + 			    'w'),
     + 		OPT_CMDMODE(0, "trivial-merge", &o.mode,
     + 			    N_("do a trivial merge only"), 't'),
      +		OPT_BOOL(0, "messages", &o.show_messages,
      +			 N_("also show informational/conflict messages")),
       		OPT_END()
       	};
       
     -@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 		usage_with_options(merge_tree_usage, mt_options);
     - 
       	/* Parse arguments */
      +	original_argc = argc;
       	argc = parse_options(argc, argv, prefix, mt_options,
     - 			     merge_tree_usage, 0);
     - 	if (o.real && o.trivial)
     - 		die(_("--write-tree and --trivial-merge are incompatible"));
     -+	if (!o.real && original_argc < argc)
     -+		die(_("--write-tree must be specified if any other options are"));
     - 	if (o.real || o.trivial) {
     - 		expected_remaining_argc = (o.real ? 2 : 3);
     - 		if (argc != expected_remaining_argc)
     + 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
     + 	if (o.mode) {
     +@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + 			usage_with_options(merge_tree_usage, mt_options);
     + 		o.mode = (argc == 2 ? 'w' : 't');
     + 	}
     ++	if (o.mode == 't' && original_argc < argc)
     ++		die(_("--trivial-merge is incompatible with all other options"));
     + 
     + 	/* Do the relevant type of merge */
     + 	if (o.mode == 'w')
      
     - ## t/t4301-merge-tree-real.sh ##
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'Barf on too many arguments' '
     + ## t/t4301-merge-tree-write-tree.sh ##
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Barf on too many arguments' '
       	grep "^usage: git merge-tree" expect
       '
       
  8:  35e0ed9271a !  9:  9c2334ae9f2 merge-ort: provide a merge_get_conflicted_files() helper function
     @@ Commit message
          merge-ort: provide a merge_get_conflicted_files() helper function
      
          After a merge, this function allows the user to extract the same
     -    information that would be printed by `ls-files -u` -- conflicted
     +    information that would be printed by `ls-files -u`, which means
          files with their mode, oid, and stage.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
  9:  fcbb087fa88 ! 10:  243134dc247 merge-tree: provide a list of which files have conflicts
     @@ builtin/merge-tree.c: struct merge_tree_options {
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       		o->show_messages = !result.clean;
       
     - 	printf("%s\n", oid_to_hex(&result.tree->object.oid));
     + 	puts(oid_to_hex(&result.tree->object.oid));
      +	if (!result.clean) {
      +		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
      +		const char *last = NULL;
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       
       	/* Do the relevant type of merge */
     - 	if (o.real)
     + 	if (o.mode == 'w')
      -		return real_merge(&o, argv[0], argv[1]);
      +		return real_merge(&o, argv[0], argv[1], prefix);
       	else
       		return trivial_merge(argv[0], argv[1], argv[2]);
       }
      
     - ## t/t4301-merge-tree-real.sh ##
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'test conflict notices and such' '
     + ## t/t4301-merge-tree-write-tree.sh ##
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'test conflict notices and such' '
       	#   "whatever" has *both* a modify/delete and a file/directory conflict
       	cat <<-EOF >expect &&
       	HASH
     @@ t/t4301-merge-tree-real.sh: test_expect_success 'test conflict notices and such'
       
       	Auto-merging greeting
       	CONFLICT (content): Merge conflict in greeting
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'test conflict notices and such' '
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'test conflict notices and such' '
       	test_cmp expect actual
       '
       
 10:  050add3e498 ! 11:  c322e4c6938 merge-tree: provide easy access to `ls-files -u` style info
     @@ Commit message
          Much like `git merge` updates the index with information of the form
              (mode, oid, stage, name)
          provide this output for conflicted files for merge-tree as well.
     -    Provide an --exclude-oids-and-modes option for users to exclude the
     -    mode, oid, and stage and only get the list of conflicted filenames.
     +    Provide an --exclude-modes-oids-stages/-l option for users to exclude
     +    the mode, oid, and stage and only get the list of conflicted filenames.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     -@@ Documentation/git-merge-tree.txt: discuss the first form.
     +@@ Documentation/git-merge-tree.txt: See `OUTPUT` below for details.
       OPTIONS
       -------
       
     @@ Documentation/git-merge-tree.txt: plumbing commands since the possibility of mer
       Part of the linkgit:git[1] suite
      
       ## builtin/merge-tree.c ##
     -@@ builtin/merge-tree.c: struct merge_tree_options {
     - 	int real;
     - 	int trivial;
     +@@ builtin/merge-tree.c: static int trivial_merge(const char *base,
     + struct merge_tree_options {
     + 	int mode;
       	int show_messages;
     -+	int exclude_oids_and_modes;
     ++	int exclude_modes_oids_stages;
       };
       
       static int real_merge(struct merge_tree_options *o,
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       			const char *name = conflicted_files.items[i].string;
      -			if (last && !strcmp(last, name))
      +			struct stage_info *c = conflicted_files.items[i].util;
     -+			if (!o->exclude_oids_and_modes)
     ++			if (!o->exclude_modes_oids_stages)
      +				printf("%06o %s %d\t",
      +				       c->mode, oid_to_hex(&c->oid), c->stage);
      +			else if (last && !strcmp(last, name))
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       			write_name_quoted_relative(
       				name, prefix, stdout, line_termination);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			 N_("do a trivial merge only")),
     + 			    N_("do a trivial merge only"), 't'),
       		OPT_BOOL(0, "messages", &o.show_messages,
       			 N_("also show informational/conflict messages")),
     -+		OPT_BOOL_F(0, "exclude-oids-and-modes",
     -+			   &o.exclude_oids_and_modes,
     -+			   N_("list conflicted files without oids and modes"),
     ++		OPT_BOOL_F('l', "exclude-modes-oids-stages",
     ++			   &o.exclude_modes_oids_stages,
     ++			   N_("list conflicted files without modes/oids/stages"),
      +			   PARSE_OPT_NONEG),
       		OPT_END()
       	};
       
      
     - ## t/t4301-merge-tree-real.sh ##
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'Content merge and a few conflicts' '
     + ## t/t4301-merge-tree-write-tree.sh ##
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content merge and a few conflicts' '
       	expected_tree=$(cat .git/AUTO_MERGE) &&
       
       	# We will redo the merge, while we are still in a conflicted state!
     @@ t/t4301-merge-tree-real.sh: test_expect_success 'Content merge and a few conflic
       	test_when_finished "git reset --hard" &&
       
       	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'Barf on too many arguments' '
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Barf on too many arguments' '
       '
       
       test_expect_success 'test conflict notices and such' '
      -	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
     -+	test_expect_code 1 git merge-tree --write-tree --exclude-oids-and-modes side1 side2 >out &&
     ++	test_expect_code 1 git merge-tree --write-tree --exclude-modes-oids-stages side1 side2 >out &&
       	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
       
       	# Expected results:
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'test conflict notices and such' '
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'test conflict notices and such' '
       '
       
       test_expect_success 'Just the conflicted files without the messages' '
      -	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
     -+	test_expect_code 1 git merge-tree --write-tree --no-messages --exclude-oids-and-modes side1 side2 >out &&
     ++	test_expect_code 1 git merge-tree --write-tree --no-messages --exclude-modes-oids-stages side1 side2 >out &&
       	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
       
       	test_write_lines HASH greeting whatever~side1 >expect &&
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'Just the conflicted files without the messages' '
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Just the conflicted files without the messages' '
       	test_cmp expect actual
       '
       
 11:  ba8a50f03cb ! 12:  25677d5038c merge-tree: add a --allow-unrelated-histories flag
     @@ Documentation/git-merge-tree.txt: OPTIONS
      
       ## builtin/merge-tree.c ##
      @@ builtin/merge-tree.c: static int trivial_merge(const char *base,
     + 
       struct merge_tree_options {
     - 	int real;
     - 	int trivial;
     + 	int mode;
      +	int allow_unrelated_histories;
       	int show_messages;
     - 	int exclude_oids_and_modes;
     + 	int exclude_modes_oids_stages;
       };
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	 * merge_incore_recursive in merge-ort.h
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	for (j = common; j; j = j->next)
       		commit_list_insert(j->item, &merge_bases);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			   &o.exclude_oids_and_modes,
     - 			   N_("list conflicted files without oids and modes"),
     + 			   &o.exclude_modes_oids_stages,
     + 			   N_("list conflicted files without modes/oids/stages"),
       			   PARSE_OPT_NONEG),
      +		OPT_BOOL_F(0, "allow-unrelated-histories",
      +			   &o.allow_unrelated_histories,
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
       	};
       
      
     - ## t/t4301-merge-tree-real.sh ##
     -@@ t/t4301-merge-tree-real.sh: test_expect_success setup '
     + ## t/t4301-merge-tree-write-tree.sh ##
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
       	>whatever/empty &&
       	git add numbers greeting whatever/empty &&
       	test_tick &&
     @@ t/t4301-merge-tree-real.sh: test_expect_success setup '
       '
       
       test_expect_success 'Content merge and a few conflicts' '
     -@@ t/t4301-merge-tree-real.sh: test_expect_success 'Check conflicted oids and modes without messages' '
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check conflicted oids and modes without messages' '
       	test_cmp conflicted-file-info actual
       '
       
 12:  4123209cafc = 13:  e7c63425a0e git-merge-tree.txt: add a section on potentional usage mistakes

-- 
gitgitgadget
