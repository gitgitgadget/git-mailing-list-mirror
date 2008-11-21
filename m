From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: Challenge of setting up git server (repository). Please help!
Date: Thu, 20 Nov 2008 16:39:08 -0800 (PST)
Message-ID: <546971.60895.qm@web37907.mail.mud.yahoo.com>
References: <563817.77498.qm@web37903.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3K4W-0005vn-3L
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbYKUAjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbYKUAjK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:39:10 -0500
Received: from web37907.mail.mud.yahoo.com ([209.191.91.169]:30021 "HELO
	web37907.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753308AbYKUAjJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 19:39:09 -0500
Received: (qmail 61074 invoked by uid 60001); 21 Nov 2008 00:39:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=MLKyv8NKHYp/6QjoYc+Koi27M+lqgedmUrCgfAfmJQ4ovk6wXweKhGed0fiR0UokqYO5+5Ey+i+1uQgZSYQBsYczfq2/5e4RCZTYuczyPVIGfnp4zQyd8knG29Xeb/Y6pGnga95TBND+Onmwxz1sMQj8rO0Wv6lFLgGYzosGt9Y=;
X-YMail-OSG: oSMgCq4VM1mNuo7jVaGXZwvV.kUV6CXy89uCy7DXX.KVkXVT6OGKE2Y6OLNsQOZK.FKLVrJo0m6tS0Ue9rrqkoJCOiOKZ2.HXzzQwEfguX4CPbGoK0vxMCzfKPM1NSvGTWKf6UVAyZZKBkIpadLfFki951nf2mT2hMJgXarbP_TKjNaaQ23dHRg7zfo0O4DHufjBKeCX2OZEgJDnjefmMeysD0Q3
Received: from [76.195.33.70] by web37907.mail.mud.yahoo.com via HTTP; Thu, 20 Nov 2008 16:39:08 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <563817.77498.qm@web37903.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101484>

I killed xinetd. Restarted with sudo xinetd -stayalive -pidfile /var/run/xinetd.pid. 

I back to my private box. I did 

git pull git://git.mycompany.com/pub/git/u-boot.git HEAD

This command hangs for over half hour and is still hanging. Again, below is the content of /etc/xinetd.d/git-daemon. What I did wrong?

cat /etc/xinetd.d/git-daemon
# default: off
# description: The git server offers access to git repositories
service git
{
        disable = no
        type            = UNLISTED
        port            = 9418
        socket_type     = stream
        wait            = no
        user            = nobody
        server          = /usr/local/libexec/git-core/git-daemon
        server_args     = git-daemon --inetd --export-all --base-path=/pub/git
        log_on_failure  += USERID
}

--- On Thu, 11/20/08, Gary Yang <garyyang6@yahoo.com> wrote:

> From: Gary Yang <garyyang6@yahoo.com>
> Subject: Re: Challenge of setting up git server (repository). Please help!
> To: "J.H." <warthog19@eaglescrag.net>
> Cc: "Deskin Miller" <deskinm@umich.edu>, git@vger.kernel.org
> Date: Thursday, November 20, 2008, 4:14 PM
> Kill the process, then
> 
> sudo xinetd -stayalive -pidfile /var/run/xinetd.pid
> 
> Please let me know if it is correct.  Thanks.
> 
> 
> --- On Thu, 11/20/08, Gary Yang <garyyang6@yahoo.com>
> wrote:
> 
> > From: Gary Yang <garyyang6@yahoo.com>
> > Subject: Re: Challenge of setting up git server
> (repository). Please help!
> > To: "J.H." <warthog19@eaglescrag.net>
> > Cc: "Deskin Miller"
> <deskinm@umich.edu>, git@vger.kernel.org
> > Date: Thursday, November 20, 2008, 4:12 PM
> > I am not system admin. How to restart it? Can I do
> this?
> > 
> > sudo xinetd -stayalive -pidfile /var/run/xinetd.pid
> > 
> > 
> > Below is the output of current running xinetd
> > 
> > ps -efww | grep xinetd
> > root      8874     1  0 Sep24 ?        00:00:00 xinetd
> > -stayalive -pidfile /var/run/xinetd.pid
> > 
> > 
> > Thanks.
> > 
> > 
> > --- On Thu, 11/20/08, J.H.
> <warthog19@eaglescrag.net>
> > wrote:
> > 
> > > From: J.H. <warthog19@eaglescrag.net>
> > > Subject: Re: Challenge of setting up git server
> > (repository). Please help!
> > > To: garyyang6@yahoo.com
> > > Cc: "Deskin Miller"
> > <deskinm@umich.edu>, git@vger.kernel.org
> > > Date: Thursday, November 20, 2008, 3:59 PM
> > > Yes.
> > > 
> > > - John 'Warthog9' Hawley
> > > Chief Kernel.org Administrator
> > > 
> > > 
> > > On Thu, 2008-11-20 at 15:54 -0800, Gary Yang
> wrote:
> > > > Do I need to restart  xinetd after I made
> changes
> > in
> > > /etc/xinetd.d/git-daemon?
> > > > 
> > > > 
> > > > --- On Thu, 11/20/08, Gary Yang
> > > <garyyang6@yahoo.com> wrote:
> > > > 
> > > > > From: Gary Yang
> <garyyang6@yahoo.com>
> > > > > Subject: Re: Challenge of setting up
> git
> > server
> > > (repository). Please help!
> > > > > To: "Deskin Miller"
> > > <deskinm@umich.edu>
> > > > > Cc: git@vger.kernel.org
> > > > > Date: Thursday, November 20, 2008, 3:48
> PM
> > > > > I ran the command,"sudo
> > > > > /usr/local/libexec/git-core/git-daemon
> > git-daemon
> > > > > --export-all /pub/git &" at
> public
> > > repository
> > > > > machine.
> > > > > 
> > > > > At my private machine, I ran, git pull
> > > > >
> git://svdcgit01.amcc.com/pub/git/u-boot.git
> > > HEAD"
> > > > > 
> > > > > I got: "fatal: The remote end hung
> up
> > > > > unexpectedly"
> > > > > 
> > > > > At the public repository server, I got
> > > > > "'/pub/git/u-boot.git':
> > repository
> > > not
> > > > > exported." Any idea of this error?
> > > > > 
> > > > > 
> > > > > ps -A | grep inetd
> > > > >  8874 ?        00:00:00 xinetd
> > > > > 
> > > > > It means it uses xinetd.
> > > > > 
> > > > > I copied git-daemon back to
> /etc/xinetd.d
> > and
> > > added
> > > > > git-daemon to the server_args. See
> below:
> > > > > 
> > > > > cat /etc/xinetd.d/git-daemon
> > > > > # default: off
> > > > > # description: The git server offers
> access
> > to
> > > git
> > > > > repositories
> > > > > service git
> > > > > {
> > > > >         disable = no
> > > > >         type            = UNLISTED
> > > > >         port            = 9418
> > > > >         socket_type     = stream
> > > > >         wait            = no
> > > > >         user            = nobody
> > > > >         server          =
> > > > > /usr/local/libexec/git-core/git-daemon
> > > > >         server_args     = git-daemon
> --inetd
> > > --export-all
> > > > > --base-path=/pub/git
> > > > >         log_on_failure  += USERID
> > > > > }
> > > > > 
> > > > > 
> > > > > I kill the daemon
> > > > >
> "/usr/local/libexec/git-core/git-daemon
> > > git-daemon
> > > > > --export-all /pub/git &". 
> > > > > 
> > > > > Back to my private box, and did git
> pull. I
> > got
> > > Connection
> > > > > refused again. what I did wrong?
> > > > > 
> > > > > git pull
> > > git://svdcgit01.amcc.com/pub/git/u-boot.git HEAD
> > > > > svdcgit01.amcc.com[0: 10.66.4.168]:
> > > errno=Connection
> > > > > refused
> > > > > fatal: unable to connect a socket
> > (Connection
> > > refused)
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > --- On Thu, 11/20/08, Deskin Miller
> > > > > <deskinm@umich.edu> wrote:
> > > > > 
> > > > > > From: Deskin Miller
> > > <deskinm@umich.edu>
> > > > > > Subject: Re: Challenge of setting
> up
> > git
> > > server
> > > > > (repository). Please help!
> > > > > > To: "Gary Yang"
> > > <garyyang6@yahoo.com>
> > > > > > Cc: git@vger.kernel.org
> > > > > > Date: Thursday, November 20, 2008,
> 3:08
> > PM
> > > > > > On Thu, Nov 20, 2008 at 02:43:30PM
> > -0800,
> > > Gary Yang
> > > > > wrote:
> > > > > > > Many thanks for your
> explanation.
> > I
> > > hope I
> > > > > understand
> > > > > > what you said. I deleted
> > > /etc/xinetd.d/git-daemon.
> > > > > Then, I
> > > > > > tried to git pull. But, I got
> > connection
> > > refused. git
> > > > > uses
> > > > > > port 9418. Should I request IT
> Admin to
> > open
> > > the port
> > > > > 9418
> > > > > > for me?
> > > > > > 
> > > > > > You'll need port 9418 open,
> yes;
> > but
> > > since
> > > > > it's an
> > > > > > unprivileged port (1024 or
> > > > > > higher), you can use it as a
> regular
> > user
> > > and
> > > > > don't
> > > > > > need IT intervention unless you
> have
> > some
> > > firewall set
> > > > > up
> > > > > > which they need to override for
> you.
> > > > > > 
> > > > > > > git pull
> > > > >
> git://git.mycompany.com/pub/git/u-boot.git
> > > > > > HEAD
> > > > > > > git.mycompany.com[0:
> 10.66.4.168]:
> > > > > errno=Connection
> > > > > > refused
> > > > > > > fatal: unable to connect a
> socket
> > > (Connection
> > > > > refused)
> > > > > > 
> > > > > > It's possible, and likely
> simpler,
> > to
> > > use
> > > > > git-daemon
> > > > > > directly, instead of
> > > > > > having it be managed by inetd;
> > especially
> > > for initial
> > > > > > debugging, I'd recommend
> > > > > > getting that working before trying
> to
> > > determine if
> > > > > > you're having issues with
> > > > > > inetd configuration: to do so,
> just run
> > > git-daemon
> > > > > with all
> > > > > > the same arguments
> > > > > > except for --inetd.
> > > > > > 
> > > > > > You said you deleted the xinetd
> config,
> > but
> > > that's
> > > > > only
> > > > > > relevant if your
> > > > > > machine actually uses inetd as its
> > > super-server.  You
> > > > > > should do 'ps -A | grep
> > > > > > inetd' (which will match
> either
> > inetd or
> > > xinetd),
> > > > > and
> > > > > > see which one is running.
> > > > > > If it's inetd, you should be
> all
> > set,
> > > and the
> > > > > issue
> > > > > > doesn't look like inetd
> > > > > > (assuming you sent it a signal to
> > reload its
> > > config
> > > > > file). 
> > > > > > If on the other
> > > > > > hand xinetd is running, you need
> to use
> > the
> > > xinetd
> > > > > config
> > > > > > file, and fix the
> > > > > > server_args to look like the
> arguments
> > which
> > > exist in
> > > > > the
> > > > > > inetd file.  Again,
> > > > > > you need to signal xinetd at this
> point
> > to
> > > reload its
> > > > > > configuration.
> > > > > > 
> > > > > > Based on the linux kernel version
> > you're
> > > > > reporting,
> > > > > > I'm guessing you have some
> > > > > > sort of Red Hat based system,
> which
> > uses
> > > xinetd to the
> > > > > best
> > > > > > of my knowledge.
> > > > > > 
> > > > > > > Another question, I got no
> output
> > of
> > > > > "netstat |
> > > > > > grep 9418". It means no
> program
> > runs at
> > > port 9418
> > > > > at
> > > > > > the public repository machine. Is
> it
> > > correct?
> > > > > > > 
> > > > > > > netstat | grep 9418
> > > > > > 
> > > > > > netstat translates IP addresses to
> dns
> > > names, and
> > > > > ports to
> > > > > > service names by
> > > > > > default; so, given the line listed
> in
> > > /etc/services,
> > > > > this
> > > > > > will show
> > > > > > '0.0.0.0:git' or
> something. 
> > Also,
> > > it lists
> > > > > > established connections, not
> > > > > > listening sockets, by default. 
> I'd
> > > recommend
> > > > > spending
> > > > > > some time with the man
> > > > > > page if you're going to use it
> to
> > debug
> > > your
> > > > > setup.
> > > > > > 
> > > > > > Deskin Miller
> > > > > 
> > > > > 
> > > > >       
> > > > > --
> > > > > To unsubscribe from this list: send the
> line
> > > > > "unsubscribe git" in
> > > > > the body of a message to
> > > majordomo@vger.kernel.org
> > > > > More majordomo info at 
> > > > >
> http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > 
> > > >       
> > > > --
> > > > To unsubscribe from this list: send the line
> > > "unsubscribe git" in
> > > > the body of a message to
> > majordomo@vger.kernel.org
> > > > More majordomo info at 
> > > http://vger.kernel.org/majordomo-info.html
> > > 
> > > --
> > > To unsubscribe from this list: send the line
> > > "unsubscribe git" in
> > > the body of a message to
> majordomo@vger.kernel.org
> > > More majordomo info at 
> > > http://vger.kernel.org/majordomo-info.html
> 
> 
>       
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
