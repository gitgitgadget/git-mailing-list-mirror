From: Petr Baudis <pasky@ucw.cz>
Subject: Re: unseeking?
Date: Sun, 24 Apr 2005 18:05:14 +0200
Message-ID: <20050424160514.GI1507@pasky.ji.cz>
References: <20050424154754.GA11094@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 18:01:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPjXU-0000Be-FS
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 18:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVDXQFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 12:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVDXQFc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 12:05:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11719 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262349AbVDXQFQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 12:05:16 -0400
Received: (qmail 26997 invoked by uid 2001); 24 Apr 2005 16:05:14 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050424154754.GA11094@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 05:47:54PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Hi,

Hi,

> I've been pulling cogito and the kernel, and just fumbling around trying to
> learn the tool. My latest cogito is version 0.7, tracking
> 
> pasky   rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
> linus   rsync://www.kernel.org/pub/linux/kernel/people/torvalds/git.git
> 
> I have many questions.
> 
> 1) I saw some discussion of 'seek' as a way to get to an earlier version of a
> tree; so I tried it on my own test directory. I 'seek'ed to the first patch, and
> it worked - but now all I have is that very early version of my test directory.
> All subsequent changes are apparently gone. How can I seek back to the most
> recent state of the dir?

git seek, without any arguments.

Perhaps we should prohibit absence of arguments and add 'unseek'?

> 2) How can I 'check out' my local repository? i.e. I want to pretend to be
> two developers, one of whom wants to grab a copy of the project leader's work. I
> tried things like:
> 
> mkdir mygitdir2
> git init ../mygitdir
> 
> where mydir is my test git repository. This didn't work. I tried rephrasing the

Actually, this _would_ work:

	git init ../mygitdir/.git

Then, you would need to git pull to get the latest changes.

> command with an rsync url:
> 
> git init rsync://home/zbrown/site/gitstuff/mygitdir
> 
> but that didn't work either. It just said:
> 
> defaulting to local storage area
> rsync: getaddrinfo: home 873: Name or service not known
> rsync error: error in socket IO (code 10) at clientserver.c(94)
> gitpull.sh: unable to get the head pointer of branch master
> gitinit.sh: pull failed

git fork seconddeveloper ../mygitdir

> 3) How can I do a rename with cogito? There doesn't seem to be a rename command,
> and if I manually do a mv and 'git add', I can commit the result, but what
> actually happened? Did I really do a rename? Is the file's history preserved?
> How can I verify these things?

Git does not record renames, and neither does Cogito (for now).

> 4) fork, seek, tag, and track are a little mysterious to me. I can guess at what
> these things do in general, but the specifics are confusing, and the README is a
> little vague.

Try head git*.sh. ;-)

> 5) I'm a little confused about how to use a git repository to follow along with
> a project. I have no problem pulling the latest version, but I'm interested in
> generating changelogs for specific releases like 2.6.12-rc3. How can I
> 
>    a) identify the proper 'c83b95297c2a6336c2007548f909769e0862b509' string that
>    represents the release I'm interested in

Assuming that it is tagged, just do

	commit-id linux-2.6.12-rc3

or whatever the tag name is. From Cogito perspective, you can use the
symbolic name anywhere you would use the proper string.

There is also tree-id and parent-id, with same usage.

>    b) generate the changelog between that version and the previous one,
>    once I've solved (a)

	git log previous that

Any ideas how to improve the user interface further are deeply
appreciated. (However please note that it is going to undergo a big
change in an hour or two, so you might want to postpone them until
that.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
