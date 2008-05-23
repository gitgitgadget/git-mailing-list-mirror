From: Barry Roberts <blr@robertsr.us>
Subject: Re: Naughty, Evil git-gui patches
Date: Thu, 22 May 2008 23:51:57 -0600
Message-ID: <1211521917.832.45.camel@gdub.robertsr.us>
References: <4835A00A.5050207@robertsr.us>
	 <20080522232417.GS29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 23 07:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzQD4-0007G7-1o
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 07:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYEWFwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 01:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYEWFwA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 01:52:00 -0400
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:36776 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262AbYEWFv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 01:51:59 -0400
Received: from OMTA09.emeryville.ca.mail.comcast.net ([76.96.30.20])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id UsY81Z0050S2fkCA204300; Fri, 23 May 2008 05:51:59 +0000
Received: from [172.30.4.99] ([76.27.51.25])
	by OMTA09.emeryville.ca.mail.comcast.net with comcast
	id Utry1Z0020YdJok8V00000; Fri, 23 May 2008 05:51:59 +0000
X-Authority-Analysis: v=1.0 c=1 a=vcssKA4Gl2pEOSy8NroA:9
 a=ETzJDrD7EeVGAgjQ90AA:7 a=yS9Vl3h6qQjuFibAYvOSX21SHQAA:4 a=WuK_CZDBSqoA:10
In-Reply-To: <20080522232417.GS29038@spearce.org>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82681>


On Thu, 2008-05-22 at 19:24 -0400, Shawn O. Pearce wrote:
> Hah!  Do you know why git-gui came along?  Because it was written as
> an emergency measure to allow a transition from no version control
> at all to git at my day-job.  :-)

Necessity, invention.

> > 0002 - I have read the reasons for having merge in the gui be more 
> > strict than 'git merge' from the command line, but 'cvs update' never 
> > gave a clean way to back out, so nobody here expects that anyway.
> 
> Maybe its just the way my brain works these days with git, but I
> have never found the refusal to merge with a dirty working directory
> to be a limitation.  I usually either don't have a dirty working
> directory, or I stash into a temporary branch and switch back to
> do the merge, then rebase or cherry-pick.  Yea, that does mean I
> fall back to the command line in such cases.  Git Gui only users
> don't have that option.
> 
> Once you get used to the idea of being able to recover your old
> state after a merge has started (or even finished!) though the
> idea of a dirty merge just sends chills down my spine.  Its a
> really bad idea.  IMHO its like holding a loaded gun to your foot
> and pulling the trigger every time you do a merge.  After a while
> you run out of toes and have lost something you cared about.

I agree.  I regard this one as transitional.  People used to thinking in
CVS have a hard time letting go.  My plan for this was to maintain a
local patch until the developers I work with are properly trained, and
then drop it.  But, it's Free Software, so if other folks have the same
pain, it's in the mail archive now.

> > 0003 -  Yeah, I want to list the stashes and select from available 
> > stashes to apply.  But this does the 80% of what we need (reducing 
> > command line usage), and my tcl sk1llz aren't that l33t.
> 
> Building a good looking list of stashes would probably require using
> several columns of text widgets with a single scrollbar.  This is
> how the blame viewer and gitk are put together.  Its ugly as s**t.

When I get time, I still plan to look at it.  But if my Windows using
colleagues don't complain, it may not happen.

A simpler option I considered  is just a simple numeric text field in
the stash commands that are allowed to specify a stash (show, apply,
drop, pop).  Choosing any of these would just open a dialog with a list
of stashes and a text field that defaults to 0.  That text field value
gets put into the stash@{$number}.  Is that too lame to bother
implementing?  Clearly a list to choose from is more standard UI design,
I just don't know if it justifies the cost for me.

>  
> > 0004 - This is just a concession to (I think) Tortoise.  Just before you 
> > commit, you notice that you left in a debug message.  This gives us an 
> > easy way to fix by diff before commit'ing.  This requires setting 
> > GIT_EXTERNAL_DIFF, or it's not very interesting.
> 
> I'm not sure I understand this.  Are you trying to get a diff for
> the entire working directory against the staged files in the index?
> As opposed to looking at each file individually?  What is your
> external diff program able to show that git-gui's internal diff
> viewer does not?

The intent is to edit one file at time to clean up before committing.
The external diff doesn't show anything different, it just lets you
edit.  I use emacs/ediff, win users use winmerge or kdiff3.  So it's
poorly named, but that was the git feature I used. The Tortoise (or
maybe WinCVS) scenario that I'm trying to enable is this:

As I'm staging files for commit, I notice I left in a debug message or
test code that shouldn't be committed, and I want to get rid of in the
file in the working directory.  With that file selected in the "Unstaged
Changes" box, I select "External Diff" from "Commit" menu (at least
that's where it is now).  For me that opens an ediff with my modified
file and the previous version so I can easily remove things I don't want
to commit.  Save, exit, Rescan (necessary?), stage, commit.

Another option I considered was adding to the context menu in the diff
box to revert a hunk in the file.  But sometimes the changes aren't
exactly hunks and you want an editor to, say, just change one line in a
hunk.

What I don't like about my patch now is that it is synchronous.  git-gui
is locked up waiting for the ediff/winmerge/kdiff3 window to close.
Plus, then I have to click OK to close the console window.  Hmm. Maybe I
should look at how you launch gitk.  That seems more appropriate here.


> I'm not objecting to supporting GIT_EXTERNAL_DIFF, I just want to
> better understand what you are trying to accomplish here so we can
> make sure its the _right_ support.

I'm positive there's room for improvement.
 

> I definately see some value in your bastard patches and would like to
> work with you to get them into a shape that we can include them.  :-)

For now, I think the external diff and pull functions would be the
easiest to clean up.  My stash menu is ugly, and if git-gui's merge is
forever safer than cmd line git-merge, that's fine with me.  I would be
interested in your opinion on that prioritization.

Now I get to go play with git and figure out how to disentangle the
mixed stash and merge stuff in patch #2.  That'll be fun.

Thanks,
Barry
