From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui and scrollbars
Date: Fri, 25 Jan 2008 20:55:40 -0500
Message-ID: <20080126015540.GP24004@spearce.org>
References: <alpine.DEB.1.00.0801251536250.13600@an.sumeria>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Flott <adam@npjh.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 02:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIaHL-0001ka-Vw
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 02:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbYAZBzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 20:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbYAZBzq
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 20:55:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57474 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbYAZBzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 20:55:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JIaGa-0004Rv-7n; Fri, 25 Jan 2008 20:55:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AE65420FBAE; Fri, 25 Jan 2008 20:55:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0801251536250.13600@an.sumeria>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71761>

Adam Flott <adam@npjh.com> wrote:
> Is it possible to have git-gui only show the scrollbars when text is too
> large for the window? Or is this a limitation of TK?

Its possible, but its a PITA in Tk.

There isn't a "hide scrollbars unless needed" option in Tk like
there is say in Java's Swing library.  You have to code up the Tk
procedure to dynamically create (and destroy) the scrollbars as
necessary based upon the associated text widget's extent.

I've done this in the revision picker megawidget that git-gui uses
in the create branch and checkout branch dialogs, but I haven't
done it for the blame window, or the diff window, or the file lists.

It also bit me recently as it seems Tk can delete the associated Tcl
procedure name for the scrollbar widget but still have the window
existing, and then I managed to get another Tk event processed that
wanted to update the scrollbar which was now partially destroyed
(or maybe it was partially created, I'm not sure).  Total suck.

I'm not inclined to do it in those other loctions anytime soon,
as I want to do some other GUI rebuilding work first.  I imagine
I'd try to make the scrollbars hidden when not needed once that
work is completed.  But its certainly a ways off.

-- 
Shawn.
