Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C799626C6;
	Tue, 20 Feb 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449003; cv=none; b=Z+0bPj4vkMBxNtnD3CwVr56LP5UO5xPG6dCI2wPrTz7O3H7KobhaKGp+7iDBQWwgyu8A7Rfot1LZIH3sqFl/FXW8zTLIpHvO6Sy7XNVJSaHDmnJ9LgS2219nhQBAczZOa3LdR453BiC4qjctFX2PZuDci20TzknTRAfgg7Ukegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449003; c=relaxed/simple;
	bh=5oJREmJonlZFU0Nj71DnYSjnG6WZAA4F6PC5WHcMMnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OGv6Ql6/kTcuFfDh0JZ9KAiBNnat2WLck/dNIiXCBLMBSoHXZNYFagmkF5hDjw0msHxAvMKIufS4Itrvur6eMbXX6a42qhcekSMrHoFGSbgqoK9ZVukSQQMljd1UR+zOqySuR6SLoFJuPOayf4ohh3PRCpJO453phMxU8Sy7cxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cGLK1JEY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cGLK1JEY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D9F5E277E3;
	Tue, 20 Feb 2024 12:09:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=5oJREmJonlZFU0Nj71DnYSjnG
	6WZAA4F6PC5WHcMMnA=; b=cGLK1JEYq3NHS6oHFs4MCxiMmXRGtbjG1wQr7oYla
	2hvj3wZPF95ojx2ALutpPHIuYH8Q0boxyILakOOGtn10dURuD7Fhbt80QGIaBl2n
	fKCCIFYCklOb8bMz8+yiXb9dXDwBvFbe1NubI2jR664CVVMtSZG+4iXTbEdfjU/k
	ao=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D109C277E2;
	Tue, 20 Feb 2024 12:09:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5AA30277E1;
	Tue, 20 Feb 2024 12:09:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.44.0-rc2
Date: Tue, 20 Feb 2024 09:09:52 -0800
Message-ID: <xmqqbk8brrj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DDC73F3E-D012-11EE-9D43-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

A release candidate Git v2.44.0-rc2 is now available for testing at
the usual places.  It is comprised of 502 non-merge commits since
v2.43.0, contributed by 85 people, 34 of which are new faces [*].

I was planning to do without -rc2 and directly go to the final
release, but there was a last-minute regression discovered, whose
fix is included in this (hopefully) final release candidate.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.44.0-rc2' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.43.0 are as follows.
Welcome to the Git development community!

  Achu Luma, Antonin Delpeuch, Benjamin Lehmann, Britton Leo Kerin,
  Carlos Andr=C3=A9s Ram=C3=ADrez Cata=C3=B1o, Chandra Pratap, Ghanshyam
  Thakkar, Illia Bobyr, James Touton, Janik Haag, Joanna Wang,
  Josh Brobst, Julian Prein, Justin Tobler, Kyle Lippincott,
  lumynou5, Maarten van der Schrieck, Marcel Krause, Marcelo
  Roberto Jimenez, Michael Lohmann, moti sd, Nikolay Borisov,
  Nikolay Edigaryev, Ondrej Pohorelsky, Sam Delmerico, Sergey
  Kosukhin, Shreyansh Paliwal, S=C3=B6ren Krecker, Stan Hu, Tamino
  Bauknecht, Wilfred Hughes, Willem Verstraeten, Xiaoguang WANG,
  and Zach FettersMoore.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Shopov, Andy Koppe, Arkadii Yakovets, Arthur Chan,
  Bagas Sanjaya, Calvin Wan, Carlo Marcelo Arenas Bel=C3=B3n, Christian
  Couder, Dragan Simic, Elijah Newren, Emir SARI, Eric Sunshine,
  Glen Choo, Han-Wen Nienhuys, Jean-No=C3=ABl Avila, Jeff Hostetler,
  Jeff King, Jiang Xin, Johannes Schindelin, John Cai, Jonathan
  Tan, Jordi Mas, Josh Soref, Josh Steadmon, Josip Sokcevic, Junio
  C Hamano, Kate Golovanova, Konstantin Ryabitsev, Kristoffer
  Haugsbakk, Linus Arver, Matthias A=C3=9Fhauer, M Hickford, Orgad
  Shaneh, Oswald Buddenhagen, Patrick Steinhardt, Peter Krefting,
  Philippe Blain, Phillip Wood, Ralf Thielow, Randall S. Becker,
  Ren=C3=A9 Scharfe, Rub=C3=A9n Justo, Simon Ser, SZEDER G=C3=A1bor, Tayl=
or
  Blau, Teng Long, Todd Zullinger, Toon Claes, Vegard Nossum,
  Victoria Dye, and Yi-Jyun Pan.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.44 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Backward Compatibility Notes

 * "git checkout -B <branch>" used to allow switching to a branch that
   is in use on another worktree, but this was by mistake.  The users
   need to use "--ignore-other-worktrees" option.


