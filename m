From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v2] use cache for function names in hunk headers
Date: Mon, 27 Sep 2010 10:52:22 -0700
Message-ID: <7v39sv13c9.fsf@alter.siamese.dyndns.org>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
 <20100923070439.GA29764@localhost> <4C9F7450.9060208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Sep 27 19:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Hsb-0004VW-PN
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 19:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759976Ab0I0Rwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 13:52:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056Ab0I0Rwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 13:52:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C524FD9492;
	Mon, 27 Sep 2010 13:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tOQTJJlpOhDZ
	F2Wf/sSoFAEa+jg=; b=sbGGztdoDOkLAAyuAVVE4OzNggaTkC1GfgTCYCKa1z2M
	rjXg0CyOYVVPoV5LSc6L5Cf2xFSaGZVc5zSqlJNv4vdo2+YnzpJYu8/FWIe9chmb
	n4BV0bKLw6FlVz0VFU2KUxb3HvAre1KynYgizQs78dDMjTPu3bj5/N3TLR4gJK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mYUDSV
	K0VvP+R2Kx90G7iTMGMa1K1z37nODvI7XuI1jZJ5a3qTsKH8m0ljlAVXR/jkxf+K
	bkhO1RkeMBk2YZOZVSS9pPoLfg8vCDeEh0I7bSBTZkELDp39akbpt5xbMuS9FdQU
	Z9UylDRX8iCP/9giPR7Vnw6sgurvF+zb5SqlI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 930C1D9491;
	Mon, 27 Sep 2010 13:52:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F55DD948F; Mon, 27 Sep
 2010 13:52:24 -0400 (EDT)
In-Reply-To: <4C9F7450.9060208@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun\, 26 Sep 2010 18\:26\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE8BEF84-CA5F-11DF-9D79-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157358>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> How about something like this?  It also removes an outdated comment. =
 The
> inlining part should probably split out in its own patch..
>
>  xdiff/xemit.c |   38 ++++++++++++++------------------------
>  1 files changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index c4bedf0..a663f21 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -85,27 +85,6 @@ static long def_ff(const char *rec, long len, char=
 *buf, long sz, void *priv)
>  	return -1;
>  }
> =20
> -static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, =
long *ll,
> -		find_func_t ff, void *ff_priv) {
> -
> -	/*
> -	 * Be quite stupid about this for now.  Find a line in the old file
> -	 * before the start of the hunk (and context) which starts with a
> -	 * plausible character.
> -	 */
> -
> -	const char *rec;
> -	long len;
> -
> -	while (i-- > 0) {
> -		len =3D xdl_get_rec(xf, i, &rec);
> -		if ((*ll =3D ff(rec, len, buf, sz, ff_priv)) >=3D 0)
> -			return;
> -	}
> -	*ll =3D 0;
> -}
> -
> -
>  static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_=
t *ecb,
>                             xdemitconf_t const *xecfg) {
>  	xdfile_t *xdf =3D &xe->xdf1;
> @@ -127,6 +106,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr,=
 xdemitcb_t *ecb,
>  	xdchange_t *xch, *xche;
>  	char funcbuf[80];
>  	long funclen =3D 0;
> +	long funclineprev =3D -1;
>  	find_func_t ff =3D xecfg->find_func ?  xecfg->find_func : def_ff;
> =20
>  	if (xecfg->flags & XDL_EMIT_COMMON)
> @@ -150,9 +130,19 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr=
, xdemitcb_t *ecb,
>  		 */
> =20
>  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
> -			xdl_find_func(&xe->xdf1, s1, funcbuf,
> -				      sizeof(funcbuf), &funclen,
> -				      ff, xecfg->find_func_priv);
> +			long l;
> +			for (l =3D s1 - 1; l >=3D 0 && l > funclineprev; l--) {
> +				const char *rec;
> +				long reclen =3D xdl_get_rec(&xe->xdf1, l, &rec);
> +				long newfunclen =3D ff(rec, reclen, funcbuf,
> +						     sizeof(funcbuf),
> +						     xecfg->find_func_priv);
> +				if (newfunclen >=3D 0) {
> +					funclen =3D newfunclen;
> +					break;
> +				}
> +			}
> +			funclineprev =3D s1 - 1;
>  		}
>  		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
>  				      funcbuf, funclen, ecb) < 0)

Looks much more straightforward ;-)
