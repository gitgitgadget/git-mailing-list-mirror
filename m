Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CC4414;
	Sat, 14 Sep 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332771; cv=none; b=VdGgIKiwP/PCFtDYjDrpiRl/ujFkl+5I8bwexZUD38bvs/Y/jZ5W5/AI3dzBkuwwpRUwAAfMdv/yISpDnuvNneX/uOY1XklPaEmbmQZtItbyU3noxvzjhZyYYIMMvIj0WDtKrmf0JmC/tGe+jXUGEmSQGePys59l9V7KO6CEzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332771; c=relaxed/simple;
	bh=tSG+XY2sGKjKGN6iesrYRJsN0vG1g5whv6Dh1Gd6hjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlIoyX4Ng0M0PS732zJhOAyxJGORsGELXMx6u7X29Kn/ZqlYQNuZfgAgC9vsGXkgVUdvooYYMdHAQsVj5uIPwcRleWEd9/O2t2fe9PZu8UPsBVIxja1opVe/X2BuYSxdDAgWTazYeAKU1l3SNIJt1UkLbWI+3uA0r35MbilrBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tN2agZOC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tN2agZOC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40E3D31739;
	Sat, 14 Sep 2024 12:52:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=tSG+XY2sGKjKGN6iesrYRJsN0
	vG1g5whv6Dh1Gd6hjM=; b=tN2agZOC6NcBijnJU2sf9zX7beYIt8n7RWR2sEwVd
	VQdEWCtk6EYDnBFkizBVlR71fdYkgzKhBxuM91h14RtQi+IUMO3Vf5VNlvfYUy1z
	j0QAFKOpSShQMy71I+ejxB29dTT+K0cN2woI8gSlKSxSKJPnJ13TswP1NwnF3Goc
	F0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3999431738;
	Sat, 14 Sep 2024 12:52:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F95831737;
	Sat, 14 Sep 2024 12:52:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.46.1
Date: Sat, 14 Sep 2024 09:52:46 -0700
Message-ID: <xmqqikuytbxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C5513EA6-72B9-11EF-A162-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The latest maintenance release Git v2.46.1 is now available at the
usual places.  Unlike maintenance releases in the recent past, this
one is _not_ about security fixes, but primarily about fixes to
various commands that can work outside a repository barfing due to
lack of initialization of the hash function.  IOW, it is not the end
of the world if you did not update to this version for a few weeks,
or wait for 2.47 ;-).

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.46.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.46.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This release is primarily to merge fixes accumulated on the 'master'
front to prepare for 2.47 release that are still relevant to 2.46.x
maintenance track.

Fixes since Git 2.46
--------------------

 * "git checkout --ours" (no other arguments) complained that the
   option is incompatible with branch switching, which is technically
   correct, but found confusing by some users.  It now says that the
   user needs to give pathspec to specify what paths to checkout.

 * It has been documented that we avoid "VAR=3DVAL shell_func" and why.

 * "git add -p" by users with diff.suppressBlankEmpty set to true
   failed to parse the patch that represents an unmodified empty line
   with an empty line (not a line with a single space on it), which
   has been corrected.

 * "git rebase --help" referred to "offset" (the difference between
   the location a change was taken from and the change gets replaced)
   incorrectly and called it "fuzz", which has been corrected.

 * "git notes add -m '' --allow-empty" and friends that take prepared
   data to create notes should not invoke an editor, but it started
   doing so since Git 2.42, which has been corrected.

 * An expensive operation to prepare tracing was done in re-encoding
   code path even when the tracing was not requested, which has been
   corrected.

 * Perforce tests have been updated.

 * The credential helper to talk to OSX keychain sometimes sent
   garbage bytes after the username, which has been corrected.

 * A recent update broke "git ls-remote" used outside a repository,
   which has been corrected.

 * "git config --value=3Dfoo --fixed-value section.key newvalue" barfed
   when the existing value in the configuration file used the
   valueless true syntax, which has been corrected.

 * "git reflog expire" failed to honor annotated tags when computing
   reachable commits.

 * A flakey test and incorrect calls to strtoX() functions have been
   fixed.

 * Follow-up on 2.45.1 regression fix.

 * "git rev-list ... | git diff-tree -p --remerge-diff --stdin" should
   behave more or less like "git log -p --remerge-diff" but instead it
   crashed, forgetting to prepare a temporary object store needed.

 * The patch parser in "git patch-id" has been tightened to avoid
   getting confused by lines that look like a patch header in the log
   message.

 * "git bundle unbundle" outside a repository triggered a BUG()
   unnecessarily, which has been corrected.

 * The code forgot to discard unnecessary in-core commit buffer data
   for commits that "git log --skip=3D<number>" traversed but omitted
   from the output, which has been corrected.

 * "git verify-pack" and "git index-pack" started dying outside a
   repository, which has been corrected.

 * A corner case bug in "git stash" was fixed.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.46.0 are as follows:

