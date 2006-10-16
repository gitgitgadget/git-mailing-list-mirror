From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 16:35:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 01:36:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZc0D-0002Y7-Gb
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 01:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWJPXgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 19:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWJPXgK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 19:36:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750814AbWJPXgG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 19:36:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GNZtaX032202
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 16:35:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GNZrQl000301;
	Mon, 16 Oct 2006 16:35:54 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45340713.6000707@utoronto.ca>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28995>



On Mon, 16 Oct 2006, Aaron Bentley wrote:
> 
> Bazaar's namespace is "simple" because all branches can be named by a
> URL, and all revisions can be named by a URL + a number.
> 
> If that's true of Git, then it certainly has a simple namespace.  Using
> eight-digit hex values doesn't sound simple to me, though.

Hey, "simple" is in the eye of the beholder. You can always just define 
Bazaar's naming convention to be simple. 

I pretty much _guarantee_ that a "number" is not a valid way to uniquely 
name a revision in a distributed environment, though. I bet the "number" 
really only names a revision in one _single_ repository, right?

Which measn that it's actually not a "name" of the revision at all. It's 
just a local shorthand that has no meaning, and the exact same revision 
will be called something different when in somebody elses repository.

I wouldn't call that "simple". I'd call it "insane".

In contrast, in git, a revision is a revision is a revision. If you give 
the SHA1 name, it's well-defined even between different repositories, and 
you can tell somebody that "revision XYZ is when the problem started", and 
they'll know _exactly_ which revision it is, even if they don't have your 
particular repository.

Now _that_ is true simplicity. It does automatically mean that the names 
are a bit longer, but in this case, "longer" really _does_ mean "simpler".

If you want a short, human-readable name, you _tag_ it. It takes all of a 
hundredth of a second to to or so.

> > I'm not sure about "No" in "Supports Repository". Git supports multiple
> > branches in one repository, and what's better supports development using
> > multiple branches, but cannot for example do a diff or a cherry-pick
> > between repositories (well, you can use git-format-patch/git-am to
> > cherry-pick changes between repositories...).
> 
> That sounds right.  So those branches are persistent, and can be worked
> on independently?

Yes.

> > About "checkouts", i.e. working directories with repository elsewhere:
> > you can use GIT_DIR environmental variable or "git --git-dir" option,
> > or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
> > "symref"-like file to point to repository passes, we can use that.
> 
> It sounds like the .gitdir/.git proposal would give Git "checkouts", by
> our meaning of the term.

Well, in the git world, it's really just one shared repository that has 
separate branch-namespaces, and separate working trees (aka "checkouts"). 
So yes, it probably matches what bazaar would call a checkout.

Almost nobody seems to actually use it that way in git - it's mostly more 
efficient to just have five different branches in the same working tree, 
and switch between them. When you switch between branches in git, git only 
rewrites the part of your working tree that actually changed, so switching 
is extremely efficient even with a large repo. 

So there is seldom any real need or reason to actually have multiple 
checkouts. But it certainly _works_.

> You'll note we referred to that bevhavior on the page.  We don't think
> what Git does is the same as supporting renames.  AIUI, some Git users
> feel the same way.

The fact is, git supports renames better than just about anybody else. It 
just does them technically differently. The fact that it happens to be the 
_right_ way, and everybody else is incompetent, is not my fault ;)

			Linus
