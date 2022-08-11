Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5BEC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 18:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiHKSEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiHKSEg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 14:04:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A709D12C
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 11:04:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B9351BFF2C;
        Thu, 11 Aug 2022 14:04:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Z3ifk6RUAxI057At/FuFD+Vxp
        WO3DB7bSzwDjgHs66w=; b=Bjg/gZkfYGHE5TQ4nhX35AARQmalGhqGbXUFkup4f
        qQK1xXfzKQBygllhcseUm/7P9gXerqxzg5ghqcIHIOHJCPly5OJad760faDpyFp5
        Y9e6+fM/n6RbtsB/t5N+XdrQFrBlDISkfrjeBx4K2nORQnaM9wMSD/0is84uWdC3
        PM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 229961BFF2B;
        Thu, 11 Aug 2022 14:04:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85DE01BFF2A;
        Thu, 11 Aug 2022 14:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.37.2
Date:   Thu, 11 Aug 2022 11:04:29 -0700
Message-ID: <xmqqedxmfyhe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0C06EDCA-19A0-11ED-B5A2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.37.2 is now available at
the usual places. =20

This is to merge down the bugfixes accumulated on the 'master' front
since Git v2.37.1 was tagged.  There was no particular reason why it
had to be released today, as none of the bugs fixed are security
bugs.  But there are a few correctness related bugfixes, and users
are encouraged to update, unless they are already running 'master'
or above, in which case they already have all the fixes that appear
here.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.37.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.37.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This primarily is to backport various fixes accumulated on the 'master'
front since 2.37.1.

Fixes since v2.37.1
-------------------

 * "git shortlog -n" relied on the underlying qsort() to be stable,
   which shouldn't have.  Fixed.

 * Variable quoting fix in the vimdiff driver of "git mergetool".

 * An earlier attempt to plug leaks placed a clean-up label to jump to
   at a bogus place, which as been corrected.

 * Fixes a long-standing corner case bug around directory renames in
   the merge-ort strategy.

 * Recent update to vimdiff layout code has been made more robust
   against different end-user vim settings.

 * In a non-bare repository, the behavior of Git when the
   core.worktree configuration variable points at a directory that has
   a repository as its subdirectory, regressed in Git 2.27 days.

 * References to commands-to-be-typed-literally in "git rebase"
   documentation mark-up have been corrected.

 * Give _() markings to fatal/warning/usage: labels that are shown in
   front of these messages.

 * "git mktree --missing" lazily fetched objects that are missing from
   the local object store, which was totally unnecessary for the purpose
   of creating the tree object(s) from its input.

 * Fixes for tests when the source directory has unusual characters in
   its path, e.g. whitespaces, double-quotes, etc.

 * Adjust technical/bitmap-format to be formatted by AsciiDoc, and
   add some missing information to the documentation.

 * Certain diff options are currently ignored when combined-diff is
   shown; mark them as incompatible with the feature.

 * "git clone" from a repository with some ref whose HEAD is unborn
   did not set the HEAD in the resulting repository correctly, which
   has been corrected.

 * mkstemp() emulation on Windows has been improved.

 * Add missing documentation for "include" and "includeIf" features in
   "git config" file format, which incidentally teaches the command
   line completion to include them in its offerings.

 * Avoid "white/black-list" in documentation and code comments.

 * Workaround for a compiler warning against use of die() in
   osx-keychain (in contrib/).

 * Workaround for a false positive compiler warning.

 * The resolve-undo information in the index was not protected against
   GC, which has been corrected.

 * A corner case bug where lazily fetching objects from a promisor
   remote resulted in infinite recursion has been corrected.

 * "git p4" working on UTF-16 files on Windows did not implement
   CRLF-to-LF conversion correctly, which has been corrected.

 * "git p4" did not handle non-ASCII client name well, which has been
   corrected.

 * "rerere-train" script (in contrib/) used to honor commit.gpgSign
   while recreating the throw-away merges.

 * "git checkout" miscounted the paths it updated, which has been
   corrected.

 * Fix for a bug that makes write-tree to fail to write out a
   non-existent index as a tree, introduced in 2.37.

 * There was a bug in the codepath to upgrade generation information
   in commit-graph from v1 to v2 format, which has been corrected.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.37.1 are as follows:

