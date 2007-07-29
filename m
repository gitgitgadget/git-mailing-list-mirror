From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/9] work-tree clean ups
Date: Mon, 30 Jul 2007 00:23:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFI7G-0002CJ-7n
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934431AbXG2XXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764452AbXG2XXw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:23:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:37698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764048AbXG2XXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:23:51 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:23:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 30 Jul 2007 01:23:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195Vic5nUN5Ip8mXnmMVhLF+39ahBMvv1VC3vCT5X
	FAn7ZGv3/ENfq+
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54149>

Hi,

this is the 3rd revision of the work-tree clean up series.  Unlike the 1st 
revision, this passes all the tests.  Unlike the 2nd revision, it has a 
concise and precise logic:

--work-tree=bla overrides GIT_WORK_TREE, which overrides core.bare = true,
which overrides core.worktree, which overrides GIT_DIR/.. when GIT_DIR
ends in /.git, which overrides the directory in which .git/ was found.

The distinction between git_dir and work_tree is much clearer now: you can 
have a work_tree which is inside a git_dir, and programs needing a 
work_tree will no longer complain.

The work tree information is no longer just thrown away.  Instead, you can 
run git from the git_dir and it will work on the work tree without you 
having to cd back and forth.

The wrong distinction between a non-bare repository and a repository with 
a work_tree is no longer there.  A repository is either bare, or it has a 
working directory.  There is no third option.

Ciao,
Dscho
