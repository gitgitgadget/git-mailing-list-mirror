From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 23:19:11 +0200
Message-ID: <1115587151.8949.74.camel@pegasus>
References: <20050508155656.GV9495@pasky.ji.cz>
	 <1115568937.9031.129.camel@pegasus> <20050508171209.GX9495@pasky.ji.cz>
	 <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz>
	 <1115574035.9031.145.camel@pegasus> <20050508175156.GA9495@pasky.ji.cz>
	 <1115578658.8949.9.camel@pegasus> <20050508200334.GG9495@pasky.ji.cz>
	 <1115584015.8949.43.camel@pegasus>  <20050508210857.GL9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:12:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUt3w-0006a3-Gw
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVEHVSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVEHVSv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:18:51 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:4270 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262935AbVEHVSr
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 17:18:47 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48LK5WX005660
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 23:20:06 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508210857.GL9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > @@ -122,10 +124,10 @@
> >  if tty -s; then
> >         if ! [ "$msgs" ] || [ "$forceeditor" ]; then
> >                 ${EDITOR:-vi} $LOGMSG2
> > -       fi
> > -       if ! [ "$msgs" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
> > -               rm $LOGMSG $LOGMSG2
> > -               die 'Commit message not modified, commit aborted'
> > +               if ! [ $LOGMSG2 -nt $LOGMSG ]; then
> > +                       rm $LOGMSG $LOGMSG2
> > +                       die 'Commit message not modified, commit aborted'
> > +               fi
> >         fi
> >  else
> > 
> > If you provide a commit message via -m and then close the editor without
> > changing it, it will commit the message. I think that will not be the
> > intention of the user.
> 
> Now, this is a pretty difficult question. The only other place in the
> Cogito toolkit which uses cg-commit -e is now cg-init when doing the
> initial commit - and you definitively want to commit even if the message
> was not modified in that case. Also, what if you want to just review
> how the -m stuff flows like before committing?
> 
> OTOH, we might want to stay consistent in behaviour and always abandon
> action when the file was not modified (except for the initial commit).
> Perhaps some -E for that? Other thoughts?

I think using -E to commit even when you don't modify the commit message
is a good idea. The alternative way is to ask the user like CVS does.

> > /*
> >  * Remove empty lines from the beginning and end.
> >  *
> >  * Turn multiple consecutive empty lines into just one
> >  * empty line.
> >  */
> 
> Bah, that's even easier when you want to squeeze the empty lines inside
> of the commit message. I don't, though.

You can do that with "cat -s", I know. But then you still have to look
at the first and the last line and delete it if they are empty.

I think it is a good idea to squeeze empty lines, because multi empty
lines are not useful for commit messages anyway. What do you think?

Regards

Marcel


