From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 16:09:08 -0500
Message-ID: <4aca3dc20712111309yf43179dh6c43ac84dcaf38e8@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	 <vpq4pepcaz5.fsf@bauges.imag.fr>
	 <alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org>
	 <4aca3dc20712111124y1d9171eem4d2c4f0872703786@mail.gmail.com>
	 <20071211194238.GD20644@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Daniel Berlin" <dberlin@dberlin.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 22:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CMB-0006OZ-Q4
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXLKVJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXLKVJL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:09:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:7438 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbXLKVJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:09:10 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1890145wra
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 13:09:09 -0800 (PST)
Received: by 10.142.52.9 with SMTP id z9mr3930510wfz.1197407348630;
        Tue, 11 Dec 2007 13:09:08 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 13:09:08 -0800 (PST)
In-Reply-To: <20071211194238.GD20644@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67940>

On 12/11/07, Pierre Habouzit <madcoder@debian.org> wrote:
> On Tue, Dec 11, 2007 at 07:24:54PM +0000, Daniel Berlin wrote:
> > On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > >
> > > On Tue, 11 Dec 2007, Matthieu Moy wrote:
> > > >
> > > > I've seen you pointing this kind of examples many times, but is that
> > > > really different from what even SVN does? "svn log drivers/char" will
> > > > also list atomic commits, and give me a filtered view of the global
> > > > log.
> > >
> > > Ok, BK and CVS both got this horribly wrong, which is why I care. Maybe
> > > this is one of the things SVN gets right.
> > >
> > > I seriously doubt it, though. Do you get *history* right, or do you just
> > > get a random list of commits?
> >
> > No, it will get actual history (IE not just things that happen to have
> > that path in the repository)
>
> OTOH svn has the result right, but the way it does that is horrible.
> When you svn log some/path, I think it just (basically) ask svn log for
> each file in that directory, and merge the logs together. This is "easy"
> for svn since it remembers "where this specific file" came from.

What?
We version directories too.
We don't do svn log for each file in the directory when you request a path.
We look at the history of the path, follow renames, etc.

When you change foo/bar/fred.c, we consider it a change to foo/bar and
foo/, and thus, they have new versions.

I'm not sure where you get this crazy notion that we do anything with
files when you ask about directories.
