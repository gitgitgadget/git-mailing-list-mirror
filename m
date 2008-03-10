From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can it be done in Git?
Date: Mon, 10 Mar 2008 18:43:18 -0400
Message-ID: <20080310224318.GC8410@spearce.org>
References: <200803091459.21354.jnareb@gmail.com> <3838F28A-DB0C-4678-BA57-3344E2225889@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 23:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYqjS-0004RU-4A
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 23:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYCJWnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 18:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbYCJWnY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 18:43:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36056 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYCJWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 18:43:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYqi5-00075F-Sl; Mon, 10 Mar 2008 18:43:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A12E20FBAE; Mon, 10 Mar 2008 18:43:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <3838F28A-DB0C-4678-BA57-3344E2225889@adacore.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76764>

Geert Bosch <bosch@adacore.com> wrote:
> On Mar 9, 2008, at 09:59, Jakub Narebski wrote:
> 
> >This extension[3][4] optimises "hg status" command by asking file
> >notification daemon about changed files instead of doing stat. I'm not
> >sure how useful this extension is: inotify is Linux specific, and  
> >Linux
> >has fast stat... nevertheless this is one example where extension
> >(plug-in) framework shows that it can do more than good scriptability.
> 
> FWIW, OS X 10.5 has a similar functionality, called "fsevents",
> as well as a much slower stat.

Windows NT on NTFS has a file monitor system that works somewhat
like an inotify, but different enough that you gotta write totally
different code for it.  It also has a much slower stat.

I have wanted to put something like this into git-gui, so that a
running git-gui session can see changes made to your working dir
"live".  But I haven't gotten around to writing it.  I did do some
early experiments on Windows NT + NTFS with a small C daemon that
watches the working directory, but it ran into issues about also
need to know what is inside .gitignore to properly avoid sending
events that git-gui doesn't want to know about.  Like say build
object files.  :-)

I think the reason Git has never had such an "extension" is we are
just that freaking fast when it comes to comparing the working tree
to the index.  hg wasn't in the early days and that may have been
what gave rise to the plugin.

-- 
Shawn.
