Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676D520954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdK2BPs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:15:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57720 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752260AbdK2BPq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 20:15:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C228B8D37;
        Tue, 28 Nov 2017 20:15:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=rrQ/ayo0M4B3LYiZOmslW3rlx
        yc=; b=D0Y1YcCsaTvpboDyntGCcYzcZOh//xNJN0t2lk2X0xB57ngmYSKDyEeaN
        Ihl8uFFcVuPedaVrobh0BD9G5+LFKXf4QQWCY8XbHu1ke0hQmeAcDUaE4oIpneS9
        xmRtEvOId/JRX+Ix4uTdToJ1YC1BeNrslwWkS3R2NIPoayZzRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Y+EW+vFCutAlzyiVUAc
        JtQ5UiK6v7cPF43rSBKvZp8fL7KKcp7gydY+j7QqJH4uAiqsREEVLAIJnTZD5z17
        HVDASN9l8sYIyZ3SGhv+YDtJI8ssPiY+dWJRjfSs6SYXnkBs2ZsR1IEQDfu/x5wI
        nFXX0iDn/ziAXm/VgK8HixtY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33277B8D36;
        Tue, 28 Nov 2017 20:15:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CD2BB8D34;
        Tue, 28 Nov 2017 20:15:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.15.1
Date:   Tue, 28 Nov 2017 14:12:56 +0900
Message-ID: <xmqqo9nl6g1v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D249C950-D4A2-11E7-A635-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.15.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.15.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.15.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.15
-----------------

 * TravisCI build updates.

 * "auto" as a value for the columnar output configuration ought to
   judge "is the output consumed by humans?" with the same criteria as
   "auto" for coloured output configuration, i.e. either the standard
   output stream is going to tty, or a pager is in use.  We forgot the
   latter, which has been fixed.

 * The experimental "color moved lines differently in diff output"
   feature was buggy around "ignore whitespace changes" edges, which
   has been corrected.

 * Instead of using custom line comparison and hashing functions to
   implement "moved lines" coloring in the diff output, use the pair
   of these functions from lower-layer xdiff/ code.

 * Some codepaths did not check for errors when asking what branch the
   HEAD points at, which have been fixed.

 * "git commit", after making a commit, did not check for errors when
   asking on what branch it made the commit, which has been corrected.

 * "git status --ignored -u" did not stop at a working tree of a
   separate project that is embedded in an ignored directory and
   listed files in that other project, instead of just showing the
   directory itself as ignored.

 * A broken access to object databases in recent update to "git grep
   --recurse-submodules" has been fixed.

 * A recent regression in "git rebase -i" that broke execution of git
   commands from subdirectories via "exec" instruction has been fixed.

 * "git check-ref-format --branch @{-1}" bit a "BUG()" when run
   outside a repository for obvious reasons; clarify the documentation
   and make sure we do not even try to expand the at-mark magic in
   such a case, but still call the validation logic for branch names.

 * Command line completion (in contrib/) update.

 * Description of blame.{showroot,blankboundary,showemail,date}
   configuration variables have been added to "git config --help".

 * After an error from lstat(), diff_populate_filespec() function
   sometimes still went ahead and used invalid data in struct stat,
   which has been fixed.

 * UNC paths are also relevant in Cygwin builds and they are now
   tested just like Mingw builds.

 * Correct start-up sequence so that a repository could be placed
   immediately under the root directory again (which was broken at
   around Git 2.13).

 * The credential helper for libsecret (in contrib/) has been improved
   to allow possibly prompting the end user to unlock secrets that are
   currently locked (otherwise the secrets may not be loaded).

 * Updates from GfW project.

 * "git rebase -i" recently started misbehaving when a submodule that
   is configured with 'submodule.<name>.ignore' is dirty; this has
   been corrected.

 * Some error messages did not quote filenames shown in it, which have
   been fixed.

 * Building with NO_LIBPCRE1_JIT did not disable it, which has been fixed=
