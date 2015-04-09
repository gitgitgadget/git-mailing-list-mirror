From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix global bash variable leak on __gitcompappend
Date: Wed, 08 Apr 2015 20:56:28 -0700
Message-ID: <xmqqiod6ar9v.fsf@gitster.dls.corp.google.com>
References: <1428471958-12339-1-git-send-email-marcio3w@gmail.com>
	<1428471958-12339-2-git-send-email-marcio3w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: =?utf-8?Q?M=C3=A1rcio_Almada?= <marcio.web2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 05:56:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg3a0-0000ZF-7P
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 05:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbbDID4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2015 23:56:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753801AbbDID4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 23:56:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AF1848057;
	Wed,  8 Apr 2015 23:56:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Y2vwMfFhph2S
	G8XaLPmH1ExD7io=; b=RRbUz6yVxbzVHNpIo8d1sAvmK1RtpG2/9vRREAU635hI
	UUyOOuSdtujYa6kEl0Cbtjgf4jU3aDYv5LmJHntv1ZKMCTjqFBuslurL0c4iQvow
	kPy3iy5K5UzzEMK163uQIx3AhlJCBhZI4dkQ5cUYmHtLUkDRCfyxz06OyAk/0Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cRcukK
	I4os+nMVKQGknYotNC9H+GHSL5l1mZHXj1cEEc6YsOT8LmQxA73l0dXMGr9Gv8Es
	vIZ/7bAkjWd2gcSd/1Q/e/pWrVUd4GUkn4F+cD2nIzLXJQs7knbrCeE7mHJQWXUM
	r6+orPftbJTdNinSRvyA+hkuDSjkkpcBagCEY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73D5948056;
	Wed,  8 Apr 2015 23:56:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA33948055;
	Wed,  8 Apr 2015 23:56:29 -0400 (EDT)
In-Reply-To: <1428471958-12339-2-git-send-email-marcio3w@gmail.com>
 (=?utf-8?Q?=22M=C3=A1rcio?=
	Almada"'s message of "Wed, 8 Apr 2015 02:45:58 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6759E3E8-DE6C-11E4-81AD-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266983>

"M=C3=A1rcio Almada" <marcio.web2@gmail.com> writes:

> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nicely found and corrected.  Please sign-off your patch and Cc area
experts if you can find them (I'll do that this time for you).

Thanks.

>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 661a829..1620546 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -186,7 +186,7 @@ fi
> =20
>  __gitcompappend ()
>  {
> -	local i=3D${#COMPREPLY[@]}
> +	local x i=3D${#COMPREPLY[@]}
>  	for x in $1; do
>  		if [[ "$x" =3D=3D "$3"* ]]; then
>  			COMPREPLY[i++]=3D"$2$x$4"
