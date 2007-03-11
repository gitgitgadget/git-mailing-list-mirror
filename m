From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 17:22:01 +0100
Message-ID: <20070311162201.GA26983@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:22:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQoS-0008Kq-Cu
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933802AbXCKQWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 12:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933803AbXCKQWI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:22:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:48746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933802AbXCKQWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:22:07 -0400
Received: (qmail invoked by alias); 11 Mar 2007 16:22:05 -0000
Received: from pD9EB9C1C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.156.28]
  by mail.gmx.net (mp045) with SMTP; 11 Mar 2007 17:22:05 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/vcR0WMMrvvc9FC42MHCFpy0lttanKcQ6S6CElje
	YVdAZEVikL20+I
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41938>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> > Idea:
> > Add some way to configure tho working directory for one repository
> > and set GIT_WORK_DIR automatically when GIT_DIR is used.  I think of:
> >  * a subdirectory in the repository directory
> >    e.g. .git/work_dir which is supposed to be a symlink (or a textfile
> >    containing the path for windows compatibility?)
> > or
> >  * a configuration variable
> 
> I am not sure why you bother.  Obviously I am missing a few
> useful use cases you and Nguyen have in mind.

For example have the checkout of a git repository publicly available
(e.g. on a webserver).  The .git directory containing all the history
should probably not go there (especially if it tracks scripts).  Sure,
setting strict permissions solves this too in most cases but anyway
it's nice to have the option to move the repository away.

Additionally when reading the man page about GIT_DIR it says 'the
default value is .git', which sounds a bit like "hey, if you don't
like the name you're free to change it", but as soon as you change it
you run into problems because git behaves strange in subdirectories :)

> But either .git/work_dir or a configuration means you are
> linking a repository with a _single_ working tree, permanently.

Well, this would only be the default value for convenience with
GIT_WORK_DIR/--work-dir still overriding this value.  You'd only have
to set GIT_DIR=~/src/website and work on the website without setting
the second environment variable too.

> I've heard read-only working tree in the past, but that cannot
> be it.  If the working tree is read-only and if you are telling
> git to always use that read-only working tree when using that
> particular repository, what useful git operations are you doing
> while in that working tree?

The tools to inspect (git diff, ..) and track (git add, ..) work fine.
So one could easily (without copying stuff around) track changes of a
read-only directory.
