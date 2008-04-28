From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use "=" instead of "==" in condition as it is more portable
Date: Mon, 28 Apr 2008 23:09:55 +0200
Message-ID: <20080428210955.GB10600@steel.home>
References: <7vfxtcsbis.fsf@gitster.siamese.dyndns.org> <20080428163642.GA22790@neumann>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?iso-8859-15?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:11:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqacr-0003iW-51
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938030AbYD1VJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 17:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbYD1VJ7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:09:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:17771 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938024AbYD1VJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:09:58 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZBJxGkw==
Received: from tigra.home (Faada.f.strato-dslnet.de [195.4.170.218])
	by post.webmailer.de (fruni mo62) (RZmta 16.27)
	with ESMTP id v07182k3SJIMvT ; Mon, 28 Apr 2008 23:09:56 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EB0F8277BD;
	Mon, 28 Apr 2008 23:09:55 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 09C6556D28; Mon, 28 Apr 2008 23:09:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080428163642.GA22790@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80613>

At least the dash from Ubuntu's /bin/sh says:

    test: 233: =3D=3D: unexpected operator

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
SZEDER G=E1bor, Mon, Apr 28, 2008 18:36:42 +0200:
> On Wed, Apr 23, 2008 at 10:53:47AM -0700, Junio C Hamano wrote:
> > "git clone [options] $src $dst excess-garbage" simply ignored
> > excess-garbage without giving any diagnostic message.  Fix it.
> >=20
> >  	dir=3D"$2"
> > +	test $# =3D=3D 2 || die "excess parameter to git-clone"
>                 ^^
> I think you mean:
>=20
>     test $# =3D 2 || die "excess parameter to git-clone"
>=20
> I just noticed because it broke t1020-subdirectory at me.

And me. Almost every test which uses git-clone (I expect some don't
test its exit code in setup routines).

 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 9e433c0..8c7fc7f 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -219,7 +219,7 @@ fi
 if test -n "$2"
 then
 	dir=3D"$2"
-	test $# =3D=3D 2 || die "excess parameter to git-clone"
+	test $# =3D 2 || die "excess parameter to git-clone"
 else
 	# Derive one from the repository name
 	# Try using "humanish" part of source repo if user didn't specify one
--=20
1.5.5.1.118.g6dd1b6.dirty
