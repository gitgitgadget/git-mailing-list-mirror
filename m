From: Andreas Ericsson <ae@op5.se>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 18:03:07 +0100
Message-ID: <43F20D4B.3060606@op5.se>
References: <43F20532.5000609@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 18:06:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F93aj-0006kE-FH
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 18:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWBNRDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 12:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbWBNRDK
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 12:03:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:4334 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1422679AbWBNRDI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 12:03:08 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B7A5E6BCFF; Tue, 14 Feb 2006 18:03:07 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Nicolas Vilz 'niv' <niv@iaglans.de>
In-Reply-To: <43F20532.5000609@iaglans.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16140>

Nicolas Vilz 'niv' wrote:
> Hello everyone,
> 
> i wonder, how i revoke a straight forward merge of two trees... I
> actually wanted to be look like somewhere in the git-repository, where
> some branches are merged back with the master tree, but i think, that
> wasn't "cg-merge -c <tree to merge with the actual one>"...
> 
> my result was that my master tree has now the same sha1-sum as my
> development-tree and gitk visualisation differs from that what i saw in
> the git-repository. (Several Arrows headed into back into one line...)
> 
> maybe that was because i didn't do anything in my master tree in the
> meantime.
> 

Correct. The "several arrows" thing is when a merge happens (i.e. two 
simultaneous lines of development crash into one another with 
surprisingly pleasant results most of the time). When you do

$ git checkout -b topic-branch
# work, work, work
$ git checkout master
$ git pull . topic-branch

git will recognize the merge-base as being the current HEAD and simply 
sets HEAD to point to that of topic-branch. This is why it's called a 
fast-forward, since no heavy computing needs to be done to combine the 
two development tracks.

> And another thing, is there no posibility to get back to some commits or
> tags? I realized you can rebranch tags... what, if i want to switch back
> to git version 1.1.6 in the git repository? Or a certain commit?
> 

git reset is your friend.

$ git reset --hard v1.1.6
$ git reset --hard ORIG_HEAD

should do something along the lines of what you want.

> do you have to make a new private branch out of the tag 1.1.6?
> 

No, you don't, but you can if you wish. It's nifty if you want to fork 
the development from a particular branch. In your case, if you really, 
really *want* the arrows pointing to one line, you can do

$ git branch topic-branch HEAD^
# work, work, work
$ git checkout master
$ git pull . topic-branch

That would create one pretty arrow. When multiple tracks of development 
(rather than just two) are combined into one it's called an octopus 
merge. Unless you really know what you're doing, you should try to avoid 
those for small projects, and doing it just for the pretty arrows is.... 
well, let's call it "interesting from the behaviour science scholars 
point of view".


> i used svn and there i could go back some revisions. I haven't found
> such a feature in git, yet... but i think i am blind all the time.
> 

Most likely. I believe at least the reset command is mentioned in the 
tutorial. I trust you've read it before asking, so something is amiss 
either with your eyesight or the tutorial.


> I like git very much and every new day I like it more.
> 

It's a Good Thing. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