UI, Workflows & Features

 * "git add" and "git stash" learned to support the ":(attr:...)"
   magic pathspec.

 * "git rebase --autosquash" is now enabled for non-interactive rebase,
   but it is still incompatible with the apply backend.

 * Introduce "git replay", a tool meant on the server side without
   working tree to recreate a history.

 * "git merge-file" learned to take the "--diff-algorithm" option to
   use algorithm different from the default "myers" diff.

 * Command line completion (in contrib/) learned to complete path
   arguments to the "add/set" subcommands of "git sparse-checkout"
   better.

 * "git checkout -B <branch> [<start-point>]" allowed a branch that is
   in use in another worktree to be updated and checked out, which
   might be a bit unexpected.  The rule has been tightened, which is a
   breaking change.  "--ignore-other-worktrees" option is required to
   unbreak you, if you are used to the current behaviour that "-B"
   overrides the safety.

 * The builtin_objectmode attribute is populated for each path
   without adding anything in .gitattributes files, which would be
   useful in magic pathspec, e.g., ":(attr:builtin_objectmode=3D100755)"
   to limit to executables.

 * "git fetch" learned to pay attention to "fetch.all" configuration
   variable, which pretends as if "--all" was passed from the command
   line when no remote parameter was given.

 * In addition to (rather cryptic) Security Identifiers, show username
   and domain in the error message when we barf on mismatch between
   the Git directory and the current user on Windows.

 * The error message given when "git branch -d branch" fails due to
   commits unique to the branch has been split into an error and a new
   conditional advice message.

 * When given an existing but unreadable file as a configuration file,
   gitweb behaved as if the file did not exist at all, but now it
   errors out.  This is a change that may break backward compatibility.

 * When $HOME/.gitconfig is missing but XDG config file is available, we
   should write into the latter, not former.  "git gc" and "git
   maintenance" wrote into a wrong "global config" file, which have
   been corrected.

 * Define "special ref" as a very narrow set that consists of
   FETCH_HEAD and MERGE_HEAD, and clarify everything else that used to
   be classified as such are actually just pseudorefs.

 * All conditional "advice" messages show how to turn them off, which
   becomes repetitive.  Setting advice.* configuration explicitly on
   now omits the instruction part.

 * The "disable repository discovery of a bare repository" check,
   triggered by setting safe.bareRepository configuration variable to
   'explicit', has been loosened to exclude the ".git/" directory inside
   a non-bare repository from the check.  So you can do "cd .git &&
   git cmd" to run a Git command that works on a bare repository without
   explicitly specifying $GIT_DIR now.

 * The completion script (in contrib/) learned more options that can
   be used with "git log".

 * The labels on conflict markers for the common ancestor, our version,
   and the other version are available to custom 3-way merge driver
   via %S, %X, and %Y placeholders.

 * The write codepath for the reftable data learned to honor
   core.fsync configuration.

 * The "--fsck-objects" option of "git index-pack" now can take the
   optional parameter to tweak severity of different fsck errors.

 * The wincred credential backend has been taught to support oauth
   refresh token the same way as credential-cache and
   credential-libsecret backends.

 * Command line completion support (in contrib/) has been
   updated for "git bisect".

 * "git branch" and friends learned to use the formatted text as
   sorting key, not the underlying timestamp value, when the --sort
   option is used with author or committer timestamp with a format
   specifier (e.g., "--sort=3Dcreatordate:format:%H:%M:%S").

 * The command line completion script (in contrib/) learned to
   complete configuration variable names better.


Performance, Internal Implementation, Development Support etc.

 * Process to add some form of low-level unit tests has started.

 * Add support for GitLab CI.

 * "git for-each-ref --no-sort" still sorted the refs alphabetically
   which paid non-trivial cost.  It has been redefined to show output
   in an unspecified order, to allow certain optimizations to take
   advantage of.

 * Simplify API implementation to delete references by eliminating
   duplication.

 * Subject approxidate() and show_date() machinery to OSS-Fuzz.

 * A new helper to let us pretend that we called lstat() when we know
   our cache_entry is up-to-date via fsmonitor.

 * The optimization based on fsmonitor in the "diff --cached"
   codepath is resurrected with the "fake-lstat" introduced earlier.

 * Test balloon to use C99 "bool" type from <stdbool.h> has been
   added.

 * "git clone" has been prepared to allow cloning a repository with
   non-default hash function into a repository that uses the reftable
   backend.

 * Streaming spans of packfile data used to be done only from a
   single, primary, pack in a repository with multiple packfiles.  It
   has been extended to allow reuse from other packfiles, too.

 * Comment updates to help developers not to attempt to modify
   messages from plumbing commands that must stay constant.

   It might make sense to reassess the plumbing needs every few years,
   but that should be done as a separate effort.

 * Move test-ctype helper to the unit-test framework.

 * Instead of manually creating refs/ hierarchy on disk upon a
   creation of a secondary worktree, which is only usable via the
   files backend, use the refs API to populate it.

 * CI for GitLab learned to drive macOS jobs.

 * A few tests to "git commit -o <pathspec>" and "git commit -i
   <pathspec>" has been added.

 * Tests on ref API are moved around to prepare for reftable.

 * The Makefile often had to say "-L$(path) -R$(path)" that repeats
   the path to the same library directory for link time and runtime.
   A Makefile template is used to reduce such repetition.

 * The priority queue test has been migrated to the unit testing
   framework.

 * Setting `feature.experimental` opts the user into multi-pack reuse
   experiment

 * Squelch node.js 16 deprecation warnings from GitHub Actions CI
   by updating actions/github-script and actions/checkout that use
   node.js 20.

 * The mechanism to report the filename in the source code, used by
   the unit-test machinery, assumed that the compiler expanded __FILE__
   to the path to the source given to the $(CC), but some compilers
   give full path, breaking the output.  This has been corrected.


