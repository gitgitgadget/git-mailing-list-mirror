Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1D2C43217
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbiBWHre (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiBWHr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157B531920
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d28so10368548wra.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bpQShdxauZ8RwaTDDS2oDMmFk6YMxY291ynuCaxYgVU=;
        b=HTc1ePxgKlnTRAz2ktshqCImOMIL6frrg5hVX7TP3ucPlj3lGdLX5CDnzY+lxlNjsp
         3PvVRco2J/OJ5LhL+/ZaiGbo3FK7iPKj7r7D+MLaBbSnOEY0LrKZM+ZG66klj6dZce6X
         sQcu31w8wSJAkmtPa5UiYz2jOsMfNxm/zgTEMr9HKUHNetDhIeiLAXrZoljUnSTjHYdK
         1SI6f44fxMEJM9Q4XXzJGqcGW5z8XIzmtGewEla59LNGjt4eYYRbvuFD3XRSNx8dnv/5
         S+aFEfswNuFAj42Z861wp9QSpY6diOdPeckA1G0KOy2oD38DnpzX02S+JkDFD16OP6Mm
         gdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bpQShdxauZ8RwaTDDS2oDMmFk6YMxY291ynuCaxYgVU=;
        b=7RVxo+2MmNSJNezCWR8SUTaYkJysmyQPx3+rw+drI0UiFuPSujpFfxDptEh7hVFt5X
         fme1P9gtoYeo6nzyNtUMT46MCYVPpXYt1SeovepVfTYhjI0PSfLEzVQpKGedMxb+78YF
         gqcjj3Onte/y/TK1SYtjGMo6PRpA+F3tmmKvqLMHF6tu6HLaeME7FmJGLYt7xOxJD3wL
         95lGEvvnnN9jNFy8cGTrVQwGX6hYVogHsNKz/ppbIdUbJjnFbWs2A64mDjN6WWUR+TPh
         A0nU/qyX9luRkv7AZH6VagKIOPhJheJaaFqxwY3kWA30RtQIGf77qN2yKq3reuTcsmqs
         LqBA==
X-Gm-Message-State: AOAM530voxDst5tpXEfVRmwOk121s4IrKIBu+UuaBgmfSCZ+QU5u/r9i
        rOrT/1h3+DlZXZ5dKwJilUKr3zrDNik=
X-Google-Smtp-Source: ABdhPJy00S23wqbDF+Zdgv2xNrYdp04gU2qH0PNAaEevPZEP0dWZ2nwIJkw4FB+j1/3KNqM6y1uI5w==
X-Received: by 2002:a05:6000:1685:b0:1e3:3bd7:d790 with SMTP id y5-20020a056000168500b001e33bd7d790mr22110415wrd.479.1645602414817;
        Tue, 22 Feb 2022 23:46:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm4239474wmb.1.2022.02.22.23.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:46:54 -0800 (PST)
Message-Id: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:41 +0000
Subject: [PATCH v6 00/12] In-core git merge-tree ("Server side merges")
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

Stuff NOT included that reviewers brought up in various rounds (and which
might still be an open question):

 * Having -z affect the informational messages section[1]
 * Having a machine-parseable variant of information from the informational
   messages section[2]
 * Very generic (mode, oid, stage, filename) printing formatting[3]
 * Providing similar functionality for doing cherry-picks/rebases/reverts,
   i.e. a scheme for three-way merges with a specified merge-base[4]. That's
   being deferred to a future series. [1]
   https://lore.kernel.org/git/CABPp-BG7id0GfpDee_7ETZ_94BC_i-e_=-u=PrYJeD7d4sVbiw@mail.gmail.com/
   [2]
   https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet/,
   https://lore.kernel.org/git/220221.86y224b80b.gmgdl@evledraar.gmail.com/
   [3]
   https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0it3z7TPn_w@mail.gmail.com/
   [4]
   https://lore.kernel.org/git/CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com/

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

 Documentation/git-merge-tree.txt | 228 +++++++++++++++++++++++++++--
 builtin/merge-tree.c             | 186 ++++++++++++++++++++++--
 git.c                            |   2 +-
 merge-ort.c                      | 109 +++++++++-----
 merge-ort.h                      |  29 ++++
 t/t4301-merge-tree-write-tree.sh | 238 +++++++++++++++++++++++++++++++
 6 files changed, 730 insertions(+), 62 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh


base-commit: ea5df61cf358d3c831189e2f04863abc2157e3e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1122%2Fnewren%2Fin-core-merge-tree-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1122/newren/in-core-merge-tree-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1122

Range-diff vs v5:

  1:  4a7cd5542bb =  1:  4a7cd5542bb merge-tree: rename merge_trees() to trivial_merge_trees()
  2:  4780ff6784d =  2:  4780ff6784d merge-tree: move logic for existing merge into new function
  3:  60253745f5c =  3:  60253745f5c merge-tree: add option parsing and initial shell for real merge function
  4:  7994775a934 !  4:  f8266d39c1b merge-tree: implement real merges
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +'git merge-tree' [--write-tree] <branch1> <branch2>
      +'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
       
     ++[[NEWMERGE]]
       DESCRIPTION
       -----------
      -Reads three tree-ish, and output trivial merge results and
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      -index.  For this reason, the output from the command omits
      -entries that match the <branch1> tree.
      +
     ++This command has a modern `--write-tree` mode and a deprecated
     ++`--trivial-merge` mode.  With the exception of the
     ++<<DEPMERGE,DEPRECATED DESCRIPTION>> section at the end, the rest of
     ++this documentation describes modern `--write-tree` mode.
     ++
      +Performs a merge, but does not make any new commits and does not read
      +from or write to either the working tree or index.
      +
     -+The first form will merge the two branches, doing a real merge.  A real
     -+merge is distinguished from a trivial merge in that it includes:
     ++The performed merge will use the same feature as the "real"
     ++linkgit:git-merge[1], including:
      +
      +  * three way content merges of individual files
      +  * rename detection
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +    merge base, creating a virtual merge base by merging the merge bases)
      +  * etc.
      +
     -+After the merge completes, the first form will create a new toplevel
     -+tree object.  See `OUTPUT` below for details.
     -+
     -+The second form is deprecated; it is kept for backward compatibility
     -+reasons but may be deleted in the future.  Other than the optional
     -+`--trivial-merge`, it accepts no options.  It can only do a trivial
     -+merge.  It reads three tree-ish, and outputs trivial merge results and
     -+conflicting stages to the standard output in a semi-diff format.
     -+Since this was designed for higher level scripts to consume and merge
     -+the results back into the index, it omits entries that match
     -+<branch1>.  The result of this second form is similar to what
     -+three-way 'git read-tree -m' does, but instead of storing the results
     -+in the index, the command outputs the entries to the standard output.
     -+This form not only has limited applicability, the output format is
     -+also difficult to work with, and it will generally be less performant
     -+than the first form even on successful merges (especially if working
     -+in large repositories).  The remainder of this manual will only
     -+discuss the first form.
     ++After the merge completes, a new toplevel tree object is created.  See
     ++`OUTPUT` below for details.
      +
     ++[[OUTPUT]]
      +OUTPUT
      +------
      +
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +USAGE NOTES
      +-----------
      +
     -+git-merge-tree was written to be low-level plumbing, similar to
     -+hash-object, mktree, commit-tree, write-tree, update-ref, and mktag.
     -+Thus, it could be used as a part of a series of steps such as
     ++This command is intended as low-level plumbing, similar to
     ++linkgit:git-hash-object[1], linkgit:git-mktree[1],
     ++linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
     ++linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
     ++used as a part of a series of steps such as:
      +
      +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
      +       test $? -eq 0 || die "There were conflicts..."
      +       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
      +       git update-ref $BRANCH1 $NEWCOMMIT
     ++
     ++[[DEPMERGE]]
     ++DEPRECATED DESCRIPTION
     ++----------------------
     ++
     ++Per the <<NEWMERGE,DESCRIPTION>> and unlike the rest of this
     ++documentation, this section describes the deprecated `--trivial-merge`
     ++mode.
     ++
     ++Other than the optional `--trivial-merge`, this mode accepts no
     ++options.
     ++
     ++This mode reads three tree-ish, and outputs trivial merge results and
     ++conflicting stages to the standard output in a semi-diff format.
     ++Since this was designed for higher level scripts to consume and merge
     ++the results back into the index, it omits entries that match
     ++<branch1>.  The result of this second form is similar to what
     ++three-way 'git read-tree -m' does, but instead of storing the results
     ++in the index, the command outputs the entries to the standard output.
     ++
     ++This form not only has limited applicability (a trivial merge cannot
     ++handle content merges of individual files, rename detection, proper
     ++directory/file conflict handling, etc.), the output format is also
     ++difficult to work with, and it will generally be less performant than
     ++the first form even on successful merges (especially if working in
     ++large repositories).
       
       GIT
       ---
     @@ builtin/merge-tree.c: struct merge_tree_options {
       {
      -	die(_("real merges are not yet implemented"));
      +	struct commit *parent1, *parent2;
     -+	struct commit_list *common;
      +	struct commit_list *merge_bases = NULL;
     -+	struct commit_list *j;
      +	struct merge_options opt;
      +	struct merge_result result = { 0 };
      +
     @@ builtin/merge-tree.c: struct merge_tree_options {
      +	 * Get the merge bases, in reverse order; see comment above
      +	 * merge_incore_recursive in merge-ort.h
      +	 */
     -+	common = get_merge_bases(parent1, parent2);
     -+	if (!common)
     ++	merge_bases = get_merge_bases(parent1, parent2);
     ++	if (!merge_bases)
      +		die(_("refusing to merge unrelated histories"));
     -+	for (j = common; j; j = j->next)
     -+		commit_list_insert(j->item, &merge_bases);
     ++	merge_bases = reverse_commit_list(merge_bases);
      +
      +	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
      +	if (result.clean < 0)
  5:  e0f95e094cf =  5:  6629af14919 merge-ort: split out a separate display_update_messages() function
  6:  90c4adecb23 !  6:  17b57efb714 merge-tree: support including merge messages in output
     @@ Documentation/git-merge-tree.txt: git-merge-tree - Perform merge without touchin
      +'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
       'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
       
     - DESCRIPTION
     -@@ Documentation/git-merge-tree.txt: than the first form even on successful merges (especially if working
     - in large repositories).  The remainder of this manual will only
     - discuss the first form.
     + [[NEWMERGE]]
     +@@ Documentation/git-merge-tree.txt: linkgit:git-merge[1], including:
     + After the merge completes, a new toplevel tree object is created.  See
     + `OUTPUT` below for details.
       
      +OPTIONS
      +-------
     @@ Documentation/git-merge-tree.txt: than the first form even on successful merges
      +	default is to include these messages if there are merge
      +	conflicts, and to omit them otherwise.
      +
     + [[OUTPUT]]
       OUTPUT
       ------
       
      -For either a successful or conflicted merge, the output from
      -git-merge-tree is simply one line:
     -+By default, for a successful merge, the output from git-merge-tree is
     -+simply one line:
     ++For a successful merge, the output from git-merge-tree is simply one
     ++line:
      +
      +	<OID of toplevel tree>
      +
     @@ Documentation/git-merge-tree.txt: than the first form even on successful merges
      -The printed tree object corresponds to what would be checked out in
      -the working tree at the end of `git merge`, and thus may have files
      -with conflict markers in them.
     ++[[OIDTLT]]
      +OID of toplevel tree
      +~~~~~~~~~~~~~~~~~~~~
      +
     @@ Documentation/git-merge-tree.txt: than the first form even on successful merges
      +working tree at the end of `git merge`.  If there were conflicts, then
      +files within this tree may have embedded conflict markers.
      +
     ++[[IM]]
      +Informational messages
      +~~~~~~~~~~~~~~~~~~~~~~
      +
     @@ Documentation/git-merge-tree.txt: than the first form even on successful merges
       
       EXIT STATUS
       -----------
     -@@ Documentation/git-merge-tree.txt: Thus, it could be used as a part of a series of steps such as
     +@@ Documentation/git-merge-tree.txt: used as a part of a series of steps such as:
              NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
              git update-ref $BRANCH1 $NEWCOMMIT
       
     -+Note that when the exit status is non-zero, NEWTREE in this sequence
     ++Note that when the exit status is non-zero, `NEWTREE` in this sequence
      +will contain a lot more output than just a tree.
      +
     - GIT
     - ---
     - Part of the linkgit:git[1] suite
     + [[DEPMERGE]]
     + DEPRECATED DESCRIPTION
     + ----------------------
      
       ## builtin/merge-tree.c ##
      @@ builtin/merge-tree.c: enum mode {
  7:  12e2351092a =  7:  4c8f42372dd merge-ort: provide a merge_get_conflicted_files() helper function
  8:  5bb7d3725ad !  8:  7b1ee417f3d merge-tree: provide a list of which files have conflicts
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     -@@ Documentation/git-merge-tree.txt: simply one line:
     +@@ Documentation/git-merge-tree.txt: line:
       Whereas for a conflicted merge, the output is by default of the form:
       
       	<OID of toplevel tree>
     @@ Documentation/git-merge-tree.txt: This is a tree object that represents what wou
       working tree at the end of `git merge`.  If there were conflicts, then
       files within this tree may have embedded conflict markers.
       
     ++[[CFI]]
      +Conflicted file list
      +~~~~~~~~~~~~~~~~~~~~
      +
     @@ Documentation/git-merge-tree.txt: This is a tree object that represents what wou
      +as explained for the configuration variable `core.quotePath` (see
      +linkgit:git-config[1]).
      +
     + [[IM]]
       Informational messages
       ~~~~~~~~~~~~~~~~~~~~~~
     - 
      
       ## builtin/merge-tree.c ##
      @@
     @@ builtin/merge-tree.c: struct merge_tree_options {
      +		      const char *prefix)
       {
       	struct commit *parent1, *parent2;
     - 	struct commit_list *common;
     + 	struct commit_list *merge_bases = NULL;
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       		o->show_messages = !result.clean;
       
  9:  3c2ca198cec !  9:  f1231a8fbc8 merge-tree: provide easy access to `ls-files -u` style info
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     -@@ Documentation/git-merge-tree.txt: discuss the first form.
     +@@ Documentation/git-merge-tree.txt: After the merge completes, a new toplevel tree object is created.  See
       OPTIONS
       -------
       
     @@ Documentation/git-merge-tree.txt: discuss the first form.
       --[no-]messages::
       	Write any informational messages such as "Auto-merging <path>"
       	or CONFLICT notices to the end of stdout.  If unspecified, the
     -@@ Documentation/git-merge-tree.txt: simply one line:
     +@@ Documentation/git-merge-tree.txt: line:
       Whereas for a conflicted merge, the output is by default of the form:
       
       	<OID of toplevel tree>
     @@ Documentation/git-merge-tree.txt: simply one line:
       	<Informational messages>
       
       These are discussed individually below.
     -@@ Documentation/git-merge-tree.txt: This is a tree object that represents what would be checked out in the
     - working tree at the end of `git merge`.  If there were conflicts, then
     +@@ Documentation/git-merge-tree.txt: working tree at the end of `git merge`.  If there were conflicts, then
       files within this tree may have embedded conflict markers.
       
     + [[CFI]]
      -Conflicted file list
      +Conflicted file info
       ~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/git-merge-tree.txt: This is a tree object that represents what wou
      +the `--name-only` option is passed, the mode, object, and stage will
      +be omitted.
       
     + [[IM]]
       Informational messages
       ~~~~~~~~~~~~~~~~~~~~~~
       
     @@ Documentation/git-merge-tree.txt: This is a tree object that represents what wou
       
         * "Auto-merging <file>"
         * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
     -@@ Documentation/git-merge-tree.txt: Thus, it could be used as a part of a series of steps such as
     - Note that when the exit status is non-zero, NEWTREE in this sequence
     +@@ Documentation/git-merge-tree.txt: used as a part of a series of steps such as:
     + Note that when the exit status is non-zero, `NEWTREE` in this sequence
       will contain a lot more output than just a tree.
       
     -+git-merge-tree was written to provide users with the same information
     -+that they'd have access to if using `git merge`:
     -+  * what would be written to the working tree (the <OID of toplevel tree>)
     ++For conflicts, the output includes the same information that you'd get
     ++with linkgit:git-merge[1]:
     ++
     ++  * what would be written to the working tree (the
     ++    <<OIDTLT,OID of toplevel tree>>)
      +  * the higher order stages that would be written to the index (the
     -+    <Conflicted file info>)
     -+  * any messages that would have been printed to stdout (the <Informational
     -+    messages>)
     ++    <<CFI,Conflicted file info>>)
     ++  * any messages that would have been printed to stdout (the
     ++    <<IM,Informational messages>>)
      +
     - GIT
     - ---
     - Part of the linkgit:git[1] suite
     + [[DEPMERGE]]
     + DEPRECATED DESCRIPTION
     + ----------------------
      
       ## builtin/merge-tree.c ##
      @@ builtin/merge-tree.c: enum mode {
 10:  6e89e17693a ! 10:  22297e6ce75 merge-tree: allow `ls-files -u` style info to be NUL terminated
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     -@@ Documentation/git-merge-tree.txt: discuss the first form.
     +@@ Documentation/git-merge-tree.txt: After the merge completes, a new toplevel tree object is created.  See
       OPTIONS
       -------
       
     @@ Documentation/git-merge-tree.txt: discuss the first form.
      +	Do not quote filenames in the <Conflicted file info> section,
      +	and end each filename with a NUL character rather than
      +	newline.  Also begin the messages section with a NUL character
     -+	instead of a newline.  See OUTPUT below for more information.
     ++	instead of a newline.  See <<OUTPUT>> below for more information.
      +
       --name-only::
       	In the Conflicted file info section, instead of writing a list
     @@ Documentation/git-merge-tree.txt: OID of toplevel tree
      +files within this tree may have embedded conflict markers.  This section
      +is always followed by a newline (or NUL if `-z` is passed).
       
     + [[CFI]]
       Conflicted file info
     - ~~~~~~~~~~~~~~~~~~~~
      @@ Documentation/git-merge-tree.txt: This is a sequence of lines with the format
       The filename will be quoted as explained for the configuration
       variable `core.quotePath` (see linkgit:git-config[1]).  However, if
     @@ Documentation/git-merge-tree.txt: This is a sequence of lines with the format
      +be omitted.  If `-z` is passed, the "lines" are terminated by a NUL
      +character instead of a newline character.
       
     + [[IM]]
       Informational messages
       ~~~~~~~~~~~~~~~~~~~~~~
       
 11:  6ddd5ffde9c ! 11:  db73c6dd823 merge-tree: add a --allow-unrelated-histories flag
     @@ Documentation/git-merge-tree.txt: OPTIONS
      +	share no common history.  This flag can be given to override that
      +	check and make the merge proceed anyway.
      +
     + [[OUTPUT]]
       OUTPUT
       ------
     - 
      
       ## builtin/merge-tree.c ##
      @@ builtin/merge-tree.c: enum mode {
     @@ builtin/merge-tree.c: enum mode {
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	 * merge_incore_recursive in merge-ort.h
       	 */
     - 	common = get_merge_bases(parent1, parent2);
     --	if (!common)
     -+	if (!common && !o->allow_unrelated_histories)
     + 	merge_bases = get_merge_bases(parent1, parent2);
     +-	if (!merge_bases)
     ++	if (!merge_bases && !o->allow_unrelated_histories)
       		die(_("refusing to merge unrelated histories"));
     - 	for (j = common; j; j = j->next)
     - 		commit_list_insert(j->item, &merge_bases);
     + 	merge_bases = reverse_commit_list(merge_bases);
     + 
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       			   &o.name_only,
       			   N_("list filenames without modes/oids/stages"),
 12:  7abf633b638 ! 12:  d58a7c7a9f6 git-merge-tree.txt: add a section on potentional usage mistakes
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     -@@ Documentation/git-merge-tree.txt: that they'd have access to if using `git merge`:
     -   * any messages that would have been printed to stdout (the <Informational
     -     messages>)
     +@@ Documentation/git-merge-tree.txt: with linkgit:git-merge[1]:
     +   * any messages that would have been printed to stdout (the
     +     <<IM,Informational messages>>)
       
      +MISTAKES TO AVOID
      +-----------------
      +
      +Do NOT look through the resulting toplevel tree to try to find which
     -+files conflict; parse the <Conflicted file info> section instead.  Not
     -+only would parsing an entire tree be horrendously slow in large
     ++files conflict; parse the <<CFI,Conflicted file info>> section instead.
     ++Not only would parsing an entire tree be horrendously slow in large
      +repositories, there are numerous types of conflicts not representable by
      +conflict markers (modify/delete, mode conflict, binary file changed on
      +both sides, file/directory conflicts, various rename conflict
      +permutations, etc.)
      +
     -+Do NOT interpret an empty <Conflicted file info> list as a clean merge;
     -+check the exit status.  A merge can have conflicts without having
     ++Do NOT interpret an empty <<CFI,Conflicted file info>> list as a clean
     ++merge; check the exit status.  A merge can have conflicts without having
      +individual files conflict (there are a few types of directory rename
      +conflicts that fall into this category, and others might also be added
      +in the future).
      +
      +Do NOT attempt to guess or make the user guess the conflict types from
     -+the <Conflicted file info> list.  The information there is insufficient
     -+to do so.  For example: Rename/rename(1to2) conflicts (both sides
     -+renamed the same file differently) will result in three different file
     -+having higher order stages (but each only has one higher order stage),
     -+with no way (short of the <Informational messages> section) to determine
     -+which three files are related.  File/directory conflicts also result in
     -+a file with exactly one higher order stage.
     ++the <<CFI,Conflicted file info>> list.  The information there is
     ++insufficient to do so.  For example: Rename/rename(1to2) conflicts (both
     ++sides renamed the same file differently) will result in three different
     ++file having higher order stages (but each only has one higher order
     ++stage), with no way (short of the <<IM,Informational messages>> section)
     ++to determine which three files are related.  File/directory conflicts
     ++also result in a file with exactly one higher order stage.
      +Possibly-involved-in-directory-rename conflicts (when
      +"merge.directoryRenames" is unset or set to "conflicts") also result in
      +a file with exactly one higher order stage.  In all cases, the
     -+<Informational messages> section has the necessary info, though it is
     -+not designed to be machine parseable.
     ++<<IM,Informational messages>> section has the necessary info, though it
     ++is not designed to be machine parseable.
      +
     -+Do NOT assume all filenames listed in the <Informational messages>
     ++Do NOT assume all filenames listed in the <<IM,Informational messages>>
      +section had conflicts.  Messages can be included for files that have no
      +conflicts, such as "Auto-merging <file>".
      +
     -+AVOID taking the OIDS from the <Conflicted file info> and re-merging
     -+them to present the conflicts to the user.  This will lose information.
     -+Instead, look up the version of the file found within the <OID of
     -+toplevel tree> and show that instead.  In particular, the latter will
     -+have conflict markers annotated with the original branch/commit being
     -+merged and, if renames were involved, the original filename.  While you
     -+could include the original branch/commit in the conflict marker
     -+annotations when re-merging, the original filename is not available from
     -+the <Conflicted file info> and thus you would be losing information that
     -+might help the user resolve the conflict.
     ++AVOID taking the OIDS from the <<CFI,Conflicted file info>> and
     ++re-merging them to present the conflicts to the user.  This will lose
     ++information.  Instead, look up the version of the file found within the
     ++<<OIDTLT,OID of toplevel tree>> and show that instead.  In particular,
     ++the latter will have conflict markers annotated with the original
     ++branch/commit being merged and, if renames were involved, the original
     ++filename.  While you could include the original branch/commit in the
     ++conflict marker annotations when re-merging, the original filename is
     ++not available from the <<CFI,Conflicted file info>> and thus you would
     ++be losing information that might help the user resolve the conflict.
      +
     - GIT
     - ---
     - Part of the linkgit:git[1] suite
     + [[DEPMERGE]]
     + DEPRECATED DESCRIPTION
     + ----------------------

-- 
gitgitgadget
