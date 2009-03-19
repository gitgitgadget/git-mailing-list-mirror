From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: git-svn with multiple branch directories
Date: Fri, 20 Mar 2009 00:17:15 +0100 (CET)
Message-ID: <alpine.LSU.2.01.0903200002390.29898@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 00:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRVh-0002X3-LH
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZCSXRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbZCSXRV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:17:21 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33266 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752206AbZCSXRU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 19:17:20 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 180712F7108
	for <git@vger.kernel.org>; Thu, 19 Mar 2009 19:17:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 19 Mar 2009 19:17:19 -0400
X-Sasl-enc: ulR2Z0WY3Er/0VkKRv8cOQzIV/RfGtbvJ7RR0v9Sf6bO 1237504638
Received: from [192.168.2.101] (p549A49D8.dip.t-dialin.net [84.154.73.216])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 587763A9F7
	for <git@vger.kernel.org>; Thu, 19 Mar 2009 19:17:18 -0400 (EDT)
User-Agent: Alpine 2.01 (LSU 1184 2008-12-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113859>

Hello,

I am trying to create a git repo that tracks an SVN repo with multiple 
branch directories.

Is there any way to get this done easily?

It seems the 'git svn' command allows only to specify one 'trunk', 
'branches' and 'tag' directory.

The example usecase is the OpenOffice.org repo (it's just a private 
experiment). I got this svn-sync'ed within 4 evening sessions, the SVN 
size is about ~8 GB with ~270000 commits. Unfortunately their structure is

   branches/
   contrib/
   cws/
   dist/
   patches/
   tags/
   trunk/

where 'cws' and 'branches' both hold branches.

I have seen a web-based article telling one should

   git svn clone <URL>/trunk repo.git

first, and then hack the repo.git/.git/config file manually to add entries 
like

   [svn-remote "b1"]
         url = $SVN_REPO_URL/branches/b1
         fetch = :refs/remotes/b1
   [svn-remote "b2"]
         url = $SVN_REPO_URL/branches/b2
         fetch = :refs/remotes/b2
   [svn-remote "c1"]
         url = $SVN_REPO_URL/cws/c1
         fetch = :refs/remotes/c1
   ...

to later use

   git svn fetch <branchname>

for each branch. But even if that worked, their seems to be no easy way to 
detect newly created branches etc. Additionally, I get two entries listed 
in 'git branch' for each, one of which with extension '@1' (seems to point 
ot the branch point). This doesn't seem to be the case for repo's with 
only one branch directory converted the normal way.

Any ideas?

Best regards

Guido
