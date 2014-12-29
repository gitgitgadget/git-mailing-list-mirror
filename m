From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: release strbuf after use in check_refname_component()
Date: Mon, 29 Dec 2014 09:37:43 -0800
Message-ID: <xmqq387y1hnc.fsf@gitster.dls.corp.google.com>
References: <549A0665.6080207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 29 18:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5eGO-0008OV-7H
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 18:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbaL2Rhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2014 12:37:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaL2Rhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2014 12:37:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F9732804C;
	Mon, 29 Dec 2014 12:37:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XDy8uo65fZ6+
	GLIeYQE3fn8u6qM=; b=QreXer4w/QBiykDaG0EsQO/VZVxJB+JsS9Jj5nBLQF62
	8VvdxJ1kBAGJig04jdbYJsdSNQWoU8jNbliYYKwwJFdzASe7ULgrJIEBdDp6d08n
	adoRNxzqxRPSBKplGlwbX1UHA0TaUWPrwE/qZ3Z4g2352LAgtn4jH0909/FncLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AMZokX
	eShUxdjNl+wde/nSq4SOz2wjuBYUFt2PhD3ilsB2B3Q7PeTNgeuWYOC1zHec8enP
	CJb1Df/0CnMd43Cz5QKzShI6U0JuUQa4QIofeqnvsar5sKuCHLGVNrnd6c48R+RV
	5DvNFCtjlYe7PbjUejYPwYYoOtJe0VeUXqwE4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 466312804B;
	Mon, 29 Dec 2014 12:37:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFF2F2804A;
	Mon, 29 Dec 2014 12:37:44 -0500 (EST)
In-Reply-To: <549A0665.6080207@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Wed, 24
	Dec 2014 01:18:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 65B64ADE-8F81-11E4-9C21-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261866>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 5fcacc6..ed3b2cb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2334,7 +2334,7 @@ static struct ref_lock *lock_ref_sha1_basic(con=
st char *refname,
>  			struct strbuf err =3D STRBUF_INIT;
>  			unable_to_lock_message(ref_file, errno, &err);
>  			error("%s", err.buf);
> -			strbuf_reset(&err);
> +			strbuf_release(&err);
>  			goto error_return;
>  		}
>  	}

The subject does not seem to match what the patch is doing, but the
patch is obviously correct ;-)
