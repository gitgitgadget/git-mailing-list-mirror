From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fsck: treat a NUL in a tag header as an error
Date: Fri, 20 Nov 2015 06:13:14 -0500
Message-ID: <20151120111312.GA11198@sigill.intra.peff.net>
References: <564DF6BE.6020609@web.de>
 <564DF7FB.3090704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzjdE-0008U7-3i
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759845AbbKTLNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2015 06:13:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:60042 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759838AbbKTLNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:13:17 -0500
Received: (qmail 17450 invoked by uid 102); 20 Nov 2015 11:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:13:17 -0600
Received: (qmail 26378 invoked by uid 107); 20 Nov 2015 11:13:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:13:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:13:14 -0500
Content-Disposition: inline
In-Reply-To: <564DF7FB.3090704@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281504>

On Thu, Nov 19, 2015 at 05:25:31PM +0100, Ren=C3=A9 Scharfe wrote:

> We check the return value of verify_header() for commits already, so =
do
> the same for tags as well.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  fsck.c          | 3 ++-
>  t/t1450-fsck.sh | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fsck.c b/fsck.c
> index e41e753..4060f1f 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -711,7 +711,8 @@ static int fsck_tag_buffer(struct tag *tag, const=
 char *data,
>  		}
>  	}
> =20
> -	if (verify_headers(buffer, size, &tag->object, options))
> +	ret =3D verify_headers(buffer, size, &tag->object, options);
> +	if (ret)
>  		goto done;

Good catch. The patch look reasonable to me.

-Peff
