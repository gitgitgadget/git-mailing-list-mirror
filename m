From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: cg-admin-setuprepo fails to make a cg-clone'able repo
Date: 12 Nov 2005 08:51:35 -0800
Message-ID: <8664qxn71k.fsf@blue.stonehenge.com>
References: <86wtjg31lo.fsf@blue.stonehenge.com>
	<20051111001333.GH30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 17:53:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaybt-0003r4-TH
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 17:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVKLQvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 11:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVKLQvl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 11:51:41 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:38064 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932409AbVKLQvl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 11:51:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 6F3618F890;
	Sat, 12 Nov 2005 08:51:36 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23215-01-24; Sat, 12 Nov 2005 08:51:35 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D35568F894; Sat, 12 Nov 2005 08:51:35 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.14.4; tzolkin = 8 Kan; haab = 2 Ceh
In-Reply-To: <20051111001333.GH30496@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11693>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> But this is actually an entirely unrelated bug, it seems - pretty
Petr> strange.  I revived another few months old thread because of this, since
Petr> it seems the 'b' was actually a typo and we don't want to pass 'cp' this
Petr> argument at all, but something different. Does cloning locally otherwise
Petr> work?

When I tried "local cloning", I first tried to make an empty archive
with cgi-init, but it dumped me into an editor.  I couldn't find a
switch to turn that off.  Perhaps the manpage should say "you'll
be dumped in to an editor", and perhaps provide a way to pass that
message with "-m".

So, on a whim, I realize that it's performing an initial commit, so
I try cg-init -I.  And here's the result:

    localhost:~/Projects/Git % cg-init -I my_master
    defaulting to local storage area
    localhost:~/Projects/Git % cg-clone my_master my_slave
    defaulting to local storage area
    find: /Users/merlyn/Projects/Git/my_master: No such file or directory
    Hard links don't work - using copy
    Fetching head...
    cp: illegal option -- b
    usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src target
           cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src1 ... srcN directory
    cg-fetch: unable to get the HEAD branch
    cg-clone: fetch failed

So, I guess your answer is no.  What is "-b" for cp.  That's not
on my manpage.

And, after reading the manpage closer, I see my first "my_master"
was created wrong.  But no error message. :(  So, repeating this
using a subdirectory...

    localhost:~/Projects/Git % rm -rf .git 
    localhost:~/Projects/Git % mkdir my_master
    localhost:~/Projects/Git % cd my_master
    localhost:..ects/Git/my_master % cg-init -I
    defaulting to local storage area
    localhost:..ects/Git/my_master % cd ..
    localhost:~/Projects/Git % cg-clone my_master my_slave
    defaulting to local storage area
    Hard links don't work - using copy
    Fetching head...
    cp: illegal option -- b
    usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src target
           cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src1 ... srcN directory
    cg-fetch: unable to get the HEAD branch
    cg-clone: fetch failed

Again, lots of "no" answers there.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
