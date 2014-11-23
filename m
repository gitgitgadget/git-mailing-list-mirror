From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Sun, 23 Nov 2014 17:12:59 +0000
Message-ID: <5472159B.4060905@ramsay1.demon.co.uk>
References: <5471EC26.3040705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 23 18:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsajI-0004Ok-M6
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 18:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaKWRNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2014 12:13:11 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:48022 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751253AbaKWRNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 12:13:11 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5E6DAA64EF8;
	Sun, 23 Nov 2014 17:13:08 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 1121AA64E34;
	Sun, 23 Nov 2014 17:13:08 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun, 23 Nov 2014 17:13:07 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5471EC26.3040705@web.de>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260090>

On 23/11/14 14:16, Torsten B=C3=B6gershausen wrote:
> gcc under cygwin reports several warnings like this:
>  warning: implicit declaration of function 'memmem'
>   [-Wimplicit-function-declaration]
> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
> as CYGWIN-64 with gcc v4.8.3-5 x86-64

Heh, thanks for looking into this. Your email came at a good time,
since I was just about to boot my old laptop into windows XP to
test my patch on 32-bit cygwin! (If I had not been watching the
=461 Grand Prix on TV, I would already have done so! ;-) ).

It's been a while since I updated my 32-bit cygwin installation
(about 6 months) but I'm a little surprised you found this issue
with gcc 4.7.3 (I'm _almost_ tempted to boot that laptop anyway
just to see what versions of software it is running).

Just for the reccord, my patch follows.

ATB,
Ramsay Jones

>=20
> Do not #define _XOPEN_SOURCE 600 for CYGWIN.
>=20
> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> This may be a start for a patch, tested under CYGWIN-32,
> both Windows7 and XP
>  git-compat-util.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 400e921..cef2691 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -75,7 +75,8 @@
>  # endif
>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USL=
C__) && \
>        !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__=
) && \
> -      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__=
)
> +      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__=
) && \
> +      !defined(__CYGWIN__)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD n=
eeds 600 for S_ISLNK() */
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
>=20
