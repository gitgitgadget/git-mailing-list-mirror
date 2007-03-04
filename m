From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Conflict editing
Date: Sun, 4 Mar 2007 13:43:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 13:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNq4M-0001l3-FO
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 13:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXCDMoD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 07:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbXCDMoD
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 07:44:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:34538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751600AbXCDMoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 07:44:01 -0500
Received: (qmail invoked by alias); 04 Mar 2007 12:44:00 -0000
X-Provags-ID: V01U2FsdGVkX18c0aAYL/4cxRdsyg+kcQYrTq1vaZYB3krlkqlXRL
	qbaXFUxF1bf1H+
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41358>

Hi,

I often end up with conflicts, and I just want to edit the conflicting 
files, one after another. To make this easier, I wrote a script (yes, no 
builtin) to start the editor with the files having conflicts.

Of course, this script is dumb and has no way to edit files whose names 
contain spaces, it will choke on conflicting symlinks and it does not 
update the index after editing the files (to avoid erroneous updating). As 
usual, it did not really receive more testing than absolutely necessary.

Ciao,
Dscho

-- snipsnap --
#!/bin/sh
#
# Copyright (c) 2006, Shawn O. Pearce
#
# Cleanup unreachable files and optimize the repository.

USAGE=''
SUBDIRECTORY_OK=Yes
. git-sh-setup
cd_to_toplevel

test -z "$(git ls-files --unmerged)" && echo "Nothing to do" && exit

git ls-files --unmerged | cut -b51- | grep ' ' >/dev/null &&
die "filenames contain spaces"

"${VISUAL:-${EDITOR:-vi}}" $(git ls-files --unmerged | cut -b51- | uniq)
