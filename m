From: William Hall <will@gnatter.net>
Subject: SVN migration
Date: Thu, 17 Jun 2010 00:02:07 +0100
Message-ID: <4C1957EF.6070504@gnatter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 01:15:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP1oy-0000Uo-Rl
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 01:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759532Ab0FPXOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 19:14:53 -0400
Received: from mail.qualtersystems.com ([74.200.89.103]:45907 "EHLO
	mail.qualtersystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758615Ab0FPXOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 19:14:50 -0400
X-Greylist: delayed 726 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jun 2010 19:14:50 EDT
Received: from localhost (mail [127.0.0.1])
	by mail.qualtersystems.com (Postfix) with ESMTP id C04582B6839A
	for <git@vger.kernel.org>; Thu, 17 Jun 2010 00:02:42 +0100 (BST)
X-Virus-Scanned: amavisd-new at qualtersystems.com
Received: from mail.qualtersystems.com ([127.0.0.1])
	by localhost (mail.qualtersystems.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7rAZctYfypW8 for <git@vger.kernel.org>;
	Thu, 17 Jun 2010 00:02:23 +0100 (BST)
Received: from [192.168.1.84] (xambo.qualtersystems.com [82.152.227.154])
	(Authenticated sender: will@mail.qualtersystems.com)
	by mail.qualtersystems.com (Postfix) with ESMTP id 837192B6830A
	for <git@vger.kernel.org>; Thu, 17 Jun 2010 00:02:07 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Lightning/1.0b1 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149279>

Hi gitters,

Background - I'm trying to convince my company to ditch SVN for git - 
the usual story. So for the duration of a project I'll be running git 
and SVN in parallel - the idea being is that we will still commit to SVN 
(and update), but the development work internal to my team will be using 
git.

An absolute *must* is for the SVN repo to continue as the SCM authority 
- at least until I can persuade the company to switch to git permanently.

Here's some crap ascii art to show the situation,

--------------
| non-git dev |
--------------
      |
      |
   -------         ----------------
  |  SVN  |-------| git/SVN bridge |
   -------         ----------------
                         |
                   ---------------
                  | bare git Repo |
                   ---------------
                         |
          ------------------------------
          |              |              |
        dev_1          dev_2          dev 3


- the git/SVN bridge is a git repo created with git-svn-clone.

- the 'bare git' repo is a typical standard git repo and I'm keen for 
the developers to experience a 'normal' git environment and not have to 
worry about SVN interactions.

Am sure this problem has been considered many times before, but I cannot 
seem to find an effective solution.

The issue is the dcommit operation from the bridge. The rebase part of 
this re-writes the commit messages to include the SVN commit-ids which 
is nice, but screws up the push/pulls between the bridge and the bare repo.

One solution I've tried is to create a branch in the bridge that tracks 
the bare repo, and another branch to track the SVN server. If the 
branches are kept separate then I can git-cherry-pick to replay changes 
from one side to the other (or at least merge one-way). his is not ideal 
as I really should use git's merge facility. I'd like to guarantee that 
the sides are not diverging over time.

Actually I've tried all permutations of merges/rebases/update-ref, I 
always fall into the same trap that befits a rebase in conjunction with 
remote repositories.

I can live without tags and branches for the time being - I just want to 
get a robust workflow defined in the bridge for the SVN 'trunk' - ie 
read/writes in both directions.

If anyone can offer any advice then it would be hugely appreciated. 
Perhaps you'll say that it cannot be done, which would make the git sell 
much harder.

Hopefully by the end of this exercise git will have 800 more fans.

Many thanks

Will
