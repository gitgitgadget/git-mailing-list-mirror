From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: Re: [PATCH/RFC] Documentation: git-daemon inetd configuration fix
Date: Fri, 16 Mar 2007 10:02:09 +0100
Message-ID: <1174035730.4067.54.camel@localhost.localdomain>
References: <11740316693552-git-send-email-matthias@spinlock.ch>
	 <7vabydwpd5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 10:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS8rh-00050t-DA
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 10:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238AbXCPJg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 05:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932991AbXCPJg1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 05:36:27 -0400
Received: from elephant.oekohosting.ch ([80.74.144.79]:33809 "EHLO
	elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933238AbXCPJg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 05:36:26 -0400
X-Greylist: delayed 2036 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Mar 2007 05:36:25 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 5543D62C0BC;
	Fri, 16 Mar 2007 10:00:11 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14119-03; Fri, 16 Mar 2007 10:00:08 +0100 (CET)
Received: from [192.168.1.7] (176-197.0-85.cust.bluewin.ch [85.0.197.176])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 56E8062C09A;
	Fri, 16 Mar 2007 10:00:08 +0100 (CET)
In-Reply-To: <7vabydwpd5.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42339>

On Fri, 2007-03-16 at 01:43 -0700, Junio C Hamano wrote:
> Matthias Kestenholz <matthias@spinlock.ch> writes:
> 
> >  On my debian server, this change was needed to get git-daemon running.
> >  I am no inetd expert, so I don't know where the error was.
> >
> >  Perhaps this patch might help someone else.
> >
> >
> > diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> > index 9ddab71..499c1f3 100644
> > --- a/Documentation/git-daemon.txt
> > +++ b/Documentation/git-daemon.txt
> > @@ -177,7 +177,7 @@ git-daemon as inetd server::
> >  +
> >  ------------------------------------------------
> >  	git stream tcp nowait nobody  /usr/bin/git-daemon
> > -		git-daemon --inetd --verbose --export-all
> > +		/usr/bin/git-daemon --inetd --verbose --export-all
> >  		/pub/foo /pub/bar
> >  ------------------------------------------------
> 
> That sounds _very_ wrong.  What you changed is argv[0] (i.e. the
> beginning of "service program arguments" field) and it should
> not matter what you have there for inetd to launch git-daemon.
> Presumably your inetd runs with /usr/bin in your path so even
> the "service program" field (the one after 'nobody') should not
> need the full path (but it is a good idea to be explicit in that
> field as a principle), but needing the full path in argv[0]?
> 
> On _my_ debian box, I do not need a full path there, so it is
> not even Debian in general but problem is on your particular
> box.  Can you dig a bit more to see what you are doing any
> differently?
> 
> For example, do you really mean the "service program arguments"
> field that matters?
> 


Uhm... I don't get it. I changed the second /usr/bin/git-daemon back to
git-dameon (and even to "foo") and it continues working after restarting
inetd.

I cannot reproduce the problem I had earlier, but everything works fine
with the line from the docs now.

Btw, git is installed in /usr/bin , so that cannot be the reason for the
failure I saw.


Oh well, sorry for the noise and thanks for the fast response.
	Matthias
