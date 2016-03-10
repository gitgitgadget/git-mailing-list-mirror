From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.7.3
Date: Thu, 10 Mar 2016 15:04:40 -0800
Message-ID: <xmqqy49qaq9j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Mar 11 00:05:07 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ae9df-0005cP-Hr
	for glk-linux-kernel-3@plane.gmane.org; Fri, 11 Mar 2016 00:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbcCJXEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 Mar 2016 18:04:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752645AbcCJXEo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2016 18:04:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5293C4C31E;
	Thu, 10 Mar 2016 18:04:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=PS3lTdKi5gxvGUdsT3FFGzL1c
	Jc=; b=q7zddpJUJq0EGLN2GSvq2XfSw8YZqM52Rpq+4P1Ntvp2fYNlZ9XGS4Kuj
	8WCgVF2Ao9SNxSCGYEZIqpM84poHyEL8pyYQKcuf7KYt6OpYOnChD0gT8TZhH26R
	cbJty6W7h7FJefSAnPukWNWFZwLWrSCQId4yy99zJHkYQhmAB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=hxz4QmLc9jGHx1PbeWD
	/u29cqRMMwS69ehFjAbYR2eBdNjM4UZjXkwgt4UG6UyueVjgkjRBF6OUVjtjWRI0
	JM3lEVvi32kNdlOS1uuzbd1xLTfAI29yNG75ljL79gnjZefjeI9UuYkmF/tXg0jb
	YUIv1Kz1t9ZbZs7z4P52A7D8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49CF14C31D;
	Thu, 10 Mar 2016 18:04:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F2F44C31A;
	Thu, 10 Mar 2016 18:04:41 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78CBD4B8-E714-11E5-A333-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288660>

The latest maintenance release Git v2.7.3 is now available at
the usual places.  This is primarily to sync the maintenance track
with miscellaneous fixes that are scheduled to be part of upcoming
v2.8.0 release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.7.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.7.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.7.2
------------------

 * Traditionally, the tests that try commands that work on the
   contents in the working tree were named with "worktree" in their
   filenames, but with the recent addition of "git worktree"
   subcommand, whose tests are also named similarly, it has become
   harder to tell them apart.  The traditional tests have been renamed
   to use "work-tree" instead in an attempt to differentiate them.

 * Many codepaths forget to check return value from git_config_set();
   the function is made to die() to make sure we do not proceed when
   setting a configuration variable failed.

 * Handling of errors while writing into our internal asynchronous
   process has been made more robust, which reduces flakiness in our
   tests.

 * "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
   rev, i.e. the object named by the the pathname with wildcard
   characters in a tree object.

 * "git rev-parse --git-common-dir" used in the worktree feature
   misbehaved when run from a subdirectory.

 * The "v(iew)" subcommand of the interactive "git am -i" command was
   broken in 2.6.0 timeframe when the command was rewritten in C.

 * "git merge-tree" used to mishandle "both sides added" conflict with
   its own "create a fake ancestor file that has the common parts of
   what both sides have added and do a 3-way merge" logic; this has
   been updated to use the usual "3-way merge with an empty blob as
   the fake common ancestor file" approach used in the rest of the
   system.

 * The memory ownership rule of fill_textconv() API, which was a bit
   tricky, has been documented a bit better.

 * The documentation did not clearly state that the 'simple' mode is
   now the default for "git push" when push.default configuration is
   not set.

 * Recent versions of GNU grep are pickier when their input contains
   arbitrary binary data, which some of our tests uses.  Rewrite the
   tests to sidestep the problem.

 * A helper function "git submodule" uses since v2.7.0 to list the
   modules that match the pathspec argument given to its subcommands
   (e.g. "submodule add <repo> <path>") has been fixed.

 * "git config section.var value" to set a value in per-repository
   configuration file failed when it was run outside any repository,
   but didn't say the reason correctly.

 * The code to read the pack data using the offsets stored in the pack
   idx file has been made more carefully check the validity of the
   data in the idx.

