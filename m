From: Kristof Provost <Kristof@provost-engineering.be>
Subject: Re: [PATCH] makefile: Add a cscope target
Date: Sat, 6 Oct 2007 16:24:42 +0200
Message-ID: <20071006142442.GA4635@luggage>
References: <20071005223336.GA4556@luggage> <20071006010437.GS31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat Oct 06 16:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeAaU-0002Mu-Ap
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 16:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbXJFOYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 10:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbXJFOYu
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 10:24:50 -0400
Received: from rhineheart.priorweb.be ([213.193.229.215]:38872 "HELO
	rhineheart.priorweb.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753699AbXJFOYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 10:24:49 -0400
Received: (qmail 30970 invoked by uid 1010); 6 Oct 2007 14:24:45 -0000
Received: from unknown (HELO rhineheart.priorweb.be) (127.0.0.1)
  by rhineheart.priorweb.be with SMTP; 6 Oct 2007 14:24:45 -0000
Received: from luggage (dD5767E05.access.telenet.be [213.118.126.5])
	by rhineheart.priorweb.be (Postfix) with SMTP;
	Sat,  6 Oct 2007 16:24:42 +0200 (CEST)
Received: by luggage (sSMTP sendmail emulation); Sat, 06 Oct 2007 16:24:43 +0200
Content-Disposition: inline
In-Reply-To: <20071006010437.GS31659@planck.djpig.de>
X-PGP-Fingerprint: 6B6E 5EED 8ECF FAE7 1F61  7458 5046 7D0E 11B0 0EE8
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Virus-Scanned: Passed
X-Spam-Scanned: 2.0
X-Spam-Status: NO
X-Scanned-By: PriorWeb mailfilter
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60147>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2007-10-06 03:04:37 (+0200), Frank Lichtenheld <frank@lichtenheld.de> wr=
ote:
> On Sat, Oct 06, 2007 at 12:33:36AM +0200, Kristof Provost wrote:
> > +cscope:
> > +	$(RM) cscope*
> > +	$(FIND) . -name '*.hcS]' -print | xargs cscope -b
>=20
>=20
> missing [
Well, that will teach me to post patches after midnight.

Here's a fixed version. I've also added cscope* to the .gitignore file.
For some reason tags and TAGS weren't in there either so I've added them
too.

Signed-off-by: Kristof Provost <Kristof@provost-engineering.be>

---
diff --git a/.gitignore b/.gitignore
index e0b91be..62afef2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,3 +171,6 @@ config.status
 config.mak.autogen
 config.mak.append
 configure
+tags
+TAGS
+cscope*
diff --git a/Makefile b/Makefile
index 8db4dbe..e2790c8 100644
--- a/Makefile
+++ b/Makefile
@@ -947,6 +947,10 @@ tags:
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
=20
+cscope:
+	$(RM) cscope*
+	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
+
 ### Detect prefix changes
 TRACK_CFLAGS =3D $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
@@ -1093,7 +1097,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
-	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
+	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) configure config.log config.mak.autogen config.mak.append config.st=
atus config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
@@ -1111,7 +1115,7 @@ endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS
=20
 .PHONY: all install clean strip
-.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags .FORCE-GIT-CFLAGS
+.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS=20
=20
 ### Check documentation
 #


--
Kristof
=20

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHB5qqUEZ9DhGwDugRAut/AKCWhmwyJ348YcARJsZo6nLT6+1cyQCeM53W
ihfQqnRUS1KfXyW7p8xbbbo=
=Rxvv
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
