From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Shared repositories and umask
Date: Wed, 15 Feb 2006 14:51:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602151448590.10593@wbgn013.biozentrum.uni-wuerzburg.de>
References: <mj+md-20060215.120104.14337.atrey@ucw.cz> <20060215130538.GO31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Mares <mj@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 14:52:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9N4e-0001sA-Tx
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 14:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945938AbWBONvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 08:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945944AbWBONvw
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 08:51:52 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51355 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1945938AbWBONvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 08:51:51 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 079541474E5; Wed, 15 Feb 2006 14:51:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EB2BD21D1;
	Wed, 15 Feb 2006 14:51:50 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C859E1474E5; Wed, 15 Feb 2006 14:51:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060215130538.GO31278@pasky.or.cz>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16241>

Hi,

On Wed, 15 Feb 2006, Petr Baudis wrote:

> Dear diary, on Wed, Feb 15, 2006 at 01:19:07PM CET, I got a letter
> where Martin Mares <mj@ucw.cz> said that...
> > I'm playing with a shared repository and I am still unable to get the
> > file and directory permissions kept correctly, that is writeable to
> > a group.
> > 
> > Setting the `core.sharedrepository' flag helps a bit, but not completely:
> > the object files and directories are group-writeable, but for example new
> > head refs aren't.
> 
>   actually, this is not necessary, since when pushing to shared
> repositories, the new ref is created in the directory as a lockfile and
> then moved over the original ref - this makes the ref updating safe and
> raceless, while also making it enough to have the refs directory
> group-writable.

IIRC the relevant discussion was started by this:

http://thread.gmane.org/gmane.comp.version-control.git/13856

>   Therefore, it shouldn't be actually necessary to meddle with umask
> anymore. The documentation is obsolete; I'll remove the relevant bits
> from Cogito docs.

Basically, if you just want a shared repository, you don't need to set the 
umask. However, if you want to work in the working directory (multiple 
users), you have to set the umask (it is not enough that the git tools do 
that, because you are likely to work with other programs as well).

Hth,
Dscho
