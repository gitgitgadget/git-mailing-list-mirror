From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] get_sha1_oneline: allow to input commit_list
Date: Sun, 12 Dec 2010 16:29:06 -0800
Message-ID: <7vsjy27bxp.fsf@alter.siamese.dyndns.org>
References: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 01:30:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRwIf-0001Ro-Fe
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 01:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab0LMA3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 19:29:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab0LMA33 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 19:29:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE53932D4;
	Sun, 12 Dec 2010 19:29:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W9wHsEe+tK+P
	fhX996+9AvcEW+4=; b=WA+w3aMjClSn4ftgLLe+jJKYUg/K7JGWArygl2N+OODu
	pTkRuzSBgYwzkU9TjrLMh+rwZmEPQ1dqYM3CqMKn0APBThSxXVvScPNJ4uzPRArL
	D3DirZC9UxZb38IiVGGq+3dTbW1CGLs1A3Kh+OXnzwlLkw42PNGMOrdurmy9NrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rErhxf
	aJwnyXa/pEOh3lmY771YkYrP+jBN2WryWfwYJitJOVXUpKWKC4BPl2MqBM2io3ZW
	+UBn7iXPK8NCjk5teORNoq21td1lmJqFnRYa4Un9hIoCzpO//M8jjo4Cyn3FNnZr
	QNoLEaS6eCywIPQcHWMuydTOwt51pRJI0freQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E88532D2;
	Sun, 12 Dec 2010 19:29:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0540732D1; Sun, 12 Dec 2010
 19:29:33 -0500 (EST)
In-Reply-To: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Sun\, 12 Dec
 2010 17\:56\:58 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1521F46A-0650-11E0-B1FC-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163498>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  sha1_name.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 2c3a5fb..c298285 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -690,7 +690,9 @@ static int handle_one_ref(const char *path,
>  	return 0;
>  }
> =20
> -static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
> +static int get_sha1_oneline(const char *prefix,
> +			    unsigned char *sha1,
> +			    struct commit_list *original_list)
>  {
>  	struct commit_list *list =3D NULL, *backup =3D NULL, *l;
>  	int retval =3D -1;
> @@ -706,7 +708,12 @@ static int get_sha1_oneline(const char *prefix, =
unsigned char *sha1)
>  	if (regcomp(&regex, prefix, REG_EXTENDED))
>  		die("Invalid search pattern: %s", prefix);
> =20
> -	for_each_ref(handle_one_ref, &list);
> +	for (l =3D original_list; l; l =3D l->next) {
> +		commit_list_insert(l->item, &list);
> +		l->item->object.flags |=3D ONELINE_SEEN;
> +	}
> +	if (!list)
> +		for_each_ref(handle_one_ref, &list);

Two-and-half yucks.

 (1) "We work on the list you give us, if you give us one, but we work =
on
     a list we come up with outselves in a magic way otherwise" is an A=
PI
     designed with a bad taste.  Why not make the original caller run
     for-each-ref before calling this function?

 (2) Why do you have to copy the list, using commit-list-insert, here?

 (3) Even if the above extra copy turns out to be needed, do you need y=
et
     another copy in "backup"?

Instead of this patch, I would suggest to go this route:

 * Remove local varaible "list" and make it an input parameter.

 * Stop calling for-each-ref from this function.  Instead, have the
   current caller run for-each-ref to prepare list and feed it to you;

 * Stop marking commits with "ONELINE_SEEN" from handle-one-ref.  Inste=
ad,
   have the loop to copy list to backup do the marking.

That way, you make the purpose of the function much more clear.  It get=
s a
list of one or more commits that are in date-order, and finds the most
recent commit reachable from them that match the given string, using
ONELINE_SEEN bit as a scratchpad (shouldn't we be using TMP_MARK here, =
by
the way?).  The caller is responsible for giving you a sorted list, but
the caller shouldn't care about ONELINE_SEEN bit.
