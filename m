From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.4
Date: Wed, 29 Jul 2009 01:46:27 -0700
Message-ID: <7vfxcfx4f0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 10:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4oC-0001k2-N7
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbZG2Iqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZG2Iqi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:46:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbZG2Iqe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:46:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7DA2715295;
	Wed, 29 Jul 2009 04:46:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8424515293; Wed, 29 Jul 2009
 04:46:28 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52072E64-7C1C-11DE-8D9F-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124329>

The latest feature release GIT 1.6.4 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.4-1.fc9.$arch.rpm	(RPM)

GIT v1.6.4 Release Notes
========================

With the next major release, "git push" into a branch that is
currently checked out will be refused by default.  You can choose
what should happen upon such a push by setting the configuration
variable receive.denyCurrentBranch in the receiving repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://git.or.cz/gitwiki/GitFaq#non-bare
  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

for more details on the reason why this change is needed and the
transition plan.

For a similar reason, "git push $there :$killed" to delete the branch
$killed in a remote repository $there, if $killed branch is the current
branch pointed at by its HEAD, gets a large warning.  You can choose what
should happen upon such a push by setting the configuration variable
receive.denyDeleteCurrent in the receiving repository.


Updates since v1.6.3
--------------------

(subsystems)

 * gitweb Perl style clean-up.

 * git-svn updates, including a new --authors-prog option to map author
   names by invoking an external program, 'git svn reset' to unwind
   'git svn fetch', support for more than one branches, documenting
   of the useful --minimize-url feature, new "git svn gc" command, etc.

(portability)

 * We feed iconv with "UTF-8" instead of "utf8"; the former is
   understood more widely.  Similarly updated test scripts to use
   encoding names more widely understood (e.g. use "ISO8859-1" instead
   of "ISO-8859-1").

 * Various portability fixes/workarounds for different vintages of
   SunOS, IRIX, and Windows.

 * Git-over-ssh transport on Windows supports PuTTY plink and TortoisePlink.

(performance)

 * Many repeated use of lstat() are optimized out in "checkout" codepath.

 * git-status (and underlying git-diff-index --cached) are optimized
   to take advantage of cache-tree information in the index.

(usability, bells and whistles)

 * "git add --edit" lets users edit the whole patch text to fine-tune what
   is added to the index.

 * "git am" accepts StGIT series file as its input.

 * "git bisect skip" skips to a more randomly chosen place in the hope
   to avoid testing a commit that is too close to a commit that is
   already known to be untestable.

 * "git cvsexportcommit" learned -k option to stop CVS keywords expansion

 * "git fast-export" learned to handle history simplification more
   gracefully.

 * "git fast-export" learned an option --tag-of-filtered-object to handle
   dangling tags resulting from history simplification more usefully.

 * "git grep" learned -p option to show the location of the match using the
   same context hunk marker "git diff" uses.

 * https transport can optionally be told that the used client
   certificate is password protected, in which case it asks the
   password only once.

 * "git imap-send" is IPv6 aware.

 * "git log --graph" draws graphs more compactly by using horizontal lines
   when able.

 * "git log --decorate" shows shorter refnames by stripping well-known
   refs/* prefix.

 * "git push $name" honors remote.$name.pushurl if present before
   using remote.$name.url.  In other words, the URL used for fetching
   and pushing can be different.

 * "git send-email" understands quoted aliases in .mailrc files (might
   have to be backported to 1.6.3.X).

 * "git send-email" can fetch the sender address from the configuration
   variable "sendmail.from" (and "sendmail.<identity>.from").

 * "git show-branch" can color its output.

 * "add" and "update" subcommands to "git submodule" learned --reference
   option to use local clone with references.

 * "git submodule update" learned --rebase option to update checked
   out submodules by rebasing the local changes.

 * "gitweb" can optionally use gravatar to adorn author/committer names.

(developers)

 * A major part of the "git bisect" wrapper has moved to C.

 * Formatting with the new version of AsciiDoc 8.4.1 is now supported.

Fixes since v1.6.3
------------------

All of the fixes in v1.6.3.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.3.X series.

 * "git diff-tree -r -t" used to omit new or removed directories from
   the output.  df533f3 (diff-tree -r -t: include added/removed
   directories in the output, 2009-06-13) may need to be cherry-picked
   to backport this fix.

 * The way Git.pm sets up a Repository object was not friendly to callers
   that chdir around.  It now internally records the repository location
   as an absolute path when autodetected.

 * Removing a section with "git config --remove-section", when its
   section header has a variable definition on the same line, lost
   that variable definition.

 * "git rebase -p --onto" used to always leave side branches of a merge
   intact, even when both branches are subject to rewriting.

 * "git repack" used to faithfully follow grafts and considered true
   parents recorded in the commit object unreachable from the commit.
   After such a repacking, you cannot remove grafts without corrupting
   the repository.

 * "git send-email" did not detect erroneous loops in alias expansion.
