From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Undo last commit?
Date: Sat, 18 Jun 2011 09:43:48 -0400
Message-ID: <1308404291-sup-8978@pinkfloyd.chass.utoronto.ca>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Mike <xandrani@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 15:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXvoe-00054N-95
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 15:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab1FRNnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 09:43:50 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:33632 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab1FRNnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 09:43:49 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:35497 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1QXvoS-0003Gz-8p; Sat, 18 Jun 2011 09:43:48 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QXvoS-0000kh-7o; Sat, 18 Jun 2011 09:43:48 -0400
In-reply-to: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175969>

Excerpts from Mike's message of Sat Jun 18 09:15:49 -0400 2011:

Hi Mike,

> 3. I googled the problem and it seems everyone has a different way of
> doing this. (Maybe git is too confusing if everyone has different
> methods that all work slightly differently!?). Anyway I executed this
> command:
> 
> % git commit --amend

This command lets you modify the last commit by either adding/removing
changes which you build up with git add or in the case where you've
not staged anything, simply edit the commit message.

> % git reset --hard HEAD~1

What you wanted was:

git reset HEAD^
or
git reset HEAD~1

The --hard resets your working tree to match that commit exactly,
throwing away uncommitted changes.  In your case, it threw away the
unstaged changes you'd made and the last commit.  You should be able
to salvage your last commit by:

git reset ORIG_HEAD

The stuff that had never been git added is likely lost.  Because git
had never created an object for those changes, there won't be much to
work with.

You might inspect the output of git reflog to see if that's of any
value, but I don't think it will be in your case.

> Any ideas how to rectify this issue? I presume the 'git commit
> --amend' just changes the commit message? I daren't try anything else
> myself in case I make matters worse.

As always, take a snapshot of the .git directory before doing further
mucking.  Maybe one of the git gurus here has ideas about the trashed
unstaged changes...?

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
