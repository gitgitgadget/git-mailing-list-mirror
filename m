From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: '.git file' alternative, native (cross-platform) workdir
 support.
Date: Fri, 29 Feb 2008 12:54:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291248510.22527@racer.site>
References: <47C7FA49.9010001@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 13:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV4lq-00085b-Uy
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 13:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbYB2Myt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 07:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYB2Mys
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 07:54:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:47880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753530AbYB2Mys (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 07:54:48 -0500
Received: (qmail invoked by alias); 29 Feb 2008 12:54:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 29 Feb 2008 13:54:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YqaAl7bkYkRUUx3ZpM/NSDQf9TscaCJPK2HDoQF
	5JYu2ojyGP9S26
X-X-Sender: gene099@racer.site
In-Reply-To: <47C7FA49.9010001@trolltech.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75530>

Hi,

On Fri, 29 Feb 2008, Marius Storm-Olsen wrote:

> I just caught a glimpse of the '.git file' efforts, as a file for 
> redirection to a real repository.
> 
> As far as I can tell, the reason for adding the support is to in the end 
> provide a cross-platform way of supporting workdirs. (If this is not the 
> [main] point, please point me to the thread describing the real reason, 
> I couldn't find it.)

This is the main reason, yes.

However, you can also use the .git file to separate the working directory 
from the repository, say, on two different drives, when you do not have 
symbolic links.

> However, wouldn't simply redirecting everything into a real repo then 
> create problems with shared index file and more? A problem which could 
> be tacled by file suffixes or other methods, I'm sure, but which would 
> require even more patches to achieve the goal.

Not only would it requre these patches, but it would actually make a 
_safe_ multiple-workdirs feature possible.

ATM the problem is that you can change a ref that is checked out 
elsewhere, and if you are not a Git expert, it will just make your life 
miserable.

However, if we do not pretend to have different repositories, but actually 
use the _identical_ repository for multiple working directories, we can 
make the mechanisms safe!

This is basically the reason why I do not like the current new-workdir 
script (and the patch in my private tree where I taught git-branch about 
it).

So while your approach may seem easier in the short run, there is no way 
you can make it safe.  No way, except going the full nine yards, and 
actually use the same repository, which means that you have to have the 
"other patches", too.

Ciao,
Dscho

