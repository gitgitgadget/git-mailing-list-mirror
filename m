From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit ID in exported Tar Ball
Date: Wed, 23 May 2007 01:22:20 -0400
Message-ID: <20070523052220.GC28023@spearce.org>
References: <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <46502EF7.6000708@lsrfire.ath.cx> <20070521060231.GI3141@spearce.org> <4651F908.2000608@lsrfire.ath.cx> <46536E32.6000202@lsrfire.ath.cx> <7vd50s79lg.fsf@assigned-by-dhcp.cox.net> <46538065.9080705@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 23 07:23:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqjJO-0006d9-Q7
	for gcvg-git@gmane.org; Wed, 23 May 2007 07:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220AbXEWFW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 01:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756235AbXEWFW5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 01:22:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46251 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220AbXEWFW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 01:22:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HqjIk-0003Me-GZ; Wed, 23 May 2007 01:22:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6BEBB20FBAE; Wed, 23 May 2007 01:22:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46538065.9080705@lsrfire.ath.cx>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48140>

Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> $Id$ (and $commit$) is reversible, @@COMMITID@@ is not.  That means you
> can create a synthetic file byte for byte with @@COMMITID@@ (and its not
> yet implemented brethren), but you can't do that with $Id$ -- it's
> impossible to get rid of the dollar signs.

Yes, and that's one of the big problems with the $Id$ syntax so
commonly used by versioning systems.  Most files you want to insert
that automatic id into want a clean id string, not something that
starts with $Id: and ends with $...

Since we are apparently supporting $Foo: ...$ to collapse back to
$Foo$ reusing that syntax for git-archive is actually probably a
bad idea.  We should support the checkout filters in git-archive (as
much as possible anyway) but what this thread has been going on is
something quite different...  so we probably want a different syntax.
Which is why I'm also in favor of the @@COMMITID@@ syntax...
 
> >  (1) introduce "const unsigned char commit_in_focus[20]",
> >      globally available to git suite, and clear it at the
> >      beginning of main();
> 
> Ugh.  Requiring another global variable doesn't smell like good design.

I agree.  We already have a lot of globals.  We need another one like
we need a hole in the head.  Especially a global like this one... ;-)
 
> Do we want git-archive specific one-way conversions that are capable of
> creating files like git.spec?  Or is this just a shiny toy hypnotizing
> me? 8-)

But aren't shiny toys fun?  ;-)

-- 
Shawn.
