Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D6C32771
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 00:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiIYAJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 20:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIYAJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 20:09:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE213F6E
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 17:09:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so5200241wrm.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=tDv+GxajuMa73HoO436g6YvZ75pIQUYTavZvYN+idts=;
        b=SvrxZMJvEp3YXAgEvgxtSVrk65iNewoKnkNxPmonpnExT9nTEQ916LxETbuTDfOLav
         nSU0yoBDTsFOhqENoLtjKe9qOq96HgboJ4yhePzathiC+U5lzJZy/7UYrZJNDXH1ZH4u
         lylJKKIpUhbrqTPs48HCkGF4KiWSsKsykOxio4WfrejfUS/628HjLQJxYEEAqGU27w9m
         JepUErsNt0JQumzLfk2wDyajpro9yoA1lzkJLH69w7pwnWjCvF8slLKBOppzwYz99u3F
         WB5bmiofyNxpmiGBlMqwVQcwHz28T2QatK08TDVo+RPU2//7DFyK1hAeBEH+XTRb+vi8
         E2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tDv+GxajuMa73HoO436g6YvZ75pIQUYTavZvYN+idts=;
        b=6XNVkeRyLEmvo90UXCwFkziSRqgbeTzhaI6xH+GuI098vm7zc5oLCTo3c5MzVDf/pq
         dK922w5QXa0AF++FflA5iJKm7lJyHl2hL/0JEh/HB0i+Q5Im4n6tWE0hQUlajJvtAT84
         wMhQiBrtsZbHo3Il+j7nuFFRk3FZJQUpl9y/btfWUMUM/2iu4M9v4M06gkDfjS4ikhah
         coZPTqAp1SFBZlZTteA+p18MzQrbw5HLKkwUybKeeH3s9M+jRi21C6VWddOUBS8Uujr6
         vzuSUA8nc05XRzHohPv/rYJrwJ0opIvAqrmdRAkfM03ClhxA9A+qvEBE99pjyM06Y758
         1/Kw==
X-Gm-Message-State: ACrzQf0Yec80lWF6lp1VJoaSmSj6lOIwF8L8qVKeezHwH/+qY6c525vd
        76qFW/cNiPmyjTkJdlxrSLRGa5t4JVE=
X-Google-Smtp-Source: AMsMyM5rOyMzB2HJjyNsEzX9HQqeHNFXtt88RFkEMy8fbOzRms47iE808XaxFSjW1X1x26sxlx2Dng==
X-Received: by 2002:adf:d1ca:0:b0:22a:cb10:450d with SMTP id b10-20020adfd1ca000000b0022acb10450dmr8947116wrd.120.1664064591177;
        Sat, 24 Sep 2022 17:09:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b003b477532e66sm19309326wmq.2.2022.09.24.17.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 17:09:50 -0700 (PDT)
Message-Id: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Sep 2022 00:09:48 +0000
Subject: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Once upon a time, Matheus wrote some patches to make
   git grep [--cached | <REVISION>] ...
restrict its output to the sparsity specification when working in a
sparse checkout[1].  That effort got derailed by two things:

  (1) The --sparse-index work just beginning which we wanted to avoid
      creating conflicts for
  (2) Never deciding on flag and config names and planned high level
      behavior for all commands.

More recently, Shaoxuan implemented a more limited form of Matheus'
patches that only affected --cached, using a different flag name,
but also changing the default behavior in line with what Matheus did.
This again highlighted the fact that we never decided on command line
flag names, config option names, and the big picture path forward.

The --sparse-index work has been mostly complete (or at least released
into production even if some small edges remain) for quite some time
now.  We have also had several discussions on flag and config names,
though we never came to solid conclusions.  Stolee once upon a time
suggested putting all these into some document in
Documentation/technical[3], which Victoria recently also requested[4].
I'm behind the times, but here's a patch attempting to finally do that.

Note that the "Implementation Questions" section is pretty large,
reflecting the fact that this is perhaps more RFC than proposal.

[1] https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/
    (See his second link in that email in particular)
[2] https://lore.kernel.org/git/20220908001854.206789-2-shaoxuan.yuan02@gmail.com/
[3] https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/
    (Scroll to the very end for the final few paragraphs)
