From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 16:26:13 -0500
Message-ID: <20080123212613.GN2230@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 22:51:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHnVe-00035q-91
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 22:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYAWVvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 16:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYAWVvQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 16:51:16 -0500
Received: from yugib.highrise.ca ([205.150.199.213]:54070 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbYAWVvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 16:51:15 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2008 16:51:15 EST
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 1E33F111E3A;
	Wed, 23 Jan 2008 16:26:13 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71573>


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I know - openserver, yuch, bla bla bla... Not my choice, but sometimes
we have to do things we don't like...

But, I've come across this in strbuf.c:
        va_start(ap, fmt);
        len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
        va_end(ap);
        if (len < 0)
                die("your vsnprintf is broken");

Now, that would seem to be the interpretation of vsnprintf I'm familiar
with too, but I read this in the SCO vsnprintf man page:

   snprintf (vsnprintf) behaves like sprintf (vsprintf), except that no
   more than maxsize characters are placed into the array, including the
   terminating null character. If more than maxsize characters were
   requested, the output array will contain exactly maxsize characters,
   with a null character being the last (when maxsize is nonzero); a
   negative value is returned.

   [...] 

   vfprintf(S-osr5), vprintf(S-osr5), and vsprintf(S-osr5) are conformant
   with :

   X/Open Portability Guide, Issue 3, 1989 ;
   and ANSI X3.159-1989 Programming Language -- C .

I guess this means that git is designed to not work on on systems such
as SCO that have what we (myself included) consider "broken" vsnprintf.

Is there any interest in trying to get strbuf to work with such broken
vsnprintf implementations?

I've got a couple of other small patches to make it "compile" on
OpenServer, but if this is too brain-dead to be worth supporting, there
is no point in cluttering things up more for compatibility which can't
really be used anyways.

a.



-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFHl7D1uVxNPsxNPScRArWQAJ9fF3QEpXpyXLTe4m/8G/IV3OWjLgCePM88
zVxevQbr8pUMlFkoY1qcD54=
=qiC2
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