.

 * We used to add an empty alternate object database to the system
   that does not help anything; it has been corrected.

 * Error checking in "git imap-send" for empty response has been
   improved.

 * An ancient bug in "git apply --ignore-space-change" codepath has
   been fixed.

 * There was a recent semantic mismerge in the codepath to write out a
   section of a configuration section, which has been corrected.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.15.0 are as follows:

Adam Dinwoodie (3):
      t5580: add Cygwin support
      rebase -i: fix comment typo
      doc/SubmittingPatches: correct subject guidance

Andrey Okoshkin (2):
      commit: check result of resolve_ref_unsafe
      diff: fix lstat() error handling in diff_populate_filespec()

Brandon Williams (1):
      wt-status: actually ignore submodules when requested

Carlos Mart=C3=ADn Nieto (1):
      diff: --indent-heuristic is no longer experimental

Charles Bailey (2):
      t4201: make use of abbreviation in the test more robust
      grep: fix NO_LIBPCRE1_JIT to fully disable JIT

Dennis Kaarsemaker (1):
      credential-libsecret: unlock locked secrets

Jacob Keller (1):
      sequencer: pass absolute GIT_DIR to exec commands

Jakub Bere=C5=BCa=C5=84ski (2):
      t0302: check helper can handle empty credentials
      wincred: handle empty username/password correctly

Jean Carlo Machado (1):
      fix typos in 2.15.0 release notes

Jeff King (11):
      t4015: refactor --color-moved whitespace test
      t4015: check "negative" case for "-w --color-moved"
      t4015: test the output of "diff --color-moved -b"
      diff: fix whitespace-skipping with --color-moved
      diff: handle NULs in get_string_hash()
      test-ref-store: avoid passing NULL to printf
      remote: handle broken symrefs
      log: handle broken HEAD in decoration check
      worktree: handle broken symrefs in find_shared_symref()
      setup: avoid double slashes when looking for HEAD
      link_alt_odb_entries: make empty input a noop

Johannes Schindelin (5):
      status: do not get confused by submodules in excluded directories
      mingw: include the full version information in the resources
      mingw: add experimental feature to redirect standard handles
      mingw: optionally redirect stderr/stdout via the same handle
      mingw: document the standard handle redirection

Junio C Hamano (9):
      t5601: rm the target file of cp that could still be executing
      check-ref-format --branch: do not expand @{...} outside repository
      check-ref-format --branch: strip refs/heads/ using skip_prefix
      check-ref-format doc: --branch validates and expands <branch>
      column: do not include pager.c
      Start preparation for 2.15.1
      Almost ready for 2.15.1
      A bit more fixes for 2.15.1
      Git 2.15.1

Kaartic Sivaraam (1):
      mailmap: use Kaartic Sivaraam's new address

Kevin Daudt (1):
      column: show auto columns when pager is active

Martin =C3=85gren (7):
      grep: take the read-lock when adding a submodule
      bisect: change calling-convention of `find_bisection()`
      bisect: fix memory leak in `find_bisection()`
      bisect: fix off-by-one error in `best_bisection_sorted()`
      bisect: fix memory leak when returning best element
      builtin/merge-base: free commit lists
      reduce_heads: fix memory leaks

Ren=C3=A9 Scharfe (6):
      sequencer: factor out rewrite_file()
      sequencer: use O_TRUNC to truncate files
      imap-send: handle NULL return of next_arg()
      imap-send: handle missing response codes gracefully
      apply: avoid out-of-bounds access in fuzzy_matchlines()
      config: flip return value of write_section()

SZEDER G=C3=A1bor (2):
      travis-ci: fix running P4 and Git LFS tests in Linux build jobs
      travis-ci: don't build Git for the static analysis job

Simon Ruderich (2):
      sequencer.c: check return value of close() in rewrite_file()
      wrapper.c: consistently quote filenames in error messages

Stefan Beller (3):
      xdiff-interface: export comparing and hashing strings
      diff.c: get rid of duplicate implementation
      config: document blame configuration

Thomas Braun (1):
      completion: add remaining flags to checkout

Todd Zullinger (3):
      Replace Free Software Foundation address in license notices
      Replace Free Software Foundation address in license notices
      RelNotes: minor typo fixes in 2.15.1 draft

