From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 11:48:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 26 11:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv75t-0002Mr-NI
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 11:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab0CZKso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 06:48:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:47823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752128Ab0CZKsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 06:48:43 -0400
Received: (qmail invoked by alias); 26 Mar 2010 10:48:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 26 Mar 2010 11:48:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uUwoqPE/uM/BaWYG1EcuDV/ioLSIhem8Zux6MVL
	1fL/2iaVCFz6kX
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143219>


This supports opening the results of a 'git grep' directly in a pager 
(where the pager can be 'vi', too).

This series is purely about convenience, everything the option does can
be done with a regular script or command line.

But I saw so many people doing their own scripts for that, and in many
cases, they are subtly broken (e.g.

	git grep -z <expr> | xargs -0r vi +/<expr>

would work as long as you do not have to check the exit status of git
grep from another script) that I finally decided to go for it and send
this patch pair.

My most common use case for this is to do something like

	git grep -Ovi SomeJustRenamedFile

to edit all files I might have forgotten to change after a git mv.

(Actually, to be honest, my use case involves -Pvi, but I will have to
retrain my hands.)

Johannes Schindelin (2):
  grep: Add the option '--open-files-in-pager'
  grep -P: allow optional argument specifying the pager (or editor)

 Documentation/git-grep.txt |    8 +++++
 builtin-grep.c             |   74 ++++++++++++++++++++++++++++++++++++++++++++
 git.c                      |    2 +-
 3 files changed, 83 insertions(+), 1 deletions(-)
