From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:33:27 -0400
Message-ID: <20071019033327.GF14735@spearce.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182251110.19446@xanadu.home> <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiicN-0000tE-5S
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654AbXJSDdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758284AbXJSDdg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:33:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44976 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758280AbXJSDdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:33:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iiibp-0002HT-4h; Thu, 18 Oct 2007 23:33:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6571020FBAE; Thu, 18 Oct 2007 23:33:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61633>

Nicolas Pitre <nico@cam.org> wrote:
> Frankly, I think effort should be spent on the refs update display at 
> this point.  Something that looks like:
> 
> * refs/heads/origin: fast forward to branch 'master' of git://gi
> t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>   old..new: 66ffb04..4fa4d23
> 
> [ note that I arbitrarily cut the long line before the 80th column to 
>   show the effect within an email ]
> 
> You usually get long lines that gets wrapped, so that means 3 lines of 
> screen space for one updated branches.  Is the "66ffb04..4fa4d23" 
> information really useful?  Might someone ever care?

The reason its formatted the way it is today is someone can grab
that line into a copy-paste buffer and throw it onto a "git-log"
or "gitk" command line with ease to see what new stuff has come in.

Me, I just use the reflog if I care (`origin@{1}..origin`) to see
what a fetch changed in the tracking branch.

However I *don't* need the remote branch name or the remote URL,
especially if we are storing it into a tracking branch.  That's most
likely coming from a configured remote that the user fetches from
frequently.  I don't think about Linus' URL, I think about the fact
that in my linux-2.6 repository his directory is my origin remote.

Maybe something like this would be more useful:

 * origin: fast-forwarded: 66ffb04..4fa4d23

Or if you are using refs/remotes style tracking branches:

 * origin/master: fast-forwarded: 66ffb04..4fa4d23
 * origin/pu: forcing update: 66ffb04..4fa4d23

Too terse?  Yea, probably.  But it is a whole lot shorter.


My other pet peeve here is the display from send-pack and
receive-pack when you push a ref.  Hello?

  updating 'refs/heads/master'
    from de61e42b539ffbd28d2a2ba827bb0eb79767057b
    to   d7e56dbc4f60f6bd238e8612783541d89f006fb7
  ...
  refs/heads/master: de61e42b539ffbd28d2a2ba827bb0eb79767057b -> d7e56dbc4f60f6bd238e8612783541d89f006fb7

That's like 4 too many SHA-1 strings for the average user.

-- 
Shawn.
