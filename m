From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: problem pushing repository
Date: Sun, 24 Jun 2007 19:47:59 -0400
Message-ID: <20070624234759.GO17393@spearce.org>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com> <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com> <20070622022426.GA2961@bowser.ruder> <1182496916.6207.11.camel@localhost> <Pine.LNX.4.64.0706221224310.4059@racer.site> <1182519484.6207.38.camel@localhost> <20070622224712.GI17393@spearce.org> <1182593536.5937.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Ruder <andy@aeruder.net>, git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 01:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2boU-0006Ep-4M
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 01:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXFXXsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 19:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbXFXXsG
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 19:48:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49595 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbXFXXsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 19:48:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I2bo7-0002JA-6O; Sun, 24 Jun 2007 19:47:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 74A3020FBAE; Sun, 24 Jun 2007 19:47:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1182593536.5937.14.camel@localhost>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50847>

Raimund Bauer <ray007@gmx.net> wrote:
> On Fri, 2007-06-22 at 18:47 -0400, Shawn O. Pearce wrote:
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > ---
> >  contrib/completion/git-completion.bash |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Thanks a lot, your patch makes my life easier.
> Since you obviously know what you're doing here, maybe I can wish for
> something too?

Heh, sure.  I wrote that "stock" bash completion package, but at
this point I largely consider it to be "complete and stable" and
therefore don't put a lot of effort into it anymore.

This recent thread has been interesting, as it has uncovered two
bugs related to the git-push completion.
 
> It would be really cool if completion also worked when I started the
> branchname with a '+' to force the push ...

How does this work?  ;-)

I'm pushing it out to my fastimport tree shortly.

-->8--
Teach bash how to complete +refspec on git-push

Using `git push origin +foo` to forcefully overwrite the remote
branch named foo is a common idiom, especially since + is shorter
than the long option --force and can be specified on a per-branch
basis.

We now complete `git push origin +foo` just like we do the standard
`git push origin foo`.  The leading + on a branch refspec does not
alter the completion.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c7c9963..f2b10fa 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -682,6 +682,9 @@ _git_push ()
 			esac
 			__gitcomp "$(__git_refs "$remote")" "" "${cur#*:}"
 			;;
+		+*)
+			__gitcomp "$(__git_refs)" + "${cur#+}"
+			;;
 		*)
 			__gitcomp "$(__git_refs)"
 			;;
-- 
1.5.2.2.1334.g1625


-- 
Shawn.