Fixes since v2.43
-----------------

 * The way CI testing used "prove" could lead to running the test
   suite twice needlessly, which has been corrected.

 * Update ref-related tests.

 * "git format-patch --encode-email-headers" ignored the option when
   preparing the cover letter, which has been corrected.

 * Newer versions of Getopt::Long started giving warnings against our
   (ab)use of it in "git send-email".  Bump the minimum version
   requirement for Perl to 5.8.1 (from September 2002) to allow
   simplifying our implementation.

 * Earlier we stopped relying on commit-graph that (still) records
   information about commits that are lost from the object store,
   which has negative performance implications.  The default has been
   flipped to disable this pessimization.

 * Stale URLs have been updated to their current counterparts (or
   archive.org) and HTTP links are replaced with working HTTPS links.

 * trace2 streams used to record the URLs that potentially embed
   authentication material, which has been corrected.

 * The sample pre-commit hook that tries to catch introduction of new
   paths that use potentially non-portable characters did not notice
   an existing path getting renamed to such a problematic path, when
   rename detection was enabled.

 * The command line parser for the "log" family of commands was too
   loose when parsing certain numbers, e.g., silently ignoring the
   extra 'q' in "git log -n 1q" without complaining, which has been
   tightened up.

 * "git $cmd --end-of-options --rev -- --path" for some $cmd failed
   to interpret "--rev" as a rev, and "--path" as a path.  This was
   fixed for many programs like "reset" and "checkout".

 * "git bisect reset" has been taught to clean up state files and refs
   even when BISECT_START file is gone.

 * Some codepaths did not correctly parse configuration variables
   specified with valueless "true", which has been corrected.

 * Code clean-up for sanity checking of command line options for "git
   show-ref".

 * The code to parse the From e-mail header has been updated to avoid
   recursion.

 * "git fetch --atomic" issued an unnecessary empty error message,
   which has been corrected.

 * Command line completion script (in contrib/) learned to work better
   with the reftable backend.

 * "git status" is taught to show both the branch being bisected and
   being rebased when both are in effect at the same time.

 * "git archive --list extra garbage" silently ignored excess command
   line parameters, which has been corrected.

 * "git sparse-checkout set" added default patterns even when the
   patterns are being fed from the standard input, which has been
   corrected.

 * "git sparse-checkout (add|set) --[no-]cone --end-of-options" did
   not handle "--end-of-options" correctly after a recent update.

 * Unlike other environment variables that took the usual
   true/false/yes/no as well as 0/1, GIT_FLUSH only understood 0/1,
   which has been corrected.

 * Clearing in-core repository (happens during e.g., "git fetch
   --recurse-submodules" with commit graph enabled) made in-core
   commit object in an inconsistent state by discarding the necessary
   data from commit-graph too early, which has been corrected.

 * Update to a new feature recently added, "git show-ref --exists".

 * oss-fuzz tests are built and run in CI.
   (merge c4a9cf1df3 js/oss-fuzz-build-in-ci later to maint).

 * Rename detection logic ignored the final line of a file if it is an
   incomplete line.

 * GitHub CI update.
   (merge 0188b2c8e0 pb/ci-github-skip-logs-for-broken-tests later to mai=
nt).

 * "git diff --no-rename A B" did not disable rename detection but did
   not trigger an error from the command line parser.

 * "git archive --remote=3D<remote>" learned to talk over the smart
   http (aka stateless) transport.
   (merge 176cd68634 jx/remote-archive-over-smart-http later to maint).

 * Fetching via protocol v0 over Smart HTTP transport sometimes failed
   to correctly auto-follow tags.
   (merge fba732c462 jk/fetch-auto-tag-following-fix later to maint).

 * The documentation for the --exclude-per-directory option marked it
   as deprecated, which confused readers into thinking there may be a
   plan to remove it in the future, which was not our intention.
   (merge 0009542cab jc/ls-files-doc-update later to maint).

 * "git diff --no-index file1 file2" segfaulted while invoking the
   external diff driver, which has been corrected.

 * Rewrite //-comments to /* comments */ in files whose comments
   prevalently use the latter.

 * Cirrus CI jobs started breaking because we specified version of
   FreeBSD that is no longer available, which has been corrected.
   (merge 81fffb66d3 cb/use-freebsd-13-2-at-cirrus-ci later to maint).

 * A caller called index_file_exists() that takes a string expressed
   as <ptr, length> with a wrong length, which has been corrected.
   (merge 156e28b36d jh/sparse-index-expand-to-path-fix later to maint).

 * A failed "git tag -s" did not necessarily result in an error
   depending on the crypto backend, which has been corrected.

 * "git stash" sometimes was silent even when it failed due to
   unwritable index file, which has been corrected.

 * "git show-ref --verify" did not show things like "CHERRY_PICK_HEAD",
   which has been corrected.

 * Recent conversion to allow more than 0/1 in GIT_FLUSH broke the
   mechanism by flipping what yes/no means by mistake, which has been
   corrected.

 * The sequencer machinery does not use the ref API and instead
   records names of certain objects it needs for its correct operation
   in temporary files, which makes these objects susceptible to loss
   by garbage collection.  These temporary files have been added as
   starting points for reachability analysis to fix this.
   (merge bc7f5db896 pw/gc-during-rebase later to maint).

 * "git cherry-pick" invoked during "git rebase -i" session lost
   the authorship information, which has been corrected.
   (merge e4301f73ff vn/rebase-with-cherry-pick-authorship later to maint=
).

 * The code paths that call repo_read_object_file() have been
   tightened to react to errors.
   (merge 568459bf5e js/check-null-from-read-object-file later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 5aea3955bc rj/clarify-branch-doc-m later to maint).
   (merge 9cce3be2df bk/bisect-doc-fix later to maint).
   (merge 8430b438f6 vd/fsck-submodule-url-test later to maint).
   (merge 3cb4384683 jc/t0091-with-unknown-git later to maint).
   (merge 020456cb74 rs/receive-pack-remove-find-header later to maint).
   (merge bc47139f4f la/trailer-cleanups later to maint).

----------------------------------------------------------------

Changes since v2.43.0 are as follows:

Achu Luma (2):
      unit-tests: rewrite t/helper/test-ctype.c as a unit test
      t2400: avoid losing exit status to pipes

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5610t)

