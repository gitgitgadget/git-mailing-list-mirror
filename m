From: Klaus Robert Suetterlin <robert@mpe.mpg.de>
Subject: missing: git api, reference, user manual and mission statement
Date: Tue, 19 Apr 2005 14:36:32 +0200
Message-ID: <20050419123631.GD3739@xdt04.mpe-garching.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 14:34:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNrv1-0007hg-M7
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 14:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDSMhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDSMhZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 08:37:25 -0400
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:5388 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id S261465AbVDSMgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 08:36:41 -0400
Received: from xdt04.mpe-garching.mpg.de (xdt04.mpe-garching.mpg.de [130.183.136.164])
	by mpehp1.mpe-garching.mpg.de (8.9.3 (PHNE_25183+JAGae58098)/8.9.3) with ESMTP id OAA19570
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 14:36:36 +0200 (METDST)
Received: (from krs@localhost)
	by xdt04.mpe-garching.mpg.de (8.13.3/8.13.1/Submit) id j3JCaW7D016286
	for git@vger.kernel.org; Tue, 19 Apr 2005 14:36:32 +0200 (CEST)
	(envelope-from krs)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear all,

please don't bother me with ``read the source dude'' or similar answers to this post.  If it's tone or contents just piss You off, ignore it.

I read a little about git lately, and tried to get it running the
last two days.  I found the following things lacking:

1) There is no clear (e.g. by name) distinction between ``git as done
by Linus'', which is a kind of content addressable database with added
semantics, and ``git as done by the rest of You'', which is a kind of
SCM on top of Linuses stuff.

2) For Linuses stuff I dare to say that it is an evil hack from
hell.  A prototype come alive.  This is not meant as an insult;  I
guess Linus agrees.

What it misses the most is a written reasoning about the WHYs, HOWs and
WHATFORs of git.  There is the README which tells us a little about
the WHAT on a level just above source code.

Linus must have had an idea of the final product, and how to use
that.  The real day to day workflow.  From that, and from his
experience with BK and the glimpse he took at monotone, he deduced
what limits the backend of his new distributed SCM system should have.
That is what he implemented:  A storage backend for an SCM.
(Unfortunately he didn't tell us for which.  This is like having
the answer without the question.  That is gitLinus is just like
``42''.)

Unfortunately what this storage backend does not have is an API or
UI definition.  I.e. there is no definition of git interaction
except for the git source code and the application on BLOB, TREE,
CHANGESET as described in the README.

I do think there should be a well defined API or UI so that the
backend could be replaced / changed / improved as need dictates.

3) As of the gitSCM stuff, I really miss any kind of description
how it works.  That is it completely lacks any concept, except for
``we will use gitLinus as backend''.

Take a look at some other distributed SCM (e.g. monotone -- which
might be too slow for a project like the kernel) and see how much these
people think about usage.  Do not reinvent the wheel, there is prior
art for use cases, too!

Some examples are:
1) What does the typical usage look like?
2) What is a version?
3) What is fork? (Especially in the context of a distributed SCM.)
4) What is a branch?
5) Which questions do we want the SCM to answer?
6) What is our security modell?
7) How do we synchronise?  (Not what command do we use , i.e.
   ``rsync'', but what is the operation, e.g. ``full replication of
   state''.)

I really believe a lot of questions on the git mailing list could
be answered if there was a user manual and a reference for git.
Even before all of it will be implemented.

4) Concerning usability on systems other than Linux...  I guess
this one can be ignored by most.

The source still uses st->st_mtim.tv_nsec which should be ->st_mtimensec, I guess.

git is implemented as mostly sh shell scripts.
gitdiff-do and gitlog.sh rely on bash, more precisely on /bin/bash.
git pull uses rsync
...

The list of dependencies is long and growing.  So if the intent of
doing gitSCM with shell scripts was to make it portable: that goal was missed.

5) gitLinus as library.

First I have to say that between what I saw in git-0.04 and the
current stuff from git-pasky there has been quite a lot of work to
get further away from the evil prototype.

Still gitLinus lacks a clear definition of its interface, so I
guess no one will be able to tell if it works correct.  How could You
do a test case without knowing
a) what the software should do and
b) how You should tell it?

And of course there are still memory leaks.  The obvious
--- i.e. malloc and (missing) free in the same function --- I found
while reading the git-0.04 source yesterday are gone.  Still I found
one of the ``malloc in called function no free in caller'' leaks
in git-pasky as pulled NOW.  And all I did was `grep malloc *'.
Someone should sit down and read all the source top to bottom.  And
the software should either check its resource usage or someone
should use a good tool on it.



Thanks for Your time and patience,

--Robert Suetterlin (robert@mpe.mpg.de)
phone: (+49)89 / 30000-3546   fax: (+49)89 / 30000-3950
