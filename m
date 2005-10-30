From: Andreas Ericsson <ae@op5.se>
Subject: Re: Tracking few files among many
Date: Sun, 30 Oct 2005 16:29:27 +0100
Message-ID: <4364E6D7.9010707@op5.se>
References: <20051030130001.GA26652@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 30 16:30:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWF7j-0001DS-SW
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 16:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVJ3P33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 10:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVJ3P33
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 10:29:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53452 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750952AbVJ3P32
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 10:29:28 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 676086BCBE
	for <git@vger.kernel.org>; Sun, 30 Oct 2005 16:29:27 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051030130001.GA26652@ebar091.ebar.dtu.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10821>

Peter Eriksen wrote:
> Hello,
> 
> There's something I can't figure out.  I'm tracking a few
> configuration files in $HOME, but some operations are really
> slow.  Let's take git-status as example: 
> 
> ~ > git-status >laaangsom.txt
> ~ > wc -l laaangsom.txt
> 25875 laaangsom.txt
> ~ > cat laaangsom.txt
> #
> # Changed but not updated:
> #   (use git-update-index to mark for commit)
> #
> #       modified: .gaim/blist.xml
> #       modified: .gaim/prefs.xml
> #       modified: .mozilla/firefox/s4q22693.default/prefs.js
> #
> #
> # Untracked files:
> #   (use "git add" to add to commit)
> #
> #   [ A lot of untracked files. See the line count above. ]
> 
> What is going on?  This really doesn't seem like the wanted
> behavior.  Have I missed something?

Apart from the fact that git tracks objects using sha1-hashes, no.

However, hashing +25000 files takes quite some time even on a fairly 
quick computer. I also imagine that some of those files are quite large, 
so that doesn't really help.

If you really (really, really) want to use git to track configuration 
file changes in your homedir, I'd suggest creating a separate directory 
to keep the real files in and then symlink to those from their usual 
locations.

OTOH, since you *know* git-status (precisely because it looks for files 
not added to the index) to be slow, you should use git-diff* instead. I 
imagine you know what files you're tracking anyways since it's just a 
subset of 25000-something.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
