From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problem with git-svn
Date: Wed, 19 Dec 2007 00:27:51 -0800
Message-ID: <20071219082751.GA17787@muzzle>
References: <4764FE2C.1010103@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 09:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4uHo-0001cx-GD
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 09:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbXLSI1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 03:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXLSI1x
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 03:27:53 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39596 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbXLSI1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 03:27:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D347C7DC122;
	Wed, 19 Dec 2007 00:27:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4764FE2C.1010103@obry.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68864>

Pascal Obry <pascal@obry.net> wrote:
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

Hi,

Can you show me the output of `svn log -v -r9458 svn+ssh://myserver/' ?

Thanks.

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

So did svn+ssh://importfromcvs/trunk/file.el at r9458?  If so, git-svn
is behaving as expected.  If not, can you tell me where "file.el" was at
r9458?

> 
> So I'm looking for hints about the possible problem.
> 
> Note that I have tried to reproduce this with a small
> script (using the same repository structure) but I was
> not able.

-- 
Eric Wong
