From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: An idea: maybe Git should use a lock/unlock file mode for
 problematic files? [Was: Re: after first git clone of linux kernel repository
 there are changed files in working dir]
Date: Tue, 20 Jan 2009 17:08:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901201651050.19665@iabervon.org>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>  <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>  <83ocy3fmez.fsf@kalahari.s2.org>  <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>  <alpine.LNX.1.00.0901201441480.19665@iabervon.org>
 <1232486929.4179.7.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hannu Koivisto <azure@iki.fi>, rdkrsr <rdkrsr@googlemail.com>,
	git@vger.kernel.org
To: John Chapman <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:10:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPOnL-0002pC-IX
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbZATWIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbZATWIY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:08:24 -0500
Received: from iabervon.org ([66.92.72.58]:50837 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756072AbZATWIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:08:22 -0500
Received: (qmail 15365 invoked by uid 1000); 20 Jan 2009 22:08:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jan 2009 22:08:21 -0000
In-Reply-To: <1232486929.4179.7.camel@therock.nsw.bigpond.net.au>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106527>

On Wed, 21 Jan 2009, John Chapman wrote:

> On Tue, 2009-01-20 at 15:11 -0500, Daniel Barkalow wrote:
> <snip>
> > 
> > The hard part is actually identifying what the user's filesystem has done. 
> > There's pretty good internal support for git knowing that, for a 
> > particular entry, the filesystem should not be consulted for information. 
> > I don't think anyone's come up with a suitably cross-platform and 
> > automatic way to figure out what's happened when git tries to write to a 
> > particular filename and the system decides it is the same as some other 
> > filename or it decides to use a different filename instead.
> 
> This would only need to interact with the git status command, wouldn't
> it?

The information is needed in a bunch of commands (diff and add, for 
example), but I believe that's already taken care on. The problem is 
getting it set automatically instead of having git not notice that the 
filesystem isn't doing what it expects.

> > Of course, it is reasonably likely that a project whose files can't all be 
> > checked out can't be dealt with anyway on that platform (IIRC, the Linux 
> > kernel build system assumes that it can create both .S and .s files, so it 
> > won't build on FAT). So nobody's been sufficiently motivated to try to 
> > implement a fix.
> 
> I doubt the kernel builds on windows, but this would allow a windows
> user to modify such files, perhaps in preparation for a patch that does
> allow the kernel to be built on windows?
> (Of course, we're using the kernel here as an example, right?  Nobody
> would be insane as to want to use windows for that!)
> 
> See, a very annoying thing about windows is that it is quite simple for
> a team to commit two files that differ by case alone to a git
> repository.

My impression was that this didn't happen in practice, because teams
would tend to not have two people create the same file at the same time, 
but with different cases, and people interacting with the same file at 
different times would use whatever case it was introduced with.

I think I'd only heard about problems for people who were using 
filesystems with different properties than what the rest of the developers 
on the project were using.

But I've only ever worked on projects that expect case-sensitivity, and 
mostly on projects that have a standard style that prevents duplication.

	-Daniel
*This .sig left intentionally blank*
