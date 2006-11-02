X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 01 Nov 2006 16:53:18 -0800
Message-ID: <7vk62ewtxd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 00:53:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: e23ed9a8b4769fcba0944cf121d366ec7db7fe3b
X-master-at: 7854e526ff170846aef4ae3c71588c98ed9176d0
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30676>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfQph-0003n5-JA for gcvg-git@gmane.org; Thu, 02 Nov
 2006 01:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752335AbWKBAxV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 19:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbWKBAxV
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 19:53:21 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42421 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1752335AbWKBAxT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 19:53:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061102005319.QXTF18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 19:53:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hctP1V00Y1kojtg0000000 Wed, 01 Nov 2006
 19:53:24 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* The 'maint' branch has these fixes since the last announcement.

  We have one semantic fix in "maint".  To the revision traversal
  machinery, --unpacked used to mean that any commit that is in a
  pack is uninteresting and tainted its ancestors also
  uninteresting.  Updated semantics of --unpacked is just an
  output filter -- it traverses ancestry chain as usual, but does
  not show unpacked commits.  This made what "git repack" does
  actually make sense when the repository is partly packed in the
  half-way (the earlier logic worked fine only if all ancestors of
  a packed commit were all packed).

  A few minor "diff --cc" output fixes are also in "maint".  It
  now honours --no-commit-id option and shows function names on
  the @@@ ... @@@ line just like normal diffs do.


   Christian Couder (2):
      Documentation: add upload-archive service to git-daemon.
      Documentation: add git in /etc/services.

   Edgar Toernig (1):
      Use memmove instead of memcpy for overlapping areas

   Jakub Narebski (2):
      diff-format.txt: Correct information about pathnames quoting in
	patch format
      gitweb: Check git base URLs before generating URL from it

   Jan Harkes (1):
      Continue traversal when rev-list --unpacked finds a packed commit.

   Junio C Hamano (7):
      combine-diff: a few more finishing touches.
      combine-diff: fix hunk_comment_line logic.
      combine-diff: honour --no-commit-id
      Surround "#define DEBUG 0" with "#ifndef DEBUG..#endif"
      quote.c: ensure the same quoting across platforms.
      revision traversal: --unpacked does not limit commit list anymore.
      link_temp_to_file: don't leave the path truncated on
	adjust_shared_perm failure

   Nicolas Pitre (1):
      pack-objects doesn't create random pack names

   Rene Scharfe (1):
      git-cherry: document limit and add diagram


