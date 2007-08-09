From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Wed, 8 Aug 2007 23:26:10 -0400
Message-ID: <20070809032610.GA24573@spearce.org>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com> <Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de> <85lkclrdpr.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 05:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIyfF-00079h-Tg
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 05:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXHID0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 23:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbXHID0S
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 23:26:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34038 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbXHID0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 23:26:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IIyeu-0001oU-B8; Wed, 08 Aug 2007 23:26:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 21AEE20FBAE; Wed,  8 Aug 2007 23:26:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85lkclrdpr.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55404>

David Kastrup <dak@gnu.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > General question: should this not be in git-gui rather than gitk?  Gitk as 
> > of now is really more a viewing tool.
> 
> Well, yes.  But git-gui only works on a single branch head at a time,
> and that is not enough for rebasing.

Sure.  But so does git's command line tools.  They tend to only
work on a single branch at time, the one called `HEAD`.  HEAD is
usually a symref/symlink, in which case such work is actually done
on a different branch, but doesn't have to be.  Oh, and in case
you did not know this, such single head operation *does* support
rebasing.  Bought to you by no less than *three* different flavors
of git-rebase.

So "single branch head at a time" is *not* why git-gui doesn't
support rebase.  Its because nobody has gotten around to writing it.

> It would be really nice if
> git-gui did not outsource its branch handling and viewing to gitk.

I agree, for the very reason that you mention about being able to
drag and drop commit nodes to setup a rebase.  This gets a little
hairy when you want to also drag and drop to create merges, or to
recreate merges, but its still implementable.

I have been considering loading a 'safe' interpreter and throwing
gitk into there, rather than reimplementing its rendering engine
in git-gui.  But I haven't had the time to look into how that would
work, and if there is any benefit to it.
 
> Could git-gui perhaps be merged with giggle at some point of time?

Unlikely.  A while ago I considered "Stay in Tcl/Tk or move to
something more 'powerful/better/faster/Linus friendly'" and stayed
in Tcl/Tk.  I doubt git-gui will leave Tcl/Tk.  giggle is Gtk based.

> Another option might be to let it talk with uDraw(Graph) over a
> socket: uDraw(Graph) keeps track of the graph layout and tells its
> client what has been dragged where.

Interesting.  I had not heard of this tool before.
 
> Rebasing would also be a fine operation for drag and drop on a
> graphical revision history/branch system: pull one head onto another,
> or mark one segment and pull it onto another head.  And use the reflog
> to recover from catastrophes...

Yes, I agree.  I decided that any sort of rebase operation in git-gui
must be *at least* as easy to use/user friendly as `rebase -i` is.
Anything less is just mocking the end-user.  Or something like that.
Anyway, since git-gui is restricted to a graphical interface and
most such interfaces have these pointy rodents available we can do
fancy things like dragging to express what we want to have happen,
instead of moving lines of text around.

Want to write a patch (or series of patches) for git-gui?  ;-)

-- 
Shawn.