Andy Koppe (3):
      rebase: fully ignore rebase.autoSquash without -i
      rebase: support --autosquash without -i
      rebase: rewrite --(no-)autosquash documentation

Antonin Delpeuch (2):
      merge-file: add --diff-algorithm option
      merge-ll: expose revision names to custom drivers

Arkadii Yakovets (3):
      l10n: uk: v2.44 localization update
      l10n: uk: v2.44 update (round 2)
      l10n: uk: v2.44 update (round 3)

Arthur Chan (1):
      fuzz: add new oss-fuzz fuzzer for date.c / date.h

Bagas Sanjaya (1):
      l10n: po-id for 2.44 (round 1)

Britton Leo Kerin (9):
      doc: use singular form of repeatable path arg
      doc: refer to pathspec instead of path
      completion: tests: always use 'master' for default initial branch n=
ame
      completion: bisect: complete bad, new, old, and help subcommands
      completion: bisect: complete custom terms and related options
      completion: bisect: complete missing --first-parent and - -no-check=
out options
      completion: new function __git_complete_log_opts
      completion: bisect: complete log opts for visualize subcommand
      completion: bisect: recognize but do not complete view subcommand

Carlo Marcelo Arenas Bel=C3=B3n (1):
      ci: update FreeBSD cirrus job

Chandra Pratap (4):
      sideband.c: remove redundant 'NEEDSWORK' tag
      write-or-die: make GIT_FLUSH a Boolean environment variable
      t4129: prevent loss of exit code due to the use of pipes
      tests: move t0009-prio-queue.sh to the new unit testing framework

Elijah Newren (32):
      t6429: remove switching aspects of fast-rebase
      replay: introduce new builtin
      replay: start using parse_options API
      replay: die() instead of failing assert()
      replay: introduce pick_regular_commit()
      replay: change rev walking options
      replay: add an important FIXME comment about gpg signing
      replay: remove progress and info output
      replay: remove HEAD related sanity check
      replay: make it a minimal server side command
      replay: use standard revision ranges
      replay: add --advance or 'cherry-pick' mode
      replay: add --contained to rebase contained branches
      replay: stop assuming replayed branches do not diverge
      completion: squelch stray errors in sparse-checkout completion
      completion: fix logic for determining whether cone mode is active
      completion: avoid misleading completions in cone mode
      completion: avoid user confusion in non-cone mode
      treewide: remove unnecessary includes from header files
      treewide: remove unnecessary includes in source files
      archive.h: remove unnecessary include
      blame.h: remove unnecessary includes
      fsmonitor--daemon.h: remove unnecessary includes
      http.h: remove unnecessary include
      line-log.h: remove unnecessary include
      pkt-line.h: remove unnecessary include
      submodule-config.h: remove unnecessary include
      trace2/tr2_tls.h: remove unnecessary include
      treewide: add direct includes currently only pulled in transitively
      treewide: remove unnecessary includes in source files
      sparse-checkout: be consistent with end of options markers
      diffcore-delta: avoid ignoring final 'line' of file

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.44

Eric Sunshine (1):
      git-add.txt: add missing short option -A to synopsis

Ghanshyam Thakkar (4):
      t7501: add tests for --include and --only
      t7501: add tests for --amend --signoff
      t0024: avoid losing exit status to pipes
      t0024: style fix

Illia Bobyr (1):
      rebase: clarify --reschedule-failed-exec default

James Touton (1):
      git-p4: use raw string literals for regular expressions

Jean-No=C3=ABl Avila (3):
      doc: enforce dashes in placeholders
      doc: enforce placeholders in documentation
      l10n: fr.po: v2.44.0 round 3

Jeff Hostetler (4):
      trace2: fix signature of trace2_def_param() macro
      t0211: test URL redacting in PERF format
      t0212: test URL redacting in EVENT format
      sparse-index: pass string length to index_file_exists()