* The 'master' branch has these since the last announcement.

  Linus's packed-refs work with associated refs handling
  clean-ups are out on "master", but there is one disclaimer.
  Commit walkers cannot fetch from a repository whose refs are
  packed and then pruned yet, so people with public repositories
  that are expected to be fetched via http should not run
  git-pack-refs just yet.  I think it is probably just the
  matter of updating git-fetch.sh to run ls-remote against the
  repository upfront, and use the SHA-1 of wanted branch tip
  instead of the branch tip name when running the low-level
  git-http-fetch.

  git-branch and git-cherry are now built-in.

   Andy Parkins (1):
      Make filenames line up in git-status output

   Christian Couder (14):
      Add [-s|--hash] option to Linus' show-ref.
      Use Linus' show ref in "git-branch.sh".
      Document git-show-ref [-s|--hash] option.
      Fix show-ref usage for --dereference.
      Add pack-refs and show-ref test cases.
      When creating branch c/d check that branch c does not already exists.
      Uncomment test case: git branch c/d should barf if branch c exists.
      Fix a remove_empty_dir_recursive problem.
      Clean up "git-branch.sh" and add remove recursive dir test cases.
      Use git-update-ref to delete a tag instead of rm()ing the ref file.
      Check that a tag exists using show-ref instead of looking for the
	ref file.
      Do not create tag leading directories since git update-ref does it.
      Documentation: add upload-archive service to git-daemon.
      Documentation: add git in /etc/services.

   Dennis Stosberg (3):
      lock_ref_sha1_basic does not remove empty directories on BSD
      Remove bashism from t3210-pack-refs.sh
      Bash completion support for aliases

   Edgar Toernig (2):
      Use memmove instead of memcpy for overlapping areas
      Use memmove instead of memcpy for overlapping areas

   Jakub Narebski (8):
      gitweb: Use --no-commit-id in git_commit and git_commitdiff
      diff-format.txt: Correct information about pathnames quoting in
	patch format
      gitweb: Check git base URLs before generating URL from it
      Documentation: Update information about <format> in git-for-each-ref
      gitweb: Move git_get_last_activity subroutine earlier
      gitweb: Add "next" link to commitdiff view
      gitweb: Secure against commit-ish/tree-ish with the same name as path
      gitweb: Use 's' regexp modifier to secure against filenames with LF

   Jan Harkes (1):
      Continue traversal when rev-list --unpacked finds a packed commit.

   Jeff King (3):
      wt-status: use simplified resolve_ref to find current branch
      gitignore: git-pack-refs is a generated file.
      gitignore: git-show-ref is a generated file.

   Johannes Schindelin (2):
      Fix git-update-index --again
      show-branch: mark active branch with a '*' again

   Jonas Fonseca (1):
      Add man page for git-show-ref

   Junio C Hamano (42):
      Fix t1400-update-ref test minimally
      fsck-objects: adjust to resolve_ref() clean-up.
      symbolit-ref: fix resolve_ref conversion.
      Add callback data to for_each_ref() family.
      Tell between packed, unpacked and symbolic refs.
      pack-refs: do not pack symbolic refs.
      git-pack-refs --prune
      pack-refs: fix git_path() usage.
      lock_ref_sha1_basic: remove unused parameter "plen".
      Clean-up lock-ref implementation
      update-ref: -d flag and ref creation safety.
      update a few Porcelain-ish for ref lock safety.
      Teach receive-pack about ref-log
      receive-pack: call setup_ident before git_config
      ref locking: allow 'foo' when 'foo/bar' used to exist but not anymore.
      refs: minor restructuring of cached refs data.
      lock_ref_sha1(): do not sometimes error() and sometimes die().
      lock_ref_sha1(): check D/F conflict with packed ref when creating.
      delete_ref(): delete packed ref
      git-branch: remove D/F check done by hand.
      show-ref --hash=len, --abbrev=len, and --abbrev
      git-fetch: adjust to packed-refs.
      Fix refs.c;:repack_without_ref() clean-up path
      git-fetch: do not look into $GIT_DIR/refs to see if a tag exists.
      pack-refs: use lockfile as everybody else does.
      pack-refs: call fflush before fsync.
      ref-log: allow ref@{count} syntax.
      core.logallrefupdates create new log file only for branch heads.
      git-pack-refs --all
      core.logallrefupdates thinko-fix
      ref-log: fix D/F conflict coming from deleted refs.
      sha1_name.c: avoid compilation warnings.
      t3200: git-branch testsuite update
      combine-diff: fix hunk_comment_line logic.
      combine-diff: honour --no-commit-id
      tests: merge-recursive is usable without Python
      Documentation: fix git-format-patch mark-up and link it from git.txt
      Surround "#define DEBUG 0" with "#ifndef DEBUG..#endif"
      quote.c: ensure the same quoting across platforms.
      revision traversal: --unpacked does not limit commit list anymore.
      link_temp_to_file: don't leave the path truncated on
	adjust_shared_perm failure
      branch: work in subdirectories.

   Lars Hjemli (2):
      Make git-branch a builtin
      Fix show-ref usagestring

   Linus Torvalds (6):
      Add "git show-ref" builtin command
      Teach "git checkout" to use git-show-ref
      Start handling references internally as a sorted in-memory list
      Add support for negative refs
      Make ref resolution saner
      Enable the packed refs file format

   Luben Tuikov (2):
      git-revert with conflicts to behave as git-merge with conflicts
      gitweb: esc_html() author in blame

   Nicolas Pitre (1):
      pack-objects doesn't create random pack names

   Petr Baudis (3):
      Fix broken sha1 locking
      Fix buggy ref recording
      gitweb: Fix up bogus $stylesheet declarations

   Rene Scharfe (3):
      Built-in cherry
      Make git-cherry handle root trees
      git-cherry: document limit and add diagram

   Robin Rosenberg (2):
      Mention that pull can work locally in the synopsis
      Swap the porcelain and plumbing commands in the git man page

   Sasha Khapyorsky (1):
      git-svnimport: support for partial imports

   Sergey Vlasov (2):
      git-send-email: Document support for local sendmail instead of
	SMTP server
      git-send-email: Read the default SMTP server from the GIT config file

   Shawn Pearce (1):
      Move deny_non_fast_forwards handling completely into receive-pack.


