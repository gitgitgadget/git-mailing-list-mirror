From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] git-log shows first parent and repeated last for octopus merge
Date: Wed, 18 Oct 2006 13:11:35 +0200
Organization: At home
Message-ID: <eh5242$rar$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 18 13:11:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga9Kb-0003vU-C2
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 13:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWJRLL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 07:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWJRLL0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 07:11:26 -0400
Received: from main.gmane.org ([80.91.229.2]:55939 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030204AbWJRLLZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 07:11:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ga9KU-0003uS-31
	for git@vger.kernel.org; Wed, 18 Oct 2006 13:11:22 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 13:11:22 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 13:11:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29222>

When trying to find how many merges and how many octopus merges (merges with
more than two parents) are in git.git repository I have encountered the
following strange output of git-log:

 1000:jnareb@roke:~/git> git log --parents --full-history --max-count=1 \
   211232bae64bcc60bbf5d1b5e5b2344c22ed767e -- a//b
 commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e <last parent repeated>
 Merge: d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b...
 [...]

while git-show gives correct output

 1005:jnareb@roke:~/git> git show 211232bae64bcc60bbf5d1b5e5b2344c22ed767e
 commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e
 Merge: fc54a9c... 9e30dd7... c4b83e6... 6602659... b28858b...
 [...]

Same with git-rev-list, also shows correct output:

 1005:jnareb@roke:~/git> git rev-list --header --parents --max-count=1 \
   211232bae64bcc60bbf5d1b5e5b2344c22ed767e
 211232bae64bcc60bbf5d1b5e5b2344c22ed767e [...] 
 tree cdafa88fa4ed7fcc7bb6c64d62e2d7c4d3b65e42
 parent fc54a9c30ccad3fde5890d2c0ca2e2acc0848fbc
 parent 9e30dd7c0ecc9f10372f31539d0122db97418353
 parent c4b83e618f1df7d8ecc9392fa40e5bebccbe6b5a
 parent 660265909fc178581ef327076716dfd3550e6e7b
 parent b28858bf65d4fd6d8bb070865518ec43817fe7f3
 [...]

1008:jnareb@roke:~/git> git --version
git version 1.4.2.1
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