[4] https://lore.kernel.org/git/cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    [RFC] sparse-checkout.txt: new document with sparse-checkout directions
    
    As noted in the title and commit message, while I have some goals &
    plans proposed here, I have a lot more in the questions category.
    Thoughts and opinions very much welcome.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1367%2Fnewren%2Fsparse-checkout-directions-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1367/newren/sparse-checkout-directions-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1367

 Documentation/technical/sparse-checkout.txt | 670 ++++++++++++++++++++
 1 file changed, 670 insertions(+)
 create mode 100644 Documentation/technical/sparse-checkout.txt

diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
new file mode 100644
index 00000000000..b213b2b3f35
--- /dev/null
+++ b/Documentation/technical/sparse-checkout.txt
@@ -0,0 +1,670 @@
+Table of contents:
+
+  * Purpose of sparse-checkouts
+  * Desired behavior
+  * Subcommand-dependent defaults
+  * Implementation Questions
+  * Implementation Goals/Plans
+  * Known bugs
+  * Reference Emails
+
+
+=== Purpose of sparse-checkouts ===
+
+sparse-checkouts exist to allow users to work with a subset of their
+files.
+
+The idea is simple enough, but there are two different high-level
+usecases which affect how some Git subcommands should behave.  Further,
+even if we only considered one of those usecases, sparse-checkouts
+modify different subcommands in over a half dozen different ways.  Let's
+start by considering the high level usecases in this section:
+
+  A) Users are _only_ interested in the sparse portion of the repo
+
+  B) Users want a sparse working tree, but are working in a larger whole
+
+It may be worth explaining both of these in a bit more detail:
+
+  (Behavior A) Users are _only_ interested in the sparse portion of the repo
+
+These folks might know there are other things in the repository, but
+don't care.  They are uninterested in other parts of the repository, and
+only want to know about changes within their area of interest.  Showing
+them other results from history (e.g. from diff/log/grep/etc.) is a
+usability annoyance, potentially a huge one since other changes in
+history may dwarf the changes they are interested in.
+
+Some of these users also arrive at this usecase from wanting to use
+partial clones together with sparse checkouts and do disconnected
+development.  Not only do these users generally not care about other
+parts of the repository, but consider it a blocker for Git commands to
+try to operate on those.  If commands attempt to access paths in history
+outside the sparsity specification, then the partial clone will attempt
+to download additional blobs on demand, fail, and then fail the user's
+command.  (This may be unavoidable in some cases, e.g. when `git merge`
+has non-trivial changes to reconcile outside the sparsity path, but we
+should limit how often users are forced to connect to the network.)
+
+Also, even for users using partial clones that do not mind being
+always connected to the network, the need to download blobs as
+side-effects of various other commands (such as the printed diffstat
+after a merge or pull) can lead to worries about local repository size
+growing unnecessarily[10].
+
+  (Behavior B) Users want a sparse working tree, but are working in a larger whole
+
+Stolee described this usecase this way[11]:
+
+"I'm also focused on users that know that they are a part of a larger
+whole. They know they are operating on a large repository but focus on
+what they need to contribute their part. I expect multiple "roles" to
+use very different, almost disjoint parts of the codebase. Some other
+"architect" users operate across the entire tree or hop between different
+sections of the codebase as necessary. In this situation, I'm wary of
+scoping too many features to the sparse-checkout definition, especially
+"git log," as it can be too confusing to have their view of the codebase
+depend on your "point of view."
+
+People might also end up wanting behavior B due to complex inter-project
+dependencies.  The initial attempts to use sparse-checkouts usually
+involve the directories you are directly interested in plus what those
+directories depend upon within your repository.  But there's a monkey
+wrench here: if you have integration tests, they invert the hierarchy:
+to run integration tests, you need not only what you are interested in
+and its dependencies, you also need everything that depends upon what
+you are interested in or that depends upon one of your
+dependencies...AND you need all the dependencies of that expanded group.
+That can easily change your sparse-checkout into a nearly dense one.
+Naturally, that tends to kill the benefits of sparse-checkouts.  There
+are a couple solutions to this conundrum: either avoid grabbing
+dependencies (maybe have built versions of your dependencies pulled from
+a CI cache somewhere), or say that users shouldn't run integration tests
+directly and instead do it on the CI server when they submit a code
+review.  Or do both.  Regardless of whether you stub out your
+dependencies or stub out the things that depend upon you, there is
+certainly a reason to want to query and be aware of those other
+stubbed-out parts of the repository, particularly when the dependencies
+are complex or change relatively frequently.  Thus, for such uses,
+sparse-checkouts can be used to limit what you directly build and
+modify, but these users do not necessarily want their sparse checkout
+paths to limit their queries of history.
+
+Some people may also be interested in behavior B simply as a performance
+workaround: if they are using non-cone mode, then they have to deal with
+its inherent quadratic performance problems.  In that mode, every
+operation that checks whether paths match the sparsity specification can
+be expensive.  As such, these users may only be willing to pay for those
+expensive checks when interacting with the working copy, and may prefer
+getting "unrelated" results from their history queries over having slow
+commands.
+
+
+=== Desired behavior ===
+
+As noted in the previous section, despite the simple idea of just
+working with a subset of files, there are a range of different
+behavioral changes that need to be made to different subcommands to work
+well with such a feature.  See [1,2,3,4,5,6,7,8,9,10] for various
+examples.  In particular, at [2], we saw that mere composition of other
+commands that individually worked correctly in a sparse-checkout context
+did not imply that the higher level command would work correctly; it
+sometimes requires further tweaks.  So, understanding these differences
+can be beneficial.
+
+* Commands behaving the same regardless of high-level use-case
+
+  * commands that only look at files within the sparsity specification
+
+      * status
+      * diff (without --cached or REVISION arguments)
+      * grep (without --cached or REVISION arguments)
+
+  * commands that restore files to the working tree that match sparsity patterns, and
+    remove unmodified files that don't match those patterns:
+
+      * switch
+      * checkout (the switch-like half)
+      * read-tree
+      * reset --hard
+
+      * `restore` & the restore-like half of `checkout` SHOULD be in this above
+	category, but are buggy (see the "Known bugs" section below)
+
+  * commands that write conflicted files to the working tree, but otherwise will
+    omit writing files that do not match the sparsity patterns:
+
+      * merge
+      * rebase
+      * cherry-pick
+      * revert
+
+    Note that this somewhat depends upon the merge strategy being used:
+      * `ort` behaves as described above
+      * `recursive` tries to not vivify files unnecessarily, but does sometimes
+	vivify files without conflicts.
+      * `octopus` and `resolve` will always vivify any file changed in the merge
+	relative to the first parent, which is rather suboptimal.
+
+  * commands that always ignore sparsity since commits must be full-tree
+
+      * archive
+      * bundle
+      * commit
+      * format-patch
+      * fast-export
+      * fast-import
+      * commit-tree
+
+  * commands that write any modified file to the working tree (conflicted or not,
+    and whether those paths match sparsity patterns or not):
+
+      * stash
+
+      * am/apply probably should be in the above category, but need to be fixed to
+	auto-vivify instead of failing
+
+* Commands that differ for behavior A vs. behavior B:
+
+  * commands that make modifications:
+      * add
+      * rm
+      * mv
+
+  * commands that query history
+      * diff (with --cached or REVISION arguments)
+      * grep (with --cached or REVISION arguments)
+      * show (when given commit arguments)
+      * bisect
+      * blame
+	* and annotate
+      * log
+	* and variants: shortlog, gitk, show-branch, whatchanged
+
+* Comands I don't know how to classify
+
+  * ls-files
+
+    Shows all tracked files by default, and with an option can show
+    sparse directory entries instead of expanding them.  Should there be
+    a way to restrict to just the non SKIP_WORKTREE files?
+
+    Note that `git ls-files -t` is often used to see what is sparse and
+    what is not, which only works with a non-restricted assumption.
+
+  * checkout-index
+
+    should it be like `checkout` and pay attention to sparsity paths, or
+    be considered special and write to working tree anyway?  The
+    interaction with --prefix, and the use of specifically named files
+    (rather than globs) makes me wonder.
+
+  * update-index
+
+    The --[no-]ignore-skip-worktree-entries default is totally bogus,
+    but otherwise this command seems okay?  Not sure what category it
+    would go under, though.
+
+  * range-diff
+
+    Is this like `log` or `format-patch`?
+
+  * cherry
+
+    See range-diff
+
+  * plumbing -- diff-files, diff-index, diff-tree, ls-tree, rev-list
+
+    should these be tweaked or always operate full-tree?
+
+* Commands unaffected by sparse-checkouts
+
+  * branch
+  * clean (works on untracked files, whereas SKIP_WORKTREE files are still tracked)
+  * describe
+  * fetch
+  * gc
+  * init
+  * maintenance
+  * notes
+  * pull (merge & rebase have the necessary changes)
+  * push
+  * submodule
+  * tag
+
+  * config
+  * filter-branch (works in separate checkout without sparse-checkout setup)
+  * pack-refs
+  * prune
+  * remote
+  * repack
+  * replace
+
+  * bugreport
+  * count-objects
+  * fsck
+  * gitweb
+  * help
+  * instaweb
+  * merge-tree (doesn't touch worktree or index, and merges always compute full-tree)
+  * rerere
+  * verify-commit
+  * verify-tag
+
+  * commit-graph
+  * hash-object
+  * index-pack
+  * mktag
+  * mktree
+  * multi-pack-index
+  * pack-objects
+  * prune-packed
+  * symbolic-ref
+  * unpack-objects
+  * update-ref
+  * write-tree (operates on index, possibly optimized to use sparse dir entries)
+
+  * for-each-ref
+  * get-tar-commit-id
+  * ls-remote
+  * merge-base (merges are computed full tree, so merge base should be too)
+  * name-rev
+  * pack-redundant
+  * rev-parse
+  * show-index
+  * show-ref
+  * unpack-file
+  * var
+  * verify-pack
+
+  * <Everything under 'Interacting with Others' in 'git help --all'>
+  * <Everything under 'Low-level...Syncing' in 'git help --all'>
+  * <Everything under 'Low-level...Internal Helpers' in 'git help --all'>
+  * <Everything under 'External commands' in 'git help --all'>
+
+* Commands that might be affected, but who cares?
+
+  * merge-file
+  * merge-index
+
+
+=== Subcommand-dependent defaults ===
+
+Note that we have different defaults (for the desired behavior, not just
+the current implementation) depending on the command:
+
+  * Commands defaulting to --restrict:
+    * status
+    * diff (without --cached or REVISION arguments)
+    * grep (without --cached or REVISION arguments)
+    * switch
+    * checkout (the switch-like half)
+    * read-tree
+    * reset (--hard)
+    * restore/checkout
+    * checkout-index
+
+    This behavior makes sense; these interact with the working tree.
+
+  * Commands defaulting to --restrict-unless-conflicts
+    * merge
+    * rebase
+    * cherry-pick
+    * revert
+
+    These also interact with the working tree, but require slightly different
+    behavior so that conflicts can be resolved.
+
+  * Commands defaulting to --no-restrict
+    * archive
+    * bundle
+    * commit
+    * format-patch
+    * fast-export
+    * fast-import
+    * commit-tree
+
+    * ls-files
+    * stash
+    * am
+    * apply
+
+    These have completely different defaults and perhaps deserve the most detailed
+    explanation:
+
+    In the case of commands in the first group (format-patch,
+    fast-export, bundle, archive, etc.), these are commands for
+    communicating history, which will be broken if they restrict to a
+    subset of the repository.  As such, they operate on full paths and
+    have no `--restrict` option for overriding.  Some of these commands may
+    take paths for manually restricting what is exported, but it needs to
+    be very explicit.
+
+    In the case of stash, it needs to vivify files to avoid losing the
+    user's changes.
+
+    In the case of am and apply, those commands only operate on the
+    working tree, so they are kind of in the same boat as stash.
+    Perhaps `git am` could run `git sparse-checkout reapply`
+    automatically afterward and move into a category more similar to
+    merge/rebase/cherry-pick, but it'd still be weird because it'd
+    vivify files besides just conflicted ones when there are conflicts.
+
+    In the case of ls-files, `git ls-files -t` is often used to see what
+    is sparse and not, in which case restricting would not make sense.
+    Also, ls-files has traditionally been used to get a list of "all
+    tracked files", which would suggest not restricting.  But it's
+    slightly funny, because sparse-checkouts essentially split tracked
+    files into two categories -- those in the sparse specification and
+    those outside -- and how does the user specify which of those two
+    types of tracked files they want?
+
+  * Commands defaulting to --restrict-but-warn (although Behavior A vs. Behavior B
+    may affect how verbose the warnings are):
+    * add
+    * rm
+    * mv
+
+    The defaults here perhaps make sense since they are nearly --restrict, but
+    actually using --restrict could cause user confusion if users specify a
+    specific filename, so they warn by default.  That logic may sound like
+    --no-restrict should be the default, but that's prone to even bigger confusion:
+      * `git add <somefile>` if honored and outside the sparse cone, can result in
+	the file randomly disappearing later when some subsequent command is run
+	(since various commands automatically clean up unmodified files outside
+	the sparsity specification).
+      * `git rm '*.jpg'` could very negatively surprise users if it deletes files
+	outside the range of the user's interest.  Much better to operate on the
+	sparsity specification and give the user warnings if other files could have
+	matched.
+      * `git mv` has similar surprises when moving into or out of the cone, so
+	best to restrict and throw warnings if restriction might affect the result.
+
+    There may be a difference in here between behavior A and behavior B.
+    For behavior A, we probably only want to warn if there were no
+    suitable matches for files in the sparsity specification, whereas
+    for behavior B, we may want to warn even if there are valid files to
+    operate on if the result would have been different under
+    `--no-restrict`.
+
+  * Commands whose default for --restrict vs. --no-restrict should vary depending
+    on Behavior A or Behavior B
+    * diff (with --cached or REVISION arguments)
+    * grep (with --cached or REVISION arguments)
+    * show (when given commit arguments)
+    * bisect
+    * blame
+      * and annotate
+    * log
+      * and variants: shortlog, gitk, show-branch, whatchanged
+
+    For now, we default to behavior B for these, which want a default of
+    --no-restrict.
+
+    Note that two of these commands -- diff and grep -- also appeared in
+    a different list with a default of --restrict, but only when limited
+    to searching the working tree.  The working tree vs. history
+    distinction is fundamental in how behavior B operates, so this is
+    expected.
+
+    --restrict may make more sense as the long term default for
+    these[12], but that's a fair amount of work to implement, and it'd
+    be very problematic for behavior B users.  Making it the default
+    now, and then slowly implementing that default in various
+    subcommands over multiple releases would mean that behavior B users
+    would need to learn to slowly add additional flags to their
+    commands, depending on git version, to get the behavior they want.
+    That gradual switchover would be painful, so we should avoid it at
+    least until it's fully implemented.
+
+
+=== Implementation Questions ===
+
+  * Does the name --[no-]restrict sound good to others?  Are there better options?
+    * Names in use, or appearing in patches, or previously suggested:
+      * --sparse/--dense
+      * --ignore-skip-worktree-bits
+      * --ignore-skip-worktree-entries
+      * --ignore-sparsity
+      * --[no-]restrict-to-sparse-paths
+      * --full-tree/--sparse-tree
+      * --[no-]restrict
+    * Rationale making me lean slightly towards --[no-]restrict:
+      * We want a name that works for many commands, so we need a name that
+	does not conflict
+      * --[no-]restrict isn't overly long and seems relatively explanatory
+      * `--sparse`, as used in add/rm/mv, is totally backwards for
+	grep/log/etc.  Changing the meaning of `--sparse` for these
+	commands would fix the backwardness, but possibly break existing
+	scripts.  Using a new name pairing would allow us to treat
+	`--sparse` in these commands as a deprecated alias.
+      * There is a different `--sparse`/`--dense` pair for commands using
+	revision machinery, so using that naming might cause confusion
+      * There is also a `--sparse` in both pack-objects and show-branch, which
+	don't conflict but do suggest that `--sparse` is overloaded
+      * The name --ignore-skip-worktree-bits is a double negative, is
+	quite a mouthful, refers to an implementation detail that many
+	users may not be familiar with, and we'd need a negation for it
+	which would probably be even more ridiculously long.  (But we
+	can make --ignore-skip-worktree-bits a deprecated alias for
+	--no-restrict.)
+
+  * Should --[no-]restrict be a git global option, or added as options to each
+    relevant command?  (Does that make sense given the multitude of different
+    default behaviors we have for different options?)
+
+  * If a config option is added (core.restrictToSparsity?) what should
+    the values and description be?  There's a risk of confusion, because
+    we only want this config option to affect the history-querying
+    commands (log/diff/grep) and maybe the path-modifying worktree
+    commands (add/rm/mv), but certainly not most the others.  Previous config
+    suggestion here: [13]
+
+  * Should --sparse in ls-files be made an alias for --restrict?
+    `--restrict` is certainly a near synonym in cone-mode, but even then
+    it's not quite the same.  In non-cone mode, ls-files' `--sparse`
+    option has no effect, and in cone-mode it still shows the sparse
+    directory entries which are technically outside the sparsity
+    specification.
+
+  * Should --ignore-skip-worktree-bits in checkout-index, checkout, and
+    restore be made deprecated aliases for --no-restrict?  (They have the
+    same meaning.)
+
+  * Should --ignore-skip-worktree-entries in update-index be made a
+    deprecated alias for --no-restrict?  (Or, better yet, should the
+    option just be nuked from orbit after flipping the default, since
+    the reverse option is never wanted and the sole purpose of this
+    option was to turn off a bug?)
+
+  * sparse-checkout: once behavior A is fully implemented, should we
+    take an interim measure to easy people into switching the default?
+    Namely, if folks are not already in a sparse checkout, then require
+    `sparse-checkout init/set` to take a `--[no-]restrict` flag (which
+    would set core.restrictToSparse according to the setting given), and
+    throw an error if the flag is not provided?  That error would be a
+    great place to warn folks that the default may change in the future,
+    and get them used to specifying what they want so that the eventual
+    default switch is seamless for them.
+
+  * clone: should we provide some mechanism for tying partial clones and
+    sparse checkouts together better.  Maybe an option
+	--sparse=dir1,dir2,...,dirN
+    which:
+       * Does initial fetch with `--filter=blob:none`
+       * Does the `sparse-checkout set --cone dir1 dir2 ... dirN` thing
+       * Runs a `git rev-list --objects --all -- dir1 dir2 ... dirN` to
+	 fault in the missing blobs within the sparse
+	 specification...except that rev-list needs some kind of options
+	 to also get files from leading directories too.
+       * Sets --restrict mode to allow focusing on the cone of interest
+	 (and to permit disconnected development)
+
+
+=== Implementation Goals/Plans ===
+
+ * Figure out answers to the 'Implementation Questions' sections (above)
+
+ * Fix bugs in the 'Known bugs' section (below)
+
+ * update-index: flip the default to --no-ignore-skip-worktree-entries, possibly
+   nuke this stupid "Oh, there's a bug?  Let me add a flag to let users request
+   that they not trigger this bug." flag
+
+  * Flags & Config
+    * Make `--sparse` in add/rm/mv a deprecated alias for `--no-restrict`
+    * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
+      a deprecated aliases for `--no-restrict`
+    * Create config option (core.restrictToSparsity?), note how it only
+      affects two classes of commands
+
+ * Behavioral plans:
+     add, rm, mv:
+	Behavior B: throw error if would have affected paths outside of sparsity.
+	Behavior A: throw error if would have only affected paths outside of sparsity.
+     grep (on history), diff (on history), log, etc:
+	Behavior B: act on all paths (already implemented)
+	Behavior A: act on limited paths, maybe show stderr warning ("results limited")
+		    if selected via config rather than explicitly
+     other diff machinery:
+	make sure diff machinery changes don't mess with format-patch, fast-export, etc.
+
+  * Fix performance issues, such as
+    https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
+
+
+=== Known bugs ===
+
+This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
+been working on it.
+
+0. Behavior A is not well supported in Git.  (Behavior B didn't used to be either,
+   but was the easier of the two to implement.)
+
+1. am and apply:
+
+   am and apply rely on files being present in the working copy, and
+   also write to them unconditionally.  They should probably first check
+   for the files' presence, and if found to be SKIP_WORKTREE, then clear
+   the bit and vivify the paths, then do its work.
+
+2. reset --hard:
+
+   reset --hard provides confusing error message (works correctly, but
+   misleads the user into believing it didn't):
+
+    $ touch addme
+    $ git add addme
+    $ git ls-files -t
+    H addme
+    H tracked
+    S tracked-but-maybe-skipped
+    $ git reset --hard                           # usually works great
+    error: Path 'addme' not uptodate; will not remove from working tree.
+    HEAD is now at bdbbb6f third
+    $ git ls-files -t
+    H tracked
+    S tracked-but-maybe-skipped
+    $ ls -1
+    tracked
+
+    `git reset --hard` DID remove addme from the index and the working tree, contrary
+    to the error message, but in line with how reset --hard should behave.
+
+3. Checkout, restore:
+
+   These command do not handle path & revision arguments appropriately:
+
+    $ ls
+    tracked
+    $ git ls-files -t
+    H tracked
+    S tracked-but-maybe-skipped
+    $ git status --porcelain
+    $ git checkout -- '*skipped'
+    error: pathspec '*skipped' did not match any file(s) known to git
+    $ git ls-files -- '*skipped'
+    tracked-but-maybe-skipped
+    $ git checkout HEAD -- '*skipped'
+    error: pathspec '*skipped' did not match any file(s) known to git
+    $ git ls-tree HEAD | grep skipped
+    100644 blob 276f5a64354b791b13840f02047738c77ad0584f	tracked-but-maybe-skipped
+    $ git status --porcelain
+    $ git checkout HEAD~1 -- '*skipped'
+    $ git ls-files -t
+    H tracked
+    H tracked-but-maybe-skipped
+    $ git status --porcelain
+    M  tracked-but-maybe-skipped
+    $ git checkout HEAD -- '*skipped'
+    $ git status --porcelain
+    $
+
+    Note that checkout without a revision (or restore --staged) fails to
+    find a file to restore from the index, even though ls-files shows
+    such a file certainly exists.
+
+    Similar issues occur with HEAD (--source=HEAD in restore's case),
+    but suddenly works when HEAD~1 is specified.  And then after that it
+    will work with HEAD specified, even though it didn't before.
+
+    Directories are also an issue:
+
+    $ git sparse-checkout set nomatches
+    $ git status
+    On branch main
+    You are in a sparse checkout with 0% of tracked files present.
+
+    nothing to commit, working tree clean
+    $ git checkout .
+    error: pathspec '.' did not match any file(s) known to git
+    $ git checkout HEAD~1 .
+    Updated 1 path from 58916d9
+    $ git ls-files -t
+    S tracked
+    H tracked-but-maybe-skipped
+
+
+=== Reference Emails ===
+
+Emails that detail various bugs we've had in sparse-checkout:
+
+[1] (Original descriptions of behavior A & behavior B)
+    https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
+[2] (Fix stash applications in sparse checkouts; bugs from behavioral differences)
+    https://lore.kernel.org/git/ccfedc7140dbf63ba26a15f93bd3885180b26517.1606861519.git.gitgitgadget@gmail.com/
+[3] (Present-despite-skipped entries)
+    https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
+[4] (Clone --no-checkout interaction)
+    https://lore.kernel.org/git/pull.801.v2.git.git.1591324899170.gitgitgadget@gmail.com/ (clone --no-checkout)
+[5] (The need for update_sparsity() and avoiding `read-tree -mu HEAD`)
+    https://lore.kernel.org/git/3a1f084641eb47515b5a41ed4409a36128913309.1585270142.git.gitgitgadget@gmail.com/
+[6] (SKIP_WORKTREE is advisory, not mandatory)
+    https://lore.kernel.org/git/844306c3e86ef67591cc086decb2b760e7d710a3.1585270142.git.gitgitgadget@gmail.com/
+[7] (`worktree add` should copy sparsity settings from current worktree)
+    https://lore.kernel.org/git/c51cb3714e7b1d2f8c9370fe87eca9984ff4859f.1644269584.git.gitgitgadget@gmail.com/
+[8] (Avoid negative surprises in add, rm, and mv)
+    https://lore.kernel.org/git/cover.1617914011.git.matheus.bernardino@usp.br/
+    https://lore.kernel.org/git/pull.1018.v4.git.1632497954.gitgitgadget@gmail.com/
+[9] (Move from out-of-cone to in-cone)
+    https://lore.kernel.org/git/20220630023737.473690-6-shaoxuan.yuan02@gmail.com/
+    https://lore.kernel.org/git/20220630023737.473690-4-shaoxuan.yuan02@gmail.com/
+[10] (Unnecessarily downloading objects outside sparsity specification)
+     https://lore.kernel.org/git/CAOLTT8QfwOi9yx_qZZgyGa8iL8kHWutEED7ok_jxwTcYT_hf9Q@mail.gmail.com/
+
+[11] (Stolee's comments on high-level usecases)
+     https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
+
+[12] Others commenting on eventually switching default to behavior A:
+  * https://lore.kernel.org/git/xmqqh719pcoo.fsf@gitster.g/
+  * https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/
+  * https://lore.kernel.org/git/a86af661-cf58-a4e5-0214-a67d3a794d7e@github.com/
+
+[13] Previous config name suggestion and description
+  * https://lore.kernel.org/git/CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com/
+
+[14] Tangential issue: switch to cone mode as default sparsity specification mechanism:
+  https://lore.kernel.org/git/a1b68fd6126eb341ef3637bb93fedad4309b36d0.1650594746.git.gitgitgadget@gmail.com/
+
+[15] Lengthy email on grep behavior, covering what should be searched:
+  * https://lore.kernel.org/git/CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com/

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
gitgitgadget
