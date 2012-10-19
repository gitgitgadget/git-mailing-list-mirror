From: Cristian Tibirna <ctibirna@giref.ulaval.ca>
Subject: fatal: cannot convert from utf8 to UTF-8
Date: Thu, 18 Oct 2012 20:03:26 -0400
Organization: GIREF
Message-ID: <1532361.Y42DjGJIX1@leto>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 03:08:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP14b-00033Q-J3
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 03:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab2JSBIF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 21:08:05 -0400
Received: from walter.accountservergroup.com ([50.22.11.10]:42821 "EHLO
	walter.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752137Ab2JSBIE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 21:08:04 -0400
X-Greylist: delayed 3874 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2012 21:08:04 EDT
Received: from modemcable066.126-58-74.mc.videotron.ca ([74.58.126.66]:59839 helo=leto.localnet)
	by walter.accountservergroup.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <ctibirna@giref.ulaval.ca>)
	id 1TP03k-00098o-Ki; Thu, 18 Oct 2012 19:03:28 -0500
User-Agent: KMail/4.9.2 (Linux/3.4.11-2.16-desktop; KDE/4.9.2; x86_64; ; )
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - walter.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - giref.ulaval.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208036>


This error:

fatal: cannot convert from utf8 to UTF-8

occured in two distinct situations in our work group with git binaries =
older=20
or equal to 1.7.7. Once during a commit, the other time during a rebase=
=2E Both=20
occurences are 100% reproductible. But the commit that gives the error =
during=20
a rebase doesn't do so in a cherry-pick.

This is in part our fault: during the standardisation of our git enviro=
nment,=20
we (re)enforced UTF-8 encodings by setting "i18n.commitenconding" and=20
"i18n.logOutputEncoding" to "utf8".

It is the "i18n.logOutputEncoding =3D utf8" that *sometimes* triggers t=
he error=20
above.

I know "utf8" is not an accepted denomination ("UTF-8" or "utf-8" shoul=
d be=20
used, according to IANA standards), but we have attenuating circumstanc=
es in=20
the fact that most things dealing with encoding accept the erroneous na=
me.=20
That includes at least iconv(1) and python(1). Thus we ignored that a=20
distinction existed and, as self-respecting lazy typers, we preferred t=
he (one=20
touch) shorter version.

I wonder if it should be expected that git accepts these name variants =
("utf8"=20
and "UTF8") as valid and equivalent to the standard ones.

Of course it is very easy for us to work around the error, since settin=
g=20
"i18n.logOutputEncoding =3D utf-8" or removing it altogether from the g=
it config=20
file chases the error away. It's only that these kinds of things are bo=
und to=20
happen and for a good proportion of git users it might be well opaque,=20
difficult to fix and, in drastic (user ignorance-induced) cases, a=20
showstopper.

Thanks for listening.

--=20
Cristian Tibirna				(418) 656-2131 / 4340
  Laval University - Qu=E9bec, CAN ... http://www.giref.ulaval.ca/~ctib=
irna
  Research professional - GIREF ... ctibirna@giref.ulaval.ca