Jeff King (39):
      commit-graph: handle overflow in chunk_size checks
      midx: check consistency of fanout table
      commit-graph: drop redundant call to "lite" verification
      commit-graph: clarify missing-chunk error messages
      commit-graph: abort as soon as we see a bogus chunk
      commit-graph: use fanout value for graph size
      commit-graph: check order while reading fanout chunk
      commit-graph: drop verify_commit_graph_lite()
      commit-graph: mark chunk error messages for translation
      parse-options: decouple "--end-of-options" and "--"
      bisect: always clean on reset
      config: handle NULL value when parsing non-bools
      setup: handle NULL value when parsing extensions
      trace2: handle NULL values in tr2_sysenv config callback
      help: handle NULL value for alias.* config
      submodule: handle NULL value when parsing submodule.*.branch
      trailer: handle NULL value when parsing trailer-specific config
      fsck: handle NULL value when parsing message config
      config: reject bogus values for core.checkstat
      git_xmerge_config(): prefer error() to die()
      imap-send: don't use git_die_config() inside callback
      config: use config_error_nonbool() instead of custom messages
      diff: give more detailed messages for bogus diff.* config
      config: use git_config_string() for core.checkRoundTripEncoding
      push: drop confusing configset/callback redundancy
      gpg-interface: drop pointless config_error_nonbool() checks
      sequencer: simplify away extra git_config_string() call
      mailinfo: fix out-of-bounds memory reads in unquote_quoted_pair()
      t5100: make rfc822 comment test more careful
      mailinfo: avoid recursion when unquoting From headers
      t1006: add tests for %(objectsize:disk)
      commit-graph: retain commit slab when closing NULL commit_graph
      index-pack: spawn threads atomically
      transport-helper: re-examine object dir after fetching
      diff: handle NULL meta-info when spawning external diff
      Makefile: use mkdir_p_parent_template for UNIT_TEST_BIN
      Makefile: remove UNIT_TEST_BIN directory with "make clean"
      t/Makefile: get UNIT_TESTS list from C sources
      trailer: fix comment/cut-line regression with opts->no_divider

Jiang Xin (14):
      t5574: test porcelain output of atomic fetch
      fetch: no redundant error message for atomic fetch
      test-pkt-line: add option parser for unpack-sideband
      pkt-line: memorize sideband fragment in reader
      pkt-line: do not chomp newlines for sideband messages
      transport-helper: no connection restriction in connect_helper
      remote-curl: supports git-upload-archive service
      transport-helper: protocol v2 supports upload-archive
      http-backend: new rpc-service for git-upload-archive
      transport-helper: call do_take_over() in connect_helper
      transport-helper: call do_take_over() in process_connect
      diff: mark param1 and param2 as placeholders
      l10n: ci: remove unused param for add-pr-comment@v2
      l10n: ci: disable cache for setup-go to suppress warnings

Joanna Wang (2):
      attr: enable attr pathspec magic for git-add and git-stash
      attr: add builtin objectmode values support

Johannes Schindelin (15):
      artifacts-tar: when including `.dll` files, don't forget the unit-t=
ests
      cmake: fix typo in variable name
      cmake: also build unit tests
      cmake: use test names instead of full paths
      unit-tests: do not mistake `.pdb` files for being executable
      cmake: handle also unit tests
      unit-tests: do show relative file paths
      ci: avoid running the test suite _twice_
      packfile.c: fix a typo in `each_file_in_pack_dir_fn()`'s declaratio=
n
      trace2: redact passwords from https:// URLs by default
      win32: special-case `ENOSPC` when writing to a pipe
      Always check the return value of `repo_read_object_file()`
      l10n: bump Actions versions in l10n.yml
      ci: bump remaining outdated Actions versions
      ci(linux32): add a note about Actions that must not be updated

John Cai (15):
      t3210: move to t0601
      remove REFFILES prerequisite for some tests in t1405 and t2017
      t1414: convert test to use Git commands instead of writing refs man=
ually
      t1404: move reffiles specific tests to t0600
      t1405: move reffiles specific tests to t0601
      t1406: move reffiles specific tests to t0600
      t1410: move reffiles specific tests to t0600
      t1415: move reffiles specific tests to t0601
      t1503: move reffiles specific tests to t0600
      t3903: make drop stash test ref backend agnostic
      t4202: move reffiles specific tests to t0600
      t5312: move reffiles specific tests to t0601
      reftable: honor core.fsync
      index-pack: test and document --strict=3D<msg-id>=3D<severity>...
      index-pack: --fsck-objects to take an optional argument for fsck ms=
gs

Jordi Mas (1):
      l10n: Update Catalan translation

Josh Brobst (1):
      builtin/reflog.c: fix dry-run option short name

Josh Soref (13):
      doc: update links to current pages
      doc: switch links to https
      doc: update links for andre-simon.de
      doc: refer to internet archive
      CodingGuidelines: move period inside parentheses
      CodingGuidelines: write punctuation marks
      SubmittingPatches: drop ref to "What's in git.git"
      SubmittingPatches: discourage new trailers
      SubmittingPatches: update extra tags list
      SubmittingPatches: provide tag naming advice
      SubmittingPatches: clarify GitHub visual
      SubmittingPatches: clarify GitHub artifact format
      SubmittingPatches: hyphenate non-ASCII

Josh Steadmon (4):
      unit tests: add a project plan document
      ci: run unit tests in CI
      fuzz: fix fuzz test build rules
      ci: build and run minimal fuzzers in GitHub CI

Julian Prein (1):
      hooks--pre-commit: detect non-ASCII when renaming

Junio C Hamano (57):
      cache: add fake_lstat()
      diff-lib: fix check_removed() when fsmonitor is active
      checkout: refactor die_if_checked_out() caller
      orphan/unborn: add to the glossary and use them consistently
      orphan/unborn: fix use of 'orphan' in end-user facing messages
      revision: parse integer arguments to --max-count, --skip, etc., mor=
e carefully
      Start the 2.44 cycle
      checkout: forbid "-B <branch>" from touching a branch used elsewher=
