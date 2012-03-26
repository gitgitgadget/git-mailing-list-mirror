From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show loop
Date: Sun, 25 Mar 2012 21:34:28 -0700
Message-ID: <7v7gy8rne3.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1203241101390.2046@localhost6.localdomain6>
 <4F6DB4E9.3090402@in.waw.pl> <4F6DC151.9040707@in.waw.pl>
 <4F6DE5D6.4010408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Julia Lawall <julia.lawall@lip6.fr>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 26 06:35:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC1e1-0003YO-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 06:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab2CZEed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 00:34:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab2CZEec convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 00:34:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC0BE7106;
	Mon, 26 Mar 2012 00:34:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aIQ1koCBtOFP
	4hcbOscaxUKliW4=; b=Dqm4jslJN8ev0QGek1fpAL50ltdpcDVHk8pQhATrCNJ4
	D4IakS0Ni9JPxCCV/lxy6MyGdjKlEqpv7+PaVnU0gcW07dI+d2zVcgIlVfPnDWC/
	ZIPVB6FO3hmp5rDYVoQpkw90OdxdOwPb8z9WVYEW9p7s+DVzXbYtwoMsiEs5vFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=W+bpdg
	Tq9mncluhWqNX7fsye6XGfJ8XrA0s5xf+1OVV9+Yr5R3x+1FrFOeyc8Z3rM6rFXp
	4xZniMHM74e7Qu0xz6UbgaaojjOAoRv/Hi3Nb8GaAt4dCGRdjG2EsRECyWSolxOf
	+cdcZoc+6+Na8Sl00kxhZzYF7O7u5MkBZNU6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E30357105;
	Mon, 26 Mar 2012 00:34:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7382F7104; Mon, 26 Mar 2012
 00:34:30 -0400 (EDT)
In-Reply-To: <4F6DE5D6.4010408@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 24 Mar 2012 16:18:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA877D72-76FC-11E1-9094-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193897>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Subject: [PATCH] combine-diff: fix loop index underflow
>
> If both la and context are zero at the start of the loop, la wraps ar=
ound
> and we end up reading from memory far away.  Skip the loop in that ca=
se
> instead.
>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---

Thanks. This dates back to 1.3.0.

Will queue.

>  combine-diff.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index a2e8dcf..9786680 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -423,7 +423,7 @@ static int make_hunks(struct sline *sline, unsign=
ed long cnt,
>  						     hunk_begin, j);
>  				la =3D (la + context < cnt + 1) ?
>  					(la + context) : cnt + 1;
> -				while (j <=3D --la) {
> +				while (la && j <=3D --la) {
>  					if (sline[la].flag & mark) {
>  						contin =3D 1;
>  						break;
