From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 17:17:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181711090.3586@pacific.mpi-cbg.de>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com> <7vhc3x1874.fsf@gitster.siamese.dyndns.org> <20090118094113.GE11992@leksak.fem-net>
 <20090118153928.GA16664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Jonas_Flod=E9n?= <jonas@floden.nu>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 17:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOaMe-0003Sy-Mt
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165AbZARQRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 11:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757155AbZARQRo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:17:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:35177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757237AbZARQRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 11:17:44 -0500
Received: (qmail invoked by alias); 18 Jan 2009 16:17:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 18 Jan 2009 17:17:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kmJ1/CDzk2Lss90sy/R1gomO/mJ1XRWFqoFHz3+
	2VIqn0GuydiJm8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090118153928.GA16664@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106237>

Hi,

On Sun, 18 Jan 2009, Jeff King wrote:

> On Sun, Jan 18, 2009 at 10:41:13AM +0100, Stephan Beyer wrote:
> 
> > > Looks sane except that I do not think you need printf nor the leading
> > > blank line, i.e.
> > > 
> > > 	echo "Patch failed at $msgnum ($FIRSTLINE)"
> > 
> > Hmm, IIRC if $FIRSTLINE contains \n or something like that, it will
> > interpret this as newline in some shell/echo implementations.
> > 
> > So printf "...%s..." "$FOO" is always sane for user input.
> 
> Yes, I'm surprised Junio doesn't remember the mass conversions we 
> already had to do (4b7cc26a and 293623ed). But looking at the date, I 
> guess it _has_ been a year and a half. :)

Hey, be nice to Junio.  Have you seen the amount of mails on this list 
recently?  I think Junio's the only one really reading all of them; even 
if you were right, he would be entitled to a nicer reminder.

But you are wrong.  And Stephan is wrong, too.

The name "FIRSTLINE" suggests that it is indeed a first line, and 
consequently cannot contain a newline.

And indeed, it is defined as

	FIRSTLINE=$(sed 1q "$dotest/final-commit")

Just do the following in any of your favorite shells:

	$ FIRSTLINE=$(sed 1q README)
	$ echo "$FIRSTLINE."

You'll find that the "." is not in a new line.

And I know that we relied on that behavior for an eternity.

So there is certainly no need for a printf here.

'nuff said,
Dscho
