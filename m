From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] http: add support for specifying the SSL version
Date: Wed, 12 Aug 2015 15:33:19 +0200 (CEST)
Message-ID: <950187984.739852.1439386399510.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1439384456-16335-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 15:33:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPW9i-0003ga-T6
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 15:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbbHLNdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2015 09:33:18 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:42434 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751977AbbHLNdS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 09:33:18 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2015 09:33:17 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C1D402112;
	Wed, 12 Aug 2015 15:26:56 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9kw3kFX5gkle; Wed, 12 Aug 2015 15:26:56 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id AE8D820FE;
	Wed, 12 Aug 2015 15:26:56 +0200 (CEST)
In-Reply-To: <1439384456-16335-1-git-send-email-gitter.spiros@gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Win)/8.0.9_GA_6191)
Thread-Topic: http: add support for specifying the SSL version
Thread-Index: J4kB9z57wUVXvMgyRM9YQY+oRuZmtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275766>

Hello, Elia

Elia Pinto <gitter.spiros@gmail.com> writes:
> +        if (ssl_version !=3D NULL && *ssl_version) {
> +                if (!strcmp(ssl_version,"tlsv1")) {
> +                        sslversion =3D CURL_SSLVERSION_TLSv1;
> +                } else if (!strcmp(ssl_version,"sslv2")) {
> +                        sslversion =3D CURL_SSLVERSION_SSLv2;
> +                } else if (!strcmp(ssl_version,"sslv3")) {
> +                        sslversion =3D CURL_SSLVERSION_SSLv3;
> +#if LIBCURL_VERSION_NUM >=3D 0x072200
> +                } else if (!strcmp(ssl_version,"tlsv1.0")) {
> +                        sslversion =3D CURL_SSLVERSION_TLSv1_0;
> +                } else if (!strcmp(ssl_version,"tlsv1.1")) {
> +                        sslversion =3D CURL_SSLVERSION_TLSv1_1;
> +                } else if (!strcmp(ssl_version,"tlsv1.2")) {
> +                        sslversion =3D CURL_SSLVERSION_TLSv1_2;
> +                } else {
> +                        warning("unsupported ssl version %s : using =
default",
> +                        ssl_version);
> +#endif
> +                }
> +        }

I'm curious about what would happen should 'sslVersion' be set to
'tlsv1.0' (or a value that doesn't belong to the possible values) and
'LIBCURL_VERSION_NUM' be inferior to '0x072200'.
Since we wouldn't go through any 'if' and would also skip the 'else'
case, wouldn't we have a silent 'unsupported ssl version: using
default' ?

So I think that the 'else' case should be outside of the '#if [...]
#endif'.

Thanks,
R=C3=A9mi
