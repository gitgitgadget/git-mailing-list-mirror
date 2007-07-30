From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] add series editor support.
Date: Mon, 30 Jul 2007 12:26:24 +0200
Message-ID: <5C7E2F1B-A11F-4958-9662-88B0EFA07F79@lrde.epita.fr>
References: <20070730100512.GA14637@dnb.sw.ru>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--821928860"
Content-Transfer-Encoding: 7bit
Cc: Josef Jeff Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 12:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFSSc-0002W4-8X
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbXG3K0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbXG3K0n
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:26:43 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38066 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbXG3K0m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:26:42 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IFSSU-000662-UL; Mon, 30 Jul 2007 12:26:39 +0200
In-Reply-To: <20070730100512.GA14637@dnb.sw.ru>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54222>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--821928860
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Jul 30, 2007, at 12:05 PM, Dmitry Monakhov wrote:

> Usually we have to edit series file directly (via editor).
> I think it is not bad idea to let guilt export this service.
> IMHO "guilt-series -e" it the best way to do it.
>
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  guilt-series |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/guilt-series b/guilt-series
> index 62c3bb1..7594b2e 100755
> --- a/guilt-series
> +++ b/guilt-series
> @@ -3,7 +3,7 @@
>  # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
>  #
>
> -USAGE="[-v | -g]"
> +USAGE="[-v | -g | -e]"
>  . `dirname $0`/guilt
>
>  while case "$#" in 0) break ;; esac
> @@ -13,13 +13,18 @@ do
>  		verbose=t ;;
>  	-g)
>  		gui=t ;;
> +	-e)
> +		edit=t ;;
>  	*)
>  		usage ;;
>  	esac
>  	shift
>  done
>
> -if [ ! -z "$gui" ]; then
> +# edit -e ?
> +if [ "$edit" = "t" ]; then
> +	$editor "$GUILT_DIR/$branch/series"
> +elif [ ! -z "$gui" ]; then
>  	[ -z "`get_top`" ] && die "No patches applied."
>  	bottom=`head -1 $applied | cut -d: -f1`
>  	top=`tail -1 $applied | cut -d: -f1`

Hi,
Why do you use string comparisons instead of initializing all the  
variables to false and setting them to `:' or `true' so that you can  
then write if $edit; then ... ?  It's suboptimal.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-5--821928860
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGrbzQwwE67wC8PUkRAhAGAKCCrtP189vvUlaXdZbH0JmSNXBPVACeLC04
q1XA3dZMN7E2EWYC0fMgQNs=
=BS6Z
-----END PGP SIGNATURE-----

--Apple-Mail-5--821928860--