Abhradeep Chakraborty (3):
      bitmap-format.txt: feed the file to asciidoc to generate html
      bitmap-format.txt: fix some formatting issues
      bitmap-format.txt: add information for trailing checksum

Celeste Liu (1):
      contrib/rerere-train: avoid useless gpg sign in training

Cleber Rosa (1):
      setup: fix function name in a BUG() message

Derrick Stolee (9):
      t5510: replace 'origin' with URL more carefully
      vscode: improve tab size and wrapping
      git-rebase.txt: use back-ticks consistently
      daemon: clarify directory arguments
      git-cvsserver: clarify directory list
      git.txt: remove redundant language
      t: avoid "whitelist"
      transport.c: avoid "whitelist"
      compat/win32: correct for incorrect compiler warning

Dimitriy Ryazantcev (1):
      i18n: mark message helpers prefix for translation

Elijah Newren (6):
      t6429: fix use of non-existent function
      t6423: add tests of dual directory rename plus add/add conflict
      merge-ort: small cleanups of check_for_directory_rename
      merge-ort: make a separate function for freeing struct collisions
      merge-ort: shuffle the computation and cleanup of potential collisi=
ons
      merge-ort: fix issue with dual rename and add/add conflict

Fernando Ramos (1):
      vimdiff: make layout engine more robust against user vim settings

Goss Geppert (2):
      dir: traverse into repository
      dir: minor refactoring / clean-up

Han Xin (2):
      commit-graph.c: no lazy fetch in lookup_commit_in_graph()
      t5330: remove run_with_limited_processses()

Jeff King (6):
      revisions.txt: escape "..." to avoid asciidoc horizontal ellipsis
      clone: drop extra newline from warning message
      clone: propagate empty remote HEAD even with other branches
      clone: use remote branch if it matches default HEAD
      clone: move unborn head creation to update_head()
      diff-files: move misplaced cleanup label

Johannes Schindelin (3):
      tests: fix incorrect --write-junit-xml code
      mergetool(vimdiff): allow paths to contain spaces again
      shortlog: use a stable sort

Junio C Hamano (6):
      revision: mark blobs needed for resolve-undo as reachable
      fsck: do not dereference NULL while checking resolve-undo data
      builtin/remote.c: use the right kind of STRING_LIST_INIT
      Downmerge a handful of fixes for 2.37.x maintenance track
      Downmerge a bit more for 2.37.x
      Git 2.37.2

Kilian Kilger (2):
      git-p4: fix bug with encoding of p4 client name
      git-p4: refactoring of p4CmdList()

Lessley Dennington (1):
      osx-keychain: fix compiler warning

Li Linchao (1):
      ls-files: update test style

Manuel Boni (1):
      config.txt: document include, includeIf

Martin =C3=85gren (3):
      config/core.txt: fix minor issues for `core.sparseCheckoutCone`
      t4200: drop irrelevant code
      read-cache: make `do_read_index()` always set up `istate->repo`

Matheus Tavares (4):
      checkout: document bug where delayed checkout counts entries twice
      checkout: show bug about failed entries being included in final rep=
ort
      checkout: fix two bugs on the final count of updated entries
      pkt-line.h: move comment closer to the associated code

Moritz Baumann (1):
      git-p4: fix CR LF handling for utf16 files

Philippe Blain (3):
      diff-format.txt: dst can be 0* SHA-1 when path is deleted, too
      diff-format.txt: correct misleading wording
      diff-index.txt: update raw output format in examples

Ren=C3=A9 Scharfe (3):
      combine-diff: abort if --ignore-matching-lines is given
      combine-diff: abort if --output is given
      mingw: avoid mktemp() in mkstemp() implementation

Richard Oliver (1):
      mktree: do not check type of remote objects

SZEDER G=C3=A1bor (1):
      index-format.txt: remove outdated list of supported extensions

Tao Klerks (1):
      rev-parse: documentation adjustment - mention remote tracking with =
@{u}

Taylor Blau (4):
      pack-objects.h: remove outdated pahole results
      t5318: demonstrate commit-graph generation v2 corruption
      commit-graph: introduce `repo_find_commit_pos_in_graph()`
      commit-graph: fix corrupt upgrade from generation v1 to v2

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
      tests: add missing double quotes to included library paths
      test-lib.sh: fix prepend_var() quoting issue
      config tests: fix harmless but broken "rm -r" cleanup