e
      git.txt: HEAD is not that special
      git-bisect.txt: BISECT_HEAD is not that special
      refs.h: HEAD is not that special
      docs: AUTO_MERGE is not that special
      docs: MERGE_AUTOSTASH is not that special
      doc: format.notes specify a ref under refs/notes/ hierarchy
      The second batch
      remote.h: retire CAS_OPT_NAME
      The third batch
      archive: "--list" does not take further options
      sparse-checkout: use default patterns for 'set' only !stdin
      The fourth batch
      The fifth batch
      The sixth batch
      messages: mark some strings with "up-to-date" not to touch
      The seventh batch
      The eighth batch
      The ninth batch
      Docs: majordomo@vger.kernel.org has been decomissioned
      CoC: whitespace fix
      ls-files: avoid the verb "deprecate" for individual options
      The tenth batch
      builtin/worktree: comment style fixes
      merge-ort.c: comment style fix
      reftable/pq_test: comment style fix
      The eleventh batch
      t0091: allow test in a repository without tags
      The twelfth batch
      Makefile: reduce repetitive library paths
      Makefile: simplify output of the libpath_template
      The thirteenth batch
      GitHub Actions: update to checkout@v4
      GitHub Actions: update to github-script@v7
      t/Makefile: say the default target upfront
      The fourteenth batch
      tag: fix sign_buffer() call to create a signed tag
      bisect: document "terms" subcommand more fully
      bisect: document command line arguments for "bisect start"
      ssh signing: signal an error with a negative return value
      The fifteenth batch
      Git 2.43.1
      Git 2.44-rc0
      unit-tests: do show relative file paths on non-Windows, too
      A few more topics before -rc1
      write-or-die: fix the polarity of GIT_FLUSH environment variable
      A few more fixes before -rc1
      Git 2.43.2
      Hopefully the last batch of fixes before 2.44 final
      Git 2.44-rc2

Justin Tobler (2):
      t1401: remove lockfile creation
      t5541: remove lockfile creation

Kristoffer Haugsbakk (5):
      config: format newlines
      config: rename global config function
      config: factor out global config file retrieval
      maintenance: use XDG config if it exists
      config: add back code comment

Kyle Lippincott (1):
      setup: allow cwd=3D.git w/ bareRepository=3Dexplicit

Linus Arver (4):
      commit: ignore_non_trailer computes number of bytes to ignore
      trailer: find the end of the log message
      trailer: use offsets for trailer_start/trailer_end
      strvec: use correct member name in comments

M Hickford (1):
      credential/wincred: store oauth_refresh_token

Maarten van der Schrieck (1):
      Documentation: fix statement about rebase.instructionFormat

Marcel Krause (1):
      doc: make the gitfile syntax easier to discover

Marcelo Roberto Jimenez (1):
      gitweb: die when a configuration file cannot be read

Michael Lohmann (2):
      Documentation/git-merge.txt: fix reference to synopsis
      Documentation/git-merge.txt: use backticks for command wrapping

Nikolay Borisov (1):
      rebase: fix documentation about used shell in -x

Nikolay Edigaryev (1):
      rev-list-options: fix off-by-one in '--filter=3Dblob:limit=3D<n>' e=
xplainer

Patrick Steinhardt (139):
      t: allow skipping expected object ID in `ref-store update-ref`
      t: convert tests to not write references via the filesystem
      t: convert tests to not access symrefs via the filesystem
      t: convert tests to not access reflog via the filesystem
      t1450: convert tests to remove worktrees via git-worktree(1)
      t4207: delete replace references via git-update-ref(1)
      t7300: assert exact states of repo
      t7900: assert the absence of refs via git-for-each-ref(1)
      t: mark several tests that assume the files backend with REFFILES
      ci: reorder definitions for grouping functions
      ci: make grouping setup more generic
      ci: group installation of Docker dependencies
      ci: split out logic to set up failed test artifacts
      ci: unify setup of some environment variables
      ci: squelch warnings when testing with unusable Git repo
      ci: install test dependencies for linux-musl
      ci: add support for GitLab CI
      t/lib-httpd: dynamically detect httpd and modules path
      t/lib-httpd: stop using legacy crypt(3) for authentication
      t9164: fix inability to find basename(1) in Subversion hooks
      global: convert trivial usages of `test <expr> -a/-o <expr>`
      contrib/subtree: stop using `-o` to test for number of args
      contrib/subtree: convert subtree type check to use case statement
      Makefile: stop using `test -o` when unlinking duplicate executables
      t5510: ensure that the packed-refs file needs locking
      refs/files: use transactions to delete references
      refs: deduplicate code to delete references
      refs: remove `delete_refs` callback from backends
      commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
      t0410: mark tests to require the reffiles backend
      t1400: split up generic reflog tests from the reffile-specific ones
      t1401: stop treating FETCH_HEAD as real reference
      t1410: use test-tool to create empty reflog
      t1417: make `reflog --updateref` tests backend agnostic
      t3310: stop checking for reference existence via `test -f`
      t4013: simplify magic parsing and drop "failure"
      t5401: speed up creation of many branches
      t5551: stop writing packed-refs directly
      t6301: write invalid object ID via `test-tool ref-store`
      reftable: wrap EXPECT macros in do/while
      reftable: handle interrupted reads
      reftable: handle interrupted writes
      reftable/stack: verify that `reftable_stack_add()` uses auto-compac=
tion
      reftable/stack: perform auto-compaction with transactional interfac=
