From: Andreas Gruenbacher <agruen@suse.de>
Subject: GNU patch: upcoming stable release
Date: Mon, 6 Apr 2009 17:13:37 +0100
Organization: SUSE Labs / Novell
Message-ID: <200904061813.37994.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 18:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqrZY-0001md-0z
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbZDFQTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 12:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbZDFQTt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:19:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43014 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbZDFQTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 12:19:48 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A2BAE86445
	for <git@vger.kernel.org>; Mon,  6 Apr 2009 18:19:45 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Length: 3598
X-UID: 12595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115849>

Hello,

I am pleased to announce the next alpha release of GNU patch, available by 
anonymous FTP from:

  ftp://alpha.gnu.org/gnu/patch/

The code should be feature complete for the next stable release with only a 
few minor bugfixes left in the queue.  This is your chance to report more 
bugs that still need to be addressed.  Please expect the next stable release 
to happen in about a month's time.

The last stable release dates back to June 2004 with version 2.5.9.  I would 
like to thank Paul Eggert for his work on GNU patch, and for making his code 
repository available for import.  A new project has been created on Savannah 
with the new code repository and the bug-patch@gnu.org mailing list archive:

  http://savannah.gnu.org/projects/patch

A lot of things have accumulated since version 2.5.9.  The following user 
visible changes have been made:

* A regression test suite has been added ("make check").

* A -m or --merge option has been added which will merge a patch file into
  the original files similar to merge(1).  See the patch(1) manual page for
  documentation.

* Unless a filename has been specified on the command line, look only
  for filenames in the patch until one has been found.  This prevents
  patch from tripping over garbage that isn't a patch.  When conforming
  to POSIX, this behavior is turned off and patch will ask for a
  filename if none is found.

* All reject files have file name headers, which allows to use them
  as regular patches.

* When a patch file modifies the same file more than once, patch makes
  sure it backs up the original version of the file, rather than any
  intermediary versions.

* In the above situation, if there are rejects in more than one of those
  patches, the rejects are appended to the same reject file (rather then
  overwriting themselves).

* The -r option works correctly even there are rejects in more than one
  file.  Use the - argument to discard rejects.

* Rejected hunks come out in unified diff format if the input patch was of
  that format, otherwise in ordinary context diff form.  Use the
  --reject-format option to enforce either "context" or "unified" format.
  The "diff -p" (--show-c-function) output is preserved.
  Changed lines in context format reject files are correctly indicated
  with '!' markers as the format defines.  Added and removed lines are
  still marked with '+' and '-', respectively.

* The file permissions of reject files are no longer set to match the files
  they modify.  Instead, they retain the default permissions.  This is
  consistent with reject files to which rejects of multiple files may be
  written (-r option).

* The --binary option disables the heuristic for stripping CRs from
  line endings in patches.  This allows to preserve CRs even in mangled
  patches, or in patches generated without the --binary option on non-POSIX
  systems.

* Backup files for nonexisting files are now created with default
  permissions rather than with mode 0: backup files with mode 0 were
  causing problems with applications which do not expect unreadable
  files.

* The -B, -Y, and -z options (--prefix, --basename-prefix, --suffix) now
  imply the simple version control mode, and can be combined.

* Patch rejects more malformed normal format commands and checks for trailing
  garbage.  It now recognizes ed commands without addresses.

Please see the project's bug tracker for a list of known issues before 
reporting those things again on the mailing list.  (Postponed bugs are not 
going to be addressed in the next stable release.)

Please email bugs or suggestions to <bug-patch@gnu.org>.

Thanks,
Andreas