* The 'next' branch, in addition, has these.

  The largest one is "pickaxe"; I think it is ready for wider
  testing if not for production use, and it is a new command so
  it should be relatively safe to push it out anytime on "master".

  Nico did a lot of work on index-pack and with help from Shawn
  pushing many objects without exploding them into loose objects
  at the other end is becoming reality.  The latest part of
  their series is not in "next" nor "pu" yet, though.

  Linus pointed out that when merging a branch based on an older
  codebase that used to have a path into your branch that does
  not have that path tracked anymore triggers a bogus safety
  valve; I've done both merge-resolve and merge-recursive to
  handle this situation but the result needs to be sanity
  checked.  We are _loosening_ safety valve and need to be extra
  cautious not to overloosen it.

   Junio C Hamano (28):
      upload-pack: stop the other side when they have more roots than we do.
      git-pickaxe: blame rewritten.
      git-pickaxe -M: blame line movements within a file.
      git-pickaxe -C: blame cut-and-pasted lines.
      git-pickaxe: pagenate output by default.
      git-pickaxe: fix nth_line()
      git-pickaxe: improve "best match" heuristics
      git-pickaxe: introduce heuristics to avoid "trivial" chunks
      git-pickaxe: do not keep commit buffer.
      git-pickaxe: do not confuse two origins that are the same.
      git-pickaxe: get rid of wasteful find_origin().
      git-pickaxe: swap comparison loop used for -C
      merge: loosen overcautious "working file will be lost" check.
      merge-recursive: use abbreviated commit object name.
      merge-recursive: make a few functions static.
      merge-recursive: adjust to loosened "working file clobbered" check
      t6022: ignoring untracked files by merge-recursive when they do not
	matter
      send-pack --keep: do not explode into loose objects on the receiving end.
      git-pickaxe: WIP to refcount origin structure.
      git-pickaxe: allow -Ln,m as well as -L n,m
      git-pickaxe: refcount origin correctly in find_copy_in_parent()
      git-pickaxe: tighten sanity checks.
      Revert "send-pack --keep: do not explode into loose objects on the
	receiving end."
      git-pickaxe: split find_origin() into find_rename() and find_origin().
      git-pickaxe: cache one already found path per commit.
      Introduce a new revision set operator <rev>^!

   Linus Torvalds (2):
      Allow '-' in config variable names
      git push: add verbose flag and allow overriding of default target
	repository

   Nicolas Pitre (8):
      enable index-pack streaming capability
      make index-pack able to complete thin packs.
      add progress status to index-pack
      mimic unpack-objects when --stdin is used with index-pack
      enhance clone and fetch -k experience
      index-pack: minor fixes to comment and function name
      missing small substitution
      make git-push a bit more verbose

   Petr Baudis (1):
      gitweb: Support for 'forks'

   Shawn Pearce (4):
      Allow short pack names to git-pack-objects --unpacked=.
      Only repack active packs by skipping over kept packs.
      Teach git-index-pack how to keep a pack file.
      Remove unused variable in receive-pack.


* The 'pu' branch, in addition, has these.

  Johannes's "shallow" was marked as "pu" material so I've based
  the series on the tip of "next" (which means we cannot
  directly merge that into "next" or "master" without rebasing
  it to "master" first) and parked it in "pu".  I have given
  only a cursory look to it but it looks promising.

  Nico's latest 6-series builds on top of what Shawn has here
  (the first two from Nico are the same), but I haven't gotten
  around to them yet.

   Johannes Schindelin (6):
      upload-pack: no longer call rev-list
      support fetching into a shallow repository
      allow cloning a repository "shallowly"
      allow deepening of a shallow repository
      add tests for shallow stuff
      Build in shortlog

   Junio C Hamano (4):
      rev-list --left-right
      git-diff/git-apply: make diff output a bit friendlier to GNU
	patch (part 2)
      para-walk: walk n trees, index and working tree in parallel
      git-commit: show --summary after successful commit.

   Shawn Pearce (2):
      Allow pack header preprocessing before unpack-objects/index-pack.
      Teach receive-pack how to keep pack files based on object count.