Celeste Liu (1):
      doc: replace 3 dash with correct 2 dash in git-config(1)

D Harithamma (1):
      convert: return early when not tracing

David Disseldorp (1):
      notes: do not trigger editor when adding an empty note

Jayson Rhynas (1):
      doc: fix hex code escapes in git-ls-files

Jeff King (4):
      credential/osxkeychain: respect NUL terminator in username
      apply: canonicalize modes read from patches
      t4129: fix racy index when calling chmod after git-add
      revision: free commit buffers for skipped commits

Johannes Schindelin (2):
      ci: bump microsoft/setup-msbuild from v1 to v2
      ci(win+VS): download the vcpkg artifacts using a dedicated GitHub A=
ction

Junio C Hamano (30):
      checkout: special case error messages during noop switching
      doc: note that AT&T ksh does not work with our test suite
      Revert "reflog expire: don't use lookup_commit_reference_gently()"
      howto-maintain: cover a whole development cycle
      howto-maintain: update daily tasks
      CodingGuidelines: document a shell that "fails" "VAR=3DVAL shell_fu=
nc"
      doc: difference in location to apply is "offset", not "fuzz"
      mailmap: plug memory leak in read_mailmap_blob()
      csum-file: introduce discard_hashfile()
      t4204: patch-id supports various input format
      patch-id: call flush_current_id() only when needed
      patch-id: make get_one_patchid() more extensible
      patch-id: rewrite code that detects the beginning of a patch
      patch-id: tighten code to detect the patch header
      safe.directory: preliminary clean-up
      safe.directory: normalize the checked path
      safe.directory: normalize the configured path
      safe.directory: setting safe.directory=3D"." allows the "current" d=
irectory
      t0018: remove leftover debugging cruft
      tests: drop use of 'tee' that hides exit status
      tutorial: grammofix
      doc: grammofix in git-diff-tree
      howto-maintain: mention preformatted docs
      Prepare for 2.46.1
      CodingGuidelines: spaces around C operators
      A bit more topics for 2.46.x maintenance track
      git-config.1: --get-all description update
      git-config.1: fix description of --regexp in synopsis
      Another batch of topics for 2.46.1
      Git 2.46.1

Justin Tobler (1):
      doc: clarify post-receive hook behavior

Kousik Sanagavarapu (1):
      unit-tests/test-lib: fix typo in check_pointer_eq() description

Kyle Lippincott (2):
      set errno=3D0 before strtoX calls
      t6421: fix test to work when repo dir contains d0

Patrick Steinhardt (8):
      t98xx: fix Perforce tests with p4d r23 and newer
      ci: update Perforce version to r23.2
      t98xx: mark Perforce tests as memory-leak free
      builtin/ls-remote: fall back to SHA1 outside of a repo
      builtin/bundle: have unbundle check for repo before opening its bun=
dle
      bundle: default to SHA1 when reading bundle headers
      builtin/stash: fix `--keep-index --include-untracked` with empty HE=
AD
      builtin/index-pack: fix segfaults when running outside of a repo

Phillip Wood (2):
      add-patch: handle splitting hunks with diff.suppressBlankEmpty
      add-patch: use normalize_marker() when recounting edited hunk

Ramsay Jones (1):
      compat/terminal: mark parameter of git_terminal_prompt() UNUSED

Ren=C3=A9 Scharfe (2):
      t-example-decorate: remove test messages
      log-tree: use decimal_width()

Sven Strickroth (1):
      refs/files: prevent memory leak by freeing packed_ref_store

Taylor Blau (1):
      config.c: avoid segfault with --fixed-value and valueless config

Tomas Nordin (1):
      doc: remove dangling closing parenthesis

Xing Xin (1):
      diff-tree: fix crash when used with --remerge-diff

ahmed akef (1):
      docs: explain the order of output in the batched mode of git-cat-fi=
le(1)

