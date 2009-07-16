From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.4.rc1
Date: Wed, 15 Jul 2009 17:57:12 -0700
Message-ID: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756812AbZGPA5W@vger.kernel.org Thu Jul 16 02:57:59 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756812AbZGPA5W@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRFIL-0004Zo-O8
	for glk-linux-kernel-3@gmane.org; Thu, 16 Jul 2009 02:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbZGPA5W (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 15 Jul 2009 20:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756672AbZGPA5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jul 2009 20:57:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756646AbZGPA5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jul 2009 20:57:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CB7FE4F17;
	Wed, 15 Jul 2009 20:57:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AB62E4F16; Wed,
 15 Jul 2009 20:57:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9C93A1A2-71A3-11DE-813F-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123350>

A release candidate GIT 1.6.4.rc1 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.4.rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.4.rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.4.rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.4.rc1-1.fc9.$arch.rpm	(RPM)

GIT v1.6.4 Release Notes (draft)
================================

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

When the user does not tell "git push" what to push, it has always
pushed matching refs.  For some people it is unexpected, and a new
configuration variable push.default has been introduced to allow
changing a different default behaviour.  To advertise the new feature,
a big warning is issued if this is not configured and a git push without
arguments is attempted.

	Side note: we might want to tone this down, as it does not seem
	likely for us to change the default behaviour when this option is
	not set.


Updates since v1.6.3
--------------------

(subsystems)

 * gitweb Perl style clean-up.

 * git-svn updates, including a new --authors-prog option to map author
   names by invoking an external program.

(portability)

 * We feed iconv with "UTF-8" instead of "utf8"; the former is
   understood more widely.

(performance)

(usability, bells and whistles)

 * "git add --edit" lets users edit the whole patch text to fine-tune what
   is added to the index.

 * "git log --graph" draws graphs more compactly by using horizonal lines
   when able.

 * "git log --decorate" shows shorter refnames by stripping well-known
   refs/* prefix.

 * "git send-email" understands quoted aliases in .mailrc files (might
   have to be backported to 1.6.3.X).

 * "git send-email" can fetch the sender address from the configuration
   variable "sendmail.from" (and "sendmail.<identity>.from").

 * "git show-branch" can color its output.

 * "add" and "update" subcommands to "git submodule" learned --reference
   option to use local clone with references.

(developers)

 * A major part of the "git bisect" wrapper has moved to C.

Fixes since v1.6.3
------------------

All of the fixes in v1.6.3.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.3.X series.

 * The way Git.pm sets up a Repository object was not friendly to callers
   that chdir around.  It now internally records the repository location
   as an absolute path when autodetected.
