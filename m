From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Sat, 9 Aug 2008 12:00:19 +0200
Message-ID: <200808091200.21634.trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch> <200808082037.49918.trast@student.ethz.ch> <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8253307.IxbjYPbSuh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 09 12:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRlHN-0005Kd-RP
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 12:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbYHIKAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 06:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbYHIKAO
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 06:00:14 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:39184 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbYHIKAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 06:00:13 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Aug 2008 12:00:10 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Aug 2008 12:00:11 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-OriginalArrivalTime: 09 Aug 2008 10:00:11.0134 (UTC) FILETIME=[B61079E0:01C8FA06]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91761>

--nextPart8253307.IxbjYPbSuh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> But hey, if other people agree with you, and this kind of thinking ends=20
> up in Git proper, I can still resort to other DVCSes.

BTW, the following is fairly ironic.  (It was later rewritten in
813b473 to the current one-shot 'rev-list --parents' form.)

commit 685ef546b62d063c72b401cd38b83a879301aac4
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Fri Jun 8 01:30:35 2007 +0100

    Teach filter-branch about subdirectory filtering
   =20
    With git-filter-branch --subdirectory-filter <subdirectory> you can
    get at the history, as seen by a certain subdirectory. The history
    of the rewritten branch will only contain commits that touched that
    subdirectory, and the subdirectory will be rewritten to be the new
    project root.
   =20
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
[...snip...]
@@ -224,7 +228,13 @@ set_ident () {
=20
 # list all parent's object names for a given commit
 get_parents () {
=2D	git-rev-list -1 --parents "$1" | sed "s/^[0-9a-f]*//"
+	case "$filter_subdir" in
+	"")
+		git-rev-list -1 --parents "$1"
+		;;
+	*)
+		git-rev-list -1 --parents "$1" -- "$filter_subdir"
+	esac | sed "s/^[0-9a-f]*//"
 }
=20
 tempdir=3D.git-rewrite
[...snip...]

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart8253307.IxbjYPbSuh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkidarUACgkQqUud07tmzP0GBACgllYlBbcx56oThh+qS1OhssQz
ga8An15YUgjJ4if1gzXP+fkGDO1PP7DF
=Cpoc
-----END PGP SIGNATURE-----

--nextPart8253307.IxbjYPbSuh--
