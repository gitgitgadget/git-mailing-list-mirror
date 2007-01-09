From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Pushing into a repository with working directory?
Date: Mon, 8 Jan 2007 22:32:13 -0500
Message-ID: <20070109033213.GC1904@spearce.org>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org> <7vwt41j1le.fsf@assigned-by-dhcp.cox.net> <20070105193646.GC8753@spearce.org> <45A24CE6.5060201@shadowen.org> <7vd55pt3ts.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 04:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H47io-0000SB-8Y
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 04:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXAIDcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 22:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbXAIDcT
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 22:32:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48473 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXAIDcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 22:32:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H47iW-00004r-EI; Mon, 08 Jan 2007 22:32:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0DD3E20FBAE; Mon,  8 Jan 2007 22:32:13 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd55pt3ts.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36303>

Junio C Hamano <junkio@cox.net> wrote:
> However, I am not sure if that is easy to understand for the
> users.  It would be sane to deny pushing into the current branch
> for a non-bare repositories by default, and if we do allow it
> (perhaps with 'git-push --force'), then detach the HEAD as you
> suggest.  On the other hand, pushing into the current branch of
> a bare repository should just work; the HEAD pointer in a bare
> repository is not about the commit the index and the working
> tree are based on, but which branch is the primary branch of the
> repository.

But from the working directory management tools' perspective HEAD
*is* about the current index and the current working directory.
If HEAD doesn't match the index and working directory closely
enough then the user is going to do something stupid, like commit
a negative delta by accident.

Pushing into the current branch of a repository with a working
directory probably shouldn't be allowed by default as users probably
don't want to do that.  But if --force is used then detaching the
HEAD is probably the best idea.  The user could easily recover by
doing `git checkout origbranch` (though they may need `git checkout
-m origbranch` if their working directory was dirty).

-- 
Shawn.
