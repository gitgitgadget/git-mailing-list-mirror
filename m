From: Junio C Hamano <gitster@pobox.com>
Subject: GIT 1.6.5-rc1
Date: Sun, 13 Sep 2009 03:14:12 -0700
Message-ID: <7vws43up6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 12:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmm6B-00059Z-RS
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 12:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbZIMKOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 06:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbZIMKOO
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 06:14:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZIMKON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 06:14:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E97974F74B;
	Sun, 13 Sep 2009 06:14:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=o1AY
	Mnen9fgMjGaXELVGeEJt9m0=; b=gVnWQMCLV3Z0X0JJB9OEhZPawVDjlm50W3LE
	/j7pqvzdhvadDj8NA00cNo2sQ//+7YPy/J/4t7QkjUBf/7koVLL7MO850e0gkkC0
	LeG4bVtuKPAeqUSpDDfRcVwYIdLK4h1NkifG/JsJ4ZfSvYXYD7EqSFi6gCj2zvOV
	7Kgi2PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=euN
	uM9MwwkvIifVcqQ4Q9Ai9bQombtleG17/Al1162Sb/mGHvgdR8rGsYYzmxukwll/
	6ZaB4M9ToYWXY6yuTRit/Y0f4n4e0PFVHNEXpB6YWTj1+UyClLQxkX2C7GxJicU0
	XdoZ+kPiisEo1vl5RHdtSK4mNthdRru70cj62Gls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9F364F74A;
	Sun, 13 Sep 2009 06:14:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D526A4F749; Sun, 13 Sep 2009
 06:14:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 310BE690-A04E-11DE-A831-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128351>

I've tagged 1.6.5-rc1.  Here is how the draft release notes for it looks
like.

Please switch to regression-hunting and bug-fixing mode now ;-)

GIT v1.6.5 Release Notes (draft)
================================

In git 1.7.0, which was planned to be the release after 1.6.5, "git
push" into a branch that is currently checked out will be refused by
default.

You can choose what should happen upon such a push by setting the
configuration variable receive.denyCurrentBranch in the receiving
repository.

Also, "git push $there :$killed" to delete the branch $killed in a remote
repository $there, when $killed branch is the current branch pointed at by
its HEAD, will be refused by default.

You can choose what should happen upon such a push by setting the
configuration variable receive.denyDeleteCurrent in the receiving
repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://git.or.cz/gitwiki/GitFaq#non-bare
  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

for more details on the reason why this change is needed and the
transition plan.

Updates since v1.6.4
--------------------

(subsystems)

 * various updates to git-svn and gitweb.

(portability)

 * more improvements on mingw port.

 * mingw will also give FRSX as the default value for the LESS
   environment variable when the user does not have one.

(performance)

 * On major platforms, the system can be compiled to use with Linus's
   block-sha1 implementation of the SHA-1 hash algorithm, which
   outperforms the default fallback implementation we borrowed from
   Mozzilla.

 * Unnecessary inefficiency in deepening of a shallow repository has
   been removed.

 * The "git" main binary used to link with libcurl, which then dragged
   in a large number of external libraries.  When using basic plumbing
   commands in scripts, this unnecessarily slowed things down.  We now
   implement http/https/ftp transfer as a separate executable as we
   used to.

 * "git clone" run locally hardlinks or copies the files in .git/ to
   newly created repository.  It used to give new mtime to copied files,
   but this delayed garbage collection to trigger unnecessarily in the
   cloned repository.  We now preserve mtime for these files to avoid
   this issue.

(usability, bells and whistles)

 * Human writable date format to various options, e.g. --since=yesterday,
   master@{2000.09.17}, are taught to infer some omitted input properly.

 * A few programs gave verbose "advice" messages to help uninitiated
   people when issuing error messages.  An infrastructure to allow
   users to squelch them has been introduced, and a few such messages
   can be silenced now.

 * refs/replace/ hierarchy is designed to be usable as a replacement
   of the "grafts" mechanism, with the added advantage that it can be
   transferred across repositories.

 * "git am" learned to optionally ignore whitespace differences.

 * "git am" handles input e-mail files that has CRLF line endings sensibly.

 * "git am" learned "--scissors" option to allow you to discard early part
   of an incoming e-mail.

 * "git checkout", "git reset" and "git stash" learned to pick and
   choose to use selected changes you made, similar to "git add -p".

 * "git clone" learned a "-b" option to pick a HEAD to check out
   different from the remote's default branch.

 * "git commit --dry-run $args" is a new recommended way to ask "what would
   happen if I try to commit with these arguments."

 * "git commit --dry-run" and "git status" shows conflicted paths in a
   separate section to make them easier to spot during a merge.

 * "git cvsimport" now supports password-protected pserver access even
   when the password is not taken from ~/.cvspass file.

 * "git fast-export" learned --no-data option that can be useful when
   reordering commits and trees without touching the contents of
   blobs.

 * "git fast-import" has a pair of new front-end in contrib/ area.

 * "git init" learned to mkdir/chdir into a directory when given an
   extra argument (i.e. "git init this").

 * "git instaweb" optionally can use mongoose as the web server.

 * "git log --decorate" can optionally be told with --decorate=full to
   give the reference name in full.

 * "git merge" issued an unnecessarily scary message when it detected
   that the merge may have to touch the path that the user has local
   uncommitted changes to. The message has been reworded to make it
   clear that the command aborted, without doing any harm.

 * "git push" can be told to be --quiet.

 * "git push" pays attention to url.$base.pushInsteadOf and uses a URL
   that is derived from the URL used for fetching.

 * informational output from "git reset" that lists the locally modified
   paths is made consistent with that of "git checkout $another_branch".

 * "git submodule" learned to give submodule name to scripts run with
   "foreach" subcommand.

 * various subcommands to "git submodule" learned --recursive option.

 * "git submodule summary" learned --files option to compare the work
   tree vs the commit bound at submodule path, instead of comparing
   the index.

 * "git upload-pack", which is the server side support for "git clone" and
   "git fetch", can call a new post-upload-pack hook for statistics purposes.

(developers)

 * With GIT_TEST_OPTS="--root=/p/a/t/h", tests can be run outside the
   source directory; using tmpfs may give faster turnaround.
