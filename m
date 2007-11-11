From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk/git-gui misfeature: saving the geometry can the window out of reach
Date: Sun, 11 Nov 2007 05:44:08 -0500
Message-ID: <20071111104407.GY14735@spearce.org>
References: <63F7323C-D90A-4F5E-AE3C-8937455972FD@lrde.epita.fr> <20071111051128.GS14735@spearce.org> <8700373A-4878-4EBD-BA27-D4F31BE44907@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:44:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrAIp-0005Z2-AB
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 11:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbXKKKoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 05:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbXKKKoM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 05:44:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46465 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbXKKKoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 05:44:12 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IrAIS-0005js-R6; Sun, 11 Nov 2007 05:44:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7F25420FBAE; Sun, 11 Nov 2007 05:44:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <8700373A-4878-4EBD-BA27-D4F31BE44907@lrde.epita.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64442>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> On Nov 11, 2007, at 6:11 AM, Shawn O. Pearce wrote:
> >Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> >>gitk (and I think git-gui too) save their "geometry" (which includes
> >>X/Y position) in ~/.gitk.  So far so good.  The problem is that I
> >>often use 2 screens at work (one is the screen of my laptop, the
> >>other one is above) and I happen to put my gitk/git-gui windows on
> >>the 2nd screen.  When I go back home, I don't have a second screen
> >>and gitk/git-gui open their windows out of reach.
> >
> >Actually git-gui saves the geometry to .git/config so I'm not sure
> >why the sed line above would correct git-gui's display issues.  But I
> >have also noticed this problem on my Mac OS X laptop when running
> >again after leaving either git-gui or gitk on the external display.
> 
> it's been a long time since I last used Tcl/Tk but if you give me a  
> hint as to where to look / what should be done, I can give it a try.

Look in git-gui.sh for "-- Load geometry"; in my current master
it is on line 2625.  This is the block where we have taken the
geometry data back in from .git/config and are trying to update
the UI to match what it says.  Unfortunately we set a coordinate
that is off the desktop using a standard X geometry string in the
"wm geometry . [lindex $gm 0]" call...

-- 
Shawn.
