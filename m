From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Tue, 3 Jul 2007 12:27:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031217480.4071@racer.site>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site> 
 <20070702145549.GB4720@thunk.org>  <Pine.LNX.4.64.0707021654450.4071@racer.site>
  <20070702160810.GD4720@thunk.org> <81b0412b0707030007o328f0b35hfa758e1f3b2ef289@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2037960422-1183462055=:4071"
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 13:27:45 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5gXo-0008CZ-Ov
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 13:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbXGCL1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 07:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756313AbXGCL1m
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 07:27:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:39649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754486AbXGCL1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 07:27:41 -0400
Received: (qmail invoked by alias); 03 Jul 2007 11:27:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 03 Jul 2007 13:27:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19u7Zx4xo5uQfr/vB2nTqrKs08FgQpAPt/hiLSFOB
	IQcz1+M+UbR8bs
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0707030007o328f0b35hfa758e1f3b2ef289@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51475>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2037960422-1183462055=:4071
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 3 Jul 2007, Alex Riesen wrote:

> On 7/2/07, Theodore Tso <tytso@mit.edu> wrote:
> > On Mon, Jul 02, 2007 at 04:55:24PM +0100, Johannes Schindelin wrote:
> > > > But what if you don't want the argument passed at the end of the
> > > > alias, but somewhere else?  I suspect the better answer would be to
> > > > support $* and $1, $2, $3, et. al interpolation, no?  It was on my
> > > > list of things to do when I had a spare moment, but I never got around
> > > > to it.
> > >
> > > There is a point where you do not want to complicate git, but rather
> > write
> > > a script. This is such a point IMHO.
> > 
> > Such a point exists, I agree, but I would draw after $* and $1/$2/$3
> > interpolation.  There is a lot more value that gets added with
> > positional arguments support, and it makes git aliases more usable on
> > platforms such as Windows where scripting capability is much more
> > limited.
> 
> I don't think it is _possible_ to make it work on Windows properly: you have
> to quote the arguments with whitespaces as there is nothing like argv there
> (windows programs don't use command line, so it does not exist).

Since the "!" aliases use system() (i.e. no argv, but a plain string as 
parameter), my patch already does that. It quotes the arguments properly.

> As the quoting is implemented in the programs the rules are all different
> and mostly suboptimal.

You mean the programs that could be called via "!" aliases? Yes, that is 
right. And there is also the problem that you have to convert path names 
if you are working on Windows, because of this c:\&@!§$ braindamage.

However, in this case Junio's idea to use the shell to do the hard work is 
again an alternative:

	[alias]
		alex = !sh -c 'd:\program.exe $(cygpath -w "$1")'

FWIW I do not think that executing the shell from time to time is a big 
problem. It's only that I would like to get rid of the dependency on perl 
and bash for the plain Windows user, who will not dare to leave the gui 
into the command line jungle where there be bisons, yaccs and kills.

Ciao,
Dscho

--8323584-2037960422-1183462055=:4071--
