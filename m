From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] repack: don't report "Nothing new to pack." if -q is
	given
Date: Tue, 3 Jul 2007 20:19:23 +0200
Message-ID: <20070703181923.GE4580@xp.machine.xx>
References: <20070703084757.GA4694@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:19:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5my4-00042Z-6e
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 20:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbXGCSTO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Jul 2007 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754601AbXGCSTO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 14:19:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:47240 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754556AbXGCSTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 14:19:13 -0400
Received: (qmail invoked by alias); 03 Jul 2007 18:19:11 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp049) with SMTP; 03 Jul 2007 20:19:11 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18rRessyvAroVzJYiB1s2LlH24YUORif7JcExiX0L
	JeDRqP4MnUnij3
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070703084757.GA4694@lala>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51520>

On Tue, Jul 03, 2007 at 10:47:58AM +0200, Uwe Kleine-K=F6nig wrote:
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.d=
e>
> ---
> This patch is on top of maint.  For master and next you need
> s/name/names/.
>=20
> Best regards
> Uwe
>=20
>  git-repack.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-repack.sh b/git-repack.sh
> index ddfa8b4..d980275 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -65,7 +65,9 @@ args=3D"$args $local $quiet $no_reuse_delta$extra"
>  name=3D$(git-pack-objects --non-empty --all --reflog $args </dev/nul=
l "$PACKTMP") ||
>  	exit 1
>  if [ -z "$name" ]; then
> -	echo Nothing new to pack.
> +	if test -q "$quiet"; then
> +		echo Nothing new to pack.
> +	fi

This looks wrong, especially as I can't find a '-q' in the manpage of "=
test".
Perhaps you ment something like the following code, which is already us=
ed in
the script:

	if test "$quiet" !=3D '-q'; then
		echo ...
	fi

-Peter
