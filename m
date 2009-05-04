From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH 6/6] Remove bareword filehandles in git-send-email.perl
Date: Mon, 4 May 2009 08:12:54 +0200
Message-ID: <20090504081254.64e289fd@pc09.procura.nl>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
	<1241010743-7020-7-git-send-email-wfp5p@virginia.edu>
	<20090503205826.GF20468@coredump.intra.peff.net>
	<200905032334.03286.fge@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Bill Pemberton <wfp5p@virginia.edu>,
	git@vger.kernel.org, gitster@pobox.com
To: Francis Galiegue <fge@one2team.com>
X-From: git-owner@vger.kernel.org Mon May 04 08:13:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rQU-0000MZ-5y
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZEDGNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2009 02:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbZEDGNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:13:09 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:3017 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZEDGNI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 02:13:08 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id n446Ct00020808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 4 May 2009 08:12:55 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <200905032334.03286.fge@one2team.com>
X-Mailer: Claws Mail 3.7.1cvs44 (GTK+ 2.14.4; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118204>

On Sun, 3 May 2009 23:34:03 +0200, Francis Galiegue <fge@one2team.com>
wrote:

> Le Sunday 03 May 2009 22:58:26 Jeff King, vous avez =C3=A9crit=C2=A0:
> > On Wed, Apr 29, 2009 at 09:12:23AM -0400, Bill Pemberton wrote:
> > > The script was using bareword filehandles.  This is considered a =
bad
> > > practice so they have been changed to indirect filehandles.
> >
> > I think this is a real improvement; using indirect filehandles mean=
 they
> > get scoped properly, which can avoid errors (especially forgetting =
to
> > close() them, which happens automagically when they go out of scope=
).
> > Assuming, of course, that the scoping added by your change is corre=
ct,
> > and doesn't close a handle during a loop that we may have wanted to=
 keep
> > open (I didn't check carefully).
> >
> > But in the patch itself:
> > > -	open(C,">",$compose_filename)
> > > +	open my $C,'>',$compose_filename
> >
> > There are actually two things happening here:
> >
> >   1. s/C/my $C/, which I think is good
> >
> >   2. losing the parentheses around open(). This is a style issue, b=
ut I
> >      think we usually prefer the parenthesized form of most perl
> >      builtins (and certainly in the absence of other information, i=
t
> >      should be left as-is).
> >
>=20
> And why not go the full way and using IO::File?

Because that would be travelling back in time.
The most efficient and preferred way is three-arg lexical:

    open my $fh, "<", $filename or die "$filename: $!";
    while (<$fh>) {
        # ...
        }
    close $fh or die "$filename: $!";

give or take quoting style, some spaces and/or indents

> my $fh =3D new IO::File;
>=20
> $fh->open("/the/file", O_RDONLY|...)

Why use a module for something that is neatly buit in?

--=20
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org=
/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00=
,
11.11, 11.23, and 11.31, OpenSuSE 10.3, 11.0, and 11.1, AIX 5.2 and 5.3=
=2E
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org=
/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers=
/