e
      reftable/stack: reuse buffers when reloading stack
      reftable/stack: fix stale lock when dying
      reftable/stack: fix use of unseeded randomness
      reftable/merged: reuse buffer to compute record keys
      reftable/block: introduce macro to initialize `struct block_iter`
      reftable/block: reuse buffer to compute record keys
      setup: extract function to create the refdb
      setup: allow skipping creation of the refdb
      remote-curl: rediscover repository when fetching refs
      builtin/clone: fix bundle URIs with mismatching object formats
      builtin/clone: set up sparse checkout later
      builtin/clone: skip reading HEAD when retrieving remote
      builtin/clone: create the refdb with the correct object format
      wt-status: read HEAD and ORIG_HEAD via the refdb
      refs: propagate errno when reading special refs fails
      refs: complete list of special refs
      bisect: consistently write BISECT_EXPECTED_REV via the refdb
      tests: adjust whitespace in chainlint expectations
      t: introduce DEFAULT_REPO_FORMAT prereq
      worktree: skip reading HEAD when repairing worktrees
      refs: refactor logic to look up storage backends
      setup: start tracking ref storage format
      setup: set repository's formats on init
      setup: introduce "extensions.refStorage" extension
      setup: introduce GIT_DEFAULT_REF_FORMAT envvar
      t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
      builtin/rev-parse: introduce `--show-ref-format` flag
      builtin/init: introduce `--ref-format=3D` value flag
      builtin/clone: introduce `--ref-format=3D` value flag
      t9500: write "extensions.refstorage" into config
      reftable/stack: do not overwrite errors when compacting
      reftable/stack: do not auto-compact twice in `reftable_stack_add()`
      reftable/writer: fix index corruption when writing multiple indices
      reftable/record: constify some parts of the interface
      reftable/record: store "val1" hashes as static arrays
      reftable/record: store "val2" hashes as static arrays
      reftable/merged: really reuse buffers to compute record keys
      reftable/merged: transfer ownership of records when iterating
      git-prompt: stop manually parsing HEAD with unknown ref formats
      ci: add job performing static analysis on GitLab CI
      refs: prepare `refs_init_db()` for initializing worktree refs
      setup: move creation of "refs/" into the files backend
      refs/files: skip creation of "refs/{heads,tags}" for worktrees
      builtin/worktree: move setup of commondir file earlier
      worktree: expose interface to look up worktree by name
      builtin/worktree: create refdb via ref backend
      reftable/stack: refactor stack reloading to have common exit path
      reftable/stack: refactor reloading to use file descriptor
      reftable/stack: use stat info to avoid re-reading stack list
      reftable/blocksource: refactor code to match our coding style
      reftable/blocksource: use mmap to read tables
      git-p4: stop reaching into the refdb
      commit-graph: fix memory leak when not writing graph
      completion: discover repo path in `__git_pseudoref_exists ()`
      t9902: verify that completion does not print anything
      completion: improve existence check for pseudo-refs
      completion: silence pseudoref existence check
      completion: treat dangling symrefs as existing pseudorefs
      t7527: decrease likelihood of racing with fsmonitor daemon
      Makefile: detect new Homebrew location for ARM-based Macs
      ci: handle TEST_OUTPUT_DIRECTORY when printing test failures
      ci: make p4 setup on macOS more robust
      ci: add macOS jobs to GitLab CI
      reftable/stack: unconditionally reload stack after commit
      reftable/stack: fix race in up-to-date check
      sequencer: clean up pseudo refs with REF_NO_DEREF
      sequencer: delete REBASE_HEAD in correct repo when picking commits
      refs: convert AUTO_MERGE to become a normal pseudo-ref
      sequencer: introduce functions to handle autostashes via refs
      refs: convert MERGE_AUTOSTASH to become a normal pseudo-ref
      refs: redefine special refs
      Documentation: add "special refs" to the glossary
      reftable/stack: adjust permissions of compacted tables
      t1300: make tests more robust with non-default ref backends
      t1301: mark test for `core.sharedRepository` as reffiles specific
      t1302: make tests more robust with new extensions
      t1419: mark test suite as files-backend specific
      t5526: break test submodule differently
      t: mark tests regarding git-pack-refs(1) to be backend specific
      reftable/stack: fsync "tables.list" during compaction
      reftable/reader: be more careful about errors in indexed seeks
      reftable/writer: use correct type to iterate through index entries
      reftable/writer: simplify writing index records
      reftable/writer: fix writing multi-level indices
      reftable: document reading and writing indices
      builtin/stash: report failure to write to index
      reftable: introduce macros to grow arrays
      reftable: introduce macros to allocate arrays
      reftable/stack: fix parameter validation when compacting range
      reftable/stack: index segments with `size_t`
      reftable/stack: use `size_t` to track stack slices during compactio=
n
      reftable/stack: use `size_t` to track stack length
      reftable/merged: refactor seeking of records
      reftable/merged: refactor initialization of iterators
      reftable/record: improve semantics when initializing records

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Philippe Blain (11):
      completion: complete missing rev-list options
      completion: complete --patch-with-raw
      completion: complete --encoding
      completion: complete missing 'git log' options
      ci(github): also skip logs of broken test cases
      imap-send: add missing "strbuf.h" include under NO_CURL
      .github/PULL_REQUEST_TEMPLATE.md: add a note about single-commit PR=
s
      completion: add space after config variable names also in Bash 3
      completion: complete 'submodule.*' config variables
      completion: add and use __git_compute_first_level_config_vars_for_s=
ection
      completion: add and use __git_compute_second_level_config_vars_for_=
section

Phillip Wood (4):
      unit tests: add TAP unit test framework
      show-ref --verify: accept pseudorefs
      t1400: use show-ref to check pseudorefs
      prune: mark rebase autostash and orig-head as reachable

