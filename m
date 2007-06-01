From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] catch asciidoc failures
Date: Fri, 1 Jun 2007 10:36:21 +0200
Message-ID: <20070601083621.GB3521@admingilde.org>
References: <11806790373908-git-send-email-slamb@slamb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu2ca-0000SB-Uy
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 10:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbXFAIgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 04:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbXFAIgY
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 04:36:24 -0400
Received: from mail.admingilde.org ([213.95.32.147]:37361 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbXFAIgX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 04:36:23 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hu2cP-0007Iy-Jc; Fri, 01 Jun 2007 10:36:21 +0200
Content-Disposition: inline
In-Reply-To: <11806790373908-git-send-email-slamb@slamb.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48852>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, May 31, 2007 at 11:23:57PM -0700, Scott Lamb wrote:
> If pipefail is available (GNU bash >=3D 3.00), fail when asciidoc returns
> error rather than possibly later during XSLT.

perhaps we should simply change the pipe ordering to get asciidoc
to the end of the pipeline so that all shells respect its exit code?

> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -111,6 +111,7 @@ clean:
> =20
>  %.html : %.txt
>  	rm -f $@+ $@
> +	set -o pipefail 2>/dev/null; \
>  	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
>  		$(ASCIIDOC_EXTRA) -o - $< | \
>  		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+

something like (untested):
	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $< |
		$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
			$(ASCIIDOC_EXTRA) -o $@+ -

--=20
Martin Waitz

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGX9qFj/Eaxd/oD7IRAuIbAJ9ewj02QkdMuFTYbEWvosmnsXTmwwCeK4fD
aSv7KH2EeE1/dYJK3j7pYqQ=
=qcsP
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
