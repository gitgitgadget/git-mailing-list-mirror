From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: blameview and file line number
Date: Tue, 30 Jan 2007 10:48:52 -0500
Message-ID: <20070130154852.GA25950@spearce.org>
References: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com> <7vireo52xs.fsf@assigned-by-dhcp.cox.net> <cc723f590701300112x6493a0eaw153aad1a18cd289a@mail.gmail.com> <7vd54w23zh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 30 16:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBvEC-0000Eg-D0
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 16:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbXA3Ps5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 10:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbXA3Ps5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 10:48:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59185 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbXA3Ps4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 10:48:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBvE1-0003Sa-5D; Tue, 30 Jan 2007 10:48:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6BDC620FBAE; Tue, 30 Jan 2007 10:48:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vd54w23zh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38161>

Junio C Hamano <junkio@cox.net> wrote:
> As Linus mentioned, the screen real estate is already wasted by
> too much metainfomation.  Although I do not care too much about
> the UI issue in it since this is only a sample program, showing
> the line number for each line in the final image ($lno) to waste
> more space feels doubly wrong.

Actually including the final image line number is probably something
you want to do in a blame viewer.  When I rework git-gui's blame
UI I'm going to keep the original line number column, but ditch
everything else into some sort of cursor-following-floating window
(Linus' idea).

The reason is, I'll be looking at a line of code in a 5000 line
source file in Eclipse (or vi!) and want to know how it came to be.
I'll go open a blame, but now I have 5000 lines to scan through.

If there's line numbers and a scrollbar, I can binary search to
it relatively quickly.  If there's a text search function, sure I
could try to enter part of the symbol to match, but at that point
I might as well just enter the line number to jump to, especially
if the symbol appears a few times in that file.

So yes, the -L option to git-blame is *very* handy on the command
line.  But I think you already knew that...

I realize that git-gui's blame feature won't be used very often
by the really hard-core developers on this list (you know who you
are) as the command line is simply faster, easier to use, and more
powerful.  Most of the features in git-gui are being created for
people who are a tad bit afraid of a command line and prefer to
point their way through their life with a small rodent shaped device.
Those folks need something like a -L that they can make use of.

> By the way, telling git-gui to annotate revision.h with the
> attached patch was fun to watch.

Yes, especially with its current technicolor interface.  :-)

I just had to go run this, and aside from the rather horrible blame
interface in git-gui, I'm seeing that git-blame is producing data
faster than git-gui can really process it.  This causes the UI to
flash through huge batches of updates.  Probably would be much more
interesting if I disabled the fileevent handler for a few hundred
ms to let the UI catch up.  :-)

-- 
Shawn.
