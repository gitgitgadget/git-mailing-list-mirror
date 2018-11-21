Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8891F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 15:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeKVByb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 20:54:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbeKVByb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 20:54:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7160C11239E;
        Wed, 21 Nov 2018 10:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=HRhWZ/3lCuAhJ6gcK5e03Rwmc
        eg=; b=bseVEmbi+1gUJW4ylRxosSkyWyLZRT7uFHTBQw+ivk9zwuNatA3WW3M2H
        sxP59eJ5KtEZiTh8o8y0d+oqRaktMUa8yMJMwhQTUFZiXiAUgazgSsyAywTZ70fu
        nw9hAAoVVuDB/7jfSldWLrXCa6WbpxGhNZIZd53RDQdsMw8ycc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=PIvX+Om0PgCgFre8RcV
        p76em6s+zz4nDKnTcO6aD/yy+YxTiBqYfr0PIHHbgtvAryarRNc7kRSiXTgKEJaB
        r6fTKgRRA10XnzXu3NA+2VkLuEpgpeXIIJOTBmzkmdWDpL2Fuye0BLUQahQVRyHq
        sJjuDP7iU6ULE9Oh5me1iHpw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A22511239D;
        Wed, 21 Nov 2018 10:19:32 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1B0911239C;
        Wed, 21 Nov 2018 10:19:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.19.2
Date:   Thu, 22 Nov 2018 00:19:30 +0900
Message-ID: <xmqqtvka5ugt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D89177BE-EDA0-11E8-98CD-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.19.2 is now available at the
usual places.  This is a collection of small fixes that have been
accumulated on the primary development track, merged on top of
v2.19.1 released earlier in the year.  On the 'master' front, we are
nearing the upcoming future release, by the way.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.19.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.19.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.19.1
-------------------

 * "git interpret-trailers" and its underlying machinery had a buggy
   code that attempted to ignore patch text after commit log message,
   which triggered in various codepaths that will always get the log
   message alone and never get such an input.

 * "git rebase -i" did not clear the state files correctly when a run
   of "squash/fixup" is aborted and then the user manually amended the
   commit instead, which has been corrected.

 * When fsmonitor is in use, after operation on submodules updates
   .gitmodules, we lost track of the fact that we did so and relied on
   stale fsmonitor data.

 * Fix for a long-standing bug that leaves the index file corrupt when
   it shrinks during a partial commit.

 * Further fix for O_APPEND emulation on Windows

 * A corner case bugfix in "git rerere" code.

 * "git add ':(attr:foo)'" is not supported and is supposed to be
   rejected while the command line arguments are parsed, but we fail
   to reject such a command line upfront.

 * "git rebase" etc. in Git 2.19 fails to abort when given an empty
   commit log message as result of editing, which has been corrected.

 * The code to backfill objects in lazily cloned repository did not
   work correctly, which has been corrected.

 * Update error messages given by "git remote" and make them consistent.

 * "git update-ref" learned to make both "--no-deref" and "--stdin"
   work at the same time.

 * Recently added "range-diff" had a corner-case bug to cause it
   segfault, which has been corrected.

 * The recently introduced commit-graph auxiliary data is incompatible
   with mechanisms such as replace & grafts that "breaks" immutable
   nature of the object reference relationship.  Disable optimizations
   based on its use (and updating existing commit-graph) when these
   incompatible features are in use in the repository.

 * The mailmap file update.

 * The code in "git status" sometimes hit an assertion failure.  This
   was caused by a structure that was reused without cleaning the data
   used for the first run, which has been corrected.

 * A corner-case bugfix.

 * A partial clone that is configured to lazily fetch missing objects
   will on-demand issue a "git fetch" request to the originating
   repository to fill not-yet-obtained objects.  The request has been
   optimized for requesting a tree object (and not the leaf blob
   objects contained in it) by telling the originating repository that
   no blobs are needed.

 * The codepath to support the experimental split-index mode had
   remaining "racily clean" issues fixed.

 * "git log --graph" showing an octopus merge sometimes miscounted the
   number of display columns it is consuming to show the merge and its
   parent commits, which has been corrected.

 * The implementation of run_command() API on the UNIX platforms had a
   bug that caused a command not on $PATH to be found in the current
   directory.

 * A mutex used in "git pack-objects" were not correctly initialized
   and this caused "git repack" to dump core on Windows.

 * Under certain circumstances, "git diff D:/a/b/c D:/a/b/d" on
   Windows would strip initial parts from the paths because they
   were not recognized as absolute, which has been corrected.

 * The receive.denyCurrentBranch=3DupdateInstead codepath kicked in even
   when the push should have been rejected due to other reasons, such
   as it does not fast-forward or the update-hook rejects it, which
   has been corrected.

 * "git repack" in a shallow clone did not correctly update the
   shallow points in the repository, leading to a repository that
   does not pass fsck.

 * Operations on promisor objects make sense in the context of only a
   small subset of the commands that internally use the revisions
   machinery, but the "--exclude-promisor-objects" option were taken
   and led to nonsense results by commands like "log", to which it
   didn't make much sense.  This has been corrected.

 * The "container" mode of TravisCI is going away.  Our .travis.yml
   file is getting prepared for the transition.

 * Our test scripts can now take the '-V' option as a synonym for the
   '--verbose-log' option.

 * A regression in Git 2.12 era made "git fsck" fall into an infinite
   loop while processing truncated loose objects.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.19.1 are as follows:

Alexander Pyhalov (1):
      t7005-editor: quote filename to fix whitespace-issue

Andreas Heiduk (6):
      doc: clarify boundaries of 'git worktree list --porcelain'
      doc: fix ASCII art tab spacing
      doc: fix inappropriate monospace formatting
      doc: fix descripion for 'git tag --format'
      doc: fix indentation of listing blocks in gitweb.conf.txt
      doc: fix formatting in git-update-ref

Ben Peart (1):
      git-mv: allow submodules and fsmonitor to work together

Brandon Williams (1):
      config: document value 2 for protocol.version

Daniels Umanovskis (3):
      doc: move git-rev-parse from porcelain to plumbing
      doc: move git-get-tar-commit-id to plumbing
      doc: move git-cherry to plumbing

David Zych (1):
      doc: clarify gitcredentials path component matching

Derrick Stolee (6):
      commit-graph: update design document
      test-repository: properly init repo
      commit-graph: not compatible with replace objects
      commit-graph: not compatible with grafts
      commit-graph: not compatible with uninitialized repo
      commit-graph: close_commit_graph before shallow walk

Elijah Newren (7):
      Remove superfluous trailing semicolons
      t4200: demonstrate rerere segfault on specially crafted merge
      rerere: avoid buffer overrun
      update-ref: fix type of update_flags variable to match its usage
      update-ref: allow --no-deref with --stdin
      sequencer: fix --allow-empty-message behavior, make it smarter
      commit: fix erroneous BUG, 'multiple renames on the same target? ho=
w?'

Frederick Eaton (3):
      git-archimport.1: specify what kind of Arch we're talking about
      git-column.1: clarify initial description, provide examples
      git-describe.1: clarify that "human readable" is also git-readable

Jeff Hostetler (2):
      t0051: test GIT_TRACE to a windows named pipe
      mingw: fix mingw_open_append to work with named pipes

Jeff King (16):
      trailer: use size_t for string offsets
      trailer: use size_t for iterating trailer list
      trailer: pass process_trailer_opts to trailer_info_get()
      interpret-trailers: tighten check for "---" patch boundary
      interpret-trailers: allow suppressing "---" divider
      pretty, ref-filter: format %(trailers) with no_divider option
      sequencer: ignore "---" divider when parsing trailers
      append_signoff: use size_t for string offsets
      reopen_tempfile(): truncate opened file
      config.mak.dev: add -Wformat-security
      receive-pack: update comment with check_everything_connected
      run-command: mark path lookup errors with ENOENT
      upload-pack: fix broken if/else chain in config callback
      t1450: check large blob in trailing-garbage test
      check_stream_sha1(): handle input underflow
      cat-file: handle streaming failures consistently

Johannes Schindelin (8):
      rebase -i --autosquash: demonstrate a problem skipping the last squ=
ash
      rebase -i: be careful to wrap up fixup/squash chains
      pack-objects: fix typo 'detla' -> 'delta'
      pack-objects (mingw): demonstrate a segmentation fault with large d=
