From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] submodule path handling fixes
Date: Sat, 7 Feb 2009 14:42:43 +0100 (CET)
Message-ID: <cover.1234013924u.git.johannes.schindelin@gmx.de>
References: <7vfxiqy76k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 07 14:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVnT4-0000aG-IS
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 14:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbZBGNmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 08:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbZBGNmG
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 08:42:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:36351 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753227AbZBGNmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 08:42:05 -0500
Received: (qmail invoked by alias); 07 Feb 2009 13:42:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 07 Feb 2009 14:42:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bOO5Exk8bRImSwn+NVJhRgb43Ta8qgaYr44J+xY
	E0uiWb8rIAzhV8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfxiqy76k.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108850>

My earlier attempt at this was misguided by my laziness, and I was willing 
to sacrifice correctness for the ability to move on to other problems.

So now, I taught plumbing to handle the trailing slash problem, which is 
not only much cleaner, but helps other users of ls-files, too.

Note that at this moment, it is beyond my reach to fix the issue that "git 
submodule no-such-submodule" will _only_ warn and not _fail_.

That would take a builtinification, as ls-files is used in a pipe in 
git-submodule.sh, and AFAIR there is no really portable way to catch 
errors in a pipe, short of using temporary files.

Johannes Schindelin (2):
  Let ls-files strip trailing slashes in submodules' paths
  submodule: warn about non-submodules

 builtin-ls-files.c         |   21 ++++++++++++++++++++-
 git-submodule.sh           |    2 +-
 t/t7400-submodule-basic.sh |   13 +++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)
