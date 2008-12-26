From: Brice Figureau <brice+git@daysofwonder.com>
Subject: Strange large push operation.
Date: Fri, 26 Dec 2008 13:23:50 +0100
Message-ID: <4954CCD6.5000105@daysofwonder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 13:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGBuN-0005Db-05
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 13:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbYLZMbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 07:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYLZMbP
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 07:31:15 -0500
Received: from mail.daysofwonder.com ([87.98.213.69]:58905 "EHLO
	mail.daysofwonder.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYLZMbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 07:31:15 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Dec 2008 07:31:14 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.daysofwonder.com (Postfix) with ESMTP id 89F2268088
	for <git@vger.kernel.org>; Fri, 26 Dec 2008 13:23:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at daysofwonder.com
Received: from mail.daysofwonder.com ([127.0.0.1])
	by localhost (mail.daysofwonder.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id L9G79wPQkyPq for <git@vger.kernel.org>;
	Fri, 26 Dec 2008 13:23:51 +0100 (CET)
Received: from macbook.local (figureau.pck.nerim.net [213.41.177.193])
	(Authenticated sender: brice)
	by mail.daysofwonder.com (Postfix) with ESMTPSA id 7055968086
	for <git@vger.kernel.org>; Fri, 26 Dec 2008 13:23:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103937>

Hi,

I'm a git user since about a year, but I can't say I'm really familiar 
with its internals. I am using git v 1.5.6.5

I have a quite large bare remote repository (around 1GiB, about 86k 
objects), and I have a clone on my development computer (which was 
cloned a long time ago). I use ssh to push/pull between those repositories.

About 2 months ago, we created a remote branch (let's call it 'branch') 
and pursued development on this branch and also on master, with a few 
regular merge points from master to 'branch'.

Two days ago, I wanted to start developping a new feature, and as such 
created a local branch from this branch, which we'll call 'newbranch'. I 
cherrypicked a couple of old (4 months) commits  that were in another 
local branch, and then added more small commits (about 10 sloc of 
changes on it) on top of these.

Then I wanted to push this newbranch as a remote branch with:
$ git push origin newbranch:refs/heads/newbranch

and obtained the following output:
Counting objects: 12767, done.
Compressing objects: 100% (3816/3816), done.
writing objects:   8% (935/11682), 2.40 MiB | 324 KiB/s
^C

I stopped the push because I don't get why there are so much objects to 
send while the diff between newbranch and branch is only 5 small commits 
  (and it obviously wants to push a large part of the history).

Is there a way to check what objects are sent to origin and why?
What could be the cause of the issue?
What's wrong with those repositories?

I tried to git gc both repositories, I also git fsck both repositories 
(and found 5 unreachables objects in the local one, should I care?). I 
also upgraded the remote git to latest 1.6.0.6 but this didn't change 
anything. I also tried --thin but that didn't change anything.

So what should I do to push only the changes between branch and newbranch?

Many thanks for any answer,
--
Brice Figureau