eltas
      pack-objects (mingw): initialize `packing_data` mutex in the correc=
t spot
      repack: point out a bug handling stale shallow info
      shallow: offer to prune only non-existing entries
      repack -ad: prune the list of shallow commits

Johannes Sixt (2):
      diff: don't attempt to strip prefix from absolute Windows paths
      t3404-rebase-interactive: test abbreviated commands

Jonathan Nieder (2):
      mailmap: consistently normalize brian m. carlson's name
      git doc: direct bug reporters to mailing list archive

Jonathan Tan (4):
      fetch-object: unify fetch_object[s] functions
      fetch-object: set exact_oid when fetching
      fetch-pack: avoid object flags if no_dependents
      fetch-pack: exclude blobs when lazy-fetching trees

Junio C Hamano (5):
      CodingGuidelines: document the API in *.h files
      receive: denyCurrentBranch=3Dupdateinstead should not blindly updat=
e
      cocci: simplify "if (++u > 1)" to "if (u++)"
      fsck: s/++i > 1/i++/
      Git 2.19.2

Martin =C3=85gren (5):
      git-commit-graph.txt: fix bullet lists
      git-commit-graph.txt: typeset more in monospace
      git-commit-graph.txt: refer to "*commit*-graph file"
      Doc: refer to the "commit-graph file" with dash
      t1400: drop debug `echo` to actually execute `test`

Matthew DeVore (2):
      Documentation/git-log.txt: do not show --exclude-promisor-objects
      exclude-promisor-objects: declare when option is allowed

Michael Witten (3):
      docs: typo: s/go/to/
      docs: graph: remove unnecessary `graph_update()' call
      docs: typo: s/isimilar/similar/

Mihir Mehta (1):
      doc: fix a typo and clarify a sentence

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      add: do not accept pathspec magic 'attr'
      config.txt: correct the note about uploadpack.packObjectsHook

Noam Postavsky (1):
      log: fix coloring of certain octopus merge shapes

Ren=C3=A9 Scharfe (1):
      sequencer: use return value of oidset_insert()

SZEDER G=C3=A1bor (12):
      Documentation/git.txt: clarify that GIT_TRACE=3D/path appends
      t3701-add-interactive: tighten the check of trace output
      t1700-split-index: drop unnecessary 'grep'
      t0090: disable GIT_TEST_SPLIT_INDEX for the test checking split ind=
ex
      t1700-split-index: document why FSMONITOR is disabled in this test =
script
      split-index: add tests to demonstrate the racy split index problem
      t1700-split-index: date back files to avoid racy situations
      split-index: count the number of deleted entries
      split-index: don't compare cached data of entries already marked fo=
r split index
      split-index: smudge and add racily clean cache entries to split ind=
ex
      split-index: BUG() when cache entry refers to non-existing shared e=
ntry
      test-lib: introduce the '-V' short option for '--verbose-log'

Sam McKelvie (1):
      rev-parse: --show-superproject-working-tree should work during a me=
rge

Saulius Gurklys (1):
      doc: fix small typo in git show-branch

Sebastian Staudt (1):
      travis-ci: no longer use containers

Shulhan (1):
      builtin/remote: quote remote name on error to display empty name

Stefan Beller (4):
      refs.c: migrate internal ref iteration to pass thru repository argu=
ment
      refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callb=
ack
      string-list: remove unused function print_string_list
      strbuf.h: format according to coding guidelines

Tao Qingyun (3):
      refs: docstring typo
      builtin/branch.c: remove useless branch_get
      branch: trivial style fix

Thomas Gummerer (4):
      .gitattributes: add conflict-marker-size for relevant files
      linear-assignment: fix potential out of bounds memory access
      t5551: move setup code inside test_expect blocks
      t5551: compare sorted cookies files

Tim Schumacher (1):
      Documentation/Makefile: make manpage-base-url.xsl generation quiete=
r

Torsten B=C3=B6gershausen (2):
      Make git_check_attr() a void function
      path.c: char is not (always) signed

Uwe Kleine-K=C3=B6nig (1):
      howto/using-merge-subtree: mention --allow-unrelated-histories

