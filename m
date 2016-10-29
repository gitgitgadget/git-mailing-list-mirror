Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8102021E
	for <e@80x24.org>; Sat, 29 Oct 2016 06:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbcJ2GY3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 02:24:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59169 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750964AbcJ2GY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 02:24:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF87342DB8;
        Sat, 29 Oct 2016 02:24:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=v7Asx4mtZfrK9WZy2FFF+4kD0
        X0=; b=qUg9YTnBUK6Uw0j7/zio/do5UgxGQfEMjCCY3yDf8ObYvhiTtzIMeSFud
        0mMoPH/7y8dbo4BH6e158cM2/9XkqyJqeJI7M1utT9gXVCkSYixzZzOIw5U4O1s1
        vDZcb18ts9U+L4iXrBziXmkPr8rlqMpc8Z0wXFo1flVwwJKibU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=cjb72QpNNk28PVh0nOi
        eCuINrAvVZwX061ZXp6rHUjVPnQDAhipIzowX/M7fq1mMPGOLkdFccBpVpkywyp7
        bkQN5l4iC9U9eP9gUGtoa0W8TJpIMugEMWYyaodsGidyGe4KjBVr9rCp+AJg53+R
        OF5YiNLSI4Aeyg42CiDl0kGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E506142DB7;
        Sat, 29 Oct 2016 02:24:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CF9142DB6;
        Sat, 29 Oct 2016 02:24:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.10.2
Date:   Fri, 28 Oct 2016 23:24:23 -0700
Message-ID: <xmqqd1ijwu3s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5685FD78-9DA0-11E6-886F-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.10.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.10.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.10.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.10.1
-------------------

 * The code that parses the format parameter of for-each-ref command
   has seen a micro-optimization.

 * The "graph" API used in "git log --graph" miscounted the number of
   output columns consumed so far when drawing a padding line, which
   has been fixed; this did not affect any existing code as nobody
   tried to write anything after the padding on such a line, though.

 * Almost everybody uses DEFAULT_ABBREV to refer to the default
   setting for the abbreviation, but "git blame" peeked into
   underlying variable bypassing the macro for no good reason.

 * Doc update to clarify what "log -3 --reverse" does.

 * An author name, that spelled a backslash-quoted double quote in the
   human readable part "My \"double quoted\" name", was not unquoted
   correctly while applying a patch from a piece of e-mail.

 * The original command line syntax for "git merge", which was "git
   merge <msg> HEAD <parent>...", has been deprecated for quite some
   time, and "git gui" was the last in-tree user of the syntax.  This
   is finally fixed, so that we can move forward with the deprecation.

 * Codepaths that read from an on-disk loose object were too loose in
   validating what they are reading is a proper object file and
   sometimes read past the data they read from the disk, which has
   been corrected.  H/t to Gustavo Grieco for reporting.

 * "git worktree", even though it used the default_abbrev setting that
   ought to be affected by core.abbrev configuration variable, ignored
   the variable setting.  The command has been taught to read the
   default set of configuration variables to correct this.

 * A low-level function verify_packfile() was meant to show errors
   that were detected without dying itself, but under some conditions
   it didn't and died instead, which has been fixed.

 * When "git fetch" tries to find where the history of the repository
   it runs in has diverged from what the other side has, it has a
   mechanism to avoid digging too deep into irrelevant side branches.
   This however did not work well over the "smart-http" transport due
   to a design bug, which has been fixed.

 * When we started cURL to talk to imap server when a new enough
   version of cURL library is available, we forgot to explicitly add
   imap(s):// before the destination.  To some folks, that didn't work
   and the library tried to make HTTP(s) requests instead.

 * The ./configure script generated from configure.ac was taught how
   to detect support of SSL by libcurl better.

 * http.emptyauth configuration is a way to allow an empty username to
   pass when attempting to authenticate using mechanisms like
   Kerberos.  We took an unspecified (NULL) username and sent ":"
   (i.e. no username, no password) to CURLOPT_USERPWD, but did not do
   the same when the username is explicitly set to an empty string.

 * "git clone" of a local repository can be done at the filesystem
   level, but the codepath did not check errors while copying and
   adjusting the file that lists alternate object stores.

 * Documentation for "git commit" was updated to clarify that "commit
   -p <paths>" adds to the current contents of the index to come up
   with what to commit.

 * A stray symbolic link in $GIT_DIR/refs/ directory could make name
   resolution loop forever, which has been corrected.

 * The "submodule.<name>.path" stored in .gitmodules is never copied
   to .git/config and such a key in .git/config has no meaning, but
   the documentation described it and submodule.<name>.url next to
   each other as if both belong to .git/config.  This has been fixed.

 * Recent git allows submodule.<name>.branch to use a special token
   "." instead of the branch name; the documentation has been updated
   to describe it.

 * In a worktree connected to a repository elsewhere, created via "git
   worktree", "git checkout" attempts to protect users from confusion
   by refusing to check out a branch that is already checked out in
   another worktree.  However, this also prevented checking out a
   branch, which is designated as the primary branch of a bare
   reopsitory, in a worktree that is connected to the bare
   repository.  The check has been corrected to allow it.

 * "git rebase" immediately after "git clone" failed to find the fork
   point from the upstream.

 * When fetching from a remote that has many tags that are irrelevant
   to branches we are following, we used to waste way too many cycles
   when checking if the object pointed at by a tag (that we are not
   going to fetch!) exists in our repository too carefully.

 * The Travis CI configuration we ship ran the tests with --verbose
   option but this risks non-TAP output that happens to be "ok" to be
   misinterpreted as TAP signalling a test that passed.  This resulted
   in unnecessary failure.  This has been corrected by introducing a
   new mode to run our tests in the test harness to send the verbose
   output separately to the log file.

 * Some AsciiDoc formatter mishandles a displayed illustration with
   tabs in it.  Adjust a few of them in merge-base documentation to
   work around them.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.10.1 are as follows:

