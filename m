From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 12:45:03 -0700
Message-ID: <7v61zml0ow.fsf@alter.siamese.dyndns.org>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBoZ-0006Hc-OR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935644Ab3DPTpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 15:45:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935589Ab3DPTpI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 15:45:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24944D8BC;
	Tue, 16 Apr 2013 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o2HGamIYRTue
	6mEUVUdJwWYlMFI=; b=UYkjqPQswoCWswTdaUmwR8nMW7TRAj5iMDjnbTYWctHK
	JumwYcGIgquA+ZyiOxb/QummkKLXBPL61zGxRr6pDpnWGXX4C1R+3RNS0kgS/MPm
	C0qCZYymBriH7J6yv1iyCyO3ds73LMhkT2bcwlm+MQo0iUG7vZ9NY/A4Kjjl2y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dkIxyo
	8IWURabUFBhTmXEI//+0OVm4DbHx45//622x6gBXX4f+xBsEWQFDbVBKGlK9e7Xi
	/jaLqqIx5+CFX1wmkCOrkZeBViVtGoTRmoEvdIrThEUdJEapk6+kGQwO1ag3Zbso
	4O1SYKeOwwiyXZ74mwsBNV+/j28RGWXBbFlMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C337D8BA;
	Tue, 16 Apr 2013 19:45:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E2C1D8B9; Tue, 16 Apr 2013
 19:45:05 +0000 (UTC)
In-Reply-To: <516D93C4.1000100@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 16 Apr 2013 20:09:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2300A8F8-A6CE-11E2-91C0-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221457>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Does this patch help?
>
>  pretty.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index d3a82d2..713eefc 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -405,8 +405,8 @@ void pp_user_info(const struct pretty_print_conte=
xt *pp,
>  	const char *mailbuf, *namebuf;
>  	size_t namelen, maillen;
>  	int max_length =3D 78; /* per rfc2822 */
> -	unsigned long time;
> -	int tz;
> +	unsigned long time =3D 0;
> +	int tz =3D 0;
> =20
>  	if (pp->fmt =3D=3D CMIT_FMT_ONELINE)
>  		return;
> @@ -438,8 +438,10 @@ void pp_user_info(const struct pretty_print_cont=
ext *pp,
>  	strbuf_add(&name, namebuf, namelen);
> =20
>  	namelen =3D name.len + mail.len + 3; /* ' ' + '<' + '>' */
> -	time =3D strtoul(ident.date_begin, &date, 10);
> -	tz =3D strtol(date, NULL, 10);
> +	if (ident.date_begin) {
> +		time =3D strtoul(ident.date_begin, &date, 10);
> +		tz =3D strtol(date, NULL, 10);
> +	}
> =20
>  	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
>  		strbuf_addstr(sb, "From: ");

Looks like a sensible change.  split_ident_line() decided that the
given input was mangled and decided there is no valid date (the
input had <> where the timestamp string was required), so the
updated code leaves the time/tz unspecified.

It still is curious how a malformed line was created in the first
place.  I wouldn't worry if a private tool used hash-object to
create such a commit, but if it is something that is commonly used
(e.g. "git commit"), others may suffer from the same and the tool
needs to be tightened a bit.
