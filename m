From: Andreas Gruenbacher <agruen@suse.de>
Subject: GNU patch: new alpha release
Date: Mon, 23 Mar 2009 00:49:56 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903230049.56549.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 00:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlXWO-0006Bn-Am
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbZCVXyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 19:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755877AbZCVXyN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:54:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59435 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756156AbZCVXyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 19:54:12 -0400
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E64D386391
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 00:54:04 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Length: 3598
X-UID: 12537
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114206>

Hello,

I am pleased to announce my first alpha release of GNU patch,
available by anonymouns FTP from:

  ftp://alpha.gnu.org/gnu/patch/

The purpose of this release is to allow people to test changes which will 
eventually end up in the next stable release.

The last release dates back to June 2004 with version 2.5.9.  I would like to 
thank Paul Eggert for his work on GNU patch, and for making his code 
repository available for import.  A new project has been created on Savannah 
with the new code repository and the bug-patch@gnu.org mailing list archive:

  http://savannah.gnu.org/projects/patch

A lot of things have accumulated since version 2.5.9.  I am in the process of 
reviewing more bug reports to bug-gnu-utils@gnu.org and bug-patch@gnu.org.  
Meanwhile, several issues have already been addressed, and the following user 
visible changes have been made:

* A regression test suite has been added ("make check").

* Unless a filename has been specified on the command line, look only
  for filenames in the patch until one has been found.  Start looking
  for hunks only after that.  This prevents patch from tripping over
  garbage that isn't a patch.  When conforming to POSIX, this behavior
  is turned off and patch will ask for a filename when none is found.

* Reject more malformed normal format commands and check for trailing
  garbage.  Recognize ed commands without addresses.

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

More fixes and improvements are pending.  Please see the project's bug tracker 
for a (so far incomplete) list of known issues before reporting those things 
again on the mailing list.

Please email bugs or suggestions to <bug-patch@gnu.org>.

Thanks,
Andreas
