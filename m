From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Find the starting point of a local branch
Date: Sun, 23 Dec 2012 23:09:58 -0500
Message-ID: <201212240409.qBO49wkV020768@no.baka.org>
References: <20121224035825.GA17203@zuhnb712>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 05:31:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tmzh0-0006Rw-7f
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 05:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab2LXEaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 23:30:52 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:50163 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab2LXEav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 23:30:51 -0500
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Dec 2012 23:30:51 EST
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id qBO49w4b030969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 23 Dec 2012 23:09:59 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id qBO49wkV020768;
	Sun, 23 Dec 2012 23:09:58 -0500
In-reply-to: <20121224035825.GA17203@zuhnb712>
Comments: In reply to a message from "Woody Wu <narkewoody@gmail.com>" dated "Mon, 24 Dec 2012 11:58:25 +0800."
Bypass: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212094>


In message <20121224035825.GA17203@zuhnb712>, Woody Wu writes:

    How can I find out what's the staring reference point (a commit number
    or tag name) of a locally created branch? I can use gitk to find out it
    but this method is slow, I think there might be a command line to do it
    quickly.

The answer is more complex than you probably suspected.

Technically, `git log --oneline mybranch | tail -n 1` will tell you
the starting point of any branch.  But...I'm sure that isn't what you
want to know.

You want to know "what commit was I at when I typed `git branch
mybranch`"?  The problem is git doesn't record this information and
doesn't have the slightest clue.

But, you say, I can use `gitk` and see it.  See?  Right there.  That
isn't (necessarily) the "starting point" of the branch, it is the
place where your branch diverged from some other branch.  Git is
actually quite able to tell you when the last time your branch
diverged from some other branch.  `git merge-base mybranch master`
will tell you this, and is probably the answer you were looking for.
Note that this is the *last* divergence.  If your branch diverged and
merged previously that will not be reported.  Even worse, if you did a
fast-forward merge (I recommend against them in general) then it is
impossible to discover about what the independent pre-merge history
was really like.

					-Seth Robertson
