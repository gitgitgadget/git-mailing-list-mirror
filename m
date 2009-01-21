From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What about allowing multiple hooks?
Date: Wed, 21 Jan 2009 22:50:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212247510.3586@pacific.mpi-cbg.de>
References: <20081121133828.GB5912@gmx.de> <20090103233252.GA12095@myhost> <7vd4f3z8xu.fsf@gitster.siamese.dyndns.org> <4977872E.70901@0x63.nu> <alpine.DEB.1.00.0901212206430.3586@pacific.mpi-cbg.de> <497793E5.7090107@0x63.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alexander Potashev <aspotashev@gmail.com>,
	Marc Weber <marco-oweber@gmx.de>,
	Rogan Dawes <lists@dawes.za.net>,
	martin f krafft <madduck@madduck.net>
To: Anders Waldenborg <anders@0x63.nu>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkzb-0003pW-MV
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZAUVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbZAUVuu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:50:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:38998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752077AbZAUVut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:50:49 -0500
Received: (qmail invoked by alias); 21 Jan 2009 21:50:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 21 Jan 2009 22:50:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UVtZPQoUUfvUEhhns4Oui4ed1DcdvW7tE8189bH
	l6AxfzMRtVvdd4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <497793E5.7090107@0x63.nu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106684>

Hi,

On Wed, 21 Jan 2009, Anders Waldenborg wrote:

> Johannes Schindelin wrote:
> > > I currently use configvalues to specify which hooks to run. For example
> > > this is how my post-receive looks:
> > >
> > > data=$(cat)
> > > git config --get-all hooks.post-receive.hook | while read hook; do
> > >         $hook <<__EOF__
> > > "$data"
> > > __EOF__
> > > done
> > 
> > I wonder why you don't do the obvious thing:
> 
> 
> Because I wanted to be able to do things like this:
> 
> git config -add hooks.post-receive.hook \
>  "sh hooks/buildbot 192.168.99.9:9989"

You are missing a "-".

> So, the thing I initially wanted to solve was "multiple instances" of 
> the same hook.

And why not use a shell function for that?

-- snip --
buildbot () {
	echo "Who is so evil and puts a bot into a post-receive hook?" >&2
	echo "This function would connect to $* if it were building a bot."
}

buildbot www.google.com
buildbot www.kernel.org
-- snap --

> Then when I found this thread I saw that the richer meta information 
> needed to implement multiple hooks with sane semantics could be done 
> with the config values.

I think this is technically called an "XY" problem.  You ask for a 
specific technical solution, while your real problem would be better 
solved by other means.

Ciao,
Dscho
