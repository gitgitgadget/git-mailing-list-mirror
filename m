From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: Challenge of setting up git server (repository). Please help!
Date: Thu, 20 Nov 2008 14:43:30 -0800 (PST)
Message-ID: <146002.93100.qm@web37908.mail.mud.yahoo.com>
References: <20081120221321.GA6349@euler>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3IGY-0003N2-8O
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 23:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbYKTWnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 17:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYKTWnd
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 17:43:33 -0500
Received: from web37908.mail.mud.yahoo.com ([209.191.91.170]:23379 "HELO
	web37908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751308AbYKTWnb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 17:43:31 -0500
Received: (qmail 93249 invoked by uid 60001); 20 Nov 2008 22:43:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=qnOQcTw7wRgI59C1NU7Z2QLM92Mm9wVQ5B9j8K4e60ToqicW2oDSncTu5zUx5ur1f/ury7NsYeL7THdbG2/+vAhToGNfQlhRUtQtxlFUwsHgFRjn5CEuG8+2/0v3FWFCFIMCucLEurADK8XqsOlk4g+9LG5QZn38sqW7OFALwLQ=;
X-YMail-OSG: 313gadAVM1ngTpe59KDBMytUu4UVwfrboL8zfc5bxeHg6V66pyWZziGIs9qfof2NtLumU3iGG6NbLW47ZuhT3dFWsKehtsVfI..DPCreQydOrZc_ohNdcF38d8FNjSrDdCGVf5qWNb2HZ4kUl_J6nKgEHyDs0EKvJfqmlrzpo0saWmjiPtNt_H_XAEYu
Received: from [76.195.33.70] by web37908.mail.mud.yahoo.com via HTTP; Thu, 20 Nov 2008 14:43:30 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081120221321.GA6349@euler>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101476>

Deskin,

Many thanks for your explanation. I hope I understand what you said. I deleted /etc/xinetd.d/git-daemon. Then, I tried to git pull. But, I got connection refused. git uses port 9418. Should I request IT Admin to open the port 9418 for me?

git pull git://git.mycompany.com/pub/git/u-boot.git HEAD
git.mycompany.com[0: 10.66.4.168]: errno=Connection refused
fatal: unable to connect a socket (Connection refused)

Another question, I got no output of "netstat | grep 9418". It means no program runs at port 9418 at the public repository machine. Is it correct?

netstat | grep 9418


--- On Thu, 11/20/08, Deskin Miller <deskinm@umich.edu> wrote:

> From: Deskin Miller <deskinm@umich.edu>
> Subject: Re: Challenge of setting up git server (repository). Please help!
> To: "Gary Yang" <garyyang6@yahoo.com>
> Cc: git@vger.kernel.org
> Date: Thursday, November 20, 2008, 2:13 PM
> On Thu, Nov 20, 2008 at 01:39:12PM -0800, Gary Yang wrote:
> > 
> > I am working on setting up a git server so that people
> can clone, pull and push their code at
> git.mycompany.com/pub/git+project path. 
> > However, I am having challenges. For people who setup
> their git servers, please share your experneces with me and
> tell me what I did wrong.
> > I greatly appreciate it.
> > 
> > After I made configurations, I ran the command, git
> update-server-info at the public repository machine. But, I
> got the error.
> > 
> > git pull http://git.mycompany.com/pub/git/u-boot.git
> HEAD
> > fatal:
> http://git.mycompany.com/pub/git/u-boot.git/info/refs not
> found: did you run git update-server-info on the server?
> > 
> > The file /pub/git/u-boot.git/info/refs dose exist.
> > 
> > cat /pub/git/u-boot.git/info/refs
> > 87ee4576c4c31b7046fe2bbbdf309eaba5c3f346       
> refs/heads/master
> > 
> > My question:
> > 
> > Is the contet of /pub/git/u-boot.git/hooks/post-update
> correct? Should I change "exec
> git-update-server-info" to "exec git
> update-server-info"?
> > 
> > cat /pub/git/u-boot.git/hooks/post-update
> > #!/bin/sh
> > #
> > # An example hook script to prepare a packed
> repository for use over
> > # dumb transports.
> > #
> > # To enable this hook, rename this file to
> "post-update".
> > exec git-update-server-info
> > 
> > I tried and changed "exec
> git-update-server-info" to "exec git
> update-server-info" in
> /pub/git/u-boot.git/hooks/post-update. But, I still got same
> error.
> > git pull http://git.mycompany.com/pub/git/u-boot.git
> HEAD
> > fatal:
> http://git.mycompany.com/pub/git/u-boot.git/info/refs not
> found: did you run git update-server-info on the server?
> > 
> > Which one is correct? "exec
> git-update-server-info" or "exec git
> update-server-info"? Eventhogh none of them working.
> > 
> > Below are my settings:
> > 
> > grep 9418 /etc/services
> > git             9418/tcp                        # Git
> Version Control System
> > 
> > 
> > grep git /etc/inetd.conf
> > git     stream  tcp     nowait  nobody 
> /usr/local/libexec/git-core/git-daemon git-daemon --inetd
> --export-all /pub/git
> > 
> > 
> > cat /etc/xinetd.d/git-daemon
> > # default: off
> > # description: The git server offers access to git
> repositories
> > service git
> > {
> >         disable = no
> >         type            = UNLISTED
> >         port            = 9418
> >         socket_type     = stream
> >         wait            = no
> >         user            = nobody
> >         server          =
> /usr/local/libexec/git-core/git-daemon
> >         server_args     = --inetd --export-all
> --base-path=/pub/git
> >         log_on_failure  += USERID
> > }
> > 
> > 
> > I am running git at Linux box:
> > uname -a
> > Linux svdclw004 2.6.9-67.ELsmp #1 SMP Wed Nov 7
> 13:56:44 EST 2007 x86_64 GNU/Linux
> > 
> > Are there anything wrong? Please let me know.
> 
> You tried to fetch from a http url, but your settings make
> no mention of
> running a web server.  git-update-server-info is only
> relevant in the context
> of using a web server to serve git repositories via the
> same http protocol as
> is used by web servers everywhere.  git-daemon, on the
> other hand, which is
> what you show configured here, is used to serve git
> repositories via a git://
> url.  Its configuration has no effect on whether using http
> to fetch a git
> repository will work or not.
> 
> Either use a git:// url to fetch the project, or set up a
> web server which
> serves stuff under /pub/git.
> 
> I'll also mention that you appear to have configuration
> for both inetd and
> xinetd, which are two generally mutually-exclusive
> 'super-servers'; and
> furthermore, your configurations are inconsistent in the
> arguments they pass to
> git-daemon: it looks like, were you to replace http:// with
> git://, the inetd
> config would work as listed, while xinetd would not.
> 
> Hope that helps,
> Deskin Miller
> 
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
