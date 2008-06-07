From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git diff dira dirb file ...
Date: Fri, 6 Jun 2008 20:40:18 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806062024440.19665@iabervon.org>
References: <alpine.LNX.1.00.0806061821320.19665@iabervon.org> <7vmylyqfga.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4mUb-0002Jx-Hp
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbYFGAkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYFGAkV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:40:21 -0400
Received: from iabervon.org ([66.92.72.58]:44479 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbYFGAkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:40:20 -0400
Received: (qmail 1494 invoked by uid 1000); 7 Jun 2008 00:40:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jun 2008 00:40:18 -0000
In-Reply-To: <7vmylyqfga.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84157>

On Fri, 6 Jun 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > After a lot of trying, I finally found something that git diff doesn't 
> > handle. If you've got two trees of files with the same general structure, 
> > even if they aren't at all git-related, you can use:
> >
> > $ git diff dira dirb
> >
> > to get a nice diff between them. But then it would be intuitive and useful 
> > to be able to restrict by path the files within those directories that you 
> > want to compare (much like "git diff origin master file1 file2 ...") with:
> >
> > $ git diff dira dirb file1 file2
> >
> > That would, of course, compare dira/file1 with dirb/file1 and dira/file2 
> > with dirb/file2. Before I start looking into implementing this, is it 
> > incoherent for some reason I'm not seeing?
> 
> Incoherent?
> 
> I do not see anything fundamentally wrong with it, except that command
> line parsing may get tricky, because we rely on the revision command line
> parser, and logically you should be able to spell the above commandline as
> "diff dira dirb -- file1 file2", revision parser wants anything that comes
> before -- to be revisions, not paths.
> 
> Just make sure that you got two directories, at least one of which is
> outside the work tree, mark your diff option as "no-index", then walk the
> two directories in parallel to populate the diff_queue().  Once you are
> done walking, let diffcore_std() to do its usual thing.
> 
> Having said that, that new "feature" is not git anymore, and I'd rather
> wish to see competent git people to be working on hunting for and fixing
> outstanding bugs during the -rc period, than spending their time on new
> features and non-git hacking, but all of us do this as hobbies, so I
> wouldn't stop you ;-)

Actually, that came up in my day job, where I only really get to use git 
to work around the fact that the big commerical version control system 
doesn't make it easy to do stuff. So think of it as testing corner cases 
of the diff machinary on the side, when I can't justify working directly 
on git.

In any case, this goes on my list of things to work on someday.

Do you have a list of outstanding issues for the release?

	-Daniel
*This .sig left intentionally blank*
