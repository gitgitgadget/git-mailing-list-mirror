From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] repack: don't report "Nothing new to pack." if -q is given
Date: Tue, 3 Jul 2007 21:17:16 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070703191716.GA22775@informatik.uni-freiburg.de>
References: <20070703084757.GA4694@lala> <20070703181923.GE4580@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 21:17:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5nsK-0008Vg-4z
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428AbXGCTRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Jul 2007 15:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756236AbXGCTRV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:17:21 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33365 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755912AbXGCTRU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 15:17:20 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I5nsF-00039N-2C
	for git@vger.kernel.org; Tue, 03 Jul 2007 21:17:19 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l63JHGDU023073
	for <git@vger.kernel.org>; Tue, 3 Jul 2007 21:17:16 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l63JHGq4023072
	for git@vger.kernel.org; Tue, 3 Jul 2007 21:17:16 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070703181923.GE4580@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51525>

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
Peter Baumann wrote:
> On Tue, Jul 03, 2007 at 10:47:58AM +0200, Uwe Kleine-K=F6nig wrote:
> >  	exit 1
> >  if [ -z "$name" ]; then
> > -	echo Nothing new to pack.
> > +	if test -q "$quiet"; then
> > +		echo Nothing new to pack.
> > +	fi
>=20
> This looks wrong, especially as I can't find a '-q' in the manpage of=
 "test".
> Perhaps you ment something like the following code, which is already =
used in
> the script:
>=20
> 	if test "$quiet" !=3D '-q'; then
> 		echo ...
> 	fi
actually I meant test -z "$quiet", but test "$quiet" !=3D '-q' would be
equally good.

Thanks for noticing.

Uwe

 git-repack.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index ddfa8b4..1ce2760 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -65,7 +65,9 @@ args=3D"$args $local $quiet $no_reuse_delta$extra"
 name=3D$(git-pack-objects --non-empty --all --reflog $args </dev/null =
"$PACKTMP") ||
 	exit 1
 if [ -z "$name" ]; then
-	echo Nothing new to pack.
+	if test -z "$quiet"; then
+		echo Nothing new to pack.
+	fi
 else
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
--=20
1.5.2.2.1451.gb0e5e



> > Best regards
> > Uwe
> >=20
> >  git-repack.sh |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/git-repack.sh b/git-repack.sh
> > index ddfa8b4..d980275 100755
> > --- a/git-repack.sh
> > +++ b/git-repack.sh
> > @@ -65,7 +65,9 @@ args=3D"$args $local $quiet $no_reuse_delta$extra=
"
> >  name=3D$(git-pack-objects --non-empty --all --reflog $args </dev/n=
ull "$PACKTMP") ||

> -Peter
>=20

--=20
Uwe Kleine-K=F6nig

$ dc -e "5735816763073014741799356604682P"
