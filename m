From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 22:49:57 +0200
Message-ID: <1274215797.16337.16.camel@localhost>
References: <1274202486.4228.22.camel@localhost>
	 <1274203013-1349-1-git-send-email-yann@droneaud.fr>
	 <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 18 22:50:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OETkK-0003YD-Cu
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 22:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954Ab0ERUuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 16:50:08 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:42851 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757791Ab0ERUuF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 16:50:05 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 62A1EE08120;
	Tue, 18 May 2010 22:49:58 +0200 (CEST)
Received: from mais.quest-ce.net (mais.quest-ce.net [88.161.129.79])
	by smtp6-g21.free.fr (Postfix) with ESMTP;
	Tue, 18 May 2010 22:49:57 +0200 (CEST)
Received: by mais.quest-ce.net (Postfix, from userid 500)
	id 74F057C0B4; Tue, 18 May 2010 22:49:57 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
X-Mailer: Evolution 2.26.3-1.1mdv2009.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147309>

Le mardi 18 mai 2010 =C3=A0 10:45 -0700, Linus Torvalds a =C3=A9crit :
>=20
> On Tue, 18 May 2010, Yann Droneaud wrote:
> > =20
> > -if locale -a |grep -q en_US.utf8; then
> > +if locale -a |grep -qE '^en_US\.(utf|UTF)-?8$'; then
>=20
> While -E is POSIX, I suspect that it's not universal. iirc, you still=
 have=20
> some really crap fileutils tools coming with Solaris, for example.=20
>=20

You're right, Solaris's own grep doesn't known about -E nor -e.

And it even doesn't know about -q :=20

 $ grep -q                                                    =20
 grep: illegal option -- q
 Usage: grep -hblcnsviw pattern file . . .

So the whole test won't work for older Solaris.

Solaris don't support grep -e, but has the non POSIX egrep instead
(which doesn't support -q too).

[...]

> I'm also not entirely sure you want to make that pattern stricter - t=
he=20
> whole problem with the old pattern was that it was too exact, so why =
add=20
> the beginning/end requirement?
>=20

Just to be sure it doesn't match "garbage".=20
Initial regexp was using a straight '.' operator, so while fixing it, I
thought it would be better to achieve "perfect match".

Regards.

--=20
Yann Droneaud
