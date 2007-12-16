From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Problem with git-svn
Date: Sun, 16 Dec 2007 14:56:25 +0100
Message-ID: <20071216135625.GB4999@xp.machine.xx>
References: <4764FE2C.1010103@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Dec 16 14:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3tzD-00055Z-2A
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 14:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbXLPN4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 08:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbXLPN4a
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 08:56:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:50112 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751336AbXLPN43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 08:56:29 -0500
Received: (qmail invoked by alias); 16 Dec 2007 13:56:27 -0000
Received: from p54AAB2DC.dip0.t-ipconnect.de (EHLO localhost) [84.170.178.220]
  by mail.gmx.net (mp051) with SMTP; 16 Dec 2007 14:56:27 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+bRVFMJiSbqfNS5AMLTD0YAs2ywAFkaB9ThtF2HG
	ZfcBx23eoQxl8/
Content-Disposition: inline
In-Reply-To: <4764FE2C.1010103@obry.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68459>

On Sun, Dec 16, 2007 at 11:30:04AM +0100, Pascal Obry wrote:
> 
> I'm trying to use a Subversion repository with Git. I had
> great success with many repositories except one. This one
> live since long time and as been migrated from CVS to
> Subversion.
> 
> The current Subversion repository contains multiple projects.
> Each project is under /trunk. While trying to import the project
> PROJ:
> 
>   $ git svn clone svn+ssh://myserver/trunk/PROJ
> 
> I get:
> 
> Initialized empty Git repository in .git/
> W: Ignoring error from SVN, path probably does not exist: (160013):
> Filesystem has no item: File not found: revision 100, path '/trunk/PROJ'
> Found possible branch point: svn+ssh://myserver/importfromcvs/trunk =>
> svn+ssh://myserver/trunk/PROJ, 48467
> Initializing parent: git-svn@48467
> W: Ignoring error from SVN, path probably does not exist: (160013):
> Filesystem has no item: File not found: revision 101, path
> '/importfromcvs/trunk'
> r9458 = b90789186c85a19a9f32ea6dc8a4259e2eadef67 (git-svn@48467)
>         A       file.el
> 
> But file.el is not part of this project, it is part of another one
> on the same Subversion repository. It looks like git-svn get confused
> at some point. I've been trying to track this down, but since I've
> never written a single Perl script that's not easy :(
> 
> Note that AFAIK each CVS modules have been imported into
> /importfromcvs/trunk then move into /trunk/<MODULE_NAME>.
> 
> r48467 seem ok as a branch point:
> 
> <<
> ------------------------------------------------------------------------
> r48468 | svn | 2007-05-09 15:10:54 +0200 (Wed, 09 May 2007) | 1 line
> Changed paths:
>    D /importfromcvs/trunk
>    A /trunk/PROJ (from /importfromcvs/trunk:48467)
> 
> Importing module PROJ into SVN.
> >>
> 
> So I'm looking for hints about the possible problem.
> 
> Note that I have tried to reproduce this with a small
> script (using the same repository structure) but I was
> not able.
> 
> Thanks,
> Pascal.
> 

Eric made a fix[1] this week so git-svn won't get confused if e.g. trunk
gets deleted and later created (or e.g. moved). Could you check if it
also fixes your problem? At least there is some familiarity, because your
trunk/PROJ also get moved from outside a path git-svn isn't tracking.

-Peter

[1]: See this thread for more details
     http://thread.gmane.org/gmane.comp.version-control.git/67665