Ralf Thielow (1):
      l10n: Update German translation

Ren=C3=A9 Scharfe (21):
      column: release strbuf and string_list after use
      i18n: factorize even more 'incompatible options' messages
      push: use die_for_incompatible_opt4() for - -delete/--tags/--all/--=
mirror
      repack: use die_for_incompatible_opt3() for -A/-k/--cruft
      revision: use die_for_incompatible_opt3() for - -graph/--reverse/--=
walk-reflogs
      revision, rev-parse: factorize incompatibility messages about - -ex=
clude-hidden
      clean: factorize incompatibility message
      worktree: standardize incompatibility messages
      worktree: simplify incompatibility message for --orphan and commit-=
ish
      show-ref: use die_for_incompatible_opt3()
      t6300: avoid hard-coding object sizes
      git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool
      rebase: use strvec_pushf() for format-patch revisions
      fast-import: use mem_pool_calloc()
      mem-pool: fix big allocations
      mem-pool: simplify alignment calculation
      t1006: prefer shell loop to awk for packed object sizes
      parse-options: fully disable option abbreviation with PARSE_OPT_KEE=
P_UNKNOWN
      parse-options: simplify positivation handling
      receive-pack: use find_commit_header() in check_cert_push_options()
      receive-pack: use find_commit_header() in check_nonce()

Rub=C3=A9n Justo (10):
      status: fix branch shown when not only bisecting
      branch: clarify <oldbranch> term
      advice: sort the advice related lists
      advice: fix an unexpected leading space
      branch: make the advice to force-deleting a conditional one
      advice: allow disabling the automatic hint in advise_if_enabled()
      t5332: mark as leak-free
      t6113: mark as leak-free
      test-lib: check for TEST_PASSES_SANITIZE_LEAK
      t0080: mark as leak-free

Sam Delmerico (1):
      push: region_leave trace for negotiate_using_fetch

Shreyansh Paliwal (1):
      test-lib-functions.sh: fix test_grep fail message wording

Simon Ser (1):
      format-patch: fix ignored encode_email_headers for cover letter

Stan Hu (2):
      completion: refactor existence checks for pseudorefs
      completion: support pseudoref existence checks for reftables

S=C3=B6ren Krecker (1):
      mingw: give more details about unsafe directory's ownership

Tamino Bauknecht (1):
      fetch: add new config option fetch.all

Taylor Blau (29):
      pack-objects: free packing_data in more places
      pack-bitmap-write: deep-clear the `bb_commit` slab
      pack-bitmap: plug leak in find_objects()
      midx: factor out `fill_pack_info()`
      midx: implement `BTMP` chunk
      midx: implement `midx_locate_pack()`
      pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
      ewah: implement `bitmap_is_empty()`
      pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signat=
ure
      pack-bitmap: return multiple packs via `reuse_partial_packfile_from=
_bitmap()`
      pack-objects: parameterize pack-reuse routines over a single pack
      pack-objects: keep track of `pack_start` for each reuse pack
      pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
      pack-objects: prepare `write_reused_pack()` for multi-pack reuse
      pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack=
 reuse
      pack-objects: include number of packs reused in output
      git-compat-util.h: implement checked size_t to uint32_t conversion
      midx: implement `midx_preferred_pack()`
      pack-revindex: factor out `midx_key_to_pack_pos()` helper
      pack-revindex: implement `midx_pair_to_pack_pos()`
      pack-bitmap: prepare to mark objects from multiple packs for reuse
      pack-objects: add tracing for various packfile metrics
      t/test-lib-functions.sh: implement `test_trace2_data` helper
      pack-objects: allow setting `pack.allowPackReuse` to "single"
      pack-bitmap: enable reuse from all bitmapped packs
      t/perf: add performance tests for multi-pack reuse
      pack-bitmap: drop unused `reuse_objects`
      t5332-multi-pack-reuse.sh: extract pack-objects helper functions
      pack-objects: enable multi-pack reuse via `feature.experimental`

Teng Long (1):
      l10n: zh_CN: for git 2.44 rounds

Todd Zullinger (3):
      perl: bump the required Perl version to 5.8.1 from 5.8.0
      send-email: avoid duplicate specification warnings
      RelNotes: minor typo fixes in 2.44.0 draft

Toon Claes (1):
      builtin/show-ref: treat directory as non-existing in --exists

Vegard Nossum (1):
      sequencer: unset GIT_CHERRY_PICK_HELP for 'exec' commands

Victoria Dye (15):
      ref-filter.c: really don't sort when using --no-sort
      ref-filter.h: add max_count and omit_empty to ref_format
      ref-filter.h: move contains caches into filter
      ref-filter.h: add functions for filter/format & format-only
      ref-filter.c: rename 'ref_filter_handler()' to 'filter_one()'
      ref-filter.c: refactor to create common helper functions
      ref-filter.c: filter & format refs in the same callback
      for-each-ref: clean up documentation of --format
      ref-filter.c: use peeled tag for '*' format fields
      t/perf: add perf tests for for-each-ref
      submodule-config.h: move check_submodule_url
      test-submodule: remove command line handling for check-name
      t7450: test submodule urls
      submodule-config.c: strengthen URL fsck check
      ref-filter.c: sort formatted dates by byte value

Yi-Jyun Pan (1):
      l10n: zh_TW: Git 2.44

Zach FettersMoore (1):
      subtree: fix split processing with multiple subtrees present

