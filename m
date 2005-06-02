From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Thu, 02 Jun 2005 13:03:49 -0400
Message-ID: <1117731830.32257.52.camel@jmcmullan.timesys>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net> <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net> <7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-ruIil/Mt8pf3nEIXPaVg";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:02:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddt3u-00057q-9l
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 19:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFBRD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 13:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVFBRD4
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 13:03:56 -0400
Received: from mail.timesys.com ([65.117.135.102]:1913 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261192AbVFBRDx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 13:03:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 02 Jun 2005 13:03:50 -0400
In-Reply-To: <7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Thu, 2 Jun 2005 12:57:02 -0400
Message-ID: <1117731830.32257.52.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Handle deltified object correctly in git-*-pull family.
thread-index: AcVnlBkA4Lz/0YpXSy6rQzzxR8lIRQ==
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ruIil/Mt8pf3nEIXPaVg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-06-02 at 09:46 -0700, Junio C Hamano wrote:
> When a remote repository is deltified, we need to get the
> objects that a deltified object we want to obtain is based upon.
> The initial parts of each retrieved SHA1 file is inflated and
> inspected to see if it is deltified, and its base object is
> asked from the remote side when it is.  Since this partial
> inflation and inspection has a small performance hit, it can
> optionally be skipped by giving -d flag to git-*-pull commands.
> This flag should be used only when the remote repository is
> known to have no deltified objects.

Eww. Don't you want to attempt to get the referenced sha1 *before*
you stick the delta blob into the repository?

Otherwise, if a transfer fails, there's no good way to recover your
database through the git-*pull interfaces, ie:

Try to pull session 1:
  pull tree a
    pull delta b (references blob c)
    pull blob c -> fails!

Try to pull session 2:
  pull tree a
    delta b - Found in database!
    ...

Or do I not understand your code properly?

(I'm working on a similar piece of code for my git-daemon protocol,
 which is why I'm worried about this issue)
  =20
--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-ruIil/Mt8pf3nEIXPaVg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCnzv18/0vJ5szK6kRAmdHAKCKozQvPC3yTQorYdKHofRRCvK9OgCfXZz3
XSDVa9CuzYAzGPIZNSsThYc=
=GLEs
-----END PGP SIGNATURE-----

--=-ruIil/Mt8pf3nEIXPaVg--