Also includes documentation and test updates.

----------------------------------------------------------------

Changes since v2.7.2 are as follows:

Alexander Kuleshov (2):
      exec_cmd.c: use find_last_dir_sep() for code simplification
      git.c: simplify stripping extension of a file in handle_builtin()

David Turner (1):
      refs: document transaction semantics

Jeff King (37):
      checkout: reorder check_filename conditional
      check_filename: tighten dwim-wildcard ambiguity
      get_sha1: don't die() on bogus search strings
      reflog_expire_cfg: NUL-terminate pattern field
      add helpers for detecting size_t overflow
      tree-diff: catch integer overflow in combine_diff_path allocation
      diff: clarify textconv interface
      harden REALLOC_ARRAY and xcalloc against size_t overflow
      add helpers for allocating flex-array structs
      argv-array: add detach function
      convert manual allocations to argv_array
      convert trivial cases to ALLOC_ARRAY
      use xmallocz to avoid size arithmetic
      convert trivial cases to FLEX_ARRAY macros
      use st_add and st_mult for allocation size computation
      prepare_{git,shell}_cmd: use argv_array
      write_untracked_extension: use FLEX_ALLOC helper
      fast-import: simplify allocation in start_packfile
      fetch-pack: simplify add_sought_entry
      test-path-utils: fix normalize_path_copy output buffer size
      sequencer: simplify memory allocation of get_message
      git-compat-util: drop mempcpy compat code
      transport_anonymize_url: use xstrfmt
      diff_populate_gitlink: use a strbuf
      convert ewah/bitmap code to use xmalloc
      ewah: convert to REALLOC_ARRAY, etc
      merge-one-file: use empty blob for add/add base
      merge-tree: drop generate_common strategy
      xdiff: drop XDL_EMIT_COMMON
      t5313: test bounds-checks of corrupted/malicious pack/idx files
      nth_packed_object_offset: bounds-check extended offset
      use_pack: handle signed off_t overflow
      write_or_die: handle EPIPE in async threads
      fetch-pack: ignore SIGPIPE in sideband demuxer
      test_must_fail: report number of unexpected signal
      t5504: handle expected output from SIGPIPE death
      compat/mingw: brown paper bag fix for 50a6c8e

Johannes Schindelin (1):
      git config: report when trying to modify a non-existing repo conf=
ig

John Keeping (2):
      t8005: avoid grep on non-ASCII data
      t9200: avoid grep on non-ASCII data

Junio C Hamano (4):
      pager: lose a separate argv[]
      pager: factor out a helper to prepare a child process to run the =
pager
      am -i: fix "v"iew
      Git 2.7.3

Martin Amdisen (1):
      templates/hooks: fix minor typo in the sample update-hook

Matthieu Moy (1):
      Documentation/git-push: document that 'simple' is the default

Michael J Gruber (1):
      tests: rename work-tree tests to *work-tree*

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      rev-parse: take prefix into account in --git-common-dir
      sha1_file.c: mark strings for translation

Patrick Steinhardt (16):
      config: introduce set_or_die wrappers
      branch: report errors in tracking branch setup
      branch: die on config error when unsetting upstream
      branch: die on config error when editing branch description
      submodule: die on config error when linking modules
      submodule--helper: die on config error when cloning module
      remote: die on config error when setting URL
      remote: die on config error when setting/adding branches
      remote: die on config error when manipulating remotes
      clone: die on config error in cmd_clone
      init-db: die on config errors when initializing empty repo
      sequencer: die on config error when saving replay opts
      compat: die when unable to set core.precomposeunicode
      config: rename git_config_set to git_config_set_gently
      config: rename git_config_set_or_die to git_config_set
      xdiff/xmerge: fix memory leak in xdl_merge

Shawn O. Pearce (1):
      remote-curl: include curl_errorstr on SSL setup failures

Stefan Beller (1):
      submodule helper list: respect correct path prefix
