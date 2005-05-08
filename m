From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 19:30:03 +0200
Message-ID: <20050508173003.GY9495@pasky.ji.cz>
References: <1115564550.9031.96.camel@pegasus> <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus> <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus> <20050508171209.GX9495@pasky.ji.cz> <1115572667.9031.139.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:25:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpW3-0007Kn-DI
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVEHRar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVEHRar
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:30:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3546 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262904AbVEHRaF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:30:05 -0400
Received: (qmail 3798 invoked by uid 2001); 8 May 2005 17:30:03 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115572667.9031.139.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 07:17:47PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> > > I will check what I can do, but I don't really care that much about the
> > > patch size ;)
> > 
> > But I do. :-)
> 
> Sometime you don't have any other choice, because diff is not perfect.
> Do you wanna apply that patch or should I change the mktemp templates
> first?

It looks like it'll be most painless when I just reinvent parts of your
patch here locally and you can send me patches on top of that.

> > > > > Index: cg-commit
> > > > > ===================================================================
> > > > > --- f00d7589973e8ea65d2264f5fbac82e1b217dc8f/cg-commit  (mode:100755)
> > > > > +++ cb61efa8a01400150162af9b0f3773f21d502fe9/cg-commit  (mode:100755)
> > > > > @@ -94,30 +78,55 @@
> > > > >  		echo "$uri" >>$LOGMSG
> > > > >  		[ "$msgs" ] && echo "$uri"
> > > > >  	done
> > > > > -	echo >>$LOGMSG
> > > > > +else
> > > > > +	first=1
> > > > >  fi
> > > > > -first=1
> > > > > +
> > > > >  for msg in "${msgs[@]}"; do
> > > > >  	if [ "$first" ]; then
> > > > >  		first=
> > > > >  	else
> > > > >  		echo >>$LOGMSG
> > > > >  	fi
> > > > > -	echo $msg | fmt >>$LOGMSG
> > > > > +	echo $msg | fmt -s -w 74 >>$LOGMSG
> > > > >  done
> > > > > +
> > > > > +if [ "$first" ]; then
> > > > > +	echo >>$LOGMSG
> > > > > +fi
> > > > 
> > > > This mess is still here.
> > > 
> > > That is not mess. Think about it. If we have messages provided by -m we
> > > want an empty line between the merge message and the the first commit
> > > message. And we don't wanna have an extra empty line at the top if you
> > > provide a commit messages via -m.
> > 
> > But, that's the current behaviour, isn't it?
> 
> No it is not, because with my change the messages are at the top and
> before the CG: lines.

I'm sorry but I still don't get what are you trying to say. :-)
As far as I can see, the output will be the same, except that with to -m
arguments, there won't be the extra newline for the merge message - and
we agreed we want it, didn't we?

I'll just drop this chunk. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
