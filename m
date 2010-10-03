From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 2/6] tg-remote: use default remote if non is
	given
Date: Mon, 4 Oct 2010 00:00:52 +0200
Message-ID: <20101003220052.GD28679@pengutronix.de>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com> <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Peter Simons <simons@cryp.to>,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 00:01:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2WcA-00014W-OC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 00:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab0JCWA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 18:00:57 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60558 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab0JCWA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 18:00:56 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2Wc2-0002CU-W2; Mon, 04 Oct 2010 00:00:54 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2Wc0-0001wV-Vn; Mon, 04 Oct 2010 00:00:52 +0200
Content-Disposition: inline
In-Reply-To: <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157937>

Hello,

On Sun, Oct 03, 2010 at 11:25:53PM +0200, Bert Wesarg wrote:
> This is usefull if the remote has new topics and you need to populate=
 the local
> top-bases.
>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>=20
> ---
>  README       |    2 +-
>  tg-remote.sh |    5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/README b/README
> index c418ff4..5a54468 100644 README
> --- a/README
> +++ b/README
> @@ -327,7 +327,7 @@ tg remote
>  	and 'git push' to operate on them. (Do NOT use 'git push --all'
>  	for your pushes - plain 'git push' will do the right thing.)
> =20
> -	It takes a mandatory remote name argument, and optional
> +	It takes a optional remote name argument, and optional
>  	'--populate' switch - use that for your origin-style remote,
>  	it will seed the local topic branch system based on the
>  	remote topic branches. '--populate' will also make 'tg remote'
> diff --git a/tg-remote.sh b/tg-remote.sh
> index 86dcd9a..61774d7 100644 tg-remote.sh
> --- a/tg-remote.sh
> +++ b/tg-remote.sh
> @@ -15,13 +15,16 @@ while [ -n "$1" ]; do
>  	--populate)
>  		populate=3D1;;
>  	-*)
> -		echo "Usage: tg [...] remote [--populate] REMOTE" >&2
> +		echo "Usage: tg [...] remote [--populate] [REMOTE]" >&2
>  		exit 1;;
>  	*)
>  		name=3D"$arg";;
>  	esac
>  done
> =20
> +[ -n "$name" ] ||
> +	name=3D"$base_remote"
> +
Doesn't this need error checking, i.e. what happens if tg remote was
never called before?  Hmm, seems to be a problem that already exists
now?!  Took your patch anyhow.

>  git config "remote.$name.url" >/dev/null || die "unknown remote '$na=
me'"
> =20
> =20
> --=20
> tg: (29ab4cf..) bw/tg-remote-use-defualt-remote (depends on: master)
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
