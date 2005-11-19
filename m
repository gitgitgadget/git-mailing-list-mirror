From: Marco Costalba <mcostalba@yahoo.it>
Subject: git --exec-path conversion
Date: Sat, 19 Nov 2005 03:14:44 -0800 (PST)
Message-ID: <20051119111444.82122.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 12:14:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdQgE-00063i-1t
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 12:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVKSLOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 06:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVKSLOq
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 06:14:46 -0500
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:63074 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751041AbVKSLOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 06:14:46 -0500
Received: (qmail 82124 invoked by uid 60001); 19 Nov 2005 11:14:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=v4HY8jtIL4KmtE4OHzscJDLMijvnmpSLPi54VmHnHp/mcTAV2udVXBrEBnLEeZrXcnJR6Tu4P/+n9KvdVNGn0cRviy75rFVrIw/67IqLnQBlqonxKmUZ6nnZnLSqB4ay6wG0qxsYDYatTxGtZn2W2+EPwFaroYFLjmYk6tLXtxU=  ;
Received: from [151.44.24.124] by web26309.mail.ukl.yahoo.com via HTTP; Sat, 19 Nov 2005 03:14:44 PST
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12328>

Hi,

   if I understood correctly, git programs will be installed somewhere in $PATH for at least next
two months.

But I would like to update to what will be the future, i.e. prepending what 'git --exec-path' says
to any git command.

I don't call git programs directly but I use a function QGit::run(cmd) that does this plus other
things.

The problem is that I call QGit::run() also for other commands not related to git (ls, cat,
etc..).

How can I make the transition?

Now I have two ways, the brute force way and the easy (peraphs tricky) way.

The brute force is to create a new function QGit::runGitCmd() that deals only with git commands
_and_ replace all the occurences of run() with the latter.

The easy way is to prepend the exec-path *inside* run(), and to use to disambiguate bewteen git
and shell commands the testing of first three chars of the command to launch, something like:

    if (cmd.left(3) == "git") 
         cmd = cmd.prepend(exec-path);


I would like to go with the second one, I'm a bit lazy ;-) , but I would like to ask if this is a
good policy, i.e. if also inside git programs/scripts (like in git.c I guess) is used or is
foreseen to keep using something like this.


Thanks
Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
