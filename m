From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Is my repository broken?
Date: Tue, 8 Apr 2008 18:55:22 -0400
Message-ID: <20080408225522.GD10274@spearce.org>
References: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 09 00:56:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjMja-0003DF-AQ
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 00:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbYDHWz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 18:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbYDHWz1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 18:55:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53990 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbYDHWz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 18:55:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JjMig-0007oi-Cd; Tue, 08 Apr 2008 18:55:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9979E20FBAE; Tue,  8 Apr 2008 18:55:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79046>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> [...] In particular I had a number of commits with an empty ident [...]
...
> Also, shouldn't fast-import be imposing the same restrictions on what you 
> are allowed to commit that the main git tools do?  If not, are such 
> restrictions documented so that I can apply them in my conversion script?

Hmm, no.  fast-import allows what the generalized data model permits
in the object store, its really plumbing.  If you are feeding it
an input stream that creates data that isn't compliant with what
the higher level VCS porcelain wants, well, all I can say is "don't
do that".

The fast-import manual specifically warns in the "merge" command
documentation that you may not want to use more than 15 merge
commands, as it can create a commit that other tools based around
git won't like.  But we still let you do it.

We also still let you create a commit with duplicate parents.
Some tools (gitk) have had issues with that in the past, but many of
them have been fixed after a fast-import result was used with them.
From a VCS point of view its silly to list the same ancestor twice.
But from an object model point of view, it may make sense if you
were building something else on top of the core plumbing.

The same holds true for the empty ident.

-- 
Shawn.
