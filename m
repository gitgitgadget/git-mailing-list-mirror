Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87B2C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3E764E8F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBHXuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:50:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58616 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBHXuO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:50:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBA8311DB38;
        Mon,  8 Feb 2021 18:49:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=yRv0ErEW2TlC7+onQTOXnUk0g
        y0=; b=asiJaGNkkRRMBxitGWCwwgShzDDy6AQiMQP/AJkY2fae/OTW+cfSho4+2
        t0lAotrYFkvAt8Idj9KjtK3/oz1BG117SAG6rsEFRajTEH6/8uz2aKc5ipmhmSw1
        QyuRMff/oUJZ4+GsLilKmwjIRPCEzq4Gth67m2LVzrnpVtKXXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=gdpfkOwPYhOZgZtrmkc
        9K/evxzRJDzszQ2RZhIHl7lB6YSeVoar08s36hViEnXgUalZRkYjXRjUxd9ERcF+
        OaDOKum8kPg2+j91Dad8MHaoQKlX1qABVnQNAXc+n+q9cY3k4+m8DZWL/9Mi35Yk
        WbNid3MXjRQ+0UBtu+utf72Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0CC711DB37;
        Mon,  8 Feb 2021 18:49:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9E9911DB36;
        Mon,  8 Feb 2021 18:49:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.30.1
Date:   Mon, 08 Feb 2021 15:49:26 -0800
Message-ID: <xmqqsg662k8p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47D30840-6A68-11EB-B155-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.30.1 is now available at the
usual places.  This is to propagate obvious fixes that have
accumulated on the 'master' front down to the 2.30.x series.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.30.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.30.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This release is primarily to merge fixes accumulated on the 'master'
front to prepare for 2.31 release that are still relevant to 2.30.x
maintenance track.

Fixes since v2.30
-----------------

 * "git fetch --recurse-submodules" failed to update a submodule
   when it has an uninitialized (hence of no interest to the user)
   sub-submodule, which has been corrected.

 * Command line error of "git rebase" are diagnosed earlier.

 * "git stash" did not work well in a sparsely checked out working
   tree.

 * Some tests expect that "ls -l" output has either '-' or 'x' for
   group executable bit, but setgid bit can be inherited from parent
   directory and make these fields 'S' or 's' instead, causing test
   failures.

 * "git for-each-repo --config=3D<var> <cmd>" should not run <cmd> for
   any repository when the configuration variable <var> is not defined
   even once.

 * "git mergetool --tool-help" was broken in 2.29 and failed to list
   all the available tools.

 * Fix for procedure to building CI test environment for mac.

 * Newline characters in the host and path part of git:// URL are
   now forbidden.

 * When more than one commit with the same patch ID appears on one
   side, "git log --cherry-pick A...B" did not exclude them all when a
   commit with the same patch ID appears on the other side.  Now it
   does.

 * Documentation for "git fsck" lost stale bits that has become
   incorrect.

 * Doc for packfile URI feature has been clarified.

 * The implementation of "git branch --sort" wrt the detached HEAD
   display has always been hacky, which has been cleaned up.

 * Our setting of GitHub CI test jobs were a bit too eager to give up
   once there is even one failure found.  Tweak the knob to allow
   other jobs keep running even when we see a failure, so that we can
   find more failures in a single run.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.30.0 are as follows:

Adam Dinwoodie (1):
      t4129: fix setfacl-related permissions failure

Antonio Russo (1):
      t6016: move to lib-log-graph.sh framework

Daniel Levin (1):
      git-p4: fix syncing file types with pattern

Derrick Stolee (1):
      for-each-repo: do nothing on empty config

Elijah Newren (3):
      t7012: add a testcase demonstrating stash apply bugs in sparse chec=
kouts
      stash: remove unnecessary process forking
      stash: fix stash application in sparse-checkouts

Felipe Contreras (1):
      test: bisect-porcelain: fix location of files

Jeff King (5):
      git_connect_git(): forbid newlines in host and path
      fsck: reject .gitmodules git:// urls with newlines
      t5516: loosen "not our ref" error check
      patch-ids: handle duplicate hashmap entries
      p5303: avoid sed GNU-ism

Johannes Schindelin (1):
      SKIP_DASHED_BUILT_INS: respect `config.mak`

Johannes Sixt (1):
      annotate-tests: quote variable expansions containing path names

Jonathan Tan (1):
      Doc: clarify contents of packfile sent as URI

Junio C Hamano (5):
      parse-options: format argh like error messages
      SubmittingPatches: tighten wording on "sign-off" procedure
      ci/install-depends: attempt to fix "brew cask" stuff
      Prepare for 2.30.1
      Git 2.30.1

Martin =C3=85gren (9):
      t1300: remove duplicate test for `--file ../foo`
      t1300: remove duplicate test for `--file no-such-file`
      t1300: don't needlessly work with `core.foo` configs
      pack-format.txt: document sizes at start of delta data
      builtin/gc: don't peek into `struct lock_file`
      commit-graph: don't peek into `struct lock_file`
      midx: don't peek into `struct lock_file`
      refs/files-backend: don't peek into `struct lock_file`
      read-cache: try not to peek into `struct {lock_,temp}file`

Matheus Tavares (1):
      t4129: don't fail if setgid is set in the test directory

Peter Kaestle (1):
      submodules: fix of regression on fetching of non-init subsub-repo

Philippe Blain (3):
      gitmodules.txt: fix 'GIT_WORK_TREE' variable name
      mergetool--lib: fix '--tool-help' to correctly show available tools
      ci: do not cancel all jobs of a matrix if one fails

Ren=C3=A9 Scharfe (1):
      rebase: verify commit parameter

Taylor Blau (2):
      p7519: allow running without watchman prereq
      Documentation/git-clone.txt: document race with --local

Thomas Ackermann (1):
      doc: fix some typos

Utku Gultopu (1):
      doc: remove "directory cache" from man pages

Vasyl Vavrychuk (1):
      git-send-email.txt: mention less secure app access with Gmail

ZheNing Hu (1):
      builtin/*: update usage format

brian m. carlson (1):
      docs: rephrase and clarify the git status --short format

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (10):
      branch: change "--local" to "--list" in comment
      branch tests: add to --sort tests
      ref-filter: add braces to if/else if/else chain
      ref-filter: move "cmp_fn" assignment into "else if" arm
      ref-filter: move ref_sorting flags to a bitfield
      branch: sort detached HEAD based on a flag
      branch: show "HEAD detached" first under reverse sort
      Makefile: remove a warning about old GETTEXT_POISON flag
      gettext.c: remove/reword a mostly-useless comment
      fsck doc: remove ancient out-of-date diagnostics

