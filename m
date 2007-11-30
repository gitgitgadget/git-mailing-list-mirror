From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 00:54:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711300053260.27959@racer.site>
References: <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site>
 <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net>
 <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
 <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org> <474F5E90.9040505@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:55:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixu9l-0007Ze-9C
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbXK3Aym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbXK3Aym
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:54:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:39068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932752AbXK3Ayl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:54:41 -0500
Received: (qmail invoked by alias); 30 Nov 2007 00:54:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp007) with SMTP; 30 Nov 2007 01:54:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181bZgCBdI15YjSaM4BHyNjf7CcOlRSS1yT6Wz7UC
	1Lo9BoUpciDyFs
X-X-Sender: gene099@racer.site
In-Reply-To: <474F5E90.9040505@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66585>

Hi,

On Thu, 29 Nov 2007, A Large Angry SCM wrote:

> Junio C Hamano wrote:
> [...]
> > Ok.  So here is a revised roadmap that a panda brain (that is not so
> > well working today due to fever) came up.
> > 
> >  - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
> >    release notes for the version will warn users that:
> > 
> >    (1) using git-foo from the command line, and
> > 
> >    (2) using git-foo from your scripts without first prepending the
> >        return value of "git --exec-path" to the PATH
> > 
> >    is now officially deprecated (it has been deprecated for a long time
> >    since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
> >    the default configuration that does not install git-foo form in
> >    user's PATH.
> > 
> >    If further will warn users that git-foo form will be removed in
> >    v1.5.6 for many commands and it will be merely an accident if some of
> >    them still work after that.
> > 
> >  - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
> >    for inclusion in v1.5.5, perhaps in Feb-Mar 2008 timeframe.  This
> >    will also affect the sample RPM spec and resulting RPM binary
> >    packages I will place on k.org, and I'll ask Gerrit to do the same on
> >    Debian side.  The official binary packaging of individual distros are
> >    not under my control, but if there is a handy list of people I can
> >    send this notice to for other distros, that would help this process.
> > 
> >  - The release notes for v1.5.5 will warn users again that git-foo will
> >    be removed in v1.5.6 for many commands and it will be merely an
> >    accident if some of them still work.
> > 
> >  - Post v1.5.5, start cooking the change that does not install hardlinks
> >    for built-in commands, aiming for inclusion in v1.5.6, in May-Jun
> >    2008 timeframe.
> 
> Again, there needs to remain support in the Makefile to install the "dashed"
> versions of the commands for those that want it; and be able to set
> gitexecdir=$(binder) without editing the Makefile.

Umm.  Why?  If there is no compelling reason (and you named none, but 
there were quite a few reasons against it), why should the Makefile 
support the dash form after 1.5.6?

Ciao,
Dscho
