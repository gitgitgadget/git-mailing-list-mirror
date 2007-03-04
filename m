From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: Creating attachments using git-format-patch
Date: Sun, 4 Mar 2007 22:48:09 +0100
Message-ID: <20070304214809.GA18861@issaris.org>
References: <loom.20070303T215950-974@post.gmane.org> <7vhct27xk2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vslcl7jxo.fsf@assigned-by-dhcp.cox.net> <7vmz2t7i1x.fsf@assigned-by-dhcp.cox.net> <45EB2294.9040702@issaris.org> <7vodn84ru2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNyYi-0006vY-19
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 22:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXCDVr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 16:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbXCDVr5
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 16:47:57 -0500
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:57414 "EHLO
	outmx007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbXCDVr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 16:47:56 -0500
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
        by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id l24LloJe004155
        for <git@vger.kernel.org>; Sun, 4 Mar 2007 22:47:50 +0100
        (envelope-from <takis.issaris@uhasselt.be>)
Received: from adsl-dyn.isp.belgacom.be (78.129-64-87.adsl-dyn.isp.belgacom.be [87.64.129.78])
        by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with SMTP id l24Llji3004122;
	Sun, 4 Mar 2007 22:47:45 +0100
        (envelope-from <takis.issaris@uhasselt.be>)
Received: by adsl-dyn.isp.belgacom.be (sSMTP sendmail emulation); Sun, 04 Mar 2007 22:48:09 +0100
Content-Disposition: inline
In-Reply-To: <7vodn84ru2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41372>

Hi,

On Sun, Mar 04, 2007 at 01:33:09PM -0800, Junio C Hamano wrote:
> Panagiotis Issaris <takis@issaris.org> writes:
> 
> > The patch did not work for me in the sense that the patches still 
> > appeared as inline text in both Mutt (1.5.13) and Thunderbird (2 beta 2).
> >
> > The email show up as being threaded in Mutt, but in Thunderbird they 
> > still do not show up threaded.
> > thread about git-format-patch attachments, so Thunderbird appears to 
> > work alright).
> 
> If the patch below is needed, then I doubt you can honestly say
> it appears to work...
Well, here on Ubuntu using Mutt and Thunderbird the change below indeed makes
the patches appear as attachments instead of inline text.

The e-mails not showing up as one thread is probably some other issue, or some
misuse of me of git-format-patch and git-send-email.

I'm trying to get one e-mail sent with a header of [PATCH 00/16] with the other
patches as attachments to that one summary e-mail. Initially they did not show
up as being threaded in Thunderbird, but they did show up being threaded in
Mutt. Now, with some experimentation, I managed to get them to show up in a
thread in Thunderbird too, but unfortunately, now I am seeing the [PATCH 00/16]
e-mail followed by one reply [PATCH 01/16] and all others are replies to [PATCH
01/16] instead of [PATCH 00/16]. Or by further experimentation, I got the [PATCH
00/16] e-mail sent with 14 replies correctly threaded, but two of them for some
reader not ending up in the same thread...

git-format-patch --thread --attach -n origin..or2

git-send-email --no-chain-reply-to --to takis.issaris@uhasselt.be --from \
takis@issaris.org --subject "[PATCH 00/16] Various Doxygen related patches" \
--suppress-from --compose 00*patch

I've tried removing the --no-chain-reply and removing the --thread option of
format-patch, but I never manage to get the mails sent in the way I want them
to.

Anyway, I think my not-showing-up-as-a-thread issue is mainly because of me not
understanding how to use it correctly :) and being unrelated to the
patches-showing-up-inline-instead-of-as-attachments issue, which is really fixed
here with the patch shown below.

In fact, I noticed that using --inline or --attach does not seem to make a
difference for Mutt or Thunderbird, in both cases the emails appear to have
attachments now :-/

The way I came to the patch below is by manually editing the e-mails generated
by git-format-patch and sending them after each modification with git-send-email
until I figured out what change made the patches appear as attachments in both
email clients.

> > diff -u b/log-tree.c b/log-tree.c
> > --- b/log-tree.c
> > +++ b/log-tree.c
> > @@ -186,7 +186,7 @@
> >  			snprintf(subject_buffer, sizeof(subject_buffer) - 1,
> >  				 "%s"
> >  				 "MIME-Version: 1.0\n"
> > -				 "Content-Type: multipart/mixed;\n"
> > +				 "Content-Type: multipart/mixed;"
> >  				 " boundary=\"%s%s\"\n"
> >  				 "\n"
> >  				 "This is a multi-part message in MIME "
> > @@ -202,10 +202,10 @@
> >  
> >  			snprintf(buffer, sizeof(buffer) - 1,
> >  				 "--%s%s\n"
> > -				 "Content-Type: text/x-patch;\n"
> > +				 "Content-Type: text/x-patch;"
> >  				 " name=\"%s.diff\"\n"
> >  				 "Content-Transfer-Encoding: 8bit\n"
> > -				 "Content-Disposition: %s;\n"
> > +				 "Content-Disposition: %s;"
> >  				 " filename=\"%s.diff\"\n\n",
> >  				 mime_boundary_leader, opt->mime_boundary,
> >  				 sha1,
> 
> But if it helps some implementations of MIME decoder without
> harming others, then I'd say why not.  I just wanted to make
> sure it does not throw regression at others (for example by
> making the physical line too long for them to grok).
Of course, I fully understand your cautiousness.

With friendly regards,
Takis 
