From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Git-SVN & subdirectory branches
Date: Fri, 27 Aug 2010 12:37:42 -0400
Message-ID: <F393D37F-9BDE-4F29-94E9-806AF88D1A30@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 18:37:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op1wD-0006rb-L3
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 18:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab0H0Qhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 12:37:51 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53492 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab0H0Qhu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 12:37:50 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CA2B71FFC054; Fri, 27 Aug 2010 16:37:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 684FE1FFC054;
	Fri, 27 Aug 2010 16:37:40 +0000 (UTC)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154605>

I'm working on creating a git mirror of the MINIX 3 repository.  I'm encountering a problem with the fact that the branches and tags often but not always are based on a subdirectory of trunk.  It appears that when git-svn encounters one of these branches it starts over from revision 1.  Is there a good way to deal with this or should I just let git-svn clone it as it will and use something like filter-branch to clean it up?  (Note that I intend this to be an ongoing mirror so any solution has to let git-svn work properly afterwords.)

In particular, MINIX's trunk contains a bigports and a src subdirectory and some branches (and tags) have both subdirectories, but more often they branch just the src (kernel and servers) directory.

For visual learners:

/trunk
  /bigports
  /src
    /boot
    /commands
    ...
/branches
  /R3.1.0
    /bigports
    /src
  /R3.1.7
    /boot
    /commands
    ...

The SVN repo can be browsed at https://gforge.cs.vu.nl/gf/project/minix/scmsvn/?action=browse&path=/ but people should be careful trying to clone it fully using git-svn due to the issue above.  I finally just used svnsync to create a local copy to clone from.

~~ Brian