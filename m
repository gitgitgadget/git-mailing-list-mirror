From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Naughty, Evil git-gui patches
Date: Sun, 25 May 2008 22:14:13 -0400
Message-ID: <20080526021413.GB29038@spearce.org>
References: <4835A00A.5050207@robertsr.us> <20080522232417.GS29038@spearce.org> <1211521917.832.45.camel@gdub.robertsr.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Barry Roberts <blr@robertsr.us>
X-From: git-owner@vger.kernel.org Mon May 26 04:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0SFN-0002oW-Hc
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 04:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbYEZCOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 22:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYEZCOT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 22:14:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51978 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYEZCOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 22:14:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0SDs-0000qQ-6p; Sun, 25 May 2008 22:14:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A68520FBAE; Sun, 25 May 2008 22:14:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1211521917.832.45.camel@gdub.robertsr.us>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82889>

Barry Roberts <blr@robertsr.us> wrote:
> On Thu, 2008-05-22 at 19:24 -0400, Shawn O. Pearce wrote:
> > 
> > Building a good looking list of stashes would probably require using
> > several columns of text widgets with a single scrollbar.  This is
> > how the blame viewer and gitk are put together.  Its ugly as s**t.
> 
> A simpler option I considered  is just a simple numeric text field in
> the stash commands that are allowed to specify a stash (show, apply,
> drop, pop).  Choosing any of these would just open a dialog with a list
> of stashes and a text field that defaults to 0.  That text field value
> gets put into the stash@{$number}.  Is that too lame to bother
> implementing?  Clearly a list to choose from is more standard UI design,
> I just don't know if it justifies the cost for me.

Good point.  A text field would at least let you select a stash,
but I'm not sure there is much of a point without also having a
way to view the stash's diff.  But that could also just be a text
field to enter a stash.  ;-)
 
> > > 0004 - This is just a concession to (I think) Tortoise.  Just before you 
> > > commit, you notice that you left in a debug message.  This gives us an 
> > > easy way to fix by diff before commit'ing.  This requires setting 
> > > GIT_EXTERNAL_DIFF, or it's not very interesting.

OK.  Your (clipped) explanation makes sense.  I'm not sure
GIT_EXTERNAL_DIFF is the best way to select that program; perhaps
it should be a git-gui specific setting in ~/.gitconfig or something.
 
> What I don't like about my patch now is that it is synchronous.  git-gui
> is locked up waiting for the ediff/winmerge/kdiff3 window to close.
> Plus, then I have to click OK to close the console window.  Hmm. Maybe I
> should look at how you launch gitk.  That seems more appropriate here.

I think the procedure is called do_gitk, but it invokes another Tcl/Tk
process with the path of gitk.  The trick to making it run asynchronous
is to append "&" to the end of the argument list when you call exec:

	exec [list $env(GIT_EXTERNAL_DIFF) $file &]

> > I definately see some value in your bastard patches and would like to
> > work with you to get them into a shape that we can include them.  :-)
> 
> For now, I think the external diff and pull functions would be the
> easiest to clean up.  My stash menu is ugly, and if git-gui's merge is
> forever safer than cmd line git-merge, that's fine with me.  I would be
> interested in your opinion on that prioritization.

Both are useful.  Whatever order you want to work on them in.
I think you are right that the diff and pull work is smaller and
easier to clean up.

-- 
Shawn.
