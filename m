From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Trouble with gitk and ActiveState tcltk on OS X
Date: Sun, 10 Feb 2008 23:49:41 -0500
Message-ID: <20080211044941.GX24004@spearce.org>
References: <m2ve4wh5sx.fsf@ziti.evri.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Seth Falcon <seth@userprimary.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOQcT-00014p-Bs
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 05:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbYBKEtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 23:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYBKEtq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 23:49:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59594 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbYBKEtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 23:49:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JOQbi-0000lS-To; Sun, 10 Feb 2008 23:49:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E41E520FBAE; Sun, 10 Feb 2008 23:49:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <m2ve4wh5sx.fsf@ziti.evri.corp>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73465>

Seth Falcon <seth@userprimary.net> wrote:
> I'm hoping that another OS X git user can point me in the right
> direction...
> 
> I installed the ActiveState tcltk and set the following in
> git/config.mak:
> 
>     TCLTK_PATH=/usr/local/bin/wish8.5
> 
> With this, git gui works great (I get a real icon when switching apps
> and the overall look is more consistent than when I was running with
> X11 + MacPorts tcltk).

For what its worth I use the native Tcl/Tk that ships with Mac OS X,
/usr/bin/wish, which is really in /Library/Frameworks/Tk.framework.
I've never used the ActiveState Tcl/Tk package on Mac OS X.

git-gui builds against the Tk.framework I mentioned above when on
Mac OS X.  In particular the git-gui Makefile seems to ignore the
setting of TCLTK_PATH when it sees the above mentioned Tk.framework
is available in your filesystem.

The reason why you get nice icons for git-gui is because we use a
feature of the Aqua port Tcl/Tk framework that allows us to create a
full Mac OS X app by copying a tiny executable from the framework,
and supplying our own resource bundle.  The bundle configures
the icon.  Its the only way to get a custom icon on Mac OS X.

Launching gitk from within git-gui (Repository -> Visualize History)
uses the same app and bundle, so gitk inherits the icon too.
I'd also bet gitk works this way, because it isn't launching through
the ActiveState Tcl/Tk port.

In short, why not just use the native Aqua Tcl/Tk that Apple ships?
Why go through X11 and MacPorts?
 
-- 
Shawn.
