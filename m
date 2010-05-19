From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Wed, 19 May 2010 17:16:42 +0200
Message-ID: <1274282202.4275.68.camel@localhost>
References: <1274202486.4228.22.camel@localhost>
	 <1274203013-1349-1-git-send-email-yann@droneaud.fr>
	 <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
	 <1274215797.16337.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 17:16:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEl0y-0005eq-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 17:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab0ESPQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 11:16:51 -0400
Received: from smtp28.orange.fr ([80.12.242.101]:26111 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab0ESPQu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 11:16:50 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2824.orange.fr (SMTP Server) with ESMTP id C01428000F80;
	Wed, 19 May 2010 17:16:44 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2824.orange.fr (SMTP Server) with ESMTP id B12EA80014B1;
	Wed, 19 May 2010 17:16:44 +0200 (CEST)
Received: from iago.mandriva.com (LPuteaux-156-16-100-40.w80-12.abo.wanadoo.fr [80.12.80.40])
	by mwinf2824.orange.fr (SMTP Server) with ESMTP id A2F138000F80;
	Wed, 19 May 2010 17:16:44 +0200 (CEST)
X-ME-UUID: 20100519151644667.A2F138000F80@mwinf2824.orange.fr
Received: by iago.mandriva.com (Postfix, from userid 10001)
	id 092405AA; Wed, 19 May 2010 17:16:43 +0200 (CEST)
In-Reply-To: <1274215797.16337.16.camel@localhost>
X-Mailer: Evolution 2.28.2-1.1mdv2010.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147330>

Le mardi 18 mai 2010 =C3=A0 22:49 +0200, Yann Droneaud a =C3=A9crit :
> Le mardi 18 mai 2010 =C3=A0 10:45 -0700, Linus Torvalds a =C3=A9crit =
:
> >=20
> > On Tue, 18 May 2010, Yann Droneaud wrote:
> > > =20
> > > -if locale -a |grep -q en_US.utf8; then
> > > +if locale -a |grep -qE '^en_US\.(utf|UTF)-?8$'; then
> >=20
> > While -E is POSIX, I suspect that it's not universal. iirc, you sti=
ll have=20
> > some really crap fileutils tools coming with Solaris, for example.=20
> >=20
>=20
> You're right, Solaris's own grep doesn't known about -E nor -e.
>=20
> And it even doesn't know about -q :=20
>=20
>  $ grep -q                                                    =20
>  grep: illegal option -- q
>  Usage: grep -hblcnsviw pattern file . . .
>=20

Integrating Linus's remarks and some autoconf[1][2] hints, here is a
proposal for a portable test:

   if locale -a |grep -i 'en_US\.utf-*8' > /dev/null ; then

It should be as portable as possible without too much work.


[1] egrep
<http://www.gnu.org/software/autoconf/manual/html_node/Limitations-of-U=
sual-Tools.html#index-g_t_0040command_007begrep_007d-1706>

[2] grep
<http://www.gnu.org/software/autoconf/manual/html_node/Limitations-of-U=
sual-Tools.html#index-g_t_0040command_007bgrep_007d-1712>

Regards.

--=20
Yann Droneaud