Anders Kaseorg (1):
      imap-send: Tell cURL to use imap:// or imaps://

Brandon Williams (1):
      submodules doc: update documentation for "." used for submodule bra=
nches

David Turner (2):
      add David Turner's Two Sigma address
      http: http.emptyauth should allow empty (not just NULL) usernames

Dennis Kaarsemaker (1):
      worktree: allow the main brach of a bare repository to be checked o=
ut

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jakub Nar=C4=99bski (1):
      configure.ac: improve description of NO_REGEX test

Jeff King (11):
      verify_packfile: check pack validity before accessing data
      graph: fix extra spaces in graph_padding_line
      clone: detect errors in normalize_path_copy
      files_read_raw_ref: avoid infinite loop on broken symlinks
      files_read_raw_ref: prevent infinite retry loops in general
      merge-base: handle --fork-point without reflog
      fetch: use "quick" has_sha1_file for tag following
      test-lib: handle TEST_OUTPUT_DIRECTORY with spaces
      test-lib: add --verbose-log option
      travis: use --verbose-log test option
      test-lib: bail out when "-v" used under "prove"

Johannes Schindelin (1):
      reset: fix usage

Jonathan Tan (1):
      fetch-pack: do not reset in_vain on non-novel acks

Junio C Hamano (9):
      streaming: make sure to notice corrupt object
      unpack_sha1_header(): detect malformed object header
      worktree: honor configuration variables
      blame: use DEFAULT_ABBREV macro
      diff_unique_abbrev(): document its assumption and limitation
      Start preparing for 2.10.2
      cocci: refactor common patterns to use xstrdup_or_null()
      t3700: fix broken test under !SANITY
      Git 2.10.2

Kevin Daudt (2):
      t5100-mailinfo: replace common path prefix with variable
      mailinfo: unescape quoted-pair in header fields

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      git-commit.txt: clarify --patch mode with pathspec

Philip Oakley (2):
      doc: fix merge-base ASCII art tab spacing
      doc: fix the 'revert a faulty merge' ASCII art tab spacing

Pranit Bauva (2):
      rev-list-options: clarify the usage of --reverse
      t0040: convert all possible tests to use `test-parse-options --expe=
ct`

Ralf Thielow (2):
      l10n: de.po: fix translation of autostash
      l10n: de.po: translate 260 new messages

Ren=C3=A9 Scharfe (17):
      contrib/coccinelle: fix semantic patch for oid_to_hex_r()
      add coccicheck make target
      use strbuf_addstr() for adding constant strings to a strbuf, part 2
      pretty: let %C(auto) reset all attributes
      add COPY_ARRAY
      use COPY_ARRAY
      git-gui: stop using deprecated merge syntax
      gitignore: ignore output files of coccicheck make target
      use strbuf_addstr() instead of strbuf_addf() with "%s", part 2
      use strbuf_add_unique_abbrev() for adding short hashes, part 2
      pretty: avoid adding reset for %C(auto) if output is empty
      coccicheck: make transformation for strbuf_addf(sb, "...") more pre=
cise
      remove unnecessary NULL check before free(3)
      use strbuf_add_unique_abbrev() for adding short hashes, part 3
      pretty: fix document link for color specification
      avoid pointer arithmetic involving NULL in FLEX_ALLOC_MEM
      inline xalloc_flex() into FLEXPTR_ALLOC_MEM

SZEDER G=C3=A1bor (1):
      ref-filter: strip format option after a field name only once while =
parsing

Stefan Beller (1):
      documentation: improve submodule.<name>.{url, path} description

Younes Khoudli (1):
      doc: remove reference to the traditional layout in git-tag.txt

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 (1):
      ./configure.ac: detect SSL in libcurl using curl-config

