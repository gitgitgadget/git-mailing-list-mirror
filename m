From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Tue, 11 Nov 2008 21:53:30 +0100
Organization: One2team
Message-ID: <200811112153.31214.fg@one2team.com>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <200811111230.28076.fg@one2team.com> <alpine.LFD.2.00.0811111542230.24205@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, Git Mailing List <git@vger.kernel.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 21:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00Gp-0003lO-QH
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 21:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbYKKUyR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 15:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbYKKUyR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 15:54:17 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:58891 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbYKKUyR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2008 15:54:17 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 6132292C002;
	Tue, 11 Nov 2008 21:54:04 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 5CCA97001F;
	Tue, 11 Nov 2008 21:54:14 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0811111542230.24205@sys-0.hiltweb.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100676>

Le Tuesday 11 November 2008 21:47:55 Ian Hilt, vous avez =E9crit=A0:
> On Tue, 11 Nov 2008, Francis Galiegue wrote:
> > Le Tuesday 11 November 2008 02:49:19 Tait, vous avez =E9crit=A0:
> > > > > > +	if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
> > > > >
> > > > > Greedy operators are only supported with perl 5.10 or more...=
 I
> > > > > think it's a bad idea to use them...
> > > >
> > > > The problem here was that a space should follow the field, but =
it may
> > > > not.  The user may unwarily backup over it.  "\s*" would match =
this
> > > > case.
> > > >
> > > > But if there is a space, it is included in the "(.+)".
> > >
> > > Not in any version of Perl to which I have access.
> >
> > And if you see a space in (.+), your regex engine is buggy anyway.
>
> So what does this script produce on your systems?
>
>
> #!/usr/bin/perl -Tw
> --8<--
> use strict;
> my $ws =3D "To: \nCc:";
>
> $ws =3D~ /^To:\s*(.+)\s*\nCc:/ism;
>
> if ($1 eq ' ') {
> 	print "\$1 is equal to a space.\n";
> }
> -->8--
>
> On mine, it prints the message.  So it seems it is matching _a_ space=
=2E

Which is perfectly normal. The first \s* wanted spaces, it got them. Bu=
t it=20
left nothing for the capturing .+ behind. And any quantifier (except wh=
en it=20
is possessive) _MUST_ backtrack in order for the full regex to complete=
=2E This=20
is why the .+ captured the space: the first \s* was perfectly fine with=
 no=20
space at all, and the second, well, didn't find any space but it didn't=
 care=20
either.

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
