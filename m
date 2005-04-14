From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: [patch pasky] refresh cache after changing tracked tree
Date: Fri, 15 Apr 2005 00:54:11 +0200
Message-ID: <1113519251.23299.115.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CTJQXhhij/npvpooM16Y"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:48:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMD7M-0002G3-6L
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVDNWuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDNWun
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:50:43 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:11256 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261620AbVDNWu0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:50:26 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id 7AD636F97;
	Fri, 15 Apr 2005 00:50:21 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id D69E83A26DB;
	Fri, 15 Apr 2005 00:56:26 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22424-02; Fri, 15 Apr 2005 00:56:21 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id CCDC43A26DA;
	Fri, 15 Apr 2005 00:56:21 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-CTJQXhhij/npvpooM16Y
Content-Type: multipart/mixed; boundary="=-aBrTsX5q0ZvnJRJamrvC"


--=-aBrTsX5q0ZvnJRJamrvC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I see the latest gitdiff-do does the right thing regarding modes, but we
still need to refresh the cache.


Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
--- 03d6db1fb3a70605ef249c632c04e542457f0808/gittrack.sh
+++ uncommitted/gittrack.sh
@@ -51,6 +51,7 @@

        read-tree $(tree-id "$name")
        gitdiff.sh local "$name" | gitapply.sh
+       update-cache --refresh

 else
        [ "$tracking" ] || \
@@ -61,6 +62,7 @@
        if [ -s ".git/HEAD.local" ]; then
                gitdiff.sh "$tracking" local | gitapply.sh
                read-tree $(tree-id local)
+               update-cache --refresh

                head=3D$(cat .git/HEAD)
                branchhead=3D$(cat .git/heads/$tracking)


--=20
Martin Schlemmer


--=-aBrTsX5q0ZvnJRJamrvC
Content-Disposition: attachment; filename=git-track-update_cache.patch
Content-Type: text/x-patch; name=git-track-update_cache.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Z2l0dHJhY2suc2g6ICAwM2Q2ZGIxZmIzYTcwNjA1ZWYyNDljNjMyYzA0ZTU0MjQ1N2YwODA4DQot
LS0gMDNkNmRiMWZiM2E3MDYwNWVmMjQ5YzYzMmMwNGU1NDI0NTdmMDgwOC9naXR0cmFjay5zaA0K
KysrIHVuY29tbWl0dGVkL2dpdHRyYWNrLnNoDQpAQCAtNTEsNiArNTEsNyBAQA0KIA0KIAlyZWFk
LXRyZWUgJCh0cmVlLWlkICIkbmFtZSIpDQogCWdpdGRpZmYuc2ggbG9jYWwgIiRuYW1lIiB8IGdp
dGFwcGx5LnNoDQorCXVwZGF0ZS1jYWNoZSAtLXJlZnJlc2gNCiANCiBlbHNlDQogCVsgIiR0cmFj
a2luZyIgXSB8fCBcDQpAQCAtNjEsNiArNjIsNyBAQA0KIAlpZiBbIC1zICIuZ2l0L0hFQUQubG9j
YWwiIF07IHRoZW4NCiAJCWdpdGRpZmYuc2ggIiR0cmFja2luZyIgbG9jYWwgfCBnaXRhcHBseS5z
aA0KIAkJcmVhZC10cmVlICQodHJlZS1pZCBsb2NhbCkNCisJCXVwZGF0ZS1jYWNoZSAtLXJlZnJl
c2gNCiANCiAJCWhlYWQ9JChjYXQgLmdpdC9IRUFEKQ0KIAkJYnJhbmNoaGVhZD0kKGNhdCAuZ2l0
L2hlYWRzLyR0cmFja2luZykNCg==


--=-aBrTsX5q0ZvnJRJamrvC--

--=-CTJQXhhij/npvpooM16Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXvSTqburzKaJYLYRAgbPAJ0d6FCUgpexZUkck0sE9g5fRNSlagCeJacL
mM8V38hC1X787atDQSHvPZ0=
=MT/t
-----END PGP SIGNATURE-----

--=-CTJQXhhij/npvpooM16Y--

