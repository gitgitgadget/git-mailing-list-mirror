From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum
 member
Date: Mon, 07 Nov 2011 13:18:58 -0800
Message-ID: <7vlirr1vi5.fsf@alter.siamese.dyndns.org>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com>
 <20111107194912.GA12469@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:19:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWbG-0002AU-0s
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab1KGVTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 16:19:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab1KGVTC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 16:19:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E55B65D19;
	Mon,  7 Nov 2011 16:19:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2dSRdQjgoTCR
	Fh27Up/nLO5slvU=; b=pzkyo+k5/ddpNNiYXY+IQrIovkg7T8ZJBy+WBqHSjoLm
	O4os4aI2tZocSz9b+6S0JvBECCCH3h/AUBU8PrkFSLcAqTqmY0xauMD8Pacpuc/5
	ObkbHCQ7A9eydDx1NPUNQ7BBAZmJB/nLW1apnHYf7pLh+dAXOL5wU6TEx6jc9SE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kqzibx
	k56ZrxWiIEf5aR9BoZgPt3EeBMgi3Aku6MCK6zUcMYapLJfGcMseOSI2oTaFgWw+
	LwJqP/s0vqmCi/5zBLNb6L3MR2ZEIrvmemcuj8uSqMGwcbrgxdJgFF3PHVo3tzX8
	blyZ8VP1Dgy6zOPweO55+JSxx4YaR1uwjlBJ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC50D5D18;
	Mon,  7 Nov 2011 16:19:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AFDB5D17; Mon,  7 Nov 2011
 16:19:00 -0500 (EST)
In-Reply-To: <20111107194912.GA12469@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Mon, 7 Nov 2011 13:49:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C688FA6-0986-11E1-BEA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185027>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [jn: drop the GREP_HEADER_FIELD_MAX <=3D p->field check, too,
>  for symmetry]

Umm, why is this removal of defensive programming practice an improveme=
nt?
This part is mostly my code and because I know what I wrote is almost
always perfect, so I do not think there is any real harm done, but stil=
l...

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  grep.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index b29d09c7..424c46cd 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -327,8 +327,6 @@ static struct grep_expr *prep_header_patterns(str=
uct grep_opt *opt)
>  	for (p =3D opt->header_list; p; p =3D p->next) {
>  		if (p->token !=3D GREP_PATTERN_HEAD)
>  			die("bug: a non-header pattern in grep header list.");
> -		if (p->field < 0 || GREP_HEADER_FIELD_MAX <=3D p->field)
> -			die("bug: unknown header field %d", p->field);
>  		compile_regexp(p, opt);
>  	}
