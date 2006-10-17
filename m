From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 02:04:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610170157270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
 <200610170155.10536.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 02:05:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcSN-0007Iq-EZ
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422957AbWJQAE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWJQAE7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:04:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:54246 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422957AbWJQAE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:04:58 -0400
Received: (qmail invoked by alias); 17 Oct 2006 00:04:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 17 Oct 2006 02:04:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610170155.10536.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29001>

Hi,

On Tue, 17 Oct 2006, Jakub Narebski wrote:

> Linus Torvalds wrote:
> >>> About "checkouts", i.e. working directories with repository elsewhere:
> >>> you can use GIT_DIR environmental variable or "git --git-dir" option,
> >>> or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
> >>> "symref"-like file to point to repository passes, we can use that.
> >> 
> >> It sounds like the .gitdir/.git proposal would give Git "checkouts", by
> >> our meaning of the term.
> > 
> > Well, in the git world, it's really just one shared repository that has 
> > separate branch-namespaces, and separate working trees (aka "checkouts"). 
> > So yes, it probably matches what bazaar would call a checkout.
> > 
> > Almost nobody seems to actually use it that way in git - it's mostly more 
> > efficient to just have five different branches in the same working tree, 
> > and switch between them. When you switch between branches in git, git only 
> > rewrites the part of your working tree that actually changed, so switching 
> > is extremely efficient even with a large repo. 
> 
> Unless you have branch(es) with totally different contents, like git.git
> 'todo' branch.

But I _do_ work with it! I just don't need to "checkout" it! Example:

git -p cat-file -p todo:TODO

(How about making git-cat be a short cuut to "git -p cat-file -p"?)

> > So there is seldom any real need or reason to actually have multiple 
> > checkouts. But it certainly _works_.
> 
> But without .git being either symlink, or .git/.gitdir "symref"-link,
> you have to remember what to ser GIT_DIR to, or parameter for --git-dir
> option.

You'd just use alternates for that.

But as Linus mentioned in another email, you mostly can use the _same_ 
working directory. If you want to work on another branch, which is not all 
that different from the current branch (say, you have a bug fix branch on 
top of an upstream branch), you just _switch_ to it. Git recognizes those 
files which are changed, and updates only these. Therefore, if you have 
something like a Makefile system to build the project, you actually save 
(compile) time as compared to the multiple-checkout scenario.

I use this system a lot, since I maintain a few bugfixes for a few 
projects until the bugfixes are applied upstream. BTW the 
multiple-branches-in-one-working-directory workflow was propagated by Jeff 
a long time ago, and it really changed my way of working. Thanks, Jeff!

Ciao,
Dscho
