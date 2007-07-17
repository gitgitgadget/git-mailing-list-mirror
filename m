From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: problem viewing git.git with gitk on cygwin
Date: Mon, 16 Jul 2007 23:14:48 -0400
Message-ID: <20070717031448.GI32566@spearce.org>
References: <200707161330.36907.rayl@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Lehtiniemi <rayl@mail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAdWa-0008NB-1Q
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 05:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370AbXGQDOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 23:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbXGQDOx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 23:14:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59987 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbXGQDOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 23:14:52 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAdWI-0005Qe-NU; Mon, 16 Jul 2007 23:14:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3EA3020FBAE; Mon, 16 Jul 2007 23:14:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707161330.36907.rayl@mail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52735>

Ray Lehtiniemi <rayl@mail.com> wrote:
> i'm seeing a problem with gitk on cygwin.  if i try and view the history of 
> git itself, it seems to stop at version 22dcbb.  interestingly, the next 
> commit 3ef378 has an embedded CTRL-Z character in the commit message.
> 
> possible DOS EOF handling bug? or is there a repo setting i need to be 
> tweaking?
> 
> using git version 1.5.2.2, installed using the cygwin package setup tool.

Not Git's fault; Tcl on Cygwin honors EOF.  Because nobody would
ever put that byte into a data stream.  ;-)

Looks like gitk needs to add -eofchar {} to an fconfigure command
before it reads data from Git.  Otherwise on Windows systems it
just stops reading.  I better do the same to git-gui.  *sigh*

-- 
Shawn.
