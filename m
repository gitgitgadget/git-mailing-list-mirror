From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the
 --compose flag
Date: Tue, 11 Nov 2008 15:47:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111542230.24205@sys-0.hiltweb.site>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site> <20081111014919.GI7408@ece.pdx.edu> <200811111230.28076.fg@one2team.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1644764628-1226436478=:24205"
Cc: Tait <git.git@t41t.com>, Git Mailing List <git@vger.kernel.org>
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 21:49:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00B4-0000za-AJ
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYKKUsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 15:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYKKUsL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 15:48:11 -0500
Received: from mail.gmx.com ([74.208.5.67]:36161 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751870AbYKKUsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 15:48:09 -0500
Received: (qmail invoked by alias); 11 Nov 2008 20:48:02 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us001) with SMTP; 11 Nov 2008 15:48:02 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+3XAd5yfa3VFA+l0F5rnKGtTK3cD5U3w5G62I+KO
	iqNhd/5UXY4b1T
In-Reply-To: <200811111230.28076.fg@one2team.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100673>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1644764628-1226436478=:24205
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Nov 2008, Francis Galiegue wrote:
> Le Tuesday 11 November 2008 02:49:19 Tait, vous avez =E9crit=A0:
> > > > > +=09if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
> > > >
> > > > Greedy operators are only supported with perl 5.10 or more... I thi=
nk
> > > > it's a bad idea to use them...
> > >
> > > The problem here was that a space should follow the field, but it may
> > > not.  The user may unwarily backup over it.  "\s*" would match this
> > > case.
> > >
> > > But if there is a space, it is included in the "(.+)".
> >
> > Not in any version of Perl to which I have access.
> >
>=20
> And if you see a space in (.+), your regex engine is buggy anyway.

So what does this script produce on your systems?


#!/usr/bin/perl -Tw
--8<--
use strict;
my $ws =3D "To: \nCc:";

$ws =3D~ /^To:\s*(.+)\s*\nCc:/ism;

if ($1 eq ' ') {
=09print "\$1 is equal to a space.\n";
}
-->8--

On mine, it prints the message.  So it seems it is matching _a_ space.
This resulted in an illegal recipient field.  Junio's suggestion to
change this to

  /^To:\s*(\S.+?)\s*\nCc:/ism

worked beautifully.
--8323328-1644764628-1226436478=:24205--
