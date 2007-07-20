From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Another question about importing SVN with fast-import
Date: Fri, 20 Jul 2007 01:11:42 -0400
Message-ID: <20070720051142.GO32566@spearce.org>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk> <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: David Frech <david@nimblemachines.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 07:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBkmS-0000c2-4f
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbXGTFLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbXGTFLx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:11:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49708 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbXGTFLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 01:11:52 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBkmG-0002D4-Jf; Fri, 20 Jul 2007 01:11:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4008520FBAE; Fri, 20 Jul 2007 01:11:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53054>

David Frech <david@nimblemachines.com> wrote:
> On 7/16/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> >Now the question.  Shawn recently added C and R operations - almost as
> >soon as they were asked for too.  However, how do you copy a file from a
> >particular revision?
> 
> I have to second Julian's question.

I'm getting to it.  Maybe this weekend.  Right now I have git-gui
work to finish, and that work is more important to me this week than
fast-import is.  Not that fast-import isn't important to me either,
its just the way things are this week.
 
> This is kind of a request and a comment/question. The request is:
> there is no way to do *reasonably* in the front end what fast-import
> can do somewhat reasonably: namely, copy a <path> (file or directory!)
> from an arbitrary previously committed revision/mark to the current
> branch.

I agree.
 
> The comment/question is: how different is this, really, from being
> able to  specify a "from" line in a commit? In both cases I'm asking
> fast-import to reach into its memory (or the repo) and pull out a
> tree, and to add (some or all of it) to my current branch. Isn't the
> kind of generic C command that Julian and I are asking for the same
> thing, only instead of taking the whole tree (from the specified
> commit) it takes a single file or directory?

It is possible.  I'm just not sure what the syntax for it should be.
Suggestions?  I really want to stay backwards compatible with the
current "C" command, so:

	'C' SP commit SP path SP path

is out because its ambiguous with the current meaning where the
second (destination) path can contain SP without being quoted by
the frontend.

> Lastly, do we really need "R"? With this generic copy - and I think
> there should be *only* a generic version, not a "streamlined local
> copy" version and a "reach into history arbitrarily" version - we can,
> as an earlier poster pointed out, do R by doing a C and then a D. This
> is, in fact, how svn dump files represent file and directory renames.

The code for "R" is so short that I just don't see a need to remove it.
Its also already out in the wild, as it has been in Junio's master for
a little while now.
 
-- 
Shawn.
