From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Bisect run: "skip" current commit if script exit code is 125.
Date: Fri, 26 Oct 2007 08:25:21 +0200
Message-ID: <A43880E9-E496-48AA-BC1C-2C98DFD12370@lrde.epita.fr>
References: <20071026053937.2831a89b.chriscool@tuxfamily.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-324357038"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 08:25:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlIda-0002Ix-FT
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 08:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXJZGZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 02:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbXJZGZ3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 02:25:29 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:59915 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbXJZGZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 02:25:28 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IlIdK-0002Bz-QN; Fri, 26 Oct 2007 08:25:26 +0200
In-Reply-To: <20071026053937.2831a89b.chriscool@tuxfamily.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62394>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-324357038
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 26, 2007, at 5:39 AM, Christian Couder wrote:

> This is incompatible with previous versions because an exit code
> of 125 used to mark current commit as "bad". But hopefully this exit
> code is not much used by test scripts or other programs. (126 and 127
> are used by bash.)
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-bisect.txt |    8 ++++++--
>  git-bisect.sh                |   11 ++++++++++-
>  t/t6030-bisect-porcelain.sh  |   40 +++++++++++++++++++++++++++++++ 
> +++++++++
>  3 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git- 
> bisect.txt
> index 785f381..14b7a95 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -183,13 +183,17 @@ $ git bisect run my_script
>
>  Note that the "run" script (`my_script` in the above example) should
>  exit with code 0 in case the current source code is good and with a
> -code between 1 and 127 (included) in case the current source code is
> -bad.
> +code between 1 and 127 (included), except 125 that is special, in  
> case
> +the current source code is bad.
>
>  Any other exit code will abort the automatic bisect process. (A
>  program that does "exit(-1)" leaves $? = 255, see exit(3) manual  
> page,
>  the value is chopped with "& 0377".)
>
> +The special exit code 125 should be used when the current source code
> +cannot be tested. If the "run" script exits with this code, the  
> current
> +revision will be "skip"ped, see `git bisect skip` above.
> +
>  You may often find that during bisect you want to have near-constant
>  tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or
>  "revision that does not have this commit needs this patch applied to

Since exit 77 is already used by automake to mean "skip", wouldn't it  
be better to do the same thing here?

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-1-324357038
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHIYhRwwE67wC8PUkRAtvUAJ9cb059aWjc6ROYCoU5T+NcAxnVLgCfcbJJ
6XPWfQb9tVyo2Soc4iXOcEA=
=X+Sc
-----END PGP SIGNATURE-----

--Apple-Mail-1-324357038--
