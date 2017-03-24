Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5F41FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 21:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966793AbdCXVTq (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 17:19:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55375 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966637AbdCXVTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 17:19:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF58A77FF5;
        Fri, 24 Mar 2017 17:19:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=/YuaoD8KUyu1P7/2YgYunLALl
        60=; b=GBdB6bIyrde8nwJOFYFxer1BblS9fkzMZO7nFf95Zw+hC4U891rx39bEf
        0qDTB6MULCJNvqR16yhTGrVdbCcSsuMbY1xVXHpmlPA95sDDWwv4CGvT8vUO5jrd
        vwePbstCR0icoxLGRuzOUvxPPYV7wRqZoQgYy2tC4Whsw5nBJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=d/ur0hE59xTEtFDY442
        khFVkKbTLZjXF8Te1Fmf+EYrwM+0KMASbxUUV74dgdMb61nPmNiCP/TZeugjoqnH
        cLdtM0BF4z0LVj7QcgsxBNiAfN45+Z8tsR57W0v/B7vVQTJicOh7mrAd69JQRfOp
        qIi1LjRTzirwaYqmFM3i9E1k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6D8D77FF4;
        Fri, 24 Mar 2017 17:19:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3085C77FF2;
        Fri, 24 Mar 2017 17:19:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.12.2
Date:   Fri, 24 Mar 2017 14:19:39 -0700
Message-ID: <xmqqa88a74pg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97FE5CD2-10D7-11E7-98D9-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.12.2 is now available at the
usual places.  These fixes have all been in the 'master' branch to
be included in the next feature release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.12.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.12.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.12.1
-------------------

 * "git status --porcelain" is supposed to give a stable output, but a
   few strings were left as translatable by mistake.

 * "Dumb http" transport used to misparse a nonsense http-alternates
   response, which has been fixed.

 * "git diff --quiet" relies on the size field in diff_filespec to be
   correctly populated, but diff_populate_filespec() helper function
   made an incorrect short-cut when asked only to populate the size
   field for paths that need to go through convert_to_git() (e.g. CRLF
   conversion).

 * There is no need for Python only to give a few messages to the
   standard error stream, but we somehow did.

 * A leak in a codepath to read from a packed object in (rare) cases
   has been plugged.

 * "git upload-pack", which is a counter-part of "git fetch", did not
   report a request for a ref that was not advertised as invalid.
   This is generally not a problem (because "git fetch" will stop
   before making such a request), but is the right thing to do.

 * A "gc.log" file left by a backgrounded "gc --auto" disables further
   automatic gc; it has been taught to run at least once a day (by
   default) by ignoring a stale "gc.log" file that is too old.

 * "git remote rm X", when a branch has remote X configured as the
   value of its branch.*.remote, tried to remove branch.*.remote and
   branch.*.merge and failed if either is unset.

 * A caller of tempfile API that uses stdio interface to write to
   files may ignore errors while writing, which is detected when
   tempfile is closed (with a call to ferror()).  By that time, the
   original errno that may have told us what went wrong is likely to
   be long gone and was overwritten by an irrelevant value.
   close_tempfile() now resets errno to EIO to make errno at least
   predictable.

 * "git show-branch" expected there were only very short branch names
   in the repository and used a fixed-length buffer to hold them
   without checking for overflow.

 * The code that parses header fields in the commit object has been
   updated for (micro)performance and code hygiene.

 * A test that creates a confusing branch whose name is HEAD has been
   corrected not to do so.

 * "Cc:" on the trailer part does not have to conform to RFC strictly,
   unlike in the e-mail header.  "git send-email" has been updated to
   ignore anything after '>' when picking addresses, to allow non-address
   cruft like " # stable 4.4" after the address.

 * "git push" had a handful of codepaths that could lead to a deadlock
   when unexpected error happened, which has been fixed.

 * Code to read submodule.<name>.ignore config did not state the
   variable name correctly when giving an error message diagnosing
   misconfiguration.

 * "git ls-remote" and "git archive --remote" are designed to work
   without being in a directory under Git's control.  However, recent
   updates revealed that we randomly look into a directory called
   .git/ without actually doing necessary set-up when working in a
   repository.  Stop doing so.

 * The code to parse the command line "git grep <patterns>... <rev>
   [[--] <pathspec>...]" has been cleaned up, and a handful of bugs
   have been fixed (e.g. we used to check "--" if it is a rev).

 * The code to parse "git -c VAR=3DVAL cmd" and set configuration
   variable for the duration of cmd had two small bugs, which have
   been fixed.
   This supersedes jc/config-case-cmdline topic that has been discarded.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.12.1 are as follows:

David Turner (1):
      gc: ignore old gc.log files

Eric Wong (1):
      README: create HTTP/HTTPS links from URLs in Markdown

Jeff King (20):
      grep: move thread initialization a little lower
      grep: re-order rev-parsing loop
      grep: fix "--" rev/pathspec disambiguation
      grep: avoid resolving revision names in --no-index case
      grep: do not diagnose misspelt revs with --no-index
      show-branch: drop head_len variable
      show-branch: store resolved head in heap buffer
      remote: avoid reading $GIT_DIR config in non-repo
      grep: treat revs the same for --untracked as for --no-index
      show-branch: use skip_prefix to drop magic numbers
      tempfile: set errno to a known value before calling ferror()
      t6300: avoid creating refs/heads/HEAD
      ewah: fix eword_t/uint64_t confusion
      receive-pack: fix deadlock when we cannot create tmpdir
      send-pack: extract parsing of "unpack" response
      send-pack: use skip_prefix for parsing unpack status
      send-pack: improve unpack-status error messages
      send-pack: read "unpack" status even on pack-objects failure
      send-pack: report signal death of pack-objects
      http-walker: fix buffer underflow processing remote alternates

Johan Hovold (1):
      send-email: only allow one address per body tag

Jonathan Nieder (1):
      remote helpers: avoid blind fall-back to ".git" when setting GIT_DI=
R

Jonathan Tan (2):
      grep: do not unnecessarily query repo for "--"
      upload-pack: report "not our ref" to client

Junio C Hamano (5):
      config: move a few helper functions up
      config: use git_config_parse_key() in git_config_parse_parameter()
      diff: do not short-cut CHECK_SIZE_ONLY check in diff_populate_files=
pec()
      Prepare for 2.12.2
      Git 2.12.2

Michael J Gruber (2):
      git-status: make porcelain more robust
      mailmap: use Michael J Gruber's new address

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      git-commit.txt: list post-rewrite in HOOKS section

Patrick Steinhardt (2):
      docs/diffcore: fix grammar in diffcore-rename header
      docs/diffcore: unquote "Complete Rewrites" in headers

Ramsay Jones (2):
      wrapper.c: remove unused git_mkstemp() function
      wrapper.c: remove unused gitmkstemps() function

Ren=C3=A9 Scharfe (3):
      sha1_file: release fallback base's memory in unpack_entry()
      commit: be more precise when searching for headers
      commit: don't check for space twice when looking for header

Ross Lagerwall (1):
      remote: ignore failure to remove missing branch.<name>.merge

Sebastian Schuberth (1):
      contrib: git-remote-{bzr,hg} placeholders don't need Python

Stefan Beller (1):
      submodule-config: correct error reporting for invalid ignore value

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
      doc: change erroneous --[no]-whatever into --[no-]whatever
      push: mention "push.default=3Dtracking" in the documentation

