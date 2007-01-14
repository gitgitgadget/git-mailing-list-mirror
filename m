From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sun, 14 Jan 2007 01:11:20 +0100
Message-ID: <200701140111.20671.Josef.Weidendorfer@gmx.de>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 01:12:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5syf-0000QY-EN
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 01:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXANALx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 19:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbXANALx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 19:11:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:38941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750712AbXANALw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 19:11:52 -0500
Received: (qmail invoked by alias); 14 Jan 2007 00:11:50 -0000
Received: from p5496ACD6.dip0.t-ipconnect.de (EHLO noname) [84.150.172.214]
  by mail.gmx.net (mp001) with SMTP; 14 Jan 2007 01:11:50 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.5
In-Reply-To: <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36782>

On Friday 12 January 2007 21:56, Junio C Hamano wrote:
> This updates five commands (merge, pull, rebase, revert and cherry-pick)
> so that they can be started from a subdirectory.
> 
> This may not actually be what we want to do.  These commands are
> inherently whole-tree operations, and an inexperienced user may
> mistakenly expect a "git pull" from a subdirectory would merge
> only the subdirectory the command started from.

Yes, this IMHO is a problem.

Why not add a general "--top" option to the "git" wrapper,
to temporarily let git change to the toplevel while running
the command?

The wish to allow git-fetch from subdirectories is the
inconvenience to have to cd up, and later down. This is
avoided by running "git --top fetch", and theses people
should be happy.

Yet, if the command outputs some relative paths, the
user is very well aware that these paths are from the
toplevel, as he explicitly specified "--top".

Aside from this, the "--top" options sometimes could
be handy even for other git commands.

And when e.g. git fetch is run from a subdirectory, we
could add to the (now better) error message:

You need to run this command from the toplevel of the working tree.
Alternatively, run "git --top ..." to temporary switch to the
toplevel while running the git command.

Josef
