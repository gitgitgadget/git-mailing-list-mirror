From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: finding earliest tags descended from a given commit
Date: Fri, 26 Jan 2007 23:55:52 -0500
Message-ID: <20070127045552.GB9966@spearce.org>
References: <20070127040618.GA14205@fieldses.org> <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org> <20070127044246.GC14205@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 05:56:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAfbn-0002yL-Lb
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 05:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbXA0E4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 23:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbXA0Ez7
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 23:55:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46742 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbXA0Ez7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 23:55:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAfbJ-0002dY-SC; Fri, 26 Jan 2007 23:55:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CAE4520FBAE; Fri, 26 Jan 2007 23:55:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070127044246.GC14205@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37919>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> That's interesting, I hadn't noticed name-rev before you and Shawn
> mentioned it.
> 
> It only finds one name, though. When I tried it just now on my
> repository what it found was a tag I'd created for an experimental
> version, which probably wouldn't be what I wanted.  (Though it might be,
> in some situations.)

Yea. Hmm.  Maybe name-rev needs to learn a few more tricks, like
favoring annotated tags over non-annotated ones/heads, and being
able to print the top n nearest matches (e.g. 10), by displaying
only one line of output per tag (or ref).

Right now I'm trying to educate describe some more.  Although
similar, describe has a much easier job as its very easy for it to
say "that's the best name we have for the input".  Part of that is
because it is favoring annotated tags all of the time, and part of
that is because it does this distance computation thing now and
always favors the tag with the shortest distance between the tag
and the input.

In the case of name-rev I'm thinking maybe its actually the longest
distance annotated tag that makes sense.  That is, prefer to name
the input using the annotated tag which has the shortest distance
between the tag and the input, but where the tag is the farthest
back in history you can go when compared to any other possible tag,
and yet stills contains the input in its ancestry.

-- 
Shawn.
